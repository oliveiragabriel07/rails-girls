require 'rails_helper'

RSpec.feature "UserLikes", type: :feature do

  background do
    visit root_path
    login_as(user, :scope => :user)
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

      scenario "clicking like changes link to unlike", :js => true do
        click_link "Like"
        expect(page).to have_content('Unlike')
      end
    end

    describe "within idea liked by user" do
      let!(:like) { create(:like) }
      let(:idea) { like.likeable }
      let(:user) { like.user }

      scenario "page has unlike link" do
        expect(page).to have_selector(:link_or_button, "Unlike")
      end

      scenario "clicking unlike changes link to like", :js => true do
        click_link "Unlike"
        expect(page).to have_content('Like')
      end
    end
  end
end
