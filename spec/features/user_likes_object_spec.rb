require 'rails_helper'

RSpec.feature "UserAuthenticates", type: :feature do
  let!(:idea) { create(:idea) }
  let!(:user) { idea.user }

  background do
    visit root_url
    login(user.email, user.password)
  end

  describe "user visits idea page" do
    scenario "should have Like button" do
      visit idea_path(idea)
      expect(page).to have_content('Like')
    end

    scenario "should have Deslike button if liked" do
      like = create(:like, likeable_id: idea.id, likeable_type: idea.class.to_s, user_id: user.id)
      visit idea_path(idea)
      expect(page).to have_content('Unlike')
    end

    scenario "should change Like to Deslike after like" do
      pending 'implement with JS driver'
      this_should_not_get_executed
      # visit idea_path(idea)
      # click_button('Like')
      # expect(page).to have_content('Deslike')
    end
  end

  private
  def login(email, password)
    fill_in "user_email", :with => email
    fill_in "user_password", :with => password
    click_button "Log in"
  end
end
