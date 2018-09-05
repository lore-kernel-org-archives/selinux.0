Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w85LpMpc007683
 for <selinux@tycho.nsa.gov>; Wed, 5 Sep 2018 17:51:22 -0400
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr
 [89.156.252.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 44F7E561235
 for <selinux@tycho.nsa.gov>; Wed,  5 Sep 2018 23:49:13 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Wed,  5 Sep 2018 23:49:05 +0200
Message-Id: <20180905214906.11016-1-nicolas.iooss@m4x.org>
Subject: [PATCH 1/2] semanage: "semanage user" does not use -s,
 fix documentation
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Both "semanage user --help" and "man 8 semanage-user" state that
"semanage user" accepts option -s, but this is incorrect: -s is not
needed to specify the SELinux user on the command line, contrary to
"semanage login" for example. Fix the documention.

While at it, remove many spaces from the helptext of option --roles. I
do not know where they came from, but they were reduced to a single
space when displayed anyway.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/semanage/semanage        | 4 ++--
 python/semanage/semanage-user.8 | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/python/semanage/semanage b/python/semanage/semanage
index 8d8a086094c9..e32d1e8ad387 100644
--- a/python/semanage/semanage
+++ b/python/semanage/semanage
@@ -53,7 +53,7 @@ usage_fcontext = "semanage fcontext [-h] [-n] [-N] [-S STORE] ["
 usage_fcontext_dict = {' --add': ('(', '-t TYPE', '-f FTYPE', '-r RANGE', '-s SEUSER', '|', '-e EQUAL', ')', 'FILE_SPEC',), ' --delete': ('(', '-t TYPE', '-f FTYPE', '|', '-e EQUAL', ')', 'FILE_SPEC',), ' --modify': ('(', '-t TYPE', '-f FTYPE', '-r RANGE', '-s SEUSER', '|', '-e EQUAL', ')', 'FILE_SPEC',), ' --list': ('[-C]',), ' --extract': ('',), ' --deleteall': ('',)}
 
 usage_user = "semanage user [-h] [-n] [-N] [-S STORE] ["
-usage_user_dict = {' --add': ('(', '-L LEVEL', '-R ROLES', '-r RANGE', '-s SEUSER', 'selinux_name'')'), ' --delete': ('selinux_name',), ' --modify': ('(', '-L LEVEL', '-R ROLES', '-r RANGE', '-s SEUSER', 'selinux_name', ')'), ' --list': ('-C',), ' --extract': ('',), ' --deleteall': ('',)}
+usage_user_dict = {' --add': ('(', '-L LEVEL', '-R ROLES', '-r RANGE', 'SEUSER', ')'), ' --delete': ('SEUSER',), ' --modify': ('(', '-L LEVEL', '-R ROLES', '-r RANGE', '-s SEUSER', 'SEUSER', ')'), ' --list': ('-C',), ' --extract': ('',), ' --deleteall': ('',)}
 
 usage_port = "semanage port [-h] [-n] [-N] [-S STORE] ["
 usage_port_dict = {' --add': ('-t TYPE', '-p PROTOCOL', '-r RANGE', '(', 'port_name', '|', 'port_range', ')'), ' --modify': ('-t TYPE', '-p PROTOCOL', '-r RANGE', '(', 'port_name', '|', 'port_range', ')'), ' --delete': ('-p PROTOCOL', '(', 'port_name', '|', 'port_range', ')'), ' --list': ('-C',), ' --extract': ('',), ' --deleteall': ('',)}
@@ -421,7 +421,7 @@ def setupUserParser(subparsers):
     userParser.add_argument('-R', '--roles', default=[],
                             action=CheckRole,
                             help=_('''
-SELinux Roles.  You must enclose multiple roles within quotes,                  separate by spaces. Or specify -R multiple times.
+SELinux Roles.  You must enclose multiple roles within quotes, separate by spaces. Or specify -R multiple times.
 '''))
     userParser.add_argument('-P', '--prefix', default="user", help=argparse.SUPPRESS)
     userParser.add_argument('selinux_name', nargs='?', default=None, help=_('selinux_name'))
diff --git a/python/semanage/semanage-user.8 b/python/semanage/semanage-user.8
index 30bc67052ed7..23fec698e042 100644
--- a/python/semanage/semanage-user.8
+++ b/python/semanage/semanage-user.8
@@ -2,7 +2,7 @@
 .SH "NAME"
 .B semanage\-user \- SELinux Policy Management SELinux User mapping tool
 .SH "SYNOPSIS"
-.B  semanage user [\-h] [\-n] [\-N] [\-S STORE] [ \-\-add ( \-L LEVEL \-R ROLES \-r RANGE \-s SEUSER selinux_name) | \-\-delete selinux_name | \-\-deleteall  | \-\-extract  | \-\-list [\-C] | \-\-modify ( \-L LEVEL \-R ROLES \-r RANGE \-s SEUSER selinux_name ) ]
+.B  semanage user [\-h] [\-n] [\-N] [\-S STORE] [ \-\-add ( \-L LEVEL \-R ROLES \-r RANGE SEUSER) | \-\-delete SEUSER | \-\-deleteall  | \-\-extract  | \-\-list [\-C] | \-\-modify ( \-L LEVEL \-R ROLES \-r RANGE SEUSER ) ]
 
 .SH "DESCRIPTION"
 semanage is used to configure certain elements of
-- 
2.18.0
