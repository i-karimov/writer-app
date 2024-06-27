class Region < ApplicationRecord
  validates :name, presence: true

  has_many :users
  has_many :post, through: :users

  def self.ransackable_attributes(_auth_object = nil)
    ['name']
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
