From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: [PATCH 7/8] libselinux: DISABLE_BOOL move to include headers
Date: Mon, 17 Oct 2016 16:24:09 -0400
Message-Id: <1476735850-7844-7-git-send-email-william.c.roberts@intel.com>
In-Reply-To: <1476735850-7844-1-git-send-email-william.c.roberts@intel.com>
References: <1476735850-7844-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

Some systems, like Mac, don't have stdio_ext.h. Since we're
building with DISABLE_BOOL=y on Mac, just include the
header files with the DISABLE define, and use the bare
minimum headers for DISABLE_BOOL=y.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/booleans.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
index cbb0610..ba9d934 100644
--- a/libselinux/src/booleans.c
+++ b/libselinux/src/booleans.c
@@ -5,6 +5,8 @@
  *   Dan Walsh <dwalsh@redhat.com> - Added security_load_booleans().
  */
 
+#ifndef DISABLE_BOOL
+
 #include <assert.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -25,8 +27,6 @@
 
 #define SELINUX_BOOL_DIR "/booleans/"
 
-#ifndef DISABLE_BOOL
-
 static int filename_select(const struct dirent *d)
 {
 	if (d->d_name[0] == '.'
@@ -561,6 +561,10 @@ int security_load_booleans(char *path)
 }
 
 #else
+
+#include <stdlib.h>
+#include "selinux_internal.h"
+
 int security_set_boolean_list(size_t boolcnt __attribute__((unused)),
 	SELboolean * boollist __attribute__((unused)),
 	int permanent __attribute__((unused)))
-- 
1.9.1
