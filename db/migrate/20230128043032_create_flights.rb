class CreateFlights < ActiveRecord::Migration[6.1]
  def change
    create_table :flights do |t|
      t.string :destination
      t.datetime :departure
      t.integer :plane_id
    end
  end
end
