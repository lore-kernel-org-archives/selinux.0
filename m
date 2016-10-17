From: william.c.roberts@intel.com
To: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: [PATCH 4/8] libselinux: fix required alignment for sha1.c on mac
Date: Mon, 17 Oct 2016 16:24:06 -0400
Message-Id: <1476735850-7844-4-git-send-email-william.c.roberts@intel.com>
In-Reply-To: <1476735850-7844-1-git-send-email-william.c.roberts@intel.com>
References: <1476735850-7844-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

When building on mac with ANDROID_HOST=y, clang complains:
sha1.c:73:33: error: cast from 'uint8_t *' (aka 'unsigned char *') to 'CHAR64LONG16 *' increases required alignment from 1 to 4 [-Werror,-Wcast-align]
    CHAR64LONG16*       block = (CHAR64LONG16*) workspace;

Rather then casting the bytearray to the CHAR64LONG16 union,
just create a stack workspace of type CHAR64LONG16.

This will prevent alignment issues with the data accesses.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/sha1.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/sha1.c b/libselinux/src/sha1.c
index 5f02af8..9bcbb6e 100644
--- a/libselinux/src/sha1.c
+++ b/libselinux/src/sha1.c
@@ -8,8 +8,14 @@
 //  Modified by WaterJuice retaining Public Domain license.
 //
 //  This is free and unencumbered software released into the public domain - June 2013 waterjuice.org
-//  Modified to stop symbols being exported for libselinux shared library - October 2015
+//  Modified to:
+//    - stop symbols being exported for libselinux shared library - October 2015
 //								       Richard Haines <richard_c_haines@btinternet.com>
+//    - Not cast the workspace from a byte array to a CHAR64LONG16 due to allignment isses.
+//      Fixes:
+//        sha1.c:73:33: error: cast from 'uint8_t *' (aka 'unsigned char *') to 'CHAR64LONG16 *' increases required alignment from 1 to 4 [-Werror,-Wcast-align]
+//             CHAR64LONG16*       block = (CHAR64LONG16*) workspace;
+//                                                                     William Roberts <william.c.roberts@intel.com>
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@@ -69,8 +75,8 @@ void
     uint32_t            c;
     uint32_t            d;
     uint32_t            e;
-    uint8_t             workspace[64];
-    CHAR64LONG16*       block = (CHAR64LONG16*) workspace;
+    CHAR64LONG16        workspace;
+    CHAR64LONG16*       block = &workspace;
 
     memcpy( block, buffer, 64 );
 
-- 
1.9.1
