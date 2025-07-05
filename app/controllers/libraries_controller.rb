class LibrariesController < ApplicationController
  include Authentication

  before_action :set_library

  def index
    @books = Rails.cache.fetch("#{@library.id}/search_prices", expires_in: 1.hour) do
      @library.books.includes(:authors, :subjects, :search_prices)
    end
  end

  def delete_book
    book = Book.find_by(id: params[:book_id])

    @library.books.delete(book)

    redirect_to root_path, notice: "Book '#{book.title}'deleted with success."
  end

  private

  def set_library
    @library = current_user.library
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Library not found."
  end
end
