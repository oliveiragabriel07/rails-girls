require 'rails_helper'

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
end
