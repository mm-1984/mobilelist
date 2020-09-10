class Device < ApplicationRecord
  has_many :reviews
  has_many :favorites, dependent: :destroy
  has_many :liked, through: :favorites, source: :user
  
  mount_uploader :image, ImageUploader
  
end