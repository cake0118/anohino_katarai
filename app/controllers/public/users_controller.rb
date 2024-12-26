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
    if @user.update(user_params)
      redirect_to user_path(@user), notice: '更新しました'
    else
      @user = current_user
      redirect_to edit_user_path(@user), alert: '更新に失敗しました'
    end
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
