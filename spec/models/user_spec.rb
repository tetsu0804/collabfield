require 'rails_helper'

RSpec.describe User, type: :model do
  # 関連付け
  context 'Association' do
    # has_many posts
    it 'has_many posts' do
      association = described_class.reflect_on_association(:posts)
      expect(association.macro).to eq :has_many
      expect(association.options[:dependent]).to eq :destroy
    end
  end
end
