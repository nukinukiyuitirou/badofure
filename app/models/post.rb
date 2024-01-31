class Post < ApplicationRecord
  scope :active_posts, -> { includes(:user).where( 'users.is_active': true ) }
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :region

  validates :text, presence: true

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
