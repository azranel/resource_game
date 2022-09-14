require 'rails_helper'

RSpec.describe "HomeController", type: :request do
  let(:user) { User.create(email: 'bart@gmail.com', password: 'password') }

  describe "GET /index" do
    before { sign_in user }

    it "returns http success" do
      get "/home/index"
      expect(response).to have_http_status(:success)
    end
  end

end
