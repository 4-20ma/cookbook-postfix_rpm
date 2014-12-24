postfix_rpm Cookbook
====================
[![Travis](https://img.shields.io/travis/4-20ma/cookbook-postfix_rpm.svg?style=flat)](https://travis-ci.org/4-20ma/cookbook-postfix_rpm)
[![Gemnasium](http://img.shields.io/gemnasium/4-20ma/cookbook-postfix_rpm.svg?style=flat)](https://gemnasium.com/4-20ma/cookbook-postfix_rpm)

Creates rpm package for `postfix`. The primary use case for this cookbook is to leverage Test Kitchen to:

- create a pristine virtual machine
- download, build, & package `postfix` source code

The newly-created RPM will be located at:

````text
.
└── .products
    ├── postfix-x.y.z-r.el6.x86_64.rpm
    └── postfix-perl-scripts-x.y.z-r.el6.x86_64.rpm
````


Requirements
------------
### Cookbooks
The following cookbook is a dependency because it's used for optional functionality.

- [`yum-epel`](https://github.com/opscode-cookbooks/yum-epel)

### Platforms
The following platform is supported and tested under Test Kitchen:

- CentosOS 6.5

Other RHEL family distributions are assumed to work.


Attributes
----------

File / Attribute(s)                       | Description
------------------------------------------|------------
[default.rb](attributes/default.rb)       |
`node['postfix']['devel_packages']`       | array of base *-devel packages required to build postfix
`node['postfix']['name']`                 | name to be used for RPM
`node['postfix']['version']`              | version to be used for RPM
`node['postfix']['release']`              | release to be used for RPM
`node['postfix']['pre_tidy']`             | set this to true to cleanup before build
`node['postfix']['post_tidy']`            | set this to true to cleanup after build
&nbsp;                                    | &nbsp;
Options                                   |
`node['postfix']['options']['ipv6]`       | set this to true to enable IPv6
`node['postfix']['options']['ldap]`       | set this to true to enable LDAP
`node['postfix']['options']['mysql]`      | set this to true to enable MySQL
`node['postfix']['options']['pcre]`       | set this to true to enable PCRE
`node['postfix']['options']['pflogsumm]`  | set this to true to enable pflogsumm
`node['postfix']['options']['pgsql]`      | set this to true to enable PostgreSQL
`node['postfix']['options']['sasl]`       | set this to true to enable Cyrus-SASL
`node['postfix']['options']['sqlite]`     | set this to true to enable SQLite
`node['postfix']['options']['tls]`        | set this to true to enable TLS


Recipes
-------
This cookbook provides one main recipe for building a binary RPM and an optional recipe for downloading a source RPM.

Name                            | Description
--------------------------------|------------
[`default`](recipes/default.rb) | use this recipe to build a binary RPM
[`source`](recipes/source.rb)   | use this recipe to download a source RPM (optional--for RPM development)


Update
------
To update to a new version of `postfix`, do the following:

File / Section(s)            | Description
-----------------------------|------------
[.kitchen.yml](.kitchen.yml) |
`attributes/postfix/version` | update to new postfix version
`attributes/postfix/release` | reset to 0 for new postfix version (increment if new rpm release of same postfix version)
&nbsp;                       | &nbsp;
[SOURCES](templates/default/SOURCES)|
`postfix-x.y.z-config.patch` | rename to match postfix version; update patch, if necessary
`postfix-x.y.z-files.patch`  | rename to match postfix version; update patch, if necessary
&nbsp;                       | &nbsp;
[postfix.spec.erb](templates/default/SPECS/postfix.spec.erb)|
`Patch1`                     | update patch filename to match postfix version
`Patch2`                     | update patch filename to match postfix version
`%changelog`                 | update changelog with pertinent information
&nbsp;                       | &nbsp;
[postfix_spec.rb](test/integration/postfix/serverspec/postfix_spec.rb)|
`postfix_ver`                | update to match postfix version
`release`                    | update to match release

Run `rake` to ensure syntax, lint, and unit tests pass.

````bash
$ bundle exec rake
````

Use Test Kitchen to run integration tests (converge, verify, and destroy the node if everything tests OK).

````bash
$ bundle exec kitchen test
````

Create a feature branch, stage & commit the changes, and push the branch.

````bash
$ git checkout -b branch_name
$ git add -A
$ git commit
$ git push --set-upstream origin branch_name
````

Create a pull request and merge once travis-ci tests pass.

Update `CHANGELOG`, bump version in `metadata.rb`, stage & commit the changes, and push the branch (OK to add [skip ci] to commit message to skip travis-ci).

Release the updated cookbook (stash any uncommitted changes before releasing).

````bash
$ bundle exec rake release
````


Usage
-----
Use Test Kitchen to converge the node and retrieve the resultant RPM from `.products/`.

````bash
$ bundle exec kitchen converge
````

Alternatively, the following command will converge the node and automatically destroy it when finished. Retrieve the RPM from `.products/`.

````bash
$ bundle exec kitchen test
````


License & Authors
-----------------
- Author:: Doc Walker (<4-20ma@wvfans.net>)

````text
Copyright 2014, Doc Walker

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
````
