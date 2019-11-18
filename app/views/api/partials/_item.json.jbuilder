json.extract! item, :code, :description, :unit_price
if (!!item.volume_discount_number)
    json.volume_discounts do
        json.array! [{number: item.volume_discount_number}, {price: item.volume_discount_price}]
    end
else
    json.volume_discounts do
        json.array! []
    end
end