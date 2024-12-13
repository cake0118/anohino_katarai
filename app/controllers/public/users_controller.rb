class Public::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @games = @user.games
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def unsubscribe
  end

  def withdraw
  end

  private

  def user_params
    params.require(:user).permit(:name, :name_kana, :handle_name)
  end

end
