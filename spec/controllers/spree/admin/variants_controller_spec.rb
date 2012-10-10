require 'spec_helper'

describe Spree::Admin::VariantsController do
  let(:user) { FactoryGirl.create :user }
  before do
    controller.stub :spree_current_user => user
    user.stub :has_role? => true
    controller.stub :admin_variants_url => "/"
  end

  describe "PUT #update" do
    it "creates a volume price" do
      variant = FactoryGirl.create :variant

      lambda do
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
      end.should change(variant.volume_prices, :count).by(1)
    end
  end
end
