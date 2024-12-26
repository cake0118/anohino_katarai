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
    if @game.save
       redirect_to user_path(current_user),notice: '投稿しました'
    else
      redirect_to new_game_path, alert: '投稿に失敗しました'
    end
  end

  private

  def restrict_guest_user
    if current_user.guest?
      redirect_to root_path, alert: 'ゲストユーザーはこの操作を行えません。'
    end
  end

  def game_params
    params.require(:game).permit(:title, :title_kana, :body, :headware_id)
  end
end
