class AddLockVersionToPost < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :lock_version, :integer
  end
end
