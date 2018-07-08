class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :title
      t.text :comment
      t.integer :good
      t.timestamps null: false
    end
  end
end
