class ChangeUserModel < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :uid
      t.string :provider
    end
  
    add_index :users, [:uid, :provider], unique: true
  end
end
