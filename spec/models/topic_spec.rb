require 'rails_helper'

RSpec.describe Topic, type: :model do
let(:topic) {create(:topic)}
 
   describe "attributes" do
     it "responds to name" do
       expect(topic).to respond_to(:name)
     end
 
     it "responds to description" do
       expect(topic).to respond_to(:description)
     end
 
     it "responds to public" do
       expect(topic).to respond_to(:public)
     end
 
     it "is public by default" do
       expect(topic.public).to be(true)
     end
     
     it { is_expected.to validate_presence_of(:name) }
     it { is_expected.to validate_length_of(:name) }
     it { is_expected.to validate_presence_of(:description) }
     it { is_expected.to validate_length_of(:description) }

   end
   
    describe "relationships" do 
        it { is_expected.to have_many(:posts) }
        it { is_expected.to have_many(:sponsoredposts) }
        it { is_expected.to have_many(:labelings) }
        it { is_expected.to have_many(:labels).through(:labelings) }
    end

end
