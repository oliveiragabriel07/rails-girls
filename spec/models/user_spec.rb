require 'rails_helper'
require 'cancan/matchers'

RSpec.describe User, type: :model do

  context "db" do
    context "columns" do
      it { is_expected.to have_db_column(:first_name).of_type(:string) }
      it { is_expected.to have_db_column(:last_name).of_type(:string) }
    end
  end

  context "validation" do
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
  end

  describe "abilities" do
    let(:user) { create(:user_with_ideas, ideas_count: 1) }
    let(:other_user) { create(:user_with_ideas, ideas_count: 1) }
    let(:idea) { create(:idea) }
    let(:comment) { build(:comment) }
    let(:ability) { Ability.new(user) }
    subject { ability }

    it { is_expected.to have_abilities(:manage, comment) }
    it { is_expected.to have_abilities([:read, :create], idea) }
    it { is_expected.to have_abilities(:modify, user.ideas.first) }
    it "not have abilities modify on Idea of others" do
      is_expected.to not_have_abilities(:modify, other_user.ideas.first)
    end
  end
end
