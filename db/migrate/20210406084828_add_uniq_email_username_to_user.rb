class AddUniqEmailUsernameToUser < ActiveRecord::Migration[6.1]
  def change
    add_index :users, [:username, :email], unique: true
  end
end
