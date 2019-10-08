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
end
