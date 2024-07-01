RSpec.describe 'UpdatePostForm' do
  let(:post) { create(:post, status: :draft) }
  let(:params) { post.attributes.symbolize_keys.merge(status: 'on_moderation') }
  let(:form) { UpdatePostForm.new(post, params) }

  describe '#perform' do
    context 'when the form is valid' do
      it 'updates the post and attaches images and files' do
        expect(form).to receive(:valid?).and_return(true)
        expect(post).to receive(:update).with(params.except(:images, :files, :state))
        expect(post.images).to receive(:attach).with(params[:images])
        expect(post.files).to receive(:attach).with(params[:files])
        expect(UpdatePostStatusJob).to receive(:perform_later).with(post.id, form.aasm_event)
        form.perform
      end

      it 'returns true if the post is updated successfully' do
        expect(form).to receive(:valid?).and_return(true)
        expect(form.perform).to be_truthy
      end
    end
  end
end
