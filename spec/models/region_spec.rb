require 'rails_helper'

RSpec.describe Region, type: :model do
  describe 'validation' do
    let(:region) { build(:region) }

    it 'is valid' do
      expect(region).to be_valid
    end
  end
end
