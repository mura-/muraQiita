class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false                      # メールアドレス
      t.string :email_for_index, null: false            # 索引用メールアドレス
      t.string :name, null: false                       # ユーザー名
      t.string :hashed_password                         # パスワード
      t.date :start_date, null: false                    # 開始日
      t.date :end_date                                  # 終了日
      t.boolean :suspended, null: false, default: false # 停止フラグ

      t.timestamps null: false
    end

    add_index :users, :email_for_index, unique: true
  end
end
