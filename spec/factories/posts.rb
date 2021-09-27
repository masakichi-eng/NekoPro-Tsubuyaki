FactoryBot.define do
  factory :post do
    description {'test'}

    association :user
    
    after(:build) do |post|
      post.photo.attach(io: File.open('public/images/text_image_300×300.png'), filename: 'text_image_300×300.png')
    end
  end
end
