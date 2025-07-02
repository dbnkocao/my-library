class BookPriceSearchJob < ApplicationJob
  queue_as :default
  attr_reader :book, :doc

  CARD_SELECTOR = '[data-testid=\"product-card\:\:card\"]'.freeze
  PRICE_SELECTOR = '[data-testid=\"product-card\:\:price\"]'.freeze
  PRODUCT_SELECTOR = '[data-testid=\"product-card\:\:name\"]'.freeze
  URL = "https://www.zoom.com.br".freeze

  def perform(book_id)
    @book = Book.find(book_id)

    search
    create_search_prices
  rescue OpenURI::HTTPError => e
    Rails.logger.error "Error accessing the URL: #{e.message}"
    Rails.logger.error "Please ensure the URL is correct and accessible."
  end

  private

  def search
    html_content = URI.open(full_url).read
    @doc = Nokogiri::HTML(html_content)
  end

  def search_prices_elements
    doc&.css(CARD_SELECTOR)
  end

  def search_prices
    @search_prices ||= search_prices_elements.map do |element|
      {
        book_id: book.id,
        price: element.at_css(PRICE_SELECTOR)&.text&.strip,
        product: element.at_css(PRODUCT_SELECTOR)&.text&.strip,
        link: element.attribute("href")&.value&.strip,
        image_link: element.at_css('img')&.attribute('src')&.value&.strip
      }
    end
  end

  def create_search_prices
    return unless search_prices.size >= 0

    book.search_prices.delete_all
    SearchPrice.insert_all(search_prices)
  end

  def full_url
    "#{URL}/search?#{query_string}"
  end

  def query_string
    URI.encode_www_form(
      {
        q: book.title,
        hitsPerPage: 24,
        page: 1,
        sortBy: 'price_asc',
        isDealsPage: false,
        enableRefinementsSuggestions: true
      }
    )
  end
end
