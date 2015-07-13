From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] selinux-testsuite: move unix_socket and mmmap tests out of
 SUBDIRS_COMMON
Date: Mon, 13 Jul 2015 11:42:26 -0400
Message-Id: <1436802146-25156-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

RHEL 4 and 5 have forked test policies under policy/redhat, so
we cannot add new tests to SUBDIRS_COMMON unless we want to port the
policy rules for those tests to the rhel 4 and 5 test policies
as well.  For now, just move the unix_socket and mmap tests out of
SUBDIRS_COMMON to SUBDIRS so that they are only run on Fedora and
RHEL 7.  We might also be able to add them to the RHEL6 SUBDIRS
definition as it shares the same test policy but that has not been
tested.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 tests/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile b/tests/Makefile
index f92e6a1..90b1cc1 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -3,9 +3,9 @@ export CFLAGS+=-g -O0 -Wall -D_GNU_SOURCE
 
 DISTRO=$(shell ./os_detect)
 
-SUBDIRS_COMMON:=domain_trans entrypoint execshare exectrace execute_no_trans fdreceive inherit link mkdir msg open ptrace readlink relabel rename rxdir sem setattr setnice shm sigkill stat sysctl task_create task_setnice task_setscheduler task_getscheduler task_getsid task_getpgid task_setpgid wait file ioctl capable_file capable_net capable_sys unix_socket mmap
+SUBDIRS_COMMON:=domain_trans entrypoint execshare exectrace execute_no_trans fdreceive inherit link mkdir msg open ptrace readlink relabel rename rxdir sem setattr setnice shm sigkill stat sysctl task_create task_setnice task_setscheduler task_getscheduler task_getsid task_getpgid task_setpgid wait file ioctl capable_file capable_net capable_sys
 
-SUBDIRS:= $(SUBDIRS_COMMON) dyntrans dyntrace bounds nnp inet_socket
+SUBDIRS:= $(SUBDIRS_COMMON) dyntrans dyntrace bounds nnp inet_socket unix_socket mmap
 
 ifeq ($(DISTRO),RHEL4)
     SUBDIRS:=$(SUBDIRS_COMMON)
-- 
2.1.0
