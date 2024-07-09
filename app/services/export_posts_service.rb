class ExportPostsService < ApplicationService
  arg :post_ids, type: Array

  step :prepare_posts
  step :create_renderer
  step :render_reports

  output :compressed_filestream, default: false

  private

  attr_accessor :posts, :renderer

  def prepare_posts
    self.posts = Post.includes(attachments_attachments: :blob).where(id: post_ids)
  end

  def create_renderer
    self.renderer = ActionController::Base.new
  end

  def render_reports
    output_stream = Zip::OutputStream.write_buffer do |zos|
      posts.find_each do |post|
        zos.put_next_entry "post_#{post.id}.xlsx"
        zos.print renderer.render_to_string(
          layout: false, handlers: [:axlsx], formats: [:xlsx], template: 'posts/post', locals: { post: post.decorate }
        )
      end
    end

    output_stream.rewind
    self.compressed_filestream = output_stream
  end
end
