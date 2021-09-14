FactoryBot.define do
  factory :post do
    description {'test'}
    # user_id {1}

    association :user
    
    after(:build) do |post|
      post.photo.attach(io: File.open('public/images/text_image_300×300.png'), filename: 'text_image_300×300.png')
    end
  end
end
