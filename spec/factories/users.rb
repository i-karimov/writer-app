FactoryBot.define do
  factory :user do
    email { FFaker::Internet.unique.email }
    first_name { FFaker::Name.unique.first_name }
    last_name { FFaker::Name.unique.last_name }
    middle_name { FFaker::Lorem.unique.word }
    password { '#13R1fr:wx,E' }
    password_confirmation { '#13R1fr:wx,E' }
    association :region

    trait :with_posts do
      after(:create) do |user|
        create_list(:post, 5, user:, region: user.region)
      end
    end

    trait :admin do
      role { :admin }
    end
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
#  role            :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  region_id       :bigint
#
# Indexes
#
#  index_users_on_email      (email) UNIQUE
#  index_users_on_region_id  (region_id)
#  index_users_on_role       (role)
#
# Foreign Keys
#
#  fk_rails_...  (region_id => regions.id)
#
