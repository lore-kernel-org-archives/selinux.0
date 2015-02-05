From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] selinux-testsuite:  split testcase list for rhel-6.
Date: Thu,  5 Feb 2015 12:56:48 -0500
Message-Id: <1423159008-13641-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The NNP test will not work on rhel-6, so split off a separate
testcase list for rhel-6 as we have previously done for rhel-5 and 4.
Simplify maintenance by introducing a SUBDIRS_COMMON variable with
the list of testcases shared by all.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 tests/Makefile | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tests/Makefile b/tests/Makefile
index 4cfecdf..ddbedf7 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -1,14 +1,19 @@
 REDHAT_RELEASE=$(shell rpm -q redhat-release)
 
-SUBDIRS=domain_trans entrypoint execshare exectrace execute_no_trans fdreceive inherit link mkdir msg nnp open ptrace readlink relabel rename rxdir sem setattr setnice shm sigkill stat sysctl task_create task_setnice task_setscheduler task_getscheduler task_getsid task_getpgid task_setpgid wait file ioctl capable_file capable_net capable_sys dyntrans dyntrace bounds
-#SUBDIRS=socket unix_socket unix_secure
+SUBDIRS_COMMON:=domain_trans entrypoint execshare exectrace execute_no_trans fdreceive inherit link mkdir msg open ptrace readlink relabel rename rxdir sem setattr setnice shm sigkill stat sysctl task_create task_setnice task_setscheduler task_getscheduler task_getsid task_getpgid task_setpgid wait file ioctl capable_file capable_net capable_sys
+
+SUBDIRS:= $(SUBDIRS_COMMON) dyntrans dyntrace bounds nnp
 
 ifeq (redhat-release-4, $(findstring redhat-release-4, $(REDHAT_RELEASE)))
-    SUBDIRS=domain_trans entrypoint execshare exectrace execute_no_trans fdreceive inherit link mkdir msg open ptrace readlink relabel rename rxdir sem setattr setnice shm sigkill stat sysctl task_create task_setnice task_setscheduler task_getscheduler task_getsid task_getpgid task_setpgid wait file ioctl capable_file capable_net capable_sys
+    SUBDIRS:=$(SUBDIRS_COMMON)
 endif
 
 ifeq (redhat-release-5, $(findstring redhat-release-5, $(REDHAT_RELEASE)))
-    SUBDIRS=domain_trans entrypoint execshare exectrace execute_no_trans fdreceive inherit link mkdir msg open ptrace readlink relabel rename rxdir sem setattr setnice shm sigkill stat sysctl task_create task_setnice task_setscheduler task_getscheduler task_getsid task_getpgid task_setpgid wait file ioctl capable_file capable_net capable_sys dyntrace dyntrans
+    SUBDIRS:=$(SUBDIRS_COMMON) dyntrace dyntrans
+endif
+
+ifeq (redhat-release-6, $(findstring redhat-release-5, $(REDHAT_RELEASE)))
+    SUBDIRS:=$(SUBDIRS_COMMON) dyntrace dyntrans bounds
 endif
 
 .PHONY: all test clean
-- 
1.9.3
