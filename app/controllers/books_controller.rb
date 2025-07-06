class BooksController < ApplicationController
  include Authentication

  def index; end

  def create
    result = ::CreateBookByIsbnService.call(isbn: params[:isbn])

    if result.success?
      book = result.value[:book] if result.success?
      library_books << book if book.persisted? && !library_books.include?(book)
      flash[:notice] = "Book '#{book.title}' added successfully."
    else
      flash[:notice] = result.value[:errors]
    end

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
