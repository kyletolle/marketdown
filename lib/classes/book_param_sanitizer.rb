class BookParamSanitizer
  def initialize(book_params)
    @book_params = book_params
  end

  def sanitize
    @book_params[:content] = CGI.escapeHTML(@book_params[:content])
    @book_params
  end
end

