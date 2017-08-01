From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Date: Tue,  1 Aug 2017 11:03:31 -0400
Message-Id: <20170801150331.24572-1-sds@tycho.nsa.gov>
Subject: [PATCH v3] selinux-testsuite: Add tests for transitions under
 NNP/nosuid
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Duplicate the existing tests for transitions under NNP for
transitions on a nosuid mount, and then augment both the NNP
and nosuid tests to also test the new support for allowing
transitions based on nnp_transition and/or nosuid_transition
permission if the nnp_nosuid_transition policy capability is
enabled.  Test NNP and nosuid independently and together.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
v3 fixes a few bugs in the test policy and code, and adds one further test.

 policy/Makefile                      |   6 +-
 policy/test_nnp.te                   |  34 -------
 policy/test_nnp_nosuid.te            |  85 ++++++++++++++++
 tests/Makefile                       |  10 +-
 tests/nnp/test                       |  44 --------
 tests/{nnp => nnp_nosuid}/Makefile   |   0
 tests/{nnp => nnp_nosuid}/checkcon.c |   0
 tests/{nnp => nnp_nosuid}/execnnp.c  |  40 ++++++--
 tests/nnp_nosuid/test                | 189 +++++++++++++++++++++++++++++++++++
 9 files changed, 314 insertions(+), 94 deletions(-)
 delete mode 100644 policy/test_nnp.te
 create mode 100644 policy/test_nnp_nosuid.te
 delete mode 100755 tests/nnp/test
 rename tests/{nnp => nnp_nosuid}/Makefile (100%)
 rename tests/{nnp => nnp_nosuid}/checkcon.c (100%)
 rename tests/{nnp => nnp_nosuid}/execnnp.c (57%)
 create mode 100755 tests/nnp_nosuid/test

diff --git a/policy/Makefile b/policy/Makefile
index b728a9e..1dafc65 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -16,7 +16,7 @@ TARGETS = \
 	test_entrypoint.te test_execshare.te test_exectrace.te \
 	test_execute_no_trans.te test_fdreceive.te test_file.te \
 	test_inherit.te test_ioctl.te test_ipc.te test_link.te test_mkdir.te \
-	test_nnp.te test_open.te test_ptrace.te test_readlink.te \
+	test_nnp_nosuid.te test_open.te test_ptrace.te test_readlink.te \
 	test_relabel.te test_rename.te test_rxdir.te test_setattr.te \
 	test_setnice.te test_sigkill.te test_stat.te test_sysctl.te \
 	test_task_create.te test_task_getpgid.te test_task_getsched.te \
@@ -57,6 +57,10 @@ ifeq ($(shell grep -q all_file_perms.*map $(POLDEV)/include/support/all_perms.sp
 export M4PARAM = -Dmap_permission_defined
 endif
 
+ifeq ($(shell grep -q nnp_transition $(POLDEV)/include/support/all_perms.spt && echo true),true)
+export M4PARAM += -Dnnp_nosuid_transition_permission_defined
+endif
+
 ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
 TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te, $(TARGETS))
 endif
diff --git a/policy/test_nnp.te b/policy/test_nnp.te
deleted file mode 100644
index 54ebfd3..0000000
--- a/policy/test_nnp.te
+++ /dev/null
@@ -1,34 +0,0 @@
-#################################
-#
-# Policy for testing NO_NEW_PRIVS transitions.
-#
-
-# A domain bounded by the unconfined domain.
-type test_nnp_bounded_t;
-domain_type(test_nnp_bounded_t)
-typeattribute test_nnp_bounded_t testdomain;
-typebounds unconfined_t test_nnp_bounded_t;
-
-# The entrypoint type for this domain.
-type test_nnp_bounded_exec_t;
-files_type(test_nnp_bounded_exec_t)
-domain_entry_file(test_nnp_bounded_t, test_nnp_bounded_exec_t)
-domain_entry_file(unconfined_t, test_nnp_bounded_exec_t)
-
-# Run it!  This should succeed on v3.18 or later, fail on older kernels.
-unconfined_runs_test(test_nnp_bounded_t)
-unconfined_run_to(test_nnp_bounded_t, test_nnp_bounded_exec_t)
-
-# A domain that is not bounded by the unconfined domain.
-type test_nnp_notbounded_t;
-domain_type(test_nnp_notbounded_t)
-typeattribute test_nnp_notbounded_t testdomain;
-
-# The entrypoint type for this domain.
-type test_nnp_notbounded_exec_t;
-files_type(test_nnp_notbounded_exec_t)
-domain_entry_file(test_nnp_notbounded_t, test_nnp_notbounded_exec_t)
-
-# Run it!  This should fail always.
-unconfined_runs_test(test_nnp_notbounded_t)
-unconfined_run_to(test_nnp_notbounded_t, test_nnp_notbounded_exec_t)
diff --git a/policy/test_nnp_nosuid.te b/policy/test_nnp_nosuid.te
new file mode 100644
index 0000000..bf2b6ef
--- /dev/null
+++ b/policy/test_nnp_nosuid.te
@@ -0,0 +1,85 @@
+#################################
+#
+# Policy for testing NO_NEW_PRIVS and nosuid transitions.
+#
+
+# A domain bounded by the unconfined domain.
+type test_bounded_t;
+domain_type(test_bounded_t)
+typeattribute test_bounded_t testdomain;
+typebounds unconfined_t test_bounded_t;
+
+# The entrypoint type for this domain.
+type test_bounded_exec_t;
+files_type(test_bounded_exec_t)
+domain_entry_file(test_bounded_t, test_bounded_exec_t)
+domain_entry_file(unconfined_t, test_bounded_exec_t)
+
+# Run it!  This should succeed on v3.18 or later, fail on older kernels.
+unconfined_runs_test(test_bounded_t)
+unconfined_run_to(test_bounded_t, test_bounded_exec_t)
+
+# A domain that is not bounded by the unconfined domain.
+type test_notbounded_t;
+domain_type(test_notbounded_t)
+typeattribute test_notbounded_t testdomain;
+
+# The entrypoint type for this domain.
+type test_notbounded_exec_t;
+files_type(test_notbounded_exec_t)
+domain_entry_file(test_notbounded_t, test_notbounded_exec_t)
+
+# Run it!  This should fail always.
+unconfined_runs_test(test_notbounded_t)
+unconfined_run_to(test_notbounded_t, test_notbounded_exec_t)
+
+# A domain to which the unconfined domain is allowed nnp_transition.
+type test_nnptransition_t;
+domain_type(test_nnptransition_t)
+typeattribute test_nnptransition_t testdomain;
+
+# The entrypoint type for this domain.
+type test_nnptransition_exec_t;
+files_type(test_nnptransition_exec_t)
+domain_entry_file(test_nnptransition_t, test_nnptransition_exec_t)
+
+# Run it!  This should succeed on v4.14 or later.
+unconfined_runs_test(test_nnptransition_t)
+unconfined_run_to(test_nnptransition_t, test_nnptransition_exec_t)
+ifdef(`nnp_nosuid_transition_permission_defined', `
+allow unconfined_t test_nnptransition_t:process2 nnp_transition;
+')
+
+# A domain to which the unconfined domain is allowed nosuid_transition.
+type test_nosuidtransition_t;
+domain_type(test_nosuidtransition_t)
+typeattribute test_nosuidtransition_t testdomain;
+
+# The entrypoint type for this domain.
+type test_nosuidtransition_exec_t;
+files_type(test_nosuidtransition_exec_t)
+domain_entry_file(test_nosuidtransition_t, test_nosuidtransition_exec_t)
+
+# Run it!  This should succeed on v4.14 or later.
+unconfined_runs_test(test_nosuidtransition_t)
+unconfined_run_to(test_nosuidtransition_t, test_nosuidtransition_exec_t)
+ifdef(`nnp_nosuid_transition_permission_defined', `
+allow unconfined_t test_nosuidtransition_t:process2 nosuid_transition;
+')
+
+# A domain to which the unconfined domain is allowed both nosuid_transition and nnp_transition.
+type test_nnpnosuidtransition_t;
+domain_type(test_nnpnosuidtransition_t)
+typeattribute test_nnpnosuidtransition_t testdomain;
+
+# The entrypoint type for this domain.
+type test_nnpnosuidtransition_exec_t;
+files_type(test_nosuidtransition_exec_t)
+domain_entry_file(test_nnpnosuidtransition_t, test_nnpnosuidtransition_exec_t)
+
+# Run it!  This should succeed on v4.14 or later.
+unconfined_runs_test(test_nnpnosuidtransition_t)
+unconfined_run_to(test_nnpnosuidtransition_t, test_nnpnosuidtransition_exec_t)
+ifdef(`nnp_nosuid_transition_permission_defined', `
+allow unconfined_t test_nnpnosuidtransition_t:process2 { nnp_transition nosuid_transition };
+')
diff --git a/tests/Makefile b/tests/Makefile
index f42fe7e..f9cc5ac 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -9,8 +9,8 @@ SUBDIRS:= domain_trans entrypoint execshare exectrace execute_no_trans \
 	rxdir sem setattr setnice shm sigkill stat sysctl task_create \
 	task_setnice task_setscheduler task_getscheduler task_getsid \
 	task_getpgid task_setpgid file ioctl capable_file capable_net \
-	capable_sys dyntrans dyntrace bounds nnp mmap unix_socket inet_socket \
-	overlay checkreqprot mqueue mac_admin infiniband_pkey \
+	capable_sys dyntrans dyntrace bounds nnp_nosuid mmap unix_socket \
+        inet_socket overlay checkreqprot mqueue mac_admin infiniband_pkey \
 	infiniband_endport atsecure
 
 ifeq ($(shell grep -q cap_userns $(POLDEV)/include/support/all_perms.spt && echo true),true)
@@ -32,15 +32,15 @@ SUBDIRS += prlimit
 endif
 
 ifeq ($(DISTRO),RHEL4)
-    SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap nnp overlay unix_socket, $(SUBDIRS))
+    SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap nnp_nosuid overlay unix_socket, $(SUBDIRS))
 endif
 
 ifeq ($(DISTRO),RHEL5)
-    SUBDIRS:=$(filter-out bounds inet_socket mmap nnp overlay unix_socket, $(SUBDIRS))
+    SUBDIRS:=$(filter-out bounds inet_socket mmap nnp_nosuid overlay unix_socket, $(SUBDIRS))
 endif
 
 ifeq ($(DISTRO),RHEL6)
-    SUBDIRS:=$(filter-out nnp overlay, $(SUBDIRS))
+    SUBDIRS:=$(filter-out nnp_nosuid overlay, $(SUBDIRS))
 endif
 
 ifeq ($(DISTRO),RHEL7)
diff --git a/tests/nnp/test b/tests/nnp/test
deleted file mode 100755
index 4c7e010..0000000
--- a/tests/nnp/test
+++ /dev/null
@@ -1,44 +0,0 @@
-#!/usr/bin/perl
-
-use Test;
-BEGIN { plan tests => 4 }
-
-$basedir = $0;
-$basedir =~ s|(.*)/[^/]*|$1|;
-
-# Remove any leftover programs from prior failed runs.
-system("rm -f $basedir/true");
-
-# Set entrypoint type for bounded domain.
-system("chcon -t test_nnp_bounded_exec_t $basedir/checkcon");
-
-# Transition to bounded type via setexec.
-$result = system(
-"$basedir/execnnp runcon -t test_nnp_bounded_t $basedir/checkcon test_nnp_bounded_t 2>&1"
-);
-ok( $result, 0 );    #this should pass
-
-# Automatic transition to bounded domain via exec.
-$result = system("$basedir/execnnp $basedir/checkcon test_nnp_bounded_t 2>&1");
-ok( $result, 0 );    #this should pass
-
-# Use true as an entrypoint program to test ability to exec at all.
-system("cp /bin/true $basedir/true");
-
-# Set entrypoint type for notbounded domain.
-system("chcon -t test_nnp_notbounded_exec_t $basedir/checkcon $basedir/true");
-
-# Transition to notbounded domain via setexec.
-$result =
-  system("$basedir/execnnp runcon -t test_nnp_notbounded_t $basedir/true 2>&1");
-ok($result);         #this should fail
-
-# Automatic transition to notbounded domain via exec.
-$result =
-  system("$basedir/execnnp $basedir/checkcon test_nnp_notbounded_t 2>&1");
-ok($result);         #this should fail
-
-# Cleanup.
-system("rm -f $basedir/true");
-
-exit;
diff --git a/tests/nnp/Makefile b/tests/nnp_nosuid/Makefile
similarity index 100%
rename from tests/nnp/Makefile
rename to tests/nnp_nosuid/Makefile
diff --git a/tests/nnp/checkcon.c b/tests/nnp_nosuid/checkcon.c
similarity index 100%
rename from tests/nnp/checkcon.c
rename to tests/nnp_nosuid/checkcon.c
diff --git a/tests/nnp/execnnp.c b/tests/nnp_nosuid/execnnp.c
similarity index 57%
rename from tests/nnp/execnnp.c
rename to tests/nnp_nosuid/execnnp.c
index d8f1986..78b5ab5 100644
--- a/tests/nnp/execnnp.c
+++ b/tests/nnp_nosuid/execnnp.c
@@ -2,36 +2,56 @@
 #include <stdlib.h>
 #include <string.h>
 #include <stdbool.h>
+#include <getopt.h>
 #include <unistd.h>
 #include <sys/utsname.h>
 #include <sys/prctl.h>
 #include <sys/types.h>
 #include <sys/wait.h>
 
+static void usage(const char *progname)
+{
+	fprintf(stderr, "usage: %s [-n] command [args...]\n", progname);
+	exit(-1);
+}
+
 int main(int argc, char **argv)
 {
 	bool nobounded;
 	struct utsname uts;
 	pid_t pid;
 	int rc, status;
+	int opt;
+	bool nnp = false;
 
-	if (argc < 2) {
-		fprintf(stderr, "usage:  %s command [args...]\n", argv[0]);
-		exit(-1);
+	while ((opt = getopt(argc, argv, "n")) != -1) {
+		switch (opt) {
+		case 'n':
+			nnp = true;
+			break;
+		default:
+			usage(argv[0]);
+			break;
+		}
 	}
 
+	if ((argc - optind) < 2)
+		usage(argv[0]);
+
 	if (uname(&uts) < 0) {
 		perror("uname");
 		exit(-1);
 	}
 
-	nobounded = ((strcmp(argv[argc - 1], "test_nnp_bounded_t") == 0) &&
+	nobounded = ((strcmp(argv[argc - 1], "test_bounded_t") == 0) &&
 		     (strverscmp(uts.release, "3.18") < 0));
 
-	rc = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
-	if (rc < 0) {
-		perror("prctl PR_SET_NO_NEW_PRIVS");
-		exit(-1);
+	if (nnp) {
+		rc = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+		if (rc < 0) {
+			perror("prctl PR_SET_NO_NEW_PRIVS");
+			exit(-1);
+		}
 	}
 
 	pid = fork();
@@ -41,8 +61,8 @@ int main(int argc, char **argv)
 	}
 
 	if (pid == 0) {
-		execvp(argv[1], &argv[1]);
-		perror(argv[1]);
+		execvp(argv[optind], &argv[optind]);
+		perror(argv[optind]);
 		exit(-1);
 	}
 
diff --git a/tests/nnp_nosuid/test b/tests/nnp_nosuid/test
new file mode 100755
index 0000000..accb3f2
--- /dev/null
+++ b/tests/nnp_nosuid/test
@@ -0,0 +1,189 @@
+#!/usr/bin/perl
+
+use Test;
+
+BEGIN {
+    $test_count                 = 8;
+    $test_nnp_nosuid_transition = 0;
+
+    if (
+        system(
+"grep -q 1 /sys/fs/selinux/policy_capabilities/nnp_nosuid_transition 2> /dev/null"
+        ) == 0
+      )
+    {
+        $test_nnp_nosuid_transition = 1;
+        $test_count += 10;
+    }
+
+    plan tests => $test_count;
+}
+
+$basedir = $0;
+$basedir =~ s|(.*)/[^/]*|$1|;
+
+# Remove any leftover programs from prior failed runs.
+system("rm -f $basedir/true");
+
+# Set entrypoint type for bounded domain under NNP.
+system("chcon -t test_bounded_exec_t $basedir/checkcon");
+
+# Create nosuid mount.
+system("mkdir -p $basedir/testdir");
+system("mount -t tmpfs -o nosuid none $basedir/testdir");
+
+# Set entrypoint type for bounded domain under nosuid.
+system("cp $basedir/checkcon $basedir/testdir");
+system("chcon -t test_bounded_exec_t $basedir/testdir/checkcon");
+
+# Transition under NNP to bounded type via setexec.
+$result = system(
+"$basedir/execnnp -n -- runcon -t test_bounded_t $basedir/checkcon test_bounded_t 2>&1"
+);
+ok( $result, 0 );    #this should pass
+
+# Transition on nosuid to bounded type via setexec.
+$result = system(
+"$basedir/execnnp -- runcon -t test_bounded_t $basedir/testdir/checkcon test_bounded_t 2>&1"
+);
+ok( $result, 0 );    #this should pass
+
+# Automatic transition under NNP to bounded domain via exec.
+$result =
+  system("$basedir/execnnp -n -- $basedir/checkcon test_bounded_t 2>&1");
+ok( $result, 0 );    #this should pass
+
+# Automatic transition on nosuid to bounded domain via exec.
+$result =
+  system("$basedir/execnnp -- $basedir/testdir/checkcon test_bounded_t 2>&1");
+ok( $result, 0 );    #this should pass
+
+# Use true as an entrypoint program to test ability to exec at all.
+system("cp /bin/true $basedir/true");
+system("cp /bin/true $basedir/testdir/true");
+
+# Set entrypoint type for notbounded domain.
+system("chcon -t test_notbounded_exec_t $basedir/checkcon $basedir/true");
+system(
+"chcon -t test_notbounded_exec_t $basedir/testdir/checkcon $basedir/testdir/true"
+);
+
+# Transition under NNP to notbounded domain via setexec.
+$result =
+  system(
+    "$basedir/execnnp -n -- runcon -t test_notbounded_t $basedir/true 2>&1");
+ok($result);    #this should fail
+
+# Transition on nosuid to notbounded domain via setexec.
+$result =
+  system(
+    "$basedir/execnnp -- runcon -t test_notbounded_t $basedir/testdir/true 2>&1"
+  );
+ok($result);    #this should fail
+
+# Automatic transition under NNP to notbounded domain via exec.
+$result =
+  system("$basedir/execnnp -n -- $basedir/checkcon test_notbounded_t 2>&1");
+ok($result);    #this should fail
+
+# Automatic transition on nosuid to notbounded domain via exec.
+$result =
+  system(
+    "$basedir/execnnp -- $basedir/testdir/checkcon test_notbounded_t 2>&1");
+ok($result);    #this should fail
+
+if ($test_nnp_nosuid_transition) {
+
+    # Set entrypoint type for nnptransition domain.
+    system(
+        "chcon -t test_nnptransition_exec_t $basedir/checkcon $basedir/true");
+    system(
+"chcon -t test_nnptransition_exec_t $basedir/testdir/checkcon $basedir/testdir/true"
+    );
+
+    # Transition under NNP to nnptransition domain via setexec.
+    $result =
+      system(
+"$basedir/execnnp -n -- runcon -t test_nnptransition_t $basedir/true 2>&1"
+      );
+    ok( $result, 0 );    #this should succeed
+
+    # Transition under NNP+nosuid to nnptransition domain via setexec.
+    $result =
+      system(
+"$basedir/execnnp -n -- runcon -t test_nnptransition_t $basedir/testdir/true 2>&1"
+      );
+    ok($result);         #this should fail
+
+    # Automatic transition under NNP to nnptransition domain via exec.
+    $result =
+      system(
+        "$basedir/execnnp -n -- $basedir/checkcon test_nnptransition_t 2>&1");
+    ok( $result, 0 );    #this should succeed
+
+    # Automatic transition under NNP+nosuid to nnptransition domain via exec.
+    $result =
+      system(
+"$basedir/execnnp -n -- $basedir/testdir/checkcon test_nnptransition_t 2>&1"
+      );
+    ok($result);         #this should fail
+
+    # Set entrypoint type for nosuidtransition domain.
+    system(
+"chcon -t test_nosuidtransition_exec_t $basedir/testdir/checkcon $basedir/testdir/true"
+    );
+
+    # Transition under nosuid to nosuidtransition domain via setexec.
+    $result =
+      system(
+"$basedir/execnnp -- runcon -t test_nosuidtransition_t $basedir/testdir/true 2>&1"
+      );
+    ok( $result, 0 );    #this should succeed
+
+    # Transition under NNP+nosuid to nosuidtransition domain via setexec.
+    $result =
+      system(
+"$basedir/execnnp -n -- runcon -t test_nosuidtransition_t $basedir/testdir/true 2>&1"
+      );
+    ok($result);         #this should fail
+
+    # Automatic transition under nosuid to nosuidtransition domain via exec.
+    $result =
+      system(
+"$basedir/execnnp -- $basedir/testdir/checkcon test_nosuidtransition_t 2>&1"
+      );
+    ok( $result, 0 );    #this should succeed
+
+    # Automatic transition under NNP+nosuid to nosuidtransition domain via exec.
+    $result =
+      system(
+"$basedir/execnnp -n -- $basedir/testdir/checkcon test_nosuidtransition_t 2>&1"
+      );
+    ok($result);         #this should fail
+
+    # Set entrypoint type for nnpnosuidtransition domain.
+    system(
+"chcon -t test_nnpnosuidtransition_exec_t $basedir/testdir/checkcon $basedir/testdir/true"
+    );
+
+    # Transition under NNP+nosuid to nnpnosuidtransition domain via setexec.
+    $result =
+      system(
+"$basedir/execnnp -n -- runcon -t test_nnpnosuidtransition_t $basedir/testdir/true 2>&1"
+      );
+    ok( $result, 0 );    #this should succeed
+
+    # Automatic transition under NNP+nosuid to nnpnosuidtransition domain via exec.
+    $result =
+      system(
+"$basedir/execnnp -n -- $basedir/testdir/checkcon test_nnpnosuidtransition_t 2>&1"
+      );
+    ok( $result, 0 );    #this should succeed
+}
+
+# Cleanup.
+system("rm -f $basedir/true");
+system("umount $basedir/testdir");
+system("rmdir $basedir/testdir");
+
+exit;
-- 
2.9.4
