require 'spec_helper'

describe Spree::Order do
  before(:each) do
    @order = FactoryGirl.create(:order)
    @variant = FactoryGirl.create(:variant, :price => 10)

    @variant_with_prices = FactoryGirl.create(:variant, :price => 10)
    @variant_with_prices.volume_prices << FactoryGirl.create(:volume_price, :range => '(1..5)', :amount => 9)
    @variant_with_prices.volume_prices << FactoryGirl.create(:volume_price, :range => '(5..9)', :amount => 8)
  end

  describe "add_variant" do
    it "should use the variant price if there are no volume prices" do
      @order.contents.add(@variant)
      @order.line_items.first.price.should == 10
    end

    it "should use the volume price if quantity falls within a quantity range of a volume price" do
      @variant.volume_prices << FactoryGirl.create(:volume_price, :range => '(5..10)', :amount => 9)
      @order.contents.add(@variant_with_prices, 7)
      @order.line_items.first.price.should == 8
    end

    it "should use the variant price if the quantity fails to satisfy any of the volume price ranges" do
      @order.contents.add(@variant, 10)
      @order.line_items.first.price.should == 10
    end

    it "should use the first matching volume price in the event of more then one matching volume prices" do
      @order.contents.add(@variant_with_prices, 5)
      @order.line_items.first.price.should == 9
    end
  end
end
