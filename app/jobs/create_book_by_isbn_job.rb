class CreateBookByIsbnJob < ApplicationJob
  queue_as :default
  attr_reader :book, :result

  def perform(isbn)
    @result = Brasilapi::IsbnService.call(param: isbn)

    return unless result.success

    create_book
    add_authors
    add_subjects
  end

  private

  def create_book
    book_params = result.data.except("authors", "subjects","dimensions")
    book_params.merge!(result.data["dimensions"])
    @book = Book.create!(book_params)
  end

  def add_authors
    result.data["authors"]&.each do |author_name|
      book.authors << Author.find_or_create_by(name: author_name)
    end
  end

  def add_subjects
    result.data["subjects"]&.each do |description|
      book.subjects << Subject.find_or_create_by(description: description)
    end
  end
end
