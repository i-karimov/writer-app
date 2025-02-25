class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email, null: false, index: { unique: true }
      t.string :first_name, null: false
      t.string :last_name
      t.string :middle_name
      t.string :password_digest

      t.timestamps
    end
  end
end
