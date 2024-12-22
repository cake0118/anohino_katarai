class Public::SearchesController < ApplicationController

  def index
    @kana = params[:kana]
    @query = params[:query]
    
    if @query.present?
      @games = Game.where("title LIKE ? OR title_kana LIKE ?", "%#{@query}%", "%#{@query}%" ).order(:title_kana)
    elsif @kana.present?
      range = case @kana
              when 'ア' then ['ア', 'オ']
              when 'カ' then ['カ', 'コ']
              when 'ガ' then ['ガ', 'ゴ']
              when 'サ' then ['サ', 'ソ']
              when 'ザ' then ['ザ', 'ゾ']
              when 'タ' then ['タ', 'ト']
              when 'ダ' then ['ダ', 'ド']
              when 'ナ' then ['ナ', 'ノ']
              when 'ハ' then ['ハ', 'ホ']
              when 'バ' then ['バ', 'ボ']
              when 'パ' then ['パ', 'ポ']
              when 'マ' then ['マ', 'モ']
              when 'ヤ' then ['ヤ', 'ヨ']
              when 'ラ' then ['ラ', 'ロ']
              when 'ワ' then ['ワ', 'ン']
              else [@kana, @kana] # 想定外の入力があった場合、該当なし
              end

      @games = Game.where(title_kana: range[0]..range[1]).order(:title_kana)
    else
      @games = Game.none # 空の結果
    end
  end

end
