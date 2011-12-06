# encoding: utf-8
require 'rake'
require 'rake/testtask'
require 'rake/packagetask'
require 'rubygems/package_task'
require 'rspec/core/rake_task'
require 'spree/core/testing_support/common_rake'

RSpec::Core::RakeTask.new

task :default => :rspec

spec = eval(File.read('spree_volume_pricing.gemspec'))

Gem::PackageTask.new(spec) do |p|
  p.gem_spec = spec
end

task :release => :package do
  require 'rake/gemcutter'
  Rake::Gemcutter::Tasks.new(spec).define
  Rake::Task['gem:push'].invoke
end

task :test_app do
  ENV['LIB_NAME'] = 'spree_volume_pricing'
  Rake::Task['common:test_app'].invoke
end
