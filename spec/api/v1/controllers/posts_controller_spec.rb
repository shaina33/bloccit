require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
    let(:user) { create(:user) }
    let(:topic) { create(:topic) }
    let(:my_post) { create(:post) }
    let(:comment) { create(:comment, post: my_post) }
    let(:post2) { create(:post) }
    
    context "unauthenticated user" do
        it "GET index returns http success" do
            get :index
            expect(response).to have_http_status(:success)
        end
        it "GET index returns json object of all posts" do
            get :index
            expect(response.body).to eq([post, post2].to_json)
        end
        it "GET show returns http success" do
            get :show, id: my_post.id
            expect(response).to have_http_status(:success)
        end
        it "GET show returns json object of the post and its comments" do
            get :show, id: my_post.id
            expect(response.body).to eq({the_post: my_post, the_comments: [comment]}.to_json)
        end

    end
    
    context "unauthorized user" do
        before do
            controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(user.auth_token)
        end
        
        it "GET index returns http success" do
            get :index
            expect(response).to have_http_status(:success)
        end
        
        it "GET show returns http success" do
            get :show, id: my_post.id
            expect(response).to have_http_status(:success)
        end
    end
end