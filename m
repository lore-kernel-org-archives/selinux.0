From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, casey@schaufler-ca.com,
 Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux-testsuite: Add CAP_MAC_ADMIN tests
Date: Thu, 20 Apr 2017 11:35:15 -0400
Message-Id: <20170420153515.10589-1-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add a set of tests for SELinux CAP_MAC_ADMIN checking, which controls
the ability to get or set a raw, uninterpreted security context unknown
to the currently loaded security policy.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policy/Makefile          |  2 +-
 policy/test_mac_admin.te | 52 +++++++++++++++++++++++++++++++++++++++++++++
 tests/Makefile           |  2 +-
 tests/mac_admin/Makefile |  2 ++
 tests/mac_admin/test     | 55 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 111 insertions(+), 2 deletions(-)
 create mode 100644 policy/test_mac_admin.te
 create mode 100644 tests/mac_admin/Makefile
 create mode 100755 tests/mac_admin/test

diff --git a/policy/Makefile b/policy/Makefile
index 6537b68..661f27a 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -20,7 +20,7 @@ TARGETS = \
 	test_task_create.te test_task_getpgid.te test_task_getsched.te \
 	test_task_getsid.te test_task_setpgid.te test_task_setsched.te \
 	test_transition.te test_inet_socket.te test_unix_socket.te \
-	test_mmap.te test_overlayfs.te test_mqueue.te
+	test_mmap.te test_overlayfs.te test_mqueue.te test_mac_admin.te
 
 ifeq ($(shell [ $(POL_VERS) -ge 24 ] && echo true),true)
 TARGETS += test_bounds.te
diff --git a/policy/test_mac_admin.te b/policy/test_mac_admin.te
new file mode 100644
index 0000000..579a017
--- /dev/null
+++ b/policy/test_mac_admin.te
@@ -0,0 +1,52 @@
+########################################
+#
+# Policy for testing mac_admin permission checks.
+
+attribute mac_admintestdomain;
+
+# Domain that is allowed mac_admin.
+type test_mac_admin_t;
+domain_type(test_mac_admin_t)
+unconfined_runs_test(test_mac_admin_t)
+typeattribute test_mac_admin_t mac_admintestdomain;
+typeattribute test_mac_admin_t testdomain;
+
+# Relabeling a file to an undefined label remaps it to the unlabeled context,
+# which may have a different SELinux user identity (e.g. system_u).
+# This would go in the common section below but the interface only
+# accepts types, not attributes.
+domain_obj_id_change_exemption(test_mac_admin_t)
+
+# Relabeling a file to an unknown label requires mac_admin permission.
+allow test_mac_admin_t self:capability2 mac_admin;
+
+# Domain that is not allowed mac_admin permission.
+type test_no_mac_admin_t;
+domain_type(test_no_mac_admin_t)
+unconfined_runs_test(test_no_mac_admin_t)
+typeattribute test_no_mac_admin_t mac_admintestdomain;
+typeattribute test_no_mac_admin_t testdomain;
+
+# See above.
+domain_obj_id_change_exemption(test_no_mac_admin_t)
+
+#
+# Common rules for all mac_admin test domains.
+#
+
+# Relabeling a file to an undefined label requires relabelfrom
+# the old file label and relabelto the unlabeled type.  We also
+# require getattr to both types for stat and getfilecon calls.
+allow mac_admintestdomain test_file_t:file { getattr relabelfrom };
+allow mac_admintestdomain unlabeled_t:file { getattr relabelto };
+
+# Creating a directory in an undefined label requires search/write/add_name
+# to the parent directory and create to the new directory. We also
+# allow getattr to permit stat and getfilecon.
+allow mac_admintestdomain test_file_t:dir { search write add_name };
+allow mac_admintestdomain test_file_t:dir { getattr create };
+allow mac_admintestdomain unlabeled_t:dir { getattr create };
+
+# Entry into the test domains via the test program.
+corecmd_bin_entry_type(mac_admintestdomain)
+userdom_sysadm_entry_spec_domtrans_to(mac_admintestdomain)
diff --git a/tests/Makefile b/tests/Makefile
index 4e5e7c0..fb8a0aa 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -10,7 +10,7 @@ SUBDIRS:=domain_trans entrypoint execshare exectrace execute_no_trans \
 	task_setnice task_setscheduler task_getscheduler task_getsid \
 	task_getpgid task_setpgid file ioctl capable_file capable_net \
 	capable_sys dyntrans dyntrace bounds nnp mmap unix_socket inet_socket \
-	overlay checkreqprot mqueue
+	overlay checkreqprot mqueue mac_admin
 
 ifeq ($(shell grep -q cap_userns $(POLDEV)/include/support/all_perms.spt && echo true),true)
 ifneq ($(shell ./kvercmp $$(uname -r) 4.7),-1)
diff --git a/tests/mac_admin/Makefile b/tests/mac_admin/Makefile
new file mode 100644
index 0000000..e7c006f
--- /dev/null
+++ b/tests/mac_admin/Makefile
@@ -0,0 +1,2 @@
+all:
+clean:
diff --git a/tests/mac_admin/test b/tests/mac_admin/test
new file mode 100755
index 0000000..8a186f3
--- /dev/null
+++ b/tests/mac_admin/test
@@ -0,0 +1,55 @@
+#!/usr/bin/perl
+
+use Test;
+BEGIN { plan tests => 8}
+
+$basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
+
+# Verify that test_mac_admin_t can relabel a file to an undefined context.
+system("rm -f $basedir/test_file; touch $basedir/test_file");
+$result = system ("runcon -t test_mac_admin_t -- chcon -t UNDEFINED $basedir/test_file 2>&1");
+ok($result, 0); # we expect this to succeed.
+
+# Verify that test_mac_admin_t sees the undefined context.
+$result = `runcon -t test_mac_admin_t -- secon -t -f $basedir/test_file 2>&1`;
+chomp($result);
+ok($result, "UNDEFINED");
+
+# Verify that test_no_mac_admin_t sees the unlabeled context
+$result = `runcon -t test_no_mac_admin_t -- secon -t -f $basedir/test_file 2>&1`;
+chomp($result);
+ok($result, "unlabeled_t");
+
+# Delete the test file.
+system("rm -f $basedir/test_file");
+
+# Verify that test_mac_admin_t can create a directory with an undefined label.
+system("rm -rf $basedir/test_dir");
+$result = system ("runcon -t test_mac_admin_t -- mkdir --context=system_u:object_r:UNDEFINED:s0 $basedir/test_dir 2>&1");
+ok($result, 0); # we expect this to succeed.
+
+# Verify that test_mac_admin_t sees the undefined label value.
+$result = `runcon -t test_mac_admin_t -- secon -t -f $basedir/test_dir 2>&1`;
+chomp($result);
+ok($result, "UNDEFINED");
+
+# Verify that test_no_mac_admin_t sees the unlabeled context.
+$result = `runcon -t test_no_mac_admin_t -- secon -t -f $basedir/test_dir 2>&1`;
+chomp($result);
+ok($result, "unlabeled_t");
+
+# Delete the test directory
+system("rm -rf $basedir/test_dir");
+
+# Verify that test_no_mac_admin_t cannot set an undefined label on a file
+system("rm -f $basedir/test_file; touch $basedir/test_file");
+$result = system ("runcon -t test_no_mac_admin_t -- chcon -t UNDEFINED $basedir/test_file  2>&1");
+ok($result); # we expect this to fail.
+
+# Verify that test_no_mac_admin_t cannot create a directory with an undefined context
+system("rm -rf $basedir/test_dir");
+$result = system ("runcon -t test_no_mac_admin_t -- mkdir --context=UNDEFINED $basedir/test_dir 2>&1");
+ok($result); # we expect this to fail.
+
+# cleanup
+system("rm -rf $basedir/test_file $basedir/test_dir");
-- 
2.9.3
