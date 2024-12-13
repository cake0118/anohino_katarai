class Public::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @games = @user.games
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  end

  def unsubscribe
  end

  def withdraw
  end

end
