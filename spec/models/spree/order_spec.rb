require 'spec_helper'

describe Spree::Order do
  before(:each) do
    @order = Factory(:order)
    @variant = Factory(:variant, :price => 10)

    @variant_with_prices = Factory(:variant, :price => 10)
    @variant_with_prices.volume_prices << Factory(:volume_price, :range => '(1..5)', :amount => 9)
    @variant_with_prices.volume_prices << Factory(:volume_price, :range => '(5..9)', :amount => 8)
  end

  describe "add_variant" do
    it "should use the variant price if there are no volume prices" do
      @order.add_variant(@variant)
      @order.line_items.first.price.should == 10
    end
    it "should use the volume price if quantity falls within a quantity range of a volume price" do
      @variant.volume_prices << Factory(:volume_price, :range => '(5..10)', :amount => 9)
      @order.add_variant(@variant_with_prices, 7)
      @order.line_items.first.price.should == 8
    end
    it "should use the variant price if the quantity fails to satisfy any of the volume price ranges" do
      @order.add_variant(@variant, 10)
      @order.line_items.first.price.should == 10
    end
    it "should use the first matching volume price in the event of more then one matching volume prices" do
      @order.add_variant(@variant_with_prices, 5)
      @order.line_items.first.price.should == 9
    end
  end
end
