class Api::V1::BooksController < ApplicationController
  before_action :set_book, only: [ :show, :update, :destroy ]

  # GET /books
  def index
    @books = Book.all

    render json:{
      message: "Rendered all the books",
      books: Representers::BooksRepresenter.new(@books).as_json
    }, status: :ok
  end

  # GET /books/1
  def show
    render json:{
      message: "Rendered the book with the id #{params[:id]}",
      book: @book
    }, status: :ok
  end

  # POST /books
  def create
    @book = Book.new(book_params)

    if @book.save
      render json:{
        message: "Created a new book successfully.",
        book: @book
      }, status: :created
    else
      render json:{
        message: "Error while creating a book.",
        error: @book.errors
      }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /books/1
  def update
    if @book.update(book_params)
      render json: {
        message: "Successfully updated the book with the id #{params[:id]}",
        book: @book
      }, status: :ok
    else
      render json:{
        message: "Error while updating the book.",
        error: @book.errors
      },status: :unprocessable_entity
    end
  end

  # DELETE /books/1
  def destroy
    if @book.destroy
      render json:{
        message: "Successfully deleted the book"
      }, status: :ok
    else
      render json:{
        message: "Unable to delete the book, try again later",
        error: @book.errors
      }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :author)
    end
end
