From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: [PATCH] libselinux: drop unused stdio_ext.h header file
Date: Sat, 24 Sep 2016 10:10:05 -0700
Message-Id: <1474737005-1907-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

Nothing was being used from the stdio_ext.h header file, so
remove it. Additionally, Mac builds, required for the
Android build, do not have this header.

Change-Id: Ic61c87fcda79ffebeef93a20a2b3802f048bb0b0
Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/label_file.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 7156825..8ff1170 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -10,7 +10,6 @@
 #include <stdarg.h>
 #include <string.h>
 #include <stdio.h>
-#include <stdio_ext.h>
 #include <ctype.h>
 #include <errno.h>
 #include <limits.h>
-- 
1.9.1
