Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v08Il3OC026566
 for <selinux@tycho.nsa.gov>; Sun, 8 Jan 2017 13:47:03 -0500
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 9EFC156467C
 for <selinux@tycho.nsa.gov>; Sun,  8 Jan 2017 19:46:43 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/3] mcstransd: fix and reorder includes
Date: Sun,  8 Jan 2017 19:45:53 +0100
Message-Id: <20170108184553.31842-3-nicolas.iooss@m4x.org>
In-Reply-To: <20170108184553.31842-1-nicolas.iooss@m4x.org>
References: <20170108184553.31842-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

- Sort included header files by their number of path components then
  alphabetically.
- Include unistd.h and sys/types.h only once.
- Include sys/uio.h to get readv() and writev() declarations when
  compiling with musl libc.
- Include poll.h instead of sys/poll.h as building with musl results in
  the following message:

    /usr/lib/musl/include/sys/poll.h:1:2: error: #warning redirecting
    incorrect #include <sys/poll.h> to <poll.h> [-Werror=cpp]
     #warning redirecting incorrect #include <sys/poll.h> to <poll.h>
     ^~~~~~~

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 mcstrans/src/mcstransd.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/mcstrans/src/mcstransd.c b/mcstrans/src/mcstransd.c
index f408e9f80972..a5ed36181fc6 100644
--- a/mcstrans/src/mcstransd.c
+++ b/mcstrans/src/mcstransd.c
@@ -1,22 +1,21 @@
 /* Copyright (c) 2006 Trusted Computer Solutions, Inc. */
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <sys/poll.h>
-#include <sys/stat.h>
-#include <sys/un.h>
 #include <errno.h>
+#include <poll.h>
+#include <signal.h>
 #include <stdint.h>
 #include <stdio.h>
-#include <unistd.h>
 #include <stdlib.h>
-#include <signal.h>
 #include <string.h>
 #include <syslog.h>
 #include <unistd.h>
 #include <selinux/selinux.h>
-#include <sys/types.h>
 #include <sys/capability.h>
 #include <sys/resource.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/uio.h>
+#include <sys/un.h>
 #include "mcstrans.h"
 
 #ifdef UNUSED
-- 
2.11.0
