require 'rails_helper'

RSpec.feature "UserRegisters", type: :feature do
  before { visit new_user_registration_path }
  let(:user) { build(:user) }

  scenario "with valid data" do
    submit(user, user.password)
    
    expect(current_path).to eq(ideas_path)
    expect(page).to have_css("h1", text: "Ideas")
    expect(page).to have_css("p.alert-success", text: I18n.t("devise.registrations.signed_up"), visible: true)
  end

  context "with invalid data" do
    scenario "blank fields" do
      expect_fields_to_be_blank

      click_button "Sign up"
      expect(page).to have_error_messages "First name can't be blank",
        "Last name can't be blank",
        "Email can't be blank",
        "Password can't be blank"
    end

    scenario "incorrect password confirmation" do
      submit(user, "!incorrect")
      expect(page).to have_error_message "Password confirmation doesn't match Password"
    end

    scenario "already registered email" do
      existing_user = create(:user, email: user.email)      
      submit user, user.password
      expect(page).to have_error_message "Email has already been taken"
    end

    scenario "invalid email" do
      user.email = "invalid-email-for-testing"
      submit user, user.password
      expect(page).to have_error_message "Email is invalid"
    end

    scenario "too short password" do      
      min_password_length = 8
      too_short_password = "p" * (min_password_length - 1)
      user.password = too_short_password
      submit user, user.password

      expect(page).to have_error_message "Password is too short (minimum is 8 characters)"
    end
  end

  private

  def submit(user, password_confirmation)   
    fill_in "user_first_name", :with => user.first_name
    fill_in "user_last_name", :with => user.last_name
    fill_in "user_email", :with => user.email
    fill_in "user_password", :with => user.password
    fill_in "user_password_confirmation", :with => password_confirmation

    click_button "Sign up"
  end

  def expect_fields_to_be_blank
    expect(find_field("user_first_name", type: "text").value).to be_nil
    expect(find_field("user_last_name", type: "text").value).to be_nil
    expect(page).to have_field("user_email", with: "", type: "email")
    expect(find_field("user_password", type: "password").value).to be_nil
    expect(find_field("user_password_confirmation", type: "password").value).to be_nil
  end
end
