Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8U3IZlI025766
 for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2016 23:18:35 -0400
Received: by mail-pa0-f45.google.com with SMTP id dw4so20100921pac.1
 for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2016 20:18:01 -0700 (PDT)
From: Bowgo Tsai <bowgotsai@google.com>
To: selinux@tycho.nsa.gov
Cc: bowgotsai <bowgotsai@google.com>
Subject: [PATCH] secilc: correct include path of cil.h for Android
Date: Fri, 30 Sep 2016 11:17:55 +0800
Message-Id: <1475205475-146225-1-git-send-email-bowgotsai@google.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: bowgotsai <bowgotsai@google.com>

The original CL in AOSP tree:
  https://android-review.googlesource.com/#/c/274894

BUG=31366888
---
 secilc/secilc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/secilc/secilc.c b/secilc/secilc.c
index e98abe2..dad1e90 100644
--- a/secilc/secilc.c
+++ b/secilc/secilc.c
@@ -35,7 +35,7 @@
 #include <sys/stat.h>
 
 #ifdef ANDROID
-#include <sepol/cil.h>
+#include <cil/cil.h>
 #else
 #include <sepol/cil/cil.h>
 #endif
-- 
2.8.0.rc3.226.g39d4020
