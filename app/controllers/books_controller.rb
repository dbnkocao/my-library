class BooksController < ApplicationController
  include Authentication

  def index; end

  def create
    book = Book.find_by(isbn: params[:isbn]) || ::CreateBookByIsbnService.call(params[:isbn])

    flash[:notice] = book.errors.full_messages.to_sentence if book.errors.any?
    library_books << book if book.persisted? && !library_books.include?(book)

    redirect_to root_path
  end

  def search_prices
    book = Book.find(params[:book_id])
    BookPriceSearchJob.perform_later(book.id, current_user.id)
    flash[:notice] = "Searching for prices, you will receive an email with the results."
    redirect_to root_path
  end


  private

  def library_books
    @library_books ||= current_user.library.books
  end
end
