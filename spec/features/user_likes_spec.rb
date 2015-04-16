require 'rails_helper'

RSpec.feature "UserLikes", type: :feature do

  background do
    login_as(idea.user)
  end

  describe "user visits idea page" do
    background do
      visit idea_path(idea)
    end

    describe "within unliked idea" do
      let!(:idea) { create(:idea) }

      scenario "page has like link" do
        expect(current_path).to eq(idea_path(idea))
        expect(page).to have_selector(:link_or_button, "Like")
      end

      scenario "like Idea" do
        pending "Its causing an unexpected error"
        #this_should_not_get_executed
        
        expect{ click_link "Like" }.to change{ idea.likes.count }.by(1)
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
      
      before do
        login_as(user)
        visit idea_path(idea)
      end

      scenario "page has unlike link" do
        expect(page).to have_selector(:link_or_button, "Unlike")
      end

      scenario "unlike idea" do
        pending "Its causing an unexpected error"
        expect{ click_link "Unlike" }.to change{ idea.liked_by? user }.from(true).to(false)
      end
    end
  end
end
