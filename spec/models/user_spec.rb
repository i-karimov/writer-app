require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    let(:user) { build(:user, email: 'user@email.com', region: create(:region)) }

    it 'is valid' do
      expect(user).to be_valid
    end
  end
end
