Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v25HDPOV026457
 for <selinux@tycho.nsa.gov>; Sun, 5 Mar 2017 12:13:29 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 25E505613BA
 for <selinux@tycho.nsa.gov>; Sun,  5 Mar 2017 18:13:27 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/6] secilc: add noreturn attribute to usage()
Date: Sun,  5 Mar 2017 18:13:02 +0100
Message-Id: <20170305171305.23170-3-nicolas.iooss@m4x.org>
In-Reply-To: <20170305171305.23170-1-nicolas.iooss@m4x.org>
References: <20170305171305.23170-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

While at it, make usage() static and mark its argument as const.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 secilc/secil2conf.c | 2 +-
 secilc/secilc.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/secilc/secil2conf.c b/secilc/secil2conf.c
index ff564f08ab8a..5d8fe870394d 100644
--- a/secilc/secil2conf.c
+++ b/secilc/secil2conf.c
@@ -41,7 +41,7 @@
 #endif
 #include <sepol/policydb.h>
 
-void usage(char *prog)
+static __attribute__((__noreturn__)) void usage(const char *prog)
 {
 	printf("Usage: %s [OPTION]... FILE...\n", prog);
 	printf("\n");
diff --git a/secilc/secilc.c b/secilc/secilc.c
index dad1e904eb61..f4ecbeec73fb 100644
--- a/secilc/secilc.c
+++ b/secilc/secilc.c
@@ -41,7 +41,7 @@
 #endif
 #include <sepol/policydb.h>
 
-void usage(char *prog)
+static __attribute__((__noreturn__)) void usage(const char *prog)
 {
 	printf("Usage: %s [OPTION]... FILE...\n", prog);
 	printf("\n");
-- 
2.11.1
