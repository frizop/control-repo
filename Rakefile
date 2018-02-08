require 'puppetlabs_spec_helper/rake_tasks'
require 'metadata-json-lint/rake_task'

if RUBY_VERSION >= '1.9'
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
end

PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.ignore_paths = ['spec/**/*.pp', 'pkg/**/*.pp']

# Pulled this from puppetlabs_spec_helper/rake_tasks.rb
PuppetLint::RakeTask.new(:lint) do |config|
  config.fail_on_warnings = false
  config.disable_checks = [
    '80chars'
  ]
  config.ignore_paths = [
    "bundle/**/*.pp",
    "pkg/**/*.pp",
    "spec/**/*.pp",
    "tests/**/*.pp",
    "types/**/*.pp",
    "vendor/**/*.pp",
  ]
end

desc 'Validate manifests, templates, and ruby files'
task :validate do
  Dir['manifests/**/*.pp'].each do |manifest|
    sh "puppet parser validate --noop #{manifest}"
  end
  Dir['site/profile/manifests/**/*.pp'].each do |manifest|
    sh "puppet parser validate --noop #{manifest}"
  end
  Dir['site/role/manifests/**/*.pp'].each do |manifest|
    sh "puppet parser validate --noop #{manifest}"
  end
  Dir['spec/**/*.rb', 'lib/**/*.rb'].each do |ruby_file|
    sh "ruby -c #{ruby_file}" unless ruby_file =~ %r{spec/fixtures}
  end
  Dir['templates/**/*.erb'].each do |template|
    sh "erb -P -x -T '-' #{template} | ruby -c"
  end
end

desc 'Run metadata_lint, lint, validate, and spec tests.'
task :test do
  %i[metadata_lint lint validate spec].each do |test|
    Rake::Task[test].invoke
  end
end
