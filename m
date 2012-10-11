Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q9B98GNj016931
	for <selinux@tycho.nsa.gov>; Thu, 11 Oct 2012 05:08:16 -0400
From: Jan Stancek <jstancek@redhat.com>
To: selinux@tycho.nsa.gov
Cc: serge@hallyn.com, jburke@redhat.com
Subject: [selinux-testsuite][PATCH] fix execshare/parent segfault on ia64
Date: Thu, 11 Oct 2012 11:07:57 +0200
Message-Id: <42002068c0fe81bb86ba73b1dadf3b67f7573708.1349946248.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

from clone(2):
---
On ia64, a different system call is used:
..
The  __clone2()  system  call  operates  in  the same way as clone(),
except that child_stack_base points to the lowest address of the
child’s stack area, and stack_size specifies the size of the stack
pointed to by child_stack_base.
---

Problem is that __clone2() expects lowest address, and it's passed
the highest one. This likely worked before only by chance, where
it used part of heap and didn't overwrite something essential.

Following commit unmasked the problem:
commit 8de27738f01550a3639ff100982adbeb46082105
Author: Serge Hallyn <serge.hallyn@canonical.com>
Date:   Wed Apr 4 21:12:32 2012 -0500
    alloc more than a page for clone stack

Pagesize on ia64 host, where it failed is 16k, so when clone stack
size increased 16x, (16*16k = 256k), it went over MMAP_THRESHOLD
and instead of using heap it mmap-ed some isolated area.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 tests/execshare/parent.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tests/execshare/parent.c b/tests/execshare/parent.c
index 77ea499..86f6ae9 100644
--- a/tests/execshare/parent.c
+++ b/tests/execshare/parent.c
@@ -78,7 +78,7 @@ int main(int argc, char **argv)
 #if defined(__hppa__)
 	pid = clone(clone_fn, page, cloneflags | SIGCHLD, argv);
 #elif defined(__ia64__)
-	pid = __clone2(clone_fn, clone_stack, pagesize, cloneflags | SIGCHLD, argv, NULL, NULL, NULL);
+	pid = __clone2(clone_fn, page, pagesize, cloneflags | SIGCHLD, argv, NULL, NULL, NULL);
 #else
 	pid = clone(clone_fn, clone_stack, cloneflags | SIGCHLD, argv);
 #endif
-- 
1.7.1



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
