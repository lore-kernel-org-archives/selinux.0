Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0P9iZkN025399
 for <selinux@tycho.nsa.gov>; Wed, 25 Jan 2017 04:44:36 -0500
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: selinux@tycho.nsa.gov
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH] libselinux/src/regex.c: support old compilers for the endian
 check
Date: Wed, 25 Jan 2017 22:44:16 +1300
Message-Id: <1485337456-16195-1-git-send-email-thomas.petazzoni@free-electrons.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

libselinux 2.6 has added some code in regex.c that uses __BYTE_ORDER__
to determine the system endianness. Unfortunately, this definition
provided directly by the compiler doesn't exist in older gcc versions
such as gcc 4.4.

In order to address this, this commit extends the logic to use
<endian.h> definitions if __BYTE_ORDER__ is not provided by the
compiler. This allows libselinux to build properly with gcc 4.4.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 libselinux/src/regex.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index a3b427b..0c5ad27 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -13,7 +13,18 @@
 #endif
 
 #ifndef __BYTE_ORDER__
-#error __BYTE_ORDER__ not defined. Unable to determine endianness.
+
+/* If the compiler doesn't define __BYTE_ORDER__, try to use the C
+ * library <endian.h> header definitions. */
+#include <endian.h>
+#ifndef __BYTE_ORDER
+#error Neither __BYTE_ORDER__ nor __BYTE_ORDER defined. Unable to determine endianness.
+#endif
+
+#define __ORDER_LITTLE_ENDIAN __LITTLE_ENDIAN
+#define __ORDER_BIG_ENDIAN __BIG_ENDIAN
+#define __BYTE_ORDER__ __BYTE_ORDER
+
 #endif
 
 #ifdef USE_PCRE2
-- 
2.7.4
