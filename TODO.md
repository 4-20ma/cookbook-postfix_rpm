# TODO

Update gem versions


Improvements

  - Use github_changelog_generator
  - add troubleshooting notes to display package contents
    rpm -q --filesbypkg -p postfix-2.11.1-0.el6.x86_64.rpm

Fix deprecations

  - WARN: Cannot specify both default and name_property together on property path of resource yum_globalconfig. Only one (name_property) will be obeyed. In Chef 13, this will become an error. Please remove one or the other from the property. (CHEF-5)/var/folders/99/k8fst2ds0_d4z_62g5zpdx1w0000gn/T/d20170212-58284-1vx4nt0/cookbooks/yum/resources/globalconfig.rb:76:in `class_from_file'.
  - WARN: YumRepository already exists!  Deprecation class overwrites Custom resource yum_repository from cookbook yum
  - /Users/doc/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/net-ssh-2.9.4/lib/net/ssh/transport/session.rb:67:in `initialize': Object#timeout is deprecated, use Timeout.timeout instead.
