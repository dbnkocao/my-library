class CreateBookByIsbnService < Solid::Process
  input do
    attribute :isbn, :string
  end

  def call(attributes)
    rollback_on_failure {
      Given(attributes)
        .and_then(:search_existing_book)
        .and_then(:search_book_by_isbn)
        .and_then(:create_book)
        .and_then(:add_authors)
        .and_then(:add_subjects)
    }.and_expose(:book_created, [:book])
  end

  private

  def search_existing_book(isbn:, **)
    book = Book.find_by(isbn:)

    Continue(isbn:, book:)
  end

  def search_book_by_isbn(isbn:, book:, **)
    return Success(:book_created, book:) if book

    result = ThirdPartySearch::Brasilapi::IsbnService.call(param: isbn)

    return Continue(data: result.data) if result.success

    Failure(:book_not_found, errors: result.error)
  end

  def create_book(data:, **)
    book_params = data.except("authors", "subjects","dimensions")
    book_params.merge!(data["dimensions"]) if data["dimensions"]
    book = Book.new(book_params)

    return Continue(data:, book:) if book.save

    Failure(:invalid_input, errors: book.errors.full_messages)
  end

  def add_authors(data:, book:, **)
    book.authors << data["authors"]&.map { Author.find_or_create_by(name: it) }
    Continue(data:, book:)
  end

  def add_subjects(data:, book:, **)
    book.subjects << data["subjects"]&.map { Subject.find_or_create_by(description: it) }
    Continue(book:)
  end
end
