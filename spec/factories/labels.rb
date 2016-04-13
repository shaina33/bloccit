FactoryGirl.define do
    factory :label do
        name {RandomData.random_word}
        
        factory :label_t do
            topic
        end
        factory :label_p do
            post
        end
    end
end