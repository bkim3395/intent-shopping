json.extract! cart, :session_token
json.items do 
    json.array! cart.items do |item|
        json.partial! "/api/partials/item.json.jbuilder", item: item
    end
end