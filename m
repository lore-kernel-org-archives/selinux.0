From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux-testsuite: Test ioctl xperms
Date: Wed, 17 May 2017 10:45:13 -0400
Message-Id: <20170517144513.19131-1-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Extend the existing ioctl tests with a simple test for the ioctl
xperms support.  This depends on:
1) checkmodule that supports module policy version >= 18,
2) kernel that supports kernel policy version >= 30.

The tests are automatically skipped if xperms are not supported
by checkmodule or the kernel.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policy/Makefile             |  6 ++++++
 policy/test_ioctl_xperms.te | 18 ++++++++++++++++++
 tests/ioctl/test            | 33 +++++++++++++++++++++++++++++++--
 3 files changed, 55 insertions(+), 2 deletions(-)
 create mode 100644 policy/test_ioctl_xperms.te

diff --git a/policy/Makefile b/policy/Makefile
index 14b215b..7bc7f95 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -2,11 +2,13 @@
 POLDEV ?= /usr/share/selinux/devel
 SEMODULE = /usr/sbin/semodule
 CHECKPOLICY = /usr/bin/checkpolicy
+CHECKMODULE = /usr/bin/checkmodule
 
 DISTRO=$(shell ../tests/os_detect)
 RHEL_VERS=$(shell echo $(DISTRO) | sed 's/RHEL//')
 
 POL_VERS := $(shell $(CHECKPOLICY) -V |cut -f 1 -d ' ')
+MOD_POL_VERS := $(shell $(CHECKMODULE) -V |cut -f 2 -d '-')
 
 TARGETS = \
 	test_global.te test_capable_file.te test_capable_net.te \
@@ -26,6 +28,10 @@ ifeq ($(shell [ $(POL_VERS) -ge 24 ] && echo true),true)
 TARGETS += test_bounds.te
 endif
 
+ifeq ($(shell [ $(MOD_POL_VERS) -ge 18 ] && echo true),true)
+TARGETS += test_ioctl_xperms.te
+endif
+
 ifeq ($(shell grep -q cap_userns $(POLDEV)/include/support/all_perms.spt && echo true),true)
 TARGETS += test_cap_userns.te
 endif
diff --git a/policy/test_ioctl_xperms.te b/policy/test_ioctl_xperms.te
new file mode 100644
index 0000000..f9bc8d5
--- /dev/null
+++ b/policy/test_ioctl_xperms.te
@@ -0,0 +1,18 @@
+define(`FIOCLEX', `{ 0x00006601 0x00005451 }')
+
+# Domain for process that is allowed the required ioctl xperms.
+type test_ioctl_xperm_t;
+domain_type(test_ioctl_xperm_t)
+unconfined_runs_test(test_ioctl_xperm_t)
+typeattribute test_ioctl_xperm_t ioctldomain;
+typeattribute test_ioctl_xperm_t testdomain;
+allow test_ioctl_xperm_t test_ioctl_file_t:file { open read write ioctl getattr setattr };
+allowxperm test_ioctl_xperm_t test_ioctl_file_t:file ioctl FIOCLEX;
+
+# Domain for process that is not allowed the required ioctl xperms.
+type test_ioctl_noxperm_t;
+domain_type(test_ioctl_noxperm_t)
+unconfined_runs_test(test_ioctl_noxperm_t)
+typeattribute test_ioctl_noxperm_t ioctldomain;
+typeattribute test_ioctl_noxperm_t testdomain;
+allowxperm test_ioctl_noxperm_t test_ioctl_file_t:file ioctl ~FIOCLEX;
diff --git a/tests/ioctl/test b/tests/ioctl/test
index 7ce2c9e..fb84bae 100755
--- a/tests/ioctl/test
+++ b/tests/ioctl/test
@@ -4,7 +4,21 @@
 #
 
 use Test;
-BEGIN { plan tests => 2}
+BEGIN {
+    $test_count = 2;
+    $test_xperms = 0;
+
+    $modver = `checkmodule -V | cut -f 2 -d -`;
+    $selinuxfs = `cat /proc/mounts | grep selinuxfs | cut -f 2 -d ' '`;
+    chomp($selinuxfs);
+    $kernver = `cat $selinuxfs/policyvers`;
+    if ($modver >= 18 && $kernver >= 30) {
+	$test_xperms = 1;
+	$test_count += 2;
+    }
+
+    plan tests => $test_count
+}
 
 $basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
 
@@ -26,7 +40,22 @@ ok($result, 0);
 # individual calls, so we expect success always from that program.
 #
 $result = system "runcon -t test_noioctl_t -- $basedir/test_noioctl $basedir/temp_file 2>&1";
-ok($result, 0); 
+ok($result, 0);
+
+if ($test_xperms) {
+    #
+    # Attempt to perform the ioctls with the required ioctl xperms.
+    #
+    $result = system "runcon -t test_ioctl_xperm_t -- $basedir/test_ioctl $basedir/temp_file 2>&1";
+    ok($result, 0);
+
+
+    #
+    # Attempt to perform the ioctls without the required ioctl xperm.
+    #
+    $result = system "runcon -t test_ioctl_noxperm_t -- $basedir/test_ioctl $basedir/temp_file 2>&1";
+    ok($result);
+}
 
 system "rm -f $basedir/temp_file 2>&1";
 
-- 
2.9.3
