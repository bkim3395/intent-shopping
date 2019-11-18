class Cart < ApplicationRecord
    validates :session_token, presence: true, uniqueness: true

    has_many :cart_items,
    foreign_key: :cart_id,
    class_name: :CartItem,
    dependent: :destroy
    
    has_many :items,
    through: :cart_items,
    source: :item

    after_initialize :ensure_session_token

    def self.generate_session_token
        SecureRandom.urlsafe_base64
    end

    def ensure_session_token
        self.session_token ||= Cart.generate_session_token
    end

    def reset_session_token!
        self.session_token = Cart.generate_session_token
        self.save!
        self.session_token
    end
end