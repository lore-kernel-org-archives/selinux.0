Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tA79LIbf019723
 for <selinux@tycho.nsa.gov>; Sat, 7 Nov 2015 04:21:18 -0500
Received: by lfgh9 with SMTP id h9so81260323lfg.1
 for <selinux@tycho.nsa.gov>; Sat, 07 Nov 2015 01:20:58 -0800 (PST)
Received: from viper.bobcat.mine.nu (62-78-200-229.bb.dnainternet.fi.
 [62.78.200.229])
 by smtp.gmail.com with ESMTPSA id f198sm701622lff.9.2015.11.07.01.20.57
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 07 Nov 2015 01:20:57 -0800 (PST)
Sender: =?UTF-8?Q?Ville_Skytt=C3=A4?= <vskytta@gmail.com>
From: =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux, policycoreutils: Man page warning fixes
Date: Sat,  7 Nov 2015 11:20:56 +0200
Message-Id: <1446888056-15525-1-git-send-email-ville.skytta@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>
---
 libselinux/man/man3/security_load_booleans.3        | 2 +-
 libselinux/man/man3/selinux_binary_policy_path.3    | 2 +-
 libselinux/man/man8/avcstat.8                       | 2 +-
 libselinux/man/man8/booleans.8                      | 2 +-
 libselinux/man/man8/getenforce.8                    | 2 +-
 libselinux/man/man8/getsebool.8                     | 2 +-
 libselinux/man/man8/matchpathcon.8                  | 2 +-
 libselinux/man/man8/selinux.8                       | 2 +-
 libselinux/man/man8/selinuxenabled.8                | 2 +-
 libselinux/man/man8/selinuxexeccon.8                | 2 +-
 libselinux/man/man8/setenforce.8                    | 2 +-
 libselinux/man/man8/togglesebool.8                  | 2 +-
 policycoreutils/semodule/semodule.8                 | 4 ++--
 policycoreutils/semodule_package/semodule_package.8 | 2 +-
 policycoreutils/sepolicy/sepolicy-communicate.8     | 2 +-
 policycoreutils/setsebool/setsebool.8               | 2 +-
 16 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/libselinux/man/man3/security_load_booleans.3 b/libselinux/man/man3/security_load_booleans.3
index 3dc963d..3b0bbea 100644
--- a/libselinux/man/man3/security_load_booleans.3
+++ b/libselinux/man/man3/security_load_booleans.3
@@ -56,7 +56,7 @@ commits all pending values for the booleans.
 Where not otherwise stated, functions described in this manual page return
 zero on success or \-1 on error. 
 .
-.SH AUTHOR	
+.SH AUTHOR
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
 .
 .SH "SEE ALSO"
diff --git a/libselinux/man/man3/selinux_binary_policy_path.3 b/libselinux/man/man3/selinux_binary_policy_path.3
index 503c52c..edaa3b8 100644
--- a/libselinux/man/man3/selinux_binary_policy_path.3
+++ b/libselinux/man/man3/selinux_binary_policy_path.3
@@ -108,7 +108,7 @@ returns the defines tty types for newrole securettys.
 .BR selinux_booleans_path ()
 returns the initial policy boolean settings.
 .
-.SH AUTHOR	
+.SH AUTHOR
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
 .
 .SH "SEE ALSO"
diff --git a/libselinux/man/man8/avcstat.8 b/libselinux/man/man8/avcstat.8
index 6251591..204687d 100644
--- a/libselinux/man/man8/avcstat.8
+++ b/libselinux/man/man8/avcstat.8
@@ -27,7 +27,7 @@ Display the cumulative values.
 Specifies the location of the AVC statistics file, defaulting to
 .IR /selinux/avc/cache_stats .
 .
-.SH AUTHOR	
+.SH AUTHOR
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
 The program was written by James Morris <jmorris@redhat.com>.
 .
diff --git a/libselinux/man/man8/booleans.8 b/libselinux/man/man8/booleans.8
index 9c4dbc3..d4ca9c4 100644
--- a/libselinux/man/man8/booleans.8
+++ b/libselinux/man/man8/booleans.8
@@ -47,7 +47,7 @@ unless the
 .B \-P
 option is used to setsebool.
 .
-.SH AUTHOR	
+.SH AUTHOR
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
 The SELinux conditional policy support was developed by Tresys Technology.
 .
diff --git a/libselinux/man/man8/getenforce.8 b/libselinux/man/man8/getenforce.8
index e0924d8..70b9921 100644
--- a/libselinux/man/man8/getenforce.8
+++ b/libselinux/man/man8/getenforce.8
@@ -9,7 +9,7 @@ getenforce \- get the current mode of SELinux
 .B getenforce
 reports whether SELinux is enforcing, permissive, or disabled.
 .
-.SH AUTHOR	
+.SH AUTHOR
 Dan Walsh, <dwalsh@redhat.com>
 .
 .SH "SEE ALSO"
diff --git a/libselinux/man/man8/getsebool.8 b/libselinux/man/man8/getsebool.8
index 6353a2a..d70bf1e 100644
--- a/libselinux/man/man8/getsebool.8
+++ b/libselinux/man/man8/getsebool.8
@@ -27,7 +27,7 @@ their pending values as desired and then committing once.
 .B \-a
 Show all SELinux booleans.
 .
-.SH AUTHOR	
+.SH AUTHOR
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
 The program was written by Tresys Technology.
 .
diff --git a/libselinux/man/man8/matchpathcon.8 b/libselinux/man/man8/matchpathcon.8
index 5d60789..50c0d39 100644
--- a/libselinux/man/man8/matchpathcon.8
+++ b/libselinux/man/man8/matchpathcon.8
@@ -54,7 +54,7 @@ Use alternate policy root path
 .B \-V
 Verify file context on disk matches defaults
 .
-.SH AUTHOR	
+.SH AUTHOR
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
 .
 .SH "SEE ALSO"
diff --git a/libselinux/man/man8/selinux.8 b/libselinux/man/man8/selinux.8
index 9e3bdc4..6f1034b 100644
--- a/libselinux/man/man8/selinux.8
+++ b/libselinux/man/man8/selinux.8
@@ -77,7 +77,7 @@ also has this capability.  The
 .BR restorecon / fixfiles
 commands are also available for relabeling files.
 .
-.SH AUTHOR	
+.SH AUTHOR
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
 .
 .SH FILES
diff --git a/libselinux/man/man8/selinuxenabled.8 b/libselinux/man/man8/selinuxenabled.8
index ac20587..5cd7a62 100644
--- a/libselinux/man/man8/selinuxenabled.8
+++ b/libselinux/man/man8/selinuxenabled.8
@@ -11,7 +11,7 @@ Indicates whether SELinux is enabled or disabled.
 .SH "EXIT STATUS"
 It exits with status 0 if SELinux is enabled and 1 if it is not enabled.
 .
-.SH AUTHOR	
+.SH AUTHOR
 Dan Walsh, <dwalsh@redhat.com>
 .
 .SH "SEE ALSO"
diff --git a/libselinux/man/man8/selinuxexeccon.8 b/libselinux/man/man8/selinuxexeccon.8
index 30c20ed..194740d 100644
--- a/libselinux/man/man8/selinuxexeccon.8
+++ b/libselinux/man/man8/selinuxexeccon.8
@@ -20,7 +20,7 @@ staff_u:staff_r:passwd_t:s0-s0:c0.c1023
 system_u:system_r:system_mail_t:s0
 .fi
 .
-.SH AUTHOR	
+.SH AUTHOR
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
 .
 .SH "SEE ALSO"
diff --git a/libselinux/man/man8/setenforce.8 b/libselinux/man/man8/setenforce.8
index 8a24f1c..702041d 100644
--- a/libselinux/man/man8/setenforce.8
+++ b/libselinux/man/man8/setenforce.8
@@ -22,7 +22,7 @@ to put SELinux in permissive mode.
 If SELinux is disabled and you want to enable it, or SELinux is enabled and you want to disable it, please see 
 .BR selinux (8).
 .
-.SH AUTHOR	
+.SH AUTHOR
 Dan Walsh, <dwalsh@redhat.com>
 .
 .SH "SEE ALSO"
diff --git a/libselinux/man/man8/togglesebool.8 b/libselinux/man/man8/togglesebool.8
index 598dc94..8f775ca 100644
--- a/libselinux/man/man8/togglesebool.8
+++ b/libselinux/man/man8/togglesebool.8
@@ -12,7 +12,7 @@ flips the current value of a list of booleans. If the value is currently a 1,
 then it will be changed to a 0 and vice versa. Only the "in memory" values are
 changed; the boot-time settings are unaffected. 
 .
-.SH AUTHOR	
+.SH AUTHOR
 This man page was written by Steve Grubb <sgrubb@redhat.com>
 .
 .SH "SEE ALSO"
diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semodule/semodule.8
index 9cd04e7..6db390c 100644
--- a/policycoreutils/semodule/semodule.8
+++ b/policycoreutils/semodule/semodule.8
@@ -20,7 +20,7 @@ by semodule_package.  Conventionally, these files have a .pp suffix
 .B \-R, \-\-reload
 force a reload of policy
 .TP
-.B \-B, \-\-build		
+.B \-B, \-\-build
 force a rebuild of policy (also reloads unless \-n is used)
 .TP
 .B \-D, \-\-disable_dontaudit
@@ -63,7 +63,7 @@ enable module
 .B  \-d,\-\-disable=MODULE_NAME
 disable module
 .TP
-.B  \-s,\-\-store	   
+.B  \-s,\-\-store
 name of the store to operate on
 .TP
 .B  \-n,\-\-noreload,\-N
diff --git a/policycoreutils/semodule_package/semodule_package.8 b/policycoreutils/semodule_package/semodule_package.8
index 563d526..9697cc5 100644
--- a/policycoreutils/semodule_package/semodule_package.8
+++ b/policycoreutils/semodule_package/semodule_package.8
@@ -37,7 +37,7 @@ user_extra file to be included in the package.
 .B  \-m \-\-module <Module file>
 Policy module file to be included in the package.
 .TP
-.B  \-f \-\-fc	<File context file>
+.B  \-f \-\-fc <File context file>
 File contexts file for the module (optional).
 .TP
 .B  \-n \-\-nc <netfilter context file>
diff --git a/policycoreutils/sepolicy/sepolicy-communicate.8 b/policycoreutils/sepolicy/sepolicy-communicate.8
index 764fd35..050aa47 100644
--- a/policycoreutils/sepolicy/sepolicy-communicate.8
+++ b/policycoreutils/sepolicy/sepolicy-communicate.8
@@ -13,7 +13,7 @@ The default command looks to see if there are any file types that the source dom
 
 .SH "OPTIONS"
 .TP
-.I		  \-c, \-\-class
+.I                \-c, \-\-class
 Specify the SELinux class which the source domain will attempt to communicate with the target domain.  (Default file)
 .TP
 .I                \-h, \-\-help       
diff --git a/policycoreutils/setsebool/setsebool.8 b/policycoreutils/setsebool/setsebool.8
index 916a58c..52936f5 100644
--- a/policycoreutils/setsebool/setsebool.8
+++ b/policycoreutils/setsebool/setsebool.8
@@ -23,7 +23,7 @@ If the \-N option is given, the policy on disk is not reloaded into the kernel.
 If the \-V option is given, verbose error messages will be printed from semanage libraries.
 
 
-.SH AUTHOR	
+.SH AUTHOR
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
 The program was written by Tresys Technology.
 
-- 
2.4.3
