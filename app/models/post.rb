class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :region
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
