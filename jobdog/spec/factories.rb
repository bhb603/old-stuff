FactoryGirl.define do
  factory :user do
    email "a@b.co"
    password "1234"
  end
  
  factory :job do
    title "Tets job"
    association :user, factory: :user
  end
  
end