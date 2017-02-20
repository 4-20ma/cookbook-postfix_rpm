# encoding: utf-8
#
# Task:: version
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

#--------------------------------------------------------------------- version
begin
  require 'rake/version_task'
  Rake::VersionTask.new do |t|
    t.with_git = false
    t.with_git_tag = false
  end # Rake::VersionTask
rescue ScriptError, StandardError => e
  source = "from rakelib/#{File.basename(__FILE__)}"
  STDOUT.puts Rainbow("[WARN] #{e} (#{source})").yellow
end
