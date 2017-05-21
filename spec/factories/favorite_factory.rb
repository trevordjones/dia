FactoryGirl.define do
  factory :favorite do
    yelp_id { Faker::Company.name.downcase.tr(' ', '-') }
  end
end
