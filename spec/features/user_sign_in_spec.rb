require 'rails_helper'

RSpec.feature "UserSignIn", type: :feature do
  let(:password) { "somepass" }
  let!(:user) { create(:user, password: password) }

  scenario "with correct data" do
    visit root_path
    expect(current_path).to eq(new_user_session_path)

    login user.email, password
    expect(current_path).to have_text(ideas_path)
    expect(page).to have_css("h1", text: "Listing Ideas")
    expect(page).to have_css("p.alert-success", text: "Signed in successfully.", visible: true)
  end

  scenario "with invalid data" do
    visit root_path
    expect(current_path).to eq(new_user_session_path)

    login user.email, password << "!invalid"
    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_css("p.alert-danger", text: "Invalid email or password.", visible: true)
  end

  private
  def login(email, password)
    fill_in "user_email", :with => email
    fill_in "user_password", :with => password
    click_button "Log in"
  end
end
