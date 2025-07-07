class BookPriceSearchJob < ApplicationJob
  queue_as :default

  def perform(book_id, user_id)
    book = Book.find(book_id)
    search_prices = ThirdPartySearch::ZoomSearchService.call(book.title)
    return if search_prices.blank?

    book.search_prices.destroy_all
    SearchPrice.insert_all(search_prices.map { it.merge(book_id: book.id) })
    SearchPricesMailer.list_prices(user_id, book_id).deliver_later
  end
end
