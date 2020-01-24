class CreateCars < ActiveRecord::Migration[5.2]
  def change
    create_table :cars do |t|
      t.string :driver_name
      t.string :country
      t.integer :car_number
      t.string :car_colour
      t.integer :position
      t.float :interval
      t.boolean :pitting
      t.float :last_lap

      t.timestamps
    end
  end
end
