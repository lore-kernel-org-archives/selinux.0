Message-ID: <459E856B.60800@redhat.com>
Date: Fri, 05 Jan 2007 12:05:47 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, James Antill <jantill@redhat.com>,
        Linda Knippers <linda.knippers@hp.com>,
        redhat-lspp <redhat-lspp@redhat.com>, Klaus Weidner <klaus@atsec.com>,
        SE Linux <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [redhat-lspp] Re: [PATCH 2/3] Re: MLS enforcing PTYs,	sshd,	and
 newrole
References: <20070105033311.GA24315@w-m-p.com>		<6FE441CD9F0C0C479F2D88F959B015886CA28F@exchange.columbia.tresys.com>		<20070105040119.GB24315@w-m-p.com>	<1168012584.18961.161.camel@moss-spartans.epoch.ncsc.mil> <459E7BA2.1050109@redhat.com>
In-Reply-To: <459E7BA2.1050109@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------000604030809060202070904"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000604030809060202070904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

First libselinux-rhat patch was broken.  Needs to only check the context 
type.

more /etc/selinux/mls/contexts/securetty_contexts
sysadm_tty_device_t
staff_tty_device_t
user_tty_device_t



--------------000604030809060202070904
Content-Type: text/x-patch;
 name="libselinux-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibselinux/include/selinux/selinux.h libselinux-1.33.3/include/selinux/selinux.h
--- nsalibselinux/include/selinux/selinux.h	2006-11-16 17:15:18.000000000 -0500
+++ libselinux-1.33.3/include/selinux/selinux.h	2007-01-05 11:57:44.000000000 -0500
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
+++ libselinux-1.33.3/man/man3/selinux_binary_policy_path.3	2007-01-05 11:57:44.000000000 -0500
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
+++ libselinux-1.33.3/man/man3/selinux_check_securetty_context.3	2007-01-05 11:57:44.000000000 -0500
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
+++ libselinux-1.33.3/man/man3/selinux_securetty_context_path.3	2007-01-05 11:57:44.000000000 -0500
@@ -0,0 +1 @@
+.so man3/selinux_binary_policy_path.3
diff --exclude-from=exclude -N -u -r nsalibselinux/src/file_path_suffixes.h libselinux-1.33.3/src/file_path_suffixes.h
--- nsalibselinux/src/file_path_suffixes.h	2006-11-16 17:15:25.000000000 -0500
+++ libselinux-1.33.3/src/file_path_suffixes.h	2007-01-05 11:57:44.000000000 -0500
@@ -7,6 +7,7 @@
     S_(USER_CONTEXTS, "/contexts/users/")
     S_(FAILSAFE_CONTEXT, "/contexts/failsafe_context")
     S_(DEFAULT_TYPE, "/contexts/default_type")
+    S_(SECURETTY_CONTEXTS, "/contexts/securetty_contexts")
     S_(BOOLEANS, "/booleans")
     S_(MEDIA_CONTEXTS, "/contexts/files/media")
     S_(REMOVABLE_CONTEXT, "/contexts/removable_context")
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinux_check_securetty_context.c libselinux-1.33.3/src/selinux_check_securetty_context.c
--- nsalibselinux/src/selinux_check_securetty_context.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.33.3/src/selinux_check_securetty_context.c	2007-01-05 11:57:44.000000000 -0500
@@ -0,0 +1,49 @@
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
+	fp = fopen(selinux_securetty_context_path(), "r");
+	if (fp) {
+		context_t con =context_new(tty_context);
+		if (con) {
+			char *type=context_type_get(con);
+			found = 0;
+			len = strlen(type);
+			while (!feof_unlocked(fp)) {
+				if (!fgets_unlocked(buf, sizeof buf, fp))
+					break;
+
+				if (buf[strlen(buf) - 1])
+					buf[strlen(buf) - 1] = 0;
+
+				ptr = buf;
+				while (*ptr && isspace(*ptr))
+					ptr++;
+				if (!(*ptr))
+					continue;
+
+				if (!strncmp(type, ptr, len)) {
+					found = 1;
+					break;
+				}
+			}
+			context_free(con);
+		}
+		fclose(fp);
+	}
+
+	return found;
+}
+
+hidden_def(selinux_check_securetty_context)
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinux_config.c libselinux-1.33.3/src/selinux_config.c
--- nsalibselinux/src/selinux_config.c	2006-11-16 17:15:25.000000000 -0500
+++ libselinux-1.33.3/src/selinux_config.c	2007-01-05 11:57:44.000000000 -0500
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
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinux_internal.h libselinux-1.33.3/src/selinux_internal.h
--- nsalibselinux/src/selinux_internal.h	2006-11-16 17:15:25.000000000 -0500
+++ libselinux-1.33.3/src/selinux_internal.h	2007-01-05 11:57:44.000000000 -0500
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
diff --exclude-from=exclude -N -u -r nsalibselinux/utils/selinux_check_securetty_context.c libselinux-1.33.3/utils/selinux_check_securetty_context.c
--- nsalibselinux/utils/selinux_check_securetty_context.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.33.3/utils/selinux_check_securetty_context.c	2007-01-05 11:57:44.000000000 -0500
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

--------------000604030809060202070904--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
