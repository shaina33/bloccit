FactoryGirl.define do
    factory :comment do
        body RandomData.random_sentence
        user
        
        factory :comment_t do
            topic
        end
        factory :comment_p do
            post
        end
    end
end