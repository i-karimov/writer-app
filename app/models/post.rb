class Post < ApplicationRecord
  validates :title, :content, :status, presence: true

  validate :attachments_extension

  has_many_attached :images
  has_many_attached :files

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
#  content    :text
#  status     :string           not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
