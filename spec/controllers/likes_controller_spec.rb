require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let!(:user) { create(:user) }

  before(:each) do
    sign_in user
  end

  context 'POST #create' do
    context 'with valid attributes' do
      let!(:idea) { create(:idea) }
      let!(:valid_attributes) {
        {user_id: user.id, likeable_id: idea.id, likeable_type: idea.class.to_s}
      }

      it 'creates new like' do
        expect {
          post :create, format: :js, like: valid_attributes
        }.to change(Like, :count).by(1)
      end

      it 'should respond with 200' do
        post :create, format: :js, like: valid_attributes
        expect(response.status).to eq(200)
      end
    end

    context 'with invalid attributes' do
      let!(:idea) { create(:idea) }
      let!(:invalid_attributes) {
        {user_id: user.id, likeable_id: nil, likeable_type: idea.class.to_s}
      }

      it 'should not create a new like' do
        expect {
          post :create, format: :js, like: invalid_attributes
        }.to_not change(Like, :count)
      end
    end
  end

  context 'DESTROY #create' do
    context 'with valid attributes' do
      let!(:like) { create(:like) }
      let!(:valid_attributes) {
        {likeable_id: like.likeable.id, likeable_type: like.likeable.class.to_s}
      }

      it 'destroys a like' do
        expect {
          delete :destroy, format: :js, id: like.id
          # delete :destroy, format: :js, like: valid_attributes
        }.to change(Like, :count).by(-1)
      end
    end
  end
end
