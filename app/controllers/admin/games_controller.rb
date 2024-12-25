class Admin::GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    @groups = @game.groups
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    @game.update(game_params)
    redirect_to admin_game_path(@game)
  end

  private

  def game_params
    params.require(:game).permit(:title, :title_kana, :body, :user_id, :headware_id)
  end

end
