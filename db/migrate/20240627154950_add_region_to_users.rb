class AddRegionToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :region, null: true, foreign_key: true
  end
end
