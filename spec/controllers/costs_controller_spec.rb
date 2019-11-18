require 'rails_helper'

RSpec.describe Api::CostsController, type: :controller do
    render_views
    let(:json) { JSON.parse(response.body) }

    describe 'GET #show' do
        let!(:a) {Item.create(code: "A", description: "Apple", unit_price: 2.0, volume_discount_number: 4, volume_discount_price: 7.0)}        
        let!(:b) {Item.create(code: "B", description: "Banana", unit_price: 12.0)}
        let!(:c) {Item.create(code: "C", description: "Cranberry", unit_price: 1.25, volume_discount_number: 6, volume_discount_price: 6.0)}
        let!(:d) {Item.create(code: "D", description: "Durian", unit_price: 0.15)}
    
        context "If the cart doesn't exist" do
            before do
                get :show, format: :json
            end

            it "has a 400 status code" do
                expect(response.status).to eq(400)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Cart does not exist so total cost can't be calculated./)
            end        
        end

        context "If the Cart holds ABCDABAA items" do
            before do
                cart = Cart.create
                session[:session_token] = cart.session_token
                CartItem.create(cart_id: cart.id, item_id: a.id)
                CartItem.create(cart_id: cart.id, item_id: b.id)
                CartItem.create(cart_id: cart.id, item_id: c.id)
                CartItem.create(cart_id: cart.id, item_id: d.id)
                CartItem.create(cart_id: cart.id, item_id: a.id)
                CartItem.create(cart_id: cart.id, item_id: b.id)
                CartItem.create(cart_id: cart.id, item_id: a.id)
                CartItem.create(cart_id: cart.id, item_id: a.id)
                get :show, format: :json           
            end

            it "should return '32.40'" do
                expect(json["cost"]).to eq(32.40)
            end
        end

        context "If the Cart holds CCCCCCC items" do
            before do
                cart = Cart.create
                session[:session_token] = cart.session_token
                CartItem.create(cart_id: cart.id, item_id: c.id)
                CartItem.create(cart_id: cart.id, item_id: c.id)
                CartItem.create(cart_id: cart.id, item_id: c.id)
                CartItem.create(cart_id: cart.id, item_id: c.id)
                CartItem.create(cart_id: cart.id, item_id: c.id)
                CartItem.create(cart_id: cart.id, item_id: c.id)
                CartItem.create(cart_id: cart.id, item_id: c.id)
                get :show, format: :json           
            end

            it "should return '7.25'" do
                expect(json["cost"]).to eq(7.25)
            end
        end

        context "If the Cart holds ABCD items" do
            before do
                cart = Cart.create
                session[:session_token] = cart.session_token
                CartItem.create(cart_id: cart.id, item_id: a.id)
                CartItem.create(cart_id: cart.id, item_id: b.id)
                CartItem.create(cart_id: cart.id, item_id: c.id)
                CartItem.create(cart_id: cart.id, item_id: d.id)
                get :show, format: :json           
            end

            it "should return '15.40'" do
                expect(json["cost"]).to eq(15.40)
            end
        end
    end
end