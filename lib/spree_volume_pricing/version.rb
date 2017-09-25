module SpreeVolumePricing
  module_function

  # Returns the version of the currently loaded SpreeVolumePricing as a
  # <tt>Gem::Version</tt>.
  def version
    Gem::Version.new VERSION::STRING
  end

  module VERSION
    MAJOR = 3
    MINOR = 3
    TINY  = 1
    PRE   = nil

    STRING = [MAJOR, MINOR, TINY, PRE].compact.join('.')
  end
end
