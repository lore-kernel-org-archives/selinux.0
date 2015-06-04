Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t54GFfwq032600
 for <selinux@tycho.nsa.gov>; Thu, 4 Jun 2015 12:15:41 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 by mx1.redhat.com (Postfix) with ESMTPS id A853F2CAB8B
 for <selinux@tycho.nsa.gov>; Thu,  4 Jun 2015 16:15:39 +0000 (UTC)
Subject: [PATCH 3/3] selinux-testsuite: fix compile warnings in tests/execshare
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Thu, 04 Jun 2015 12:15:38 -0400
Message-ID: <20150604161538.4124.38211.stgit@localhost>
In-Reply-To: <20150604161454.4124.77310.stgit@localhost>
References: <20150604161454.4124.77310.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Correct the following:

make[2]: Entering directory '/root/sources/selinux-testsuite/tests/execshare'
cc     parent.c  -lselinux -o parent
parent.c: In function 'main':
parent.c:83:8: warning: implicit declaration of function 'clone'
  pid = clone(clone_fn, clone_stack, cloneflags | SIGCHLD, argv);
        ^

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 tests/execshare/parent.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/execshare/parent.c b/tests/execshare/parent.c
index 86f6ae9..343c35f 100644
--- a/tests/execshare/parent.c
+++ b/tests/execshare/parent.c
@@ -1,3 +1,6 @@
+
+#define _GNU_SOURCE
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
