Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t54JhOG1015840
 for <selinux@tycho.nsa.gov>; Thu, 4 Jun 2015 15:43:24 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 by mx1.redhat.com (Postfix) with ESMTPS id 3E238BBB2C
 for <selinux@tycho.nsa.gov>; Thu,  4 Jun 2015 19:43:20 +0000 (UTC)
Subject: [PATCH] selinux-testsuite: adopt a more consistent style
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Thu, 04 Jun 2015 15:43:18 -0400
Message-ID: <20150604194318.31844.34320.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Do a bulk restyling effort using astyle with the following options:

        astyle --options=none --lineend=linux --mode=c \
                --style=linux \
                --indent=force-tab=8 \
                --indent-preprocessor \
                --indent-col1-comments \
                --min-conditional-indent=0 \
                --max-instatement-indent=80 \
                --pad-oper \
                --align-pointer=name \
                --align-reference=name \
                --max-code-length=80 \
                --break-after-logical

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 tests/bounds/thread.c             |    2 
 tests/capable_file/test_lease.c   |   55 ++++++-----
 tests/capable_net/test_bind.c     |   23 ++---
 tests/capable_net/test_raw.c      |   19 ++--
 tests/capable_sys/test_chroot.c   |   27 +++--
 tests/capable_sys/test_hostname.c |   29 +++---
 tests/capable_sys/test_nice.c     |   17 ++-
 tests/capable_sys/test_rawio.c    |   57 ++++++------
 tests/dyntrace/child.c            |    2 
 tests/dyntrace/parent.c           |   15 ++-
 tests/dyntrans/parent.c           |    4 -
 tests/execshare/child.c           |    2 
 tests/execshare/parent.c          |   18 ++--
 tests/exectrace/child.c           |    2 
 tests/exectrace/parent.c          |   17 ++-
 tests/fdreceive/client.c          |    8 +-
 tests/fdreceive/server.c          |   16 ++-
 tests/file/test_fcntl.c           |   89 +++++++++---------
 tests/file/test_lock.c            |   65 +++++++------
 tests/file/test_mmap.c            |   70 +++++++-------
 tests/file/test_mprotect.c        |   83 +++++++++--------
 tests/file/test_nofcntl.c         |   81 ++++++++--------
 tests/file/test_rw.c              |   81 ++++++++--------
 tests/file/test_seek.c            |   57 ++++++------
 tests/file/test_sigiotask.c       |  178 ++++++++++++++++++------------------
 tests/file/wait_io.c              |   32 +++----
 tests/inherit/child.c             |    2 
 tests/inherit/parent.c            |   10 +-
 tests/ioctl/test_ioctl.c          |   87 +++++++++---------
 tests/ioctl/test_noioctl.c        |  120 ++++++++++++------------
 tests/msg/msgctl.c                |    8 +-
 tests/msg/msgget.c                |    4 -
 tests/msg/msgrcv.c                |    4 -
 tests/msg/msgsnd.c                |    2 
 tests/nnp/execnnp.c               |    5 +
 tests/open/append2write.c         |    2 
 tests/open/fopen.c                |    2 
 tests/ptrace/ptrace.c             |   38 ++++----
 tests/sem/semctl.c                |   16 ++-
 tests/sem/semget.c                |    2 
 tests/sem/semop.c                 |    2 
 tests/setnice/child.c             |   30 +++---
 tests/setnice/parent.c            |  182 +++++++++++++++++++------------------
 tests/shm/shmat.c                 |    6 +
 tests/shm/shmctl.c                |   12 +-
 tests/shm/shmget.c                |    4 -
 tests/sigkill/server.c            |   24 ++---
 tests/socket/noaccept.c           |    2 
 tests/socket/options.c            |    6 +
 tests/socket/sink.c               |    2 
 tests/socket/source.c             |    6 +
 tests/task_create/parent.c        |    4 -
 tests/task_getpgid/source.c       |    6 +
 tests/task_getpgid/target.c       |    2 
 tests/task_getscheduler/source.c  |    6 +
 tests/task_getscheduler/target.c  |    2 
 tests/task_getsid/source.c        |    6 +
 tests/task_getsid/target.c        |    2 
 tests/task_setnice/target.c       |    2 
 tests/task_setpgid/source.c       |   10 +-
 tests/task_setscheduler/source.c  |    8 +-
 tests/task_setscheduler/target.c  |    2 
 tests/unix_secure/checksyscalls.c |    4 -
 tests/unix_secure/client.c        |   14 +--
 tests/unix_socket/unix_options.c  |    6 +
 tests/unix_socket/unix_sink.c     |    2 
 tests/unix_socket/unix_source.c   |    6 +
 tests/wait/child.c                |    2 
 tests/wait/parent.c               |    6 +
 69 files changed, 871 insertions(+), 846 deletions(-)

diff --git a/tests/bounds/thread.c b/tests/bounds/thread.c
index d9ecafb..d09a634 100644
--- a/tests/bounds/thread.c
+++ b/tests/bounds/thread.c
@@ -56,7 +56,7 @@ int main(int argc, char *argv[])
 	if (context_type_set(context, argv[1])) {
 		fprintf(stderr, "%s: unable to set new type\n", argv[0]);
 		return 1;
-        }
+	}
 
 	freecon(security_context);
 	security_context = context_str(context);
diff --git a/tests/capable_file/test_lease.c b/tests/capable_file/test_lease.c
index e8f29eb..c5f2ebc 100644
--- a/tests/capable_file/test_lease.c
+++ b/tests/capable_file/test_lease.c
@@ -7,34 +7,35 @@
 #include <fcntl.h>
 
 /*
- * Test the fcntl F_SETLEASE operation on a file whose name is given as 
+ * Test the fcntl F_SETLEASE operation on a file whose name is given as
  * the first argument.
  */
-int main(int argc, char **argv) {
-
-  int fd;
-  int rc;
-
-  if( argc != 2 ) {
-    printf("usage: %s filename\n", argv[0]);
-    exit(2);
-  }
-
-  fd = open(argv[1], O_RDONLY, 0);
-  
-  if(fd == -1) {
-    perror("test_lease:open");
-    exit(2);
-  }
-
-  rc = fcntl(fd, F_SETLEASE, 0);
-  if( rc == -1 ) {
-    perror("test_lease:F_SETLEASE");
-    close(fd);
-    exit(1);
-  }
-
-  close(fd);
-  exit(0);
+int main(int argc, char **argv)
+{
+
+	int fd;
+	int rc;
+
+	if( argc != 2 ) {
+		printf("usage: %s filename\n", argv[0]);
+		exit(2);
+	}
+
+	fd = open(argv[1], O_RDONLY, 0);
+
+	if(fd == -1) {
+		perror("test_lease:open");
+		exit(2);
+	}
+
+	rc = fcntl(fd, F_SETLEASE, 0);
+	if( rc == -1 ) {
+		perror("test_lease:F_SETLEASE");
+		close(fd);
+		exit(1);
+	}
+
+	close(fd);
+	exit(0);
 
 }
diff --git a/tests/capable_net/test_bind.c b/tests/capable_net/test_bind.c
index 4b04164..fdd76c0 100644
--- a/tests/capable_net/test_bind.c
+++ b/tests/capable_net/test_bind.c
@@ -6,19 +6,20 @@
 /*
  * Test the bind() operation for a socket that is protected (< 1024).
  */
-int main(int argc, char **argv) {
+int main(int argc, char **argv)
+{
 
-  int fd;
-  int aport;
+	int fd;
+	int aport;
 
-  aport = IPPORT_RESERVED - 1;
-  fd = rresvport(&aport);
-  if(fd == -1) {
-    perror("test_bind:rresvport");
-    exit(1);
-  }
+	aport = IPPORT_RESERVED - 1;
+	fd = rresvport(&aport);
+	if(fd == -1) {
+		perror("test_bind:rresvport");
+		exit(1);
+	}
 
-  close(fd);
-  exit(0);
+	close(fd);
+	exit(0);
 
 }
diff --git a/tests/capable_net/test_raw.c b/tests/capable_net/test_raw.c
index 3380c87..4f34868 100644
--- a/tests/capable_net/test_raw.c
+++ b/tests/capable_net/test_raw.c
@@ -6,17 +6,18 @@
 /*
  * Test the bind() operation for a raw socket.
  */
-int main(int argc, char **argv) {
+int main(int argc, char **argv)
+{
 
-  int fd;
+	int fd;
 
-  fd = socket(PF_INET, SOCK_RAW, IPPROTO_RAW);
-  if(fd == -1) {
-    perror("test_raw:socket");
-    exit(1);
-  }
+	fd = socket(PF_INET, SOCK_RAW, IPPROTO_RAW);
+	if(fd == -1) {
+		perror("test_raw:socket");
+		exit(1);
+	}
 
-  close(fd);
-  exit(0);
+	close(fd);
+	exit(0);
 
 }
diff --git a/tests/capable_sys/test_chroot.c b/tests/capable_sys/test_chroot.c
index 6151d7d..07188d0 100644
--- a/tests/capable_sys/test_chroot.c
+++ b/tests/capable_sys/test_chroot.c
@@ -3,24 +3,25 @@
 #include <unistd.h>
 
 /*
- * Test the chroot() call on a directory whose name is given as the first 
+ * Test the chroot() call on a directory whose name is given as the first
  * argument. This call will result in a CAP_SYS_CHROOT capable check.
  */
-int main(int argc, char **argv) {
+int main(int argc, char **argv)
+{
 
-  int rc;
+	int rc;
 
-  if( argc != 2 ) {
-    printf("usage: %s pathname\n", argv[0]);
-    exit(2);
-  }
+	if( argc != 2 ) {
+		printf("usage: %s pathname\n", argv[0]);
+		exit(2);
+	}
 
-  rc = chroot(argv[1]);
-  if( rc != 0 ) {
-    perror("test_chroot:chroot");
-    exit(1);
-  }
+	rc = chroot(argv[1]);
+	if( rc != 0 ) {
+		perror("test_chroot:chroot");
+		exit(1);
+	}
 
-  exit(0);
+	exit(0);
 
 }
diff --git a/tests/capable_sys/test_hostname.c b/tests/capable_sys/test_hostname.c
index fc24548..318bf63 100644
--- a/tests/capable_sys/test_hostname.c
+++ b/tests/capable_sys/test_hostname.c
@@ -7,23 +7,24 @@
  * Test the sethostname() call.
  * This call will result in a CAP_SYS_ADMIN capable check.
  */
-int main(int argc, char **argv) {
+int main(int argc, char **argv)
+{
 
-  int rc;
-  char buf[255];
+	int rc;
+	char buf[255];
 
-  rc = gethostname(buf, sizeof(buf));
-  if( rc != 0 ) {
-    perror("test_sethostname:gethostname");
-    exit(2);
-  }
+	rc = gethostname(buf, sizeof(buf));
+	if( rc != 0 ) {
+		perror("test_sethostname:gethostname");
+		exit(2);
+	}
 
-  rc = sethostname(buf, strlen(buf));
-  if( rc != 0 ) {
-    perror("test_sethostname:sethostname");
-    exit(1);
-  }
+	rc = sethostname(buf, strlen(buf));
+	if( rc != 0 ) {
+		perror("test_sethostname:sethostname");
+		exit(1);
+	}
 
-  exit(0);
+	exit(0);
 
 }
diff --git a/tests/capable_sys/test_nice.c b/tests/capable_sys/test_nice.c
index 588295f..04a942d 100644
--- a/tests/capable_sys/test_nice.c
+++ b/tests/capable_sys/test_nice.c
@@ -7,16 +7,17 @@
  * Test the nice() system call.
  * This call will result in a CAP_SYS_NICE capable check.
  */
-int main(int argc, char **argv) {
+int main(int argc, char **argv)
+{
 
-  int rc;
+	int rc;
 
-  rc = nice(-10);
-  if( rc == -1) {
-    perror("test_nice:nice");
-    exit(1);
-  }
+	rc = nice(-10);
+	if( rc == -1) {
+		perror("test_nice:nice");
+		exit(1);
+	}
 
-  exit(0);
+	exit(0);
 
 }
diff --git a/tests/capable_sys/test_rawio.c b/tests/capable_sys/test_rawio.c
index 722f48b..80ae727 100644
--- a/tests/capable_sys/test_rawio.c
+++ b/tests/capable_sys/test_rawio.c
@@ -6,35 +6,36 @@
 #include <unistd.h>
 
 /*
- * Test the FIBMAP ioctl() call on a file whose name is given as the first 
+ * Test the FIBMAP ioctl() call on a file whose name is given as the first
  * argument. This ioctl will result in a CAP_SYS_RAWIO capable check.
  */
-int main(int argc, char **argv) {
-
-  int fd;
-  int rc;
-  int val = 0;
-
-  if( argc != 2 ) {
-    printf("usage: %s filename\n", argv[0]);
-    exit(2);
-  }
-
-  fd = open(argv[1], O_RDONLY, 0);
-  
-  if(fd == -1) {
-    perror("test_rawio:open");
-    exit(2);
-  }
-
-  val = 0;
-  rc = ioctl(fd, FIBMAP, &val);
-  if( rc != 0 ) {
-    perror("test_rawio:FIBMAP");
-    exit(1);
-  }
-
-  close(fd);
-  exit(0);
+int main(int argc, char **argv)
+{
+
+	int fd;
+	int rc;
+	int val = 0;
+
+	if( argc != 2 ) {
+		printf("usage: %s filename\n", argv[0]);
+		exit(2);
+	}
+
+	fd = open(argv[1], O_RDONLY, 0);
+
+	if(fd == -1) {
+		perror("test_rawio:open");
+		exit(2);
+	}
+
+	val = 0;
+	rc = ioctl(fd, FIBMAP, &val);
+	if( rc != 0 ) {
+		perror("test_rawio:FIBMAP");
+		exit(1);
+	}
+
+	close(fd);
+	exit(0);
 
 }
diff --git a/tests/dyntrace/child.c b/tests/dyntrace/child.c
index d146e8b..2d29fd4 100644
--- a/tests/dyntrace/child.c
+++ b/tests/dyntrace/child.c
@@ -2,7 +2,7 @@
 #include <stdio.h>
 #include <selinux/selinux.h>
 
-int main(int argc, char **argv) 
+int main(int argc, char **argv)
 {
 	int rc;
 
diff --git a/tests/dyntrace/parent.c b/tests/dyntrace/parent.c
index 03e08c1..a3a644e 100644
--- a/tests/dyntrace/parent.c
+++ b/tests/dyntrace/parent.c
@@ -20,7 +20,7 @@ int main(int argc, char **argv)
 		fprintf(stderr, "usage:  %s newdomain program\n", argv[0]);
 		exit(-1);
 	}
-	
+
 	rc = getcon(&context_s);
 	if (rc < 0) {
 		fprintf(stderr, "%s:  unable to get my context\n", argv[0]);
@@ -33,12 +33,12 @@ int main(int argc, char **argv)
 		fprintf(stderr, "%s:  unable to create context structure\n", argv[0]);
 		exit(-1);
 	}
-	
+
 	if (context_type_set(context, argv[1])) {
 		fprintf(stderr, "%s:  unable to set new type\n", argv[0]);
 		exit(-1);
 	}
-	
+
 	freecon(context_s);
 	context_s = context_str(context);
 	if (!context_s) {
@@ -51,7 +51,7 @@ int main(int argc, char **argv)
 		perror("fork");
 		exit(-1);
 	} else if (pid == 0) {
-		signal(SIGTRAP, SIG_IGN); 
+		signal(SIGTRAP, SIG_IGN);
 		rc =  ptrace(PTRACE_TRACEME, 0, 0, 0);
 		if (rc < 0) {
 			perror("ptrace: PTRACE_TRACEME");
@@ -86,8 +86,8 @@ repeat:
 		}
 		fprintf(stderr, "Child has context %s\n", context_s);
 		fprintf(stderr, "..Resuming the child.\n");
-		rc = ptrace(PTRACE_CONT,pid,0,0);
-		if (rc < 0){
+		rc = ptrace(PTRACE_CONT, pid, 0, 0);
+		if (rc < 0) {
 			perror("ptrace: PTRACE_CONT");
 			exit(-1);
 		}
@@ -96,7 +96,8 @@ repeat:
 
 	if (WIFSIGNALED(status)) {
 		fprintf(stderr, "Child terminated by signal %d.\n", WTERMSIG(status));
-		fprintf(stderr, "..This is consistent with a ptrace permission denial - check the audit message.\n");
+		fprintf(stderr,
+			"..This is consistent with a ptrace permission denial - check the audit message.\n");
 		exit(1);
 	}
 
diff --git a/tests/dyntrans/parent.c b/tests/dyntrans/parent.c
index bb69695..660a1d5 100644
--- a/tests/dyntrans/parent.c
+++ b/tests/dyntrans/parent.c
@@ -31,12 +31,12 @@ int main(int argc, char **argv)
 		fprintf(stderr, "%s:  unable to create context structure\n", argv[0]);
 		exit(-1);
 	}
-	
+
 	if (context_type_set(context, argv[1])) {
 		fprintf(stderr, "%s:  unable to set new type\n", argv[0]);
 		exit(-1);
 	}
-	
+
 	freecon(context_s);
 	context_s = context_str(context);
 	if (!context_s) {
diff --git a/tests/execshare/child.c b/tests/execshare/child.c
index 50b9b72..d80c613 100644
--- a/tests/execshare/child.c
+++ b/tests/execshare/child.c
@@ -1,6 +1,6 @@
 #include <stdlib.h>
 
-int main(void) 
+int main(void)
 {
 	exit(0);
 }
diff --git a/tests/execshare/parent.c b/tests/execshare/parent.c
index 86f6ae9..2357265 100644
--- a/tests/execshare/parent.c
+++ b/tests/execshare/parent.c
@@ -12,7 +12,7 @@
 int clone_fn(void *arg)
 {
 	char **argv = arg;
-	execv(argv[3], argv+3);
+	execv(argv[3], argv + 3);
 	perror(argv[3]);
 	return -1;
 }
@@ -36,7 +36,7 @@ int main(int argc, char **argv)
 		exit(-1);
 	}
 
-	pagesize = 16*getpagesize();
+	pagesize = 16 * getpagesize();
 	page = malloc(pagesize);
 	if (!page) {
 		perror("malloc");
@@ -56,7 +56,7 @@ int main(int argc, char **argv)
 		fprintf(stderr, "%s:  unable to create context structure\n", argv[0]);
 		exit(-1);
 	}
-	
+
 	if (context_type_set(context, argv[2])) {
 		fprintf(stderr, "%s:  unable to set new type\n", argv[0]);
 		exit(-1);
@@ -78,14 +78,15 @@ int main(int argc, char **argv)
 #if defined(__hppa__)
 	pid = clone(clone_fn, page, cloneflags | SIGCHLD, argv);
 #elif defined(__ia64__)
-	pid = __clone2(clone_fn, page, pagesize, cloneflags | SIGCHLD, argv, NULL, NULL, NULL);
+	pid = __clone2(clone_fn, page, pagesize, cloneflags | SIGCHLD, argv, NULL, NULL,
+		       NULL);
 #else
 	pid = clone(clone_fn, clone_stack, cloneflags | SIGCHLD, argv);
 #endif
 	if (pid < 0) {
 		perror("clone");
 		exit(-1);
-	} 
+	}
 
 	pid = wait(&status);
 	if (pid < 0) {
@@ -102,8 +103,8 @@ int main(int argc, char **argv)
 		fprintf(stderr, "Child stopped by signal %d.\n", WSTOPSIG(status));
 		fprintf(stderr, "..This shouldn't happen.\n");
 		fprintf(stderr, "..Killing the child.\n");
-		rc = kill(pid,SIGKILL);
-		if (rc < 0){
+		rc = kill(pid, SIGKILL);
+		if (rc < 0) {
 			perror("kill");
 			exit(-1);
 		}
@@ -112,7 +113,8 @@ int main(int argc, char **argv)
 
 	if (WIFSIGNALED(status)) {
 		fprintf(stderr, "Child terminated by signal %d.\n", WTERMSIG(status));
-		fprintf(stderr, "..This is consistent with a share permission denial, check the audit message.\n");
+		fprintf(stderr,
+			"..This is consistent with a share permission denial, check the audit message.\n");
 		exit(1);
 	}
 
diff --git a/tests/exectrace/child.c b/tests/exectrace/child.c
index 50b9b72..d80c613 100644
--- a/tests/exectrace/child.c
+++ b/tests/exectrace/child.c
@@ -1,6 +1,6 @@
 #include <stdlib.h>
 
-int main(void) 
+int main(void)
 {
 	exit(0);
 }
diff --git a/tests/exectrace/parent.c b/tests/exectrace/parent.c
index 219bce6..88adb56 100644
--- a/tests/exectrace/parent.c
+++ b/tests/exectrace/parent.c
@@ -18,7 +18,7 @@ int main(int argc, char **argv)
 		fprintf(stderr, "usage:  %s newdomain program\n", argv[0]);
 		exit(-1);
 	}
-	
+
 	rc = getcon(&context_s);
 	if (rc < 0) {
 		fprintf(stderr, "%s:  unable to get my context\n", argv[0]);
@@ -31,12 +31,12 @@ int main(int argc, char **argv)
 		fprintf(stderr, "%s:  unable to create context structure\n", argv[0]);
 		exit(-1);
 	}
-	
+
 	if (context_type_set(context, argv[1])) {
 		fprintf(stderr, "%s:  unable to set new type\n", argv[0]);
 		exit(-1);
 	}
-	
+
 	freecon(context_s);
 	context_s = context_str(context);
 	if (!context_s) {
@@ -55,13 +55,13 @@ int main(int argc, char **argv)
 		perror("fork");
 		exit(-1);
 	} else if (pid == 0) {
-		signal(SIGTRAP, SIG_IGN); 
+		signal(SIGTRAP, SIG_IGN);
 		rc =  ptrace(PTRACE_TRACEME, 0, 0, 0);
 		if (rc < 0) {
 			perror("ptrace: PTRACE_TRACEME");
 			exit(-1);
 		}
-		execv(argv[2], argv+2);
+		execv(argv[2], argv + 2);
 		perror(argv[2]);
 		exit(1);
 	}
@@ -87,8 +87,8 @@ repeat:
 		}
 		fprintf(stderr, "Child has context %s\n", context_s);
 		fprintf(stderr, "..Resuming the child.\n");
-		rc = ptrace(PTRACE_CONT,pid,0,0);
-		if (rc < 0){
+		rc = ptrace(PTRACE_CONT, pid, 0, 0);
+		if (rc < 0) {
 			perror("ptrace: PTRACE_CONT");
 			exit(-1);
 		}
@@ -97,7 +97,8 @@ repeat:
 
 	if (WIFSIGNALED(status)) {
 		fprintf(stderr, "Child terminated by signal %d.\n", WTERMSIG(status));
-		fprintf(stderr, "..This is consistent with a ptrace permission denial - check the audit message.\n");
+		fprintf(stderr,
+			"..This is consistent with a ptrace permission denial - check the audit message.\n");
 		exit(1);
 	}
 
diff --git a/tests/fdreceive/client.c b/tests/fdreceive/client.c
index 821825b..de40bc7 100644
--- a/tests/fdreceive/client.c
+++ b/tests/fdreceive/client.c
@@ -23,7 +23,7 @@ int main(int argc, char **argv)
 	if (argc != 3) {
 		fprintf(stderr, "usage:  %s testfile address\n", argv[0]);
 		exit(-1);
-	}	
+	}
 
 	myfd = open(argv[1], O_RDWR);
 	if (myfd < 0) {
@@ -49,7 +49,7 @@ int main(int argc, char **argv)
 	printf("client: Connected to server via %s\n", sun.sun_path);
 
 	strcpy(buf, "hello world");
-	buflen = strlen(buf)+1;
+	buflen = strlen(buf) + 1;
 	iov.iov_base = buf;
 	iov.iov_len = buflen;
 	msg.msg_name = 0;
@@ -80,10 +80,10 @@ int main(int argc, char **argv)
 		exit(-1);
 	}
 	printf("client: Received reply, code=%d\n", buf[0]);
-	if (buf[0]) 
+	if (buf[0])
 		printf("client: ...This implies the descriptor was not received\n");
 	else
 		printf("client: ...This implies the descriptor was received\n");
-		
+
 	exit(buf[0]);
 }
diff --git a/tests/fdreceive/server.c b/tests/fdreceive/server.c
index d62e167..a870e5c 100644
--- a/tests/fdreceive/server.c
+++ b/tests/fdreceive/server.c
@@ -29,13 +29,13 @@ int main(int argc, char **argv)
 	if (argc != 2) {
 		fprintf(stderr, "usage:  %s address\n", argv[0]);
 		exit(-1);
-	}	
+	}
 
 	for (i = 0; i < 32; i++) {
 		signal(i, handler);
 	}
 
-	
+
 	s = socket(AF_UNIX, SOCK_STREAM, 0);
 	if (s < 0) {
 		perror("socket");
@@ -47,7 +47,7 @@ int main(int argc, char **argv)
 	strcpy(sun.sun_path, argv[1]);
 	sunlen = strlen(sun.sun_path) + 1 + sizeof(short);
 	strcpy(my_path, sun.sun_path);
-	ret = bind(s, (struct sockaddr*)&sun, sunlen);
+	ret = bind(s, (struct sockaddr *)&sun, sunlen);
 	if (ret < 0) {
 		perror("bind");
 		exit(-1);
@@ -58,10 +58,10 @@ int main(int argc, char **argv)
 		perror("listen");
 		CLEANUP_AND_EXIT;
 	}
-	
+
 	while (1) {
 		sunlen = sizeof(struct sockaddr_un);
-		ctrl = accept(s, (struct sockaddr*)&sun, (socklen_t *)&sunlen);
+		ctrl = accept(s, (struct sockaddr *)&sun, (socklen_t *)&sunlen);
 		if (ctrl < 0) {
 			perror("accept_secure");
 			CLEANUP_AND_EXIT;
@@ -83,12 +83,12 @@ int main(int argc, char **argv)
 		if (ret < 0) {
 			perror("recv");
 			CLEANUP_AND_EXIT;
-		}	
+		}
 
-		for (cmsg = CMSG_FIRSTHDR(&msg); cmsg; cmsg = CMSG_NXTHDR(&msg,cmsg)) {
+		for (cmsg = CMSG_FIRSTHDR(&msg); cmsg; cmsg = CMSG_NXTHDR(&msg, cmsg)) {
 			if (cmsg->cmsg_level == SOL_SOCKET &&
 			    cmsg->cmsg_type == SCM_RIGHTS) {
-				fdptr = (int*)CMSG_DATA(cmsg);
+				fdptr = (int *)CMSG_DATA(cmsg);
 				fd = *fdptr;
 				printf("server:  Received a descriptor, fd=%d, sending back 0\n", fd);
 				buf[0] = 0;
diff --git a/tests/file/test_fcntl.c b/tests/file/test_fcntl.c
index 1723956..2d5fea9 100644
--- a/tests/file/test_fcntl.c
+++ b/tests/file/test_fcntl.c
@@ -6,51 +6,52 @@
 #include <unistd.h>
 
 /*
- * Test the fcntl file operation on a file whose name is given as the first 
+ * Test the fcntl file operation on a file whose name is given as the first
  * argument.
  */
-int main(int argc, char **argv) {
-
-  int fd;
-  int rc;
-  struct flock my_lock;
-
-  if( argc != 2 ) {
-    printf("usage: %s filename\n", argv[0]);
-    exit(2);
-  }
-
-  fd = open(argv[1], O_RDONLY | O_APPEND, 0);
-  
-  if(fd == -1) {
-    perror("test_fcntl:open");
-    exit(2);
-  }
-
-  rc = fcntl(fd, F_SETFL, 0);
-  if( rc == -1 ) {
-    perror("test_fcntl:F_SETFL");
-    exit(1);
-  }
-
-  rc = fcntl(fd, F_GETFL);
-  if( rc == -1 ) {
-    perror("test_fcntl:F_GETFL");
-    exit(1);
-  }
-
-  my_lock.l_type = F_RDLCK;
-  my_lock.l_start = 0;
-  my_lock.l_whence = SEEK_CUR;
-  my_lock.l_len = 0;
-
-  rc = fcntl(fd, F_GETLK, &my_lock);
-  if( rc == -1 ) {
-    perror("test_fcntl:F_GETLK");
-    exit(1);
-  }
-
-  close(fd);
-  exit(0);
+int main(int argc, char **argv)
+{
+
+	int fd;
+	int rc;
+	struct flock my_lock;
+
+	if( argc != 2 ) {
+		printf("usage: %s filename\n", argv[0]);
+		exit(2);
+	}
+
+	fd = open(argv[1], O_RDONLY | O_APPEND, 0);
+
+	if(fd == -1) {
+		perror("test_fcntl:open");
+		exit(2);
+	}
+
+	rc = fcntl(fd, F_SETFL, 0);
+	if( rc == -1 ) {
+		perror("test_fcntl:F_SETFL");
+		exit(1);
+	}
+
+	rc = fcntl(fd, F_GETFL);
+	if( rc == -1 ) {
+		perror("test_fcntl:F_GETFL");
+		exit(1);
+	}
+
+	my_lock.l_type = F_RDLCK;
+	my_lock.l_start = 0;
+	my_lock.l_whence = SEEK_CUR;
+	my_lock.l_len = 0;
+
+	rc = fcntl(fd, F_GETLK, &my_lock);
+	if( rc == -1 ) {
+		perror("test_fcntl:F_GETLK");
+		exit(1);
+	}
+
+	close(fd);
+	exit(0);
 
 }
diff --git a/tests/file/test_lock.c b/tests/file/test_lock.c
index caaa9bd..3ba1277 100644
--- a/tests/file/test_lock.c
+++ b/tests/file/test_lock.c
@@ -8,41 +8,42 @@
 #include<selinux/selinux.h>
 
 /*
- * Test the lock file operation on a file whose name is given as the first 
+ * Test the lock file operation on a file whose name is given as the first
  * argument. The second argument must be the SID we are to use to test
  * the actual lock() operation by changing the SID of the file we are
  * given.
  */
-int main(int argc, char **argv) {
-
-  int fd;
-  int rc;
-
-  if( argc != 3 ) {
-    printf("usage: %s filename context\n", argv[0]);
-    exit(2);
-  }
-
-  fd = open(argv[1], O_RDONLY, 0);
-  
-  if(fd == -1) {
-    perror("test_lock:open");
-    exit(2);
-  }
-
-  rc = fsetfilecon(fd, argv[2]);
-  if (rc < 0) {
-    perror("test_lock:fsetfilecon");
-    exit(2);
-  }
-
-  rc = flock(fd, LOCK_EX);
-  if( rc == -1 ) {
-    perror("test_lock:LOCK_EX");
-    exit(1);
-  }
-
-  close(fd);
-  exit(0);
+int main(int argc, char **argv)
+{
+
+	int fd;
+	int rc;
+
+	if( argc != 3 ) {
+		printf("usage: %s filename context\n", argv[0]);
+		exit(2);
+	}
+
+	fd = open(argv[1], O_RDONLY, 0);
+
+	if(fd == -1) {
+		perror("test_lock:open");
+		exit(2);
+	}
+
+	rc = fsetfilecon(fd, argv[2]);
+	if (rc < 0) {
+		perror("test_lock:fsetfilecon");
+		exit(2);
+	}
+
+	rc = flock(fd, LOCK_EX);
+	if( rc == -1 ) {
+		perror("test_lock:LOCK_EX");
+		exit(1);
+	}
+
+	close(fd);
+	exit(0);
 
 }
diff --git a/tests/file/test_mmap.c b/tests/file/test_mmap.c
index 5aaf9cf..f864c45 100644
--- a/tests/file/test_mmap.c
+++ b/tests/file/test_mmap.c
@@ -7,44 +7,46 @@
 #include<selinux/selinux.h>
 
 /*
- * Test the mmap file operation on a file whose name is given as the first 
+ * Test the mmap file operation on a file whose name is given as the first
  * argument. The second argument must be the SID we are to use to test
  * the actual mmap() operation by changing the SID of the file we are
  * given.
  */
 
-int main(int argc, char **argv) {
-
-  int fd;
-  void *ptr;
-  int rc;
-
-  if( argc != 3 ) {
-    printf("usage: %s filename context\n", argv[0]);
-    exit(2);
-  }
-
-  fd = open(argv[1], O_RDWR, 0);
-  
-  if(fd == -1) {
-    perror("test_mmap:open");
-    exit(2);
-  }
-
-  rc = fsetfilecon(fd, argv[2]);
-  if (rc < 0) {
-    perror("test_mmap:fsetfilecon");
-    exit(2);
-  }
-
-  ptr = mmap(0, 1024, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED, fd, getpagesize());
-  if( ptr == MAP_FAILED ) {
-    perror("test_mmap:mmap");
-    close(fd);
-    exit(1);
-  }
-
-  close(fd);
-  exit(0);
+int main(int argc, char **argv)
+{
+
+	int fd;
+	void *ptr;
+	int rc;
+
+	if( argc != 3 ) {
+		printf("usage: %s filename context\n", argv[0]);
+		exit(2);
+	}
+
+	fd = open(argv[1], O_RDWR, 0);
+
+	if(fd == -1) {
+		perror("test_mmap:open");
+		exit(2);
+	}
+
+	rc = fsetfilecon(fd, argv[2]);
+	if (rc < 0) {
+		perror("test_mmap:fsetfilecon");
+		exit(2);
+	}
+
+	ptr = mmap(0, 1024, PROT_READ | PROT_WRITE | PROT_EXEC, MAP_SHARED, fd,
+		   getpagesize());
+	if( ptr == MAP_FAILED ) {
+		perror("test_mmap:mmap");
+		close(fd);
+		exit(1);
+	}
+
+	close(fd);
+	exit(0);
 
 }
diff --git a/tests/file/test_mprotect.c b/tests/file/test_mprotect.c
index e440e6d..8a903ad 100644
--- a/tests/file/test_mprotect.c
+++ b/tests/file/test_mprotect.c
@@ -7,50 +7,51 @@
 #include<selinux/selinux.h>
 
 /*
- * Test the mprotect file operation on a file whose name is given as the first 
+ * Test the mprotect file operation on a file whose name is given as the first
  * argument. The second argument must be the SID we are to use to test
  * the actual mprotect() operation by changing the SID of the file we are
  * given.
  */
-int main(int argc, char **argv) {
-
-  int fd;
-  void *ptr;
-  int rc;
-
-  if( argc != 3 ) {
-    printf("usage: %s filename context\n", argv[0]);
-    exit(2);
-  }
-
-  fd = open(argv[1], O_RDONLY, 0);
-  
-  if(fd == -1) {
-    perror("test_mprotect:open");
-    exit(2);
-  }
-
-  ptr = mmap(0, 1024, PROT_READ, MAP_SHARED, fd, getpagesize());
-  if( ptr == MAP_FAILED ) {
-    close(fd);
-    perror("test_mprotect:mmap");
-    exit(2);
-  }
-
-  rc = fsetfilecon(fd, argv[2]);
-  if (rc < 0) {
-    perror("test_mprotect:fsetfilecon");
-    exit(2);
-  }
-
-  rc = mprotect(ptr, 1024, PROT_READ);
-  if( rc == -1 ) {
-    close(fd);
-    perror("test_mprotect:mprotect");
-    exit(1);
-  }
-
-  close(fd);
-  exit(0);
+int main(int argc, char **argv)
+{
+
+	int fd;
+	void *ptr;
+	int rc;
+
+	if( argc != 3 ) {
+		printf("usage: %s filename context\n", argv[0]);
+		exit(2);
+	}
+
+	fd = open(argv[1], O_RDONLY, 0);
+
+	if(fd == -1) {
+		perror("test_mprotect:open");
+		exit(2);
+	}
+
+	ptr = mmap(0, 1024, PROT_READ, MAP_SHARED, fd, getpagesize());
+	if( ptr == MAP_FAILED ) {
+		close(fd);
+		perror("test_mprotect:mmap");
+		exit(2);
+	}
+
+	rc = fsetfilecon(fd, argv[2]);
+	if (rc < 0) {
+		perror("test_mprotect:fsetfilecon");
+		exit(2);
+	}
+
+	rc = mprotect(ptr, 1024, PROT_READ);
+	if( rc == -1 ) {
+		close(fd);
+		perror("test_mprotect:mprotect");
+		exit(1);
+	}
+
+	close(fd);
+	exit(0);
 
 }
diff --git a/tests/file/test_nofcntl.c b/tests/file/test_nofcntl.c
index 32853f6..3554dec 100644
--- a/tests/file/test_nofcntl.c
+++ b/tests/file/test_nofcntl.c
@@ -6,48 +6,49 @@
 #include <unistd.h>
 
 /*
- * Test the fcntl file operation on a file whose name is given as the first 
+ * Test the fcntl file operation on a file whose name is given as the first
  * argument. This program expects certain tests to fail, and that failure
  * is treated as success and the program continues.
  */
-int main(int argc, char **argv) {
-
-  int fd;
-  int rc;
-  struct flock my_lock;
-
-  if( argc != 2 ) {
-    printf("usage: %s filename\n", argv[0]);
-    exit(2);
-  }
-
-  fd = open(argv[1], O_RDONLY | O_APPEND, 0);
-  
-  if(fd == -1) {
-    perror("test_nofcntl:open");
-    exit(2);
-  }
-
-  /* The next two acesses should fail, so if that happens, we return success. */
-
-  rc = fcntl(fd, F_SETFL, 0);
-  if( rc != -1 ) {
-    fprintf(stderr, "test_nofcntl:F_SETFL\n");
-    exit(1);
-  }
-
-  my_lock.l_type = F_RDLCK;
-  my_lock.l_start = 0;
-  my_lock.l_whence = SEEK_CUR;
-  my_lock.l_len = 0;
-
-  rc = fcntl(fd, F_GETLK, &my_lock);
-  if( rc != -1 ) {
-    fprintf(stderr, "test_nofcntl:F_GETLK\n");
-    exit(1);
-  }
-
-  close(fd);
-  exit(0);
+int main(int argc, char **argv)
+{
+
+	int fd;
+	int rc;
+	struct flock my_lock;
+
+	if( argc != 2 ) {
+		printf("usage: %s filename\n", argv[0]);
+		exit(2);
+	}
+
+	fd = open(argv[1], O_RDONLY | O_APPEND, 0);
+
+	if(fd == -1) {
+		perror("test_nofcntl:open");
+		exit(2);
+	}
+
+	/* The next two acesses should fail, so if that happens, we return success. */
+
+	rc = fcntl(fd, F_SETFL, 0);
+	if( rc != -1 ) {
+		fprintf(stderr, "test_nofcntl:F_SETFL\n");
+		exit(1);
+	}
+
+	my_lock.l_type = F_RDLCK;
+	my_lock.l_start = 0;
+	my_lock.l_whence = SEEK_CUR;
+	my_lock.l_len = 0;
+
+	rc = fcntl(fd, F_GETLK, &my_lock);
+	if( rc != -1 ) {
+		fprintf(stderr, "test_nofcntl:F_GETLK\n");
+		exit(1);
+	}
+
+	close(fd);
+	exit(0);
 
 }
diff --git a/tests/file/test_rw.c b/tests/file/test_rw.c
index f56f146..c6836c5 100644
--- a/tests/file/test_rw.c
+++ b/tests/file/test_rw.c
@@ -8,49 +8,50 @@
 #include<selinux/selinux.h>
 
 /*
- * Test the read/write operation on a file whose name is given as the first 
+ * Test the read/write operation on a file whose name is given as the first
  * argument. The second argument must be the SID we are to use to test
  * the actual read/write() operation by changing the SID of the file we are
  * given.
  */
-int main(int argc, char **argv) {
-
-  int fd;
-  int rc;
-  char buf[255];
-  ssize_t bytes;
-
-  if( argc != 3 ) {
-    printf("usage: %s filename context\n", argv[0]);
-    exit(2);
-  }
-
-  fd = open(argv[1], O_RDWR, 0);
-  
-  if(fd == -1) {
-    perror("test_rw:open");
-    exit(2);
-  }
-
-  rc = fsetfilecon(fd, argv[2]);
-  if (rc < 0) {
-    perror("test_rw:fsetfilecon");
-    exit(2);
-  }
-
-  bytes = read(fd, buf, sizeof buf);
-  if( bytes < 0) {
-    perror("test_rw:read");
-    exit(1);
-  }
-  
-  bytes = write(fd, buf, bytes);
-  if( bytes < 0) {
-    perror("test_rw:write");
-    exit(1);
-  }
-
-  close(fd);
-  exit(0);
+int main(int argc, char **argv)
+{
+
+	int fd;
+	int rc;
+	char buf[255];
+	ssize_t bytes;
+
+	if( argc != 3 ) {
+		printf("usage: %s filename context\n", argv[0]);
+		exit(2);
+	}
+
+	fd = open(argv[1], O_RDWR, 0);
+
+	if(fd == -1) {
+		perror("test_rw:open");
+		exit(2);
+	}
+
+	rc = fsetfilecon(fd, argv[2]);
+	if (rc < 0) {
+		perror("test_rw:fsetfilecon");
+		exit(2);
+	}
+
+	bytes = read(fd, buf, sizeof buf);
+	if( bytes < 0) {
+		perror("test_rw:read");
+		exit(1);
+	}
+
+	bytes = write(fd, buf, bytes);
+	if( bytes < 0) {
+		perror("test_rw:write");
+		exit(1);
+	}
+
+	close(fd);
+	exit(0);
 
 }
diff --git a/tests/file/test_seek.c b/tests/file/test_seek.c
index d10fdb4..bb0bef4 100644
--- a/tests/file/test_seek.c
+++ b/tests/file/test_seek.c
@@ -7,34 +7,35 @@
 #include<linux/unistd.h>
 
 /*
- * Test the seek file operation on a file whose name is given as the first 
- * argument. 
+ * Test the seek file operation on a file whose name is given as the first
+ * argument.
  */
-int main(int argc, char **argv) {
-
-  int fd;
-  int rc;
-
-  if( argc != 2 ) {
-    printf("usage: %s filename\n", argv[0]);
-    exit(2);
-  }
-
-  fd = open(argv[1], O_RDONLY, 0);
-  
-  if(fd == -1) {
-    perror("test_seek:open");
-    exit(2);
-  }
-
-  rc = lseek(fd, 10, SEEK_SET);
-  if( rc == -1 ) {
-    perror("test_seek:lseek");
-    close(fd);
-    exit(1);
-  }
-
-  close(fd);
-  exit(0);
+int main(int argc, char **argv)
+{
+
+	int fd;
+	int rc;
+
+	if( argc != 2 ) {
+		printf("usage: %s filename\n", argv[0]);
+		exit(2);
+	}
+
+	fd = open(argv[1], O_RDONLY, 0);
+
+	if(fd == -1) {
+		perror("test_seek:open");
+		exit(2);
+	}
+
+	rc = lseek(fd, 10, SEEK_SET);
+	if( rc == -1 ) {
+		perror("test_seek:lseek");
+		close(fd);
+		exit(1);
+	}
+
+	close(fd);
+	exit(0);
 
 }
diff --git a/tests/file/test_sigiotask.c b/tests/file/test_sigiotask.c
index 7f50217..b10b87d 100644
--- a/tests/file/test_sigiotask.c
+++ b/tests/file/test_sigiotask.c
@@ -20,104 +20,104 @@
  * for SIGIO signals for the terminal. The main process forces a SIGIO
  * on the terminal by sending a charcter to that device.
  */
-int main(int argc, char **argv) {
+int main(int argc, char **argv)
+{
 
-  int fd;
-  int rc;
-  int flags;
-  pid_t pid;
-  char key = '\r';
+	int fd;
+	int rc;
+	int flags;
+	pid_t pid;
+	char key = '\r';
 
-  /*
-   * ctermid returns controlling terminal, which could be console, pts,..
-   * It may not be present in some situations, e.g. running in automated test
-   * environment, where init/service spawning this test has not ctty:
-   * if (fork() > 0) {
-   *   _exit(0);
-   * }
-   * setsid();
-   */
-  pid_t ret;
-  int master, slave;
+	/*
+	 * ctermid returns controlling terminal, which could be console, pts,..
+	 * It may not be present in some situations, e.g. running in automated test
+	 * environment, where init/service spawning this test has not ctty:
+	 * if (fork() > 0) {
+	 *   _exit(0);
+	 * }
+	 * setsid();
+	 */
+	pid_t ret;
+	int master, slave;
 
-  ret = openpty(&master, &slave, NULL, NULL, NULL);
-  if (ret == -1)
-  {
-    perror("test_sigiotask:openpty");
-    exit(2);
-  }
-  fd = slave;
+	ret = openpty(&master, &slave, NULL, NULL, NULL);
+	if (ret == -1) {
+		perror("test_sigiotask:openpty");
+		exit(2);
+	}
+	fd = slave;
 
- /*
-  * Spawn off the child process to handle the information protocol.
-  */
-  if( (pid = fork()) < 0 ) {
-     perror("test_sigiotask:fork");
-     exit(2);
-  }
+	/*
+	 * Spawn off the child process to handle the information protocol.
+	 */
+	if( (pid = fork()) < 0 ) {
+		perror("test_sigiotask:fork");
+		exit(2);
+	}
 
- /*
-  * child process
-  */
-  if( pid == 0 ) {
-    char ex_name[255];
-    /* Create the path to the executable the child will run */
-    sprintf(ex_name, "%s/wait_io", dirname(strdup(argv[0])));
-    if( execl(ex_name, "wait_io", (char *) 0) < 0 ) {
-      perror("test_sigiotask:execl");
-      exit(2);
-    }
-  }
+	/*
+	 * child process
+	 */
+	if( pid == 0 ) {
+		char ex_name[255];
+		/* Create the path to the executable the child will run */
+		sprintf(ex_name, "%s/wait_io", dirname(strdup(argv[0])));
+		if( execl(ex_name, "wait_io", (char *) 0) < 0 ) {
+			perror("test_sigiotask:execl");
+			exit(2);
+		}
+	}
 
-  /* Allow the child time to start up.
-   * If the fcntls below occurs before child sets up its signal handler
-   * and there is some new data on tty then it will die by SIGIO.
-   * Example 1: fd is /dev/console and kernel prints message to it
-   * Example 2: if you run it through ptrace, ptrace will print to the same fd
-   */
-  sleep(1);
+	/* Allow the child time to start up.
+	 * If the fcntls below occurs before child sets up its signal handler
+	 * and there is some new data on tty then it will die by SIGIO.
+	 * Example 1: fd is /dev/console and kernel prints message to it
+	 * Example 2: if you run it through ptrace, ptrace will print to the same fd
+	 */
+	sleep(1);
 
-  /*
-   * parent process
-   */
-  rc = fcntl(fd, F_SETSIG, 0);
-  if( rc == -1 ) {
-    perror("test_sigiotask:F_SETSIG");
-    exit(2);
-  }
+	/*
+	 * parent process
+	 */
+	rc = fcntl(fd, F_SETSIG, 0);
+	if( rc == -1 ) {
+		perror("test_sigiotask:F_SETSIG");
+		exit(2);
+	}
 
-  rc = fcntl(fd, F_SETOWN, pid);
-  if( rc == -1 ) {
-    perror("test_sigiotask:F_SETOWN");
-    exit(2);
-  }
+	rc = fcntl(fd, F_SETOWN, pid);
+	if( rc == -1 ) {
+		perror("test_sigiotask:F_SETOWN");
+		exit(2);
+	}
 
-  flags = fcntl(fd, F_GETFL, 0);
-  if( flags < 0 ) {
-    perror("test_sigiotask:F_GETFL");
-    exit(2);
-  }
-  flags |= O_ASYNC;
-  rc = fcntl(fd, F_SETFL, flags);
-  if( rc == -1 ) {
-    perror("test_sigiotask:F_SETFL");
-    exit(2);
-  }
+	flags = fcntl(fd, F_GETFL, 0);
+	if( flags < 0 ) {
+		perror("test_sigiotask:F_GETFL");
+		exit(2);
+	}
+	flags |= O_ASYNC;
+	rc = fcntl(fd, F_SETFL, flags);
+	if( rc == -1 ) {
+		perror("test_sigiotask:F_SETFL");
+		exit(2);
+	}
 
-  rc = ioctl(fd, TIOCSTI, &key);  /* Send a key to the tty device */
-  if( rc == -1 ) {
-    perror("test_sigiotask:write");
-    exit(2);
-  }
-  close(fd);
-  wait(&rc);
-  if( WIFEXITED(rc) ) {   /* exit status from child is normal? */
-    printf("%s:  child exited OK %d\n", argv[0], WIFEXITED(rc));
-    printf("%s:  exiting with %d\n", argv[0], WEXITSTATUS(rc));
-    exit(WEXITSTATUS(rc));
-  } else {
-    printf("%s:  error exit\n", argv[0]);
-    exit(1);
-  }
+	rc = ioctl(fd, TIOCSTI, &key);  /* Send a key to the tty device */
+	if( rc == -1 ) {
+		perror("test_sigiotask:write");
+		exit(2);
+	}
+	close(fd);
+	wait(&rc);
+	if( WIFEXITED(rc) ) {   /* exit status from child is normal? */
+		printf("%s:  child exited OK %d\n", argv[0], WIFEXITED(rc));
+		printf("%s:  exiting with %d\n", argv[0], WEXITSTATUS(rc));
+		exit(WEXITSTATUS(rc));
+	} else {
+		printf("%s:  error exit\n", argv[0]);
+		exit(1);
+	}
 
 }
diff --git a/tests/file/wait_io.c b/tests/file/wait_io.c
index 94729e7..5a55ab8 100644
--- a/tests/file/wait_io.c
+++ b/tests/file/wait_io.c
@@ -6,28 +6,30 @@
 /*
  * Function to handle SIGIO.
  */
-static void sig_io(int signo) {
-  printf("wait_io:  got sigio\n");
-  exit(0);
+static void sig_io(int signo)
+{
+	printf("wait_io:  got sigio\n");
+	exit(0);
 }
 
 /*
  * This program waits either for a SIGIO signal, or will time out. The
  * exit status is 'good' on the SIGIO receive, 'bad' on the timeout.
  */
-int main(int argc, char **argv) {
+int main(int argc, char **argv)
+{
 
-  struct sigaction siga;
+	struct sigaction siga;
 
-  /*
-   * Set up signal handler for SIGIO.
-   */
-   siga.sa_handler = sig_io;
-   sigemptyset(&siga.sa_mask);
-   siga.sa_flags = 0;
-   sigaction(SIGIO, &siga, NULL);
-   sleep(5);
-   printf("wait_io:  exiting without receiving sigio\n");
-   exit(1);
+	/*
+	 * Set up signal handler for SIGIO.
+	 */
+	siga.sa_handler = sig_io;
+	sigemptyset(&siga.sa_mask);
+	siga.sa_flags = 0;
+	sigaction(SIGIO, &siga, NULL);
+	sleep(5);
+	printf("wait_io:  exiting without receiving sigio\n");
+	exit(1);
 
 }
diff --git a/tests/inherit/child.c b/tests/inherit/child.c
index de6045e..24f6621 100644
--- a/tests/inherit/child.c
+++ b/tests/inherit/child.c
@@ -4,7 +4,7 @@
 #include <stdlib.h>
 #include <string.h>
 
-int main(int argc, char **argv) 
+int main(int argc, char **argv)
 {
 	char buf[255];
 	ssize_t bytes;
diff --git a/tests/inherit/parent.c b/tests/inherit/parent.c
index beb65ef..be48b79 100644
--- a/tests/inherit/parent.c
+++ b/tests/inherit/parent.c
@@ -6,7 +6,7 @@
 #include <selinux/selinux.h>
 #include <selinux/context.h>
 
-int main(int argc, char **argv) 
+int main(int argc, char **argv)
 {
 	char **childargv;
 	security_context_t context_s;
@@ -30,12 +30,12 @@ int main(int argc, char **argv)
 		fprintf(stderr, "%s:  unable to create context structure\n", argv[0]);
 		exit(-1);
 	}
-	
+
 	if (context_type_set(context, argv[1])) {
 		fprintf(stderr, "%s:  unable to set new type\n", argv[0]);
 		exit(-1);
 	}
-	
+
 	freecon(context_s);
 	context_s = context_str(context);
 	if (!context_s) {
@@ -55,7 +55,7 @@ int main(int argc, char **argv)
 		exit(-1);
 	}
 
-	childargv = malloc(3*sizeof(char*));
+	childargv = malloc(3 * sizeof(char *));
 	if (!childargv) {
 		fprintf(stderr, "%s:  out of memory\n", argv[0]);
 		exit(-1);
@@ -73,7 +73,7 @@ int main(int argc, char **argv)
 	sprintf(childargv[1], "%d", fd);
 	childargv[2] = NULL;
 
-	execv(childargv[0],childargv);
+	execv(childargv[0], childargv);
 	perror(childargv[0]);
 	exit(-1);
 }
diff --git a/tests/ioctl/test_ioctl.c b/tests/ioctl/test_ioctl.c
index a0fe365..366d09c 100644
--- a/tests/ioctl/test_ioctl.c
+++ b/tests/ioctl/test_ioctl.c
@@ -13,56 +13,57 @@
  * argument. This program expects the domain it is running under to have
  * wide access to the given file.
  */
-int main(int argc, char **argv) {
+int main(int argc, char **argv)
+{
 
-  int fd;
-  int rc;
-  int val = 0;
+	int fd;
+	int rc;
+	int val = 0;
 
-  fd = open(argv[1], O_RDONLY, 0);
- 
-  if(fd == -1) {
-    perror("test_ioctl:open");
-    exit(1);
-  }
+	fd = open(argv[1], O_RDONLY, 0);
 
-  /* This one should hit the FILE__GETATTR or FILE__IOCTL test */
-  rc = ioctl(fd, FIGETBSZ, &val);
-  if( rc < 0 ) {
-    perror("test_ioctl:FIGETBSZ");
-    exit(1);
-  }
+	if(fd == -1) {
+		perror("test_ioctl:open");
+		exit(1);
+	}
 
-  /* This one should hit the FILE__IOCTL test */
-  rc = ioctl(fd, FIOCLEX);
-  if( rc < 0 ) {
-    perror("test_ioctl:FIOCLEX");
-    exit(1);
-  }
+	/* This one should hit the FILE__GETATTR or FILE__IOCTL test */
+	rc = ioctl(fd, FIGETBSZ, &val);
+	if( rc < 0 ) {
+		perror("test_ioctl:FIGETBSZ");
+		exit(1);
+	}
 
-  /* This one should hit the FD__USE or FILE__IOCTL test */
-  rc = ioctl(fd, FIONBIO, &val);
-  if( rc < 0 ) {
-    perror("test_ioctl:FIONBIO");
-    exit(1);
-  }
+	/* This one should hit the FILE__IOCTL test */
+	rc = ioctl(fd, FIOCLEX);
+	if( rc < 0 ) {
+		perror("test_ioctl:FIOCLEX");
+		exit(1);
+	}
 
-  /* This one should hit the FILE__GETATTR or FILE__READ test */
-  rc = ioctl(fd, FS_IOC_GETVERSION, &val);
-  if( rc < 0 && errno != ENOTTY) {
-    perror("test_ioctl:FS_IOC_GETVERSION");
-    exit(1);
-  }
+	/* This one should hit the FD__USE or FILE__IOCTL test */
+	rc = ioctl(fd, FIONBIO, &val);
+	if( rc < 0 ) {
+		perror("test_ioctl:FIONBIO");
+		exit(1);
+	}
 
-  /* This one should hit the FILE__SETATTR or FILE__WRITE test */
-  val = 0;
-  rc = ioctl(fd, FS_IOC_SETVERSION, &val);
-  if( rc < 0 && errno != ENOTTY) {
-    perror("test_ioctl:FS_IOC_SETVERSION");
-    exit(1);
-  }
+	/* This one should hit the FILE__GETATTR or FILE__READ test */
+	rc = ioctl(fd, FS_IOC_GETVERSION, &val);
+	if( rc < 0 && errno != ENOTTY) {
+		perror("test_ioctl:FS_IOC_GETVERSION");
+		exit(1);
+	}
 
-  close(fd);
-  exit(0);
+	/* This one should hit the FILE__SETATTR or FILE__WRITE test */
+	val = 0;
+	rc = ioctl(fd, FS_IOC_SETVERSION, &val);
+	if( rc < 0 && errno != ENOTTY) {
+		perror("test_ioctl:FS_IOC_SETVERSION");
+		exit(1);
+	}
+
+	close(fd);
+	exit(0);
 
 }
diff --git a/tests/ioctl/test_noioctl.c b/tests/ioctl/test_noioctl.c
index f615054..ddce457 100644
--- a/tests/ioctl/test_noioctl.c
+++ b/tests/ioctl/test_noioctl.c
@@ -20,73 +20,75 @@
  * This program expects the domain it is running as to have only read
  * acess to the given file.
  */
-int main(int argc, char **argv) {
-  struct utsname uts;
-  int fd;
-  int rc, useaccessmode = 1;
-  int val;
+int main(int argc, char **argv)
+{
+	struct utsname uts;
+	int fd;
+	int rc, useaccessmode = 1;
+	int val;
 
-  if (uname(&uts) < 0) {
-    perror("uname");
-    exit(1);
-  }
+	if (uname(&uts) < 0) {
+		perror("uname");
+		exit(1);
+	}
 
-  if (strverscmp(uts.release, "2.6.27") >= 0 && strverscmp(uts.release, "2.6.39") < 0)
-    useaccessmode = 0;
+	if (strverscmp(uts.release, "2.6.27") >= 0 &&
+	    strverscmp(uts.release, "2.6.39") < 0)
+		useaccessmode = 0;
 
-  fd = open(argv[1], O_RDONLY, 0);
- 
-  if(fd == -1) {
-    perror("test_noioctl:open");
-    exit(1);
-  }
+	fd = open(argv[1], O_RDONLY, 0);
 
-  /* This one should hit the FILE__IOCTL or FILE__GETATTR test and fail. */
-  rc = ioctl(fd, FIGETBSZ, &val);
-  if( rc == 0 ) {
-      printf("test_noioctl:FIGETBSZ");
-      exit(1);
-  }
+	if(fd == -1) {
+		perror("test_noioctl:open");
+		exit(1);
+	}
 
-  /* This one should hit the FILE__IOCTL test and fail. */
-  rc = ioctl(fd, FIOCLEX);
-  if( rc == 0 ) {
-    printf("test_noioctl:FIOCLEX");
-    exit(1);
-  }
+	/* This one should hit the FILE__IOCTL or FILE__GETATTR test and fail. */
+	rc = ioctl(fd, FIGETBSZ, &val);
+	if( rc == 0 ) {
+		printf("test_noioctl:FIGETBSZ");
+		exit(1);
+	}
 
-  /*
-   * This one depends on kernel version:
-   * >= 2.6.27 and < 2.6.39:  Should hit the FILE__IOCTL test and fail.
-   * < 2.6.27 or >= 2.6.39:  Should only check FD__USE and succeed.
-   */
-  rc = ioctl(fd, FIONBIO, &val);
-  if( !rc == !useaccessmode ) {
-    printf("test_noioctl:FIONBIO");
-    exit(1);
-  }
+	/* This one should hit the FILE__IOCTL test and fail. */
+	rc = ioctl(fd, FIOCLEX);
+	if( rc == 0 ) {
+		printf("test_noioctl:FIOCLEX");
+		exit(1);
+	}
 
-  /*
-   * This one depends on kernel version:
-   * New:  Should hit the FILE__READ test and succeed.
-   * Old:  Should hit the FILE__GETATTR test and fail.
-   */
-  rc = ioctl(fd, FS_IOC_GETVERSION, &val);
-  if( (useaccessmode && rc == 0) ||
-      (!useaccessmode && rc < 0 && errno != ENOTTY) ) {
-    perror("test_noioctl:FS_IOC_GETVERSION");
-    exit(1);
-  }
+	/*
+	 * This one depends on kernel version:
+	 * >= 2.6.27 and < 2.6.39:  Should hit the FILE__IOCTL test and fail.
+	 * < 2.6.27 or >= 2.6.39:  Should only check FD__USE and succeed.
+	 */
+	rc = ioctl(fd, FIONBIO, &val);
+	if( !rc == !useaccessmode ) {
+		printf("test_noioctl:FIONBIO");
+		exit(1);
+	}
 
-  /* This one should hit the FILE__WRITE or FILE_SETATTR test and fail. */
-  val = 0;
-  rc = ioctl(fd, FS_IOC_SETVERSION, &val);
-  if( rc == 0 ) {
-    perror("test_noioctl:FS_IOC_SETVERSION");
-    exit(1);
-  }
+	/*
+	 * This one depends on kernel version:
+	 * New:  Should hit the FILE__READ test and succeed.
+	 * Old:  Should hit the FILE__GETATTR test and fail.
+	 */
+	rc = ioctl(fd, FS_IOC_GETVERSION, &val);
+	if( (useaccessmode && rc == 0) ||
+	    (!useaccessmode && rc < 0 && errno != ENOTTY) ) {
+		perror("test_noioctl:FS_IOC_GETVERSION");
+		exit(1);
+	}
 
-  close(fd);
-  exit(0);
+	/* This one should hit the FILE__WRITE or FILE_SETATTR test and fail. */
+	val = 0;
+	rc = ioctl(fd, FS_IOC_SETVERSION, &val);
+	if( rc == 0 ) {
+		perror("test_noioctl:FS_IOC_SETVERSION");
+		exit(1);
+	}
+
+	close(fd);
+	exit(0);
 
 }
diff --git a/tests/msg/msgctl.c b/tests/msg/msgctl.c
index 56e2955..9818f0a 100644
--- a/tests/msg/msgctl.c
+++ b/tests/msg/msgctl.c
@@ -20,7 +20,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	id = msgget(key, IPC_CREAT|0444);
+	id = msgget(key, IPC_CREAT | 0444);
 	if (id == -1)
 		return 1;
 
@@ -31,14 +31,14 @@ int main(int argc, char **argv)
 	error = msgctl(id, IPC_STAT, &buf);
 	printf ("%d", error);
 
-	/* 
+	/*
 	 * Equivalent: IPC_SET
 	 * Tests:      MSGQ__SETATTR
 	 */
 	error = msgctl(id, IPC_SET, &buf);
 	printf (" %d", error);
-	
-	/* 
+
+	/*
 	 * Equivalent: IPC_RMID
 	 * Tests:      MSGQ__DESTROY
 	 */
diff --git a/tests/msg/msgget.c b/tests/msg/msgget.c
index 44f37d0..c840ad4 100644
--- a/tests/msg/msgget.c
+++ b/tests/msg/msgget.c
@@ -23,9 +23,9 @@ int main(int argc, char **argv)
 
 	}
 
-	id = msgget(key, IPC_CREAT|perms);
+	id = msgget(key, IPC_CREAT | perms);
 	if (id == -1)
-	  return 1;
+		return 1;
 	printf("msgget succeeded: key = %d, id = %d\n", key, id);
 
 	return 0;
diff --git a/tests/msg/msgrcv.c b/tests/msg/msgrcv.c
index 285dcad..5ed203a 100644
--- a/tests/msg/msgrcv.c
+++ b/tests/msg/msgrcv.c
@@ -22,9 +22,9 @@ int main(int argc, char **argv)
 		}
 	}
 
-	id = msgget(key, IPC_CREAT|0777);
+	id = msgget(key, IPC_CREAT | 0777);
 	if (id == -1)
-	  return 1;
+		return 1;
 
 	error = msgrcv(id, &msgp, MSGMAX, 1, IPC_NOWAIT);
 	printf("msgrcv: result = %d\n", error);
diff --git a/tests/msg/msgsnd.c b/tests/msg/msgsnd.c
index 7204ab6..e73bc63 100644
--- a/tests/msg/msgsnd.c
+++ b/tests/msg/msgsnd.c
@@ -23,7 +23,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	id = msgget(key, IPC_CREAT|0777);
+	id = msgget(key, IPC_CREAT | 0777);
 	if (id == -1)
 		return 1;
 
diff --git a/tests/nnp/execnnp.c b/tests/nnp/execnnp.c
index 756c2d0..8421df4 100644
--- a/tests/nnp/execnnp.c
+++ b/tests/nnp/execnnp.c
@@ -25,7 +25,7 @@ int main(int argc, char **argv)
 		exit(-1);
 	}
 
-	nobounded = ((strcmp(argv[argc-1], "test_nnp_bounded_t") == 0) &&
+	nobounded = ((strcmp(argv[argc - 1], "test_nnp_bounded_t") == 0) &&
 		     (strverscmp(uts.release, "3.18") < 0));
 
 	rc = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
@@ -51,7 +51,8 @@ int main(int argc, char **argv)
 		if (nobounded) {
 			if (!WEXITSTATUS(status))
 				exit(-1);
-			printf("%s:  Kernels < v3.18 do not support bounded transitions under NNP.\n", argv[0]);
+			printf("%s:  Kernels < v3.18 do not support bounded transitions under NNP.\n",
+			       argv[0]);
 			/* pass the test */
 			exit(0);
 		}
diff --git a/tests/open/append2write.c b/tests/open/append2write.c
index 1dd6206..bcb19b1 100644
--- a/tests/open/append2write.c
+++ b/tests/open/append2write.c
@@ -5,7 +5,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 
-int main(int argc, char **argv) 
+int main(int argc, char **argv)
 {
 	int fd, rc;
 
diff --git a/tests/open/fopen.c b/tests/open/fopen.c
index 743265d..b382074 100644
--- a/tests/open/fopen.c
+++ b/tests/open/fopen.c
@@ -5,7 +5,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 
-int main(int argc, char **argv) 
+int main(int argc, char **argv)
 {
 	FILE *fp;
 	if (argc != 3) {
diff --git a/tests/ptrace/ptrace.c b/tests/ptrace/ptrace.c
index 1b09654..ea92570 100644
--- a/tests/ptrace/ptrace.c
+++ b/tests/ptrace/ptrace.c
@@ -4,24 +4,24 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 
-int main(int argc,char **argv){
-  int rc;
-  int pid;
-  pid=atoi(argv[1]);
-  
-  rc=ptrace(PTRACE_ATTACH,pid,0,0);
-  
-  if(rc<0){
-    exit(1);
-  }
-  else{
-    wait(NULL);
-    rc = ptrace(PTRACE_DETACH,pid,0,0);
-    if (rc < 0) {
-      perror("PTRACE_DETACH");
-      exit(1);
-    }
-  }
-  exit(0);
+int main(int argc, char **argv)
+{
+	int rc;
+	int pid;
+	pid = atoi(argv[1]);
+
+	rc = ptrace(PTRACE_ATTACH, pid, 0, 0);
+
+	if(rc < 0) {
+		exit(1);
+	} else {
+		wait(NULL);
+		rc = ptrace(PTRACE_DETACH, pid, 0, 0);
+		if (rc < 0) {
+			perror("PTRACE_DETACH");
+			exit(1);
+		}
+	}
+	exit(0);
 }
 
diff --git a/tests/sem/semctl.c b/tests/sem/semctl.c
index 765095d..476aadd 100644
--- a/tests/sem/semctl.c
+++ b/tests/sem/semctl.c
@@ -37,7 +37,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	id = semget(key, num, IPC_CREAT|0777);
+	id = semget(key, num, IPC_CREAT | 0777);
 	if (id == -1)
 		return 1;
 
@@ -49,21 +49,21 @@ int main(int argc, char **argv)
 	error = semctl(id, 0, IPC_STAT, arg);
 	printf ("%d", error);
 
-	/* 
-	 * Equivalent: GETPID, GETNCNT, GETZCNT 
+	/*
+	 * Equivalent: GETPID, GETNCNT, GETZCNT
 	 * Tests:      SEM__GETATTR
 	 */
 	error = semctl(id, 0, GETPID, NULL);
 	printf (" %d", error);
 
-	/* 
+	/*
 	 * Equivalent: GETVAL, GETALL
 	 * Tests:      SEM__READ
 	 */
 	error = semctl(id, 0, GETVAL, NULL);
 	printf (" %d", error);
 
-	/* 
+	/*
 	 * Equivalent: SETVAL, SETALL
 	 * Tests:      SEM__WRITE
 	 */
@@ -71,15 +71,15 @@ int main(int argc, char **argv)
 	error = semctl(id, 0, SETVAL, arg);
 	printf (" %d", error);
 
-	/* 
+	/*
 	 * Equivalent: IPC_SET
 	 * Tests:      SEM__SETATTR
 	 */
 	arg.buf = &semid_buf;
 	error = semctl(id, 0, IPC_SET, arg);
 	printf (" %d", error);
-	
-	/* 
+
+	/*
 	 * Equivalent: IPC_RMID
 	 * Tests:      SEM__DESTROY
 	 */
diff --git a/tests/sem/semget.c b/tests/sem/semget.c
index 0d86c67..065d538 100644
--- a/tests/sem/semget.c
+++ b/tests/sem/semget.c
@@ -22,7 +22,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	id = semget(key, num, IPC_CREAT|0777);
+	id = semget(key, num, IPC_CREAT | 0777);
 	if (id == -1)
 		return 1;
 	printf("semget succeeded: key = %d, id = %d\n", key, id);
diff --git a/tests/sem/semop.c b/tests/sem/semop.c
index c65e59e..fee5e64 100644
--- a/tests/sem/semop.c
+++ b/tests/sem/semop.c
@@ -24,7 +24,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	id = semget(key, num, IPC_CREAT|0777);
+	id = semget(key, num, IPC_CREAT | 0777);
 	if (id == -1)
 		return 1;
 
diff --git a/tests/setnice/child.c b/tests/setnice/child.c
index ad6db09..207a273 100644
--- a/tests/setnice/child.c
+++ b/tests/setnice/child.c
@@ -2,22 +2,22 @@
 #include <stdlib.h>
 #include <stdio.h>
 
-int main(void) 
+int main(void)
 {
-  char buf[1];
-  int rc;
+	char buf[1];
+	int rc;
 
-  buf[0] = 0;
-  rc = write(1, buf, sizeof buf);
-  if (rc < 0) {
-    perror("write");
-    exit(-1);
-  }
-  rc = read(0, buf, sizeof buf);
-  if (rc < 0) {
-    perror("read");
-    exit(-1);
-  }  
-  exit(0);
+	buf[0] = 0;
+	rc = write(1, buf, sizeof buf);
+	if (rc < 0) {
+		perror("write");
+		exit(-1);
+	}
+	rc = read(0, buf, sizeof buf);
+	if (rc < 0) {
+		perror("read");
+		exit(-1);
+	}
+	exit(0);
 }
 
diff --git a/tests/setnice/parent.c b/tests/setnice/parent.c
index 6d3c855..b010aa0 100644
--- a/tests/setnice/parent.c
+++ b/tests/setnice/parent.c
@@ -12,95 +12,95 @@
 
 int main(int argc, char **argv)
 {
-  char buf[1];
-  int pid, rc, rc2, fd[2], fd2[2];
-  security_context_t context_s;
-  context_t context;
-  
-  if (argc != 3) {
-    fprintf(stderr, "usage:  %s newdomain program\n", argv[0]);
-    exit(-1);
-  }
-  
-  rc = getcon(&context_s);
-  if (rc < 0) {
-    fprintf(stderr, "%s:  unable to get my context\n", argv[0]);
-    exit(-1);
-    
-  }
-  
-  context = context_new(context_s);
-  if (!context) {
-    fprintf(stderr, "%s:  unable to create context structure\n", argv[0]);
-    exit(-1);
-  }
-  
-  if (context_type_set(context, argv[1])) {
-    fprintf(stderr, "%s:  unable to set new type\n", argv[0]);
-    exit(-1);
-  }
-  
-  freecon(context_s);
-  context_s = context_str(context);
-  if (!context_s) {
-    fprintf(stderr, "%s:  unable to obtain new context string\n", argv[0]);
-    exit(-1); 
-  }
-
-  rc = setexeccon(context_s);
-  if (rc < 0) {
-    fprintf(stderr, "%s:  unable to set exec context to %s\n", argv[0], context_s);
-    exit(-1);
-  }
-  
-  rc = pipe(fd);
-  if (rc < 0) {
-    perror("pipe");
-    exit(-1);
-  }
-
-  rc = pipe(fd2);
-  if (rc < 0) {
-    perror("pipe");
-    exit(-1);
-  }
-
-  pid = fork();
-  if (pid < 0) {
-    perror("fork");
-    exit(-1);
-  } else if (pid == 0) {
-    dup2(fd[0],0);
-    dup2(fd2[1],1);
-    execv(argv[2], argv+2);
-    buf[0] = -1;
-    write(1, buf, sizeof(buf));
-    perror(argv[2]);
-    exit(-1);
-  }
-
-  rc = read(fd2[0], buf, sizeof(buf));
-  if (rc < 0) {
-    perror("read");
-    exit(-1);
-  }
-  
-  if (buf[0]) {
-    fprintf(stderr, "%s:  child died unexpectedly\n", argv[0]);
-    exit(-1);
-  }
-    
-  
-  rc =  setpriority(0,pid,10);
-  rc2 = write(fd[1], buf, sizeof(buf));
-
-  if (rc2 < 0) {
-    perror("write");
-    exit(-1);
-  } 
-  if (rc < 0) {
-    perror("setnice: setnice(pid,pid)");
-    exit(1);
-  }
-  exit(0);
+	char buf[1];
+	int pid, rc, rc2, fd[2], fd2[2];
+	security_context_t context_s;
+	context_t context;
+
+	if (argc != 3) {
+		fprintf(stderr, "usage:  %s newdomain program\n", argv[0]);
+		exit(-1);
+	}
+
+	rc = getcon(&context_s);
+	if (rc < 0) {
+		fprintf(stderr, "%s:  unable to get my context\n", argv[0]);
+		exit(-1);
+
+	}
+
+	context = context_new(context_s);
+	if (!context) {
+		fprintf(stderr, "%s:  unable to create context structure\n", argv[0]);
+		exit(-1);
+	}
+
+	if (context_type_set(context, argv[1])) {
+		fprintf(stderr, "%s:  unable to set new type\n", argv[0]);
+		exit(-1);
+	}
+
+	freecon(context_s);
+	context_s = context_str(context);
+	if (!context_s) {
+		fprintf(stderr, "%s:  unable to obtain new context string\n", argv[0]);
+		exit(-1);
+	}
+
+	rc = setexeccon(context_s);
+	if (rc < 0) {
+		fprintf(stderr, "%s:  unable to set exec context to %s\n", argv[0], context_s);
+		exit(-1);
+	}
+
+	rc = pipe(fd);
+	if (rc < 0) {
+		perror("pipe");
+		exit(-1);
+	}
+
+	rc = pipe(fd2);
+	if (rc < 0) {
+		perror("pipe");
+		exit(-1);
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		perror("fork");
+		exit(-1);
+	} else if (pid == 0) {
+		dup2(fd[0], 0);
+		dup2(fd2[1], 1);
+		execv(argv[2], argv + 2);
+		buf[0] = -1;
+		write(1, buf, sizeof(buf));
+		perror(argv[2]);
+		exit(-1);
+	}
+
+	rc = read(fd2[0], buf, sizeof(buf));
+	if (rc < 0) {
+		perror("read");
+		exit(-1);
+	}
+
+	if (buf[0]) {
+		fprintf(stderr, "%s:  child died unexpectedly\n", argv[0]);
+		exit(-1);
+	}
+
+
+	rc =  setpriority(0, pid, 10);
+	rc2 = write(fd[1], buf, sizeof(buf));
+
+	if (rc2 < 0) {
+		perror("write");
+		exit(-1);
+	}
+	if (rc < 0) {
+		perror("setnice: setnice(pid,pid)");
+		exit(1);
+	}
+	exit(0);
 }
diff --git a/tests/shm/shmat.c b/tests/shm/shmat.c
index 704d676..f236998 100644
--- a/tests/shm/shmat.c
+++ b/tests/shm/shmat.c
@@ -21,12 +21,12 @@ int main(int argc, char **argv)
 		}
 	}
 
-	id = shmget(key, 2048, IPC_CREAT|0777);
+	id = shmget(key, 2048, IPC_CREAT | 0777);
 	if (id == -1)
-	  return 1;
+		return 1;
 
 	buf = shmat(id, 0, 0);
-	error = (buf==(void*)-1)?-1:0;
+	error = (buf == (void *) - 1) ? -1 : 0;
 	printf("shmat: buf=%p, returned %d\n", buf, error);
 	return error;
 }
diff --git a/tests/shm/shmctl.c b/tests/shm/shmctl.c
index d17a804..5aaa1bc 100644
--- a/tests/shm/shmctl.c
+++ b/tests/shm/shmctl.c
@@ -21,10 +21,10 @@ int main(int argc, char **argv)
 		}
 	}
 
-	id = shmget(key, 2048, IPC_CREAT|0777);
+	id = shmget(key, 2048, IPC_CREAT | 0777);
 	if (id == -1)
-	  return 1;
-	
+		return 1;
+
 	/*
 	 * Equivalent: IPC_STAT, SHM_STAT
 	 * Tests:      SHM__GETATTR | SHM__ASSOCIATE
@@ -32,7 +32,7 @@ int main(int argc, char **argv)
 	error = shmctl(id, IPC_STAT, &buf);
 	printf ("%d", error);
 
-	/* 
+	/*
 	 * Equivalent: IPC_SET
 	 * Tests:      SHM__SETATTR
 	 */
@@ -40,14 +40,14 @@ int main(int argc, char **argv)
 	printf (" %d", error);
 
 
-	/* 
+	/*
 	 * Equivalent: SHM_LOCK, SHM_UNLOCK
 	 * Tests:      SHM__LOCK
 	 */
 	error = shmctl(id, SHM_LOCK, NULL);
 	printf (" %d", error);
 
-	/* 
+	/*
 	 * Equivalent: IPC_RMID
 	 * Tests:      SHM__DESTROY
 	 */
diff --git a/tests/shm/shmget.c b/tests/shm/shmget.c
index 42d6394..b457679 100644
--- a/tests/shm/shmget.c
+++ b/tests/shm/shmget.c
@@ -19,9 +19,9 @@ int main(int argc, char **argv)
 		}
 	}
 
-	id = shmget(key, 2048, IPC_CREAT|0777);
+	id = shmget(key, 2048, IPC_CREAT | 0777);
 	if (id == -1)
-	  return 1;
+		return 1;
 	printf("shmget succeeded: key = %d, id = %d\n", key, id);
 
 	return 0;
diff --git a/tests/sigkill/server.c b/tests/sigkill/server.c
index 3250067..291d38a 100644
--- a/tests/sigkill/server.c
+++ b/tests/sigkill/server.c
@@ -7,18 +7,18 @@ void handler(int sig)
 	return;
 }
 
-int main(void) 
+int main(void)
 {
-  struct sigaction sa;
-  int i;
+	struct sigaction sa;
+	int i;
 
-  sa.sa_handler = handler;
-  sigemptyset(&sa.sa_mask);
-  sa.sa_flags = 0;
-  for (i = 0; i < 32; i++) {
-	  sigaction(i, &sa, NULL);
-  }
-	
-  while (1)
-	  ;
+	sa.sa_handler = handler;
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags = 0;
+	for (i = 0; i < 32; i++) {
+		sigaction(i, &sa, NULL);
+	}
+
+	while (1)
+		;
 }
diff --git a/tests/socket/noaccept.c b/tests/socket/noaccept.c
index d203383..7223621 100644
--- a/tests/socket/noaccept.c
+++ b/tests/socket/noaccept.c
@@ -78,7 +78,7 @@ main(int argc, char **argv)
 
 	printf("Changing socket sid back to %d\n", outsid);
 	(void)fchsid(sock, outsid);
-	
+
 	printf("remote == %d\n", remote);
 
 	shutdown(sock, 2);
diff --git a/tests/socket/options.c b/tests/socket/options.c
index 4117780..6f85b9b 100644
--- a/tests/socket/options.c
+++ b/tests/socket/options.c
@@ -67,9 +67,9 @@ main(int argc, char **argv)
 				perror("poll: ");
 				return -1;
 			} else if (result == 0) {
-				/* 
-				 * connect is taking too long, 
-				 * it's probably not going to work 
+				/*
+				 * connect is taking too long,
+				 * it's probably not going to work
 				 */
 				printf("poll: no events are ready\n");
 				return -1;
diff --git a/tests/socket/sink.c b/tests/socket/sink.c
index 4720869..acca6bf 100644
--- a/tests/socket/sink.c
+++ b/tests/socket/sink.c
@@ -80,7 +80,7 @@ main(int argc, char **argv)
 		}
 		while (readbytes > currentbytes) {
 			remote =
-			    accept(sock, (struct sockaddr *) &raddr, &rsize);
+				accept(sock, (struct sockaddr *) &raddr, &rsize);
 			if (remote < 0) {
 				perror("accept: ");
 				close(sock);
diff --git a/tests/socket/source.c b/tests/socket/source.c
index e7932d7..412d2a9 100644
--- a/tests/socket/source.c
+++ b/tests/socket/source.c
@@ -65,9 +65,9 @@ main(int argc, char **argv)
 				perror("poll: ");
 				return -1;
 			} else if (result == 0) {
-				/* 
-				 * connect is taking too long, 
-				 * it's probably not going to work 
+				/*
+				 * connect is taking too long,
+				 * it's probably not going to work
 				 */
 				printf("poll: no events are ready\n");
 				return -1;
diff --git a/tests/task_create/parent.c b/tests/task_create/parent.c
index 21a8360..6cb1303 100644
--- a/tests/task_create/parent.c
+++ b/tests/task_create/parent.c
@@ -8,9 +8,9 @@ int main(void)
 	int pid;
 
 	if ((pid = fork()) < 0) {
-		perror("fork"); 
+		perror("fork");
 		exit(1);
 	}
-	fprintf(stderr,"%d\n",pid);
+	fprintf(stderr, "%d\n", pid);
 	exit(0);
 }
diff --git a/tests/task_getpgid/source.c b/tests/task_getpgid/source.c
index 36ecd47..8181c9b 100644
--- a/tests/task_getpgid/source.c
+++ b/tests/task_getpgid/source.c
@@ -10,15 +10,15 @@ int main(int argc, char *argv[])
 	pid_t pid, group_id;
 
 	if (argc != 2) {
-		fprintf(stderr,"Usage: %s pid\n",argv[0]);
+		fprintf(stderr, "Usage: %s pid\n", argv[0]);
 		exit(-1);
 	}
 	pid = (pid_t) atol(argv[1]);
-	printf("pid = %d \n",pid); 
+	printf("pid = %d \n", pid);
 	if ((group_id = getpgid(pid)) < 0) {
 		perror("getpgid");
 		exit(1);
 	}
-	printf("group ID = %d\n",group_id);
+	printf("group ID = %d\n", group_id);
 	exit(0);
 }
diff --git a/tests/task_getpgid/target.c b/tests/task_getpgid/target.c
index 1cb4ee1..52d910f 100644
--- a/tests/task_getpgid/target.c
+++ b/tests/task_getpgid/target.c
@@ -1,6 +1,6 @@
 #include <unistd.h>
 
-int main(void) 
+int main(void)
 {
 	while (1) {
 		sleep(1);
diff --git a/tests/task_getscheduler/source.c b/tests/task_getscheduler/source.c
index 69aef85..2932b10 100644
--- a/tests/task_getscheduler/source.c
+++ b/tests/task_getscheduler/source.c
@@ -9,15 +9,15 @@ int main(int argc, char *argv[])
 	int policy;
 
 	if (argc != 2) {
-		fprintf(stderr,"Usage: %s pid\n",argv[0]);
+		fprintf(stderr, "Usage: %s pid\n", argv[0]);
 		exit(-1);
 	}
 	pid = (pid_t) atol(argv[1]);
-	printf("pid = %d \n",pid); 
+	printf("pid = %d \n", pid);
 	if ((policy = sched_getscheduler(pid)) < 0) {
 		perror("sched_getscheduler");
 		exit(1);
 	}
-	printf("policy = %d\n",policy);
+	printf("policy = %d\n", policy);
 	exit(0);
 }
diff --git a/tests/task_getscheduler/target.c b/tests/task_getscheduler/target.c
index 1cb4ee1..52d910f 100644
--- a/tests/task_getscheduler/target.c
+++ b/tests/task_getscheduler/target.c
@@ -1,6 +1,6 @@
 #include <unistd.h>
 
-int main(void) 
+int main(void)
 {
 	while (1) {
 		sleep(1);
diff --git a/tests/task_getsid/source.c b/tests/task_getsid/source.c
index 5e51a8a..f66e6b5 100644
--- a/tests/task_getsid/source.c
+++ b/tests/task_getsid/source.c
@@ -10,15 +10,15 @@ int main(int argc, char *argv[])
 	pid_t pid, session_id;
 
 	if (argc != 2) {
-		fprintf(stderr,"Usage: %s pid\n",argv[0]);
+		fprintf(stderr, "Usage: %s pid\n", argv[0]);
 		exit(-1);
 	}
 	pid = (pid_t) atol(argv[1]);
-	printf("pid = %d \n",pid); 
+	printf("pid = %d \n", pid);
 	if ((session_id = getsid(pid)) < 0) {
 		perror("getsid");
 		exit(1);
 	}
-	printf("session ID = %d\n",session_id);
+	printf("session ID = %d\n", session_id);
 	exit(0);
 }
diff --git a/tests/task_getsid/target.c b/tests/task_getsid/target.c
index 1cb4ee1..52d910f 100644
--- a/tests/task_getsid/target.c
+++ b/tests/task_getsid/target.c
@@ -1,6 +1,6 @@
 #include <unistd.h>
 
-int main(void) 
+int main(void)
 {
 	while (1) {
 		sleep(1);
diff --git a/tests/task_setnice/target.c b/tests/task_setnice/target.c
index 1cb4ee1..52d910f 100644
--- a/tests/task_setnice/target.c
+++ b/tests/task_setnice/target.c
@@ -1,6 +1,6 @@
 #include <unistd.h>
 
-int main(void) 
+int main(void)
 {
 	while (1) {
 		sleep(1);
diff --git a/tests/task_setpgid/source.c b/tests/task_setpgid/source.c
index 79fe424..3069a6a 100644
--- a/tests/task_setpgid/source.c
+++ b/tests/task_setpgid/source.c
@@ -9,14 +9,14 @@
 int main(void)
 {
 	pid_t pid, group_id;
-	
+
 	pid = getpid();
 	if ((group_id = getpgid(pid)) < 0) {
 		perror("getpgid");
 		exit(-1);
 	}
-	printf("Group ID = %d\n",group_id);
-	if (setpgid(pid,pid) < 0) {
+	printf("Group ID = %d\n", group_id);
+	if (setpgid(pid, pid) < 0) {
 		perror("setpgid");
 		exit(1);
 	}
@@ -24,7 +24,7 @@ int main(void)
 		perror("getpgid");
 		exit(-1);
 	}
-	printf("Group ID = %d\n",group_id);
-	printf("pid = %d\n",pid);
+	printf("Group ID = %d\n", group_id);
+	printf("pid = %d\n", pid);
 	exit(0);
 }
diff --git a/tests/task_setscheduler/source.c b/tests/task_setscheduler/source.c
index 4a91bc8..16869fd 100644
--- a/tests/task_setscheduler/source.c
+++ b/tests/task_setscheduler/source.c
@@ -10,7 +10,7 @@ int main(int argc, char *argv[])
 	struct sched_param p;
 
 	if (argc != 4) {
-		fprintf(stderr,"Usage: %s pid policy priority\n",argv[0]);
+		fprintf(stderr, "Usage: %s pid policy priority\n", argv[0]);
 		exit(-1);
 	}
 	pid = atol(argv[1]);
@@ -20,11 +20,11 @@ int main(int argc, char *argv[])
 	}
 	p.sched_priority = atol(argv[3]);
 	printf("pid = %d \t policy = %d \t priority = %d\n",
-		pid,policy,p.sched_priority); 
-	if (sched_setscheduler(pid,policy,&p) < 0) {
+	       pid, policy, p.sched_priority);
+	if (sched_setscheduler(pid, policy, &p) < 0) {
 		perror("sched_setscheduler");
 		exit(1);
 	}
-		
+
 	exit(0);
 }
diff --git a/tests/task_setscheduler/target.c b/tests/task_setscheduler/target.c
index 1cb4ee1..52d910f 100644
--- a/tests/task_setscheduler/target.c
+++ b/tests/task_setscheduler/target.c
@@ -1,6 +1,6 @@
 #include <unistd.h>
 
-int main(void) 
+int main(void)
 {
 	while (1) {
 		sleep(1);
diff --git a/tests/unix_secure/checksyscalls.c b/tests/unix_secure/checksyscalls.c
index 15df419..face8c4 100644
--- a/tests/unix_secure/checksyscalls.c
+++ b/tests/unix_secure/checksyscalls.c
@@ -17,8 +17,8 @@ main(int argc, char **argv)
 	if (sock < 0) {
 		perror("socket");
 		if (errno == ENOSYS) {
-		  printf("Extended socket system calls are unimplemented\n");
-		  return -1;
+			printf("Extended socket system calls are unimplemented\n");
+			return -1;
 		}
 		return -2;
 	}
diff --git a/tests/unix_secure/client.c b/tests/unix_secure/client.c
index f8c8c4a..755fd93 100644
--- a/tests/unix_secure/client.c
+++ b/tests/unix_secure/client.c
@@ -66,7 +66,7 @@ main(int argc, char **argv)
 		/* printf("connect_secure with peer sid %d\n", peer_sid); */
 	} else {
 		result =
-		    connect(sock, (struct sockaddr *) &sun, sunlen);
+			connect(sock, (struct sockaddr *) &sun, sunlen);
 	}
 	if (result < 0) {
 		if (errno == EINPROGRESS) {
@@ -77,9 +77,9 @@ main(int argc, char **argv)
 				perror("poll: ");
 				return -1;
 			} else if (result == 0) {
-				/* 
-				 * connect is taking too long, 
-				 * it's probably not going to work 
+				/*
+				 * connect is taking too long,
+				 * it's probably not going to work
 				 */
 				printf("poll: no events are ready\n");
 				return -1;
@@ -110,17 +110,17 @@ main(int argc, char **argv)
 	read_sid = atoi(data);
 	if (read_sid != client_sid) {
 		bad++;
-		/* printf("client sid %d, read back sid %d\n", 
+		/* printf("client sid %d, read back sid %d\n",
 		   client_sid, read_sid); */
 	}
 
 	shutdown(sock, 2);
 	close(sock);
 
-	/* 
+	/*
 	 * Return the number of bad connections, where the server
 	 * returned something other than the sid of this client's
-	 * socket 
+	 * socket
 	 */
 	return (bad);
 }
diff --git a/tests/unix_socket/unix_options.c b/tests/unix_socket/unix_options.c
index 6c9e877..dc1d4c9 100644
--- a/tests/unix_socket/unix_options.c
+++ b/tests/unix_socket/unix_options.c
@@ -70,9 +70,9 @@ main(int argc, char **argv)
 				perror("poll: ");
 				return -1;
 			} else if (result == 0) {
-				/* 
-				 * connect is taking too long, 
-				 * it's probably not going to work 
+				/*
+				 * connect is taking too long,
+				 * it's probably not going to work
 				 */
 				printf("poll: no events are ready\n");
 				return -1;
diff --git a/tests/unix_socket/unix_sink.c b/tests/unix_socket/unix_sink.c
index 2661c4f..f7b9718 100644
--- a/tests/unix_socket/unix_sink.c
+++ b/tests/unix_socket/unix_sink.c
@@ -86,7 +86,7 @@ main(int argc, char **argv)
 		}
 		while (readbytes > currentbytes) {
 			remote =
-			    accept(sock, (struct sockaddr *) &raddr, &rsize);
+				accept(sock, (struct sockaddr *) &raddr, &rsize);
 			if (remote < 0) {
 				perror("accept: ");
 				close(sock);
diff --git a/tests/unix_socket/unix_source.c b/tests/unix_socket/unix_source.c
index 97ddcd8..09bf381 100644
--- a/tests/unix_socket/unix_source.c
+++ b/tests/unix_socket/unix_source.c
@@ -69,9 +69,9 @@ main(int argc, char **argv)
 				perror("poll: ");
 				return -1;
 			} else if (result == 0) {
-				/* 
-				 * connect is taking too long, 
-				 * it's probably not going to work 
+				/*
+				 * connect is taking too long,
+				 * it's probably not going to work
 				 */
 				printf("poll: no events are ready\n");
 				return -1;
diff --git a/tests/wait/child.c b/tests/wait/child.c
index 50b9b72..d80c613 100644
--- a/tests/wait/child.c
+++ b/tests/wait/child.c
@@ -1,6 +1,6 @@
 #include <stdlib.h>
 
-int main(void) 
+int main(void)
 {
 	exit(0);
 }
diff --git a/tests/wait/parent.c b/tests/wait/parent.c
index c242a80..c4d1800 100644
--- a/tests/wait/parent.c
+++ b/tests/wait/parent.c
@@ -30,12 +30,12 @@ int main(int argc, char **argv)
 		fprintf(stderr, "%s:  unable to create context structure\n", argv[0]);
 		exit(-1);
 	}
-	
+
 	if (context_type_set(context, argv[1])) {
 		fprintf(stderr, "%s:  unable to set new type\n", argv[0]);
 		exit(-1);
 	}
-	
+
 	freecon(context_s);
 	context_s = context_str(context);
 	if (!context_s) {
@@ -54,7 +54,7 @@ int main(int argc, char **argv)
 		perror("fork");
 		exit(-1);
 	} else if (pid == 0) {
-		rc = execv(argv[2], argv+2);
+		rc = execv(argv[2], argv + 2);
 		perror(argv[3]);
 		exit(1);
 	}
