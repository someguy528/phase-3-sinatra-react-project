class CreatePlanes < ActiveRecord::Migration[6.1]
  def change
    create_table :planes do |t|
      t.string :name
      t.integer :capacity
      t.string :condition
    end
  end
end
