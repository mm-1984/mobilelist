class User < ApplicationRecord
    before_save { self.email.downcase! }
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    has_secure_password
    
    mount_uploader :image, ImageUploader
    
    has_many :reviews, dependent: :destroy
    
    has_many :favorites, dependent: :destroy
    has_many :likes, through: :favorites, source: :device
    
    def favorite(one_device)
         self.favorites.find_or_create_by(device_id: one_device.id)
    end
    
    def unfavorite(one_device)
        favorite = self.favorites.find_by(device_id: one_device.id)
        favorite.destroy if favorite
    end
    
    def favorite?(one_device)
        self.likes.include?(one_device)
    end
end
