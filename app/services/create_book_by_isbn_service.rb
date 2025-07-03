class CreateBookByIsbnService < ApplicationJob
  attr_reader :isbn, :book, :result

  def self.call(isbn)
    new(isbn).call
  end

  def initialize(isbn)
    @isbn = isbn
  end

  def call
    @result = Brasilapi::IsbnService.call(param: isbn)

    return book unless success_result?
    create_book
    add_authors
    add_subjects
    book
  end

  private

  def success_result?
    return true if result.success

    @book = Book.new
    book.errors.add(:isbn, result.error)
    return false
  end

  def create_book
    book_params = result.data.except("authors", "subjects","dimensions")
    book_params.merge!(result&.data["dimensions"]) if result&.data["dimensions"]
    @book = Book.create!(book_params)
  end

  def add_authors
    book.authors << result&.data["authors"]&.map { Author.find_or_create_by(name: it) }
  end

  def add_subjects
    book.subjects << result.data["subjects"]&.map { Subject.find_or_create_by(description: it) }
  end
end
