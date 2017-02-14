# encoding: utf-8
#
# Cookbook Name:: postfix_rpm
# Recipe:: source
#
# Author:: Doc Walker (<4-20ma@wvfans.net>)
#
# Copyright 2014-2017, Doc Walker
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

#---------------------------------------------------------------------- locals
home = Pathname.new('/') + 'home' + 'vagrant'
rpmbuild = home + 'rpmbuild'
sources = rpmbuild + 'SOURCES'
output = "#{node['postfix']['name']}-#{node['postfix']['version']}"
src_filepath = sources + "#{output}.tar.gz"

#------------------------------------------- include_recipe[yum-epel::default]
include_recipe 'yum-epel::default'

#----------------------------------------------- yum_repository[RedHat-Source]
yum_repository 'RedHat-Source' do
  description 'Source Packages for Enterprise Linux 6 - $basearch'
  baseurl 'http://ftp.redhat.com/redhat/linux/enterprise/6Server/en/os/SRPMS/'
end # yum_repository

#------------------------------------------------- bash[download_postfix_srpm]
bash 'download_postfix_srpm' do
  cwd     src_filepath.dirname.to_s
  code    '/usr/bin/yumdownloader --source postfix'
  not_if { (src_filepath.dirname + 'postfix-2.6.6-6.el6_5.src.rpm').file? }
end # bash

#------------------------------------------------------------------- package[]
# convenience packages; these are not needed
%w(git man nano rpmrebuild yum-utils).each do |name|
  package name
end # %w(...).each
