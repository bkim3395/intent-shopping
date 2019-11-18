# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Item.destroy_all
Cart.destroy_all
CartItem.destroy_all

a = Item.create(code: "A", description: "Apple", unit_price: 2.0, volume_discount_number: 4, volume_discount_price: 7.0)
b = Item.create(code: "B", description: "Banana", unit_price: 12.0)
c = Item.create(code: "C", description: "Cranberry", unit_price: 1.25, volume_discount_number: 6, volume_discount_price: 6.0)
d = Item.create(code: "D", description: "Durian", unit_price: 0.15)
# cart = Cart.create
# cart_a = CartItem.create(cart_id: cart.id, item_id: a.id) 
# cart_b = CartItem.create(cart_id: cart.id, item_id: b.id) 
# cart_c = CartItem.create(cart_id: cart.id, item_id: c.id) 