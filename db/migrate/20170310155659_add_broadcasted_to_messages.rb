class AddBroadcastedToMessages < ActiveRecord::Migration[5.0]

  def change
    add_column :messages, :broadcasted, :boolean, default: false
  end

end
