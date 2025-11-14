class CreateSessionGalaxies < ActiveRecord::Migration[8.0]
  def change
    create_table :session_galaxies do |t|
      t.references :session, null: false, foreign_key: true
      t.references :galaxy, null: false, foreign_key: true

      t.timestamps
    end
  end
end
