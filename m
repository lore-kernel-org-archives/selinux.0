Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v25HDPOY026457
 for <selinux@tycho.nsa.gov>; Sun, 5 Mar 2017 12:13:30 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id C311E5613BA
 for <selinux@tycho.nsa.gov>; Sun,  5 Mar 2017 18:13:28 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 6/6] policycoreutils: add noreturn attribute to usage()
Date: Sun,  5 Mar 2017 18:13:05 +0100
Message-Id: <20170305171305.23170-6-nicolas.iooss@m4x.org>
In-Reply-To: <20170305171305.23170-1-nicolas.iooss@m4x.org>
References: <20170305171305.23170-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 policycoreutils/hll/pp/pp.c                 | 2 +-
 policycoreutils/load_policy/load_policy.c   | 2 +-
 policycoreutils/secon/secon.c               | 2 +-
 policycoreutils/setfiles/restorecon_xattr.c | 2 +-
 policycoreutils/setfiles/setfiles.c         | 2 +-
 policycoreutils/setsebool/setsebool.c       | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/policycoreutils/hll/pp/pp.c b/policycoreutils/hll/pp/pp.c
index e4fa4c4b467c..b97a9b34816a 100644
--- a/policycoreutils/hll/pp/pp.c
+++ b/policycoreutils/hll/pp/pp.c
@@ -46,7 +46,7 @@ static void log_err(const char *fmt, ...)
 	}
 }
 
-static void usage(int err)
+static __attribute__((__noreturn__)) void usage(int err)
 {
 	fprintf(stderr, "Usage: %s [OPTIONS] [IN_FILE [OUT_FILE]]\n", progname);
 	fprintf(stderr, "\n");
diff --git a/policycoreutils/load_policy/load_policy.c b/policycoreutils/load_policy/load_policy.c
index 47d9b0f6ac3e..7c2c2a7836d8 100644
--- a/policycoreutils/load_policy/load_policy.c
+++ b/policycoreutils/load_policy/load_policy.c
@@ -17,7 +17,7 @@
 #define PACKAGE "policycoreutils"	/* the name of this package lang translation */
 #endif
 
-void usage(char *progname)
+static __attribute__((__noreturn__)) void usage(const char *progname)
 {
 	fprintf(stderr, _("usage:  %s [-qi]\n"), progname);
 	exit(1);
diff --git a/policycoreutils/secon/secon.c b/policycoreutils/secon/secon.c
index 134f4ee30722..c29d9fb67fa5 100644
--- a/policycoreutils/secon/secon.c
+++ b/policycoreutils/secon/secon.c
@@ -73,7 +73,7 @@ struct {
 		FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,
 		    FALSE, FALSE, FALSE, OPTS_FROM_ARG, {0} } };
 
-static void usage(const char *name, int exit_code)
+static __attribute__((__noreturn__)) void usage(const char *name, int exit_code)
 {
 	fprintf(exit_code ? stderr : stdout,
 		"  Usage: %s [-%s] [ context | - ]\n"
diff --git a/policycoreutils/setfiles/restorecon_xattr.c b/policycoreutils/setfiles/restorecon_xattr.c
index 1c39efe04e95..91c087faee93 100644
--- a/policycoreutils/setfiles/restorecon_xattr.c
+++ b/policycoreutils/setfiles/restorecon_xattr.c
@@ -14,7 +14,7 @@
 
 #include "restore.h"
 
-static void usage(const char *progname)
+static __attribute__((__noreturn__)) void usage(const char *progname)
 {
 	fprintf(stderr,
 		"\nusage: %s [-vnrmdD] [-e directory] [-f specfile] pathname\n"
diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index e3df212555a3..6f69c90c6734 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -39,7 +39,7 @@ static int iamrestorecon;
 static int ctx_validate; /* Validate contexts */
 static const char *altpath; /* Alternate path to file_contexts */
 
-void usage(const char *const name)
+static __attribute__((__noreturn__)) void usage(const char *const name)
 {
 	if (iamrestorecon) {
 		fprintf(stderr,
diff --git a/policycoreutils/setsebool/setsebool.c b/policycoreutils/setsebool/setsebool.c
index b101f0871c1d..53d3566cffbd 100644
--- a/policycoreutils/setsebool/setsebool.c
+++ b/policycoreutils/setsebool/setsebool.c
@@ -23,7 +23,7 @@ int verbose = 0;
 
 int setbool(char **list, size_t start, size_t end);
 
-void usage(void)
+static __attribute__((__noreturn__)) void usage(void)
 {
 	fputs
 	    ("\nUsage:  setsebool [ -NPV ] boolean value | bool1=val1 bool2=val2...\n\n",
-- 
2.11.1
