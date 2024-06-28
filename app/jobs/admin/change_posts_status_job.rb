# frozen_string_literal: true

module Admin
  class ChangePostStatusJob < ApplicationJob
    queue_as :default

    def perform(post_id); end
  end
end
