require 'rails_helper'
RSpec.describe LikesController, type: :controller do

  before(:each) do
    sign_in create(:user)
  end

  describe "POST #create" do
    let!(:idea) { create(:idea) }
    let(:valid_attributes) {
      { likeable_id: idea.id, likeable_type: idea.class.to_s, format: :js}
    }

    let(:invalid_attributes) {
      { likeable_id: nil, likeable_type: idea.class, format: :js}
    }

    context "with valid params" do
      it "creates a new Like" do
        expect {
          post :create, valid_attributes
        }.to change(Like, :count).by(1)
      end


      it 'responds with status 200' do
        post :create, valid_attributes
        expect(response.status).to eq(200)
      end

      it "assigns a newly created like as @like" do
        post :create, valid_attributes
        expect(assigns(:like)).to be_a(Like)
        expect(assigns(:like)).to be_persisted
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved like as @like" do
        post :create, invalid_attributes
        expect(assigns(:like)).to be_a_new(Like)
      end

      it 'do not create a new like' do
        expect {
          post :create, invalid_attributes
        }.to_not change(Like, :count)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:like) { create(:like) }

    it "destroys the requested like" do
      expect {
        delete :destroy, id: like.id, format: :js
      }.to change(Like, :count).by(-1)
    end
  end
end
