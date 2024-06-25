class Post < ApplicationRecord
  validates :title, :content, :status, presence: true
end
