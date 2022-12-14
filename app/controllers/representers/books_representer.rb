class Representers::BooksRepresenter
  def initialize(books)
    @books = books
  end

  def as_json
    books.map do|book|
      {
        book_id: book.id,
        title: book.title,
        author_name: "#{book.author.first_name} #{book.author.last_name}",
        author_age: book.author.age
      }
    end
  end

  private
  attr_reader :books
end
