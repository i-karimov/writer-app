# frozen_string_literal: true

class ExportPostsService < ApplicationService
  attr_reader :post_ids

  def initialize(post_ids)
    @post_ids = post_ids
  end

  def call
    compressed_filestream = output_stream

    compressed_filestream.rewind
    compressed_filestream
  end

  private

  def output_stream
    renderer = ActionController::Base.new

    Zip::OutputStream.write_buffer do |zos|
      Post.where(id: post_ids).find_each do |post|
        zos.put_next_entry "post_#{post.id}.xlsx"
        zos.print renderer.render_to_string(
          layout: false, handlers: [:axlsx], formats: [:xlsx], template: 'posts/post', locals: { post: post.decorate }
        )
      end
    end
  end
end
