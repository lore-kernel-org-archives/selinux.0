From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, toiwoton@gmail.com,
 Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 1/2] selinux-testsuite: mmap: fix shmat SHM_EXEC test for old
 kernels
Date: Thu, 27 Oct 2016 14:28:44 -0400
Message-Id: <1477592925-9693-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Older kernels checked read+write+execute to the backing tmpfs
file for shmat SHM_EXEC instead of execmem.  Adjust the test policy
to allow the tests to pass on these older kernels.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policy/test_mmap.te | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/policy/test_mmap.te b/policy/test_mmap.te
index e039f76..8eed390 100644
--- a/policy/test_mmap.te
+++ b/policy/test_mmap.te
@@ -31,6 +31,8 @@ allow test_execmem_t self:process execmem;
 allow test_execmem_t test_mmap_file_t:file { open read execute };
 # For mmap_hugetlb_anon_shared test.
 allow test_execmem_t hugetlbfs_t:file { read write execute };
+# For shmat test on old kernels.
+allow test_execmem_t tmpfs_t:file { read write execute };
 
 type test_no_execmem_t;
 domain_type(test_no_execmem_t)
@@ -41,6 +43,8 @@ typeattribute test_no_execmem_t mmaptestdomain;
 allow test_no_execmem_t test_mmap_file_t:file { open read };
 # For mmap_hugetlb_anon_shared test.
 allow test_no_execmem_t hugetlbfs_t:file { read write };
+# For shmat test on old kernels: no execmem check, only tmpfs write+execute.
+allow test_no_execmem_t tmpfs_t:file { read write };
 
 type test_mprotect_anon_shared_t;
 domain_type(test_mprotect_anon_shared_t)
-- 
2.7.4
