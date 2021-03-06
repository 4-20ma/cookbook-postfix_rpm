# HOWTO generate a patch file

## General process

Converge

    $ bundle exec kitchen converge

Login

    $ bundle exec kitchen login

Install editor; duplicate target file

    $ sudo yum -y install nano
    $ cd rpmbuild/BUILD/postfix-3.0.8/conf/
    $ cp postfix-files postfix-files.files

Edit target file with desired changes

    $ nano postfix-files

Generate diff

    $ cd ~/rpmbuild/BUILD/
    $ diff -up postfix-3.0.8/conf/postfix-files.files postfix-3.0.8/conf/postfix-files
    --- postfix-3.0.8/conf/postfix-files.files	2017-02-14 21:24:57.569000642 +0000
    +++ postfix-3.0.8/conf/postfix-files	2017-02-14 21:26:50.651000911 +0000
    @@ -82,9 +82,6 @@ $shlib_directory/${LIB_PREFIX}sdbm${LIB_
     $shlib_directory/${LIB_PREFIX}sqlite${LIB_SUFFIX}:f:root:-:755
     $meta_directory/dynamicmaps.cf.d:d:root:-:755
     $meta_directory/dynamicmaps.cf:f:root:-:644
    -$meta_directory/main.cf.proto:f:root:-:644
    -$meta_directory/makedefs.out:f:root:-:644
    -$meta_directory/master.cf.proto:f:root:-:644
     $meta_directory/postfix-files.d:d:root:-:755
     $meta_directory/postfix-files:f:root:-:644
     $daemon_directory/anvil:f:root:-:755
    @@ -139,18 +136,13 @@ $command_directory/postqueue:f:root:$set
     $sendmail_path:f:root:-:755
     $newaliases_path:l:$sendmail_path
     $mailq_path:l:$sendmail_path
    -$config_directory/LICENSE:f:root:-:644:1
    -$config_directory/TLS_LICENSE:f:root:-:644:1
     $config_directory/access:f:root:-:644:p1
    -$config_directory/aliases:f:root:-:644:p1
    -$config_directory/bounce.cf.default:f:root:-:644:1
     $config_directory/canonical:f:root:-:644:p1
     $config_directory/cidr_table:f:root:-:644:o
     $config_directory/generic:f:root:-:644:p1
     $config_directory/generics:f:root:-:644:o
     $config_directory/header_checks:f:root:-:644:p1
     $config_directory/install.cf:f:root:-:644:o
    -$config_directory/main.cf.default:f:root:-:644:1
     $config_directory/main.cf:f:root:-:644:p
     $config_directory/master.cf:f:root:-:644:p
     $config_directory/pcre_table:f:root:-:644:o
    @@ -163,8 +155,8 @@ $config_directory/postfix-script:f:root:
     $config_directory/postfix-script-sgid:f:root:-:755:o
     $config_directory/postfix-script-nosgid:f:root:-:755:o
     $config_directory/post-install:f:root:-:755:o
    -$manpage_directory/man1/mailq.1:f:root:-:644
    -$manpage_directory/man1/newaliases.1:f:root:-:644
    +$manpage_directory/man1/mailq.postfix.1:f:root:-:644
    +$manpage_directory/man1/newaliases.postfix.1:f:root:-:644
     $manpage_directory/man1/postalias.1:f:root:-:644
     $manpage_directory/man1/postcat.1:f:root:-:644
     $manpage_directory/man1/postconf.1:f:root:-:644
    @@ -177,9 +169,9 @@ $manpage_directory/man1/postmap.1:f:root
     $manpage_directory/man1/postmulti.1:f:root:-:644
     $manpage_directory/man1/postqueue.1:f:root:-:644
     $manpage_directory/man1/postsuper.1:f:root:-:644
    -$manpage_directory/man1/sendmail.1:f:root:-:644
    +$manpage_directory/man1/sendmail.postfix.1:f:root:-:644
     $manpage_directory/man5/access.5:f:root:-:644
    -$manpage_directory/man5/aliases.5:f:root:-:644
    +$manpage_directory/man5/aliases.postfix.5:f:root:-:644
     $manpage_directory/man5/body_checks.5:f:root:-:644
     $manpage_directory/man5/bounce.5:f:root:-:644
     $manpage_directory/man5/canonical.5:f:root:-:644

Paste diff contents into patch file

    templates/default/SOURCES/postfix-3.0.8-files.patch
