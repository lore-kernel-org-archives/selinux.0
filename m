From: Stephen Smalley <sds@tycho.nsa.gov>
To: paul@paul-moore.com
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux-testsuite: update mmap tests for map permission
Date: Tue,  9 May 2017 15:11:10 -0400
Message-Id: <20170509191110.21116-1-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

If the map permission is defined, allow it in the mmap test policy
for the existing mmap test domains, and introduce a new domain and test
for testing that it is enforced.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policy/Makefile       |  4 ++++
 policy/test_global.te |  4 ++++
 policy/test_mmap.te   | 20 ++++++++++++++++++++
 tests/mmap/test       | 11 +++++++++++
 4 files changed, 39 insertions(+)

diff --git a/policy/Makefile b/policy/Makefile
index 661f27a..14b215b 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -42,6 +42,10 @@ ifeq ($(shell grep -q getrlimit $(POLDEV)/include/support/all_perms.spt && echo
 TARGETS += test_prlimit.te
 endif
 
+ifeq ($(shell grep -q all_file_perms.*map $(POLDEV)/include/support/all_perms.spt && echo true),true)
+export M4PARAM = -Dmap_permission_defined
+endif
+
 ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
 TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te, $(TARGETS))
 endif
diff --git a/policy/test_global.te b/policy/test_global.te
index 9114abf..b77e025 100644
--- a/policy/test_global.te
+++ b/policy/test_global.te
@@ -95,3 +95,7 @@ ifdef(`distro_redhat', `
         auth_read_passwd(testdomain)
     ')
 ')
+
+define(`allow_map',
+ifdef(`map_permission_defined', `allow $1 $2:$3 map;')
+)
diff --git a/policy/test_mmap.te b/policy/test_mmap.te
index 3b92853..1d20f30 100644
--- a/policy/test_mmap.te
+++ b/policy/test_mmap.te
@@ -29,8 +29,10 @@ typeattribute test_execmem_t mmaptestdomain;
 allow test_execmem_t self:process execmem;
 # For mprotect_file_private test.
 allow test_execmem_t test_mmap_file_t:file { open read execute };
+allow_map(test_execmem_t, test_mmap_file_t, file)
 # For mmap_hugetlb_anon_shared test.
 allow test_execmem_t hugetlbfs_t:file { read write execute };
+allow_map(test_execmem_t, hugetlbfs_t, file)
 # For shmat test.
 allow test_execmem_t self:shm create_shm_perms;
 # For shmat test on old kernels.
@@ -43,8 +45,10 @@ typeattribute test_no_execmem_t testdomain;
 typeattribute test_no_execmem_t mmaptestdomain;
 # For mprotect_file_private test.
 allow test_no_execmem_t test_mmap_file_t:file { open read };
+allow_map(test_no_execmem_t, test_mmap_file_t, file)
 # For mmap_hugetlb_anon_shared test.
 allow test_no_execmem_t hugetlbfs_t:file { read write };
+allow_map(test_no_execmem_t, hugetlbfs_t, file)
 # For shmat test.
 allow test_no_execmem_t self:shm create_shm_perms;
 # For shmat test on old kernels: no execmem check, only tmpfs write+execute.
@@ -67,6 +71,7 @@ gen_require(`
 # We allow both permissions here so that the test passes regardless.
 allow test_mprotect_anon_shared_t tmpfs_t:file { read execute };
 allow test_mprotect_anon_shared_t hugetlbfs_t:file { read write execute };
+allow_map(test_mprotect_anon_shared_t, hugetlbfs_t, file)
 allow test_mprotect_anon_shared_t self:process execmem;
 
 type test_no_mprotect_anon_shared_t;
@@ -76,6 +81,7 @@ typeattribute test_no_mprotect_anon_shared_t testdomain;
 typeattribute test_no_mprotect_anon_shared_t mmaptestdomain;
 allow test_no_mprotect_anon_shared_t tmpfs_t:file read;
 allow test_no_mprotect_anon_shared_t hugetlbfs_t:file { read write };
+allow_map(test_no_mprotect_anon_shared_t, hugetlbfs_t, file)
 
 type test_mmap_dev_zero_t;
 domain_type(test_mmap_dev_zero_t)
@@ -118,6 +124,15 @@ unconfined_runs_test(test_file_rwx_t)
 typeattribute test_file_rwx_t testdomain;
 typeattribute test_file_rwx_t mmaptestdomain;
 allow test_file_rwx_t test_mmap_file_t:file { open read write execute };
+allow_map(test_file_rwx_t, test_mmap_file_t, file)
+
+# Same as test_file_rwx_t but intentionally omitting map permission.
+type test_no_map_t;
+domain_type(test_no_map_t)
+unconfined_runs_test(test_no_map_t)
+typeattribute test_no_map_t testdomain;
+typeattribute test_no_map_t mmaptestdomain;
+allow test_no_map_t test_mmap_file_t:file { open read write execute };
 
 type test_file_rx_t;
 domain_type(test_file_rx_t)
@@ -125,6 +140,7 @@ unconfined_runs_test(test_file_rx_t)
 typeattribute test_file_rx_t testdomain;
 typeattribute test_file_rx_t mmaptestdomain;
 allow test_file_rx_t test_mmap_file_t:file { open read execute };
+allow_map(test_file_rx_t, test_mmap_file_t, file)
 
 type test_file_rw_t;
 domain_type(test_file_rw_t)
@@ -132,6 +148,7 @@ unconfined_runs_test(test_file_rw_t)
 typeattribute test_file_rw_t testdomain;
 typeattribute test_file_rw_t mmaptestdomain;
 allow test_file_rw_t test_mmap_file_t:file { open read write };
+allow_map(test_file_rw_t, test_mmap_file_t, file)
 
 type test_file_r_t;
 domain_type(test_file_r_t)
@@ -139,6 +156,7 @@ unconfined_runs_test(test_file_r_t)
 typeattribute test_file_r_t testdomain;
 typeattribute test_file_r_t mmaptestdomain;
 allow test_file_r_t test_mmap_file_t:file { open read };
+allow_map(test_file_r_t, test_mmap_file_t, file)
 
 type test_execstack_t;
 domain_type(test_execstack_t)
@@ -160,6 +178,7 @@ unconfined_runs_test(test_execmod_t)
 typeattribute test_execmod_t testdomain;
 typeattribute test_execmod_t mmaptestdomain;
 allow test_execmod_t test_mmap_file_t:file { open read execute execmod };
+allow_map(test_execmod_t, test_mmap_file_t, file)
 
 type test_no_execmod_t;
 domain_type(test_no_execmod_t)
@@ -167,6 +186,7 @@ unconfined_runs_test(test_no_execmod_t)
 typeattribute test_no_execmod_t testdomain;
 typeattribute test_no_execmod_t mmaptestdomain;
 allow test_no_execmod_t test_mmap_file_t:file { open read execute };
+allow_map(test_no_execmod_t, test_mmap_file_t, file)
 
 # Allow entrypoint via the test programs.
 miscfiles_domain_entry_test_files(mmaptestdomain)
diff --git a/tests/mmap/test b/tests/mmap/test
index 0f09b64..6a2df8f 100755
--- a/tests/mmap/test
+++ b/tests/mmap/test
@@ -5,6 +5,7 @@ BEGIN {
 	$test_count = 34;
 	$test_hugepages = 0;
 	$test_exec_checking = 0;
+	$test_map_checking = 0;
 
 	system("echo 1 > /proc/sys/vm/nr_hugepages 2> /dev/null");
 	if (system("grep -q 1 /proc/sys/vm/nr_hugepages 2> /dev/null") == 0) {
@@ -17,6 +18,11 @@ BEGIN {
 		$test_count += 4;
 	}
 
+	if (-e '/sys/fs/selinux/class/file/perms/map') {
+		$test_map_checking = 1;
+		$test_count += 1;
+	}
+
 	plan tests => $test_count
 }
 
@@ -113,6 +119,11 @@ if ($test_exec_checking) {
 	ok($result);
 }
 
+if ($test_map_checking) {
+	$result = system "runcon -t test_no_map_t -- $basedir/mmap_file_shared $basedir/temp_file 2>&1";
+	ok($result);
+}
+
 # Test success and failure for file execute on mprotect w/ file shared mapping.
 $result = system "runcon -t test_file_rwx_t $basedir/mprotect_file_shared $basedir/temp_file";
 ok($result, 0);
-- 
2.9.3
