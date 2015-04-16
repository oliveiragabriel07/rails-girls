require 'rails_helper'

RSpec.describe Like, type: :model do
  let!(:like) { build(:like) }
  subject { like }

  it "has valid like factory" do
    expect(build(:like)).to be_valid
  end

  context "validation" do
    it "has unique combination of user and likeable" do
      like = create(:like)
      expect(build(:like, likeable: like.likeable, user: like.user)).to_not be_valid
    end

    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:likeable) }
  end
end
