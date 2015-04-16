require 'rails_helper'

RSpec.describe Comment, type: :model do
  context "db" do
    context "indexes" do
      it { is_expected.to belong_to(:idea) }
    end

    context "columns" do
      it { is_expected.to have_db_column(:user_name).of_type(:string) }
      it { is_expected.to have_db_column(:body).of_type(:text) }
      it { is_expected.to have_db_column(:idea_id).of_type(:integer) }
      it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
      it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
      it { is_expected.to have_db_column(:user_id).of_type(:integer) }
    end
  end

  context "validation" do
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_presence_of(:idea_id) }
    it { is_expected.to validate_presence_of(:user) }
  end
end
