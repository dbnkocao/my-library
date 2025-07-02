class BooksController < ApplicationController
  def index; end

  def create
    book = Book.find_by(isbn: params[:isbn]) || ::CreateBookByIsbnService.call(params[:isbn])

    library_books << book if book && !library_books.include?(book)

    redirect_to root_path
  end

  private

  def library_books
    @library_books ||= current_user.library.books
  end
end
