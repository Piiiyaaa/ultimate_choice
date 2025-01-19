FactoryBot.define do
  factory :answer do
    user { nil }
    question { nil }
    choice { "MyString" }
  end
end
