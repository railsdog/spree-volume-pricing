RSpec.describe Spree::Order, type: :model do
  before do
    @order = create(:order)
    @variant = create(:variant, price: 10)

    @variant_with_prices = create(:variant, price: 10)
    @variant_with_prices.volume_prices << create(:volume_price, range: '1..5', amount: 9, position: 2)
    @variant_with_prices.volume_prices << create(:volume_price, range: '(5..9)', amount: 8, position: 1)
  end

  context 'add_variant' do
    it 'uses the variant price if there are no volume prices' do
      add_variant_to_order(@variant, nil)
      expect(@order.line_items.first.price).to eq(10)
    end

    it 'uses the volume price if quantity falls within a quantity range of a volume price' do
      @variant.volume_prices << create(:volume_price, range: '(5..10)', amount: 9)
      add_variant_to_order(@variant_with_prices, 7)
      expect(@order.line_items.first.price).to eq(8)
    end

    it 'uses the variant price if the quantity fails to satisfy any of the volume price ranges' do
      add_variant_to_order(@variant, 10)
      expect(@order.line_items.first.price).to eq(10)
    end

    it 'uses the first matching volume price in the event of more then one matching volume prices' do
      add_variant_to_order(@variant_with_prices, 5)
      expect(@order.line_items.first.price).to eq(8)
    end

    it 'uses the master variant volume price in case variant has no volume price if config is true' do
      Spree::Config.use_master_variant_volume_pricing = true
      @master = @variant.product.master
      @master.volume_prices << create(:volume_price, range: '(1..5)', amount: 9, position: 2)
      add_variant_to_order(@variant, 5)
      expect(@order.line_items.first.price).to eq(9)
    end

    it 'doesnt use the master variant volume price in case variant has no volume price if config is false' do
      Spree::Config.use_master_variant_volume_pricing = false
      @master = @variant.product.master
      @master.volume_prices << create(:volume_price, range: '(1..5)', amount: 9, position: 2)
      add_variant_to_order(@variant, 5)
      expect(@order.line_items.first.price).to eq(10)
    end
  end

  def add_variant_to_order(variant, quantity)
    if quantity
      if Spree.version.to_f < 4.0
        @order.contents.add(variant, quantity)
      else
        Spree::Cart::AddItem.call(order: @order, variant: variant, quantity: quantity)
      end
    else
      if Spree.version.to_f < 4.0
        @order.contents.add(variant)
      else
        Spree::Cart::AddItem.call(order: @order, variant: variant)
      end
    end
  end
end
