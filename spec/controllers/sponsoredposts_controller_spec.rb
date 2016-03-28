require 'rails_helper'

RSpec.describe SponsoredpostsController, type: :controller do
let(:my_topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
let(:my_spost) { my_topic.sponsoredposts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 10) }

  describe "GET #show" do
    it "returns http success" do
      get :show, topic_id: my_topic.id, id: my_spost.id
      expect(response).to have_http_status(:success)
    end
    it "renders the #show view" do
      get :show, topic_id: my_topic.id, id: my_spost.id
      expect(response).to render_template :show
    end
    it "assigns my_spost to @spost" do
      get :show, topic_id: my_topic.id, id: my_spost.id
      expect(assigns(:spost)).to eq(my_spost)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, topic_id: my_topic.id
      expect(response).to have_http_status(:success)
    end
    it "renders the #new view" do
      get :new, topic_id: my_topic.id
      expect(response).to render_template :new
    end
    it "instantiates @spost" do
      get :new, topic_id: my_topic.id
      expect(assigns(:spost)).not_to be_nil
    end
  end
  
  describe "POST #create" do
    it "increases the number of sponsored posts by 1" do
      expect{post :create, topic_id: my_topic.id, spost: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 10}}.to change(Sponsoredpost,:count).by(1)
    end

    it "assigns the new sponsored post to @spost" do
      post :create, topic_id: my_topic.id, spost: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 10}
      expect(assigns(:spost)).to eq Sponsoredpost.last
    end

    it "redirects to the new post" do
      post :create, topic_id: my_topic.id, spost: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 10}
      expect(response).to redirect_to [my_topic, Sponsoredpost.last]
    end
  end
      
  describe "GET #edit" do
    it "returns http success" do
      get :edit, topic_id: my_topic.id, id: my_spost.id
      expect(response).to have_http_status(:success)
    end
    it "renders the #edit view" do
      get :edit, topic_id: my_topic.id, id: my_spost.id
      expect(response).to render_template :edit
    end
    it "assigns the correct spost to @spost" do
      get :edit, topic_id: my_topic.id, id: my_spost.id
      spost_instance = assigns(:spost)
      expect(spost_instance.id).to eq my_spost.id
      expect(spost_instance.title).to eq my_spost.title
      expect(spost_instance.body).to eq my_spost.body
      expect(spost_instance.price).to eq my_spost.price
    end
  end
  
  describe "PUT update" do
     it "updates sponsored post with expected attributes" do
       new_title = RandomData.random_sentence
       new_body = RandomData.random_paragraph
       new_price = 12
 
       put :update, topic_id: my_topic.id, id: my_spost.id, spost: {title: new_title, body: new_body, price: new_price}
 
       updated_spost = assigns(:spost)
       expect(updated_spost.id).to eq my_spost.id
       expect(updated_spost.title).to eq new_title
       expect(updated_spost.body).to eq new_body
       expect(updated_spost.price).to eq new_price
     end
 
     it "redirects to the updated sponsored post" do
       new_title = RandomData.random_sentence
       new_body = RandomData.random_paragraph
       new_price = 14
 
       put :update, topic_id: my_topic.id, id: my_spost.id, spost: {title: new_title, body: new_body, price: new_price}
       expect(response).to redirect_to [my_topic, my_spost]
     end
   end
   
  describe "DELETE destroy" do
     it "deletes the sponsored post" do
       delete :destroy, topic_id: my_topic.id, id: my_spost.id
       count = Sponsoredpost.where({id: my_spost.id}).size
       expect(count).to eq 0
     end
 
     it "redirects to topic show" do
       delete :destroy, topic_id: my_topic.id, id: my_spost.id
       expect(response).to redirect_to my_topic
     end
  end
end