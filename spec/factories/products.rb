FactoryGirl.define do
  factory :product do
    sequence(:title) { |n| "Product #{n + 1}" }
    description 'A good product'
    image_url 'http://test.com/whatever.jpg'
    price 5.00
  end
end
