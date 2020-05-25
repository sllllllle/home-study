class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }

  attr_accessor :current_password
  validates :new_password, presence: { if: :current_password }

  has_secure_password
  has_one_attached :profile_image

  mount_uploader :img, ImgUploader

  has_many :microposts, dependent: :destroy
  has_many :records, dependent: :destroy

  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverses_of_relationship, source: :user

  has_many :favorites, dependent: :destroy
  has_many :favorite_post, through: :favorites, source: :micropost

  has_many :supports, dependent: :destroy
  has_many :support_record, through: :supports, source: :record

  # ----------Start of relationships----------
  def follow(other_user)
    unless self == other_user
      relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationships = self.relationships.find_by(follow_id: other_user.id)
    relationships&.destroy
  end

  def following?(other_user)
    followings.include?(other_user)
  end

  def feed_microposts
    Micropost.where(user_id: following_ids)
  end
  # ----------End of relationships----------

  # ----------Start of favorites----------
  def favorite(micropost)
    favorites.find_or_create_by(micropost_id: micropost.id)
  end

  def unfavorite(micropost)
    favorite = favorites.find_by(micropost_id: micropost.id)
    favorite&.destroy
  end

  def favorite?(micropost)
    favorite_post.include?(micropost)
  end

  def favorite_microposts
    Micropost.where(id: favorite_post_ids)
  end
  # ----------End of favorites----------

  # ----------Start of supports----------
  def support(record)
    supports.find_or_create_by(record_id: record.id)
  end

  def unsupport(record)
    support = supports.find_by(record_id: record.id)
    support&.destroy
  end

  def support?(record)
    support_record.include?(record)
  end
  # ----------End of Supports----------
end
