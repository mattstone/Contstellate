class CreateReflections < ActiveRecord::Migration[8.0]
  def change
    create_table :reflections do |t|
      t.references :session, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.text :note
      t.string :voice_recording_url
      t.string :reflection_type

      t.timestamps
    end
  end
end
