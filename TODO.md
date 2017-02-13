# TODO

Update gem versions

  - Figure out why kitchen-vagrant v1.0.0, v1.0.1 fail

Improvements

  - update copyrights
  - Use github_changelog_generator

Fix deprecations

  - WARN: Cannot specify both default and name_property together on property path of resource yum_globalconfig. Only one (name_property) will be obeyed. In Chef 13, this will become an error. Please remove one or the other from the property. (CHEF-5)/var/folders/99/k8fst2ds0_d4z_62g5zpdx1w0000gn/T/d20170212-58284-1vx4nt0/cookbooks/yum/resources/globalconfig.rb:76:in `class_from_file'.
  - WARN: YumRepository already exists!  Deprecation class overwrites Custom resource yum_repository from cookbook yum
