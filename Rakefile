require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/packagetask'
require 'rake/gempackagetask'

spec = eval(File.read('spree_volume_pricing.gemspec'))

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
end

desc "Release to gemcutter"
task :release => :package do
  require 'rake/gemcutter'
  Rake::Gemcutter::Tasks.new(spec).define
  Rake::Task['gem:push'].invoke
end

gemfile = File.expand_path('../spec/test_app/Gemfile', __FILE__)
if File.exists?(gemfile) && (%w(spec cucumber).include?(ARGV.first.to_s) || ARGV.size == 0)
  require 'bundler'
  ENV['BUNDLE_GEMFILE'] = gemfile
  Bundler.setup

  require 'rspec'
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new
end

desc "Default Task"
task :default => [:spec ]

spec = eval(File.read('spree_volume_pricing.gemspec'))

Gem::PackageTask.new(spec) do |p|
  p.gem_spec = spec
end

desc "Regenerates a rails 3 app for testing"
task :test_app do
  SPREE_ROOT = ENV['SPREE_ROOT']
  raise "SPREE_ROOT should be specified (where is your source code for spree?)" unless SPREE_ROOT

  require File.join(SPREE_ROOT, 'lib/generators/spree/test_app_generator')

  class SpreeVolumePricingTestAppGenerator < Spree::Generators::TestAppGenerator

    def install_gems
      inside "test_app" do
        run 'bundle exec rake spree:install'
        run 'bundle exec rake spree_volume_pricing:install'
      end
    end

    def migrate_db
      run_migrations
    end

    protected
    def full_path_for_local_gems
      <<-gems
gem 'spree', :path => \'#{SPREE_ROOT}\'
gem 'spree_volume_pricing', :path => \'#{File.expand_path('..', __FILE__)}\'
      gems
    end

  end
  SpreeVolumePricingTestAppGenerator.start
end

namespace :test_app do
  desc 'Rebuild test database'
  task :rebuild_dbs do
    system("cd spec/test_app && bundle exec rake db:drop db:migrate RAILS_ENV=test")
  end
end
