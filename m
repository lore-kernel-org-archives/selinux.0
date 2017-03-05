Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v25HDPOU026457
 for <selinux@tycho.nsa.gov>; Sun, 5 Mar 2017 12:13:28 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 579295613BA
 for <selinux@tycho.nsa.gov>; Sun,  5 Mar 2017 18:13:26 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/6] checkpolicy: add noreturn attribute to usage()
Date: Sun,  5 Mar 2017 18:13:01 +0100
Message-Id: <20170305171305.23170-2-nicolas.iooss@m4x.org>
In-Reply-To: <20170305171305.23170-1-nicolas.iooss@m4x.org>
References: <20170305171305.23170-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

While at it, make usage() static and mark its argument as const.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 checkpolicy/checkmodule.c | 2 +-
 checkpolicy/checkpolicy.c | 2 +-
 checkpolicy/test/dismod.c | 2 +-
 checkpolicy/test/dispol.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/checkpolicy/checkmodule.c b/checkpolicy/checkmodule.c
index 53cc5a04c9a4..46ce258fb832 100644
--- a/checkpolicy/checkmodule.c
+++ b/checkpolicy/checkmodule.c
@@ -124,7 +124,7 @@ static int write_binary_policy(policydb_t * p, FILE *outfp)
 	return policydb_write(p, &pf);
 }
 
-static void usage(char *progname)
+static __attribute__((__noreturn__)) void usage(const char *progname)
 {
 	printf("usage:  %s [-h] [-V] [-b] [-C] [-U handle_unknown] [-m] [-M] [-o FILE] [INPUT]\n", progname);
 	printf("Build base and policy modules.\n");
diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index c82f6f409271..b98bfcd1f169 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -102,7 +102,7 @@ static const char *binfile = "policy";
 
 unsigned int policyvers = POLICYDB_VERSION_MAX;
 
-void usage(char *progname)
+static __attribute__((__noreturn__)) void usage(const char *progname)
 {
 	printf
 	    ("usage:  %s [-b] [-C] [-d] [-U handle_unknown (allow,deny,reject)] [-M]"
diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index 08b039dc1de0..aac13e17fed3 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -65,7 +65,7 @@ static const char *symbol_labels[9] = {
 	"levels ", "cats   ", "attribs"
 };
 
-void usage(const char *progname)
+static __attribute__((__noreturn__)) void usage(const char *progname)
 {
 	printf("usage:  %s binary_pol_file\n\n", progname);
 	exit(1);
diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index d91fafdb0e1c..ee0f5f643482 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -36,7 +36,7 @@
 
 static policydb_t policydb;
 
-void usage(const char *progname)
+static __attribute__((__noreturn__)) void usage(const char *progname)
 {
 	printf("usage:  %s binary_pol_file\n\n", progname);
 	exit(1);
-- 
2.11.1
