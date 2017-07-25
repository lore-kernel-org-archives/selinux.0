From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Date: Tue, 25 Jul 2017 11:55:42 -0400
Message-Id: <20170725155542.32496-1-sds@tycho.nsa.gov>
Subject: [PATCH] selinux-testsuite: Add tests for transitions under NNP/nosuid
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Duplicate the existing tests for transitions under NNP for
transitions on a nosuid mount, and then augment both the NNP
and nosuid tests to also test the new support for allowing
transitions based on nnp_transition and/or nosuid_transition
permission if the nnp_nosuid_transition policy capability is
enabled.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policy/Makefile           |  6 ++-
 policy/test_nnp.te        | 17 +++++++++
 policy/test_nosuid.te     | 51 ++++++++++++++++++++++++++
 tests/Makefile            |  2 +-
 tests/nnp/test            | 40 +++++++++++++++++++-
 tests/nosuid/Makefile     |  7 ++++
 tests/nosuid/checkcon.c   | 41 +++++++++++++++++++++
 tests/nosuid/execnosuid.c | 55 ++++++++++++++++++++++++++++
 tests/nosuid/test         | 93 +++++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 309 insertions(+), 3 deletions(-)
 create mode 100644 policy/test_nosuid.te
 create mode 100644 tests/nosuid/Makefile
 create mode 100644 tests/nosuid/checkcon.c
 create mode 100644 tests/nosuid/execnosuid.c
 create mode 100755 tests/nosuid/test

diff --git a/policy/Makefile b/policy/Makefile
index b728a9e..7cdee96 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -23,7 +23,7 @@ TARGETS = \
 	test_task_getsid.te test_task_setpgid.te test_task_setsched.te \
 	test_transition.te test_inet_socket.te test_unix_socket.te \
 	test_mmap.te test_overlayfs.te test_mqueue.te test_mac_admin.te \
-	test_ibpkey.te test_atsecure.te
+	test_ibpkey.te test_atsecure.te test_nosuid.te
 
 ifeq ($(shell [ $(POL_VERS) -ge 24 ] && echo true),true)
 TARGETS += test_bounds.te
@@ -57,6 +57,10 @@ ifeq ($(shell grep -q all_file_perms.*map $(POLDEV)/include/support/all_perms.sp
 export M4PARAM = -Dmap_permission_defined
 endif
 
+ifeq ($(shell grep -q nnp_transition $(POLDEV)/include/support/all_perms.spt && echo true),true)
+export M4PARAM += -Dnnp_transition_permission_defined
+endif
+
 ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
 TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te, $(TARGETS))
 endif
diff --git a/policy/test_nnp.te b/policy/test_nnp.te
index 54ebfd3..b99e406 100644
--- a/policy/test_nnp.te
+++ b/policy/test_nnp.te
@@ -32,3 +32,20 @@ domain_entry_file(test_nnp_notbounded_t, test_nnp_notbounded_exec_t)
 # Run it!  This should fail always.
 unconfined_runs_test(test_nnp_notbounded_t)
 unconfined_run_to(test_nnp_notbounded_t, test_nnp_notbounded_exec_t)
+
+# A domain to which the unconfined domain is allowed nnp_transition.
+type test_nnp_nnptransition_t;
+domain_type(test_nnp_nnptransition_t)
+typeattribute test_nnp_nnptransition_t testdomain;
+
+# The entrypoint type for this domain.
+type test_nnp_nnptransition_exec_t;
+files_type(test_nnp_nnptransition_exec_t)
+domain_entry_file(test_nnp_nnptransition_t, test_nnp_nnptransition_exec_t)
+
+# Run it!  This should succeed on v4.14 or later.
+unconfined_runs_test(test_nnp_nnptransition_t)
+unconfined_run_to(test_nnp_nnptransition_t, test_nnp_nnptransition_exec_t)
+ifdef(`nnp_transition_permission_defined', `
+allow unconfined_t test_nnp_nnptransition_t:process nnp_transition;
+')
diff --git a/policy/test_nosuid.te b/policy/test_nosuid.te
new file mode 100644
index 0000000..0d3d2ab
--- /dev/null
+++ b/policy/test_nosuid.te
@@ -0,0 +1,51 @@
+#################################
+#
+# Policy for testing nosuid transitions.
+#
+
+# A domain bounded by the unconfined domain.
+type test_nosuid_bounded_t;
+domain_type(test_nosuid_bounded_t)
+typeattribute test_nosuid_bounded_t testdomain;
+typebounds unconfined_t test_nosuid_bounded_t;
+
+# The entrypoint type for this domain.
+type test_nosuid_bounded_exec_t;
+files_type(test_nosuid_bounded_exec_t)
+domain_entry_file(test_nosuid_bounded_t, test_nosuid_bounded_exec_t)
+domain_entry_file(unconfined_t, test_nosuid_bounded_exec_t)
+
+# Run it!  This should succeed on v3.18 or later, fail on older kernels.
+unconfined_runs_test(test_nosuid_bounded_t)
+unconfined_run_to(test_nosuid_bounded_t, test_nosuid_bounded_exec_t)
+
+# A domain that is not bounded by the unconfined domain.
+type test_nosuid_notbounded_t;
+domain_type(test_nosuid_notbounded_t)
+typeattribute test_nosuid_notbounded_t testdomain;
+
+# The entrypoint type for this domain.
+type test_nosuid_notbounded_exec_t;
+files_type(test_nosuid_notbounded_exec_t)
+domain_entry_file(test_nosuid_notbounded_t, test_nosuid_notbounded_exec_t)
+
+# Run it!  This should fail always.
+unconfined_runs_test(test_nosuid_notbounded_t)
+unconfined_run_to(test_nosuid_notbounded_t, test_nosuid_notbounded_exec_t)
+
+# A domain to which the unconfined domain is allowed nosuid_transition.
+type test_nosuid_nosuidtransition_t;
+domain_type(test_nosuid_nosuidtransition_t)
+typeattribute test_nosuid_nosuidtransition_t testdomain;
+
+# The entrypoint type for this domain.
+type test_nosuid_nosuidtransition_exec_t;
+files_type(test_nosuid_nosuidtransition_exec_t)
+domain_entry_file(test_nosuid_nosuidtransition_t, test_nosuid_nosuidtransition_exec_t)
+
+# Run it!  This should succeed on v4.14 or later.
+unconfined_runs_test(test_nosuid_nosuidtransition_t)
+unconfined_run_to(test_nosuid_nosuidtransition_t, test_nosuid_nosuidtransition_exec_t)
+ifdef(`nnp_transition_permission_defined', `
+allow unconfined_t test_nosuid_nosuidtransition_t:process2 nosuid_transition;
+')
diff --git a/tests/Makefile b/tests/Makefile
index f42fe7e..3edf73c 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -11,7 +11,7 @@ SUBDIRS:= domain_trans entrypoint execshare exectrace execute_no_trans \
 	task_getpgid task_setpgid file ioctl capable_file capable_net \
 	capable_sys dyntrans dyntrace bounds nnp mmap unix_socket inet_socket \
 	overlay checkreqprot mqueue mac_admin infiniband_pkey \
-	infiniband_endport atsecure
+	infiniband_endport atsecure nosuid
 
 ifeq ($(shell grep -q cap_userns $(POLDEV)/include/support/all_perms.spt && echo true),true)
 ifneq ($(shell ./kvercmp $$(uname -r) 4.7),-1)
diff --git a/tests/nnp/test b/tests/nnp/test
index 4c7e010..6dcb5dc 100755
--- a/tests/nnp/test
+++ b/tests/nnp/test
@@ -1,7 +1,23 @@
 #!/usr/bin/perl
 
 use Test;
-BEGIN { plan tests => 4 }
+
+BEGIN {
+    $test_count          = 4;
+    $test_nnp_transition = 0;
+
+    if (
+        system(
+"grep -q 1 /sys/fs/selinux/policy_capabilities/nnp_nosuid_transition 2> /dev/null"
+        ) == 0
+      )
+    {
+        $test_nnp_transition = 1;
+        $test_count += 2;
+    }
+
+    plan tests => $test_count;
+}
 
 $basedir = $0;
 $basedir =~ s|(.*)/[^/]*|$1|;
@@ -38,6 +54,28 @@ $result =
   system("$basedir/execnnp $basedir/checkcon test_nnp_notbounded_t 2>&1");
 ok($result);         #this should fail
 
+if ($test_nnp_transition) {
+
+    # Set entrypoint type for nnptransition domain.
+    system(
+        "chcon -t test_nnp_nnptransition_exec_t $basedir/checkcon $basedir/true"
+    );
+
+    # Transition to nnptransition domain via setexec.
+    $result =
+      system(
+        "$basedir/execnnp runcon -t test_nnp_nnptransition_t $basedir/true 2>&1"
+      );
+    ok( $result, 0 );    #this should succeed
+
+    # Automatic transition to nnptransition domain via exec.
+    $result =
+      system(
+        "$basedir/execnnp $basedir/checkcon test_nnp_nnptransition_t 2>&1");
+    ok( $result, 0 );    #this should succeed
+
+}
+
 # Cleanup.
 system("rm -f $basedir/true");
 
diff --git a/tests/nosuid/Makefile b/tests/nosuid/Makefile
new file mode 100644
index 0000000..239e0f0
--- /dev/null
+++ b/tests/nosuid/Makefile
@@ -0,0 +1,7 @@
+TARGETS=execnosuid checkcon
+
+LDLIBS += -lselinux
+
+all: $(TARGETS)
+clean:
+	rm -f $(TARGETS)
diff --git a/tests/nosuid/checkcon.c b/tests/nosuid/checkcon.c
new file mode 100644
index 0000000..d8a1e15
--- /dev/null
+++ b/tests/nosuid/checkcon.c
@@ -0,0 +1,41 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <string.h>
+#include <unistd.h>
+#include <selinux/selinux.h>
+#include <selinux/context.h>
+
+int main(int argc, char **argv)
+{
+	char *con = NULL;
+	context_t c;
+	const char *type;
+	int rc;
+
+	if (argc != 2) {
+		fprintf(stderr, "usage:  %s expected-type\n", argv[0]);
+		exit(-1);
+	}
+
+	if (getcon(&con) < 0) {
+		perror("getcon");
+		exit(-1);
+	}
+
+	c = context_new(con);
+	if (!c) {
+		perror("context_new");
+		exit(-1);
+	}
+
+	type = context_type_get(c);
+	if (!type) {
+		perror("context_type_get");
+		exit(-1);
+
+	}
+
+	rc = strcmp(type, argv[1]);
+	exit(rc);
+}
diff --git a/tests/nosuid/execnosuid.c b/tests/nosuid/execnosuid.c
new file mode 100644
index 0000000..4324937
--- /dev/null
+++ b/tests/nosuid/execnosuid.c
@@ -0,0 +1,55 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include <sys/utsname.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+
+int main(int argc, char **argv)
+{
+	bool nobounded;
+	struct utsname uts;
+	pid_t pid;
+	int rc, status;
+
+	if (argc < 2) {
+		fprintf(stderr, "usage:  %s command [args...]\n", argv[0]);
+		exit(-1);
+	}
+
+	if (uname(&uts) < 0) {
+		perror("uname");
+		exit(-1);
+	}
+
+	nobounded = ((strcmp(argv[argc - 1], "test_nosuid_bounded_t") == 0) &&
+		     (strverscmp(uts.release, "3.18") < 0));
+
+	pid = fork();
+	if (pid < 0) {
+		perror("fork");
+		exit(-1);
+	}
+
+	if (pid == 0) {
+		execvp(argv[1], &argv[1]);
+		perror(argv[1]);
+		exit(-1);
+	}
+
+	pid = wait(&status);
+	if (WIFEXITED(status)) {
+		if (WEXITSTATUS(status) && nobounded) {
+			printf("%s:  Kernels < v3.18 do not support bounded transitions under NNP.\n",
+			       argv[0]);
+			/* pass the test */
+			exit(0);
+		}
+		exit(WEXITSTATUS(status));
+	}
+
+	fprintf(stderr, "Unexpected exit status 0x%x\n", status);
+	exit(-1);
+}
diff --git a/tests/nosuid/test b/tests/nosuid/test
new file mode 100755
index 0000000..cd46109
--- /dev/null
+++ b/tests/nosuid/test
@@ -0,0 +1,93 @@
+#!/usr/bin/perl
+
+use Test;
+
+BEGIN {
+    $test_count             = 4;
+    $test_nosuid_transition = 0;
+
+    if (
+        system(
+"grep -q 1 /sys/fs/selinux/policy_capabilities/nnp_nosuid_transition 2> /dev/null"
+        ) == 0
+      )
+    {
+        $test_nosuid_transition = 1;
+        $test_count += 2;
+    }
+
+    plan tests => $test_count;
+}
+
+$basedir = $0;
+$basedir =~ s|(.*)/[^/]*|$1|;
+
+# Create nosuid mount.
+system("mkdir -p $basedir/testdir");
+system("mount -t tmpfs -o nosuid none $basedir/testdir");
+
+# Set entrypoint type for bounded domain.
+system("cp $basedir/checkcon $basedir/testdir");
+system("chcon -t test_nosuid_bounded_exec_t $basedir/testdir/checkcon");
+
+# Transition to bounded type via setexec.
+$result = system(
+"$basedir/execnosuid runcon -t test_nosuid_bounded_t $basedir/testdir/checkcon test_nosuid_bounded_t 2>&1"
+);
+ok( $result, 0 );    #this should pass
+
+# Automatic transition to bounded domain via exec.
+$result = system(
+    "$basedir/execnosuid $basedir/testdir/checkcon test_nosuid_bounded_t 2>&1");
+ok( $result, 0 );    #this should pass
+
+# Use true as an entrypoint program to test ability to exec at all.
+system("cp /bin/true $basedir/testdir/true");
+
+# Set entrypoint type for notbounded domain.
+system(
+"chcon -t test_nosuid_notbounded_exec_t $basedir/testdir/checkcon $basedir/testdir/true"
+);
+
+# Transition to notbounded domain via setexec.
+$result =
+  system(
+"$basedir/execnosuid runcon -t test_nosuid_notbounded_t $basedir/testdir/true 2>&1"
+  );
+ok($result);    #this should fail
+
+# Automatic transition to notbounded domain via exec.
+$result =
+  system(
+"$basedir/execnosuid $basedir/testdir/checkcon test_nosuid_notbounded_t 2>&1"
+  );
+ok($result);    #this should fail
+
+if ($test_nosuid_transition) {
+
+    # Set entrypoint type for nosuid domain.
+    system(
+"chcon -t test_nosuid_nosuidtransition_exec_t $basedir/testdir/checkcon $basedir/testdir/true"
+    );
+
+    # Transition to nosuid domain via setexec.
+    $result =
+      system(
+"$basedir/execnosuid runcon -t test_nosuid_nosuidtransition_t $basedir/testdir/true 2>&1"
+      );
+    ok( $result, 0 );    #this should succeed
+
+    # Automatic transition to nosuid domain via exec.
+    $result =
+      system(
+"$basedir/execnosuid $basedir/testdir/checkcon test_nosuid_nosuidtransition_t 2>&1"
+      );
+    ok( $result, 0 );    #this should succeed
+
+}
+
+# Cleanup.
+system("umount $basedir/testdir");
+system("rmdir $basedir/testdir");
+
+exit;
-- 
2.9.4
