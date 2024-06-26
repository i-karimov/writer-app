class Post < ApplicationRecord
  include AASM
  validates :title, :content, :status, presence: true

  validate :attachments_extension

  belongs_to :region
  belong_to :user

  has_many_attached :images
  has_many_attached :files

  aasm(column: :status) do
    state :draft, initial: true
    state :on_moderation
    state :approved
    state :rejected

    event :submit do
      transitions from: :draft, to: :on_moderation
    end

    event :approve do
      transitions from: :on_moderation, to: :approved
    end

    event :reject do
      transitions from: :on_moderation, to: :rejected
    end
  end

  private

  def attachments_extension
    return if images.all? { |img| img.content_type =~ /^image/ }

    errors.add(:images, 'should have correct extension')
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[title]
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end
end

# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  status     :string           not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  region_id  :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_posts_on_region_id  (region_id)
#  index_posts_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (region_id => regions.id)
#  fk_rails_...  (user_id => users.id)
#
