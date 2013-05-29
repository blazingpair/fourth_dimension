require 'rspec/core/rake_task'
#require 'spec/rake/verify_rcov'
require 'cucumber/rake/task'

desc "Run all tests by default"
task :default => [:spec]

RSpec::Core::RakeTask.new

Cucumber::Rake::Task.new do |t|
  t.cucumber_opts = "--format pretty --no-source"
  t.rcov = false
end

namespace :spec do
  RSpec::Core::RakeTask.new do |t|
    t.rcov = true
    t.rcov_opts = ['--exclude', '\/gems,lib\/spec,bin\/spec']
    t.rspec_opts = "-c" # TODO: enable color output
  end

  #RCov::VerifyTask.new(:verify_coverage) do |t|
  #  t.threshold = 100
  #end

  desc "Run specs and verify test coverage"
  task :rcov => [:spec, :verify_coverage]
end

