FactoryGirl.define do
  factory :like do
    user
    # object_id nil
    # object_type nil
    # object
    association :likeable, factory: :idea

    # factory :like_for_idea do
    #   # object, factory: :idea
    #   association :likeable, factory: :idea
    # end
  end
end