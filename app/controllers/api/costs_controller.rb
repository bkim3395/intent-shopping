class Api::CostsController < ApplicationController

    def show
        cart = current_cart
        if (cart.nil?)
            render json: ["Cart does not exist so total cost can't be calculated."], status: 400
        else
            items = Hash.new(0)
            @cost = 0
            cart.items.each do |item|
                items[item.code] += 1
            end
            items.each do |code, count|
                item = Item.find_by(code: code)
                if (item.volume_discount_number) 
                    @cost += (count / item.volume_discount_number) * item.volume_discount_price
                    @cost += (count % item.volume_discount_number) * item.unit_price
                else
                    @cost += count * item.unit_price
                end
            end
            render 'api/costs/show.json.jbuilder'
        end
    end

end