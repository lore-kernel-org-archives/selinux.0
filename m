Message-ID: <459BF0D8.60908@redhat.com>
Date: Wed, 03 Jan 2007 13:07:20 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Patch for libselinux
Content-Type: multipart/mixed;
 boundary="------------020305030102020907070104"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020305030102020907070104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fix for matchpatchon utility to lstat file if it exists to get correct 
filecontext.

--------------020305030102020907070104
Content-Type: text/x-patch;
 name="libselinux-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-rhat.patch"

Binary files nsalibselinux/utils/matchpathcon and libselinux-1.33.2/utils/matchpathcon differ
diff --exclude-from=exclude -N -u -r nsalibselinux/utils/matchpathcon.c libselinux-1.33.2/utils/matchpathcon.c
--- nsalibselinux/utils/matchpathcon.c	2006-11-16 17:15:17.000000000 -0500
+++ libselinux-1.33.2/utils/matchpathcon.c	2006-12-06 14:11:29.000000000 -0500
@@ -4,20 +4,23 @@
 #include <getopt.h>
 #include <errno.h>
 #include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/errno.h>
 #include <selinux/selinux.h>
 
 void usage(const char *progname)
 {
 	fprintf(stderr,
-		"usage:  %s [-n] [-f file_contexts] [-p prefix] path...\n",
+		"usage:  %s [-N] [-n] [-f file_contexts] [-p prefix] [-V] path...\n",
 		progname);
 	exit(1);
 }
 
-int printmatchpathcon(char *path, int header)
+int printmatchpathcon(char *path, int header, int mode)
 {
 	char *buf;
-	int rc = matchpathcon(path, 0, &buf);
+	int rc = matchpathcon(path, mode, &buf);
 	if (rc < 0) {
 		fprintf(stderr, "matchpathcon(%s) failed: %s\n", path,
 			strerror(errno));
@@ -92,6 +95,11 @@
 		}
 	}
 	for (i = optind; i < argc; i++) {
+		int mode=0;
+		struct stat buf;
+		if (lstat(argv[i], &buf) == 0)
+			mode = buf.st_mode;
+
 		if (verify) {
 			if (selinux_file_context_verify(argv[i], 0)) {
 				printf("%s verified.\n", argv[i]);
@@ -106,17 +114,17 @@
 				if (rc >= 0) {
 					printf("%s has context %s, should be ",
 					       argv[i], con);
-					error += printmatchpathcon(argv[i], 0);
+					error += printmatchpathcon(argv[i], 0, mode);
 					freecon(con);
 				} else {
 					printf
 					    ("actual context unknown: %s, should be ",
 					     strerror(errno));
-					error += printmatchpathcon(argv[i], 0);
+					error += printmatchpathcon(argv[i], 0,mode);
 				}
 			}
 		} else {
-			error += printmatchpathcon(argv[i], header);
+			error += printmatchpathcon(argv[i], header, mode);
 		}
 	}
 	matchpathcon_fini();

--------------020305030102020907070104--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
