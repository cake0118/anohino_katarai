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
    @game = Game.new(game_params)
    @game.save
    redirect_to user_path(current_user)
  end

  private

  def game_params
    params.require(:game).permit.(:tatle, :body, :user_id, :headware_id)
  end
end
