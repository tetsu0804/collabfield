require "rails_helper"

RSpec.feature "Login", :type => :feature do
  let(:user) { create(:user) }

  scenario 'user navigation login page and successfuly login', js: true do
    user

    visit root_path
    find('nav a', text: 'Login').click
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button 'Log in'
    expect(page).to have_selector('#user-settings')
  end
end
