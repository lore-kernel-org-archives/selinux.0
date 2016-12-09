Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uB9NXJmm024093
 for <selinux@tycho.nsa.gov>; Fri, 9 Dec 2016 18:33:19 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by smtp.gentoo.org (Postfix) with ESMTP id 5F73834162B
 for <selinux@tycho.nsa.gov>; Fri,  9 Dec 2016 23:33:14 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/2] man: standardize spacing with pointers in prototypes
Date: Fri,  9 Dec 2016 18:33:11 -0500
Message-Id: <20161209233311.11139-2-vapier@gentoo.org>
In-Reply-To: <20161209233311.11139-1-vapier@gentoo.org>
References: <20161209233311.11139-1-vapier@gentoo.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The majority of prototypes don't put a space between the "*" and the
parameter name.  i.e. this style is incorrect:
	char * foo;
Instead, we want:
	char *foo;

Fix a bunch of references that use this uncommon style.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 libselinux/man/man3/avc_context_to_sid.3           |  2 +-
 libselinux/man/man3/get_ordered_context_list.3     | 12 ++++-----
 libselinux/man/man3/getcon.3                       |  6 ++---
 libselinux/man/man3/getexeccon.3                   |  4 +--
 libselinux/man/man3/getfscreatecon.3               |  4 +--
 libselinux/man/man3/getkeycreatecon.3              |  4 +--
 libselinux/man/man3/getsockcreatecon.3             |  4 +--
 libselinux/man/man3/is_context_customizable.3      |  2 +-
 libselinux/man/man3/security_check_context.3       |  4 +--
 libselinux/man/man3/security_compute_av.3          | 30 +++++++++++-----------
 .../man/man3/selinux_check_securetty_context.3     |  2 +-
 libselinux/man/man3/selinux_file_context_cmp.3     |  4 +--
 libselinux/man/man3/selinux_raw_context_to_color.3 |  2 +-
 libselinux/man/man3/setfilecon.3                   | 12 ++++-----
 14 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/libselinux/man/man3/avc_context_to_sid.3 b/libselinux/man/man3/avc_context_to_sid.3
index 021ff37de17f..5532d6c565c9 100644
--- a/libselinux/man/man3/avc_context_to_sid.3
+++ b/libselinux/man/man3/avc_context_to_sid.3
@@ -10,7 +10,7 @@ avc_context_to_sid, avc_sid_to_context, avc_get_initial_sid \- obtain and manipu
 .br
 .B #include <selinux/avc.h>
 .sp
-.BI "int avc_context_to_sid(char * " ctx ", security_id_t *" sid ");"
+.BI "int avc_context_to_sid(char *" ctx ", security_id_t *" sid ");"
 .sp
 .BI "int avc_sid_to_context(security_id_t " sid ", char **" ctx ");"
 .sp
diff --git a/libselinux/man/man3/get_ordered_context_list.3 b/libselinux/man/man3/get_ordered_context_list.3
index b1dabb6fe3cb..8de90b744c72 100644
--- a/libselinux/man/man3/get_ordered_context_list.3
+++ b/libselinux/man/man3/get_ordered_context_list.3
@@ -7,17 +7,17 @@ get_ordered_context_list, get_ordered_context_list_with_level, get_default_conte
 .br
 .B #include <selinux/get_context_list.h>
 .sp
-.BI "int get_ordered_context_list(const char *" user ", char * "fromcon ", char ***" list );
+.BI "int get_ordered_context_list(const char *" user ", char *" fromcon ", char ***" list );
 .sp
-.BI "int get_ordered_context_list_with_level(const char *" user ", const char *" level ", char * "fromcon ", char ***" list );
+.BI "int get_ordered_context_list_with_level(const char *" user ", const char *" level ", char *" fromcon ", char ***" list );
 .sp
-.BI "int get_default_context(const char *" user ", char * "fromcon ", char **" newcon );
+.BI "int get_default_context(const char *" user ", char *" fromcon ", char **" newcon );
 .sp
-.BI "int get_default_context_with_level(const char *" user ", const char *" level ", char * "fromcon ", char **" newcon );
+.BI "int get_default_context_with_level(const char *" user ", const char *" level ", char *" fromcon ", char **" newcon );
 .sp
-.BI "int get_default_context_with_role(const char *" user ", const char *" role ", char * " fromcon ", char **" newcon ");
+.BI "int get_default_context_with_role(const char *" user ", const char *" role ", char *" fromcon ", char **" newcon ");
 .sp
-.BI "int get_default_context_with_rolelevel(const char *" user ", const char *" level ", const char *" role ", char * " fromcon ", char **" newcon ");
+.BI "int get_default_context_with_rolelevel(const char *" user ", const char *" level ", const char *" role ", char *" fromcon ", char **" newcon ");
 .sp
 .BI "int query_user_context(char **" list ", char **" newcon );
 .sp
diff --git a/libselinux/man/man3/getcon.3 b/libselinux/man/man3/getcon.3
index 644ee47c8016..67872a4dede6 100644
--- a/libselinux/man/man3/getcon.3
+++ b/libselinux/man/man3/getcon.3
@@ -27,13 +27,13 @@ setcon \- set current security context of a process
 .sp
 .BI "int getpeercon_raw(int " fd ", char **" context );
 .sp
-.BI "void freecon(char * "con );
+.BI "void freecon(char *" con );
 .sp
 .BI "void freeconary(char **" con );
 .sp
-.BI "int setcon(char * " context );
+.BI "int setcon(char *" context );
 .sp
-.BI "int setcon_raw(char * " context );
+.BI "int setcon_raw(char *" context );
 .
 .SH "DESCRIPTION"
 .BR getcon ()
diff --git a/libselinux/man/man3/getexeccon.3 b/libselinux/man/man3/getexeccon.3
index 73c9e49c6fda..d6222a4fc93c 100644
--- a/libselinux/man/man3/getexeccon.3
+++ b/libselinux/man/man3/getexeccon.3
@@ -11,9 +11,9 @@ rpm_execcon \- run a helper for rpm in an appropriate security context
 .sp
 .BI "int getexeccon_raw(char **" context );
 .sp
-.BI "int setexeccon(char * "context );
+.BI "int setexeccon(char *" context );
 .sp
-.BI "int setexeccon_raw(char * "context );
+.BI "int setexeccon_raw(char *" context );
 .sp
 .BI "int setexecfilecon(const char *" filename ", const char *" fallback_type );
 .sp
diff --git a/libselinux/man/man3/getfscreatecon.3 b/libselinux/man/man3/getfscreatecon.3
index 8cc4df57c95b..c6faadc1ec34 100644
--- a/libselinux/man/man3/getfscreatecon.3
+++ b/libselinux/man/man3/getfscreatecon.3
@@ -9,9 +9,9 @@ getfscreatecon, setfscreatecon \- get or set the SELinux security context used f
 .sp
 .BI "int getfscreatecon_raw(char **" con );
 .sp
-.BI "int setfscreatecon(char * "context );
+.BI "int setfscreatecon(char *" context );
 .sp
-.BI "int setfscreatecon_raw(char * "context );
+.BI "int setfscreatecon_raw(char *" context );
 .
 .SH "DESCRIPTION"
 .BR getfscreatecon ()
diff --git a/libselinux/man/man3/getkeycreatecon.3 b/libselinux/man/man3/getkeycreatecon.3
index b51008d9e67a..7887b9b851e0 100644
--- a/libselinux/man/man3/getkeycreatecon.3
+++ b/libselinux/man/man3/getkeycreatecon.3
@@ -9,9 +9,9 @@ getkeycreatecon, setkeycreatecon \- get or set the SELinux security context used
 .sp
 .BI "int getkeycreatecon_raw(char **" con );
 .sp
-.BI "int setkeycreatecon(char * "context );
+.BI "int setkeycreatecon(char *" context );
 .sp
-.BI "int setkeycreatecon_raw(char * "context );
+.BI "int setkeycreatecon_raw(char *" context );
 .
 .SH "DESCRIPTION"
 .BR getkeycreatecon ()
diff --git a/libselinux/man/man3/getsockcreatecon.3 b/libselinux/man/man3/getsockcreatecon.3
index 26086d9bbed9..9223f60f981b 100644
--- a/libselinux/man/man3/getsockcreatecon.3
+++ b/libselinux/man/man3/getsockcreatecon.3
@@ -9,9 +9,9 @@ getsockcreatecon, setsockcreatecon \- get or set the SELinux security context us
 .sp
 .BI "int getsockcreatecon_raw(char **" con );
 .sp
-.BI "int setsockcreatecon(char * "context );
+.BI "int setsockcreatecon(char *" context );
 .sp
-.BI "int setsockcreatecon_raw(char * "context );
+.BI "int setsockcreatecon_raw(char *" context );
 .
 .SH "DESCRIPTION"
 .BR getsockcreatecon ()
diff --git a/libselinux/man/man3/is_context_customizable.3 b/libselinux/man/man3/is_context_customizable.3
index 7fed837496d2..c858a026afb0 100644
--- a/libselinux/man/man3/is_context_customizable.3
+++ b/libselinux/man/man3/is_context_customizable.3
@@ -5,7 +5,7 @@ is_context_customizable \- check whether SELinux context type is customizable by
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.BI "int is_context_customizable(char * " scon );
+.BI "int is_context_customizable(char *" scon );
 .
 .SH "DESCRIPTION"
 This function checks whether the type of scon is in the
diff --git a/libselinux/man/man3/security_check_context.3 b/libselinux/man/man3/security_check_context.3
index 8ece48c6e113..2b9a2d4c8b6a 100644
--- a/libselinux/man/man3/security_check_context.3
+++ b/libselinux/man/man3/security_check_context.3
@@ -5,9 +5,9 @@ security_check_context \- check the validity of a SELinux context
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.BI "int security_check_context(char * "con );
+.BI "int security_check_context(char *" con );
 .sp
-.BI "int security_check_context_raw(char * "con );
+.BI "int security_check_context_raw(char *" con );
 .
 .SH "DESCRIPTION"
 .BR security_check_context ()
diff --git a/libselinux/man/man3/security_compute_av.3 b/libselinux/man/man3/security_compute_av.3
index a56c3c87bcef..2aade5fe38b5 100644
--- a/libselinux/man/man3/security_compute_av.3
+++ b/libselinux/man/man3/security_compute_av.3
@@ -7,39 +7,39 @@ the SELinux policy database in the kernel
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.BI "int security_compute_av(char * "scon ", char * "tcon ", security_class_t "tclass ", access_vector_t "requested ", struct av_decision *" avd );
+.BI "int security_compute_av(char *" scon ", char *" tcon ", security_class_t "tclass ", access_vector_t "requested ", struct av_decision *" avd );
 .sp
-.BI "int security_compute_av_raw(char * "scon ", char * "tcon ", security_class_t "tclass ", access_vector_t "requested ", struct av_decision *" avd );
+.BI "int security_compute_av_raw(char *" scon ", char *" tcon ", security_class_t "tclass ", access_vector_t "requested ", struct av_decision *" avd );
 .sp
-.BI "int security_compute_av_flags(char * "scon ", char * "tcon ", security_class_t "tclass ", access_vector_t "requested ", struct av_decision *" avd );
+.BI "int security_compute_av_flags(char *" scon ", char *" tcon ", security_class_t "tclass ", access_vector_t "requested ", struct av_decision *" avd );
 .sp
-.BI "int security_compute_av_flags_raw(char * "scon ", char * "tcon ", security_class_t "tclass ", access_vector_t "requested ", struct av_decision *" avd );
+.BI "int security_compute_av_flags_raw(char *" scon ", char *" tcon ", security_class_t "tclass ", access_vector_t "requested ", struct av_decision *" avd );
 .sp
-.BI "int security_compute_create(char * "scon ", char * "tcon ", security_class_t "tclass ", char **" newcon );
+.BI "int security_compute_create(char *" scon ", char *" tcon ", security_class_t "tclass ", char **" newcon );
 .sp
-.BI "int security_compute_create_raw(char * "scon ", char * "tcon ", security_class_t "tclass ", char **" newcon );
+.BI "int security_compute_create_raw(char *" scon ", char *" tcon ", security_class_t "tclass ", char **" newcon );
 .sp
-.BI "int security_compute_create_name(char * "scon ", char * "tcon ", security_class_t "tclass ", const char *"objname ", char **" newcon );
+.BI "int security_compute_create_name(char *" scon ", char *" tcon ", security_class_t "tclass ", const char *" objname ", char **" newcon );
 .sp
-.BI "int security_compute_create_name_raw(char * "scon ", char * "tcon ", security_class_t "tclass ", const char *"objname ", char **" newcon );
+.BI "int security_compute_create_name_raw(char *" scon ", char *" tcon ", security_class_t "tclass ", const char *" objname ", char **" newcon );
 .sp
-.BI "int security_compute_relabel(char * "scon ", char * "tcon ", security_class_t "tclass ", char **" newcon );
+.BI "int security_compute_relabel(char *" scon ", char *" tcon ", security_class_t "tclass ", char **" newcon );
 .sp
-.BI "int security_compute_relabel_raw(char * "scon ", char * "tcon ", security_class_t "tclass ", char **" newcon );
+.BI "int security_compute_relabel_raw(char *" scon ", char *" tcon ", security_class_t "tclass ", char **" newcon );
 .sp
-.BI "int security_compute_member(char * "scon ", char * "tcon ", security_class_t "tclass ", char **" newcon );
+.BI "int security_compute_member(char *" scon ", char *" tcon ", security_class_t "tclass ", char **" newcon );
 .sp
-.BI "int security_compute_member_raw(char * "scon ", char * "tcon ", security_class_t "tclass ", char **" newcon );
+.BI "int security_compute_member_raw(char *" scon ", char *" tcon ", security_class_t "tclass ", char **" newcon );
 .sp
-.BI "int security_compute_user(char * "scon ", const char *" username ", char ***" con );
+.BI "int security_compute_user(char *" scon ", const char *" username ", char ***" con );
 .sp
-.BI "int security_compute_user_raw(char * "scon ", const char *" username ", char ***" con );
+.BI "int security_compute_user_raw(char *" scon ", const char *" username ", char ***" con );
 .sp
 .BI "int security_get_initial_context(const char *" name ", char **" con );
 .sp
 .BI "int security_get_initial_context_raw(const char *" name ", char **" con );
 .sp
-.BI "int selinux_check_access(const char * " scon ", const char * " tcon ", const char *" class ", const char *" perm ", void *" auditdata);
+.BI "int selinux_check_access(const char *" scon ", const char *" tcon ", const char *" class ", const char *" perm ", void *" auditdata);
 .sp
 .BI "int selinux_check_passwd_access(access_vector_t " requested );
 .sp
diff --git a/libselinux/man/man3/selinux_check_securetty_context.3 b/libselinux/man/man3/selinux_check_securetty_context.3
index 05f23441d0fc..429023bb2d40 100644
--- a/libselinux/man/man3/selinux_check_securetty_context.3
+++ b/libselinux/man/man3/selinux_check_securetty_context.3
@@ -5,7 +5,7 @@ selinux_check_securetty_context \- check whether a SELinux tty security context
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.BI "int selinux_check_securetty_context(char * "tty_context );
+.BI "int selinux_check_securetty_context(char *" tty_context );
 .
 .SH "DESCRIPTION"
 .BR selinux_check_securetty_context ()
diff --git a/libselinux/man/man3/selinux_file_context_cmp.3 b/libselinux/man/man3/selinux_file_context_cmp.3
index f7cd7ec6a825..6d4b3e8b0bf9 100644
--- a/libselinux/man/man3/selinux_file_context_cmp.3
+++ b/libselinux/man/man3/selinux_file_context_cmp.3
@@ -5,9 +5,9 @@ selinux_file_context_cmp \- Compare two SELinux security contexts excluding the
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.BI "int selinux_file_context_cmp(const char * " a ", "
+.BI "int selinux_file_context_cmp(const char *" a ", "
 .RS
-.BI "const char * " b ");"
+.BI "const char *" b ");"
 .RE
 .
 .SH "DESCRIPTION"
diff --git a/libselinux/man/man3/selinux_raw_context_to_color.3 b/libselinux/man/man3/selinux_raw_context_to_color.3
index 530e87695bfb..cfd564df1a78 100644
--- a/libselinux/man/man3/selinux_raw_context_to_color.3
+++ b/libselinux/man/man3/selinux_raw_context_to_color.3
@@ -5,7 +5,7 @@ selinux_raw_context_to_color \- Return RGB color string for an SELinux security
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.BI "int selinux_raw_context_to_color(char * " raw ", "
+.BI "int selinux_raw_context_to_color(char *" raw ", "
 .RS
 .BI "char **" color_str ");"
 .RE
diff --git a/libselinux/man/man3/setfilecon.3 b/libselinux/man/man3/setfilecon.3
index 9fe8997e7e23..0e9a383ffb59 100644
--- a/libselinux/man/man3/setfilecon.3
+++ b/libselinux/man/man3/setfilecon.3
@@ -5,17 +5,17 @@ setfilecon, fsetfilecon, lsetfilecon \- set SELinux security context of a file
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.BI "int setfilecon(const char *" path ", char * "con );
+.BI "int setfilecon(const char *" path ", char *" con );
 .sp
-.BI "int setfilecon_raw(const char *" path ", char * "con );
+.BI "int setfilecon_raw(const char *" path ", char *" con );
 .sp
-.BI "int lsetfilecon(const char *" path ", char * "con );
+.BI "int lsetfilecon(const char *" path ", char *" con );
 .sp
-.BI "int lsetfilecon_raw(const char *" path ", char * "con );
+.BI "int lsetfilecon_raw(const char *" path ", char *" con );
 .sp
-.BI "int fsetfilecon(int "fd ", char * "con );
+.BI "int fsetfilecon(int "fd ", char *" con );
 .sp
-.BI "int fsetfilecon_raw(int "fd ", char * "con );
+.BI "int fsetfilecon_raw(int "fd ", char *" con );
 .
 .SH "DESCRIPTION"
 .BR setfilecon ()
-- 
2.11.0.rc2
