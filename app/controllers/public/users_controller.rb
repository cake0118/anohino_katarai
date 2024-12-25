class Public::UsersController < ApplicationController

  before_action :restrict_guest_user, only: [:withdraw, :update]

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
    @user = User.find(params[:id])
  end

  def withdraw
    @user = current_user
    @user.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  private

  def restrict_guest_user
    if current_user.guest?
      redirect_to root_path, alert: 'ゲストユーザーはこの操作を行えません。'
    end
  end

  def user_params
    params.require(:user).permit(:name, :name_kana, :handle_name)
  end

end
