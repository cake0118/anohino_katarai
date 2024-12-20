class Public::SearchesController < ApplicationController

  def index
    if params[:first_character]
      @games = search_by_katakana(params[:first_character])
    else
      @games = Game.all
    end
  end

end
