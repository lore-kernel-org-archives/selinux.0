Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qAKEWWUh026951
	for <selinux@tycho.nsa.gov>; Tue, 20 Nov 2012 09:32:35 -0500
Received: from gaara.hadrons.org (85.137.229.25) by resmaa12.ono.com (8.6.048.02) (authenticated as guillemj@ono.com)
        id 5052D7630150E787 for selinux@tycho.nsa.gov; Tue, 20 Nov 2012 15:31:56 +0100
Received: from guillem by gaara.hadrons.org with local (Exim 4.80)
	(envelope-from <guillemj@ono.com>)
	id 1TantM-00022R-63
	for selinux@tycho.nsa.gov; Tue, 20 Nov 2012 14:29:32 +0100
From: Guillem Jover <guillem@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 4/4] libselinux: Add references and man page links to _raw function variants
Date: Tue, 20 Nov 2012 14:25:30 +0100
Message-Id: <1353417930-7707-5-git-send-email-guillem@debian.org>
In-Reply-To: <1353417930-7707-1-git-send-email-guillem@debian.org>
References: <1353417930-7707-1-git-send-email-guillem@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Signed-off-by: Guillem Jover <guillem@debian.org>
---
 libselinux/man/man3/fgetfilecon_raw.3              |  1 +
 libselinux/man/man3/fsetfilecon_raw.3              |  1 +
 libselinux/man/man3/getcon.3                       | 19 +++++++++++++++
 libselinux/man/man3/getcon_raw.3                   |  1 +
 libselinux/man/man3/getexeccon.3                   | 10 ++++++++
 libselinux/man/man3/getexeccon_raw.3               |  1 +
 libselinux/man/man3/getfilecon.3                   | 13 ++++++++++
 libselinux/man/man3/getfilecon_raw.3               |  1 +
 libselinux/man/man3/getfscreatecon.3               | 10 ++++++++
 libselinux/man/man3/getfscreatecon_raw.3           |  1 +
 libselinux/man/man3/getkeycreatecon.3              | 10 ++++++++
 libselinux/man/man3/getkeycreatecon_raw.3          |  1 +
 libselinux/man/man3/getpeercon_raw.3               |  1 +
 libselinux/man/man3/getpidcon_raw.3                |  1 +
 libselinux/man/man3/getprevcon_raw.3               |  1 +
 libselinux/man/man3/getsockcreatecon.3             | 10 ++++++++
 libselinux/man/man3/getsockcreatecon_raw.3         |  1 +
 libselinux/man/man3/lgetfilecon_raw.3              |  1 +
 libselinux/man/man3/lsetfilecon_raw.3              |  1 +
 libselinux/man/man3/security_check_context.3       |  7 ++++++
 libselinux/man/man3/security_check_context_raw.3   |  1 +
 libselinux/man/man3/security_compute_av.3          | 28 ++++++++++++++++++++++
 .../man/man3/security_compute_av_flags_raw.3       |  1 +
 libselinux/man/man3/security_compute_av_raw.3      |  1 +
 .../man/man3/security_compute_create_name_raw.3    |  1 +
 libselinux/man/man3/security_compute_create_raw.3  |  1 +
 libselinux/man/man3/security_compute_member_raw.3  |  1 +
 libselinux/man/man3/security_compute_relabel_raw.3 |  1 +
 libselinux/man/man3/security_compute_user_raw.3    |  1 +
 .../man/man3/security_get_initial_context_raw.3    |  1 +
 libselinux/man/man3/selabel_lookup_raw.3           |  1 +
 libselinux/man/man3/setcon_raw.3                   |  1 +
 libselinux/man/man3/setexeccon_raw.3               |  1 +
 libselinux/man/man3/setfilecon.3                   | 13 ++++++++++
 libselinux/man/man3/setfilecon_raw.3               |  1 +
 libselinux/man/man3/setfscreatecon_raw.3           |  1 +
 libselinux/man/man3/setkeycreatecon_raw.3          |  1 +
 libselinux/man/man3/setsockcreatecon_raw.3         |  1 +
 38 files changed, 149 insertions(+)
 create mode 100644 libselinux/man/man3/fgetfilecon_raw.3
 create mode 100644 libselinux/man/man3/fsetfilecon_raw.3
 create mode 100644 libselinux/man/man3/getcon_raw.3
 create mode 100644 libselinux/man/man3/getexeccon_raw.3
 create mode 100644 libselinux/man/man3/getfilecon_raw.3
 create mode 100644 libselinux/man/man3/getfscreatecon_raw.3
 create mode 100644 libselinux/man/man3/getkeycreatecon_raw.3
 create mode 100644 libselinux/man/man3/getpeercon_raw.3
 create mode 100644 libselinux/man/man3/getpidcon_raw.3
 create mode 100644 libselinux/man/man3/getprevcon_raw.3
 create mode 100644 libselinux/man/man3/getsockcreatecon_raw.3
 create mode 100644 libselinux/man/man3/lgetfilecon_raw.3
 create mode 100644 libselinux/man/man3/lsetfilecon_raw.3
 create mode 100644 libselinux/man/man3/security_check_context_raw.3
 create mode 100644 libselinux/man/man3/security_compute_av_flags_raw.3
 create mode 100644 libselinux/man/man3/security_compute_av_raw.3
 create mode 100644 libselinux/man/man3/security_compute_create_name_raw.3
 create mode 100644 libselinux/man/man3/security_compute_create_raw.3
 create mode 100644 libselinux/man/man3/security_compute_member_raw.3
 create mode 100644 libselinux/man/man3/security_compute_relabel_raw.3
 create mode 100644 libselinux/man/man3/security_compute_user_raw.3
 create mode 100644 libselinux/man/man3/security_get_initial_context_raw.3
 create mode 100644 libselinux/man/man3/selabel_lookup_raw.3
 create mode 100644 libselinux/man/man3/setcon_raw.3
 create mode 100644 libselinux/man/man3/setexeccon_raw.3
 create mode 100644 libselinux/man/man3/setfilecon_raw.3
 create mode 100644 libselinux/man/man3/setfscreatecon_raw.3
 create mode 100644 libselinux/man/man3/setkeycreatecon_raw.3
 create mode 100644 libselinux/man/man3/setsockcreatecon_raw.3

diff --git a/libselinux/man/man3/fgetfilecon_raw.3 b/libselinux/man/man3/fgetfilecon_raw.3
new file mode 100644
index 0000000..ae6dfcf
--- /dev/null
+++ b/libselinux/man/man3/fgetfilecon_raw.3
@@ -0,0 +1 @@
+.so man3/getfilecon.3
diff --git a/libselinux/man/man3/fsetfilecon_raw.3 b/libselinux/man/man3/fsetfilecon_raw.3
new file mode 100644
index 0000000..33c321a
--- /dev/null
+++ b/libselinux/man/man3/fsetfilecon_raw.3
@@ -0,0 +1 @@
+.so man3/setfilecon.3
diff --git a/libselinux/man/man3/getcon.3 b/libselinux/man/man3/getcon.3
index f1d3a7f..239bb7d 100644
--- a/libselinux/man/man3/getcon.3
+++ b/libselinux/man/man3/getcon.3
@@ -13,17 +13,27 @@ setcon \- set current security context of a process
 .sp
 .BI "int getcon(security_context_t *" context );
 .sp
+.BI "int getcon_raw(security_context_t *" context );
+.sp
 .BI "int getprevcon(security_context_t *" context );
 .sp
+.BI "int getprevcon_raw(security_context_t *" context );
+.sp
 .BI "int getpidcon(pid_t " pid ", security_context_t *" context );
 .sp
+.BI "int getpidcon_raw(pid_t " pid ", security_context_t *" context );
+.sp
 .BI "int getpeercon(int " fd ", security_context_t *" context );
 .sp
+.BI "int getpeercon_raw(int " fd ", security_context_t *" context );
+.sp
 .BI "void freecon(security_context_t "con );
 .sp
 .BI "void freeconary(security_context_t *" con );
 .sp
 .BI "int setcon(security_context_t " context );
+.sp
+.BI "int setcon_raw(security_context_t " context );
 .
 .SH "DESCRIPTION"
 .BR getcon ()
@@ -91,6 +101,15 @@ operation, ptrace permission will be revalidated against the new
 context and the
 .BR setcon ()
 will fail if it is not allowed by policy.
+
+.BR getcon_raw (),
+.BR getprevcon_raw (),
+.BR getpidcon_raw (),
+.BR getpeercon_raw ()
+and
+.BR setcon_raw ()
+behave identically to their non-raw counterparts but do not perform context
+translation.
 .
 .SH "RETURN VALUE"
 On error \-1 is returned.  On success 0 is returned.
diff --git a/libselinux/man/man3/getcon_raw.3 b/libselinux/man/man3/getcon_raw.3
new file mode 100644
index 0000000..1210b5a
--- /dev/null
+++ b/libselinux/man/man3/getcon_raw.3
@@ -0,0 +1 @@
+.so man3/getcon.3
diff --git a/libselinux/man/man3/getexeccon.3 b/libselinux/man/man3/getexeccon.3
index 54fb873..c188a3a 100644
--- a/libselinux/man/man3/getexeccon.3
+++ b/libselinux/man/man3/getexeccon.3
@@ -9,8 +9,12 @@ rpm_execcon \- run a helper for rpm in an appropriate security context
 .sp
 .BI "int getexeccon(security_context_t *" context );
 .sp
+.BI "int getexeccon_raw(security_context_t *" context );
+.sp
 .BI "int setexeccon(security_context_t "context );
 .sp
+.BI "int setexeccon_raw(security_context_t "context );
+.sp
 .BI "int rpm_execcon(unsigned int " verified ", const char *" filename ", char *const " argv "[] , char *const " envp "[]);
 .
 .SH "DESCRIPTION"
@@ -46,6 +50,12 @@ e.g.
 .BR popen (3),
 in order to set an exec context for that operation.  
 
+.BR getexeccon_raw ()
+and
+.BR setexeccon_raw ()
+behave identically to their non-raw counterparts but do not perform context
+translation.
+
 .B Note:
 Signal handlers that perform an
 .BR execve (2)
diff --git a/libselinux/man/man3/getexeccon_raw.3 b/libselinux/man/man3/getexeccon_raw.3
new file mode 100644
index 0000000..b2e6ab8
--- /dev/null
+++ b/libselinux/man/man3/getexeccon_raw.3
@@ -0,0 +1 @@
+.so man3/getexeccon.3
diff --git a/libselinux/man/man3/getfilecon.3 b/libselinux/man/man3/getfilecon.3
index 8605a0c..ea79b31 100644
--- a/libselinux/man/man3/getfilecon.3
+++ b/libselinux/man/man3/getfilecon.3
@@ -7,9 +7,15 @@ getfilecon, fgetfilecon, lgetfilecon \- get SELinux security context of a file
 .sp
 .BI "int getfilecon(const char *" path ", security_context_t *" con );
 .sp
+.BI "int getfilecon_raw(const char *" path ", security_context_t *" con );
+.sp
 .BI "int lgetfilecon(const char *" path ", security_context_t *" con );
 .sp
+.BI "int lgetfilecon_raw(const char *" path ", security_context_t *" con );
+.sp
 .BI "int fgetfilecon(int "fd ", security_context_t *" con );
+.sp
+.BI "int fgetfilecon_raw(int "fd ", security_context_t *" con );
 .
 .SH "DESCRIPTION"
 .BR getfilecon ()
@@ -29,6 +35,13 @@ only the open file pointed to by filedes (as returned by
 .BR open (2))
 is interrogated in place of path.
 
+.BR getfilecon_raw (),
+.BR lgetfilecon_raw ()
+and
+.BR fgetfilecon_raw ()
+behave identically to their non-raw counterparts but do not perform context
+translation.
+
 The returned context should be freed with
 .BR freecon (3)
 if non-NULL.
diff --git a/libselinux/man/man3/getfilecon_raw.3 b/libselinux/man/man3/getfilecon_raw.3
new file mode 100644
index 0000000..ae6dfcf
--- /dev/null
+++ b/libselinux/man/man3/getfilecon_raw.3
@@ -0,0 +1 @@
+.so man3/getfilecon.3
diff --git a/libselinux/man/man3/getfscreatecon.3 b/libselinux/man/man3/getfscreatecon.3
index 1b0f3d1..c7675be 100644
--- a/libselinux/man/man3/getfscreatecon.3
+++ b/libselinux/man/man3/getfscreatecon.3
@@ -7,7 +7,11 @@ getfscreatecon, setfscreatecon \- get or set the SELinux security context used f
 .sp
 .BI "int getfscreatecon(security_context_t *" con );
 .sp
+.BI "int getfscreatecon_raw(security_context_t *" con );
+.sp
 .BI "int setfscreatecon(security_context_t "context );
+.sp
+.BI "int setfscreatecon_raw(security_context_t "context );
 .
 .SH "DESCRIPTION"
 .BR getfscreatecon ()
@@ -33,6 +37,12 @@ can be applied prior to library
 functions that internally perform an file creation,
 in order to set an file context on the objects.
 
+.BR getfscreatecon_raw ()
+and
+.BR setfscreatecon_raw ()
+behave identically to their non-raw counterparts but do not perform context
+translation.
+
 .B Note:
 Signal handlers that perform a
 .BR setfscreatecon ()
diff --git a/libselinux/man/man3/getfscreatecon_raw.3 b/libselinux/man/man3/getfscreatecon_raw.3
new file mode 100644
index 0000000..21aeebd
--- /dev/null
+++ b/libselinux/man/man3/getfscreatecon_raw.3
@@ -0,0 +1 @@
+.so man3/getfscreatecon.3
diff --git a/libselinux/man/man3/getkeycreatecon.3 b/libselinux/man/man3/getkeycreatecon.3
index 709be51..d6a118c 100644
--- a/libselinux/man/man3/getkeycreatecon.3
+++ b/libselinux/man/man3/getkeycreatecon.3
@@ -7,7 +7,11 @@ getkeycreatecon, setkeycreatecon \- get or set the SELinux security context used
 .sp
 .BI "int getkeycreatecon(security_context_t *" con );
 .sp
+.BI "int getkeycreatecon_raw(security_context_t *" con );
+.sp
 .BI "int setkeycreatecon(security_context_t "context );
+.sp
+.BI "int setkeycreatecon_raw(security_context_t "context );
 .
 .SH "DESCRIPTION"
 .BR getkeycreatecon ()
@@ -33,6 +37,12 @@ can be applied prior to library
 functions that internally perform an file creation,
 in order to set an file context on the objects.
 
+.BR getkeycreatecon_raw ()
+and
+.BR setkeycreatecon_raw ()
+behave identically to their non-raw counterparts but do not perform context
+translation.
+
 .B Note:
 Signal handlers that perform a
 .BR setkeycreatecon ()
diff --git a/libselinux/man/man3/getkeycreatecon_raw.3 b/libselinux/man/man3/getkeycreatecon_raw.3
new file mode 100644
index 0000000..1e0ec5f
--- /dev/null
+++ b/libselinux/man/man3/getkeycreatecon_raw.3
@@ -0,0 +1 @@
+.so man3/getkeycreatecon.3
diff --git a/libselinux/man/man3/getpeercon_raw.3 b/libselinux/man/man3/getpeercon_raw.3
new file mode 100644
index 0000000..1210b5a
--- /dev/null
+++ b/libselinux/man/man3/getpeercon_raw.3
@@ -0,0 +1 @@
+.so man3/getcon.3
diff --git a/libselinux/man/man3/getpidcon_raw.3 b/libselinux/man/man3/getpidcon_raw.3
new file mode 100644
index 0000000..1210b5a
--- /dev/null
+++ b/libselinux/man/man3/getpidcon_raw.3
@@ -0,0 +1 @@
+.so man3/getcon.3
diff --git a/libselinux/man/man3/getprevcon_raw.3 b/libselinux/man/man3/getprevcon_raw.3
new file mode 100644
index 0000000..1210b5a
--- /dev/null
+++ b/libselinux/man/man3/getprevcon_raw.3
@@ -0,0 +1 @@
+.so man3/getcon.3
diff --git a/libselinux/man/man3/getsockcreatecon.3 b/libselinux/man/man3/getsockcreatecon.3
index 8fb2061..99e9436 100644
--- a/libselinux/man/man3/getsockcreatecon.3
+++ b/libselinux/man/man3/getsockcreatecon.3
@@ -7,7 +7,11 @@ getsockcreatecon, setsockcreatecon \- get or set the SELinux security context us
 .sp
 .BI "int getsockcreatecon(security_context_t *" con );
 .sp
+.BI "int getsockcreatecon_raw(security_context_t *" con );
+.sp
 .BI "int setsockcreatecon(security_context_t "context );
+.sp
+.BI "int setsockcreatecon_raw(security_context_t "context );
 .
 .SH "DESCRIPTION"
 .BR getsockcreatecon ()
@@ -33,6 +37,12 @@ can be applied prior to library
 functions that internally perform an file creation,
 in order to set an file context on the objects.
 
+.BR getsockcreatecon_raw ()
+and
+.BR setsockcreatecon_raw ()
+behave identically to their non-raw counterparts but do not perform context
+translation.
+
 .B Note:
 Signal handlers that perform a
 .BR setsockcreatecon ()
diff --git a/libselinux/man/man3/getsockcreatecon_raw.3 b/libselinux/man/man3/getsockcreatecon_raw.3
new file mode 100644
index 0000000..ed1a371
--- /dev/null
+++ b/libselinux/man/man3/getsockcreatecon_raw.3
@@ -0,0 +1 @@
+.so man3/getsockcreatecon.3
diff --git a/libselinux/man/man3/lgetfilecon_raw.3 b/libselinux/man/man3/lgetfilecon_raw.3
new file mode 100644
index 0000000..ae6dfcf
--- /dev/null
+++ b/libselinux/man/man3/lgetfilecon_raw.3
@@ -0,0 +1 @@
+.so man3/getfilecon.3
diff --git a/libselinux/man/man3/lsetfilecon_raw.3 b/libselinux/man/man3/lsetfilecon_raw.3
new file mode 100644
index 0000000..33c321a
--- /dev/null
+++ b/libselinux/man/man3/lsetfilecon_raw.3
@@ -0,0 +1 @@
+.so man3/setfilecon.3
diff --git a/libselinux/man/man3/security_check_context.3 b/libselinux/man/man3/security_check_context.3
index 60d571d..7ba4ead 100644
--- a/libselinux/man/man3/security_check_context.3
+++ b/libselinux/man/man3/security_check_context.3
@@ -6,11 +6,18 @@ security_check_context \- check the validity of a SELinux context
 .B #include <selinux/selinux.h>
 .sp
 .BI "int security_check_context(security_context_t "con );
+.sp
+.BI "int security_check_context_raw(security_context_t "con );
 .
 .SH "DESCRIPTION"
 .BR security_check_context ()
 returns 0 if SELinux is running and the context is valid, otherwise it
 returns \-1.
+
+.BR security_check_context_raw ()
+behaves identically to
+.BR \%security_check_context ()
+but does not perform context translation.
 .
 .SH "SEE ALSO"
 .BR selinux "(8)"
diff --git a/libselinux/man/man3/security_check_context_raw.3 b/libselinux/man/man3/security_check_context_raw.3
new file mode 100644
index 0000000..ee93986
--- /dev/null
+++ b/libselinux/man/man3/security_check_context_raw.3
@@ -0,0 +1 @@
+.so man3/security_check_context.3
diff --git a/libselinux/man/man3/security_compute_av.3 b/libselinux/man/man3/security_compute_av.3
index 6034019..c6837fc 100644
--- a/libselinux/man/man3/security_compute_av.3
+++ b/libselinux/man/man3/security_compute_av.3
@@ -11,20 +11,36 @@ the SELinux policy database in the kernel
 .sp
 .BI "int security_compute_av(security_context_t "scon ", security_context_t "tcon ", security_class_t "tclass ", access_vector_t "requested ", struct av_decision *" avd );
 .sp
+.BI "int security_compute_av_raw(security_context_t "scon ", security_context_t "tcon ", security_class_t "tclass ", access_vector_t "requested ", struct av_decision *" avd );
+.sp
 .BI "int security_compute_av_flags(security_context_t "scon ", security_context_t "tcon ", security_class_t "tclass ", access_vector_t "requested ", struct av_decision *" avd );
 .sp
+.BI "int security_compute_av_flags_raw(security_context_t "scon ", security_context_t "tcon ", security_class_t "tclass ", access_vector_t "requested ", struct av_decision *" avd );
+.sp
 .BI "int security_compute_create(security_context_t "scon ", security_context_t "tcon ", security_class_t "tclass ", security_context_t *" newcon );
 .sp
+.BI "int security_compute_create_raw(security_context_t "scon ", security_context_t "tcon ", security_class_t "tclass ", security_context_t *" newcon );
+.sp
 .BI "int security_compute_create_name(security_context_t "scon ", security_context_t "tcon ", security_class_t "tclass ", const char *"objname ", security_context_t *" newcon );
 .sp
+.BI "int security_compute_create_name_raw(security_context_t "scon ", security_context_t "tcon ", security_class_t "tclass ", const char *"objname ", security_context_t *" newcon );
+.sp
 .BI "int security_compute_relabel(security_context_t "scon ", security_context_t "tcon ", security_class_t "tclass ", security_context_t *" newcon );
 .sp
+.BI "int security_compute_relabel_raw(security_context_t "scon ", security_context_t "tcon ", security_class_t "tclass ", security_context_t *" newcon );
+.sp
 .BI "int security_compute_member(security_context_t "scon ", security_context_t "tcon ", security_class_t "tclass ", security_context_t *" newcon );
 .sp
+.BI "int security_compute_member_raw(security_context_t "scon ", security_context_t "tcon ", security_class_t "tclass ", security_context_t *" newcon );
+.sp
 .BI "int security_compute_user(security_context_t "scon ", const char *" username ", security_context_t **" con );
 .sp
+.BI "int security_compute_user_raw(security_context_t "scon ", const char *" username ", security_context_t **" con );
+.sp
 .BI "int security_get_initial_context(const char *" name ", security_context_t " con );
 .sp
+.BI "int security_get_initial_context_raw(const char *" name ", security_context_t " con );
+.sp
 .BI "int selinux_check_access(const security_context_t " scon ", const security_context_t " tcon ", const char *" class ", const char *" perm ", void *" auditdata);
 .sp
 .BI "int selinux_check_passwd_access(access_vector_t " requested );
@@ -90,6 +106,18 @@ source context. It is mainly used by
 is used to get the context of a kernel initial security identifier specified by 
 .I name
 
+.BR security_compute_av_raw (),
+.BR security_compute_av_flags_raw (),
+.BR \%security_compute_create_raw (),
+.BR \%security_compute_create_name_raw (),
+.BR \%security_compute_relabel_raw (),
+.BR \%security_compute_member_raw (),
+.BR \%security_compute_user_raw ()
+and
+.BR \%security_get_initial_context_raw ()
+behave identically to their non-raw counterparts but do not perform context
+translation.
+
 .BR selinux_check_access ()
 is used to check if the source context has the access permission for the specified class on the target context.
 
diff --git a/libselinux/man/man3/security_compute_av_flags_raw.3 b/libselinux/man/man3/security_compute_av_flags_raw.3
new file mode 100644
index 0000000..a60bca4
--- /dev/null
+++ b/libselinux/man/man3/security_compute_av_flags_raw.3
@@ -0,0 +1 @@
+.so man3/security_compute_av.3
diff --git a/libselinux/man/man3/security_compute_av_raw.3 b/libselinux/man/man3/security_compute_av_raw.3
new file mode 100644
index 0000000..a60bca4
--- /dev/null
+++ b/libselinux/man/man3/security_compute_av_raw.3
@@ -0,0 +1 @@
+.so man3/security_compute_av.3
diff --git a/libselinux/man/man3/security_compute_create_name_raw.3 b/libselinux/man/man3/security_compute_create_name_raw.3
new file mode 100644
index 0000000..a60bca4
--- /dev/null
+++ b/libselinux/man/man3/security_compute_create_name_raw.3
@@ -0,0 +1 @@
+.so man3/security_compute_av.3
diff --git a/libselinux/man/man3/security_compute_create_raw.3 b/libselinux/man/man3/security_compute_create_raw.3
new file mode 100644
index 0000000..a60bca4
--- /dev/null
+++ b/libselinux/man/man3/security_compute_create_raw.3
@@ -0,0 +1 @@
+.so man3/security_compute_av.3
diff --git a/libselinux/man/man3/security_compute_member_raw.3 b/libselinux/man/man3/security_compute_member_raw.3
new file mode 100644
index 0000000..a60bca4
--- /dev/null
+++ b/libselinux/man/man3/security_compute_member_raw.3
@@ -0,0 +1 @@
+.so man3/security_compute_av.3
diff --git a/libselinux/man/man3/security_compute_relabel_raw.3 b/libselinux/man/man3/security_compute_relabel_raw.3
new file mode 100644
index 0000000..a60bca4
--- /dev/null
+++ b/libselinux/man/man3/security_compute_relabel_raw.3
@@ -0,0 +1 @@
+.so man3/security_compute_av.3
diff --git a/libselinux/man/man3/security_compute_user_raw.3 b/libselinux/man/man3/security_compute_user_raw.3
new file mode 100644
index 0000000..a60bca4
--- /dev/null
+++ b/libselinux/man/man3/security_compute_user_raw.3
@@ -0,0 +1 @@
+.so man3/security_compute_av.3
diff --git a/libselinux/man/man3/security_get_initial_context_raw.3 b/libselinux/man/man3/security_get_initial_context_raw.3
new file mode 100644
index 0000000..a60bca4
--- /dev/null
+++ b/libselinux/man/man3/security_get_initial_context_raw.3
@@ -0,0 +1 @@
+.so man3/security_compute_av.3
diff --git a/libselinux/man/man3/selabel_lookup_raw.3 b/libselinux/man/man3/selabel_lookup_raw.3
new file mode 100644
index 0000000..64e003e
--- /dev/null
+++ b/libselinux/man/man3/selabel_lookup_raw.3
@@ -0,0 +1 @@
+.so man3/selabel_lookup.3
diff --git a/libselinux/man/man3/setcon_raw.3 b/libselinux/man/man3/setcon_raw.3
new file mode 100644
index 0000000..1210b5a
--- /dev/null
+++ b/libselinux/man/man3/setcon_raw.3
@@ -0,0 +1 @@
+.so man3/getcon.3
diff --git a/libselinux/man/man3/setexeccon_raw.3 b/libselinux/man/man3/setexeccon_raw.3
new file mode 100644
index 0000000..b2e6ab8
--- /dev/null
+++ b/libselinux/man/man3/setexeccon_raw.3
@@ -0,0 +1 @@
+.so man3/getexeccon.3
diff --git a/libselinux/man/man3/setfilecon.3 b/libselinux/man/man3/setfilecon.3
index 7da024b..5acc9bb 100644
--- a/libselinux/man/man3/setfilecon.3
+++ b/libselinux/man/man3/setfilecon.3
@@ -7,9 +7,15 @@ setfilecon, fsetfilecon, lsetfilecon \- set SELinux security context of a file
 .sp
 .BI "int setfilecon(const char *" path ", security_context_t "con );
 .sp
+.BI "int setfilecon_raw(const char *" path ", security_context_t "con );
+.sp
 .BI "int lsetfilecon(const char *" path ", security_context_t "con );
 .sp
+.BI "int lsetfilecon_raw(const char *" path ", security_context_t "con );
+.sp
 .BI "int fsetfilecon(int "fd ", security_context_t "con );
+.sp
+.BI "int fsetfilecon_raw(int "fd ", security_context_t "con );
 .
 .SH "DESCRIPTION"
 .BR setfilecon ()
@@ -24,6 +30,13 @@ is identical to setfilecon, only the open file pointed to by filedes (as
 returned by
 .BR open (2))
 has it's context set in place of path.
+
+.BR setfilecon_raw (),
+.BR lsetfilecon_raw (),
+and
+.BR fsetfilecon_raw ()
+behave identically to their non-raw counterparts but do not perform context
+translation.
 .
 .SH "RETURN VALUE"
 On success, zero is returned. On failure, \-1 is returned and
diff --git a/libselinux/man/man3/setfilecon_raw.3 b/libselinux/man/man3/setfilecon_raw.3
new file mode 100644
index 0000000..33c321a
--- /dev/null
+++ b/libselinux/man/man3/setfilecon_raw.3
@@ -0,0 +1 @@
+.so man3/setfilecon.3
diff --git a/libselinux/man/man3/setfscreatecon_raw.3 b/libselinux/man/man3/setfscreatecon_raw.3
new file mode 100644
index 0000000..21aeebd
--- /dev/null
+++ b/libselinux/man/man3/setfscreatecon_raw.3
@@ -0,0 +1 @@
+.so man3/getfscreatecon.3
diff --git a/libselinux/man/man3/setkeycreatecon_raw.3 b/libselinux/man/man3/setkeycreatecon_raw.3
new file mode 100644
index 0000000..1e0ec5f
--- /dev/null
+++ b/libselinux/man/man3/setkeycreatecon_raw.3
@@ -0,0 +1 @@
+.so man3/getkeycreatecon.3
diff --git a/libselinux/man/man3/setsockcreatecon_raw.3 b/libselinux/man/man3/setsockcreatecon_raw.3
new file mode 100644
index 0000000..ed1a371
--- /dev/null
+++ b/libselinux/man/man3/setsockcreatecon_raw.3
@@ -0,0 +1 @@
+.so man3/getsockcreatecon.3
-- 
1.8.0


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
