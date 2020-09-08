class Review < ApplicationRecord
  belongs_to :user
  # belongs_to :device
  validates :content, presence: true, length: { maximum: 255 }
end
