Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2D8D4kw017738
 for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2018 04:13:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC14.oob.disa.mil (Postfix) with SMTP id 400nf63Bqjz31Jv
 for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2018 08:12:46 +0000 (UTC)
Received: from UPDC3CPA07_EEMSG_MP23.eemsg.mil (unknown [192.168.18.18])
 by UPDCF3IC14.oob.disa.mil (Postfix) with ESMTP id 400nf62B9pz31Jt
 for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2018 08:12:46 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7C7554023BB3
 for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2018 08:12:43 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2059B1102E20
 for <selinux@tycho.nsa.gov>; Tue, 13 Mar 2018 08:12:42 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Date: Tue, 13 Mar 2018 09:12:37 +0100
Message-Id: <20180313081237.23300-1-vmojzis@redhat.com>
In-Reply-To: <20180312150948.3087-1-vmojzis@redhat.com>
References: <20180312150948.3087-1-vmojzis@redhat.com>
Subject: [PATCH] policycoreutils/semodule: Improve man page and
 unify it with --help
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Unify the way parameters are described in man pages and --help message.
Explain special syntax allowing the user to specify multiple modules when using
-i/u/r/E mods.
Point out that priority has to be specified in order to remove module at
different priority than 400 and that "-d" disables all instances of
given module across priorities.

Resolves: rhbz#1320565, rhbz#1337192

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 policycoreutils/semodule/semodule.8 | 34 ++++++++++++++++++++--------------
 policycoreutils/semodule/semodule.c |  8 ++++----
 2 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semodule/semodule.8
index 849a0426..18d4f708 100644
--- a/policycoreutils/semodule/semodule.8
+++ b/policycoreutils/semodule/semodule.8
@@ -3,7 +3,7 @@
 semodule \- Manage SELinux policy modules.
 
 .SH SYNOPSIS
-.B semodule [options]... MODE [MODES]...
+.B semodule [option]... MODE...
 .br
 .SH DESCRIPTION
 .PP
@@ -15,7 +15,7 @@ any other transaction.  semodule acts on module packages created
 by semodule_package.  Conventionally, these files have a .pp suffix
 (policy package), although this is not mandated in any way.
 
-.SH "OPTIONS"
+.SH "MODES"
 .TP
 .B \-R, \-\-reload
 force a reload of policy
@@ -36,16 +36,11 @@ deprecated, alias for --install
 deprecated, alias for --install
 .TP
 .B  \-r,\-\-remove=MODULE_NAME
-remove existing module
+remove existing module at desired priority (defaults to -X 400)
 .TP
 .B  \-l[KIND],\-\-list-modules[=KIND]
 display list of installed modules (other than base)
 .TP
-.B  \-E,\-\-extract=MODULE_PKG
-Extract a module from the store as an HLL or CIL file to the current directory.
-A module is extracted as HLL by default. The name of the module written is
-<module-name>.<lang_ext>
-.TP
 .B  KIND:
 .TP
 standard
@@ -57,12 +52,18 @@ list all modules
 .B  \-X,\-\-priority=PRIORITY
 set priority for following operations (1-999)
 .TP
-.B  \-e,\-\-enabled=MODULE_NAME
+.B  \-e,\-\-enable=MODULE_NAME
 enable module
 .TP
 .B  \-d,\-\-disable=MODULE_NAME
 disable module
 .TP
+.B  \-E,\-\-extract=MODULE_PKG
+Extract a module from the store as an HLL or CIL file to the current directory.
+A module is extracted as HLL by default. The name of the module written is
+<module-name>.<lang_ext>
+.SH "OPTIONS"
+.TP
 .B  \-s,\-\-store
 name of the store to operate on
 .TP
@@ -101,17 +102,22 @@ only modules listed in \-\-extract after this option.
 $ semodule \-b base.pp
 # Install or replace a non-base policy package.
 $ semodule \-i httpd.pp
+# Install or replace all non-base modules in the current directory.
+# This syntax can be used with -i/u/r/E, but no other option can be entered after the module names
+$ semodule \-i *.pp
+# Install or replace all modules in the current directory.
+$ ls *.pp | grep \-Ev "base.pp|enableaudit.pp" | xargs /usr/sbin/semodule \-b base.pp \-i
 # List non-base modules.
 $ semodule \-l
+# List all modules including priorities
+$ semodule \-lfull
+# Remove a module at priority 100
+$ semodule \-X 100 \-r wireshark
 # Turn on all AVC Messages for which SELinux currently is "dontaudit"ing.
 $ semodule \-DB
 # Turn "dontaudit" rules back on.
 $ semodule \-B
-# Install or replace all non-base modules in the current directory.
-$ semodule \-i *.pp
-# Install or replace all modules in the current directory.
-$ ls *.pp | grep \-Ev "base.pp|enableaudit.pp" | xargs /usr/sbin/semodule \-b base.pp \-i
-# Disable a module.
+# Disable a module (all instances of given module across priorities will be disabled).
 $ semodule \-d alsa
 # Install a module at a specific priority.
 $ semodule \-X 100 \-i alsa.pp
diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
index c63a8647..504247d3 100644
--- a/policycoreutils/semodule/semodule.c
+++ b/policycoreutils/semodule/semodule.c
@@ -120,13 +120,14 @@ static void create_signal_handlers(void)
 
 static void usage(char *progname)
 {
-	printf("usage:  %s [options]... MODE [MODES]...\n", progname);
+	printf("usage:  %s [option]... MODE...\n", progname);
 	printf("Manage SELinux policy modules.\n");
 	printf("MODES:\n");
 	printf("  -R, --reload		    reload policy\n");
 	printf("  -B, --build		    build and reload policy\n");
+	printf("  -D,--disable_dontaudit    Remove dontaudits from policy\n");
 	printf("  -i,--install=MODULE_PKG   install a new module\n");
-	printf("  -r,--remove=MODULE_NAME   remove existing module\n");
+	printf("  -r,--remove=MODULE_NAME   remove existing module at desired priority\n");
 	printf("  -l[KIND],--list-modules[=KIND]  display list of installed modules\n");
 	printf("     KIND:  standard  list highest priority, enabled modules\n");
 	printf("            full      list all modules\n");
@@ -134,12 +135,11 @@ static void usage(char *progname)
 	printf("  -e,--enable=MODULE_NAME   enable module\n");
 	printf("  -d,--disable=MODULE_NAME  disable module\n");
 	printf("  -E,--extract=MODULE_NAME  extract module\n");
-	printf("Other options:\n");
+	printf("Options:\n");
 	printf("  -s,--store	   name of the store to operate on\n");
 	printf("  -N,-n,--noreload do not reload policy after commit\n");
 	printf("  -h,--help        print this message and quit\n");
 	printf("  -v,--verbose     be verbose\n");
-	printf("  -D,--disable_dontaudit	Remove dontaudits from policy\n");
 	printf("  -P,--preserve_tunables	Preserve tunables in policy\n");
 	printf("  -C,--ignore-module-cache	Rebuild CIL modules compiled from HLL files\n");
 	printf("  -p,--path        use an alternate path for the policy root\n");
-- 
2.14.3
