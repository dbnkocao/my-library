class SearchPricesMailer < ApplicationMailer
  def list_prices(user_id, book_id)
    @user = User.find(user_id)
    @book = Book.includes(:search_prices).find(book_id)

    mail(to: @user.email_address, subject: "Prices for #{@book.title}")
  end
end
