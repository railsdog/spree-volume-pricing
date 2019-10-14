RSpec.describe Spree::LineItem, type: :model do
  before do
    @order = create(:order)
    @variant = create(:variant, price: 10)
    @variant.volume_prices.create! amount: 9, discount_type: 'price', range: '(2+)'
    add_variant_to_order
    @line_item = @order.line_items.first
    @role = create(:role)
  end

  it 'updates the line item price when the quantity changes to match a range and has no role' do
    expect(@line_item.price.to_f).to be(10.00)
    add_variant_to_order
    expect(@order.line_items.first.price.to_f).to be(9.00)
  end

  it 'updates the line item price when the quantity changes to match a range and role matches' do
    @order.user.spree_roles << @role
    Spree::Config.volume_pricing_role = @role.name
    expect(@order.user.has_spree_role? @role.name.to_sym).to eq(true)
    @variant.volume_prices.first.update(role_id: @role.id)
    expect(@line_item.price.to_f).to eq(10.00)
    add_variant_to_order
    expect(@order.line_items.first.price.to_f).to eq(9.00)
  end

  it 'does not update the line item price when the variant role and order role don`t match' do
    expect(@order.user.has_spree_role? @role.name.to_sym).to be(false)
    @variant.volume_prices.first.update(role_id: @role.id)
    expect(@line_item.price.to_f).to be(10.00)
    add_variant_to_order
    expect(@order.line_items.first.price.to_f).to be(10.00)
  end

  def add_variant_to_order
    if Spree.version.to_f < 4.0
      @order.contents.add(@variant, 1)
    else
      Spree::Cart::AddItem.call(order: @order, variant: @variant, quantity: 1)
    end
  end
end
