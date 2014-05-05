# encoding: utf-8
#
# Cookbook Name:: postfix.rpm
# Library:: options
#
# Author:: Doc Walker (<4-20ma@wvfans.net>)
#
# Copyright 2014, Doc Walker
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

#--------------------------------------------------------------------- options
# returns 0 if node['postfix']['options'][key] is false
# returns 1 if node['postfix']['options'][key] is true
# Exception: if key == 'sasl' return 2 if true
# Note: key is case-insensitive
def options(key)
  key = key.to_s.downcase
  disabled = 0
  enabled = key == 'sasl' ? 2 : 1
  node['postfix']['options'][key] ? enabled : disabled
end # def
