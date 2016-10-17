From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: [PATCH 1/8] libsepol/cil: disable symver on Mac builds
Date: Mon, 17 Oct 2016 16:24:03 -0400
Message-Id: <1476735850-7844-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

symver does not work on Mac, so like Android, just
disable it.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libsepol/cil/src/dso.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/dso.h b/libsepol/cil/src/dso.h
index a06e349..64a162c 100644
--- a/libsepol/cil/src/dso.h
+++ b/libsepol/cil/src/dso.h
@@ -1,7 +1,7 @@
 #ifndef _SEPOL_DSO_H
 #define _SEPOL_DSO_H	1
 
-#if !defined(SHARED) || defined(ANDROID)
+#if !defined(SHARED) || defined(ANDROID) || defined(__APPLE__)
     #define DISABLE_SYMVER 1
 #endif
 
-- 
1.9.1
