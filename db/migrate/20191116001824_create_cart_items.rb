class CreateCartItems < ActiveRecord::Migration[6.0]
  def change
    create_table :cart_items do |t|
      t.integer :cart_id, presence: true
      t.integer :item_id, presence: true
      t.timestamps
    end
    add_index :cart_items, :cart_id
  end
end
