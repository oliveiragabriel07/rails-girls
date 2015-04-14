FactoryGirl.define do
  factory :user do
    first_name "João"
    sequence(:last_name) { |i| "Ninguém#{i}" }
    email { I18n.transliterate("#{first_name}.#{last_name}@example.com".downcase) }
    password "123mudar"

    factory :user_with_ideas do
      transient { ideas_count 3 }

      after(:create) do |user, evaluator|
        create_list(:idea, evaluator.ideas_count, user: user)
      end
    end
  end
end