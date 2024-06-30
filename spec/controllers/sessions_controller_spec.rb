require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let!(:user) { create(:user) }
  let(:current_user) do
    controller.send(:current_user)
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid credentials' do
      it 'signs in the user' do
        post :create, params: { email: user.email, password: user.password }
        expect(current_user).to eq(user)
      end

      it 'redirects to the posts path' do
        post :create, params: { email: user.email, password: user.password }
        expect(response).to redirect_to(posts_path)
      end
    end

    context 'with invalid credentials' do
      it 'does not sign in the user' do
        post :create, params: { email: user.email, password: 'wrong_password' }
        expect(current_user).to be_nil
      end

      it 'redirects to the new session path' do
        post :create, params: { email: user.email, password: 'wrong_password' }
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      post :create, params: { email: user.email, password: user.password }
    end

    it 'signs out the user' do
      delete :destroy
      expect(current_user).to be_nil
    end

    it 'redirects to the new session path' do
      delete :destroy
      expect(response).to redirect_to(new_session_path)
    end
  end
end
