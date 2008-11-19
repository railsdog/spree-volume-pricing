# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class VolumePricingExtension < Spree::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/volume_pricing"

  # define_routes do |map|
  #   map.namespace :admin do |admin|
  #     admin.resources :whatever
  #   end  
  # end
  
  def activate
    Variant.class_eval do 
      has_many :volume_prices, :order => :position
    end
    
    Order.class_eval do
      # override the add_variant functionality so that we can adjust the price based on possible volume adjustment
      def add_variant(variant, quantity=1)
        current_item = line_items.in_order(variant)
        
        price = variant.price
        variant.volume_prices.each do |volume_price|
          price = volume_price.amount and break if volume_price.include?(quantity)
        end
        
        if current_item
          current_item.increment_quantity unless quantity > 1
          current_item.quantity = (current_item.quantity + quantity) if quantity > 1
          current_item.price = price
          current_item.save
        else
          current_item = LineItem.new(:quantity => quantity, :variant => variant, :price => price)
          self.line_items << current_item
        end
      end
    end
    
    String.class_eval do 
     def to_range
       case self.count('.')
         when 2
           elements = self.split('..')
           return Range.new(elements[0].to_i, elements[1].to_i)
         when 3
           elements = self.split('...')
           return Range.new(elements[0].to_i, elements[1].to_i-1)
         else
           raise ArgumentError.new("Couldn't convert to Range: #{self}")
       end
     end
    end
    
  end
  
end