Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v25HDPOX026457
 for <selinux@tycho.nsa.gov>; Sun, 5 Mar 2017 12:13:30 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 417395613BA
 for <selinux@tycho.nsa.gov>; Sun,  5 Mar 2017 18:13:28 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 5/6] semodule-utils: add noreturn attribute to usage()
Date: Sun,  5 Mar 2017 18:13:04 +0100
Message-Id: <20170305171305.23170-5-nicolas.iooss@m4x.org>
In-Reply-To: <20170305171305.23170-1-nicolas.iooss@m4x.org>
References: <20170305171305.23170-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 semodule-utils/semodule_deps/semodule_deps.c         | 2 +-
 semodule-utils/semodule_expand/semodule_expand.c     | 2 +-
 semodule-utils/semodule_link/semodule_link.c         | 2 +-
 semodule-utils/semodule_package/semodule_package.c   | 2 +-
 semodule-utils/semodule_package/semodule_unpackage.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/semodule-utils/semodule_deps/semodule_deps.c b/semodule-utils/semodule_deps/semodule_deps.c
index 8048ee02d3ca..7a7ff2fc9f80 100644
--- a/semodule-utils/semodule_deps/semodule_deps.c
+++ b/semodule-utils/semodule_deps/semodule_deps.c
@@ -42,7 +42,7 @@ extern int optind;
  */
 #define BASE_NAME ((char *)"BASE")
 
-static void usage(char *program_name)
+static __attribute__((__noreturn__)) void usage(const char *program_name)
 {
 	printf("usage: %s [-v -g -b] basemodpkg modpkg1 [modpkg2 ... ]\n",
 	       program_name);
diff --git a/semodule-utils/semodule_expand/semodule_expand.c b/semodule-utils/semodule_expand/semodule_expand.c
index aeb41b283de3..895cdd788ea2 100644
--- a/semodule-utils/semodule_expand/semodule_expand.c
+++ b/semodule-utils/semodule_expand/semodule_expand.c
@@ -28,7 +28,7 @@ int policyvers = 0;
 
 #define EXPANDPOLICY_VERSION "1.0"
 
-static void usage(char *program_name)
+static __attribute__((__noreturn__)) void usage(const char *program_name)
 {
 	printf("usage: %s [-V -a -c [version]] basemodpkg outputfile\n",
 	       program_name);
diff --git a/semodule-utils/semodule_link/semodule_link.c b/semodule-utils/semodule_link/semodule_link.c
index 1234735637e4..38a6843cd6ce 100644
--- a/semodule-utils/semodule_link/semodule_link.c
+++ b/semodule-utils/semodule_link/semodule_link.c
@@ -25,7 +25,7 @@ char *progname;
 extern char *optarg;
 extern int optind;
 
-static void usage(char *program_name)
+static __attribute__((__noreturn__)) void usage(const char *program_name)
 {
 	printf("usage: %s [-Vv] [-o outfile] basemodpkg modpkg1 [modpkg2]...\n",
 	       program_name);
diff --git a/semodule-utils/semodule_package/semodule_package.c b/semodule-utils/semodule_package/semodule_package.c
index a25daf59f9e7..3515234e36de 100644
--- a/semodule-utils/semodule_package/semodule_package.c
+++ b/semodule-utils/semodule_package/semodule_package.c
@@ -22,7 +22,7 @@
 char *progname = NULL;
 extern char *optarg;
 
-static void usage(const char *prog)
+static __attribute__((__noreturn__)) void usage(const char *prog)
 {
 	printf("usage: %s -o <output file> -m <module> [-f <file contexts>]\n",
 	       prog);
diff --git a/semodule-utils/semodule_package/semodule_unpackage.c b/semodule-utils/semodule_package/semodule_unpackage.c
index 5117b39e9ffe..c9124c0f5ac1 100644
--- a/semodule-utils/semodule_package/semodule_unpackage.c
+++ b/semodule-utils/semodule_package/semodule_unpackage.c
@@ -14,7 +14,7 @@
 char *progname = NULL;
 extern char *optarg;
 
-static void usage(void)
+static __attribute__((__noreturn__)) void usage(void)
 {
 	printf("usage: %s ppfile modfile [fcfile]\n", progname);
 	exit(1);
-- 
2.11.1
