Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t54Jg4ks015753
 for <selinux@tycho.nsa.gov>; Thu, 4 Jun 2015 15:42:04 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (Postfix) with ESMTPS id 97C90B8BDC
 for <selinux@tycho.nsa.gov>; Thu,  4 Jun 2015 19:42:02 +0000 (UTC)
Subject: [PATCH 3/6] selinux-testsuite: fix some compile warnings in tests/nnp
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Thu, 04 Jun 2015 15:42:01 -0400
Message-ID: <20150604194201.31270.60973.stgit@localhost>
In-Reply-To: <20150604194045.31270.58300.stgit@localhost>
References: <20150604194045.31270.58300.stgit@localhost>
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
 tests/nnp/execnnp.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/nnp/execnnp.c b/tests/nnp/execnnp.c
index a5a80cf..756c2d0 100644
--- a/tests/nnp/execnnp.c
+++ b/tests/nnp/execnnp.c
@@ -5,6 +5,8 @@
 #include <unistd.h>
 #include <sys/utsname.h>
 #include <sys/prctl.h>
+#include <sys/types.h>
+#include <sys/wait.h>
 
 int main(int argc, char **argv)
 {
