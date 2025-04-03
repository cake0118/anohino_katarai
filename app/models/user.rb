class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # userは複数のゲームを投稿できる
  has_many :games

  # 氏名のバリデーション
  validates :name, presence: true, length: { maximum: 50 }

  # フリガナのバリデーション（カタカナのみ許可）
  validates :name_kana, presence: true, format: { with: /\A[\p{katakana}ー]+\z/, message: "はカタカナで入力してください" }

  # ハンドルネームのバリデーション
  validates :handle_name, presence: true, length: { maximum: 30 }

  # 作成者としてのグループとの関係を持ってきている、dependent: :nullifyで万が一userを削除した場合でもcreator_idをnullにするだけ
  has_many :created_groups, class_name: 'Group', foreign_key: :creator_id, dependent: :nullify

  # 参加者としてのグループとの関係
  has_many :group_memberships, dependent: :destroy
  has_many :join_groups, through: :group_memberships, source: :group
  

  def guest?
    email == 'guest@example.com'
  end
  
end
