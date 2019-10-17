require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the PostsHelper. For example:
#
# describe PostsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe PostsHelper, type: :helper do
  # views/posts/_branch.html.erbのUserがサインインしている場合はCreate New していない場合は Log in画面
  context '#create_new_post_partial_path' do
    # Userがサインインしている場合
    it 'returns signed in partial path' do
      allow(helper).to receive(:user_signed_in?).and_return(true)
      expect(helper.create_new_post_partial_path). to eq 'posts/branch/create_new_post/signed_in'
    end

    # Userがサインインしていない場合
    it 'returns not signed in partial path' do
      allow(helper).to receive(:user_signed_in?).and_return(false)
      expect(helper.create_new_post_partial_path).to eq 'posts/branch/create_new_post/not_signed_in'
    end
  end

  # views/posts/branch/_categories.html params[:category]がある場合とない場合
  context '#all_categories_button_partial_path' do
    # categoryがない場合
    it 'returns all_selected partials path' do
      controller.params[:category] = ''
      expect(helper.all_categories_button_partial_path).to eq 'posts/branch/categories/all_selected'
    end
    # categoryがある場合
    it 'returns all_not_selected partials path' do
      controller.params[:category] = 'category'
      expect(helper.all_categories_button_partial_path).to eq 'posts/branch/categories/all_not_selected'
    end
  end

  # views/posts/_branch.html @postsがある場合と無い場合
  context '#no_posts_partial_path' do
    # @postsが無い場合
    it "returns a no_posts partial's path" do
      expect(helper.no_posts_partial_path([])).to (
        eq 'posts/shared/no_posts'
      )
    end

    #@postsがある場合
    it "returns an empty partial's path" do
      expect(helper.no_posts_partial_path([1])).to (
        eq 'shared/empty_partial'
      )
    end
  end

  # views/posts/_post.html.erb
  context '#post_format_partial_path' do
    # current_pageの場合
    it 'returns to current_page partial path' do
      allow(helper).to receive(:current_page?).and_return(true)
      expect(helper.post_format_partial_path).to eq 'posts/post/home_page'
    end

    # current_pageでは無いとき
    it 'returns branch page parital path' do
      allow(helper).to receive(:current_page?).and_return(false)
      expect(helper.post_format_partial_path).to eq 'posts/post/branch_page'
    end
  end

  context '#update_pagination_partial_path' do
  it "returns an update_pagination partial's path" do
    posts = double('posts', :next_page => 2)
    assign(:posts, posts)
    expect(helper.update_pagination_partial_path).to(
      eq 'posts/posts_pagination_page/update_pagination'
    )
  end

  # scroll posts pagination
  it "returns a remove_pagination partial's path" do
    posts = double('posts', :next_page => nil)
    assign(:posts, posts)
    expect(helper.update_pagination_partial_path).to(
      eq 'posts/posts_pagination_page/remove_pagination'
    )
  end
end

end
