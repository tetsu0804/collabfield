require 'rails_helper'

RSpec.describe Category, type: :model do
  # Association
  context 'Association' do
    # has_many Post
    it 'has_many Post' do
      association = described_class.reflect_on_association(:posts)
      expect(association.macro).to eq :has_many
    end
  end
end
