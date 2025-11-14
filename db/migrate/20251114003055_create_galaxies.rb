class CreateGalaxies < ActiveRecord::Migration[8.0]
  def change
    create_table :galaxies do |t|
      t.string :name, null: false
      t.string :color, null: false
      t.string :icon
      t.text :description
      t.integer :question_count, default: 0

      t.timestamps
    end

    add_index :galaxies, :name, unique: true
  end
end
