class UsersController < ApplicationController

  def show
    @book=Book.new
    @user = User.find(params[:id])
    @books = @user.books #@userのbooksをすべて保存する
  end
  def edit
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
      redirect_to user_path(@user.id)
    else
      render :edit
    end

  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end


  def is_matching_login_user
    userno = User.find(params[:id])
    unless userno.id == current_user.id
      redirect_to user_path(current_user)
    end
  end

end
