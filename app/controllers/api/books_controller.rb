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
    render 'show.json.jbuilder'
  end

  def search
    title = params[:search_term].gsub(/ +/, '_')
    response = HTTP.get("https://www.googleapis.com/books/v1/volumes?q=#{title}&maxResults=25")
    searched_books = JSON.parse(response.body, object_class: OpenStruct)["items"]
    @books = []
    searched_books.each do |book|
      @books << Book.new(
                          title: book.volumeInfo.title || "NA",
                          author: book.volumeInfo.authors && book.volumeInfo.authors.first|| "NA",
                          publisher: book.volumeInfo.publisher || "NA",
                          image_url: book.volumeInfo.imageLinks && book.volumeInfo.imageLinks.thumbnail
                        )
    end
    render 'index.json.jbuilder'
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
    #TODO change user_id to current_user.id when login form setup
    params
      .require(:book)
      .permit(:title, :publisher, :image_url, :read, :author)
      .merge(user_id: "1")
  end
end
