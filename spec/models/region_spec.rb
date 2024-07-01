require 'rails_helper'

RSpec.describe Region, type: :model do
  describe 'validation' do
    let(:region) { build(:region) }

    it 'is valid' do
      expect(region).to be_valid
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
