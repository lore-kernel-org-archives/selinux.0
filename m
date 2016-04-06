Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u360LKgZ020287
 for <selinux@tycho.nsa.gov>; Tue, 5 Apr 2016 20:21:20 -0400
Received: by mail-pf0-f177.google.com with SMTP id n1so21093507pfn.2
 for <selinux@tycho.nsa.gov>; Tue, 05 Apr 2016 17:21:18 -0700 (PDT)
From: Nick Kralevich <nnk@google.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] cil_mem.c: #define _GNU_SOURCE
Date: Tue,  5 Apr 2016 17:21:14 -0700
Message-Id: <1459902074-127953-1-git-send-email-nnk@google.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fix the following compiler error:

  external/selinux/libsepol/cil/src/cil_mem.c:109:7: warning: implicit
  declaration of function 'vasprintf' is invalid in C99
  [-Wimplicit-function-declaration]
---
 libsepol/cil/src/cil_mem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsepol/cil/src/cil_mem.c b/libsepol/cil/src/cil_mem.c
index 12c59be..023e6bd 100644
--- a/libsepol/cil/src/cil_mem.c
+++ b/libsepol/cil/src/cil_mem.c
@@ -27,6 +27,7 @@
  * either expressed or implied, of Tresys Technology, LLC.
  */
 
+#define _GNU_SOURCE
 #include <stdlib.h>
 #include <stdio.h>
 #include <stdarg.h>
-- 
2.8.0.rc3.226.g39d4020
