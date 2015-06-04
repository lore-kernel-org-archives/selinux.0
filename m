Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t54Kw3QG021376
 for <selinux@tycho.nsa.gov>; Thu, 4 Jun 2015 16:58:03 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (Postfix) with ESMTPS id A9FE0BC927
 for <selinux@tycho.nsa.gov>; Thu,  4 Jun 2015 20:58:01 +0000 (UTC)
Subject: [PATCH v3 1/6] selinux-testsuite: add _GNU_SOURCE to tests/Makefile
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Thu, 04 Jun 2015 16:58:00 -0400
Message-ID: <20150604205800.19614.98453.stgit@localhost>
In-Reply-To: <20150604205708.19614.64746.stgit@localhost>
References: <20150604205708.19614.64746.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

As suggested by Stephen Smalley.  A couple of msgbuf struct
definitions had to be renamed as they were conflicting with system
definitions.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 tests/Makefile     |    3 +++
 tests/msg/msgrcv.c |    9 ++++-----
 tests/msg/msgsnd.c |   11 +++++------
 3 files changed, 12 insertions(+), 11 deletions(-)

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
index b23c801..1276c12 100644
--- a/tests/msg/msgrcv.c
+++ b/tests/msg/msgrcv.c
@@ -5,10 +5,9 @@
 #include <sys/msg.h>
 
 #define MSGMAX 1024
-
-struct msgbuf {
-  long mtype;     /* message type, must be > 0 */
-  char mtext[1024];  /* message data */
+struct msgbuf_test {
+	long mtype;
+	char mtext[MSGMAX];
 };
 
 int main(int argc, char **argv)
@@ -17,7 +16,7 @@ int main(int argc, char **argv)
 	int key = 0x8888;
 	int id;
 	int error;
-	struct msgbuf msgp;
+	struct msgbuf_test msgp;
 
 	while ((ch = getopt(argc, argv, "k:")) != EOF) {
 		switch (ch) {
diff --git a/tests/msg/msgsnd.c b/tests/msg/msgsnd.c
index e200aef..57bb027 100644
--- a/tests/msg/msgsnd.c
+++ b/tests/msg/msgsnd.c
@@ -6,10 +6,9 @@
 #include <string.h>
 
 #define MSGMAX 1024
-
-struct msgbuf {
-  long mtype;     /* message type, must be > 0 */
-  char mtext[1024];  /* message data */
+struct msgbuf_test {
+	long mtype;
+	char mtext[MSGMAX];
 };
 
 int main(int argc, char **argv)
@@ -18,7 +17,7 @@ int main(int argc, char **argv)
 	int key = 0x8888;
 	int id;
 	int error;
-	struct msgbuf msgp;
+	struct msgbuf_test msgp;
 
 	while ((ch = getopt(argc, argv, "k:")) != EOF) {
 		switch (ch) {
@@ -32,7 +31,7 @@ int main(int argc, char **argv)
 	if (id == -1)
 		return 1;
 
-	memset(&msgp, 'z', sizeof(struct msgbuf));
+	memset(&msgp, 'z', sizeof(msgp));
 	msgp.mtype = 1;
 
 	error = msgsnd(id, &msgp, MSGMAX, IPC_NOWAIT);
