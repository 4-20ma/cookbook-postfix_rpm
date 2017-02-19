#!/usr/bin/env rake
# encoding: utf-8
require 'bundler/setup'
require 'foodcritic'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

# Style guide for this Rakefile:
# - place default task at the beginning of the file
# - individual tasks are listed in alphabetical order

#---------------------------------------------- automatically run by travis-ci
task :default => [:build_ci]

desc 'Builds the package for ci server.'
task :build_ci do
  Rake::Task[:rubocop].invoke
  Rake::Task[:foodcritic].invoke
  Rake::Task[:unit].invoke
end # task

#------------------------------------------------------------------- changelog
# TODO: improve the following:
# - remove bump version commits
# - prepend to CHANGELOG without using changelog.tmp
desc 'Updates changelog with commit messages'
task :changelog, [:tag1, :tag2] do |t, args|
  args.with_defaults(:tag1 => 'v0.1.0', :tag2 => 'HEAD')
  date = `git log -1 --format=%ad #{args[:tag2]} --date=short`
  title = %(#{args[:tag2].gsub(/^v/, '')} / #{date}).chomp
  underline = '-' * title.size
  url = 'https://github.com/4-20ma'
  format = %(- "'`'"TYPE"'`'" - %s | [view](#{url}/$basename/commit/%h))
  file = 'changelog.tmp'
  sh <<-EOF
    remote=$(git config --get branch.master.remote)
    url=$(git config --get remote.$remote.url)
    basename=$(basename "$url" .git)
    echo "#{title}\n#{underline}\n" > #{file}
    git log #{args[:tag1]}..#{args[:tag2]} --no-merges \
      --pretty=format:"#{format}" >> #{file}
  EOF
end # task

#------------------------------------------------------------------ unit tests
task :chefspec => [:unit]
RSpec::Core::RakeTask.new(:unit) do |t|
  file_list = FileList['spec/**/*_spec.rb']

  %w(integration).each do |exclude|
    file_list = file_list.exclude("spec/#{exclude}/**/*_spec.rb")
  end # %w(...).each

  t.pattern = file_list

  t.rspec_opts = [].tap do |a|
    a.push('-I spec/unit/support')
    a.push('--color')
    a.push('--format progress')
  end.join(' ')
end # RSpec::Core::RakeTask

#-------------------------------------------------- cookbook lint/style checks
begin
  FoodCritic::Rake::LintTask.new do |t|
    # exclude tags by using ~FC002 notation within :tags array
    t.options = {
      :fail_tags => %w(any),
      :include_rules => ['spec/foodcritic'],
      :tags => %w()
    }
  end # FoodCritic::Rake::LintTask.new
rescue LoadError, NameError
  STDOUT.puts '[WARN] FoodCritic::Rake::LintTask not loaded'
end

namespace :foodcritic do
  desc 'Updates 3rd-party foodcritic rules.'
  task :update do
    sh 'git submodule update --init --recursive'
  end # task
end # namespace

#----------------------------------------------------------- integration tests
begin
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new

  desc 'Run all test instances'
  task :kitchen => ['kitchen:all']
rescue LoadError
  STDOUT.puts '[WARN] Kitchen::RakeTasks not loaded'
end

#-------------------------------------------------------------- publish/tagger
# Configure path to stove gem config file (add to ~/.bash_profile):
# export STOVE_CONFIG=$HOME/.chef/stove.json

# Update stove gem config file
# $ stove login --username USERNAME --key ~/.chef/USERNAME.pem

begin
  require 'stove/rake_task'
  Stove::RakeTask.new
rescue LoadError, NameError
  STDOUT.puts '[WARN] Stove::RakeTask not loaded'
end

#------------------------------------------------------ ruby lint/style checks
desc 'Runs rubocop lint tool against the cookbook.'
task :rubocop do
  RuboCop::RakeTask.new(:rubocop) do |t|
    # t.fail_on_error = true
  end
end # task

#--------------------------------------------------------------------- version
# Assume current version is 1.0.0:
# $ rake version                      # print the current version number
# $ rake version:bump                 # bump to 1.0.1
# $ rake version:bump:major           # bump to 2.0.0
# $ rake version:bump:minor           # bump to 1.1.0
# $ rake version:bump:pre             # bump to 1.0.1a
# $ rake version:bump:pre:major       # bump to 2.0.0a
# $ rake version:bump:pre:minor       # bump to 1.1.0a
# $ rake version:bump:pre:revision    # bump to 1.0.1a
# $ rake version:bump:revision        # bump to 1.0.1
# $ rake version:create               # creates a version file

begin
  require 'rake/version_task'
  Rake::VersionTask.new do |t|
    t.with_git = false
    t.with_git_tag = false
  end # Rake::VersionTask
rescue ScriptError, StandardError => e
  source = "from tasks/#{File.basename(__FILE__)}"
  STDOUT.puts "[WARN] #{e} (#{source})"
end
