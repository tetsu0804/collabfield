require 'rails_helper'

RSpec.describe NavigationHelper, :type => :helper do
  #サインインユーザー
  context 'signed in user' do
      before(:each) {helper.stub(:user_signed_in?).and_return(true)}

      context '#collapsible_links_partial_path' do
        it 'signed_in_links partials path' do
          expect(helper.collapsible_links_partial_path).to eq 'layouts/navigation/collapsible_elements/signed_in_links'
        end
      end
  end

  #サインインしていないユーザー
  context 'non signed in user' do
    before(:each) { helper.stub(:user_signed_in?).and_return(false)}

    context '#collapsible_links_partial_path' do
      it 'non_signed_links partials path' do
        expect(helper.collapsible_links_partial_path).to eq 'layouts/navigation/collapsible_elements/non_signed_in_links'
      end
    end
  end
end
