require 'rails_helper'

RSpec.feature "UserLikes", type: :feature do

  background do
    visit root_path
    login_as(user, :scope => :user, :run_callbacks => false)
    visit idea_path(idea)
  end

  describe "user visits idea page" do
    let!(:idea) { create(:idea) }

    describe "within unliked idea" do
      let(:user) { create(:user) }

      scenario "page has like link" do
        expect(current_path).to eq(idea_path(idea))
        expect(page).to have_selector(:link_or_button, "Like")
      end

      scenario "like Idea" do
        #pending "Its causing an unexpected error"
        
        expect{ click_link "Like" }.to change(idea.likes, :count).by(1)
        expect(page).to have_css("p.alert-success", text: "You like this Idea.")
      end

      scenario "clicking like changes link from like to deslike" do
        pending "implement with JS driver"
        #this_should_not_get_executed

        click_link "Like"
        expect(page).to have_content('Deslike')
      end
    end

    describe "within idea liked by user" do
      let!(:like) { create(:like) }
      let(:idea) { like.likeable }
      let(:user) { like.user }

      scenario "page has unlike link" do
        expect(page).to have_selector(:link_or_button, "Unlike")
      end

      scenario "unlike idea" do
        pending "Its causing an unexpected error"
        expect{ click_link "Unlike" }.to change{ idea.liked_by? user }.from(true).to(false)
      end
    end
  end

  private
end
