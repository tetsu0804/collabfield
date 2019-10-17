require 'rails_helper'

RSpec.describe Post, type: :model do
  #　関連付け
  context 'Assosiations' do
    # User Assosiation
    it 'belongs_to user' do
      association = described_class.reflect_on_association(:user).macro
      expect(association).to eq :belongs_to
    end

    # Category Associatin
    it 'belongs_to Category' do
      association = described_class.reflect_on_association(:category).macro
      expect(association).to eq :belongs_to
    end
  end

  # User投稿のスコープ
  context 'Scopes' do
    # デフォルトのスコープの順番
    it 'default_scope orders by created_at' do
      first_post = create(:post)
      secound_post = create(:post)
      expect(Post.all).to eq [secound_post, first_post]
    end

    # カテゴリのスコープ
    it 'by_category scope gets posts by particula category' do
      category = create(:category)
      create(:post, category_id: category.id)
      create_list(:post, 10)
      posts = Post.by_category(category.branch, category.name)
      expect(posts.count).to eq 1
      expect(posts[0].category.name). to eq category.name
    end

    # アクション(branch)スコープ
    it 'by_branch scope gets posts by particula branch' do
      category = create(:category)
      create(:post, category_id: category.id)
      create_list(:post, 10)
      posts = Post.by_branch(category.branch)
      expect(posts.count).to eq 1
      expect(posts[0].category.branch).to eq category.branch
    end

    # サーチのスコープ
    it 'search finds a matching post' do
      post = create(:post, title: 'awesome title', content: 'great content' * 5)
      create_list(:post, 10, title: ('a'..'c' * 2).to_a.shuffle.join)
      expect(Post.search('awesome').count).to eq 1
      expect(Post.search('awesome')[0].id).to eq post.id
      expect(Post.search('great').count).to eq 1
      expect(Post.search('great')[0].id).to eq post.id
    end
  end

  # Post バリデーション
  context 'Validates' do
    let(:post) { build(:post) }

    # Post作成成功
    it 'Post Successfully' do
      expect(post).to be_valid
    end

    # category.idが無いためPost失敗
    it 'is not validate without a category' do
      post.category_id = nil
      expect(post).not_to be_valid
    end

    # titleが無いためpost失敗
    it 'is not validate without a title' do
      post.title = nil
      expect(post).not_to be_valid
    end

    # user.idが無いためpost失敗
    it 'is not validate without a user_id' do
      post.user_id = nil
      expect(post).not_to be_valid
    end

    # titleが４文字以内のためpost失敗
    it 'in not validate with a title, shorter 5' do
      post.title = "a" * 4
      expect(post).not_to be_valid
    end

    # titleが255以上の文字なのでpost失敗
    it 'is not validate with a title, long 255' do
      post.title = "a" * 256
      expect(post).not_to be_valid
    end

    # contentが無いためpost失敗
    it 'is not validate without a content' do
      post.content = nil
      expect(post).not_to be_valid
    end

    # contentの文字が20以下なのでpost失敗
    it 'is not validate with content, short 20' do
      post.content = "a" * 19
      expect(post).not_to be_valid
    end

    # contentの文字が1000以上なのでpost失敗
    it 'is not validate with content, long 1000' do
      post.content = "a" * 1001
      expect(post).not_to be_valid
    end
  end
end
