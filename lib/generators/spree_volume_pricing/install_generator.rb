module SpreeVolumePricing
  module Generators
    class InstallGenerator < Rails::Generators::Base
      def add_migrations
        run 'rake railties:install:migrations FROM=spree_volume_pricing_engine'
      end

      def run_migrations
        res = ask "Would you like to run the migrations now? [Y/n]"
        if res == "" || res.downcase == "y"
          run 'rake db:migrate'
        else
          puts "Skipping rake db:migrate, don't forget to run it!"
        end
      end
    end
  end
end

