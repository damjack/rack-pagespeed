# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = "rack-pagespeed-fork"
  gem.homepage = "http://github.com/wjordan/rack-pagespeed"
  gem.license = "MIT"
  gem.summary = "Web page speed optimizations at the Rack level - fork"
  gem.description = "Web page speed optimizations at the Rack level - fork"
  gem.email = "will@code.org"
  gem.authors = ["Will Jordan", "Julio Cesar Ody"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.rspec_opts = ['-c', '-f nested', '-r ./spec/spec_helper']
end

namespace :spec do
  desc "Runs specs on Ruby 1.8.7 and 1.9.2"
  task :rubies do
    system "rvm 1.8.7-p174,1.9.2 specs"
  end
end

task :default => :spec
