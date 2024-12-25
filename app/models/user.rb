class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # userは複数のゲームを投稿できる
  has_many :games

  # 作成者としてのグループとの関係を持ってきている、dependent: :nullifyで万が一userを削除した場合でもcreator_idをnullにするだけ
  has_many :created_groups, class_name: 'Group', foreign_key: :creator_id, dependent: :nullify

  # 参加者としてのグループとの関係
  has_many :group_memberships, dependent: :destroy
  has_many :join_groups, through: :group_memberships, source: :group
  
end
