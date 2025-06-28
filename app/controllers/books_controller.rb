class BooksController < ApplicationController
  def index; end

  def create
    book = Book.find_by(isbn: params[:isbn]) || ::CreateBookByIsbnService.call(params[:isbn])

    current_user.library.books << book if book

    redirect_to root_path
  end
end
