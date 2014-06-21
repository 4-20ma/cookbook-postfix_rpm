# encoding: utf-8
#
# Cookbook Name:: postfix.rpm
# Attributes:: default
#

default['postfix'].tap do |postfix|
  postfix['devel_packages'] = %w(db4 zlib)
  postfix['name'] = 'postfix'
  postfix['version'] = '0.0.0'  # NOTE: may be overridden in .kitchen.yml
  postfix['release'] = '0'      # NOTE: may be overridden in .kitchen.yml
  postfix['pre_tidy'] = false   # NOTE: may be overridden in .kitchen.yml
  postfix['post_tidy'] = false  # NOTE: may be overridden in .kitchen.yml

  postfix['options'].tap do |options|
    options['ipv6']       = true
    options['ldap']       = false
    options['mysql']      = false
    options['pcre']       = true
    options['pflogsumm']  = true
    options['pgsql']      = false
    options['sasl']       = true
    options['sqlite']     = true
    options['tls']        = true

    # add required development packages based on chosen options
    postfix['devel_packages'] << 'openldap' if options['ldap']
    postfix['devel_packages'] << 'mysql' if options['mysql']
    postfix['devel_packages'] << 'pcre' if options['pcre']
    postfix['devel_packages'] << 'postgresql' if options['pgsql']
    postfix['devel_packages'] << 'cyrus-sasl' if options['sasl']
    postfix['devel_packages'] << 'sqlite' if options['sqlite']
    postfix['devel_packages'] << 'openssl' if options['tls']
  end # postfix[].tap
end # default[].tap
