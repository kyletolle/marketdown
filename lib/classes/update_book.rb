class UpdateBook
  attr_reader :book

  def initialize(current_user, book_id, book_params)
    @current_user = current_user
    @id           = book_id

    @book_params = BookParamSanitizer.new(book_params).sanitize
  end

  def update
    begin
      @book = Book.where(author: @current_user).find(@id)

      @book.update(@book_params)
    rescue ActiveRecord::RecordNotFound
      false
    end
  end
end
