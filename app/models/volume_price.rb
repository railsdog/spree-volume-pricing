class VolumePrice < ActiveRecord::Base
  belongs_to :variant
  acts_as_list :scope => :variant
  validates_presence_of :variant
  validates_presence_of :amount
  
  OPEN_ENDED = /\([0-9]+\+\)/
  
  def validate
    return if open_ended?
    errors.add(:range, "must be in one of the following formats: (a..b), (a...b), (a+)") unless /\([0-9]+\.{2,3}[0-9]+\)/ =~ range
  end
  
  def include?(quantity)
    if open_ended?
      bound = /\d+/.match(range)[0].to_i
      return quantity >= bound
    else
      range.to_range === quantity
    end
  end
  
  # indicates whether or not the range is a true Ruby range or an open ended range with no upper bound
  def open_ended?
    OPEN_ENDED =~ range
  end
end
