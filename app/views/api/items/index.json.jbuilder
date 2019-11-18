json.items do
    @items.each do |item|
        json.set! item.code do
            json.partial! "api/partials/item", item: item
        end
    end
end