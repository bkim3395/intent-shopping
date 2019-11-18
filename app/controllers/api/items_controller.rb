class Api::ItemsController < ApplicationController

    def index
        @items = Item.all
        render 'api/items/index.json.jbuilder'
    end

end