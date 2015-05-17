class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.float :proteins
      t.float :carbs
      t.float :fat
      t.float :calories

      t.timestamps null: false
    end
  end
end
