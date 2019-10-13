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
  end
end
