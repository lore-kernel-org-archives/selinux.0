Message-ID: <45A3AE94.40300@redhat.com>
Date: Tue, 09 Jan 2007 10:02:44 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: libselinux patch to add securetty rewritten with getline and using
 Lindent
Content-Type: multipart/mixed;
 boundary="------------000701040708030500000604"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000701040708030500000604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------000701040708030500000604
Content-Type: text/x-patch;
 name="libselinux-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibselinux/include/selinux/selinux.h libselinux-1.33.3/include/selinux/selinux.h
--- nsalibselinux/include/selinux/selinux.h	2006-11-16 17:15:18.000000000 -0500
+++ libselinux-1.33.3/include/selinux/selinux.h	2007-01-09 09:49:51.000000000 -0500
@@ -406,6 +406,7 @@
 	extern const char *selinux_homedir_context_path(void);
 	extern const char *selinux_media_context_path(void);
 	extern const char *selinux_contexts_path(void);
+	extern const char *selinux_securetty_context_path(void);
 	extern const char *selinux_booleans_path(void);
 	extern const char *selinux_customizable_types_path(void);
 	extern const char *selinux_users_path(void);
@@ -413,12 +414,15 @@
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
+	extern int selinux_check_securetty_context(security_context_t
+						   tty_context);
 /* Set the path to the selinuxfs mount point explicitly.
    Normally, this is determined automatically during libselinux 
    initialization, but this is not always possible, e.g. for /sbin/init
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/selinux_binary_policy_path.3 libselinux-1.33.3/man/man3/selinux_binary_policy_path.3
--- nsalibselinux/man/man3/selinux_binary_policy_path.3	2006-11-16 17:15:30.000000000 -0500
+++ libselinux-1.33.3/man/man3/selinux_binary_policy_path.3	2007-01-09 09:49:51.000000000 -0500
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
+++ libselinux-1.33.3/man/man3/selinux_check_securetty_context.3	2007-01-09 09:49:51.000000000 -0500
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
+++ libselinux-1.33.3/man/man3/selinux_securetty_context_path.3	2007-01-09 09:49:51.000000000 -0500
@@ -0,0 +1 @@
+.so man3/selinux_binary_policy_path.3
diff --exclude-from=exclude -N -u -r nsalibselinux/src/file_path_suffixes.h libselinux-1.33.3/src/file_path_suffixes.h
--- nsalibselinux/src/file_path_suffixes.h	2006-11-16 17:15:25.000000000 -0500
+++ libselinux-1.33.3/src/file_path_suffixes.h	2007-01-09 09:49:51.000000000 -0500
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
+++ libselinux-1.33.3/src/selinux_check_securetty_context.c	2007-01-09 10:00:58.000000000 -0500
@@ -0,0 +1,54 @@
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
+	char *line = NULL;
+	char *start, *end = NULL;
+	size_t line_len = 0;
+	size_t len;
+	int found = -1;
+	FILE *fp;
+	fp = fopen(selinux_securetty_context_path(), "r");
+	if (fp) {
+		context_t con = context_new(tty_context);
+		if (con) {
+			const char *type = context_type_get(con);
+			found = 0;
+			while ((len = getline(&line, &line_len, fp)) != -1) {
+
+				if (line[len - 1] == '\n')
+					line[len - 1] = 0;
+
+				/* Skip leading whitespace. */
+				start = line;
+				while (*start && isspace(*start))
+					start++;
+				if (!(*start))
+					continue;
+
+				end = start;
+				while (*end && !isspace(*end))
+					end++;
+				if (*end)
+					*end++ = 0;
+				if (!strcmp(type, start)) {
+					found = 1;
+					break;
+				}
+			}
+			free(line);
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
+++ libselinux-1.33.3/src/selinux_config.c	2007-01-09 09:49:51.000000000 -0500
@@ -38,7 +38,8 @@
 #define NETFILTER_CONTEXTS    15
 #define FILE_CONTEXTS_HOMEDIR 16
 #define FILE_CONTEXTS_LOCAL 17
-#define NEL               18
+#define SECURETTY_CONTEXTS  18
+#define NEL               19
 
 /* New layout is relative to SELINUXDIR/policytype. */
 static char *file_paths[NEL];
@@ -299,6 +300,13 @@
 
 hidden_def(selinux_default_context_path)
 
+const char *selinux_securetty_context_path()
+{
+	return get_path(SECURETTY_CONTEXTS);
+}
+
+hidden_def(selinux_securetty_context_path)
+
 const char *selinux_failsafe_context_path()
 {
 	return get_path(FAILSAFE_CONTEXT);
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinux_internal.h libselinux-1.33.3/src/selinux_internal.h
--- nsalibselinux/src/selinux_internal.h	2006-11-16 17:15:25.000000000 -0500
+++ libselinux-1.33.3/src/selinux_internal.h	2007-01-09 09:49:51.000000000 -0500
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
diff --exclude-from=exclude -N -u -r nsalibselinux/utils/matchpathcon.c libselinux-1.33.3/utils/matchpathcon.c
--- nsalibselinux/utils/matchpathcon.c	2007-01-04 17:01:41.000000000 -0500
+++ libselinux-1.33.3/utils/matchpathcon.c	2007-01-09 09:49:51.000000000 -0500
@@ -95,7 +95,7 @@
 		}
 	}
 	for (i = optind; i < argc; i++) {
-		int mode=0;
+		int mode = 0;
 		struct stat buf;
 		if (lstat(argv[i], &buf) == 0)
 			mode = buf.st_mode;
@@ -114,13 +114,15 @@
 				if (rc >= 0) {
 					printf("%s has context %s, should be ",
 					       argv[i], con);
-					error += printmatchpathcon(argv[i], 0, mode);
+					error +=
+					    printmatchpathcon(argv[i], 0, mode);
 					freecon(con);
 				} else {
 					printf
 					    ("actual context unknown: %s, should be ",
 					     strerror(errno));
-					error += printmatchpathcon(argv[i], 0,mode);
+					error +=
+					    printmatchpathcon(argv[i], 0, mode);
 				}
 			}
 		} else {
diff --exclude-from=exclude -N -u -r nsalibselinux/utils/selinux_check_securetty_context.c libselinux-1.33.3/utils/selinux_check_securetty_context.c
--- nsalibselinux/utils/selinux_check_securetty_context.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.33.3/utils/selinux_check_securetty_context.c	2007-01-09 09:49:51.000000000 -0500
@@ -0,0 +1,38 @@
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
+	fprintf(stderr, "usage:  %s tty_context...\n", progname);
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

--------------000701040708030500000604--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
