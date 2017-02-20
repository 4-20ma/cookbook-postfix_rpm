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

desc 'Tag and publish to Chef supermarket'
task :publish => %w(publish:default)

namespace :publish do
  task :default => ['publish:tag', 'publish:supermarket']

  begin
    require 'version'
    desc "Tag deployment as 'v#{Version.current}'"
    task :tag do
      tag_name = "v#{Version.current}"
      puts "Tagging deployment as '#{tag_name}'"
      `git add CHANGELOG.md`
      `git add #{Version.version_file('').basename}`
      puts `git commit -m 'Version bump to #{tag_name}'`
      `git tag -a -f -m 'Version #{tag_name}' #{tag_name}`
      `git push origin master`
      `git push --tags`
    end # task
  rescue ScriptError, StandardError => e
    source = "from tasks/#{File.basename(__FILE__)}"
    STDOUT.puts "[WARN] #{e} (#{source})"
  end

  begin
    require 'stove/rake_task'
    Stove::RakeTask.new(:supermarket) do |t|
      t.stove_opts = [].tap do |a|
        a.push('--no-git')
      end # t.stove_opts
    end # Stove::RakeTask.new
  rescue LoadError, NameError
    STDOUT.puts '[WARN] Stove::RakeTask not loaded'
  end
end # namespace

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

#------------------------------------------------------------------- changelog
begin
  require 'github_changelog_generator/task'
  require 'version'

  desc 'Prepare CHANGELOG'
  GitHubChangelogGenerator::RakeTask.new(:changelog) do |config|
    config.add_issues_wo_labels = false
    config.add_pr_wo_labels = false
    config.enhancement_labels = [
      'Type: Enhancement'
    ]
    config.bug_labels = ['Type: Bug']
    config.exclude_labels = ['Type: Question']
    config.header = '# CHANGELOG'
    config.include_labels = [
      'Type: Bug',
      'Type: Enhancement',
      'Type: Feature Request',
      'Type: Maintenance'
    ]
    # config.since_tag = '0.1.0'
    config.future_release = "v#{Version.current}"
    config.user = '4-20ma'
    config.project = 'cookbook-postfix_rpm'
  end # GitHubChangelogGenerator::RakeTask.new
rescue LoadError, NameError
  STDOUT.puts '[WARN] GitHubChangelogGenerator::RakeTask not loaded'
end
