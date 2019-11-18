class Item < ApplicationRecord
    validates :code, presence: true, uniqueness: true
    validates :description, :unit_price, presence: true

    has_many :cart_items,
    foreign_key: :item_id,
    class_name: :CartItem

    has_many :carts,
    through: :cart_items,
    source: :cart
end