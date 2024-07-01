class Post < ApplicationRecord
  include AASM
  include Authorship

  self.locking_column = :lock_version
  
  default_scope { order(created_at: :desc) }

  validates :title, :content, :status, presence: true

  validate :attachments_extension

  belongs_to :region
  belongs_to :user

  has_many_attached :images do |image|
    image.variant :thumb, resize_to_limit: [250, 250], preprocessed: true
  end

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
      transitions from: :on_moderation, to: :approved do
        after do
          self.published_at = Time.current
          save
        end
      end
    end

    event :reject do
      transitions from: :on_moderation, to: :rejected
    end
  end

  ransacker :created_at do
    Arel.sql('date(created_at)')
  end

  def attachments_extension
    errors.add(:files, 'should have elligable extension') if files.any? { |file| file.content_type =~ /^image/ }
    errors.add(:images, 'should have elligable extension') unless images.all? { |img| img.content_type =~ /^image/ }
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[title published_at region_id user_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[region user]
  end
end

# == Schema Information
#
# Table name: posts
#
#  id           :bigint           not null, primary key
#  content      :text             not null
#  lock_version :integer
#  published_at :datetime
#  status       :string           not null
#  title        :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  region_id    :bigint           not null
#  user_id      :bigint           not null
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
