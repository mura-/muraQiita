class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, null: false    
      t.references :tip, null: false    
      t.text :content, null: false        
      t.datetime :created_at, null: false
      t.timestamps null: false
    end
    add_index :comments, [ :tip_id, :user_id ]
    add_foreign_key :comments, :users
    add_foreign_key :comments, :tips
  end
end
