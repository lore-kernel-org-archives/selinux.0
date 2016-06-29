Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5TC5vNv006501
 for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2016 08:05:57 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1BCEE80500
 for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2016 12:05:54 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] policycoreutils: fix [-s STORE] typos in semanage
Date: Wed, 29 Jun 2016 14:05:42 +0200
Message-Id: <1467201942-2693-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

semanage and semanage man pages used wrong usage of
[-S STORE] in synopsis

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 policycoreutils/semanage/semanage             | 14 +++++++-------
 policycoreutils/semanage/semanage-boolean.8   |  2 +-
 policycoreutils/semanage/semanage-fcontext.8  |  2 +-
 policycoreutils/semanage/semanage-interface.8 |  2 +-
 policycoreutils/semanage/semanage-login.8     |  2 +-
 policycoreutils/semanage/semanage-node.8      |  2 +-
 policycoreutils/semanage/semanage-port.8      |  2 +-
 policycoreutils/semanage/semanage-user.8      |  2 +-
 8 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/policycoreutils/semanage/semanage b/policycoreutils/semanage/semanage
index 7489955..954411d 100644
--- a/policycoreutils/semanage/semanage
+++ b/policycoreutils/semanage/semanage
@@ -45,25 +45,25 @@ except IOError:
         __builtin__.__dict__['_'] = unicode
 
 # define custom usages for selected main actions
-usage_login = "semanage login [-h] [-n] [-N] [-s STORE] ["
+usage_login = "semanage login [-h] [-n] [-N] [-S STORE] ["
 usage_login_dict = {' --add': ('-s SEUSER', '-r RANGE', 'LOGIN',), ' --modify': ('-s SEUSER', '-r RANGE', 'LOGIN',), ' --delete': ('LOGIN',), ' --list': ('-C',), ' --extract': ('',), ' --deleteall': ('',)}
 
-usage_fcontext = "semanage fcontext [-h] [-n] [-N] [-s STORE] ["
+usage_fcontext = "semanage fcontext [-h] [-n] [-N] [-S STORE] ["
 usage_fcontext_dict = {' --add': ('(', '-t TYPE', '-f FTYPE', '-r RANGE', '-s SEUSER', '|', '-e EQUAL', ')', 'FILE_SPEC', ')',), ' --delete': ('(', '-t TYPE', '-f FTYPE', '|', '-e EQUAL', ')', 'FILE_SPEC', ')',), ' --modify': ('(', '-t TYPE', '-f FTYPE', '-r RANGE', '-s SEUSER', '|', '-e EQUAL', ')', 'FILE_SPEC )',), ' --list': ('-C',), ' --extract': ('',), ' --deleteall': ('',)}
 
-usage_user = "semanage user [-h] [-n] [-N] [-s STORE] ["
+usage_user = "semanage user [-h] [-n] [-N] [-S STORE] ["
 usage_user_dict = {' --add': ('(', '-L LEVEL', '-R ROLES', '-r RANGE', '-s SEUSER', 'selinux_name'')'), ' --delete': ('selinux_name',), ' --modify': ('(', '-L LEVEL', '-R ROLES', '-r RANGE', '-s SEUSER', 'selinux_name', ')'), ' --list': ('-C',), ' --extract': ('',), ' --deleteall': ('',)}
 
-usage_port = "semanage port [-h] [-n] [-N] [-s STORE] ["
+usage_port = "semanage port [-h] [-n] [-N] [-S STORE] ["
 usage_port_dict = {' --add': ('-t TYPE', '-p PROTOCOL', '-r RANGE', '(', 'port_name', '|', 'port_range', ')'), ' --modify': ('-t TYPE', '-p PROTOCOL', '-r RANGE', '(', 'port_name', '|', 'port_range', ')'), ' --delete': ('-p PROTOCOL', '(', 'port_name', '|', 'port_range', ')'), ' --list': ('-C',), ' --extract': ('',), ' --deleteall': ('',)}
 
-usage_node = "semanage node [-h] [-n] [-N] [-s STORE] ["
+usage_node = "semanage node [-h] [-n] [-N] [-S STORE] ["
 usage_node_dict = {' --add': ('-M NETMASK', '-p PROTOCOL', '-t TYPE', '-r RANGE', 'node'), ' --modify': ('-M NETMASK', '-p PROTOCOL', '-t TYPE', '-r RANGE', 'node'), ' --delete': ('-M NETMASK', '-p PROTOCOL', 'node'), ' --list': ('-C',), ' --extract': ('',), ' --deleteall': ('',)}
 
-usage_interface = "semanage interface [-h] [-n] [-N] [-s STORE] ["
+usage_interface = "semanage interface [-h] [-n] [-N] [-S STORE] ["
 usage_interface_dict = {' --add': ('-t TYPE', '-r RANGE', 'interface'), ' --modify': ('-t TYPE', '-r RANGE', 'interface'), ' --delete': ('interface',), ' --list': ('-C',), ' --extract': ('',), ' --deleteall': ('',)}
 
-usage_boolean = "semanage boolean [-h] [-n] [-N] [-s STORE] ["
+usage_boolean = "semanage boolean [-h] [-n] [-N] [-S STORE] ["
 usage_boolean_dict = {' --modify': ('(', '--on', '|', '--off', ')', 'boolean'), ' --list': ('-C',), '  --extract': ('',), ' --deleteall': ('',)}
 
 import sepolicy
diff --git a/policycoreutils/semanage/semanage-boolean.8 b/policycoreutils/semanage/semanage-boolean.8
index 6eb6b69..0c48587 100644
--- a/policycoreutils/semanage/semanage-boolean.8
+++ b/policycoreutils/semanage/semanage-boolean.8
@@ -2,7 +2,7 @@
 .SH "NAME"
 semanage\-boolean \- SELinux Policy Management boolean tool
 .SH "SYNOPSIS"
-.B semanage boolean [\-h] [\-n] [\-N] [\-s STORE] [  \-\-extract  | \-\-deleteall  | \-\-list [\-C] | \-\-modify ( \-\-on | \-\-off ) boolean  ]
+.B semanage boolean [\-h] [\-n] [\-N] [\-S STORE] [  \-\-extract  | \-\-deleteall  | \-\-list [\-C] | \-\-modify ( \-\-on | \-\-off ) boolean  ]
 
 .SH "DESCRIPTION"
 semanage is used to configure certain elements of
diff --git a/policycoreutils/semanage/semanage-fcontext.8 b/policycoreutils/semanage/semanage-fcontext.8
index 7bbb0af..07c2831 100644
--- a/policycoreutils/semanage/semanage-fcontext.8
+++ b/policycoreutils/semanage/semanage-fcontext.8
@@ -3,7 +3,7 @@
 semanage\-fcontext \- SELinux Policy Management file context tool
 
 .SH "SYNOPSIS"
-.B semanage fcontext [\-h] [\-n] [\-N] [\-s STORE] [ \-\-add ( \-t TYPE \-f FTYPE \-r RANGE \-s SEUSER | \-e EQUAL ) FILE_SPEC ) | \-\-delete ( \-t TYPE \-f FTYPE | \-e EQUAL ) FILE_SPEC ) | \-\-deleteall  | \-\-extract  | \-\-list [\-C] | \-\-modify ( \-t TYPE \-f FTYPE \-r RANGE \-s SEUSER | \-e EQUAL ) FILE_SPEC ) ]
+.B semanage fcontext [\-h] [\-n] [\-N] [\-S STORE] [ \-\-add ( \-t TYPE \-f FTYPE \-r RANGE \-s SEUSER | \-e EQUAL ) FILE_SPEC ) | \-\-delete ( \-t TYPE \-f FTYPE | \-e EQUAL ) FILE_SPEC ) | \-\-deleteall  | \-\-extract  | \-\-list [\-C] | \-\-modify ( \-t TYPE \-f FTYPE \-r RANGE \-s SEUSER | \-e EQUAL ) FILE_SPEC ) ]
 
 .SH "DESCRIPTION"
 semanage is used to configure certain elements of
diff --git a/policycoreutils/semanage/semanage-interface.8 b/policycoreutils/semanage/semanage-interface.8
index fe8b250..fbab4b9 100644
--- a/policycoreutils/semanage/semanage-interface.8
+++ b/policycoreutils/semanage/semanage-interface.8
@@ -2,7 +2,7 @@
 .SH "NAME"
 .B semanage\-interface \- SELinux Policy Management network interface tool
 .SH "SYNOPSIS"
-.B semanage interface [\-h] [\-n] [\-N] [\-s STORE] [ \-\-add \-t TYPE \-r RANGE interface | \-\-delete interface | \-\-deleteall  | \-\-extract  | \-\-list [\-C] | \-\-modify \-t TYPE \-r RANGE interface ]
+.B semanage interface [\-h] [\-n] [\-N] [\-S STORE] [ \-\-add \-t TYPE \-r RANGE interface | \-\-delete interface | \-\-deleteall  | \-\-extract  | \-\-list [\-C] | \-\-modify \-t TYPE \-r RANGE interface ]
 
 .SH "DESCRIPTION"
 semanage is used to configure certain elements of
diff --git a/policycoreutils/semanage/semanage-login.8 b/policycoreutils/semanage/semanage-login.8
index 7cc5fde..a2397a0 100644
--- a/policycoreutils/semanage/semanage-login.8
+++ b/policycoreutils/semanage/semanage-login.8
@@ -2,7 +2,7 @@
 .SH "NAME"
 .B semanage\-login \- SELinux Policy Management linux user to SELinux User mapping tool
 .SH "SYNOPSIS"
-.B semanage login [\-h] [\-n] [\-N] [\-s STORE] [ \-\-add \-s SEUSER \-r RANGE LOGIN | \-\-delete LOGIN | \-\-deleteall  | \-\-extract  | \-\-list [\-C] | \-\-modify \-s SEUSER \-r RANGE LOGIN ]
+.B semanage login [\-h] [\-n] [\-N] [\-S STORE] [ \-\-add \-s SEUSER \-r RANGE LOGIN | \-\-delete LOGIN | \-\-deleteall  | \-\-extract  | \-\-list [\-C] | \-\-modify \-s SEUSER \-r RANGE LOGIN ]
 
 .SH "DESCRIPTION"
 semanage is used to configure certain elements of
diff --git a/policycoreutils/semanage/semanage-node.8 b/policycoreutils/semanage/semanage-node.8
index 0a2160d..e0b0e56 100644
--- a/policycoreutils/semanage/semanage-node.8
+++ b/policycoreutils/semanage/semanage-node.8
@@ -2,7 +2,7 @@
 .SH "NAME"
 .B semanage\-node \- SELinux Policy Management node mapping tool
 .SH "SYNOPSIS"
-.B semanage node [\-h] [\-n] [\-N] [\-s STORE] [ \-\-add \-M NETMASK \-p PROTOCOL \-t TYPE \-r RANGE node | \-\-delete \-M NETMASK \-p PROTOCOL node | \-\-deleteall  | \-\-extract  | \-\-list [\-C] | \-\-modify \-M NETMASK \-p PROTOCOL \-t TYPE \-r RANGE node ]
+.B semanage node [\-h] [\-n] [\-N] [\-S STORE] [ \-\-add \-M NETMASK \-p PROTOCOL \-t TYPE \-r RANGE node | \-\-delete \-M NETMASK \-p PROTOCOL node | \-\-deleteall  | \-\-extract  | \-\-list [\-C] | \-\-modify \-M NETMASK \-p PROTOCOL \-t TYPE \-r RANGE node ]
 
 .SH "DESCRIPTION"
 semanage is used to configure certain elements of
diff --git a/policycoreutils/semanage/semanage-port.8 b/policycoreutils/semanage/semanage-port.8
index 5a6a57f..666120e 100644
--- a/policycoreutils/semanage/semanage-port.8
+++ b/policycoreutils/semanage/semanage-port.8
@@ -2,7 +2,7 @@
 .SH "NAME"
 .B semanage\-port \- SELinux Policy Management port mapping tool
 .SH "SYNOPSIS"
-.B semanage port [\-h] [\-n] [\-N] [\-s STORE] [ \-\-add \-t TYPE \-p PROTOCOL \-r RANGE port_name | port_range | \-\-delete \-p PROTOCOL port_name | port_range | \-\-deleteall  | \-\-extract  | \-\-list [\-C] | \-\-modify \-t TYPE \-p PROTOCOL \-r RANGE port_name | port_range ]
+.B semanage port [\-h] [\-n] [\-N] [\-S STORE] [ \-\-add \-t TYPE \-p PROTOCOL \-r RANGE port_name | port_range | \-\-delete \-p PROTOCOL port_name | port_range | \-\-deleteall  | \-\-extract  | \-\-list [\-C] | \-\-modify \-t TYPE \-p PROTOCOL \-r RANGE port_name | port_range ]
 
 .SH "DESCRIPTION"
 semanage is used to configure certain elements of SELinux policy without requiring modification to or recompilation from policy sources.  semanage port controls the port number to port type definitions.
diff --git a/policycoreutils/semanage/semanage-user.8 b/policycoreutils/semanage/semanage-user.8
index 0e29334..2df03dd 100644
--- a/policycoreutils/semanage/semanage-user.8
+++ b/policycoreutils/semanage/semanage-user.8
@@ -2,7 +2,7 @@
 .SH "NAME"
 .B semanage\-user \- SELinux Policy Management SELinux User mapping tool
 .SH "SYNOPSIS"
-.B  semanage user [\-h] [\-n] [\-N] [\-s STORE] [ \-\-add ( \-L LEVEL \-R ROLES \-r RANGE \-s SEUSER selinux_name) | \-\-delete selinux_name | \-\-deleteall  | \-\-extract  | \-\-list [\-C] | \-\-modify ( \-L LEVEL \-R ROLES \-r RANGE \-s SEUSER selinux_name ) ]
+.B  semanage user [\-h] [\-n] [\-N] [\-S STORE] [ \-\-add ( \-L LEVEL \-R ROLES \-r RANGE \-s SEUSER selinux_name) | \-\-delete selinux_name | \-\-deleteall  | \-\-extract  | \-\-list [\-C] | \-\-modify ( \-L LEVEL \-R ROLES \-r RANGE \-s SEUSER selinux_name ) ]
 
 .SH "DESCRIPTION"
 semanage is used to configure certain elements of
-- 
1.8.3.1
