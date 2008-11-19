require File.dirname(__FILE__) + '/../spec_helper'

describe VolumePrice do
  before(:each) do
    @volume_price = VolumePrice.new(:variant => Variant.new)
  end

  it "should not interepret a Ruby range as being opend ended" do
    @volume_price.range = "(1..2)"
    @volume_price.should_not be_open_ended
  end
  
  it "should properly interpret an open ended range" do
    @volume_price.range = "(50+)"
    @volume_price.should be_open_ended
  end
  
  describe "valid?" do
    it "should require the presence of a variant" do
      @volume_price.variant = nil
      @volume_price.should_not be_valid
    end
    it "should consider a range of (1..2) to be valid" do
      @volume_price.range = "(1..2)"
      @volume_price.should be_valid
    end
    it "should consider a range of (1...2) to be valid" do
      @volume_price.range = "(1...2)"
      @volume_price.should be_valid
    end
    it "should not consider a range of 1..2 to be valid" do
      @volume_price.range = "1..2"
      @volume_price.should_not be_valid
    end
    it "should not consider a range of 1...2 to be valid" do
      @volume_price.range = "1...2"
      @volume_price.should_not be_valid
    end
    it "should consider a range of (10+) to be valid" do
      @volume_price.range = "(10+)"
      @volume_price.should be_valid
    end
    it "should not consider a range of 10+ to be valid" do
      @volume_price.range = "10+"
      @volume_price.should_not be_valid
    end
    it "should not consider a range of 1-2 to valid" do
      @volume_price.range = "1-2"
      @volume_price.should_not be_valid    
    end
    it "should not consider a range of 1 to valid" do
      @volume_price.range = "1"
      @volume_price.should_not be_valid    
    end
    it "should not consider a range of foo to valid" do
      @volume_price.range = "foo"
      @volume_price.should_not be_valid    
    end
  end
  
  describe "include?"  do    
    it "should not match a quantity that fails to fall within the specified range" do
      @volume_price.range = "(10..20)"
      @volume_price.should_not include(21)
    end
    it "should match a quantity that is within the specified range" do
      @volume_price.range = "(10..20)"
      @volume_price.should include(12)
    end
    it "should match the upper bound of ranges that include the upper bound" do
      @volume_price.range = "(10..20)"
      @volume_price.should include(20)
    end
    it "should not match the upper bound for ranges that exclude the upper bound" do
      @volume_price.range = "(10...20)"
      @volume_price.should_not include(20)
    end
    it "should match a quantity that exceeds the value of an open ended range" do
      @volume_price.range = "(50+)"
      @volume_price.should include(51)
    end
    it "should match a quantity that equals the value of an open ended range" do
      @volume_price.range = "(50+)"
      @volume_price.should include(50)
    end
    it "should not match a quantity that is less then the value of an open ended range" do
      @volume_price.range = "(50+)"
      @volume_price.should_not include(40)
    end    
  end
end
