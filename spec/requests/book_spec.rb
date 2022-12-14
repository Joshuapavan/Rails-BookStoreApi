require 'rails_helper'

describe "Books Api", type: :request do
  it "returns all books" do
    FactoryBot.create(:book, title: '1984')
    FactoryBot.create(:book, title: 'The Time Machine')

    get '/api/v1/books'

    expect(response).to have_http_status(:success)
    expect(JSON.parse(response.body).size).to eq(1)
  end
end

