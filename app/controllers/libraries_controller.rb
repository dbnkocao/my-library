class LibrariesController < ApplicationController
  include Authentication

  before_action :set_library

  def index
    @books = @library.books.includes(:subjects, :authors, :search_prices)
  end

  def delete_book
    book = Book.find_by(id: params[:book_id])

    @library.books.delete(book)

    redirect_to root_path, notice: "Book '#{book.title}' deleted with success."
  end

  private

  def set_library
    @library = current_user.library
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, error: "Library not found."
  end
end
