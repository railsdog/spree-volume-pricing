require 'spec_helper'

describe Spree::Admin::VariantsController do
  let(:user) { mock_model Spree::User }
  before do
    controller.stub :current_user => user
    user.stub :has_role? => true
  end

  it 'needs request specs' do
    pending
  end
end
