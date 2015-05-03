RSpec.describe Spree::LineItem, type: :model do
  before do
    @order = create(:order)
    @variant = create(:variant, price: 10)
    @variant.volume_prices.create! amount: 9, discount_type: 'price', range: '(2+)'
    @order.contents.add(@variant, 1)
    @line_item = @order.line_items.first
  end

  it 'updates the line item price when the quantity changes to match a range' do
    expect(@line_item.price.to_f).to be(10.00)
    @order.contents.add(@variant, 1)
    expect(@order.line_items.first.price.to_f).to be(9.00)
  end
end
