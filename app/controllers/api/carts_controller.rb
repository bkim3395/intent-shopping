class Api::CartsController < ApplicationController

    def create
        cart = Cart.new
        session[:session_token] = cart.session_token
        if (cart.save)
            @cart = current_cart
            render :show
        else
            render json: ['Failed to create a cart.'], status: 500
        end
    end

    def update
        @cart = current_cart
        if(@cart.nil?)
            render json: ['Cart does not exist.'], status: 400
        else
            if (!params.has_key?(:items))
                CartItem.where(cart_id: current_cart.id).destroy_all
            else
                current_list = Hash.new(0)
                @cart.items.each do |item|
                    current_list[item.code] += 1
                end
                params[:items].each do |item_code|
                    if (!!Item.find_by(code: item_code))
                        current_list[item_code] -= 1
                    else
                        render json: ["The item of corresponding code #{item_code} does not exist."], status: 422
                        return
                    end
                end
                current_list.each do |code, count|
                    item = Item.find_by(code: code)
                    if count > 0
                        items_in_cart = @cart.cart_items.where(item_id: item.id)
                        count.times { items_in_cart.first.destroy! }
                    else 
                        (-count).times { CartItem.create(cart_id: @cart.id, item_id: item.id) }
                    end
                end
            end
            @cart.reload
            render 'api/carts/show.json.jbuilder'
        end
    end

    def show
        @cart = current_cart
        unless (@cart)
            render json: ['Cart does not exist.'], status: 400
        end
    end

end