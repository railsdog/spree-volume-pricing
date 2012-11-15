require 'spec_helper'

describe Spree::Variant do
  it { should have_many(:volume_prices) }

  describe '#volume_price' do

    context 'discount_type = price' do
      before :each do
        @variant = Factory :variant, :price => 10
        @variant.volume_prices.create! :amount => 9, :discount_type => 'price', :range => '(10+)'
      end

      it 'should use the variants price when it does not match a range' do
        @variant.volume_price(1).to_f.should == 10.00
      end

      it 'should use the volume price when it does match a range' do
        @variant.volume_price(10).to_f.should == 9.00
      end
    end

    context 'discount_type = dollar' do
      before :each do
        @variant = Factory :variant, :price => 10
        @variant.volume_prices.create! :amount => 1, :discount_type => 'dollar', :range => '(10+)'
      end

      it 'should use the variants price when it does not match a range' do
        @variant.volume_price(1).to_f.should == 10.00
      end

      it 'should use the volume price when it does match a range' do
        @variant.volume_price(10).to_f.should == 9.00
      end
    end

    context 'discount_type = percent' do
      before :each do
        @variant = Factory :variant, :price => 10
        @variant.volume_prices.create! :amount => 0.1, :discount_type => 'percent', :range => '(10+)'
      end

      it 'should use the variants price when it does not match a range' do
        @variant.volume_price(1).to_f.should == 10.00
      end

      it 'should use the volume price when it does match a range' do
        @variant.volume_price(10).to_f.should == 9.00
      end
    end

  end
end
