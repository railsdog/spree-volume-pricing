RSpec.describe Spree::VolumePrice, type: :model do
  it { is_expected.to belong_to(:variant) }
  it { is_expected.to validate_presence_of(:variant) }
  it { is_expected.to validate_presence_of(:amount) }

  before do
    @volume_price = Spree::VolumePrice.new(variant: Spree::Variant.new, amount: 10, discount_type: 'price')
  end

  it 'does not interepret a Ruby range as being opend ended' do
    @volume_price.range = '(1..2)'
    expect(@volume_price).not_to be_open_ended
  end

  it 'properly interpret an open ended range' do
    @volume_price.range = '(50+)'
    expect(@volume_price).to be_open_ended
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

  describe 'include?'  do
    it 'does not match a quantity that fails to fall within the specified range' do
      @volume_price.range = '(10..20)'
      expect(@volume_price).not_to include(21)
    end

    it 'matches a quantity that is within the specified range' do
      @volume_price.range = '(10..20)'
      expect(@volume_price).to include(12)
    end

    it 'matches the upper bound of ranges that include the upper bound' do
      @volume_price.range = '(10..20)'
      expect(@volume_price).to include(20)
    end

    it 'does not match the upper bound for ranges that exclude the upper bound' do
      @volume_price.range = '(10...20)'
      expect(@volume_price).not_to include(20)
    end

    it 'matches a quantity that exceeds the value of an open ended range' do
      @volume_price.range = '(50+)'
      expect(@volume_price).to include(51)
    end

    it 'matches a quantity that equals the value of an open ended range' do
      @volume_price.range = '(50+)'
      expect(@volume_price).to include(50)
      @volume_price.range = '50+'
      expect(@volume_price).to include(50)
    end

    it 'does not match a quantity that is less then the value of an open ended range' do
      @volume_price.range = '(50+)'
      expect(@volume_price).not_to include(40)
    end
  end
end
