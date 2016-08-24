Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7OCrP5Q021828
 for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2016 08:53:25 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/2] libselinux: Ignore restorecon_last in
 selinux_restorecon(3)
Date: Wed, 24 Aug 2016 13:53:10 +0100
Message-Id: <1472043190-28871-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Update selinux_restorecon(3) to allow the "security.restorecon_last"
extended attribute to be ignored.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libselinux/include/selinux/restorecon.h  |  4 ++++
 libselinux/man/man3/selinux_restorecon.3 | 20 +++++++++++++++++---
 libselinux/src/selinux_restorecon.c      |  9 ++++++++-
 libselinux/utils/selinux_restorecon.c    |  9 +++++++--
 4 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/libselinux/include/selinux/restorecon.h b/libselinux/include/selinux/restorecon.h
index e6db8f9..563ae94 100644
--- a/libselinux/include/selinux/restorecon.h
+++ b/libselinux/include/selinux/restorecon.h
@@ -91,6 +91,10 @@ extern int selinux_restorecon(const char *pathname,
  * mounts to be excluded from relabeling checks.
  */
 #define SELINUX_RESTORECON_IGNORE_MOUNTS		0x2000
+/*
+ * Do not check or update RESTORECON_LAST extended attribute.
+ */
+#define SELINUX_RESTORECON_IGNORE_XATTR			0x4000
 
 /**
  * selinux_restorecon_set_sehandle - Set the global fc handle.
diff --git a/libselinux/man/man3/selinux_restorecon.3 b/libselinux/man/man3/selinux_restorecon.3
index ad8acdc..0849faa 100644
--- a/libselinux/man/man3/selinux_restorecon.3
+++ b/libselinux/man/man3/selinux_restorecon.3
@@ -43,6 +43,8 @@ flag set. If any of the specfiles had been updated, the digest
 will also be updated. However if the digest is the same, no relabeling checks
 will take place (unless the
 .B SELINUX_RESTORECON_IGNORE_DIGEST
+or the
+.B SELINUX_RESTORECON_IGNORE_XATTR
 flag is set).
 .sp
 .IR restorecon_flags
@@ -58,6 +60,14 @@ extended attribute once relabeling has been completed successfully provided the
 .B SELINUX_RESTORECON_NOCHANGE
 flag has not been set.
 .sp
+.B SELINUX_RESTORECON_IGNORE_XATTR
+do not check or update any directory SHA1 digests. Use this option to
+effectively disable usage of the
+.IR security.restorecon_last
+extended attribute. Note that setting this flag will override the
+.B SELINUX_RESTORECON_IGNORE_DIGEST
+flag.
+.sp
 .B SELINUX_RESTORECON_NOCHANGE
 don't change any file labels (passive check) or update the digest in the
 .IR security.restorecon_last
@@ -214,10 +224,14 @@ relabeled depending on the settings of the
 .B SELINUX_RESTORECON_SET_SPECFILE_CTX
 flag (provided
 .B SELINUX_RESTORECON_NOCHANGE
-is not set).
+or the
+.B SELINUX_RESTORECON_IGNORE_XATTR
+are not set).
 .IP "5." 4
-.B /sys
-and in-memory filesystems do not support the
+.B RAMFS
+and
+.B TMPFS
+filesystems do not support the
 .IR security.restorecon_last
 extended attribute and are automatically excluded from any relabeling checks.
 .IP "6." 4
diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index d49fb15..1618a88 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -86,6 +86,7 @@ struct rest_flags {
 	bool syslog_changes;
 	bool log_matches;
 	bool ignore_noent;
+	bool ignore_xattr;
 };
 
 static void restorecon_init(void)
@@ -673,6 +674,8 @@ int selinux_restorecon(const char *pathname_orig,
 		   SELINUX_RESTORECON_LOG_MATCHES) ? true : false;
 	flags.ignore_noent = (restorecon_flags &
 		   SELINUX_RESTORECON_IGNORE_NOENTRY) ? true : false;
+	flags.ignore_xattr = (restorecon_flags &
+		   SELINUX_RESTORECON_IGNORE_XATTR) ? true : false;
 	ignore_mounts = (restorecon_flags &
 		   SELINUX_RESTORECON_IGNORE_MOUNTS) ? true : false;
 
@@ -698,7 +701,7 @@ int selinux_restorecon(const char *pathname_orig,
 	if (!fc_sehandle)
 		return -1;
 
-	if (fc_digest_len) {
+	if (fc_digest_len && !flags.ignore_xattr) {
 		xattr_value = malloc(fc_digest_len);
 		if (!xattr_value)
 			return -1;
@@ -777,6 +780,10 @@ int selinux_restorecon(const char *pathname_orig,
 			setrestoreconlast = false;
 	}
 
+	/* Ignore restoreconlast if told to do so */
+	if (flags.ignore_xattr)
+		setrestoreconlast = false;
+
 	if (setrestoreconlast) {
 		size = getxattr(pathname, RESTORECON_LAST, xattr_value,
 							    fc_digest_len);
diff --git a/libselinux/utils/selinux_restorecon.c b/libselinux/utils/selinux_restorecon.c
index 7aea81f..1bed0f1 100644
--- a/libselinux/utils/selinux_restorecon.c
+++ b/libselinux/utils/selinux_restorecon.c
@@ -37,7 +37,7 @@ static int validate_context(char **contextp)
 static void usage(const char *progname)
 {
 	fprintf(stderr,
-		"\nusage: %s [-FCnRrdmiIaAsl] [-e dir] [-v|-P]\n"
+		"\nusage: %s [-FCcnRrdmiIaAsl] [-e dir] [-v|-P]\n"
 		"[-x alt_rootpath] [-p policy] [-f specfile] pathname ...\n"
 		"\nWhere:\n\t"
 		"-F  Set the label to that in specfile.\n\t"
@@ -45,6 +45,7 @@ static void usage(const char *progname)
 		"label to that\n\t    in the specfile.\n\t"
 		"-C  Check labels even if the stored SHA1 digest matches\n\t"
 		"    the specfiles SHA1 digest.\n\t"
+		"-c  Do not check or update SHA1 digests.\n\t"
 		"-n  Don't change any file labels (passive check).\n\t"
 		"-R  Recursively change file and directory labels.\n\t"
 		"-v  Show changes in file labels (-v and -P are mutually "
@@ -127,7 +128,7 @@ int main(int argc, char **argv)
 	exclude_list = NULL;
 	exclude_count = 0;
 
-	while ((opt = getopt(argc, argv, "iIFCnRvPrdaAslme:f:p:x:")) > 0) {
+	while ((opt = getopt(argc, argv, "iIFCcnRvPrdaAslme:f:p:x:")) > 0) {
 		switch (opt) {
 		case 'F':
 			restorecon_flags |=
@@ -137,6 +138,10 @@ int main(int argc, char **argv)
 			restorecon_flags |=
 					SELINUX_RESTORECON_IGNORE_DIGEST;
 			break;
+		case 'c':
+			restorecon_flags |=
+					SELINUX_RESTORECON_IGNORE_XATTR;
+			break;
 		case 'n':
 			restorecon_flags |= SELINUX_RESTORECON_NOCHANGE;
 			break;
-- 
2.7.4
