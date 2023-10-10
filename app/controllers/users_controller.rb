class UsersController < ApplicationController
  def show
    @book=Book.new
    @user = User.find(params[:id])
    @books = @user.books #@userのbooksをすべて保存する
  end

  def edit
    user=User.find(params[:id])
    unless user.id==current_user.id
      redirect_to user_path(current_user.id)
    end
    @user=User.find(params[:id])
  end

  def index
    @user=current_user
    @users=User.all
    @book=Book.new
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]="You have updated user successfully."
      redirect_to user_path(@user)
    else
      render :edit
    end
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
      render :index
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end


end
