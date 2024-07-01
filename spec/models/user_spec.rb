require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    let(:user) { build(:user, email: 'user@email.com', region: create(:region)) }

    it 'is valid' do
      expect(user).to be_valid
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
#  role            :integer          default("regular"), not null
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
