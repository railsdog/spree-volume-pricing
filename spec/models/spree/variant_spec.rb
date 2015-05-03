RSpec.describe Spree::Variant, type: :model do
  it { is_expected.to have_many(:volume_prices) }

  describe '#volume_price' do

    context 'discount_type = price' do
      before do
        @variant = create :variant, price: 10
        @variant.volume_prices.create! amount: 9, discount_type: 'price', range: '(10+)'
      end

      it 'uses the variants price when it does not match a range' do
        expect(@variant.volume_price(1).to_f).to be(10.00)
      end

      it 'uses the volume price when it does match a range' do
        expect(@variant.volume_price(10).to_f).to be(9.00)
      end

      it 'gives percent of earning' do
        expect(@variant.volume_price_earning_percent(10)).to be(10)
      end

      it 'gives zero percent earning if doesnt match' do
        expect(@variant.volume_price_earning_percent(1)).to be(0)
      end

      it 'gives amount earning' do
        expect(@variant.volume_price_earning_amount(10)).to eq(1)
      end

      it 'gives zero earning amount if doesnt match' do
        expect(@variant.volume_price_earning_amount(1)).to eq(0)
      end
    end

    context 'discount_type = dollar' do
      before do
        @variant = create :variant, price: 10
        @variant.volume_prices.create! amount: 1, discount_type: 'dollar', range: '(10+)'
      end

      it 'uses the variants price when it does not match a range' do
        expect(@variant.volume_price(1).to_f).to be(10.00)
      end

      it 'uses the volume price when it does match a range' do
        expect(@variant.volume_price(10).to_f).to be(9.00)
      end

      it 'gives percent of earning' do
        expect(@variant.volume_price_earning_percent(10)).to be(10)
      end

      it 'gives zero percent earning if doesnt match' do
        expect(@variant.volume_price_earning_percent(1)).to be(0)
      end

      it 'gives amount earning' do
        expect(@variant.volume_price_earning_amount(10)).to eq(1)
      end

      it 'gives zero earning amount if doesnt match' do
        expect(@variant.volume_price_earning_amount(1)).to eq(0)
      end
    end

    context 'discount_type = percent' do
      before do
        @variant = create :variant, price: 10
        @variant.volume_prices.create! amount: 0.1, discount_type: 'percent', range: '(10+)'
      end

      it 'uses the variants price when it does not match a range' do
        expect(@variant.volume_price(1).to_f).to be(10.00)
      end

      it 'uses the volume price when it does match a range' do
        expect(@variant.volume_price(10).to_f).to be(9.00)
      end

      it 'gives percent of earning' do
        expect(@variant.volume_price_earning_percent(10)).to be(10)
        @variant_five = create :variant, price: 10
        @variant_five.volume_prices.create! amount: 0.5, discount_type: 'percent', range: '(1+)'
        expect(@variant_five.volume_price_earning_percent(1)).to be(50)
      end

      it 'gives zero percent earning if doesnt match' do
        expect(@variant.volume_price_earning_percent(1)).to be(0)
      end

      it 'gives amount earning' do
        expect(@variant.volume_price_earning_amount(10)).to eq(1)
        @variant_five = create :variant, price: 10
        @variant_five.volume_prices.create! amount: 0.5, discount_type: 'percent', range: '(1+)'
        expect(@variant_five.volume_price_earning_amount(1)).to eq(5)
      end

      it 'gives zero earning amount if doesnt match' do
        expect(@variant.volume_price_earning_amount(1)).to eq(0)
      end
    end
  end
end
