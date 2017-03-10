class AddN24AccessTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :n24_access_token, :string
  end
end
