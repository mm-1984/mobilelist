class Device < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :liked, through: :favorites, source: :user
  
  mount_uploader :image, ImageUploader
  
end