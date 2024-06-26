class Post < ApplicationRecord
  include AASM
  validates :title, :content, :status, presence: true

  validate :attachments_extension

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
#
