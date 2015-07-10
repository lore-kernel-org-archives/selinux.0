From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] selinux-testsuite: update for mprotect PROT_EXEC regression
 fix
Date: Fri, 10 Jul 2015 17:02:37 -0400
Message-Id: <1436562157-30142-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

commit 66fc13039422ba7df2d01a8ee0873e4ef965b50b ("mm: shmem_zero_setup skip
security check and lockdep conflict with XFS") caused a regression for
SELinux by disabling any SELinux checking of mprotect PROT_EXEC on
shared anonymous mappings.  Previously SELinux was applying a tmpfs
file execute check in this situation because the kernel created an internal
shmem dev/zero file for the mapping.  commit
892e8cac99a71f6254f84fc662068d912e1943bf ("selinux: fix mprotect
PROT_EXEC regression caused by mm change") fixed the regression by changing
SELinux to detect and apply an execmem check on private inodes, making the
mmap and mprotect checking consistent for shared anonymous mappings as well
as for /dev/zero and ashmem.  Update the SELinux test policy and case for
mprotect PROT_EXEC of shared anonymous mappings so that it will pass
on both kernels that predate the regression and on kernels that include
the fix despite the difference in permission checking, only failing on
kernels the completely omit the checking (e.g. 4.1, 4.2-rc1).  Rename
the test domain to more accurately reflect its purpose.

Also add new tests for mmap/mprotect PROT_EXEC /dev/zero.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policy/test_mmap.te | 67 ++++++++++++++++++++++++++++++++++++++++++-----------
 tests/mmap/test     | 22 ++++++++++++++----
 2 files changed, 72 insertions(+), 17 deletions(-)

diff --git a/policy/test_mmap.te b/policy/test_mmap.te
index 0246e31..2a66514 100644
--- a/policy/test_mmap.te
+++ b/policy/test_mmap.te
@@ -38,23 +38,64 @@ typeattribute test_no_execmem_t mmaptestdomain;
 # For mprotect_file_private test.
 allow test_no_execmem_t test_mmap_file_t:file { open read };
 
-type test_tmpfs_execute_t;
-domain_type(test_tmpfs_execute_t)
-unconfined_runs_test(test_tmpfs_execute_t)
-typeattribute test_tmpfs_execute_t testdomain;
-typeattribute test_tmpfs_execute_t mmaptestdomain;
+type test_mprotect_anon_shared_t;
+domain_type(test_mprotect_anon_shared_t)
+unconfined_runs_test(test_mprotect_anon_shared_t)
+typeattribute test_mprotect_anon_shared_t testdomain;
+typeattribute test_mprotect_anon_shared_t mmaptestdomain;
 
 gen_require(`
 	type tmpfs_t;
 ')
-allow test_tmpfs_execute_t tmpfs_t:file { read write execute };
-
-type test_no_tmpfs_execute_t;
-domain_type(test_no_tmpfs_execute_t)
-unconfined_runs_test(test_no_tmpfs_execute_t)
-typeattribute test_no_tmpfs_execute_t testdomain;
-typeattribute test_no_tmpfs_execute_t mmaptestdomain;
-allow test_no_tmpfs_execute_t tmpfs_t:file { read write };
+# In old kernels, mprotect PROT_EXEC on an anonymous shared mapping
+# triggers a tmpfs file execute check on the kernel-internal shmem /dev/zero
+# inode.  In new kernels, mprotect PROT_EXEC will instead trigger an
+# execmem check, making it consistent with the mmap PROT_EXEC case.
+# We allow both permissions here so that the test passes regardless.
+allow test_mprotect_anon_shared_t tmpfs_t:file { read execute };
+allow test_mprotect_anon_shared_t self:process execmem;
+
+type test_no_mprotect_anon_shared_t;
+domain_type(test_no_mprotect_anon_shared_t)
+unconfined_runs_test(test_no_mprotect_anon_shared_t)
+typeattribute test_no_mprotect_anon_shared_t testdomain;
+typeattribute test_no_mprotect_anon_shared_t mmaptestdomain;
+allow test_no_mprotect_anon_shared_t tmpfs_t:file read;
+
+type test_mmap_dev_zero_t;
+domain_type(test_mmap_dev_zero_t)
+unconfined_runs_test(test_mmap_dev_zero_t)
+typeattribute test_mmap_dev_zero_t testdomain;
+typeattribute test_mmap_dev_zero_t mmaptestdomain;
+dev_rwx_zero(test_mmap_dev_zero_t)
+
+type test_no_mmap_dev_zero_t;
+domain_type(test_no_mmap_dev_zero_t)
+unconfined_runs_test(test_no_mmap_dev_zero_t)
+typeattribute test_no_mmap_dev_zero_t testdomain;
+typeattribute test_no_mmap_dev_zero_t mmaptestdomain;
+dev_rw_zero(test_no_mmap_dev_zero_t)
+
+type test_mprotect_dev_zero_t;
+domain_type(test_mprotect_dev_zero_t)
+unconfined_runs_test(test_mprotect_dev_zero_t)
+typeattribute test_mprotect_dev_zero_t testdomain;
+typeattribute test_mprotect_dev_zero_t mmaptestdomain;
+dev_rw_zero(test_mprotect_dev_zero_t)
+# In old kernels, mprotect PROT_EXEC on /dev/zero
+# triggers a tmpfs file execute check on the kernel-internal shmem /dev/zero
+# inode.  In new kernels, mprotect PROT_EXEC will instead trigger an
+# execmem check, making it consistent with the mmap PROT_EXEC case.
+# We allow both permissions here so that the test passes regardless.
+allow test_mprotect_dev_zero_t tmpfs_t:file { read execute };
+allow test_mprotect_dev_zero_t self:process execmem;
+
+type test_no_mprotect_dev_zero_t;
+domain_type(test_no_mprotect_dev_zero_t)
+unconfined_runs_test(test_no_mprotect_dev_zero_t)
+typeattribute test_no_mprotect_dev_zero_t testdomain;
+typeattribute test_no_mprotect_dev_zero_t mmaptestdomain;
+dev_rw_zero(test_no_mprotect_dev_zero_t)
 
 type test_file_rwx_t;
 domain_type(test_file_rwx_t)
diff --git a/tests/mmap/test b/tests/mmap/test
index 4337b43..6b1de55 100755
--- a/tests/mmap/test
+++ b/tests/mmap/test
@@ -1,7 +1,7 @@
 #!/usr/bin/perl
 
 use Test;
-BEGIN { plan tests => 26}
+BEGIN { plan tests => 30}
 
 $basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
 
@@ -36,10 +36,24 @@ ok($result, 0);
 $result = system "runcon -t test_no_execmem_t $basedir/mmap_anon_shared 2>&1";
 ok($result);
 
-# Test success and failure for tmpfs execute on mprotect w/ anonymous shared memory.
-$result = system "runcon -t test_tmpfs_execute_t $basedir/mprotect_anon_shared";
+# Test success and failure for mmap /dev/zero.
+$result = system "runcon -t test_mmap_dev_zero_t $basedir/mmap_file_shared /dev/zero";
 ok($result, 0);
-$result = system "runcon -t test_no_tmpfs_execute_t $basedir/mprotect_anon_shared 2>&1";
+$result = system "runcon -t test_no_mmap_dev_zero_t $basedir/mmap_file_shared /dev/zero 2>&1";
+ok($result);
+
+# Test success and failure for mprotect w/ anonymous shared memory.
+# In old kernels, this triggers a tmpfs file execute check.
+# In new kernels, it triggers an execmem check.
+$result = system "runcon -t test_mprotect_anon_shared_t $basedir/mprotect_anon_shared";
+ok($result, 0);
+$result = system "runcon -t test_no_mprotect_anon_shared_t $basedir/mprotect_anon_shared 2>&1";
+ok($result);
+
+# Test success and failure for mprotect /dev/zero.
+$result = system "runcon -t test_mprotect_dev_zero_t $basedir/mprotect_file_shared /dev/zero";
+ok($result, 0);
+$result = system "runcon -t test_no_mprotect_dev_zero_t $basedir/mprotect_file_shared /dev/zero 2>&1";
 ok($result);
 
 # Test success and failure for execheap, independent of execmem.
-- 
2.1.0
