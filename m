Message-ID: <459E7B6C.7090304@redhat.com>
Date: Fri, 05 Jan 2007 11:23:08 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Klaus Weidner <klaus@atsec.com>, Joshua Brindle <jbrindle@tresys.com>,
        James Antill <jantill@redhat.com>,
        Linda Knippers <linda.knippers@hp.com>,
        redhat-lspp <redhat-lspp@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [redhat-lspp] Re: [PATCH 2/3] Re: MLS enforcing PTYs,	sshd,	and
 newrole
References: <20070105033311.GA24315@w-m-p.com>	 <6FE441CD9F0C0C479F2D88F959B015886CA28F@exchange.columbia.tresys.com>	 <20070105040119.GB24315@w-m-p.com> <1168012584.18961.161.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1168012584.18961.161.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------020000020807010903050107"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020000020807010903050107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

libselinux securetty_context patch

--------------020000020807010903050107
Content-Type: text/x-patch;
 name="libselinux-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibselinux/debugfiles.list libselinux-1.33.3/debugfiles.list
--- nsalibselinux/debugfiles.list	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.33.3/debugfiles.list	2007-01-05 10:24:49.000000000 -0500
@@ -0,0 +1,10 @@
+/usr/lib/debug/usr/sbin/getsebool.debug
+/usr/lib/debug/usr/sbin/getenforce.debug
+/usr/lib/debug/usr/sbin/selinuxenabled.debug
+/usr/lib/debug/usr/sbin/avcstat.debug
+/usr/lib/debug/usr/sbin/matchpathcon.debug
+/usr/lib/debug/usr/sbin/togglesebool.debug
+/usr/lib/debug/usr/sbin/setenforce.debug
+/usr/lib/debug/usr/lib/python2.4/site-packages/_selinux.so.debug
+/usr/lib/debug/lib/libselinux.so.1.debug
+/usr/src/debug/libselinux-1.33.3
Binary files nsalibselinux/debugsources.list and libselinux-1.33.3/debugsources.list differ
diff --exclude-from=exclude -N -u -r nsalibselinux/include/selinux/selinux.h libselinux-1.33.3/include/selinux/selinux.h
--- nsalibselinux/include/selinux/selinux.h	2006-11-16 17:15:18.000000000 -0500
+++ libselinux-1.33.3/include/selinux/selinux.h	2007-01-05 10:24:22.000000000 -0500
@@ -406,6 +406,7 @@
 	extern const char *selinux_homedir_context_path(void);
 	extern const char *selinux_media_context_path(void);
 	extern const char *selinux_contexts_path(void);
+	extern const char *selinux_securetty_context_path(void);
 	extern const char *selinux_booleans_path(void);
 	extern const char *selinux_customizable_types_path(void);
 	extern const char *selinux_users_path(void);
@@ -413,12 +414,14 @@
 	extern const char *selinux_translations_path(void);
 	extern const char *selinux_netfilter_context_path(void);
 	extern const char *selinux_path(void);
-
 /* Check a permission in the passwd class.
    Return 0 if granted or -1 otherwise. */
 	extern int selinux_check_passwd_access(access_vector_t requested);
 	extern int checkPasswdAccess(access_vector_t requested);
 
+/* Check if the tty_context is defined as a securetty
+   Return 1 if secure, 0 if not, or -1 if otherwise. */
+	extern int selinux_check_securetty_context(security_context_t tty_context);
 /* Set the path to the selinuxfs mount point explicitly.
    Normally, this is determined automatically during libselinux 
    initialization, but this is not always possible, e.g. for /sbin/init
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/selinux_binary_policy_path.3 libselinux-1.33.3/man/man3/selinux_binary_policy_path.3
--- nsalibselinux/man/man3/selinux_binary_policy_path.3	2006-11-16 17:15:30.000000000 -0500
+++ libselinux-1.33.3/man/man3/selinux_binary_policy_path.3	2007-01-05 10:24:22.000000000 -0500
@@ -27,6 +27,8 @@
 .br
 extern const char *selinux_media_context_path(void);
 .br
+extern const char *selinux_securetty_context_path(void);
+.br
 extern const char *selinux_contexts_path(void);
 .br
 extern const char *selinux_booleans_path(void);
@@ -56,6 +58,8 @@
 .sp
 selinux_contexts_path() - directory containing all of the context configuration files
 .sp
+selinux_securetty_context_path() - defines terminal contexts for securetty
+.sp
 selinux_booleans_path() - initial policy boolean settings
 
 .SH AUTHOR	
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/selinux_check_securetty_context.3 libselinux-1.33.3/man/man3/selinux_check_securetty_context.3
--- nsalibselinux/man/man3/selinux_check_securetty_context.3	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.33.3/man/man3/selinux_check_securetty_context.3	2007-01-05 10:24:22.000000000 -0500
@@ -0,0 +1,13 @@
+.TH "selinux_check_securetty_context" "3" "1 January 2007" "dwalsh@redhat.com" "SE Linux API documentation"
+.SH "NAME"
+selinux_check_securetty_context \- check whether a tty security context is defined as a securetty context
+.SH "SYNOPSIS"
+.B #include <selinux/selinux.h>
+.sp
+.BI "int selinux_check_securetty_context(security_context_t "tty_context );
+
+.SH "DESCRIPTION"
+.B selinux_check_securetty_context
+returns 1 if tty_context is a securetty context
+returns 0 if tty_context is a not a securetty context
+returns -1 on error.
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/selinux_securetty_context_path.3 libselinux-1.33.3/man/man3/selinux_securetty_context_path.3
--- nsalibselinux/man/man3/selinux_securetty_context_path.3	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.33.3/man/man3/selinux_securetty_context_path.3	2007-01-05 10:24:22.000000000 -0500
@@ -0,0 +1 @@
+.so man3/selinux_binary_policy_path.3
Binary files nsalibselinux/src/avc_internal.lo and libselinux-1.33.3/src/avc_internal.lo differ
Binary files nsalibselinux/src/avc_internal.o and libselinux-1.33.3/src/avc_internal.o differ
Binary files nsalibselinux/src/avc.lo and libselinux-1.33.3/src/avc.lo differ
Binary files nsalibselinux/src/avc.o and libselinux-1.33.3/src/avc.o differ
Binary files nsalibselinux/src/avc_sidtab.lo and libselinux-1.33.3/src/avc_sidtab.lo differ
Binary files nsalibselinux/src/avc_sidtab.o and libselinux-1.33.3/src/avc_sidtab.o differ
Binary files nsalibselinux/src/booleans.lo and libselinux-1.33.3/src/booleans.lo differ
Binary files nsalibselinux/src/booleans.o and libselinux-1.33.3/src/booleans.o differ
Binary files nsalibselinux/src/canonicalize_context.lo and libselinux-1.33.3/src/canonicalize_context.lo differ
Binary files nsalibselinux/src/canonicalize_context.o and libselinux-1.33.3/src/canonicalize_context.o differ
Binary files nsalibselinux/src/checkAccess.lo and libselinux-1.33.3/src/checkAccess.lo differ
Binary files nsalibselinux/src/checkAccess.o and libselinux-1.33.3/src/checkAccess.o differ
Binary files nsalibselinux/src/check_context.lo and libselinux-1.33.3/src/check_context.lo differ
Binary files nsalibselinux/src/check_context.o and libselinux-1.33.3/src/check_context.o differ
Binary files nsalibselinux/src/compute_av.lo and libselinux-1.33.3/src/compute_av.lo differ
Binary files nsalibselinux/src/compute_av.o and libselinux-1.33.3/src/compute_av.o differ
Binary files nsalibselinux/src/compute_create.lo and libselinux-1.33.3/src/compute_create.lo differ
Binary files nsalibselinux/src/compute_create.o and libselinux-1.33.3/src/compute_create.o differ
Binary files nsalibselinux/src/compute_member.lo and libselinux-1.33.3/src/compute_member.lo differ
Binary files nsalibselinux/src/compute_member.o and libselinux-1.33.3/src/compute_member.o differ
Binary files nsalibselinux/src/compute_relabel.lo and libselinux-1.33.3/src/compute_relabel.lo differ
Binary files nsalibselinux/src/compute_relabel.o and libselinux-1.33.3/src/compute_relabel.o differ
Binary files nsalibselinux/src/compute_user.lo and libselinux-1.33.3/src/compute_user.lo differ
Binary files nsalibselinux/src/compute_user.o and libselinux-1.33.3/src/compute_user.o differ
Binary files nsalibselinux/src/context.lo and libselinux-1.33.3/src/context.lo differ
Binary files nsalibselinux/src/context.o and libselinux-1.33.3/src/context.o differ
Binary files nsalibselinux/src/disable.lo and libselinux-1.33.3/src/disable.lo differ
Binary files nsalibselinux/src/disable.o and libselinux-1.33.3/src/disable.o differ
Binary files nsalibselinux/src/enabled.lo and libselinux-1.33.3/src/enabled.lo differ
Binary files nsalibselinux/src/enabled.o and libselinux-1.33.3/src/enabled.o differ
Binary files nsalibselinux/src/fgetfilecon.lo and libselinux-1.33.3/src/fgetfilecon.lo differ
Binary files nsalibselinux/src/fgetfilecon.o and libselinux-1.33.3/src/fgetfilecon.o differ
diff --exclude-from=exclude -N -u -r nsalibselinux/src/file_path_suffixes.h libselinux-1.33.3/src/file_path_suffixes.h
--- nsalibselinux/src/file_path_suffixes.h	2006-11-16 17:15:25.000000000 -0500
+++ libselinux-1.33.3/src/file_path_suffixes.h	2007-01-05 10:24:22.000000000 -0500
@@ -7,6 +7,7 @@
     S_(USER_CONTEXTS, "/contexts/users/")
     S_(FAILSAFE_CONTEXT, "/contexts/failsafe_context")
     S_(DEFAULT_TYPE, "/contexts/default_type")
+    S_(SECURETTY_CONTEXTS, "/contexts/securetty_contexts")
     S_(BOOLEANS, "/booleans")
     S_(MEDIA_CONTEXTS, "/contexts/files/media")
     S_(REMOVABLE_CONTEXT, "/contexts/removable_context")
Binary files nsalibselinux/src/freeconary.lo and libselinux-1.33.3/src/freeconary.lo differ
Binary files nsalibselinux/src/freeconary.o and libselinux-1.33.3/src/freeconary.o differ
Binary files nsalibselinux/src/freecon.lo and libselinux-1.33.3/src/freecon.lo differ
Binary files nsalibselinux/src/freecon.o and libselinux-1.33.3/src/freecon.o differ
Binary files nsalibselinux/src/fsetfilecon.lo and libselinux-1.33.3/src/fsetfilecon.lo differ
Binary files nsalibselinux/src/fsetfilecon.o and libselinux-1.33.3/src/fsetfilecon.o differ
Binary files nsalibselinux/src/get_context_list.lo and libselinux-1.33.3/src/get_context_list.lo differ
Binary files nsalibselinux/src/get_context_list.o and libselinux-1.33.3/src/get_context_list.o differ
Binary files nsalibselinux/src/get_default_type.lo and libselinux-1.33.3/src/get_default_type.lo differ
Binary files nsalibselinux/src/get_default_type.o and libselinux-1.33.3/src/get_default_type.o differ
Binary files nsalibselinux/src/getenforce.lo and libselinux-1.33.3/src/getenforce.lo differ
Binary files nsalibselinux/src/getenforce.o and libselinux-1.33.3/src/getenforce.o differ
Binary files nsalibselinux/src/getfilecon.lo and libselinux-1.33.3/src/getfilecon.lo differ
Binary files nsalibselinux/src/getfilecon.o and libselinux-1.33.3/src/getfilecon.o differ
Binary files nsalibselinux/src/getpeercon.lo and libselinux-1.33.3/src/getpeercon.lo differ
Binary files nsalibselinux/src/getpeercon.o and libselinux-1.33.3/src/getpeercon.o differ
Binary files nsalibselinux/src/init.lo and libselinux-1.33.3/src/init.lo differ
Binary files nsalibselinux/src/init.o and libselinux-1.33.3/src/init.o differ
Binary files nsalibselinux/src/is_customizable_type.lo and libselinux-1.33.3/src/is_customizable_type.lo differ
Binary files nsalibselinux/src/is_customizable_type.o and libselinux-1.33.3/src/is_customizable_type.o differ
Binary files nsalibselinux/src/lgetfilecon.lo and libselinux-1.33.3/src/lgetfilecon.lo differ
Binary files nsalibselinux/src/lgetfilecon.o and libselinux-1.33.3/src/lgetfilecon.o differ
Binary files nsalibselinux/src/libselinux.a and libselinux-1.33.3/src/libselinux.a differ
Binary files nsalibselinux/src/libselinux.so and libselinux-1.33.3/src/libselinux.so differ
Binary files nsalibselinux/src/libselinux.so.1 and libselinux-1.33.3/src/libselinux.so.1 differ
Binary files nsalibselinux/src/load_policy.lo and libselinux-1.33.3/src/load_policy.lo differ
Binary files nsalibselinux/src/load_policy.o and libselinux-1.33.3/src/load_policy.o differ
Binary files nsalibselinux/src/lsetfilecon.lo and libselinux-1.33.3/src/lsetfilecon.lo differ
Binary files nsalibselinux/src/lsetfilecon.o and libselinux-1.33.3/src/lsetfilecon.o differ
Binary files nsalibselinux/src/matchmediacon.lo and libselinux-1.33.3/src/matchmediacon.lo differ
Binary files nsalibselinux/src/matchmediacon.o and libselinux-1.33.3/src/matchmediacon.o differ
Binary files nsalibselinux/src/matchpathcon.lo and libselinux-1.33.3/src/matchpathcon.lo differ
Binary files nsalibselinux/src/matchpathcon.o and libselinux-1.33.3/src/matchpathcon.o differ
Binary files nsalibselinux/src/policyvers.lo and libselinux-1.33.3/src/policyvers.lo differ
Binary files nsalibselinux/src/policyvers.o and libselinux-1.33.3/src/policyvers.o differ
Binary files nsalibselinux/src/procattr.lo and libselinux-1.33.3/src/procattr.lo differ
Binary files nsalibselinux/src/procattr.o and libselinux-1.33.3/src/procattr.o differ
Binary files nsalibselinux/src/query_user_context.lo and libselinux-1.33.3/src/query_user_context.lo differ
Binary files nsalibselinux/src/query_user_context.o and libselinux-1.33.3/src/query_user_context.o differ
Binary files nsalibselinux/src/rpm.lo and libselinux-1.33.3/src/rpm.lo differ
Binary files nsalibselinux/src/rpm.o and libselinux-1.33.3/src/rpm.o differ
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinux_check_securetty_context.c libselinux-1.33.3/src/selinux_check_securetty_context.c
--- nsalibselinux/src/selinux_check_securetty_context.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.33.3/src/selinux_check_securetty_context.c	2007-01-05 10:33:18.000000000 -0500
@@ -0,0 +1,44 @@
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdio.h>
+#include <ctype.h>
+#include "selinux_internal.h"
+#include "context_internal.h"
+
+int selinux_check_securetty_context(security_context_t tty_context)
+{
+	char buf[250];
+	char *ptr = "", *end;
+	size_t len;
+	int found = -1;
+	FILE *fp;
+
+	fp = fopen(selinux_securetty_context_path(), "r");
+	if (fp) {
+		found = 0;
+		len = strlen(tty_context);
+		while (!feof_unlocked(fp)) {
+			if (!fgets_unlocked(buf, sizeof buf, fp))
+				return found;
+			if (buf[strlen(buf) - 1])
+				buf[strlen(buf) - 1] = 0;
+
+			ptr = buf;
+			while (*ptr && isspace(*ptr))
+				ptr++;
+			if (!(*ptr))
+				continue;
+
+			if (!strncmp(tty_context, ptr, len)) {
+				found = 1;
+				break;
+			}
+		}
+		fclose(fp);
+	}
+
+	return found;
+}
+
+hidden_def(selinux_check_securetty_context)
Binary files nsalibselinux/src/selinux_check_securetty_context.lo and libselinux-1.33.3/src/selinux_check_securetty_context.lo differ
Binary files nsalibselinux/src/selinux_check_securetty_context.o and libselinux-1.33.3/src/selinux_check_securetty_context.o differ
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinux_config.c libselinux-1.33.3/src/selinux_config.c
--- nsalibselinux/src/selinux_config.c	2006-11-16 17:15:25.000000000 -0500
+++ libselinux-1.33.3/src/selinux_config.c	2007-01-05 10:24:22.000000000 -0500
@@ -38,7 +38,8 @@
 #define NETFILTER_CONTEXTS    15
 #define FILE_CONTEXTS_HOMEDIR 16
 #define FILE_CONTEXTS_LOCAL 17
-#define NEL               18
+#define SECURETTY_CONTEXTS  18
+#define NEL               19
 
 /* New layout is relative to SELINUXDIR/policytype. */
 static char *file_paths[NEL];
@@ -299,6 +300,12 @@
 
 hidden_def(selinux_default_context_path)
 
+const char *selinux_securetty_context_path()
+{
+	return get_path(SECURETTY_CONTEXTS);
+}
+hidden_def(selinux_securetty_context_path)
+
 const char *selinux_failsafe_context_path()
 {
 	return get_path(FAILSAFE_CONTEXT);
Binary files nsalibselinux/src/selinux_config.lo and libselinux-1.33.3/src/selinux_config.lo differ
Binary files nsalibselinux/src/selinux_config.o and libselinux-1.33.3/src/selinux_config.o differ
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinux_internal.h libselinux-1.33.3/src/selinux_internal.h
--- nsalibselinux/src/selinux_internal.h	2006-11-16 17:15:25.000000000 -0500
+++ libselinux-1.33.3/src/selinux_internal.h	2007-01-05 10:24:22.000000000 -0500
@@ -53,6 +53,7 @@
     hidden_proto(security_setenforce)
     hidden_proto(selinux_binary_policy_path)
     hidden_proto(selinux_default_context_path)
+    hidden_proto(selinux_securetty_context_path)
     hidden_proto(selinux_failsafe_context_path)
     hidden_proto(selinux_removable_context_path)
     hidden_proto(selinux_file_context_path)
@@ -66,6 +67,7 @@
     hidden_proto(selinux_media_context_path)
     hidden_proto(selinux_path)
     hidden_proto(selinux_check_passwd_access)
+    hidden_proto(selinux_check_securetty_context)
     hidden_proto(matchpathcon_init_prefix)
     hidden_proto(selinux_users_path)
     hidden_proto(selinux_usersconf_path);
Binary files nsalibselinux/src/_selinux.so and libselinux-1.33.3/src/_selinux.so differ
Binary files nsalibselinux/src/selinuxswig_wrap.lo and libselinux-1.33.3/src/selinuxswig_wrap.lo differ
Binary files nsalibselinux/src/setenforce.lo and libselinux-1.33.3/src/setenforce.lo differ
Binary files nsalibselinux/src/setenforce.o and libselinux-1.33.3/src/setenforce.o differ
Binary files nsalibselinux/src/setfilecon.lo and libselinux-1.33.3/src/setfilecon.lo differ
Binary files nsalibselinux/src/setfilecon.o and libselinux-1.33.3/src/setfilecon.o differ
Binary files nsalibselinux/src/setrans_client.lo and libselinux-1.33.3/src/setrans_client.lo differ
Binary files nsalibselinux/src/setrans_client.o and libselinux-1.33.3/src/setrans_client.o differ
Binary files nsalibselinux/src/seusers.lo and libselinux-1.33.3/src/seusers.lo differ
Binary files nsalibselinux/src/seusers.o and libselinux-1.33.3/src/seusers.o differ
Binary files nsalibselinux/utils/avcstat and libselinux-1.33.3/utils/avcstat differ
Binary files nsalibselinux/utils/compute_av and libselinux-1.33.3/utils/compute_av differ
Binary files nsalibselinux/utils/compute_create and libselinux-1.33.3/utils/compute_create differ
Binary files nsalibselinux/utils/compute_member and libselinux-1.33.3/utils/compute_member differ
Binary files nsalibselinux/utils/compute_relabel and libselinux-1.33.3/utils/compute_relabel differ
Binary files nsalibselinux/utils/compute_user and libselinux-1.33.3/utils/compute_user differ
Binary files nsalibselinux/utils/getconlist and libselinux-1.33.3/utils/getconlist differ
Binary files nsalibselinux/utils/getenforce and libselinux-1.33.3/utils/getenforce differ
Binary files nsalibselinux/utils/getfilecon and libselinux-1.33.3/utils/getfilecon differ
Binary files nsalibselinux/utils/getpidcon and libselinux-1.33.3/utils/getpidcon differ
Binary files nsalibselinux/utils/getsebool and libselinux-1.33.3/utils/getsebool differ
Binary files nsalibselinux/utils/getseuser and libselinux-1.33.3/utils/getseuser differ
Binary files nsalibselinux/utils/matchpathcon and libselinux-1.33.3/utils/matchpathcon differ
Binary files nsalibselinux/utils/policyvers and libselinux-1.33.3/utils/policyvers differ
Binary files nsalibselinux/utils/selinux_check_securetty_context and libselinux-1.33.3/utils/selinux_check_securetty_context differ
diff --exclude-from=exclude -N -u -r nsalibselinux/utils/selinux_check_securetty_context.c libselinux-1.33.3/utils/selinux_check_securetty_context.c
--- nsalibselinux/utils/selinux_check_securetty_context.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.33.3/utils/selinux_check_securetty_context.c	2007-01-05 10:26:51.000000000 -0500
@@ -0,0 +1,40 @@
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <getopt.h>
+#include <errno.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/errno.h>
+#include <selinux/selinux.h>
+
+void usage(const char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s tty_context...\n",
+		progname);
+	exit(1);
+}
+
+int main(int argc, char **argv)
+{
+	int i;
+	if (argc < 2)
+		usage(argv[0]);
+
+	for (i = 1; i < argc; i++) {
+		switch (selinux_check_securetty_context(argv[i])) {
+		case 1:
+			printf("%s securetty.\n", argv[i]);
+			break;
+		case 0:
+			printf("%s not securetty.\n", argv[i]);
+			break;
+		case -1:
+			perror("Failed on check if securetty");
+			return -1;
+		}
+	}
+	return 0;
+}
Binary files nsalibselinux/utils/selinuxenabled and libselinux-1.33.3/utils/selinuxenabled differ
Binary files nsalibselinux/utils/setenforce and libselinux-1.33.3/utils/setenforce differ
Binary files nsalibselinux/utils/setfilecon and libselinux-1.33.3/utils/setfilecon differ
Binary files nsalibselinux/utils/togglesebool and libselinux-1.33.3/utils/togglesebool differ

--------------020000020807010903050107--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
