module ThirdPartySearch
  class ZoomSearchService
    CARD_SELECTOR = '[data-testid="product-card::card"]'.freeze
    PRICE_SELECTOR = '[data-testid="product-card::price"]'.freeze
    PRODUCT_SELECTOR = '[data-testid="product-card::name"]'.freeze
    URL = "https://www.zoom.com.br".freeze

    attr_reader :book_title, :doc

    def initialize(book_title)
      @book_title = book_title
    end

    def self.call(book_title)
      new(book_title).call
    end

    def call
      search
      return search_prices
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
      search_prices_elements.map do |element|
        link = element.attribute("href")&.value&.strip
        link = [URL, link].join if link.present? && !link.start_with?('http')
        {
          price: element.at_css(PRICE_SELECTOR)&.text&.strip,
          product: element.at_css(PRODUCT_SELECTOR)&.text&.strip,
          link: link,
          image_link: element.at_css('img')&.attribute('src')&.value&.strip
        }
      end
    end

    def full_url
      "#{URL}/search?#{query_string}"
    end

    def query_string
      URI.encode_www_form(
        {
          q: book_title,
          hitsPerPage: 24,
          page: 1,
          sortBy: 'price_asc',
          isDealsPage: false,
          enableRefinementsSuggestions: true
        }
      )
    end
  end
end
