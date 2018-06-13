class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :content
      t.string :venue
      t.string :url
      t.time :start_time
      t.time :end_time
      t.integer :user_id
      t.integer :organization_id
      t.timestamps null: false
    end
  end
end
