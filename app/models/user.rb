class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  enum gender: { man: 1, woman: 2, other: 3}
  has_secure_password
  
  has_many :microposts
  
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  has_many :favorites
  has_many :favorite_post, through: :favorites, source: :micropost
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  def unfollow(other_user)
    relationships = self.relationships.find_by(follow_id: other_user.id)
    relationships.destroy if relationships
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def feed_microposts
    Micropost.where(user_id: self.following_ids + [self.id])
  end
  
  def favorite(micropost)
    self.favorites.find_or_create_by(micropost_id: micropost.id)
  end
  
  def unfavorite(micropost)
    favorite = self.favorites.find_by(micropost_id: micropost.id)
    favorite.destroy if favorite
  end
  
  def favorite?(micropost)
    self.favorite_post.include?(micropost)
  end
  
  def favorite_microposts
    Micropost.where(id: self.favorite_post_ids)
  end
  
end
