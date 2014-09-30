require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'rake/notes/rake_task'
require 'inch/rake'

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new
Inch::Rake::Suggest.new

task default: [:spec, :rubocop, :notes]
