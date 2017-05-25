From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux-testsuite: allow more instances of map permission
Date: Thu, 25 May 2017 14:40:36 -0400
Message-Id: <20170525184036.32327-1-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The upstream patch defining map permission for refpolicy
("refpolicy: Define and allow map permission") only adds
map permission to mmap_file_perms and exec_file_perms and to
specific interfaces where it is required.  Consequently, we need
to allow more instances of map permission in the file and mmap
test policies to avoid incorrect denials of map permission
(either ones that cause a test that should succeed to fail,
or ones that would prevent the test from reaching a later
permission check that is being tested).

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policy/test_file.te | 2 ++
 policy/test_mmap.te | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/policy/test_file.te b/policy/test_file.te
index 24c8b16..1f1da3a 100644
--- a/policy/test_file.te
+++ b/policy/test_file.te
@@ -83,6 +83,7 @@ allow fileop_t ptmx_t:chr_file { read write };
 # Permissions for the 'good' domain...
 allow test_fileop_t fileop_file_t:file { setattr rw_file_perms};
 allow test_fileop_t fileop_file_t:file { execute relabelfrom relabelto };
+allow_map(test_fileop_t, fileop_file_t, file)
 allow test_fileop_t fileop_t:process { signal };
 allow test_fileop_t ptmx_t:chr_file { open read write ioctl };
 allow test_fileop_t devpts_t:filesystem getattr;
@@ -90,6 +91,7 @@ allow test_fileop_t self:capability sys_admin;
 
 # Permissions for the 'bad' domain...
 allow test_nofileop_t nofileop_rw_file_t:file { open read write append relabelfrom };
+allow_map(test_nofileop_t, nofileop_rw_file_t, file)
 allow test_nofileop_t nofileop_ra_file_t:file { open read append };
 allow test_nofileop_t fileop_file_t:file { relabelto };
 allow test_nofileop_t ptmx_t:chr_file { open read write ioctl };
diff --git a/policy/test_mmap.te b/policy/test_mmap.te
index 1d20f30..9e2d9c9 100644
--- a/policy/test_mmap.te
+++ b/policy/test_mmap.te
@@ -96,6 +96,7 @@ unconfined_runs_test(test_no_mmap_dev_zero_t)
 typeattribute test_no_mmap_dev_zero_t testdomain;
 typeattribute test_no_mmap_dev_zero_t mmaptestdomain;
 dev_rw_zero(test_no_mmap_dev_zero_t)
+allow_map(test_no_mmap_dev_zero_t, zero_device_t, chr_file)
 
 type test_mprotect_dev_zero_t;
 domain_type(test_mprotect_dev_zero_t)
@@ -103,6 +104,7 @@ unconfined_runs_test(test_mprotect_dev_zero_t)
 typeattribute test_mprotect_dev_zero_t testdomain;
 typeattribute test_mprotect_dev_zero_t mmaptestdomain;
 dev_rw_zero(test_mprotect_dev_zero_t)
+allow_map(test_mprotect_dev_zero_t, zero_device_t, chr_file)
 # In old kernels, mprotect PROT_EXEC on /dev/zero
 # triggers a tmpfs file execute check on the kernel-internal shmem /dev/zero
 # inode.  In new kernels, mprotect PROT_EXEC will instead trigger an
@@ -117,6 +119,7 @@ unconfined_runs_test(test_no_mprotect_dev_zero_t)
 typeattribute test_no_mprotect_dev_zero_t testdomain;
 typeattribute test_no_mprotect_dev_zero_t mmaptestdomain;
 dev_rw_zero(test_no_mprotect_dev_zero_t)
+allow_map(test_no_mprotect_dev_zero_t, zero_device_t, chr_file)
 
 type test_file_rwx_t;
 domain_type(test_file_rwx_t)
-- 
2.9.4
