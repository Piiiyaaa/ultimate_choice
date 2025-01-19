FactoryBot.define do
  factory :question do
    user { nil }
    choice_one { "MyString" }
    choice_two { "MyString" }
  end
end
