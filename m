Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rA6COEiS011596
	for <selinux@tycho.nsa.gov>; Wed, 6 Nov 2013 07:24:15 -0500
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id 00AF51A1A4
	for <selinux@tycho.nsa.gov>; Wed,  6 Nov 2013 13:24:10 +0100 (CET)
Received: from anor.bigon.be ([127.0.0.1])
	by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id R432Zq86Ukco for <selinux@tycho.nsa.gov>;
	Wed,  6 Nov 2013 13:24:05 +0100 (CET)
Received: from soldur.bigon.be (unknown [193.53.238.195])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id 34D5B1A1A5
	for <selinux@tycho.nsa.gov>; Wed,  6 Nov 2013 13:24:02 +0100 (CET)
From: Laurent Bigonville <bigon@debian.org>
To: SELinux <selinux@tycho.nsa.gov>
Subject: [PATCH 3/3] Minor manpages improvements
Date: Wed,  6 Nov 2013 13:24:01 +0100
Message-Id: <1383740641-9927-3-git-send-email-bigon@debian.org>
In-Reply-To: <1383740641-9927-1-git-send-email-bigon@debian.org>
References: <1383740641-9927-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Laurent Bigonville <bigon@bigon.be>

---
 policycoreutils/audit2allow/audit2allow.1      | 2 +-
 policycoreutils/gui/selinux-polgengui.8        | 2 +-
 policycoreutils/gui/system-config-selinux.8    | 2 +-
 policycoreutils/load_policy/load_policy.8      | 2 +-
 policycoreutils/mcstrans/man/man8/mcstransd.8  | 4 ++--
 policycoreutils/scripts/fixfiles.8             | 4 ++--
 policycoreutils/secon/secon.1                  | 2 +-
 policycoreutils/semanage/semanage-boolean.8    | 2 +-
 policycoreutils/semanage/semanage-dontaudit.8  | 2 +-
 policycoreutils/semanage/semanage-export.8     | 6 +++---
 policycoreutils/semanage/semanage-fcontext.8   | 2 +-
 policycoreutils/semanage/semanage-import.8     | 4 ++--
 policycoreutils/semanage/semanage-interface.8  | 4 ++--
 policycoreutils/semanage/semanage-login.8      | 8 ++++----
 policycoreutils/semanage/semanage-module.8     | 2 +-
 policycoreutils/semanage/semanage-node.8       | 2 +-
 policycoreutils/semanage/semanage-permissive.8 | 2 +-
 policycoreutils/semanage/semanage-port.8       | 2 +-
 policycoreutils/semanage/semanage-user.8       | 4 ++--
 policycoreutils/semanage/semanage.8            | 2 +-
 policycoreutils/sepolicy/sepolicy-generate.8   | 8 +++-----
 policycoreutils/setfiles/restorecon.8          | 4 ++--
 22 files changed, 35 insertions(+), 37 deletions(-)

diff --git a/policycoreutils/audit2allow/audit2allow.1 b/policycoreutils/audit2allow/audit2allow.1
index be4df24..21d286b 100644
--- a/policycoreutils/audit2allow/audit2allow.1
+++ b/policycoreutils/audit2allow/audit2allow.1
@@ -160,7 +160,7 @@ files_read_etc_files(myapp_t)
 # interface files.
 # You can create a te file and compile it by executing
 
-$ make -f /usr/share/selinux/devel/Makefile local.pp
+$ make \-f /usr/share/selinux/devel/Makefile local.pp
 
 
 # This make command will compile a local.te file in the current
diff --git a/policycoreutils/gui/selinux-polgengui.8 b/policycoreutils/gui/selinux-polgengui.8
index 52bf7dd..a13399f 100644
--- a/policycoreutils/gui/selinux-polgengui.8
+++ b/policycoreutils/gui/selinux-polgengui.8
@@ -29,7 +29,7 @@ selinux(1), sepolicy(8), sepolicy-generate(8)
 Report bugs to <http://bugzilla.redhat.com>.
 
 .SH LICENSE AND AUTHORS
-\fBselinux-polgengui\fP is licensed under the GNU Public License and
+\fBselinux-polgengui\fP is licensed under the GNU General Public License and
 is copyrighted by Red Hat, Inc.
 .br
 This man page was written by Daniel Walsh <dwalsh@redhat.com>
diff --git a/policycoreutils/gui/system-config-selinux.8 b/policycoreutils/gui/system-config-selinux.8
index a80cbf9..149570a 100644
--- a/policycoreutils/gui/system-config-selinux.8
+++ b/policycoreutils/gui/system-config-selinux.8
@@ -31,7 +31,7 @@ selinux(1), semanage(8)
 Report bugs to <http://bugzilla.redhat.com>.
 
 .SH LICENSE AND AUTHORS
-\fBsystem-config-selinux\fP is licensed under the GNU Public License and
+\fBsystem-config-selinux\fP is licensed under the GNU General Public License and
 is copyrighted by Red Hat, Inc.
 .br
 This man page was written by Daniel Walsh <dwalsh@redhat.com>
diff --git a/policycoreutils/load_policy/load_policy.8 b/policycoreutils/load_policy/load_policy.8
index a86073f..38c01b6 100644
--- a/policycoreutils/load_policy/load_policy.8
+++ b/policycoreutils/load_policy/load_policy.8
@@ -4,7 +4,7 @@ load_policy \- load a new SELinux policy into the kernel
 
 .SH SYNOPSIS
 .B load_policy 
-[-qi]
+[\-qi]
 .br
 .SH DESCRIPTION
 .PP
diff --git a/policycoreutils/mcstrans/man/man8/mcstransd.8 b/policycoreutils/mcstrans/man/man8/mcstransd.8
index 0be6468..c1dc483 100644
--- a/policycoreutils/mcstrans/man/man8/mcstransd.8
+++ b/policycoreutils/mcstrans/man/man8/mcstransd.8
@@ -14,10 +14,10 @@ program.
 This daemon reads /etc/selinux/{SELINUXTYPE}/setrans.conf configuration file, and communicates with libselinux via a socket in /var/run/setrans.
 .SH "OPTIONS"
 .TP
--f
+\-f
 Run mcstransd in the foreground.  Do not run as a daemon.
 .TP
--h
+\-h
 Output a short summary of available command line options\&.
 
 .SH "AUTHOR"
diff --git a/policycoreutils/scripts/fixfiles.8 b/policycoreutils/scripts/fixfiles.8
index 9f660dc..1b9a2d6 100644
--- a/policycoreutils/scripts/fixfiles.8
+++ b/policycoreutils/scripts/fixfiles.8
@@ -60,11 +60,11 @@ Run a diff on  the PREVIOUS_FILECONTEXT file to the currently installed one, and
 .TP 
 .B \-N time
 Only act on files created after the specified date.  Date must be specified in
-"YYYY-MM-DD HH:MM" format.  Date field will be passed to find --newermt command.
+"YYYY\-MM\-DD HH:MM" format.  Date field will be passed to find \-\-newermt command.
 
 .TP
 .B -v
-Modify verbosity from progress to verbose. (Run restorecon with -v instead of -p)
+Modify verbosity from progress to verbose. (Run restorecon with \-v instead of \-p)
 
 .SH "ARGUMENTS"
 One of:
diff --git a/policycoreutils/secon/secon.1 b/policycoreutils/secon/secon.1
index 04b3fd3..3a8e0dd 100644
--- a/policycoreutils/secon/secon.1
+++ b/policycoreutils/secon/secon.1
@@ -31,7 +31,7 @@ shows the usage information for secon
 outputs data in a format suitable for a prompt
 .TP
 \fB\-C\fR, \fB\-\-color\fR
-outputs data with the associated ANSI color codes (requires -P)
+outputs data with the associated ANSI color codes (requires \-P)
 .TP
 \fB\-u\fR, \fB\-\-user\fR
 show the user of the security context
diff --git a/policycoreutils/semanage/semanage-boolean.8 b/policycoreutils/semanage/semanage-boolean.8
index 4195d50..6eb6b69 100644
--- a/policycoreutils/semanage/semanage-boolean.8
+++ b/policycoreutils/semanage/semanage-boolean.8
@@ -1,6 +1,6 @@
 .TH "semanage-boolean" "8" "20130617" "" ""
 .SH "NAME"
-semanage boolean\- SELinux Policy Management boolean tool
+semanage\-boolean \- SELinux Policy Management boolean tool
 .SH "SYNOPSIS"
 .B semanage boolean [\-h] [\-n] [\-N] [\-s STORE] [  \-\-extract  | \-\-deleteall  | \-\-list [\-C] | \-\-modify ( \-\-on | \-\-off ) boolean  ]
 
diff --git a/policycoreutils/semanage/semanage-dontaudit.8 b/policycoreutils/semanage/semanage-dontaudit.8
index 65002f3..122780d 100644
--- a/policycoreutils/semanage/semanage-dontaudit.8
+++ b/policycoreutils/semanage/semanage-dontaudit.8
@@ -1,6 +1,6 @@
 .TH "semanage-dontaudit" "8" "20130617" "" ""
 .SH "NAME"
-.B semanage dontaudit\- SELinux Policy Management dontaudit tool
+.B semanage\-dontaudit \- SELinux Policy Management dontaudit tool
 .SH "SYNOPSIS"
 .B semanage dontaudit [\-h] [\-S STORE] [\-N] {on,off}
 
diff --git a/policycoreutils/semanage/semanage-export.8 b/policycoreutils/semanage/semanage-export.8
index 1d32a0a..469b1bb 100644
--- a/policycoreutils/semanage/semanage-export.8
+++ b/policycoreutils/semanage/semanage-export.8
@@ -1,6 +1,6 @@
 .TH "semanage-export" "8" "20130617" "" ""
 .SH "NAME"
-.B semanage export\- SELinux Policy Management import tool
+.B semanage\-export \- SELinux Policy Management import tool
 .SH "SYNOPSIS"
 .B semanage export [\-h] [\-S STORE] [\-f OUTPUT_FILE]
 
@@ -23,10 +23,10 @@ Output file
 .SH EXAMPLE
 .nf
 Import semanage modifications from another machine
-# semanage export -f semanage.mods
+# semanage export \-f semanage.mods
 # scp semanage.mod remotemachine:
 # ssh remotemachine
-# semanage import -f semanage.mods
+# semanage import \-f semanage.mods
 
 .SH "SEE ALSO"
 .B selinux (8),
diff --git a/policycoreutils/semanage/semanage-fcontext.8 b/policycoreutils/semanage/semanage-fcontext.8
index 7369af7..7bbb0af 100644
--- a/policycoreutils/semanage/semanage-fcontext.8
+++ b/policycoreutils/semanage/semanage-fcontext.8
@@ -1,6 +1,6 @@
 .TH "semanage-fcontext" "8" "20130617" "" ""
 .SH "NAME"
-semanage fcontext\- SELinux Policy Management file context tool
+semanage\-fcontext \- SELinux Policy Management file context tool
 
 .SH "SYNOPSIS"
 .B semanage fcontext [\-h] [\-n] [\-N] [\-s STORE] [ \-\-add ( \-t TYPE \-f FTYPE \-r RANGE \-s SEUSER | \-e EQUAL ) FILE_SPEC ) | \-\-delete ( \-t TYPE \-f FTYPE | \-e EQUAL ) FILE_SPEC ) | \-\-deleteall  | \-\-extract  | \-\-list [\-C] | \-\-modify ( \-t TYPE \-f FTYPE \-r RANGE \-s SEUSER | \-e EQUAL ) FILE_SPEC ) ]
diff --git a/policycoreutils/semanage/semanage-import.8 b/policycoreutils/semanage/semanage-import.8
index fb95a04..5437de3 100644
--- a/policycoreutils/semanage/semanage-import.8
+++ b/policycoreutils/semanage/semanage-import.8
@@ -1,6 +1,6 @@
 .TH "semanage-import" "8" "20130617" "" ""
 .SH "NAME"
-.B semanage import\- SELinux Policy Management import tool
+.B semanage\-import \- SELinux Policy Management import tool
 .SH "SYNOPSIS"
 .B semanage import [\-h] [\-N] [\-S STORE] [\-f INPUT_FILE]
 
@@ -25,7 +25,7 @@ Input file
 .SH EXAMPLE
 .nf
 Import semanage modifications from another machine
-# semanage import -f semanage.mods
+# semanage import \-f semanage.mods
 
 .SH "SEE ALSO"
 .B selinux (8),
diff --git a/policycoreutils/semanage/semanage-interface.8 b/policycoreutils/semanage/semanage-interface.8
index c9dd59c..d318bb8 100644
--- a/policycoreutils/semanage/semanage-interface.8
+++ b/policycoreutils/semanage/semanage-interface.8
@@ -1,6 +1,6 @@
 .TH "semanage-interface" "8" "20130617" "" ""
 .SH "NAME"
-.B semanage interface\- SELinux Policy Management network interface tool
+.B semanage\-interface \- SELinux Policy Management network interface tool
 .SH "SYNOPSIS"
 .B semanage interface [\-h] [\-n] [\-N] [\-s STORE] [ \-\-add \-t TYPE \-r RANGE interface | \-\-delete interface | \-\-deleteall  | \-\-extract  | \-\-list [\-C] | \-\-modify \-t TYPE \-r RANGE interface ]
 
@@ -53,7 +53,7 @@ MLS/MCS Security Range (MLS/MCS Systems only) SELinux Range for SELinux login ma
 .SH EXAMPLE
 .nf
 list all interface defitions
-# semanage interface -l
+# semanage interface \-l
 
 .SH "SEE ALSO"
 .B selinux (8),
diff --git a/policycoreutils/semanage/semanage-login.8 b/policycoreutils/semanage/semanage-login.8
index 78a0ecb..7cc5fde 100644
--- a/policycoreutils/semanage/semanage-login.8
+++ b/policycoreutils/semanage/semanage-login.8
@@ -1,6 +1,6 @@
 .TH "semanage-login" "8" "20130617" "" ""
 .SH "NAME"
-.B semanage login\- SELinux Policy Management linux user to SELinux User mapping tool
+.B semanage\-login \- SELinux Policy Management linux user to SELinux User mapping tool
 .SH "SYNOPSIS"
 .B semanage login [\-h] [\-n] [\-N] [\-s STORE] [ \-\-add \-s SEUSER \-r RANGE LOGIN | \-\-delete LOGIN | \-\-deleteall  | \-\-extract  | \-\-list [\-C] | \-\-modify \-s SEUSER \-r RANGE LOGIN ]
 
@@ -53,11 +53,11 @@ MLS/MCS Security Range (MLS/MCS Systems only) SELinux Range for SELinux login ma
 .SH EXAMPLE
 .nf
 Modify the default user on the system to the guest_u user
-# semanage login -m -s guest_u __default__
+# semanage login \-m \-s guest_u __default__
 Assign gijoe user on an MLS machine  a range and to the staff_u user
-# semanage login -a -s staff_u -rSystemLow-Secret gijoe
+# semanage login \-a \-s staff_u \-rSystemLow-Secret gijoe
 Assign all users in the engineering group to the staff_u user
-# semanage login -a -s staff_u %engineering
+# semanage login \-a \-s staff_u %engineering
 
 .SH "SEE ALSO"
 .B selinux (8),
diff --git a/policycoreutils/semanage/semanage-module.8 b/policycoreutils/semanage/semanage-module.8
index fd236f7..42d6862 100644
--- a/policycoreutils/semanage/semanage-module.8
+++ b/policycoreutils/semanage/semanage-module.8
@@ -1,6 +1,6 @@
 .TH "semanage-module" "8" "20130617" "" ""
 .SH "NAME"
-.B semanage module\\- SELinux Policy Management module mapping tool
+.B semanage\-module \- SELinux Policy Management module mapping tool
 .SH "SYNOPSIS"
 .B semanage module [\-h] [\-n] [\-N] [\-S STORE] (\-a | \-r | \-e | \-d | \-\-extract | \-\-list [\-C] | \-\-deleteall) [module_name]
 
diff --git a/policycoreutils/semanage/semanage-node.8 b/policycoreutils/semanage/semanage-node.8
index 75c2d30..0a2160d 100644
--- a/policycoreutils/semanage/semanage-node.8
+++ b/policycoreutils/semanage/semanage-node.8
@@ -1,6 +1,6 @@
 .TH "semanage-node" "8" "20130617" "" ""
 .SH "NAME"
-.B semanage node\- SELinux Policy Management node mapping tool
+.B semanage\-node \- SELinux Policy Management node mapping tool
 .SH "SYNOPSIS"
 .B semanage node [\-h] [\-n] [\-N] [\-s STORE] [ \-\-add \-M NETMASK \-p PROTOCOL \-t TYPE \-r RANGE node | \-\-delete \-M NETMASK \-p PROTOCOL node | \-\-deleteall  | \-\-extract  | \-\-list [\-C] | \-\-modify \-M NETMASK \-p PROTOCOL \-t TYPE \-r RANGE node ]
 
diff --git a/policycoreutils/semanage/semanage-permissive.8 b/policycoreutils/semanage/semanage-permissive.8
index 9a143df..ee30c85 100644
--- a/policycoreutils/semanage/semanage-permissive.8
+++ b/policycoreutils/semanage/semanage-permissive.8
@@ -1,6 +1,6 @@
 .TH "semanage-permissive" "8" "20130617" "" ""
 .SH "NAME"
-.B semanage permissive \- SELinux Policy Management permissive mapping tool
+.B semanage\-permissive \- SELinux Policy Management permissive mapping tool
 .SH "SYNOPSIS"
 .B semanage permissive [\-h] (\-a | \-d | \-l) [\-n] [\-N] [\-S STORE] [type]
 
diff --git a/policycoreutils/semanage/semanage-port.8 b/policycoreutils/semanage/semanage-port.8
index cd0a1b4..9aefd3b 100644
--- a/policycoreutils/semanage/semanage-port.8
+++ b/policycoreutils/semanage/semanage-port.8
@@ -1,6 +1,6 @@
 .TH "semanage-port" "8" "20130617" "" ""
 .SH "NAME"
-.B semanage port\- SELinux Policy Management port mapping tool
+.B semanage\-port \- SELinux Policy Management port mapping tool
 .SH "SYNOPSIS"
 .B semanage port [\-h] [\-n] [\-N] [\-s STORE] [ \-\-add \-t TYPE \-p PROTOCOL \-r RANGE port_name | port_range | \-\-delete \-p PROTOCOL port_name | port_range | \-\-deleteall  | \-\-extract  | \-\-list [\-C] | \-\-modify \-t TYPE \-p PROTOCOL \-r RANGE port_name | port_range ]
 
diff --git a/policycoreutils/semanage/semanage-user.8 b/policycoreutils/semanage/semanage-user.8
index 7259ea9..0e29334 100644
--- a/policycoreutils/semanage/semanage-user.8
+++ b/policycoreutils/semanage/semanage-user.8
@@ -1,6 +1,6 @@
 .TH "semanage-user" "8" "20130617" "" ""
 .SH "NAME"
-.B semanage user\- SELinux Policy Management SELinux User mapping tool
+.B semanage\-user \- SELinux Policy Management SELinux User mapping tool
 .SH "SYNOPSIS"
 .B  semanage user [\-h] [\-n] [\-N] [\-s STORE] [ \-\-add ( \-L LEVEL \-R ROLES \-r RANGE \-s SEUSER selinux_name) | \-\-delete selinux_name | \-\-deleteall  | \-\-extract  | \-\-list [\-C] | \-\-modify ( \-L LEVEL \-R ROLES \-r RANGE \-s SEUSER selinux_name ) ]
 
@@ -60,7 +60,7 @@ List SELinux users
 Modify groups for staff_u user
 # semanage user \-m \-R "system_r unconfined_r staff_r" staff_u
 Add level for TopSecret Users
-# semanage user \-a \-R "staff_r" -rs0-TopSecret topsecret_u
+# semanage user \-a \-R "staff_r" \-rs0\-TopSecret topsecret_u
 
 .SH "SEE ALSO"
 .B selinux (8),
diff --git a/policycoreutils/semanage/semanage.8 b/policycoreutils/semanage/semanage.8
index cba2c9c..0fad36c 100644
--- a/policycoreutils/semanage/semanage.8
+++ b/policycoreutils/semanage/semanage.8
@@ -86,4 +86,4 @@ This man page was written by Daniel Walsh <dwalsh@redhat.com>
 and Russell Coker <rcoker@redhat.com>.
 .br
 Examples by Thomas Bleher <ThomasBleher@gmx.de>.
-usage: semanage [-h]
+usage: semanage [\-h]
diff --git a/policycoreutils/sepolicy/sepolicy-generate.8 b/policycoreutils/sepolicy/sepolicy-generate.8
index 96c20fc..2e67456 100644
--- a/policycoreutils/sepolicy/sepolicy-generate.8
+++ b/policycoreutils/sepolicy/sepolicy-generate.8
@@ -54,7 +54,7 @@ Use \fBsepolicy generate\fP to generate an SELinux policy Module.
 
 When specifying a \fBconfined application\fP you must specify a
 path. \fBsepolicy generate\fP will use the rpm payload of the
-application along with \fBnm -D APPLICATION\fP to help it generate
+application along with \fBnm \-D APPLICATION\fP to help it generate
 types and policy rules for your policy files.
 
 .B Type Enforcing File NAME.te
@@ -75,7 +75,7 @@ file paths to the types.  Tools like restorecon and RPM will use these paths to
 
 .B RPM Spec File NAME_selinux.spec
 .br
-This file is an RPM SPEC file that can be used to install the SELinux policy on to machines and setup the labeling. The spec file also installs the interface file and a man page describing the policy.  You can use \fBsepolicy manpage -d NAME\fP to generate the man page.
+This file is an RPM SPEC file that can be used to install the SELinux policy on to machines and setup the labeling. The spec file also installs the interface file and a man page describing the policy.  You can use \fBsepolicy manpage \-d NAME\fP to generate the man page.
 
 .B Shell File NAME.sh
 .br
@@ -158,9 +158,7 @@ Generate Policy for Minimal X Windows Login User Role
 .br
 Generating Policy for /usr/sbin/rwhod named rwhod
 .br
-Created the following files in:
-.br
-./
+Created the following files:
 .br
 rwhod.te # Type Enforcement file
 .br
diff --git a/policycoreutils/setfiles/restorecon.8 b/policycoreutils/setfiles/restorecon.8
index 672bbd2..ab43206 100644
--- a/policycoreutils/setfiles/restorecon.8
+++ b/policycoreutils/setfiles/restorecon.8
@@ -25,7 +25,7 @@ check whether the file contexts are all set as specified by the active policy
 If a file object does not have a context, restorecon will write the default
 context to the file object's extended attributes. If a file object has a
 context, restorecon will only modify the type portion of the security context.
-The -F option will force a replacement of the entire context.
+The \-F option will force a replacement of the entire context.
 .P
 It is the same executable as
 .BR setfiles
@@ -50,7 +50,7 @@ display usage information and exit.
 ignore files that do not exist.
 .TP
 .B \-n
-don't change any file labels (passive check).  To display the files whose labels would be changed, add -v.
+don't change any file labels (passive check).  To display the files whose labels would be changed, add \-v.
 .TP
 .B \-o outfilename
 Deprecated, SELinux policy will probably block this access.  Use shell redirection to save list of files with incorrect context in filename.
-- 
1.8.4.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
