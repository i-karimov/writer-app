FactoryBot.define do
  factory :post do
    title { FFaker::Lorem.sentence }
    content { FFaker::Lorem.paragraphs(5).join }
    association :user
    association :region

    trait(:with_attachment) do
      before(:create) do |post|
        post.attachments.attach(io: File.open("#{Rails.root.join('spec/fixtures/singer.jpg')}"),
                                filename: 'singer.jpg', content_type: 'image/jpg')
      end
    end
  end
end

# == Schema Information
#
# Table name: posts
#
#  id           :bigint           not null, primary key
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
