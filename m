Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3O9ZAxg005805
 for <selinux@tycho.nsa.gov>; Sun, 24 Apr 2016 05:35:10 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] selinux: Build policy on systems not supporting DCCP protocol
Date: Sun, 24 Apr 2016 10:34:47 +0100
Message-Id: <1461490487-19829-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Commit 3895fbbe0cf2ec52d6b6eda66084b6e9f8d88fb2 ("selinux: Add support
for portcon dccp protocol") added support for the (portcon dccp ..)
statement. This fix will allow policy to be built on platforms
(see [1]) that do not have DCCP support by defining the IANA
assigned IP Protocol Number 33 to IPPROTO_DCCP.

[1] https://android-review.googlesource.com/#/c/219568/

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 checkpolicy/checkpolicy.c     | 3 +++
 checkpolicy/policy_define.c   | 3 +++
 libsepol/cil/src/cil_binary.c | 3 +++
 libsepol/src/module_to_cil.c  | 3 +++
 libsepol/src/ports.c          | 3 +++
 5 files changed, 15 insertions(+)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index ea9ee00..7947c20 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -64,6 +64,9 @@
 #include <sys/stat.h>
 #include <sys/socket.h>
 #include <netinet/in.h>
+#ifndef IPPROTO_DCCP
+#define IPPROTO_DCCP 33
+#endif
 #include <arpa/inet.h>
 #include <fcntl.h>
 #include <stdio.h>
diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 7a4d2f1..2068b71 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -36,6 +36,9 @@
 #include <string.h>
 #include <sys/socket.h>
 #include <netinet/in.h>
+#ifndef IPPROTO_DCCP
+#define IPPROTO_DCCP 33
+#endif
 #include <arpa/inet.h>
 #include <stdlib.h>
 #include <limits.h>
diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 8233dfd..b8437c9 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -31,6 +31,9 @@
 #include <stdio.h>
 #include <assert.h>
 #include <netinet/in.h>
+#ifndef IPPROTO_DCCP
+#define IPPROTO_DCCP 33
+#endif
 
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/polcaps.h>
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index b478d9f..38f0dc3 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -26,6 +26,9 @@
 #include <getopt.h>
 #include <libgen.h>
 #include <netinet/in.h>
+#ifndef IPPROTO_DCCP
+#define IPPROTO_DCCP 33
+#endif
 #include <signal.h>
 #include <stdarg.h>
 #include <stdio.h>
diff --git a/libsepol/src/ports.c b/libsepol/src/ports.c
index b1ee094..62ec602 100644
--- a/libsepol/src/ports.c
+++ b/libsepol/src/ports.c
@@ -1,4 +1,7 @@
 #include <netinet/in.h>
+#ifndef IPPROTO_DCCP
+#define IPPROTO_DCCP 33
+#endif
 #include <stdlib.h>
 
 #include "debug.h"
-- 
2.5.5
