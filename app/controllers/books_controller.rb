class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :purchase]
  before_action :validate_logged_in, only: [:new, :create, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @books = Book.all
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = NewBook.new(book_params).new
    book_published =
      Authoring.new(current_user, @book)
        .publish_book

    respond_to do |format|
      if book_published
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }

      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }

      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def purchase
    purchase_completed = Purchasing.new(current_user, @book)
      .complete_purchase

    respond_to do |format|
      if purchase_completed
        format.html { redirect_to @book, notice: 'You now own this book!' }
        format.json { render :show, status: :ok, location: @book }

      else
        format.html { redirect_to @book, alert: "Book couldn't be purchased." }
        format.json { render json: {errors: {book: "couldn't be purchased."}}, status: :forbidden }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :content, :user_id)
    end

    def validate_logged_in
      unless current_user
        flash[:notice] = "You must log in first."
        redirect_to :root
      end
    end
end
