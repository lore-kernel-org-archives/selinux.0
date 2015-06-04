Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t54JfkgM015730
 for <selinux@tycho.nsa.gov>; Thu, 4 Jun 2015 15:41:51 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 by mx1.redhat.com (Postfix) with ESMTPS id 988B4BBB2C
 for <selinux@tycho.nsa.gov>; Thu,  4 Jun 2015 19:41:50 +0000 (UTC)
Subject: [PATCH 1/6] selinux-testsuite: add _GNU_SOURCE to tests/Makefile
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Thu, 04 Jun 2015 15:41:49 -0400
Message-ID: <20150604194149.31270.13124.stgit@localhost>
In-Reply-To: <20150604194045.31270.58300.stgit@localhost>
References: <20150604194045.31270.58300.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

As suggested by Stephen Smalley.  A couple of msgbuf struct
definitions had to be removed as they were conflicting with system
definitions.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 tests/Makefile     |    3 +++
 tests/msg/msgrcv.c |    5 -----
 tests/msg/msgsnd.c |    5 -----
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/tests/Makefile b/tests/Makefile
index e9d4646..8100b8f 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -1,3 +1,6 @@
+
+export CFLAGS+=-D_GNU_SOURCE
+
 DISTRO=$(shell ./os_detect)
 
 SUBDIRS_COMMON:=domain_trans entrypoint execshare exectrace execute_no_trans fdreceive inherit link mkdir msg open ptrace readlink relabel rename rxdir sem setattr setnice shm sigkill stat sysctl task_create task_setnice task_setscheduler task_getscheduler task_getsid task_getpgid task_setpgid wait file ioctl capable_file capable_net capable_sys
diff --git a/tests/msg/msgrcv.c b/tests/msg/msgrcv.c
index b23c801..285dcad 100644
--- a/tests/msg/msgrcv.c
+++ b/tests/msg/msgrcv.c
@@ -6,11 +6,6 @@
 
 #define MSGMAX 1024
 
-struct msgbuf {
-  long mtype;     /* message type, must be > 0 */
-  char mtext[1024];  /* message data */
-};
-
 int main(int argc, char **argv)
 {
 	int ch;
diff --git a/tests/msg/msgsnd.c b/tests/msg/msgsnd.c
index e200aef..7204ab6 100644
--- a/tests/msg/msgsnd.c
+++ b/tests/msg/msgsnd.c
@@ -7,11 +7,6 @@
 
 #define MSGMAX 1024
 
-struct msgbuf {
-  long mtype;     /* message type, must be > 0 */
-  char mtext[1024];  /* message data */
-};
-
 int main(int argc, char **argv)
 {
 	int ch;
