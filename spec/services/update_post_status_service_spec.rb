RSpec.describe UpdatePostStatusService, type: :service do
  context 'when transition is draft => on_moderation' do
    let(:post) { create(:post, status: :draft) }

    it 'updates the post status successfully' do
      expect(post.status).to eq('draft')
      expect(UpdatePostStatusService.call(post, :submit)).to be_truthy
      expect(post.status).to eq('on_moderation')
    end
  end

  context 'when transition is  on_moderation => approved' do
    let(:post) { create(:post, status: :on_moderation) }

    it 'updates the post status successfully' do
      expect(post.status).to eq('on_moderation')
      expect(UpdatePostStatusService.call(post, :approve)).to be_truthy
      expect(post.status).to eq('approved')
    end
  end

  context 'when transition is  on_moderation => rejected' do
    let(:post) { create(:post, status: :on_moderation) }

    it 'updates the post status successfully' do
      expect(post.status).to eq('on_moderation')
      expect(UpdatePostStatusService.call(post, :reject)).to be_truthy
      expect(post.status).to eq('rejected')
    end
  end
end