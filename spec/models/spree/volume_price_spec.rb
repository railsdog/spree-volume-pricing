RSpec.describe Spree::VolumePrice, type: :model do
  it { is_expected.to belong_to(:variant).touch(true).optional }
  it { is_expected.to belong_to(:volume_price_model).touch(true).optional }
  it { is_expected.to belong_to(:spree_role).class_name('Spree::Role').with_foreign_key('role_id').optional }
  it { is_expected.to validate_presence_of(:discount_type) }
  # TODO: Doesn't pass because of other validations. Needs to be solved.
  # it { is_expected.to validate_inclusion_of(:discount_type).in_array(%w(price dollar percent)) }
  it { is_expected.to validate_presence_of(:amount) }

  before do
    @volume_price = Spree::VolumePrice.new(variant: Spree::Variant.new, amount: 10, discount_type: 'price')
  end

  ['1..2', '(1..2)'].each do |range|
    it "does not interepret a Ruby range of #{range} as being opend ended" do
      @volume_price.range = range
      expect(@volume_price).not_to be_open_ended
    end
  end

  ['50+', '(50+)'].each do |range|
    it "properly interpret an open ended range of #{range}" do
      @volume_price.range = range
      expect(@volume_price).to be_open_ended
    end
  end

  describe 'valid range format' do
    it 'requires the presence of a variant' do
      @volume_price.variant = nil
      expect(@volume_price).not_to be_valid
    end

    it 'consider a range of (1..2) to be valid' do
      @volume_price.range = '(1..2)'
      expect(@volume_price).to be_valid
    end

    it 'consider a range of (1...2) to be valid' do
      @volume_price.range = '(1...2)'
      expect(@volume_price).to be_valid
    end

    it 'consider a range of 1..2 to be valid' do
      @volume_price.range = '1..2'
      expect(@volume_price).to be_valid
    end

    it 'consider a range of 1...2 to be valid' do
      @volume_price.range = '1...2'
      expect(@volume_price).to be_valid
    end

    it 'consider a range of (10+) to be valid' do
      @volume_price.range = '(10+)'
      expect(@volume_price).to be_valid
    end

    it 'consider a range of 10+ to be valid' do
      @volume_price.range = '10+'
      expect(@volume_price).to be_valid
    end

    it 'does not consider a range of 1-2 to valid' do
      @volume_price.range = '1-2'
      expect(@volume_price).not_to be_valid
    end

    it 'does not consider a range of 1 to valid' do
      @volume_price.range = '1'
      expect(@volume_price).not_to be_valid
    end

    it 'does not consider a range of foo to valid' do
      @volume_price.range = 'foo'
      expect(@volume_price).not_to be_valid
    end
  end

  describe 'include?' do
    ['10..20', '(10..20)'].each do |range|
      it "does not match a quantity that fails to fall within the specified range of #{range}" do
        @volume_price.range = range
        expect(@volume_price).not_to include(21)
      end

      it "matches a quantity that is within the specified range of #{range}" do
        @volume_price.range = range
        expect(@volume_price).to include(12)
      end

      it 'matches the upper bound of ranges that include the upper bound' do
        @volume_price.range = range
        expect(@volume_price).to include(20)
      end
    end

    ['10...20', '(10...20)'].each do |range|
      it 'does not match the upper bound for ranges that exclude the upper bound' do
        @volume_price.range = range
        expect(@volume_price).not_to include(20)
      end
    end

    ['50+', '(50+)'].each do |range|
      it "matches a quantity that exceeds the value of an open ended range of #{range}" do
        @volume_price.range = range
        expect(@volume_price).to include(51)
      end

      it "matches a quantity that equals the value of an open ended range of #{range}" do
        @volume_price.range = range
        expect(@volume_price).to include(50)
      end

      it "does not match a quantity that is less then the value of an open ended range of #{range}" do
        @volume_price.range = range
        expect(@volume_price).not_to include(40)
      end
    end
  end

  describe 'valid discount_type' do
    before do
      @volume_price_1 = Spree::VolumePrice.create(variant: Spree::Variant.new, amount: 10, discount_type: 'dollar')
      @volume_price_2 = Spree::VolumePrice.new(variant: Spree::Variant.new, amount: 10, discount_type: 'percent')
      @volume_price_3 = Spree::VolumePrice.new(variant: Spree::Variant.new, amount: 10, discount_type: 'price')
      @volume_price_4 = Spree::VolumePrice.new(variant: Spree::Variant.new, amount: 10)
      [@volume_price_1, @volume_price_2, @volume_price_3, @volume_price_4].each do |volume_price|
        volume_price.range = '(1..2)'
      end
    end

    it 'requires the presence of a volume price' do
      expect(@volume_price_1).to be_valid
      expect(@volume_price_2).to be_valid
      expect(@volume_price_3).to be_valid
      expect(@volume_price_4).to be_invalid
    end
  end
end
