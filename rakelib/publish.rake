# encoding: utf-8
#
# Task:: publish
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

#--------------------------------------------------------------- configuration
# Configure path to stove gem config file (add to ~/.bash_profile):
# export STOVE_CONFIG=$HOME/.chef/stove.json

#----------------------------------------------------------------------- usage
# Update stove gem config file
# $ stove login --username USERNAME --key ~/.chef/USERNAME.pem

# $ rake publish              # backwards-compatible bug fixes (revision)
# $ rake publish:revision     # same as above
# $ rake publish:minor        # new functionality; backwards-compatible manner
# $ rake publish:major        # incompatible API changes
# $ rake publish:now          # publish without version bump
# $ rake publish:tag          # tag publishment as current version
# $ rake publish:supermarket  # publish cookbook(s) to Chef supermarket

#--------------------------------------------------------------------- publish
desc 'Bump version (revision), tag, and publish to Chef supermarket'
task :publish => %w(publish:revision)

namespace :publish do
  # desc 'Bump version (revision), tag, and publish to Chef supermarket'
  task :revision => %w(version:bump:revision publish:now)

  desc 'Bump version (minor), tag, and publish to Chef supermarket'
  task :minor => %w(version:bump:minor publish:now)

  desc 'Bump version (major), tag, and publish to Chef supermarket'
  task :major => %w(version:bump:major publish:now)

  task :now => %w(changelog:version publish:tag publish:supermarket)

  begin
    require 'version'
    desc "Commit CHANGELOG, VERSION, tag as 'v#{Version.current}'"
    task :tag do
      tag_name = "v#{Version.current}"
      puts Rainbow("Tagging deployment as '#{tag_name}'").cyan
      `git add CHANGELOG.md`
      `git add #{Version.version_file('').basename}`
      puts Rainbow(`git commit -m 'Version bump to #{tag_name}'`).light_grey
      `git tag -a -f -m 'Version #{tag_name}' #{tag_name}`
      `git push origin master`
      `git push --tags`
    end # task
  rescue ScriptError, StandardError => e
    source = "from rakelib/#{File.basename(__FILE__)}"
    STDOUT.puts Rainbow("[WARN] #{e} (#{source})").yellow
  end

  begin
    require 'stove/rake_task'
    Stove::RakeTask.new(:supermarket) do |t|
      t.stove_opts = [].tap do |a|
        a.push('--no-git')
      end # t.stove_opts
    end # Stove::RakeTask.new
  rescue LoadError, NameError
    STDOUT.puts Rainbow('[WARN] Stove::RakeTask not loaded').yellow
  end
end # namespace
