class Micropost < ApplicationRecord
  belongs_to :user
  
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites, source: :user
  
  validates :content, presence: true, length: { maximum: 140 }
  
  def feed_microposts
    Micropost.where(user_id: self.following_ids + [self.id])
  end
end
