From: william.c.roberts@intel.com
To: nicolas.iooss@m4x.org, selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, William Roberts <william.c.roberts@intel.com>
Subject: [PATCH] libselinux/utils: fix all the noreturn errors
Date: Tue,  1 Nov 2016 14:23:10 -0700
Message-Id: <1478035390-24547-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

When building with clang, multiple noreturn issues arise,
for instance:

selabel_partial_match.c:11:1: error: function 'usage' could be declared with attribute 'noreturn' [-Werror,-Wmissing-noreturn]

Fix these.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/utils/avcstat.c                         | 2 +-
 libselinux/utils/getconlist.c                      | 2 +-
 libselinux/utils/getdefaultcon.c                   | 2 +-
 libselinux/utils/getsebool.c                       | 2 +-
 libselinux/utils/matchpathcon.c                    | 2 +-
 libselinux/utils/selabel_digest.c                  | 2 +-
 libselinux/utils/selabel_lookup.c                  | 2 +-
 libselinux/utils/selabel_lookup_best_match.c       | 2 +-
 libselinux/utils/selabel_partial_match.c           | 2 +-
 libselinux/utils/selinux_check_securetty_context.c | 2 +-
 libselinux/utils/selinux_restorecon.c              | 2 +-
 libselinux/utils/selinuxexeccon.c                  | 2 +-
 libselinux/utils/setenforce.c                      | 2 +-
 libselinux/utils/togglesebool.c                    | 2 +-
 14 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/libselinux/utils/avcstat.c b/libselinux/utils/avcstat.c
index 1d4d5c8..70b3109 100644
--- a/libselinux/utils/avcstat.c
+++ b/libselinux/utils/avcstat.c
@@ -43,7 +43,7 @@ static char buf[DEF_BUF_SIZE];
 /* selinuxfs mount point */
 extern char *selinux_mnt;
 
-static __attribute__((__format__(printf,1,2))) void die(const char *msg, ...)
+static __attribute__((__format__(printf,1,2),__noreturn__)) void die(const char *msg, ...)
 {
 	va_list args;
 
diff --git a/libselinux/utils/getconlist.c b/libselinux/utils/getconlist.c
index 872ce05..adec178 100644
--- a/libselinux/utils/getconlist.c
+++ b/libselinux/utils/getconlist.c
@@ -9,7 +9,7 @@
 #include <selinux/selinux.h>
 #include <selinux/get_context_list.h>
 
-static void usage(const char *name, const char *detail, int rc)
+static __attribute__ ((__noreturn__)) void usage(const char *name, const char *detail, int rc)
 {
 	fprintf(stderr, "usage:  %s [-l level] user [context]\n", name);
 	if (detail)
diff --git a/libselinux/utils/getdefaultcon.c b/libselinux/utils/getdefaultcon.c
index c6f7151..96a5a8c 100644
--- a/libselinux/utils/getdefaultcon.c
+++ b/libselinux/utils/getdefaultcon.c
@@ -9,7 +9,7 @@
 #include <selinux/selinux.h>
 #include <selinux/get_context_list.h>
 
-static void usage(const char *name, const char *detail, int rc)
+static __attribute__ ((__noreturn__)) void usage(const char *name, const char *detail, int rc)
 {
 	fprintf(stderr, "usage:  %s [-l level] [-s service] user [fromcon]\n", name);
 	if (detail)
diff --git a/libselinux/utils/getsebool.c b/libselinux/utils/getsebool.c
index 9ae9243..3c6eba5 100644
--- a/libselinux/utils/getsebool.c
+++ b/libselinux/utils/getsebool.c
@@ -6,7 +6,7 @@
 #include <string.h>
 #include <selinux/selinux.h>
 
-static void usage(const char *progname)
+static __attribute__ ((__noreturn__)) void usage(const char *progname)
 {
 	fprintf(stderr, "usage:  %s -a or %s boolean...\n", progname, progname);
 	exit(1);
diff --git a/libselinux/utils/matchpathcon.c b/libselinux/utils/matchpathcon.c
index d1f1348..fca8ee2 100644
--- a/libselinux/utils/matchpathcon.c
+++ b/libselinux/utils/matchpathcon.c
@@ -12,7 +12,7 @@
 #include <limits.h>
 #include <stdlib.h>
 
-static void usage(const char *progname)
+static __attribute__ ((__noreturn__)) void usage(const char *progname)
 {
 	fprintf(stderr,
 		"usage:  %s [-N] [-n] [-f file_contexts] [ -P policy_root_path ] [-p prefix] [-Vq] path...\n",
diff --git a/libselinux/utils/selabel_digest.c b/libselinux/utils/selabel_digest.c
index e4d84a5..49408a0 100644
--- a/libselinux/utils/selabel_digest.c
+++ b/libselinux/utils/selabel_digest.c
@@ -8,7 +8,7 @@
 
 static size_t digest_len;
 
-static void usage(const char *progname)
+static __attribute__ ((__noreturn__)) void usage(const char *progname)
 {
 	fprintf(stderr,
 		"usage: %s -b backend [-d] [-v] [-B] [-i] [-f file]\n\n"
diff --git a/libselinux/utils/selabel_lookup.c b/libselinux/utils/selabel_lookup.c
index b678a89..1aef64d 100644
--- a/libselinux/utils/selabel_lookup.c
+++ b/libselinux/utils/selabel_lookup.c
@@ -6,7 +6,7 @@
 #include <selinux/selinux.h>
 #include <selinux/label.h>
 
-static void usage(const char *progname)
+static __attribute__ ((__noreturn__)) void usage(const char *progname)
 {
 	fprintf(stderr,
 		"usage: %s -b backend [-v] [-r] -k key [-t type] [-f file]\n\n"
diff --git a/libselinux/utils/selabel_lookup_best_match.c b/libselinux/utils/selabel_lookup_best_match.c
index d74382f..6a71742 100644
--- a/libselinux/utils/selabel_lookup_best_match.c
+++ b/libselinux/utils/selabel_lookup_best_match.c
@@ -7,7 +7,7 @@
 #include <selinux/selinux.h>
 #include <selinux/label.h>
 
-static void usage(const char *progname)
+static __attribute__ ((__noreturn__)) void usage(const char *progname)
 {
 	fprintf(stderr,
 		"usage: %s [-v] [-r] -p path [-m mode] [-f file] [link...]\n\n"
diff --git a/libselinux/utils/selabel_partial_match.c b/libselinux/utils/selabel_partial_match.c
index 017702d..c5932cb 100644
--- a/libselinux/utils/selabel_partial_match.c
+++ b/libselinux/utils/selabel_partial_match.c
@@ -7,7 +7,7 @@
 #include <selinux/selinux.h>
 #include <selinux/label.h>
 
-static void usage(const char *progname)
+static __attribute__ ((__noreturn__)) void usage(const char *progname)
 {
 	fprintf(stderr,
 		"usage:  %s [-v] -p <path> [-f file]\n\n"
diff --git a/libselinux/utils/selinux_check_securetty_context.c b/libselinux/utils/selinux_check_securetty_context.c
index b158eb3..84f5907 100644
--- a/libselinux/utils/selinux_check_securetty_context.c
+++ b/libselinux/utils/selinux_check_securetty_context.c
@@ -9,7 +9,7 @@
 #include <sys/errno.h>
 #include <selinux/selinux.h>
 
-static void usage(const char *progname)
+static __attribute__ ((__noreturn__)) void usage(const char *progname)
 {
 	fprintf(stderr, "usage:  %s tty_context...\n", progname);
 	exit(1);
diff --git a/libselinux/utils/selinux_restorecon.c b/libselinux/utils/selinux_restorecon.c
index 7aea81f..4d2b08f 100644
--- a/libselinux/utils/selinux_restorecon.c
+++ b/libselinux/utils/selinux_restorecon.c
@@ -34,7 +34,7 @@ static int validate_context(char **contextp)
 	return 0;
 }
 
-static void usage(const char *progname)
+static __attribute__ ((__noreturn__)) void usage(const char *progname)
 {
 	fprintf(stderr,
 		"\nusage: %s [-FCnRrdmiIaAsl] [-e dir] [-v|-P]\n"
diff --git a/libselinux/utils/selinuxexeccon.c b/libselinux/utils/selinuxexeccon.c
index e0212e4..b50e788 100644
--- a/libselinux/utils/selinuxexeccon.c
+++ b/libselinux/utils/selinuxexeccon.c
@@ -8,7 +8,7 @@
 #include <ctype.h>
 #include <selinux/selinux.h>
 
-static void usage(const char *name, const char *detail, int rc)
+static __attribute__ ((__noreturn__)) void usage(const char *name, const char *detail, int rc)
 {
 	fprintf(stderr, "usage:  %s command [ fromcon ]\n", name);
 	if (detail)
diff --git a/libselinux/utils/setenforce.c b/libselinux/utils/setenforce.c
index df58597..60a20a4 100644
--- a/libselinux/utils/setenforce.c
+++ b/libselinux/utils/setenforce.c
@@ -6,7 +6,7 @@
 #include <strings.h>
 #include <selinux/selinux.h>
 
-static void usage(const char *progname)
+static __attribute__ ((__noreturn__)) void usage(const char *progname)
 {
 	fprintf(stderr, "usage:  %s [ Enforcing | Permissive | 1 | 0 ]\n",
 		progname);
diff --git a/libselinux/utils/togglesebool.c b/libselinux/utils/togglesebool.c
index 309f83b..4a7c830 100644
--- a/libselinux/utils/togglesebool.c
+++ b/libselinux/utils/togglesebool.c
@@ -10,7 +10,7 @@
 
 /* Attempt to rollback the transaction. No need to check error
    codes since this is rolling back something that blew up. */
-static void rollback(int argc, char **argv)
+static __attribute__ ((__noreturn__)) void rollback(int argc, char **argv)
 {
 	int i;
 
-- 
2.7.4
