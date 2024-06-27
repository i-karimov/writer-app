FactoryBot.define do
  factory :region do
    name { FFaker::AddressRU.city }
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
