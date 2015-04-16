FactoryGirl.define do
  factory :like do
    association :likeable, factory: :idea
    user
  end
end

