postfix.rpm Cookbook
====================
[![Build Status](https://travis-ci.org/4-20ma/cookbook-postfix.rpm.png?branch=master)](https://travis-ci.org/4-20ma/cookbook-postfix.rpm)
[![Dependency Status](https://gemnasium.com/4-20ma/cookbook-postfix.rpm.png)](https://gemnasium.com/4-20ma/cookbook-postfix.rpm)

Creates rpm package for `postfix`. The primary use case for this cookbook is to leverage Test Kitchen to:

- create a pristine virtual machine
- download, build, & package `postfix` source code

The newly-created RPM will be located at:

````text
.
└── .products
    ├── postfix-2.11.0-1.el6.x86_64.rpm
    └── postfix-perl-scripts-2.11.0-1.el6.x86_64.rpm
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
