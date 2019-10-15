require 'rails_helper'
require './app/services/posts_for_branch_service.rb'

describe PostsForBranchService do

  context '#call' do
    let(:not_included_posts) { create_list(:post, 2) }
    let(:category) { create(:category, branch: 'hobby', name: 'arts') }
    let(:post) do
      create(:post,title: 'a very fun post',
                    category_id: category.id)
    end

    # ブランチでフィルタリングされたpost
    it 'returns posts filtered by a branch' do
      not_included_posts
      category
      included_posts = create_list(:post, 2, category_id: category.id)
      expect(PostsForBranchService.new({branch: 'hobby'}).call).to(
        match_array included_posts
      )
    end

    # ブランチと検索によってフィルタリングされた投稿を返します
    it 'returns posts filtered by a branch and a search ' do
      not_included_posts
      category
      included_post = [] << post
      expect(PostsForBranchService.new({branch: 'hobby', search: 'fun'}).call).to(
        eq included_post
      )
    end

    # カテゴリでフィルタリングされた投稿を返します
    it 'returns posts filtered by a ctegory' do
      not_included_posts
      category
      included_post = [] << post
      expect(PostsForBranchService.new({branch: 'hobby', category: 'arts'}).call).to(
        eq included_post
      )
    end

    # カテゴリと検索でフィルタリングされた投稿を返します
    it 'returns posts filtered by a category and a search' do
      not_included_posts
      category
      included_post = [] << post
      expect(PostsForBranchService.new({name: 'arts', branch: 'hobby', search: 'fun'}).call).to(
        eq included_post
      )
    end
  end
end
