require 'spec_helper'

describe LineItem do
  before :each do
    @order = Factory(:order)
    @variant = Factory(:variant, :price => 10)
    @variant.volume_prices.create! :amount => 9, :range => '(2+)'
    @order.add_variant(@variant, 1)
    @line_item = @order.line_items.first
  end

  it 'should update the line item price when the quantity changes to match a range' do
    @line_item.price.to_f.should == 10.00
    @order.add_variant(@variant, 1)
    @line_item.price.to_f.should == 9.00
  end
end

