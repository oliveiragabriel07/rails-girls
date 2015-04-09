require 'rails_helper'

RSpec.describe Idea, type: :model do
  it "has nil name" do
    idea = Idea.new
    expect(idea.name).to be_nil 
  end
end
