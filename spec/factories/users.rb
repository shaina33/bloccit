FactoryGirl.define do
    pw = RandomData.random_sentence
    sequence(:email) {|n| "user#{n}@factory.com"}
    factory :user do
        name {RandomData.random_name}
        email { generate(:email) }
        password pw
        password_confirmation pw
        role :member
    end
end