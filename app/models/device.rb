class Device < ApplicationRecord
  has_many :review
  mount_uploader :image, ImageUploader
end