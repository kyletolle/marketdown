class NewBook
  def initialize(book_params)
    @book_params = BookParamSanitizer.new(book_params).sanitize
  end

  def new
    Book.new(@book_params)
  end
end

