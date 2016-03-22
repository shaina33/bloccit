require 'rails_helper'

RSpec.describe AdvertisementsController, type: :controller do
  let(:my_adv) {Advertisement.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(1..50)) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "assigns [my_adv] to @advertisements" do
       get :index
       expect(assigns(:advertisements)).to eq([my_adv])
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, {id: my_adv.id}
      expect(response).to have_http_status(:success)
    end
    it "assigns my_adv to @advertisement" do
      get :show, {id: my_adv.id}
      expect(assigns(:advertisement)).to eq(my_adv)
    end
    it "renders the #show view" do
      get :show, {id: my_adv.id}
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    it "instantiates @advertisement" do
      get :new
      expect(assigns(:advertisement)).not_to be_nil
    end
    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST create" do
    it "assigns the new post to @advertisement" do
      post :create, advertisement: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(1..50) }
      expect(assigns(:advertisement)).to eq Advertisement.last
    end
      
    it "redirects to the new advertisement" do
      post :create, advertisement: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(1..50) }
      expect(response).to redirect_to Advertisement.last
    end
  end

end
