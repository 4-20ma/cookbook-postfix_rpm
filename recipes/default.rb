# encoding: utf-8
#
# Cookbook Name:: postfix_rpm
# Recipe:: default
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

#---------------------------------------------------------------------- locals
home = Pathname.new('/') + 'home' + 'vagrant'
products = home + 'products'
rpmbuild = home + 'rpmbuild'
rpms = rpmbuild + 'RPMS'
sources = rpmbuild + 'SOURCES'
specs = rpmbuild + 'SPECS'
output = "#{node['postfix']['name']}-#{node['postfix']['version']}"
release = node['postfix']['release']
src_filepath = sources + "#{output}.tar.gz"
rpm_filepath = rpms + 'x86_64' + "#{output}-#{release}.el6.x86_64.rpm"

#------------------------------------------------------------------ template[]
%w(
  bash_profile
  rpmmacros
).each do |name|
  template "#{home}/.#{name}" do |t|
    source  name
    user    'vagrant'
    group   'vagrant'
  end # template
end # %w(...).each

#------------------------------------------------------------------- package[]
# packages required to build all rpms
%w(automake gcc pkgconfig rpm-build).each do |name|
  package name
end # %w(...).each

# development packages required specifically for postfix
node['postfix']['devel_packages'].each do |name|
  package "#{name}-devel"
end # node['postfix']['packages'].each

#-------------------------------------------------------------- bash[pre_tidy]
bash 'pre_tidy' do
  code    "rm -rf #{src_filepath} #{rpmbuild}/*"
  only_if { node['postfix']['pre_tidy'] }
end # bash

#----------------------------------------------------------------- directory[]
%w(SOURCES SPECS).each do |name|
  directory "#{rpmbuild}/#{name}" do
    user      'vagrant'
    group     'vagrant'
    recursive true
  end # directory
end # %w(...).each

#------------------------------------------ bash[chown /home/vagrant/rpmbuild]
bash "chown #{rpmbuild}" do
  code    "chown -R vagrant:vagrant #{rpmbuild}"
  only_if { rpmbuild.directory? }
end # bash

#------------ remote_file[/home/vagrant/rpmbuild/SOURCES/postfix-x.y.z.tar.gz]
remote_file src_filepath.to_s do
  source  'http://mirrors-usa.go-parts.com/postfix/source/official/' \
          "#{output}.tar.gz"
  backup  false
  user    'vagrant'
  group   'vagrant'
  not_if  { src_filepath.file? }
end # remote_file

#------------------------------------------------------------- cookbook_file[]
%w(
  SOURCES/pflogsumm-1.1.1.tar.gz
).each do |name|
  cookbook_file "#{rpmbuild}/#{name}" do
    source  name
    user    'vagrant'
    group   'vagrant'
  end # cookbook_file
end # %w(...).each

#------------------------------------------------------------------ template[]
%w(
  SOURCES/pflogsumm-1.1.1-datecalc.patch
  SOURCES/postfix-POSTFIX_VERSION-config.patch
  SOURCES/postfix-POSTFIX_VERSION-files.patch
  SOURCES/postfix-alternatives.patch
  SOURCES/postfix-etc-init.d-postfix
  SOURCES/postfix-large-fs.patch
  SOURCES/postfix-pam.conf
  SOURCES/postfix-sasl.conf
  SOURCES/README-Postfix-SASL-RedHat.txt
).each do |name|
  name.gsub!('POSTFIX_VERSION', node['postfix']['version'])
  template "#{rpmbuild}/#{name}" do |t|
    source  name
    user    'vagrant'
    group   'vagrant'
  end # template
end # %w(...).each

%w(
  SPECS/postfix.spec
).each do |name|
  template "#{rpmbuild}/#{name}" do |t|
    source  "#{name}.erb"
    user    'vagrant'
    group   'vagrant'
    variables(
      :version => node['postfix']['version'],
      :release => node['postfix']['release']
    )
  end # template
end # %w(...).each

#-------------------------------------------------------------- bash[rpmbuild]
bash 'rpmbuild' do
  cwd         specs.to_s
  user        'vagrant'
  group       'vagrant'
  environment 'HOME' => home.to_s
  code        'rpmbuild -ba postfix.spec'
  not_if      { rpm_filepath.exist? }
end # bash

#--------------------------------------------------- bash[copy_final_products]
bash 'copy_final_products' do
  cwd     rpm_filepath.dirname.to_s
  user    'vagrant'
  group   'vagrant'
  code    "cp -Ru #{rpm_filepath.dirname}/* #{products}"
  only_if { products.directory? }
end # bash

#------------------------------------------------------------- bash[post_tidy]
bash 'post_tidy' do
  code    "rm -rf #{src_filepath} #{rpmbuild}/*"
  only_if { node['postfix']['post_tidy'] }
end # bash

# RPM package(s) will be located at:
#   home/
#     vagrant/
#       rpmbuild/
#         RPMS/
#           x86_64/
#             postfix-x.y.z-r.el6.x86_64.rpm
#             postfix-perl-scripts-x.y.z-r.el6.x86_64.rpm
# and locally at:
#   .products/
#     postfix-x.y.z-r.el6.x86_64.rpm
#     postfix-perl-scripts-x.y.z-r.el6.x86_64.rpm
