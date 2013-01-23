#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rake/testtask'

namespace :spec do
  spec_files = FileList['spec/**/*_spec.rb']
  integration_spec_files = FileList['spec/**/*_integration_spec.rb']
  unit_spec_files = spec_files - integration_spec_files

  desc "run unit tests"
  Rake::TestTask.new("unit") do |t|
    t.libs << "spec"
    t.test_files = unit_spec_files
    t.verbose = true
  end

  desc "run integration tests"
  Rake::TestTask.new("integration") do |t|
    t.libs << "spec"
    t.test_files = integration_spec_files
    t.verbose = true
  end
end


desc "run all tests"
task spec: %w[spec:unit spec:integration]

task :default => :spec
