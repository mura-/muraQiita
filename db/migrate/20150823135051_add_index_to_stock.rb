class AddIndexToStock < ActiveRecord::Migration
  def change
    add_index :stocks, [ :user_id, :tip_id ], unique: true
  end
end
