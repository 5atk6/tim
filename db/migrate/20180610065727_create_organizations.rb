class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.text :content
      t.string :url
      t.integer :user_id
      t.integer :category_id
      t.timestamps null: false
    end
  end
end
