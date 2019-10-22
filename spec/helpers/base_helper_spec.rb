RSpec.describe Spree::BaseHelper, type: :helper do
  include SpreeVolumePricing::BaseHelper

  context 'volume pricing' do
    before do
      @variant = create :variant, price: 10
      @variant.volume_prices.create! amount: 1, discount_type: 'dollar', range: '(10+)'
    end

    it 'gives discounted price' do
      expect(display_volume_price(@variant, 10)).to eq '$9.00'
    end

    it 'gives discount percent' do
      expect(display_volume_price_earning_percent(@variant, 10)).to eq '10'
    end

    it 'gives discount amount' do
      expect(display_volume_price_earning_amount(@variant, 10)).to eq '$1.00'
    end
  end
end
