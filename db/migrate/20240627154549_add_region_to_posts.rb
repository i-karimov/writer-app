class AddRegionToPosts < ActiveRecord::Migration[7.1]
  def change
    add_reference :posts, :region, null: false, foreign_key: true
  end
end
