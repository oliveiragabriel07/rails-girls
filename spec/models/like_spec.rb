require 'rails_helper'

RSpec.describe Like, type: :model do

  let!(:like) { build(:like) }
  subject { like }

  it "should have a valid like_for_idea factory" do
    expect(build(:like)).to be_valid
  end

  it "should have an unique combination of user and likeable" do
    like = create(:like)
    expect(build(:like, likeable: like.likeable, user: like.user)).to_not be_valid
  end

  context "validation" do
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:likeable) }
  end
end
