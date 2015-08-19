class RenameTitleColumnToUsers < ActiveRecord::Migration
  def change
    rename_column :users, :startdate, :start_date
  end
end
