Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v08Il3OD026566
 for <selinux@tycho.nsa.gov>; Sun, 8 Jan 2017 13:47:06 -0500
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id D1E8F56467C
 for <selinux@tycho.nsa.gov>; Sun,  8 Jan 2017 19:46:40 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/3] checkpolicy: always include ctypes.h
Date: Sun,  8 Jan 2017 19:45:52 +0100
Message-Id: <20170108184553.31842-2-nicolas.iooss@m4x.org>
In-Reply-To: <20170108184553.31842-1-nicolas.iooss@m4x.org>
References: <20170108184553.31842-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The prototype of isdigit() is provided by ctypes.h header. Without
including this file, gcc fails to build checkpolicy using musl libc:

    checkpolicy.c: In function ‘main’:
    checkpolicy.c:705:8: error: implicit declaration of function
    ‘isdigit’ [-Werror=implicit-function-declaration]
        if (isdigit(ans[0])) {
            ^~~~~~~

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 checkpolicy/checkpolicy.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index 2d68316dc07b..c82f6f409271 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -57,6 +57,7 @@
  * booleans or conditional rules are thrown away a warning is printed.
  */
 
+#include <ctype.h>
 #include <getopt.h>
 #include <unistd.h>
 #include <stdlib.h>
@@ -73,10 +74,6 @@
 #include <errno.h>
 #include <sys/mman.h>
 
-#ifdef __APPLE__
-#include <ctype.h>
-#endif
-
 #include <sepol/module_to_cil.h>
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/services.h>
-- 
2.11.0
