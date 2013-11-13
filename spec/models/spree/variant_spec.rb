require 'spec_helper'

describe Spree::Variant do
  it { should have_many(:volume_prices) }

  describe '#volume_price' do

    context 'discount_type = price' do
      before :each do
        @variant = FactoryGirl.create :variant, :price => 10
        @variant.volume_prices.create! :amount => 9, :discount_type => 'price', :range => '(10+)'
      end

      it 'should use the variants price when it does not match a range' do
        @variant.volume_price(1).to_f.should == 10.00
      end

      it 'should use the volume price when it does match a range' do
        @variant.volume_price(10).to_f.should == 9.00
      end

      it 'it should give percent of earning' do
        @variant.volume_price_earning_percent(10).should == 10
      end

      it 'should give zero percent earning if doesnt match' do
        @variant.volume_price_earning_percent(1).should == 0
      end

      it 'should give amount earning' do 
        @variant.volume_price_earning_amount(10).should == 1
      end

      it 'should give zero earning amount if doesnt match' do
        @variant.volume_price_earning_amount(1).should == 0
      end
    end

    context 'discount_type = dollar' do
      before :each do
        @variant = FactoryGirl.create :variant, :price => 10
        @variant.volume_prices.create! :amount => 1, :discount_type => 'dollar', :range => '(10+)'
      end

      it 'should use the variants price when it does not match a range' do
        @variant.volume_price(1).to_f.should == 10.00
      end

      it 'should use the volume price when it does match a range' do
        @variant.volume_price(10).to_f.should == 9.00
      end

      it 'it should give percent of earning' do
        @variant.volume_price_earning_percent(10).should == 10
      end

      it 'should give zero percent earning if doesnt match' do
        @variant.volume_price_earning_percent(1).should == 0
      end

      it 'should give amount earning' do 
        @variant.volume_price_earning_amount(10).should == 1
      end

      it 'should give zero earning amount if doesnt match' do
        @variant.volume_price_earning_amount(1).should == 0
      end
    end

    context 'discount_type = percent' do
      before :each do
        @variant = FactoryGirl.create :variant, :price => 10
        @variant.volume_prices.create! :amount => 0.1, :discount_type => 'percent', :range => '(10+)'
      end

      it 'should use the variants price when it does not match a range' do
        @variant.volume_price(1).to_f.should == 10.00
      end

      it 'should use the volume price when it does match a range' do
        @variant.volume_price(10).to_f.should == 9.00
      end

      it 'should give percent of earning' do
        @variant.volume_price_earning_percent(10).should == 10
        @variant_five = FactoryGirl.create :variant, :price => 10
        @variant_five.volume_prices.create! :amount => 0.5, :discount_type => 'percent', :range => '(1+)'
        @variant_five.volume_price_earning_percent(1).should == 50
      end

      it 'should give zero percent earning if doesnt match' do
        @variant.volume_price_earning_percent(1).should == 0
      end

      it 'should give amount earning' do 
        @variant.volume_price_earning_amount(10).should == 1
        @variant_five = FactoryGirl.create :variant, :price => 10
        @variant_five.volume_prices.create! :amount => 0.5, :discount_type => 'percent', :range => '(1+)'
        @variant_five.volume_price_earning_amount(1).should == 5
      end

      it 'should give zero earning amount if doesnt match' do
        @variant.volume_price_earning_amount(1).should == 0
      end

    end

  end
end
