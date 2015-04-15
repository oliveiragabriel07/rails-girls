require 'rails_helper'

RSpec.describe Idea, type: :model do
  context "db" do
    context "indexes" do
      it { is_expected.to have_db_index(:user_id) }
      it { is_expected.to belong_to(:user) }
      it { is_expected.to have_many(:comments) }
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

  context '#liked_by' do
    let!(:user) { create(:user) }
    let!(:idea) { create(:idea) }
    it 'should return like object' do
      like = create(:like, likeable: idea, user: user)
      expect(idea.reload.liked_by(user)).to eq(like)
    end

    it 'should return nil when idea wasnt liked by user' do
      expect(idea.liked_by(user)).to be_nil
    end
  end

  context '#liked_by?' do
    let!(:user) { create(:user) }
    it 'should be true when idea is already liked by user' do
      idea = create(:idea)
      create(:like, likeable: idea, user: user)

      expect(idea.reload.liked_by?(user)).to be true
    end

    it 'should not be true when idea wasnt liked by user' do
      idea = create(:idea)
      expect(idea.liked_by?(user)).to be false
    end
  end
end
