Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7GKC4ng027000
 for <selinux@tycho.nsa.gov>; Tue, 16 Aug 2016 16:12:04 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 03ED1C0B7737
 for <selinux@tycho.nsa.gov>; Tue, 16 Aug 2016 20:11:44 +0000 (UTC)
Subject: [PATCH] selinux-testsuite: fix cap_userns compiler warnings
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Tue, 16 Aug 2016 16:11:42 -0400
Message-ID: <147137830278.28034.16028483708824878946.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The top-level Makefile defines _GNU_SOURCE by default which causes the
following build warning:

    cc -g -O0 -Wall -D_GNU_SOURCE userns_child_exec.c -o userns_child_exec
    userns_child_exec.c:11:0: warning: "_GNU_SOURCE" redefined
     #define _GNU_SOURCE

... this patch first checks to see if _GNU_SOURCE is defined before
defining it again.  We're doing it this way, instead of removing it
entirely so that the test will still work outside the testsuite.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 tests/cap_userns/userns_child_exec.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/cap_userns/userns_child_exec.c b/tests/cap_userns/userns_child_exec.c
index 26ea357..e31bf71 100644
--- a/tests/cap_userns/userns_child_exec.c
+++ b/tests/cap_userns/userns_child_exec.c
@@ -8,7 +8,11 @@
    namespace(s); allow UID and GID mappings to be specified when
    creating a user namespace.
 */
+
+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
+
 #include <sched.h>
 #include <unistd.h>
 #include <stdlib.h>
