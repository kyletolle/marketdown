class NewBook
  def initialize(book_params)
    @book_params = book_params
  end

  def new
    Book.new(@book_params)
  end
end

