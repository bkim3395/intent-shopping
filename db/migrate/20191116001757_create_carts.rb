class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.string :session_token, presence: true
      t.timestamps
    end
    add_index :carts, :session_token, unique: true
  end
end
