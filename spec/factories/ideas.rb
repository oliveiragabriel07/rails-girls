FactoryGirl.define do
  factory :idea do
    name "My Idea"
    description "Idea description"
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/support/ideas/pictures', 'idea_lamp.png')) }
    user

    factory :idea_with_comments do
      transient { comments_count 3 }

      after(:create) do |idea, evaluator|
        create_list(:comment, evaluator.comments_count, idea: idea)
      end
    end
  end
end