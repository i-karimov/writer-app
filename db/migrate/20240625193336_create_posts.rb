class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :content
      t.string :status, null: false

      t.timestamps
    end
  end
end
