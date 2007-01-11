Message-ID: <45A68F43.3050101@redhat.com>
Date: Thu, 11 Jan 2007 14:25:55 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: New test program for libselinux/utils that helped with testing MLS/Role/Level
 coding
Content-Type: multipart/mixed;
 boundary="------------070005080105090309080701"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070005080105090309080701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

getdefaultcon.c

--------------070005080105090309080701
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsalibselinux/utils/getdefaultcon.c libselinux-1.33.4/utils/getdefaultcon.c
--- nsalibselinux/utils/getdefaultcon.c	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.33.4/utils/getdefaultcon.c	2007-01-11 14:24:24.000000000 -0500
@@ -0,0 +1,75 @@
+#include <unistd.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <string.h>
+#include <ctype.h>
+#include <selinux/selinux.h>
+#include <selinux/get_context_list.h>
+
+void usage(char *name, char *detail, int rc)
+{
+	fprintf(stderr, "usage:  %s [-l level] user fromcon\n", name);
+	if (detail)
+		fprintf(stderr, "%s:  %s\n", name, detail);
+	exit(rc);
+}
+
+int main(int argc, char **argv)
+{
+	security_context_t usercon = NULL, cur_context = NULL;
+	char *user = NULL, *level = NULL, *role=NULL, *seuser=NULL;
+	int ret, opt;
+
+	while ((opt = getopt(argc, argv, "l:r:")) > 0) {
+		switch (opt) {
+		case 'l':
+			level = strdup(optarg);
+			break;
+		case 'r':
+			role = strdup(optarg);
+			break;
+		default:
+			usage(argv[0], "invalid option", 1);
+		}
+	}
+
+	if (((argc - optind) < 1) || ((argc - optind) > 2))
+		usage(argv[0], "invalid number of arguments", 2);
+
+	/* If selinux isn't available, bail out. */
+	if (!is_selinux_enabled()) {
+		fprintf(stderr,
+			"%s may be used only on a SELinux kernel.\n", argv[0]);
+		return 1;
+	}
+
+	user = argv[optind];
+
+	/* If a context wasn't passed, use the current context. */
+	if (((argc - optind) < 2)) {
+		if (getcon(&cur_context) < 0) {
+			fprintf(stderr, "Couldn't get current context.\n");
+			return 2;
+		}
+	} else
+		cur_context = argv[optind + 1];
+
+	if (getseuserbyname(user, &seuser, &level)==0) {
+		if (role != NULL && role[0]) 
+			ret=get_default_context_with_rolelevel(seuser, role, level,cur_context,&usercon);
+		else
+			ret=get_default_context_with_level(seuser, level, cur_context,&usercon);
+	}
+	if (ret < 0)
+		perror(argv[0]);
+	else
+		printf("%s: %s from %s %s %s %s -> %s\n", argv[0], user, cur_context, seuser, role, level, usercon);
+
+
+	free(usercon);
+
+	return 0;
+}

--------------070005080105090309080701--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
