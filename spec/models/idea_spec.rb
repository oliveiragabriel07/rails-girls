require 'rails_helper'

RSpec.describe Idea, type: :model do
  context "db" do
    context "indexes" do
      it { is_expected.to have_db_index(:user_id) }
      it { is_expected.to belong_to(:user) }
      it { is_expected.to have_many(:comments) }
      it { is_expected.to have_many(:likes) }
    end

    context "columns" do
      it { is_expected.to have_db_column(:name).of_type(:string) }
      it { is_expected.to have_db_column(:description).of_type(:text) }
      it { is_expected.to have_db_column(:picture).of_type(:string) }
      it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
      it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
    end
  end

  context "validation" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name)
      .is_at_least(3)
      .is_at_most(50)
    }
    it { is_expected.to allow_value('', nil).for(:description) }
    it { is_expected.to validate_length_of(:description)
      .is_at_least(3)
      .is_at_most(256) 
    }
    it { is_expected.to validate_presence_of(:picture) }
    it { is_expected.to validate_presence_of(:user) }
  end

  context "likeable" do
    let!(:idea) { create(:idea) }
    let(:user) { create(:user) }
    
    context "#liked_by?" do
      it { is_expected.to respond_to(:liked_by?) }

      context "returns false" do
        it "within nil user" do
          expect(idea.liked_by? nil).to be false
        end

        it "when user did not like idea" do
          expect(idea.liked_by? user).to be false
        end
      end
    end

    context "#liked_by" do
      it 'returns like object' do
        like = create(:like, likeable: idea, user: user)
        expect(idea.liked_by(user)).to eq(like)
      end
    end
  end
end
