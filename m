From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, toiwoton@gmail.com,
 Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 2/2] selinux-testsuite: mmap: fix shmat SHM_EXEC test for old
 policies
Date: Thu, 27 Oct 2016 14:28:45 -0400
Message-Id: <1477592925-9693-2-git-send-email-sds@tycho.nsa.gov>
In-Reply-To: <1477592925-9693-1-git-send-email-sds@tycho.nsa.gov>
References: <1477592925-9693-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Policies need not allow domains to create and use shared memory
objects by default, so we should not assume that in the test policy.
Allow it explicitly.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policy/test_mmap.te | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/policy/test_mmap.te b/policy/test_mmap.te
index 8eed390..3b92853 100644
--- a/policy/test_mmap.te
+++ b/policy/test_mmap.te
@@ -31,6 +31,8 @@ allow test_execmem_t self:process execmem;
 allow test_execmem_t test_mmap_file_t:file { open read execute };
 # For mmap_hugetlb_anon_shared test.
 allow test_execmem_t hugetlbfs_t:file { read write execute };
+# For shmat test.
+allow test_execmem_t self:shm create_shm_perms;
 # For shmat test on old kernels.
 allow test_execmem_t tmpfs_t:file { read write execute };
 
@@ -43,6 +45,8 @@ typeattribute test_no_execmem_t mmaptestdomain;
 allow test_no_execmem_t test_mmap_file_t:file { open read };
 # For mmap_hugetlb_anon_shared test.
 allow test_no_execmem_t hugetlbfs_t:file { read write };
+# For shmat test.
+allow test_no_execmem_t self:shm create_shm_perms;
 # For shmat test on old kernels: no execmem check, only tmpfs write+execute.
 allow test_no_execmem_t tmpfs_t:file { read write };
 
-- 
2.7.4
