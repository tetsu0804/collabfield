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
    it 'returns no_posts partial path' do
      assign(:posts, [])
      expect(helper.no_posts_partial_path).to eq 'posts/branch/no_posts'
    end

    #@postsがある場合
    it 'returns posts partial path' do
      assign(:posts, [1])
      expect(helper.no_posts_partial_path).to eq 'shared/empty_partial'
    end
  end

end
