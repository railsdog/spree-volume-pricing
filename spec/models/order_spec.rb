require File.dirname(__FILE__) + '/../spec_helper'

describe Order do
  before(:each) do
    @order = Order.new
    @variant = Variant.new(:price => 10)
  end

  describe "add_variant" do
    it "should use the variant price if there are no volume prices" do
      @order.add_variant(@variant, 100)
      @order.line_items.first.price.should == 10
    end
    it "should use the volume price if quantity falls within a quantity range of a volume price" do
      @variant.volume_prices << mock_model(VolumePrice, :include? => true, :amount => 9)
      @order.add_variant(@variant)
      @order.line_items.first.price.should == 9
    end
    it "should use the variant price if the quantity fails to satisfy any of the volume price ranges" do
      @variant.volume_prices << mock_model(VolumePrice, :include? => false)
      @variant.volume_prices << mock_model(VolumePrice, :include? => false)
      @order.add_variant(@variant)
      @order.line_items.first.price.should == 10
    end
    it "should use the first matching volume price in the event of more then one matching volume prices" do
      @variant.volume_prices << mock_model(VolumePrice, :include? => true, :amount => 9)
      @variant.volume_prices << mock_model(VolumePrice, :include? => true, :amount => 8)
      @order.add_variant(@variant)
      @order.line_items.first.price.should == 9
    end
  end
end