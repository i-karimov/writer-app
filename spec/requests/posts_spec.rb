require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { create(:user) }
  let(:the_post) { create(:post, user:) }

  before do
    post '/session', params: { email: user.email, password: user.password }
  end

  describe 'GET /posts' do
    it 'renders the index template' do
      get posts_path
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template with zip format' do
      get posts_path, params: { format: :zip }
      expect(response).to have_http_status(:success)
      expect(response.headers['Content-Disposition']).to include('posts.zip')
    end
  end

  describe 'GET /posts/new' do
    it 'renders the new template' do
      get new_post_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /posts' do
    context 'with valid data' do
      let(:valid_params) { { post: { title: 'Test Post', content: 'This is a test post' } } }

      it 'creates a new post' do
        expect do
          post posts_path, params: valid_params
        end.to change(Post, :count).by(1)
      end

      it 'redirects to the posts path' do
        post posts_path, params: valid_params
        expect(response).to redirect_to(posts_path)
      end
    end

    context 'with invalid data' do
      let(:invalid_params) { { post: { title: '', content: '' } } }

      it 'does not create a new post' do
        expect do
          post posts_path, params: invalid_params
        end.not_to change(Post, :count)
      end

      it 'renders the new template' do
        post posts_path, params: invalid_params
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET /posts/:id' do
    it 'renders the show template' do
      get post_path(the_post)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /posts/:id/edit' do
    it 'renders the edit template' do
      get edit_post_path(the_post)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /posts/:id' do
    context 'with valid data' do
      let(:valid_params) { { post: { title: 'Updated Title', content: 'New content', status: 'on_moderation' } } }

      it 'updates the post' do
        patch post_path(the_post), params: valid_params
        expect(the_post.reload.title).to eq('Updated Title')
        expect(the_post.reload.content).to eq('New content')
      end

      it 'redirects to the posts path' do
        patch post_path(the_post), params: valid_params
        expect(response).to redirect_to(posts_path)
      end
    end

    context 'with invalid data' do
      let(:invalid_params) { { post: { title: '' } } }

      it 'does not update the post' do
        patch post_path(the_post), params: invalid_params
        expect(the_post.reload.title).not_to eq('')
      end

      it 'renders the edit template' do
        patch post_path(the_post), params: invalid_params
        expect(response).to redirect_to(posts_path)
      end
    end
  end

  describe 'DELETE /posts/:id' do
    let(:request) { delete post_path(the_post) }

    it 'redirects to the posts path' do
      expect(response).to redirect_to(posts_path)
    end
  end
end
