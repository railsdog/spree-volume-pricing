RSpec.describe Spree::Admin::VariantsController, type: :controller do
  stub_authorization!

  context 'PUT #update' do
    it 'creates a volume price' do
      variant = create :variant

      expect do
        spree_put :update,
                  product_id: variant.product.slug,
                  id: variant.id,
                  variant: {
                    'volume_prices_attributes' => {
                      '1335830259720' => {
                        'name' => '5-10',
                        'discount_type' => 'price',
                        'range' => '5..10',
                        'amount' => '90',
                        'position' => '1',
                        '_destroy' => 'false'
                      }
                    }
                  }
      end.to change(variant.volume_prices, :count).by(1)
    end
  end
end
