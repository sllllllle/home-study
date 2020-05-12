class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
                    
  # enum gender: { "man": 1, "woman": 2, "other": 3}
  
  has_secure_password
  # プロフィール画像
  has_one_attached :profile_image
  
  has_many :microposts
  has_many :records
  
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  has_many :favorites
  has_many :favorite_post, through: :favorites, source: :micropost
  
  has_many :supports
  has_many :support_record, through: :supports, source: :record
  
  # ----------Start of relationships----------
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
  # ----------End of relationships----------
  
  # ----------Start of favorites----------
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
  # ----------End of favorites----------
  
  
  # ----------Start of supports----------
  def support(record)
    self.supports.find_or_create_by(record_id: record.id)
  end
  
  def unsupport(record)
    support = self.supports.find_by(record_id: record.id)
    support.destroy if support
  end
  
  def support?(record)
    self.support_record.include?(record)
  end
  # ----------End of Supports----------
  
end
