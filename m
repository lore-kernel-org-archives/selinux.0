Message-ID: <539F0C7E.6090702@tycho.nsa.gov>
Date: Mon, 16 Jun 2014 11:25:50 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH] selinux-testsuite:  Add tests for exec transitions under
 NO_NEW_PRIVS
References: <5399FD14.60101@tycho.nsa.gov>
 <CALCETrVbD3NxxhJsjiAGcEE-5yjH34+BijTHrOFiefwotu6krA@mail.gmail.com>
 <5399FF80.604@tycho.nsa.gov>
In-Reply-To: <5399FF80.604@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="------------070801070308010507020103"
Cc: SELinux-NSA <SELinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------070801070308010507020103
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Tests 1-4 will fail on existing kernels without the patch entitled
"selinux: Permit exec transitions under NO_NEW_PRIVS or NOSUID under
certain circumstances.".  Tests 5-6 should always pass.

We shouldn't apply it to the selinux-testsuite until after the kernel
change is merged, and then we should make it dependent on the first
kernel version that will include the change.

--------------070801070308010507020103
Content-Type: text/x-patch;
 name="0001-Add-tests-for-exec-transitions-under-NO_NEW_PRIVS.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Add-tests-for-exec-transitions-under-NO_NEW_PRIVS.patch"

>From 66e8681c88a4cb0e3d84ed92f59e9812ba4a3003 Mon Sep 17 00:00:00 2001
From: Stephen Smalley <sds@tycho.nsa.gov>
Date: Fri, 13 Jun 2014 12:40:16 -0400
Subject: [PATCH] Add tests for exec transitions under NO_NEW_PRIVS.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policy/Makefile      |  2 +-
 policy/test_nnp.te   | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/Makefile       |  2 +-
 tests/nnp/Makefile   |  7 +++++++
 tests/nnp/checkcon.c | 40 +++++++++++++++++++++++++++++++++++++++
 tests/nnp/execnnp.c  | 25 +++++++++++++++++++++++++
 tests/nnp/test       | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 175 insertions(+), 2 deletions(-)
 create mode 100644 policy/test_nnp.te
 create mode 100644 tests/nnp/Makefile
 create mode 100644 tests/nnp/checkcon.c
 create mode 100644 tests/nnp/execnnp.c
 create mode 100755 tests/nnp/test

diff --git a/policy/Makefile b/policy/Makefile
index a0a6c88..683f454 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -14,7 +14,7 @@ TARGETS = \
 	test_entrypoint.te test_execshare.te test_exectrace.te \
 	test_execute_no_trans.te test_fdreceive.te test_file.te \
 	test_inherit.te test_ioctl.te test_ipc.te test_link.te test_mkdir.te \
-	test_open.te test_ptrace.te test_readlink.te \
+	test_nnp.te test_open.te test_ptrace.te test_readlink.te \
 	test_relabel.te test_rename.te test_rxdir.te test_setattr.te \
 	test_setnice.te test_sigkill.te test_stat.te test_sysctl.te \
 	test_task_create.te test_task_getpgid.te test_task_getsched.te \
diff --git a/policy/test_nnp.te b/policy/test_nnp.te
new file mode 100644
index 0000000..8ab798f
--- /dev/null
+++ b/policy/test_nnp.te
@@ -0,0 +1,48 @@
+#################################
+#
+# Policy for testing NO_NEW_PRIVS transitions.
+#
+
+# A domain bounded by the unconfined domain.
+type test_nnp_bounded_t;
+domain_type(test_nnp_bounded_t)
+typeattribute test_nnp_bounded_t testdomain;
+typebounds unconfined_t test_nnp_bounded_t;
+
+# The entrypoint type for this domain.
+type test_nnp_bounded_exec_t;
+files_type(test_nnp_bounded_exec_t)
+domain_entry_file(test_nnp_bounded_t, test_nnp_bounded_exec_t)
+
+# Run it!  This should succeed on patched kernels, fail on old ones.
+unconfined_runs_test(test_nnp_bounded_t)
+unconfined_run_to(test_nnp_bounded_t, test_nnp_bounded_exec_t)
+
+# A domain that can be reached via setcon by the start domain.
+type test_nnp_dyntransition_t;
+domain_type(test_nnp_dyntransition_t)
+typeattribute test_nnp_dyntransition_t testdomain;
+allow unconfined_t test_nnp_dyntransition_t:process dyntransition;
+
+# The entrypoint type for this domain.
+type test_nnp_dyntransition_exec_t;
+files_type(test_nnp_dyntransition_exec_t)
+domain_entry_file(test_nnp_dyntransition_t, test_nnp_dyntransition_exec_t)
+
+# Run it!  This should succeed on patched kernels, fail on old ones.
+unconfined_runs_test(test_nnp_dyntransition_t)
+unconfined_run_to(test_nnp_dyntransition_t, test_nnp_dyntransition_exec_t)
+
+# A domain that is neither bounded nor reachable via setcon from the start domain.
+type test_nnp_neither_t;
+domain_type(test_nnp_neither_t)
+typeattribute test_nnp_neither_t testdomain;
+
+# The entrypoint type for this domain.
+type test_nnp_neither_exec_t;
+files_type(test_nnp_neither_exec_t)
+domain_entry_file(test_nnp_neither_t, test_nnp_neither_exec_t)
+
+# Run it!  This should fail always.
+unconfined_runs_test(test_nnp_neither_t)
+unconfined_run_to(test_nnp_neither_t, test_nnp_neither_exec_t)
diff --git a/tests/Makefile b/tests/Makefile
index 5886403..4cfecdf 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -1,6 +1,6 @@
 REDHAT_RELEASE=$(shell rpm -q redhat-release)
 
-SUBDIRS=domain_trans entrypoint execshare exectrace execute_no_trans fdreceive inherit link mkdir msg open ptrace readlink relabel rename rxdir sem setattr setnice shm sigkill stat sysctl task_create task_setnice task_setscheduler task_getscheduler task_getsid task_getpgid task_setpgid wait file ioctl capable_file capable_net capable_sys dyntrans dyntrace bounds
+SUBDIRS=domain_trans entrypoint execshare exectrace execute_no_trans fdreceive inherit link mkdir msg nnp open ptrace readlink relabel rename rxdir sem setattr setnice shm sigkill stat sysctl task_create task_setnice task_setscheduler task_getscheduler task_getsid task_getpgid task_setpgid wait file ioctl capable_file capable_net capable_sys dyntrans dyntrace bounds
 #SUBDIRS=socket unix_socket unix_secure
 
 ifeq (redhat-release-4, $(findstring redhat-release-4, $(REDHAT_RELEASE)))
diff --git a/tests/nnp/Makefile b/tests/nnp/Makefile
new file mode 100644
index 0000000..4e8e400
--- /dev/null
+++ b/tests/nnp/Makefile
@@ -0,0 +1,7 @@
+TARGETS=execnnp checkcon
+
+LDLIBS += -lselinux
+
+all: $(TARGETS)
+clean:
+	rm -f $(TARGETS)
diff --git a/tests/nnp/checkcon.c b/tests/nnp/checkcon.c
new file mode 100644
index 0000000..5d992ca
--- /dev/null
+++ b/tests/nnp/checkcon.c
@@ -0,0 +1,40 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <selinux/selinux.h>
+#include <selinux/context.h>
+
+int main(int argc, char **argv)
+{
+    char *con = NULL;
+    context_t c;
+    const char *type;
+    int rc;
+
+    if (argc != 2) {
+        fprintf(stderr, "usage:  %s expected-type\n", argv[0]);
+        exit(-1);
+    }
+
+    if (getcon(&con) < 0) {
+        perror("getcon");
+        exit(-1);
+    }
+      
+    c = context_new(con);
+    if (!c) {
+        perror("context_new");
+        exit(-1);
+    }
+    
+    type = context_type_get(c);
+    if (!type) {
+        perror("context_type_get");
+        exit(-1);
+
+    }
+    
+    rc = strcmp(type, argv[1]);
+    exit(rc);
+}
diff --git a/tests/nnp/execnnp.c b/tests/nnp/execnnp.c
new file mode 100644
index 0000000..9de5967
--- /dev/null
+++ b/tests/nnp/execnnp.c
@@ -0,0 +1,25 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/prctl.h>
+
+int main(int argc, char **argv)
+{
+    int rc;
+
+    if (argc < 2) {
+	fprintf(stderr, "usage:  %s command [args...]\n", argv[0]);
+	exit(-1);
+    }
+
+    rc = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+    if (rc < 0) {
+        perror("prctl PR_SET_NO_NEW_PRIVS");
+        exit(-1);
+    }
+
+    execvp(argv[1], &argv[1]);
+    perror(argv[1]);
+    exit(1);
+}
diff --git a/tests/nnp/test b/tests/nnp/test
new file mode 100755
index 0000000..eb2c522
--- /dev/null
+++ b/tests/nnp/test
@@ -0,0 +1,53 @@
+#!/usr/bin/perl
+
+# Depends on kernel patch with the following subject line:
+# selinux:  Permit exec transitions under NO_NEW_PRIVS or NOSUID under certain circumstances.
+
+use Test;
+BEGIN { plan tests => 6}
+
+$basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
+
+# Remove any leftover programs from prior failed runs.
+system("rm -f $basedir/true");
+
+# Set entrypoint type for bounded domain.
+system("chcon -t test_nnp_bounded_exec_t $basedir/checkcon");
+
+# Transition to bounded type via setexec.
+$result = system("$basedir/execnnp runcon -t test_nnp_bounded_t $basedir/checkcon test_nnp_bounded_t 2>&1");
+ok($result,0); #this should pass
+
+# Automatic transition to bounded domain via exec.
+$result = system("$basedir/execnnp $basedir/checkcon test_nnp_bounded_t 2>&1");
+ok($result,0); #this should pass
+
+# Set entrypoint type for dyntransition domain.
+system("chcon -t test_nnp_dyntransition_exec_t $basedir/checkcon");
+
+# Transition to dyntransition domain via setexec.
+$result = system("$basedir/execnnp runcon -t test_nnp_dyntransition_t $basedir/checkcon test_nnp_dyntransition_t 2>&1");
+ok($result,0); #this should pass
+
+# Automatic transition to dyntransition domain via exec.
+$result = system("$basedir/execnnp $basedir/checkcon test_nnp_dyntransition_t 2>&1");
+ok($result,0); #this should pass
+
+# Use true as an entrypoint program to test ability to exec at all.
+system("cp /bin/true $basedir/true");
+
+# Set entrypoint type for neither bounded nor dyntransition domain.
+system("chcon -t test_nnp_neither_exec_t $basedir/checkcon $basedir/true");
+
+# Transition to neither domain via setexec.
+$result = system("$basedir/execnnp runcon -t test_nnp_neither_t $basedir/true 2>&1");
+ok($result); #this should fail
+
+# Automatic transition to neither domain via exec.
+$result = system("$basedir/execnnp $basedir/checkcon test_nnp_neither_t 2>&1");
+ok($result); #this should fail
+
+# Cleanup.
+system("rm -f $basedir/true");
+
+exit;
-- 
1.9.3


--------------070801070308010507020103--
