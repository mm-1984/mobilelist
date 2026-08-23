class CreateDevices < ActiveRecord::Migration[7.2]
  def change
    create_table :devices do |t|
      t.string :name
      t.string :image
      t.text :content
      t.string :maker
      t.string :on_sale
      t.string :size

      t.timestamps
    end
  end
end
