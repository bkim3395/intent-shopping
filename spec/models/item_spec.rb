require 'rails_helper'

RSpec.describe Item, type: :model do
    it { should have_many(:cart_items) }
    it { should have_many(:carts) }
    it { should validate_presence_of(:code) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_uniqueness_of(:code) }
end