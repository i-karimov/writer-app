class Region < ApplicationRecord
  validates :name, presence: true

  has_many :post
  has_many :users
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
