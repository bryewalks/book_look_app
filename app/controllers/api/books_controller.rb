class Api::BooksController < ApplicationController
  def index
    @books = Book.all
    render 'index.json.jbuilder'
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      render 'show.json.jbuilder'
    else
      render json: {errors: @book.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def search
    #google api search goes here
  end

  def update
    @book = Book.find(params[:id])
    if @book.update!(book_params)
      render 'show.json.jbuilder'
    else
      render json: {errors: @book.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    render json: {message: "Successfully removed book."}
  end

  private

  def book_params
    params
      .require(:book)
      .permit(:author, :title, :publisher, :image_url)
  end
end
