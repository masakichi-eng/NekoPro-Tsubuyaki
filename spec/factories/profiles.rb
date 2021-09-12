FactoryBot.define do
  factory :profile do
    last_name { "サン" }
    first_name { "プル" }
    last_name_kana { "サン" }
    first_name_kana { "プル" }
    birth_date { "1999-01-01" }
  end
end
