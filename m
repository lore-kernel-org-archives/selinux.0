Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v08Ikkkg026346
 for <selinux@tycho.nsa.gov>; Sun, 8 Jan 2017 13:46:47 -0500
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 6BF4256467C
 for <selinux@tycho.nsa.gov>; Sun,  8 Jan 2017 19:46:39 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/3] libselinux: include errno.h instead of sys/errno.h
Date: Sun,  8 Jan 2017 19:45:51 +0100
Message-Id: <20170108184553.31842-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Building with musl libc leads to some build errors:

    setrans_client.c: In function ‘receive_response’:
    setrans_client.c:147:19: error: implicit declaration of function
    ‘readv’ [-Werror=implicit-function-declaration]
      while (((count = readv(fd, resp_hdr, 3)) < 0) && (errno == EINTR)) ;
                       ^~~~~

and:

    In file included from matchpathcon.c:10:0:
    /usr/include/sys/errno.h:1:2: error: #warning redirecting incorrect
    #include <sys/errno.h> to <errno.h> [-Werror=cpp]
     #warning redirecting incorrect #include <sys/errno.h> to <errno.h>
      ^

Fix the first one by including <sys/uio.h> and the second one by using
<errno.h> instead of <sys/errno.h>.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/src/setrans_client.c                    | 1 +
 libselinux/utils/matchpathcon.c                    | 1 -
 libselinux/utils/selinux_check_securetty_context.c | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/setrans_client.c b/libselinux/src/setrans_client.c
index 8c3a41c8dc52..fa188a824f78 100644
--- a/libselinux/src/setrans_client.c
+++ b/libselinux/src/setrans_client.c
@@ -18,6 +18,7 @@
 #include <string.h>
 #include <ctype.h>
 #include <unistd.h>
+#include <sys/uio.h>
 #include "dso.h"
 #include "selinux_internal.h"
 #include "setrans_internal.h"
diff --git a/libselinux/utils/matchpathcon.c b/libselinux/utils/matchpathcon.c
index fca8ee29766a..67e4a433da59 100644
--- a/libselinux/utils/matchpathcon.c
+++ b/libselinux/utils/matchpathcon.c
@@ -7,7 +7,6 @@
 #include <limits.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/errno.h>
 #include <selinux/selinux.h>
 #include <limits.h>
 #include <stdlib.h>
diff --git a/libselinux/utils/selinux_check_securetty_context.c b/libselinux/utils/selinux_check_securetty_context.c
index 84f59078ba15..5581dde15c83 100644
--- a/libselinux/utils/selinux_check_securetty_context.c
+++ b/libselinux/utils/selinux_check_securetty_context.c
@@ -1,3 +1,4 @@
+#include <errno.h>
 #include <unistd.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -6,7 +7,6 @@
 #include <string.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/errno.h>
 #include <selinux/selinux.h>
 
 static __attribute__ ((__noreturn__)) void usage(const char *progname)
-- 
2.11.0
