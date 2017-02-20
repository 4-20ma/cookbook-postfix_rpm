# encoding: utf-8
#
# Task:: kitchen
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
# $ rake kitchen                          # run all integration tests
# $ rake kitchen:test                     # run all integration tests
# $ rake kitchen:default-centos-6         # run default-centos tests
# $ rake kitchen:create[default]          # create; OK to use kitchen regex
# $ rake kitchen:converge[default]        # converge
# $ rake kitchen:setup[default]           # setup
# $ rake kitchen:verify[default]          # verify
# $ rake kitchen:destroy[default]         # destroy
# $ rake kitchen:login[default]           # login to container to debug

#--------------------------------------------------------------------- kitchen
desc 'Run all tests instances'
task :kitchen, [:instance] => %w(kitchen:test)

begin
  require 'kitchen'

  ENV['KITCHEN_YAML'] ||= '.kitchen.yml'
  test_base_path = File.join('test', 'integration')

  namespace 'kitchen' do
    %w(test create converge setup verify destroy list login).each do |cmd|
      desc "Run kitchen #{cmd} on instance"
      task cmd, :instance do |t, args|
        args.with_defaults(:instance => 'all')
        sh "bundle exec kitchen #{cmd} #{args[:instance]} " \
          "-t #{test_base_path}"
      end # task
    end # %w(...).each
  end # namespace

rescue ScriptError, StandardError => e
  source = "from rakelib/#{File.basename(__FILE__)}"
  STDOUT.puts Rainbow("[WARN] #{e} (#{source})").yellow
end
