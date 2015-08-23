class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.references :user, null: false    
      t.references :tip, null: false    
      t.timestamps null: false
    end
    add_index :stocks, [ :user_id ]
    add_index :stocks, [ :tip_id ]
    add_foreign_key :stocks, :users
    add_foreign_key :stocks, :tips
    # FIXME: add multipul key
  end
end
