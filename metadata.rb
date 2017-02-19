# encoding: utf-8
name              'postfix_rpm'
maintainer        'Doc Walker'
maintainer_email  '4-20ma@wvfans.net'
description       'Creates rpm package for postfix.'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
license           'Apache 2.0'
version           IO.read(File.join(__dir__, 'VERSION')).chomp
issues_url        'https://github.com/4-20ma/cookbook-postfix_rpm/issues' if respond_to?(:issues_url)
source_url        'https://github.com/4-20ma/cookbook-postfix_rpm' if respond_to?(:source_url)

#------------------------------------------------------- cookbook dependencies
depends           'yum-epel', '~> 2.1.1'

#--------------------------------------------------------- supported platforms
# tested
supports          'centos'

# platform_family?('rhel'): not tested, but should work
supports          'amazon'
supports          'oracle'
supports          'redhat'
supports          'scientific'
