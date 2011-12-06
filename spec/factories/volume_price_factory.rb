FactoryGirl.define do
  factory :volume_price, :class => Spree::VolumePrice do
    amount 10
    range '(1..5)'
    association :variant
  end
end

