require 'rails_helper'

RSpec.describe GeneralController, type: :request do
  before do
    User.create(id: 1, name: 'test')
    @post = FactoryBot.create(:post, user_id: 1)

  end

  describe 'GET #index' do
    it 'リクエストが成功すること' do
      get root_path
      expect(response.status).to eq 200
    end

    it '画像が表示されていること' do
      get root_path
      expect(response.body).to include "text_image_300%C3%97300.png"
    end
  end
end
