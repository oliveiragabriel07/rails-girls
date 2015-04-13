require 'rails_helper'

RSpec.describe Idea, type: :model do
  context "db" do
    context "indexes" do
      it { is_expected.to have_db_index(:user_id) }
    end

    context "columns" do
      it { is_expected.to have_db_column(:name).of_type(:string) }
      it { is_expected.to have_db_column(:description).of_type(:text) }
      it { is_expected.to have_db_column(:picture).of_type(:string) }
      it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
      it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
    end

    context "references" do
      it { is_expected.to belong_to(:user) }
      it { is_expected.to have_many(:comments) }
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
end
