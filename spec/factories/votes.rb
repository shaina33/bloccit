FactoryGirl.define do
    factory :vote do
        user
        post
        value {[-1,1].sample}
    end
end