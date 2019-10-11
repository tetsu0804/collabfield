require "rails_helper"

RSpec.feature "visit single post", :type => :feature do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  scenario "User gose on single post from home page" do
    post
    visit root_path
    page.find('.single-post-card').click
    expect(page).to have_selector('.modal')
    click_button "I'm interested"
    expect(page).to have_selector('#single-post-content p', text: post.content)
  end
end
