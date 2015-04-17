FactoryGirl.define do
  factory :admin do
    sequence(:email) {|i| "admin#{i}@example.com" }
    password "123mudar"
  end

end
