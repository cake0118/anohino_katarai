class Game < ApplicationRecord

  belongs_to :user
  belongs_to :headware

  has_many :groups, dependent: :destroy

  # タイトルを必須にするかつ重複を防ぐ
  validates :title, presence: true, uniqueness: true, uniqueness: { message: "は既に存在します。" }

  def self.search_by_katakana(first_character)
    # 五十音順の最初の文字を取得して検索
    first_character = first_character.upcase
  
    if first_character.match?(/\A[ア-ン]\z/) # カタカナかどうか確認
      # カタカナでフィルタリング
      games = Game.where("title_kana LIKE ?", "#{first_character}%")
    else
      # 無効なカタカナ文字が入力された場合の処理
      ganmes = Game.none
    end
    games
  end
  
end
