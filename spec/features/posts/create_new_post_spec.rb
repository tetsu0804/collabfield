require 'rails_helper'

# ユーザーがpost作成できるかのテスト
RSpec.feature "Create a new post", :type => :feature do
  let(:user) { create(:user) }
  before(:each) { login_as user }

  #　ユーザーが新しい投稿をする
  shared_examples 'user create a new post' do |branch|
    # 作成
    scenario 'successfully' do
      create(:category, name: 'category', branch: branch)
      visit send("#{branch}_posts_path")
      find('.new-post-button').click
      fill_in 'post[title]', with: "a" * 20
      fill_in 'post[content]', with: "a" * 20
      select 'category', from: 'post[category_id]'
      click_on 'Create a post'
      expect(page).to have_selector('h3', text: "a" * 20)
    end
  end
  include_examples 'user create a new post', 'hobby'
  include_examples 'user create a new post', 'study'
  include_examples 'user create a new post', 'team'
end
