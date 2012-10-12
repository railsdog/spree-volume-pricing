module SpreeVolumePricing
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_volume_pricing'

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end

      String.class_eval do 
        def to_range
          case self.count('.')
          when 2
            elements = self.split('..')
            return Range.new(elements[0].from(1).to_i, elements[1].to_i)
          when 3
            elements = self.split('...')
            return Range.new(elements[0].from(1).to_i, elements[1].to_i-1)
          else
            raise ArgumentError.new("Couldn't convert to Range: #{self}")
          end
        end
      end
    end

    config.autoload_paths += %W(#{config.root}/lib)
    config.to_prepare &method(:activate).to_proc
  end
end

