require 'rails_helper'

RSpec.describe Admin, type: :model do

  context "validation" do
    it { is_expected.to validate_uniqueness_of(:email) }
  end

  describe "abilities" do
    let(:admin) { create(:admin) }
    let(:ability) { Ability.new(admin) }
    subject { ability }

    it { is_expected.to have_abilities(:manage, :all) }
  end
end
