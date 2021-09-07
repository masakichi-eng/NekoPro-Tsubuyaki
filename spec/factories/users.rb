FactoryBot.define do
  factory :user do
    nickname { 'sample' }
    email { 'sample00@sample.com' }
    password { 'sample00' }
    password_confirmation { 'sample00' }
  end
end
