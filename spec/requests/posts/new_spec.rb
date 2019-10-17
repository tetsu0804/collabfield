require 'rails_helper'
include Warden::Test::Helpers
RSpec.describe "new", :type => :request do

  # サインインしていないユーザー
  context 'non-signed_in user' do
    it 'redirect_to user' do
      get '/posts/new'
      expect(response).to redirect_to root_path
    end
  end

  # サインインしているユーザー
  context 'signed_in user' do
    let(:user) { create(:user) }
    before(:each) { login_as user }

    it 'render a new template' do
      get '/posts/new'
      expect(response).to render_template(:new)
    end
  end
end
