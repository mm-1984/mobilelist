class AddColumnsToDevices < ActiveRecord::Migration[5.2]
  def change
    add_column :devices, :maker, :string
    add_column :devices, :on_sale, :string
    add_column :devices, :size, :string
  end
end
