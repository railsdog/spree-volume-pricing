module SpreeVolumePricing
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_volume_pricing'

    initializer 'spree_volume_pricing.preferences', before: 'spree.environment' do
      Spree::AppConfiguration.class_eval do
        preference :use_master_variant_volume_pricing, :boolean, default: false
        preference :volume_pricing_role, :string, default: 'wholesale'
      end
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end

      String.class_eval do
        def to_range
          case count('.')
          when 2
            elements = split('..')
            return Range.new(elements[0].delete('(').to_i, elements[1].to_i)
          when 3
            elements = split('...')
            return Range.new(elements[0].delete('(').to_i, elements[1].to_i - 1)
          else
            raise ArgumentError.new(
              I18n.t(
                :'activerecord.errors.messages.could_not_conver_to_range',
                number: self
              )
            )
          end
        end
      end
    end

    config.autoload_paths += %W(#{config.root}/lib)
    config.to_prepare(&method(:activate).to_proc)
  end
end
