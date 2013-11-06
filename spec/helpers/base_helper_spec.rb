require 'spec_helper'

describe Spree::BaseHelper do
  include Spree::BaseHelper

  context "volume pricing" do

    before :each do
      @variant = FactoryGirl.create :variant, :price => 10
      @variant.volume_prices.create! :amount => 1, :discount_type => 'dollar', :range => '(10+)'
    end
    
    it "should give discounted price" do
      expect(display_volume_price(@variant, 10)).to eq "$9.00"
    end

    it "should give discount percent" do
      expect(display_volume_price_earning_percent(@variant, 10)).to eq "10"
    end

    it "should give discount amount" do
      expect(display_volume_price_earning_amount(@variant, 10)).to eq "$1.00"
    end
  end
end