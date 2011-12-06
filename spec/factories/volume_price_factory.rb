FactoryGirl.define do
  factory :volume_price do
    amount 10
    range '(1..5)'
    association :variant
  end
end

