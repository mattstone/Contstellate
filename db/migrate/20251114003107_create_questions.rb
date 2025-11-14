class CreateQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :questions do |t|
      t.text :content, null: false
      t.references :galaxy, null: false, foreign_key: true
      t.integer :used_count, default: 0

      t.timestamps
    end

    add_index :questions, :used_count
  end
end
