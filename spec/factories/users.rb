FactoryBot.define do
  factory :user do
    email { FFaker::Internet.unique.email }
    first_name { FFaker::Name.unique.first_name }
    last_name { FFaker::Name.unique.last_name }
    middle_name { FFaker::Lorem.unique.word }
  end
end

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  first_name      :string           not null
#  last_name       :string
#  middle_name     :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
