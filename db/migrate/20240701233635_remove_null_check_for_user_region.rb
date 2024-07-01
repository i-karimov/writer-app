class RemoveNullCheckForUserRegion < ActiveRecord::Migration[7.1]
  def change
    change_column_null :users, :region_id, true
  end
end
