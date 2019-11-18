require 'rails_helper'

RSpec.describe Api::ItemsController, type: :controller do
    render_views
    let(:json) { JSON.parse(response.body) }

    describe 'GET #index' do
        before do
            a = Item.create(code: "A", description: "Apple", unit_price: 2.0, volume_discount_number: 4, volume_discount_price: 7.0)
            b = Item.create(code: "B", description: "Banana", unit_price: 12.0)
            c = Item.create(code: "C", description: "Cranberry", unit_price: 1.25, volume_discount_number: 6, volume_discount_price: 6.0)
            d = Item.create(code: "D", description: "Durian", unit_price: 0.15)
            get :index, format: :json
        end

        it "has a 200 status code" do
            expect(response.status).to eq(200)
        end

        it "outputs a JSON with 4 key-value pairs with key being item's code and value being item itself" do
            expect(json["items"]["A"]["code"]).to eq("A")
            expect(json["items"]["B"]["code"]).to eq("B")
            expect(json["items"]["C"]["code"]).to eq("C")
            expect(json["items"]["D"]["code"]).to eq("D")
        end
    end
end