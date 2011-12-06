require 'spec_helper'

describe Spree::Admin::VariantsController do
  let(:user) { mock_model Spree::User }
  before do
    controller.stub :current_user => user
    user.stub :has_role? => true
  end

  context "#update" do
    it "should fire the before filter" do
      variant = Factory(:variant)

      controller.should_receive(:before_update)

      put :update, {:product_id=>variant.product.permalink, :id => variant.id,:variant => variant.attributes}
    end
  end
end
