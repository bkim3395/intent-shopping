require 'rails_helper'
require './spec/support/helpers'


RSpec.configure do |c|
    c.include Helpers
end

RSpec.describe Api::CartsController, type: :controller do
    render_views
    let(:json) { JSON.parse(response.body) }

    describe 'POST #create' do
        before do
            post :create, format: :json
        end

        it "has a 200 status code" do
            expect(response.status).to eq(200)
        end

        it 'creates a new cart with a session token' do
            cart = Cart.find_by(session_token: session[:session_token])
            expect(session[:session_token]).to eq(cart.session_token)
        end

        it 'outputs a JSON with a session token and an empty Items array' do
            expect(json["cart"]["session_token"]).to eq(session[:session_token])
            expect(json["cart"]["items"]).to be_empty
        end
    end

    describe 'GET #show' do

        context "If the browser has a session_token in session cookie" do
            before do
                cart = Cart.create
                session[:session_token] = cart.session_token
                get :show, format: :json
            end

            it "has a 200 status code" do
                expect(response.status).to eq(200)
            end

            it 'outputs a JSON with a session token and an item' do
                expect(json["cart"]["session_token"]).to eq(session[:session_token])
                expect(json["cart"]).to have_key("items")
            end
        end

        context "If the browser doesn't have a session_token in session cookie" do
            before do
                get :show, format: :json
            end

            it "has a 400 status code" do
                expect(response.status).to eq(400)
            end


            it 'returns a not found message' do
                expect(response.body).to match(/Cart does not exist./)
            end
        end
    end

    describe "PUT #update" do

        context "If the cart doesn't exist" do
            before do
                session[:session_token] = nil
                put :update, params: {
                    items: []
                }
            end

            it "has a 400 status code" do
                expect(response.status).to eq(400)
            end


            it 'returns a not found message' do
                expect(response.body).to match(/Cart does not exist./)
            end
        end

        context "If the cart exists" do
            before do
                cart = Cart.create
                session[:session_token] = cart.session_token
                a = Item.create(code: "A", description: "Apple", unit_price: 2.0, volume_discount_number: 4, volume_discount_price: 7.0)
                b = Item.create(code: "B", description: "Banana", unit_price: 12.0)
                c = Item.create(code: "C", description: "Cranberry", unit_price: 1.25, volume_discount_number: 6, volume_discount_price: 6.0)
                d = Item.create(code: "D", description: "Durian", unit_price: 0.15)
            end

            context "If the request enters a code of an item that doesn't exist" do
                before do
                    put :update, params: {
                        items: ["E"]
                    }
                end

                it "has a 422 status code" do
                    expect(response.status).to eq(422)
                end

                it 'returns a not found message' do
                    expect(response.body).to match(/The item of corresponding code/)
                end
            end

            context "If the request only contains code of existing items" do
                context "and the items requested were ['A', 'B', 'C']" do
                    before do
                        put :update, params: {
                            items: ["A", "B", "C"]
                        }
                    end

                    it "has a 200 status code" do
                        expect(response.status).to eq(200)
                    end

                    it "returns a cart with 3 items ('A', 'B', 'C')" do
                        expect(includesKey?(json["cart"]["items"], "A")).to be_truthy
                        expect(includesKey?(json["cart"]["items"], "B")).to be_truthy
                        expect(includesKey?(json["cart"]["items"], "C")).to be_truthy
                    end
                end

                context "and, then, the items requested were ['C'] to the existing cart with 3 items ('A', 'B', 'C')" do
                    before do
                        put :update, params: {
                            items: ["C"]
                        }
                    end

                    it "has a 200 status code" do
                        expect(response.status).to eq(200)
                    end

                    it "returns a cart with an item with code 'C'" do
                        expect(includesKey?(json["cart"]["items"], "C")).to be_truthy
                        expect(includesKey?(json["cart"]["items"], "B")).to be_falsey
                        expect(includesKey?(json["cart"]["items"], "A")).to be_falsey
                    end
                end
            end
        end
    end
end