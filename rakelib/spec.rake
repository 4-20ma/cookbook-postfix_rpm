# encoding: utf-8
#
# Task:: spec
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
# $ rake spec

#------------------------------------------------------------------ unit tests
desc 'Run ChefSpec examples'
RSpec::Core::RakeTask.new(:spec) do |t|
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
