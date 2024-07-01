FactoryBot.define do
  factory :region do
    name { FFaker::AddressRU.city }

    trait :with_users do
      after(:create) do |region|
        create_list(:user, 2, :with_posts, region:)
      end
    end
  end
end

# == Schema Information
#
# Table name: regions
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
