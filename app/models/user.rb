class User < ApplicationRecord
  has_secure_password

  default_scope { order(created_at: :desc) }

  validates :email, presence: true, 'valid_email2/email': true
  validates :email, uniqueness: true
  validates :region_id, presence: true, unless: proc { |user| user.admin_role? }

  validates :first_name, presence: true
  # validate :password_complexity
  validate :password_presence

  belongs_to :region, optional: true
  has_many :posts

  enum role: { regular: 0, admin: 1 }, _suffix: :role

  def author?(obj)
    obj.user == self
  end

  private

  def password_complexity
    # Regexp extracted from https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a
    return if password.blank? || password =~ /(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-])/

    msg = 'complexity requirement not met. Length should be 8-70 characters and ' \
          'include: 1 uppercase, 1 lowercase, 1 digit and 1 special character'
    errors.add :password, msg
  end

  def password_presence
    errors.add(:password, :blank) if password_digest.blank?
  end

  ransacker :full_name do |parent|
    Arel::Nodes::NamedFunction.new('CONCAT_WS',
                                   [Arel::Nodes.build_quoted(' '), parent.table[:first_name], parent.table[:last_name]])
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[first_name middle_name last_name]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[posts region]
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
