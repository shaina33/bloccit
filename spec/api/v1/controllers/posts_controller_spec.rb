require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
    let(:user) { create(:user) }
    let(:topic) { create(:topic) }
    let(:post) { create(:post, topic: topic, user: user) }
    let(:comment) { create(:comment, post: post) }
    let(:post2) { create(:post, topic: topic, user: user) }
    
    context "unauthenticated user" do
        it "GET index returns http success" do
            get :index
            expect(response).to have_http_status(:success)
        end
        it "GET index returns json object of all posts" do
            get :index
            expect(response.body).to eq(Post.all.to_json)
        end
        it "GET show returns http success" do
            get :show, id: post.id
            expect(response).to have_http_status(:success)
        end
        it "GET show returns json object of the post and its comments" do
            get :show, id: post.id
            expect(response.body).to eq({the_post: post, the_comments: [comment]}.to_json)
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
            get :show, id: post.id
            expect(response).to have_http_status(:success)
        end
    end
end