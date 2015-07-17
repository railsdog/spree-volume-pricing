RSpec.describe Spree::Variant, type: :model do
  it { is_expected.to have_many(:volume_prices) }

  describe '#volume_price' do

    context 'discount_type = price' do
      before :each do
        @variant = create :variant, price: 10
        @variant.volume_prices.create! amount: 9, discount_type: 'price', range: '(10+)'
        @role = create(:role)
        @user = create(:user)
      end

      it 'uses the variants price when it does not match a range' do
        expect(@variant.volume_price(1).to_f).to be(10.00)
      end

      it 'uses the variants price when it does not match role with null role' do
        @variant.volume_prices.first.update(role_id: @role.id)
        expect(@variant.volume_price(10).to_f).to be(10.00)
      end

      it 'uses the variants price when it does not match roles' do
        other_role = create(:role)
        @user.spree_roles << other_role
        @variant.volume_prices.first.update(role_id: @role.id)
        expect(@variant.volume_price(10, @user).to_f).to be(10.00)
      end

      it 'uses the volume price when it does match a range' do
        expect(@variant.volume_price(10).to_f).to be(9.00)
      end

      it 'uses the volume price when it does match a range and role' do
        @user.spree_roles << @role
        Spree::Config.volume_pricing_role = @role.name
        @variant.volume_prices.first.update(role_id: @role.id)
        expect(@variant.volume_price(10, @user).to_f).to be(9.00)
      end

      it 'uses the volume price when it does match from a volume price model' do
        @variant.volume_price_models << create(:volume_price_model)
        @variant.volume_price_models.first.volume_prices.create!(amount: 5, discount_type: 'price', range: '(5+)')
        expect(@variant.volume_price(6).to_f).to be(5.00)
      end

      it 'gives percent of earning without role' do
        expect(@variant.volume_price_earning_percent(10)).to be(10)
      end

      it 'gives percent of earning if role matches' do
        @user.spree_roles << @role
        Spree::Config.volume_pricing_role = @role.name
        @variant.volume_prices.first.update(role_id: @role.id)
        expect(@variant.volume_price_earning_percent(10, @user)).to be(10)
      end

      it 'gives zero percent earning if doesnt match' do
        expect(@variant.volume_price_earning_percent(1)).to be(0)
      end

      it 'gives zero percent earning if role doesnt match with null' do
        @variant.volume_prices.first.update(role_id: @role.id)
        expect(@variant.volume_price_earning_percent(10)).to be(0)
      end

      it 'gives zero percent earning if role doesnt match' do
        other_role = create(:role)
        @user.spree_roles << other_role
        @variant.volume_prices.first.update(role_id: @role.id)
        expect(@variant.volume_price_earning_percent(10, @user)).to be(0)
      end

      it 'gives amount earning without role' do
        expect(@variant.volume_price_earning_amount(10)).to eq(1)
      end

      it 'gives amount earning if role matches' do
        @user.spree_roles << @role
        Spree::Config.volume_pricing_role = @role.name
        @variant.volume_prices.first.update(role_id: @role.id)
        expect(@variant.volume_price_earning_amount(10, @user)).to eq(1)
      end

      it 'gives zero earning amount if doesnt match' do
        expect(@variant.volume_price_earning_amount(1)).to eq(0)
      end

      it 'gives zero earning amount if role doesnt match with null' do
        @variant.volume_prices.first.update(role_id: @role.id)
        expect(@variant.volume_price_earning_amount(10)).to be(0)
      end

      it 'gives zero earning amount if role doesnt match' do
        other_role = create(:role)
        @user.spree_roles << other_role
        @variant.volume_prices.first.update(role_id: @role.id)
        expect(@variant.volume_price_earning_amount(10, @user)).to be(0)
      end
    end

    context 'discount_type = dollar' do
      before :each do
        @variant = create :variant, price: 10
        @variant.volume_prices.create! amount: 1, discount_type: 'dollar', range: '(10+)'
        @role = create(:role)
        @user = create(:user)
      end

      it 'uses the variants price when it does not match a range' do
        expect(@variant.volume_price(1).to_f).to be(10.00)
      end

      it 'uses the variants price when it does not match role with null role' do
        @variant.volume_prices.first.update(role_id: @role.id)
        expect(@variant.volume_price(10).to_f).to be(10.00)
      end

      it 'uses the variants price when it does not match roles' do
        other_role = create(:role)
        @user.spree_roles << other_role
        @variant.volume_prices.first.update(role_id: @role.id)
        expect(@variant.volume_price(10, @user).to_f).to be(10.00)
      end

      it 'uses the volume price when it does match a range' do
        expect(@variant.volume_price(10).to_f).to be(9.00)
      end

      it 'uses the volume price when it does match a range and role' do
        @user.spree_roles << @role
        Spree::Config.volume_pricing_role = @role.name
        @variant.volume_prices.first.update(role_id: @role.id)
        expect(@variant.volume_price(10, @user).to_f).to be(9.00)
      end

      it 'uses the volume price when it does match from a volume price model' do
        @variant.volume_price_models << create(:volume_price_model)
        @variant.volume_price_models.first.volume_prices.create!(amount: 5, discount_type: 'dollar', range: '(5+)')
        expect(@variant.volume_price(6).to_f).to be(5.00)
      end

      it 'gives percent of earning without role' do
        expect(@variant.volume_price_earning_percent(10)).to be(10)
      end

      it 'gives percent of earning if role matches' do
        @user.spree_roles << @role
        Spree::Config.volume_pricing_role = @role.name
        @variant.volume_prices.first.update(role_id: @role.id)
        expect(@variant.volume_price_earning_percent(10, @user)).to be(10)
      end

      it 'gives zero percent earning if doesnt match' do
        expect(@variant.volume_price_earning_percent(1)).to be(0)
      end

      it 'gives zero percent earning if role doesnt match with null' do
        @variant.volume_prices.first.update(role_id: @role.id)
        expect(@variant.volume_price_earning_percent(10)).to be(0)
      end

      it 'gives zero percent earning if role doesnt match' do
        other_role = create(:role)
        @user.spree_roles << other_role
        @variant.volume_prices.first.update(role_id: @role.id)
        expect(@variant.volume_price_earning_percent(10, @user)).to be(0)
      end

      it 'gives amount earning without role' do
        expect(@variant.volume_price_earning_amount(10)).to eq(1)
      end

      it 'gives amount earning if role matches' do
        @user.spree_roles << @role
        Spree::Config.volume_pricing_role = @role.name
        @variant.volume_prices.first.update(role_id: @role.id)
        expect(@variant.volume_price_earning_amount(10, @user)).to eq(1)
      end

      it 'gives zero earning amount if doesnt match' do
        expect(@variant.volume_price_earning_amount(1)).to eq(0)
      end

      it 'gives zero earning amount if role doesnt match with null' do
        @variant.volume_prices.first.update(role_id: @role.id)
        expect(@variant.volume_price_earning_amount(10)).to be(0)
      end

      it 'gives zero earning amount if role doesnt match' do
        other_role = create(:role)
        @user.spree_roles << other_role
        @variant.volume_prices.first.update(role_id: @role.id)
        expect(@variant.volume_price_earning_amount(10, @user)).to be(0)
      end
    end

    context 'discount_type = percent' do
      before :each do
        @variant = create :variant, price: 10
        @variant.volume_prices.create! amount: 0.1, discount_type: 'percent', range: '(10+)'
        @role = create(:role)
        @user = create(:user)
      end

      it 'uses the variants price when it does not match a range' do
        expect(@variant.volume_price(1).to_f).to be(10.00)
      end

      it 'uses the variants price when it does not match role with null role' do
        @variant.volume_prices.first.update(role_id: @role.id)
        expect(@variant.volume_price(10).to_f).to be(10.00)
      end

      it 'uses the variants price when it does not match roles' do
        other_role = create(:role)
        @user.spree_roles << other_role
        @variant.volume_prices.first.update(role_id: @role.id)
        expect(@variant.volume_price(10, @user).to_f).to be(10.00)
      end

      it 'uses the volume price when it does match a range' do
        expect(@variant.volume_price(10).to_f).to be(9.00)
      end

      it 'uses the volume price when it does match a range and role' do
        @user.spree_roles << @role
        Spree::Config.volume_pricing_role = @role.name
        @variant.volume_prices.first.update(role_id: @role.id)
        expect(@variant.volume_price(10, @user).to_f).to be(9.00)
      end

      it 'gives percent of earning without roles' do
        expect(@variant.volume_price_earning_percent(10)).to be(10)
        @variant_five = create :variant, price: 10
        @variant_five.volume_prices.create! amount: 0.5, discount_type: 'percent', range: '(1+)'
        expect(@variant_five.volume_price_earning_percent(1)).to be(50)
      end

      it 'gives amount earning if role matches' do
        @user.spree_roles << @role
        Spree::Config.volume_pricing_role = @role.name
        expect(@variant.volume_price_earning_percent(10)).to be(10)
        @variant_five = create :variant, price: 10
        @variant_five.volume_prices.create! amount: 0.5, discount_type: 'percent', range: '(1+)'
        @variant_five.volume_prices.first.update(role_id: @role.id)
        expect(@variant_five.volume_price_earning_percent(1, @user)).to be(50)
      end

      it 'gives zero percent earning if doesnt match' do
        expect(@variant.volume_price_earning_percent(1)).to be(0)
      end

      it 'gives zero percent earning if role doesnt match with null' do
        @variant.volume_prices.first.update(role_id: @role.id)
        expect(@variant.volume_price_earning_percent(10)).to be(0)
      end

      it 'gives zero percent earning if role doesnt match' do
        other_role = create(:role)
        @user.spree_roles << other_role
        @variant.volume_prices.first.update(role_id: @role.id)
        expect(@variant.volume_price_earning_percent(10, @user)).to be(0)
      end

      it 'gives amount earning without roles' do
        expect(@variant.volume_price_earning_amount(10)).to eq(1)
        @variant_five = create :variant, price: 10
        @variant_five.volume_prices.create! amount: 0.5, discount_type: 'percent', range: '(1+)'
        expect(@variant_five.volume_price_earning_amount(1)).to eq(5)
      end

      it 'gives amount earning if role matches' do
        @user.spree_roles << @role
        Spree::Config.volume_pricing_role = @role.name
        expect(@variant.volume_price_earning_amount(10)).to eq(1)
        @variant_five = create :variant, price: 10
        @variant_five.volume_prices.create! amount: 0.5, discount_type: 'percent', range: '(1+)'
        @variant_five.volume_prices.first.update(role_id: @role.id)
        expect(@variant_five.volume_price_earning_amount(1, @user)).to eq(5)
      end

      it 'uses the volume price when it does match from a volume price model' do
        @variant.volume_price_models << create(:volume_price_model)
        @variant.volume_price_models.first.volume_prices.create!(amount: 0.5, discount_type: 'percent', range: '(5+)')
        expect(@variant.volume_price(6).to_f).to be(5.00)
      end

      it 'gives zero earning amount if doesnt match' do
        expect(@variant.volume_price_earning_amount(1)).to eq(0)
      end

      it 'gives zero earning amount if role doesnt match with null' do
        @variant.volume_prices.first.update(role_id: @role.id)
        expect(@variant.volume_price_earning_amount(10)).to be(0)
      end

      it 'gives zero earning amount if role doesnt match' do
        other_role = create(:role)
        @user.spree_roles << other_role
        @variant.volume_prices.first.update(role_id: @role.id)
        expect(@variant.volume_price_earning_amount(10, @user)).to be(0)
      end
    end
  end
end
