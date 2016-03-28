require 'rails_helper'

RSpec.describe Sponsoredpost, type: :model do
    let(:topic) {Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
    let (:spost) {topic.sponsoredposts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 10)}
    
    describe "attributes" do
        it "responds to title" do
            expect(spost).to respond_to(:title)
        end
        it "responds to body" do
            expect(spost).to respond_to(:body)
        end
        it "responds to price" do
            expect(spost).to respond_to(:price)
        end
    end
    
    it "belongs to topic" do
        is_expected.to belong_to(:topic)
    end
end
