class Micropost < ApplicationRecord
  validates :content, presence: true, length: { maximum: 140 }
  belongs_to :user
  
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites, source: :user
  
  
end
