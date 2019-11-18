require 'rails_helper'

RSpec.describe Cart, type: :model do
    it { should have_many(:items)}
    it { should have_many(:cart_items).dependent(:destroy)}
    it { should validate_presence_of(:session_token)}
    it { should validate_uniqueness_of(:session_token)}
end