require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:my_q) {Question.create!(title: RandomData.random_question, body: RandomData.random_paragraph, resolved: RandomData.random_resolve)}

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "assigns [my_q] to @questions" do
       get :index
       expect(assigns(:questions)).to eq([my_q])
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, {id: my_q.id}
      expect(response).to have_http_status(:success)
    end
    it "assigns my_q to @question" do
      get :show, {id: my_q.id}
      expect(assigns(:question)).to eq(my_q)
    end
    it "renders the #show view" do
      get :show, {id: my_q.id}
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    it "instantiates @question" do
      get :new
      expect(assigns(:question)).not_to be_nil
    end
    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end
  end
  
  describe "POST #create" do
      it "increases the number of Question by 1" do
        expect{post :create, question: {title: RandomData.random_question, body: RandomData.random_paragraph, resolved: RandomData.random_resolve}}.to change(Question,:count).by(1)
      end

      it "assigns the new question to @question" do
        post :create, question: {title: RandomData.random_question, body: RandomData.random_paragraph, resolved: RandomData.random_resolve}
        expect(assigns(:question)).to eq Question.last
      end
  
      it "redirects to the new question" do
        post :create, question: {title: RandomData.random_question, body: RandomData.random_paragraph, resolved: RandomData.random_resolve}
        expect(response).to redirect_to Question.last
      end
  end  

  describe "GET #edit" do
    it "returns http success" do
      get :edit, {id: my_q.id}
      expect(response).to have_http_status(:success)
    end
  
    it "renders the #edit view" do
     get :edit, {id: my_q.id}
     expect(response).to render_template :edit
    end

    it "assigns post to be updated to @question" do
     get :edit, {id: my_q.id}

     q_instance = assigns(:question)

     expect(q_instance.id).to eq my_q.id
     expect(q_instance.title).to eq my_q.title
     expect(q_instance.body).to eq my_q.body
    end
  end
  
  describe "PUT #update" do
     it "updates post with expected attributes" do
       new_title = RandomData.random_question
       new_body = RandomData.random_paragraph
       new_resolved = RandomData.random_resolve
 
       put :update, id: my_q.id, question: {title: new_title, body: new_body, resolved: new_resolved}
 
       updated_q = assigns(:question)
       expect(updated_q.id).to eq my_q.id
       expect(updated_q.title).to eq new_title
       expect(updated_q.body).to eq new_body
       expect(updated_q.resolved).to eq new_resolved
     end
 
     it "redirects to the updated post" do
       new_title = RandomData.random_question
       new_body = RandomData.random_paragraph
       new_resolved = RandomData.random_resolve
 
       put :update, id: my_q.id, question: {title: new_title, body: new_body, resolved: new_resolved}
       expect(response).to redirect_to my_q
     end
   end
  
  describe "DELETE #destroy" do
     it "deletes the question" do
       delete :destroy, {id: my_q.id}
       count = Question.where({id: my_q.id}).size
       expect(count).to eq 0
     end
 
     it "redirects to posts index" do
       delete :destroy, {id: my_q.id}
       expect(response).to redirect_to questions_path
     end
  end  
  
end
