class Public::GamesController < ApplicationController

  before_action :restrict_guest_user, only: [:new, :create]

  def new
    @game = Game.new
  end

  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    @groups = @game.groups
  end

  def create
    @game = current_user.games.new(game_params)
    @game.save
    redirect_to user_path(current_user)
  end

  private

  def restrict_guest_user
    if current_user.guest?
      redirect_to root_path, alert: 'ゲストユーザーはこの操作を行えません。'
    end
  end

  def game_params
    params.require(:game).permit(:title, :title_kana, :body, :user_id, :headware_id)
  end
end
