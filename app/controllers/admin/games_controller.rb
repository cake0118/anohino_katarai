class Admin::GamesController < ApplicationController
  def index
    @game = Game.find(params[:id])
  end

  def show
    @games = Game.all
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    @game.update
    redirect_to admin_game_path(@game)
  end

  private

  def game_params
    params.require(:game).permit(:title, :body)
  end

end
