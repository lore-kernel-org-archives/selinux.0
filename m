From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: [PATCH 3/8] libselinux: fix mac build warning when ANDROID_HOST=y
Date: Mon, 17 Oct 2016 16:24:05 -0400
Message-Id: <1476735850-7844-3-git-send-email-william.c.roberts@intel.com>
In-Reply-To: <1476735850-7844-1-git-send-email-william.c.roberts@intel.com>
References: <1476735850-7844-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

When building on Mac, outside of the Android tree, with ANDROID_HOST=y, this warning
is observed:

label.c:102:9: warning: implicit declaration of function 'fgets_unlocked' is invalid in C99 [-Wimplicit-function-declaration]
        while (fgets_unlocked(buf, sizeof(buf) - 1, cfg)) {

Fix it by using the fgets_unlocked define that was introduced for Android, just apply it for mac builds
as well.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/label_internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index 6a9481a..3d7ff74 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -16,8 +16,8 @@
 #include "dso.h"
 #include "sha1.h"
 
-#ifdef ANDROID
-// Android does not have fgets_unlocked()
+#if defined(ANDROID) || defined(__APPLE__)
+// Android and Mac do not have fgets_unlocked()
 #define fgets_unlocked(buf, size, fp) fgets(buf, size, fp)
 #endif
 
-- 
1.9.1
