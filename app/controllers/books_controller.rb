class BooksController < ApplicationController
  before_action :is_matching_login_user,only:[:edit,:update]
  before_action :authenticate_user
  def new
    @book=Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books=Book.all
      @user=current_user
      flash[:notice] = "error"
      render :index
    end
  end

  def index
    @book=Book.new
    @books=Book.all
    @user=current_user
  end

  def show
    @book=Book.new
    @books = Book.find(params[:id])
    @user=@books.user
  end

  def update
    book = Book.find(params[:id])
    book.update(book_params)
    flash[:notice]="You have updated book successfully."
    redirect_to book_path(book.id)
  end

  def edit
    @book=Book.find(params[:id])
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    book = Book.find(params[:id])
    user = book.user
    unless user.id == current_user.id
      redirect_to books_path
    end
  end


end
