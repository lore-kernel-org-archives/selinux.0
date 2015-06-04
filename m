Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t54JgMOs015773
 for <selinux@tycho.nsa.gov>; Thu, 4 Jun 2015 15:42:22 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 by mx1.redhat.com (Postfix) with ESMTPS id 837DEB7A6F
 for <selinux@tycho.nsa.gov>; Thu,  4 Jun 2015 19:42:20 +0000 (UTC)
Subject: [PATCH 6/6] selinux-testsuite: fix compile problems in
 tests/capable_file
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Thu, 04 Jun 2015 15:42:19 -0400
Message-ID: <20150604194219.31270.44618.stgit@localhost>
In-Reply-To: <20150604194045.31270.58300.stgit@localhost>
References: <20150604194045.31270.58300.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fix the following warnings:

make[2]: Entering directory '/home/pmoore/sources/selinux-testsuite/selinux_testsuite-upstream/tests/capable_file'
cc -g -O0 -Wall -D_GNU_SOURCE    test_lease.c   -o test_lease
test_lease.c: In function 'main':
test_lease.c:22:3: warning: implicit declaration of function 'open'
   fd = open(argv[1], O_RDONLY, 0);
   ^
test_lease.c:29:3: warning: implicit declaration of function 'fcntl'
   rc = fcntl(fd, F_SETLEASE, 0);
   ^

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 tests/capable_file/test_lease.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/capable_file/test_lease.c b/tests/capable_file/test_lease.c
index 606d75c..e8f29eb 100644
--- a/tests/capable_file/test_lease.c
+++ b/tests/capable_file/test_lease.c
@@ -1,9 +1,10 @@
-#include<stdio.h>
-#include<stdlib.h>
-#include<sys/types.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/stat.h>
 #include <linux/posix_types.h>
-#include<linux/fcntl.h>
 #include <unistd.h>
+#include <fcntl.h>
 
 /*
  * Test the fcntl F_SETLEASE operation on a file whose name is given as 
