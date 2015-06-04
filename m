Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t54JgAYA015765
 for <selinux@tycho.nsa.gov>; Thu, 4 Jun 2015 15:42:10 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 by mx1.redhat.com (Postfix) with ESMTPS id 871EA2DC416
 for <selinux@tycho.nsa.gov>; Thu,  4 Jun 2015 19:42:08 +0000 (UTC)
Subject: [PATCH 4/6] selinux-testsuite: fix compile warnings in tests/setnice
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Thu, 04 Jun 2015 15:42:07 -0400
Message-ID: <20150604194207.31270.38391.stgit@localhost>
In-Reply-To: <20150604194045.31270.58300.stgit@localhost>
References: <20150604194045.31270.58300.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Correct the following:

make[2]: Entering directory '/root/sources/selinux-testsuite/tests/setnice'
cc     parent.c  -lselinux -o parent
parent.c: In function 'main':
parent.c:92:9: warning: implicit declaration of function 'setpriority'
   rc =  setpriority(0,pid,10);
         ^

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 tests/setnice/parent.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/setnice/parent.c b/tests/setnice/parent.c
index d5a2533..6d3c855 100644
--- a/tests/setnice/parent.c
+++ b/tests/setnice/parent.c
@@ -3,6 +3,8 @@
 #include <unistd.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <sys/time.h>
+#include <sys/resource.h>
 #include <signal.h>
 #include <selinux/selinux.h>
 #include <selinux/context.h>
