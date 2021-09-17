FactoryBot.define do
  factory :comment do
    comment {'test comment'}

    association :user
    association :post
  end
end
