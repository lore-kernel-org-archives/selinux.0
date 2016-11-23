Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uANMc93O032760
 for <selinux@tycho.nsa.gov>; Wed, 23 Nov 2016 17:38:09 -0500
Received: by mail-pg0-f45.google.com with SMTP id 3so10665079pgd.0
 for <selinux@tycho.nsa.gov>; Wed, 23 Nov 2016 14:38:08 -0800 (PST)
From: Nick Kralevich <nnk@google.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] enabled.c: Remove stdio_ext.h header
Date: Wed, 23 Nov 2016 14:37:58 -0800
Message-Id: <1479940678-8681-1-git-send-email-nnk@google.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This appears to be unused.

Signed-off-by: Nick Kralevich <nnk@google.com>
---
 libselinux/src/enabled.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/libselinux/src/enabled.c b/libselinux/src/enabled.c
index bb659a9..2ec6797 100644
--- a/libselinux/src/enabled.c
+++ b/libselinux/src/enabled.c
@@ -6,7 +6,6 @@
 #include <errno.h>
 #include <limits.h>
 #include <stdio.h>
-#include <stdio_ext.h>
 #include "policy.h"
 
 int is_selinux_enabled(void)
-- 
2.8.0.rc3.226.g39d4020
