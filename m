Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0BCfPqF023269
 for <selinux@tycho.nsa.gov>; Wed, 11 Jan 2017 07:41:25 -0500
Received: by mail-wj0-f177.google.com with SMTP id i20so100967657wjn.2
 for <selinux@tycho.nsa.gov>; Wed, 11 Jan 2017 04:41:20 -0800 (PST)
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Subject: [PATCH] policycoreutils,
 python: Fix bad manpage formatting in "SEE ALSO"
Date: Wed, 11 Jan 2017 12:41:09 +0000
Message-Id: <20170111124110.5721-1-alan.christopher.jenkins@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fix missing and surplus commas.  Fix the following formatting errors:

    .BR selinux(8)

renders the the "(8)" in bold as well as the "selinux".  This is wrong.

    .B selinux
    (8)

renders with a space between "selinux" and "(8)", this is wrong.

    .B selinux (8)

commits both of the above mistakes.

    .BR selinux (8), apparmor (8)

omits the space separating "selinux(8)," and "apparmor(8)", this is wrong.
Correct all the above using the following markup:

    .BR selinux (8),
    .BR apparmor (8)

Signed-off-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>
---
 policycoreutils/load_policy/load_policy.8 |  3 +--
 policycoreutils/newrole/newrole.1         |  3 +--
 policycoreutils/run_init/run_init.8       |  6 ++----
 policycoreutils/scripts/fixfiles.8        |  3 ++-
 policycoreutils/secon/secon.1             |  3 +--
 policycoreutils/semodule/semodule.8       |  3 ++-
 python/semanage/semanage-boolean.8        |  8 ++++----
 python/semanage/semanage-dontaudit.8      |  4 ++--
 python/semanage/semanage-export.8         |  6 +++---
 python/semanage/semanage-fcontext.8       |  4 ++--
 python/semanage/semanage-interface.8      |  4 ++--
 python/semanage/semanage-login.8          |  6 +++---
 python/semanage/semanage-module.8         |  6 +++---
 python/semanage/semanage-permissive.8     |  4 ++--
 python/semanage/semanage-port.8           |  4 ++--
 python/semanage/semanage-user.8           |  6 +++---
 python/semanage/semanage.8                | 26 +++++++++++++-------------
 17 files changed, 48 insertions(+), 51 deletions(-)

diff --git a/policycoreutils/load_policy/load_policy.8 b/policycoreutils/load_policy/load_policy.8
index 38c01b6..5f5550d 100644
--- a/policycoreutils/load_policy/load_policy.8
+++ b/policycoreutils/load_policy/load_policy.8
@@ -35,8 +35,7 @@ Policy load failed
 .B 3
 Initial policy load failed and enforcing mode requested
 .SH SEE ALSO
-.B booleans
-(8),
+.BR booleans (8)
 .SH AUTHORS
 .nf
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
diff --git a/policycoreutils/newrole/newrole.1 b/policycoreutils/newrole/newrole.1
index 96cdd14..0d9738a 100644
--- a/policycoreutils/newrole/newrole.1
+++ b/policycoreutils/newrole/newrole.1
@@ -110,8 +110,7 @@ Running a program in a given role or level:
 /etc/selinux/newrole_pam.conf - optional mapping of commands to separate pam service names
 .br
 .SH SEE ALSO
-.B runcon
-(1)
+.BR runcon (1)
 .SH AUTHORS
 .nf
 Anthony Colatrella
diff --git a/policycoreutils/run_init/run_init.8 b/policycoreutils/run_init/run_init.8
index 9fb5249..a031d5d 100644
--- a/policycoreutils/run_init/run_init.8
+++ b/policycoreutils/run_init/run_init.8
@@ -20,10 +20,8 @@ not required.  Check your PAM documentation.
 .br
 /etc/selinux/POLICYTYPE/contexts/initrc_context - contains the context to run init scripts under
 .SH SEE ALSO
-.B newrole
-(1),
-.B runcon
-(1)
+.BR newrole (1),
+.BR runcon (1)
 .SH AUTHORS
 .nf
 Wayne Salamon (wsalamon@tislabs.com) 
diff --git a/policycoreutils/scripts/fixfiles.8 b/policycoreutils/scripts/fixfiles.8
index 1b9a2d6..0099b9b 100644
--- a/policycoreutils/scripts/fixfiles.8
+++ b/policycoreutils/scripts/fixfiles.8
@@ -89,5 +89,6 @@ This man page was written by Richard Hally <rhally@mindspring.com>.
 The script  was written by Dan Walsh <dwalsh@redhat.com>
 
 .SH "SEE ALSO"
-.BR setfiles (8), restorecon(8)
+.BR setfiles (8),
+.BR restorecon (8)
 
diff --git a/policycoreutils/secon/secon.1 b/policycoreutils/secon/secon.1
index a0ff795..501b5cb 100644
--- a/policycoreutils/secon/secon.1
+++ b/policycoreutils/secon/secon.1
@@ -116,8 +116,7 @@ If none of \fB\-\-user\fR, \fB\-\-role\fR, \fB\-\-type\fR, \fB\-\-level\fR or
 Then all of them will be output.
 .PP
 .SH SEE ALSO
-.B chcon
-(1)
+.BR chcon (1)
 .SH AUTHORS
 .nf
 James Antill (james.antill@redhat.com) 
diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semodule/semodule.8
index 0c5fdf7..849a042 100644
--- a/policycoreutils/semodule/semodule.8
+++ b/policycoreutils/semodule/semodule.8
@@ -127,7 +127,8 @@ $ semodule \-X 400 \-\-hll \-E puppet \-\-cil \-E wireshark
 .fi
 
 .SH SEE ALSO
-.B checkmodule(8), semodule_package(8)
+.BR checkmodule (8),
+.BR semodule_package (8)
 .SH AUTHORS
 .nf
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
diff --git a/python/semanage/semanage-boolean.8 b/python/semanage/semanage-boolean.8
index 0c48587..99a6260 100644
--- a/python/semanage/semanage-boolean.8
+++ b/python/semanage/semanage-boolean.8
@@ -52,10 +52,10 @@ List customized booleans
 # semanage boolean \-l \-C
 
 .SH "SEE ALSO"
-.B selinux (8),
-.B semanage (8)
-.B setsebool (8)
-.B getsebool (8)
+.BR selinux (8),
+.BR semanage (8),
+.BR setsebool (8),
+.BR getsebool (8)
 
 .SH "AUTHOR"
 This man page was written by Daniel Walsh <dwalsh@redhat.com>
diff --git a/python/semanage/semanage-dontaudit.8 b/python/semanage/semanage-dontaudit.8
index 3d29911..81accc6 100644
--- a/python/semanage/semanage-dontaudit.8
+++ b/python/semanage/semanage-dontaudit.8
@@ -27,8 +27,8 @@ Turn off dontaudit rules
 # semanage dontaudit off
 
 .SH "SEE ALSO"
-.B selinux (8),
-.B semanage (8)
+.BR selinux (8),
+.BR semanage (8)
 
 .SH "AUTHOR"
 This man page was written by Daniel Walsh <dwalsh@redhat.com>
diff --git a/python/semanage/semanage-export.8 b/python/semanage/semanage-export.8
index d688224..d422683 100644
--- a/python/semanage/semanage-export.8
+++ b/python/semanage/semanage-export.8
@@ -29,9 +29,9 @@ Import semanage modifications from another machine
 # semanage import \-f semanage.mods
 
 .SH "SEE ALSO"
-.B selinux (8),
-.B semanage (8),
-.B semanage-import (8)
+.BR selinux (8),
+.BR semanage (8),
+.BR semanage-import (8)
 
 .SH "AUTHOR"
 This man page was written by Daniel Walsh <dwalsh@redhat.com>
diff --git a/python/semanage/semanage-fcontext.8 b/python/semanage/semanage-fcontext.8
index 07c2831..561123a 100644
--- a/python/semanage/semanage-fcontext.8
+++ b/python/semanage/semanage-fcontext.8
@@ -80,8 +80,8 @@ execute the following commands.
 # restorecon \-R \-v /disk6
 
 .SH "SEE ALSO"
-.B selinux (8),
-.B semanage (8)
+.BR selinux (8),
+.BR semanage (8)
 
 .SH "AUTHOR"
 This man page was written by Daniel Walsh <dwalsh@redhat.com>
diff --git a/python/semanage/semanage-interface.8 b/python/semanage/semanage-interface.8
index fbab4b9..d9d526d 100644
--- a/python/semanage/semanage-interface.8
+++ b/python/semanage/semanage-interface.8
@@ -56,8 +56,8 @@ list all interface definitions
 # semanage interface \-l
 
 .SH "SEE ALSO"
-.B selinux (8),
-.B semanage (8)
+.BR selinux (8),
+.BR semanage (8)
 
 .SH "AUTHOR"
 This man page was written by Daniel Walsh <dwalsh@redhat.com>
diff --git a/python/semanage/semanage-login.8 b/python/semanage/semanage-login.8
index a2397a0..f451bdc 100644
--- a/python/semanage/semanage-login.8
+++ b/python/semanage/semanage-login.8
@@ -60,9 +60,9 @@ Assign all users in the engineering group to the staff_u user
 # semanage login \-a \-s staff_u %engineering
 
 .SH "SEE ALSO"
-.B selinux (8),
-.B semanage (8),
-.B semanage-user (8)
+.BR selinux (8),
+.BR semanage (8),
+.BR semanage-user (8)
 
 .SH "AUTHOR"
 This man page was written by Daniel Walsh <dwalsh@redhat.com>
diff --git a/python/semanage/semanage-module.8 b/python/semanage/semanage-module.8
index 42d6862..e005716 100644
--- a/python/semanage/semanage-module.8
+++ b/python/semanage/semanage-module.8
@@ -52,9 +52,9 @@ Install custom apache policy module
 # semanage module \-a myapache
 
 .SH "SEE ALSO"
-.B selinux (8),
-.B semanage (8)
-.B semodule (8)
+.BR selinux (8),
+.BR semanage (8),
+.BR semodule (8)
 
 .SH "AUTHOR"
 This man page was written by Daniel Walsh <dwalsh@redhat.com>
diff --git a/python/semanage/semanage-permissive.8 b/python/semanage/semanage-permissive.8
index ee30c85..1999a45 100644
--- a/python/semanage/semanage-permissive.8
+++ b/python/semanage/semanage-permissive.8
@@ -38,8 +38,8 @@ Make httpd_t (Web Server) a permissive domain
 # semanage permissive \-a httpd_t
 
 .SH "SEE ALSO"
-.B selinux (8),
-.B semanage (8)
+.BR selinux (8),
+.BR semanage (8)
 
 .SH "AUTHOR"
 This man page was written by Daniel Walsh <dwalsh@redhat.com>
diff --git a/python/semanage/semanage-port.8 b/python/semanage/semanage-port.8
index 666120e..a21287c 100644
--- a/python/semanage/semanage-port.8
+++ b/python/semanage/semanage-port.8
@@ -61,8 +61,8 @@ Allow sshd to listen on tcp port 8991
 # semanage port \-a \-t ssh_port_t \-p tcp 8991
 
 .SH "SEE ALSO"
-.B selinux (8),
-.B semanage (8)
+.BR selinux (8),
+.BR semanage (8)
 
 .SH "AUTHOR"
 This man page was written by Daniel Walsh <dwalsh@redhat.com>
diff --git a/python/semanage/semanage-user.8 b/python/semanage/semanage-user.8
index 2df03dd..30bc670 100644
--- a/python/semanage/semanage-user.8
+++ b/python/semanage/semanage-user.8
@@ -63,9 +63,9 @@ Add level for TopSecret Users
 # semanage user \-a \-R "staff_r" \-rs0\-TopSecret topsecret_u
 
 .SH "SEE ALSO"
-.B selinux (8),
-.B semanage (8)
-.B semanage\-login (8)
+.BR selinux (8),
+.BR semanage (8),
+.BR semanage\-login (8)
 
 .SH "AUTHOR"
 This man page was written by Daniel Walsh <dwalsh@redhat.com>
diff --git a/python/semanage/semanage.8 b/python/semanage/semanage.8
index ac39862..abc4736 100644
--- a/python/semanage/semanage.8
+++ b/python/semanage/semanage.8
@@ -66,19 +66,19 @@ modification.
 List help information
 
 .SH "SEE ALSO"
-.B selinux (8),
-.B semanage-boolean (8),
-.B semanage-dontaudit (8),
-.B semanage-export (8),
-.B semanage-fcontext (8),
-.B semanage-import (8),
-.B semanage-interface (8),
-.B semanage-login (8),
-.B semanage-module (8),
-.B semanage-node (8),
-.B semanage-permissive (8),
-.B semanage-port (8),
-.B semanage-user (8)
+.BR selinux (8),
+.BR semanage-boolean (8),
+.BR semanage-dontaudit (8),
+.BR semanage-export (8),
+.BR semanage-fcontext (8),
+.BR semanage-import (8),
+.BR semanage-interface (8),
+.BR semanage-login (8),
+.BR semanage-module (8),
+.BR semanage-node (8),
+.BR semanage-permissive (8),
+.BR semanage-port (8),
+.BR semanage-user (8)
 
 .SH "AUTHOR"
 This man page was written by Daniel Walsh <dwalsh@redhat.com>
-- 
2.9.3
