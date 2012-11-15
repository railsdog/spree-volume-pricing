FactoryGirl.define do
  factory :volume_price, :class => Spree::VolumePrice do
    amount 10
    discount_type 'price'
    range '(1..5)'
    association :variant
  end
end

