require 'spec_helper'

describe Spree::Admin::VariantsController do
  stub_authorization!

  describe "PUT #update" do
    it "creates a volume price" do
      variant = FactoryGirl.create :variant

      expect do
        spree_put :update,
          :product_id => variant.product.permalink,
          :id => variant.id,
          :variant => {
            "volume_prices_attributes" => {
              "1335830259720" => {
                "name"=>"5-10",
                "range"=>"5..10",
                "amount"=>"90",
                "position"=>"1",
                "_destroy"=>"false"
              }
            }
          }
      end.to change(variant.volume_prices, :count).by(1)
    end
  end
end
