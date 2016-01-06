class CreateSubgreens < ActiveRecord::Migration
  def change
    create_table :subgreens do |t|
      t.string :name
      t.integer :admin
      t.text :description

      t.timestamps null: false
    end
  end
end
