class CreateSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :sessions do |t|
      t.string :mode, null: false
      t.datetime :started_at
      t.datetime :completed_at
      t.integer :galaxies_visited, default: 0
      t.integer :player_count, default: 1

      t.timestamps
    end

    add_index :sessions, :mode
    add_index :sessions, :started_at
  end
end
