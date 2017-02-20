# encoding: utf-8
#
# Task:: changelog
#
# Author:: Doc Walker (<4-20ma@wvfans.net>)
#
# Copyright 2014-2017 Doc Walker
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'rake'

#----------------------------------------------------------------------- usage
# $ rake changelog

#------------------------------------------------------------------- changelog
desc 'Generate a Change log from GitHub'
task :changelog => %w(changelog:generate)

namespace :changelog do
  begin
    require 'github_changelog_generator/task'
    require 'version'

    GitHubChangelogGenerator::RakeTask.new(:generate) do |config|
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
      config.future_release = '__UNRELEASED__'
      config.user = '4-20ma'
      config.project = 'cookbook-postfix_rpm'
    end # GitHubChangelogGenerator::RakeTask.new
  rescue LoadError, NameError
    STDOUT.puts Rainbow('[WARN] GitHubChangelogGenerator::RakeTask ' \
      'not loaded').yellow
  end

  # desc 'Update CHANGELOG with current version'
  task :version do
    STDOUT.puts Rainbow('Updating CHANGELOG.md version to ' \
      "v#{Version.current}").cyan
    cwd = File.expand_path(__dir__)
    file = File.join(cwd, '..', 'CHANGELOG.md')
    contents = IO.read(file)
    contents.gsub!('__UNRELEASED__', "v#{Version.current}")
    IO.write(file, contents)
  end # task
end # namespace
