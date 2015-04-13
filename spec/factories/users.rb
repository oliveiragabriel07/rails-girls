FactoryGirl.define do
  factory :user do
    first_name "João"
    sequence(:last_name) { |i| "Ninguém#{i}" }
    email { I18n.transliterate("#{first_name}.#{last_name}@example.com".downcase) }
    password "123mudar"
  end
end