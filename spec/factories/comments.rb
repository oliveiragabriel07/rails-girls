FactoryGirl.define do
  factory :comment do
    body "Conteúdo da mensagem"
    idea
    user
  end
end