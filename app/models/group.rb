class Group < ApplicationRecord

  belongs_to :game
  has_many :comments, dependent: :destroy

  # creator_idを外部キーとして作成時に登録したuserを参照する
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id

  # グループとして参加者との関係を中間テーブルを使って表している
  has_many :group_memberships, dependent: :destroy
  has_many :users, through: :group_memberships

  # 同ゲーム内で同じタイトルを許容しない為
  validates :title, presence: true, uniqueness: { scope: :game_id }

  # グループ作成者かの確認
  def created_by?(user)
    creator_id == user.id
  end
end
