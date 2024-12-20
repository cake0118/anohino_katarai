class Public::GamesController < ApplicationController

  def new
    @game = Game.new
  end

  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
  end

  def create
    @game = current_user.games.new(game_params)
    @game.save
    redirect_to user_path(current_user)
  end

  private

  def game_params
    params.require(:game).permit(:title, :title_kana, :body, :user_id, :headware_id)
  end
end
