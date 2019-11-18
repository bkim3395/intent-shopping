class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :code, presence: true
      t.string :description, presence: true
      t.float :unit_price, presence: true
      t.integer :volume_discount_number
      t.float :volume_discount_price
      t.timestamps
    end
    add_index :items, :code, unique: true
  end
end
