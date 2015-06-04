Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t54GFOof032589
 for <selinux@tycho.nsa.gov>; Thu, 4 Jun 2015 12:15:29 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 by mx1.redhat.com (Postfix) with ESMTPS id 796D13627D6
 for <selinux@tycho.nsa.gov>; Thu,  4 Jun 2015 16:15:27 +0000 (UTC)
Subject: [PATCH 1/3] selinux-testsuite: fix some compile warnings in tests/nnp
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Thu, 04 Jun 2015 12:15:26 -0400
Message-ID: <20150604161526.4124.36377.stgit@localhost>
In-Reply-To: <20150604161454.4124.77310.stgit@localhost>
References: <20150604161454.4124.77310.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Correct the following:

make[2]: Entering directory '/root/sources/selinux-testsuite/tests/nnp'
cc     execnnp.c  -lselinux -o execnnp
execnnp.c: In function 'main':
execnnp.c:27:9: warning: implicit declaration of function 'strverscmp'
        (strverscmp(uts.release, "3.18") < 0));
         ^
execnnp.c:47:8: warning: implicit declaration of function 'wait'
  pid = wait(&status);

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 tests/nnp/execnnp.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/nnp/execnnp.c b/tests/nnp/execnnp.c
index a5a80cf..2563909 100644
--- a/tests/nnp/execnnp.c
+++ b/tests/nnp/execnnp.c
@@ -1,3 +1,6 @@
+
+#define _GNU_SOURCE
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -5,6 +8,8 @@
 #include <unistd.h>
 #include <sys/utsname.h>
 #include <sys/prctl.h>
+#include <sys/types.h>
+#include <sys/wait.h>
 
 int main(int argc, char **argv)
 {
