From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux-testsuite: mmap: add tests for hugetlb anon mappings
Date: Thu, 11 Aug 2016 13:41:16 -0400
Message-Id: <1470937276-31004-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Anonymous hugetlb mappings are treated as file mappings since
they operate on an internally created hugetlb file.  Test that
the appropriate file execute checks are applied on mmap and mprotect.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policy/test_mmap.te                        |  7 +++++++
 tests/mmap/mmap_hugetlb_anon_private.c     | 20 ++++++++++++++++++++
 tests/mmap/mmap_hugetlb_anon_shared.c      | 20 ++++++++++++++++++++
 tests/mmap/mprotect_hugetlb_anon_private.c | 28 ++++++++++++++++++++++++++++
 tests/mmap/mprotect_hugetlb_anon_shared.c  | 28 ++++++++++++++++++++++++++++
 tests/mmap/test                            | 30 +++++++++++++++++++++++++++++-
 6 files changed, 132 insertions(+), 1 deletion(-)
 create mode 100644 tests/mmap/mmap_hugetlb_anon_private.c
 create mode 100644 tests/mmap/mmap_hugetlb_anon_shared.c
 create mode 100644 tests/mmap/mprotect_hugetlb_anon_private.c
 create mode 100644 tests/mmap/mprotect_hugetlb_anon_shared.c

diff --git a/policy/test_mmap.te b/policy/test_mmap.te
index 2a66514..e039f76 100644
--- a/policy/test_mmap.te
+++ b/policy/test_mmap.te
@@ -29,6 +29,8 @@ typeattribute test_execmem_t mmaptestdomain;
 allow test_execmem_t self:process execmem;
 # For mprotect_file_private test.
 allow test_execmem_t test_mmap_file_t:file { open read execute };
+# For mmap_hugetlb_anon_shared test.
+allow test_execmem_t hugetlbfs_t:file { read write execute };
 
 type test_no_execmem_t;
 domain_type(test_no_execmem_t)
@@ -37,6 +39,8 @@ typeattribute test_no_execmem_t testdomain;
 typeattribute test_no_execmem_t mmaptestdomain;
 # For mprotect_file_private test.
 allow test_no_execmem_t test_mmap_file_t:file { open read };
+# For mmap_hugetlb_anon_shared test.
+allow test_no_execmem_t hugetlbfs_t:file { read write };
 
 type test_mprotect_anon_shared_t;
 domain_type(test_mprotect_anon_shared_t)
@@ -46,6 +50,7 @@ typeattribute test_mprotect_anon_shared_t mmaptestdomain;
 
 gen_require(`
 	type tmpfs_t;
+	type hugetlbfs_t;
 ')
 # In old kernels, mprotect PROT_EXEC on an anonymous shared mapping
 # triggers a tmpfs file execute check on the kernel-internal shmem /dev/zero
@@ -53,6 +58,7 @@ gen_require(`
 # execmem check, making it consistent with the mmap PROT_EXEC case.
 # We allow both permissions here so that the test passes regardless.
 allow test_mprotect_anon_shared_t tmpfs_t:file { read execute };
+allow test_mprotect_anon_shared_t hugetlbfs_t:file { read write execute };
 allow test_mprotect_anon_shared_t self:process execmem;
 
 type test_no_mprotect_anon_shared_t;
@@ -61,6 +67,7 @@ unconfined_runs_test(test_no_mprotect_anon_shared_t)
 typeattribute test_no_mprotect_anon_shared_t testdomain;
 typeattribute test_no_mprotect_anon_shared_t mmaptestdomain;
 allow test_no_mprotect_anon_shared_t tmpfs_t:file read;
+allow test_no_mprotect_anon_shared_t hugetlbfs_t:file { read write };
 
 type test_mmap_dev_zero_t;
 domain_type(test_mmap_dev_zero_t)
diff --git a/tests/mmap/mmap_hugetlb_anon_private.c b/tests/mmap/mmap_hugetlb_anon_private.c
new file mode 100644
index 0000000..71c1be6
--- /dev/null
+++ b/tests/mmap/mmap_hugetlb_anon_private.c
@@ -0,0 +1,20 @@
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <sys/mman.h>
+
+#define LENGTH (2*1024*1024)
+
+int main(void)
+{
+	char *ptr;
+
+	ptr = mmap(NULL, LENGTH, PROT_READ | PROT_WRITE | PROT_EXEC,
+		   MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
+	if (ptr == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+	exit(0);
+}
diff --git a/tests/mmap/mmap_hugetlb_anon_shared.c b/tests/mmap/mmap_hugetlb_anon_shared.c
new file mode 100644
index 0000000..fff10fa
--- /dev/null
+++ b/tests/mmap/mmap_hugetlb_anon_shared.c
@@ -0,0 +1,20 @@
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <sys/mman.h>
+
+#define LENGTH (2*1024*1024)
+
+int main(void)
+{
+	char *ptr;
+
+	ptr = mmap(NULL, LENGTH, PROT_READ | PROT_WRITE | PROT_EXEC,
+		   MAP_SHARED | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
+	if (ptr == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+	exit(0);
+}
diff --git a/tests/mmap/mprotect_hugetlb_anon_private.c b/tests/mmap/mprotect_hugetlb_anon_private.c
new file mode 100644
index 0000000..2201244
--- /dev/null
+++ b/tests/mmap/mprotect_hugetlb_anon_private.c
@@ -0,0 +1,28 @@
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <sys/mman.h>
+
+#define LENGTH (2*1024*1024)
+
+int main(void)
+{
+	char *ptr;
+	int rc;
+
+	ptr = mmap(NULL, LENGTH, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1,
+		   0);
+	if (ptr == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+
+	rc = mprotect(ptr, LENGTH, PROT_READ | PROT_EXEC);
+	if (rc < 0) {
+		perror("mprotect");
+		exit(1);
+	}
+	exit(0);
+}
diff --git a/tests/mmap/mprotect_hugetlb_anon_shared.c b/tests/mmap/mprotect_hugetlb_anon_shared.c
new file mode 100644
index 0000000..4181fdb
--- /dev/null
+++ b/tests/mmap/mprotect_hugetlb_anon_shared.c
@@ -0,0 +1,28 @@
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <sys/mman.h>
+
+#define LENGTH (2*1024*1024)
+
+int main(void)
+{
+	char *ptr;
+	int rc;
+
+	ptr = mmap(NULL, LENGTH, PROT_READ | PROT_WRITE,
+		   MAP_SHARED | MAP_ANONYMOUS | MAP_HUGETLB, -1,
+		   0);
+	if (ptr == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+
+	rc = mprotect(ptr, LENGTH, PROT_READ | PROT_EXEC);
+	if (rc < 0) {
+		perror("mprotect");
+		exit(1);
+	}
+	exit(0);
+}
diff --git a/tests/mmap/test b/tests/mmap/test
index e1c2942..6711ba7 100755
--- a/tests/mmap/test
+++ b/tests/mmap/test
@@ -1,7 +1,7 @@
 #!/usr/bin/perl
 
 use Test;
-BEGIN { plan tests => 32}
+BEGIN { plan tests => 40}
 
 $basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
 
@@ -110,6 +110,34 @@ ok($result, 0);
 $result = system "runcon -t test_no_execmod_t $basedir/mprotect_file_private_execmod $basedir/temp_file 2>&1";
 ok($result);
 
+system "echo 1 > /proc/sys/vm/nr_hugepages";
+
+# Test success and failure for execmem on mmap w/ hugetlb anonymous shared memory.
+$result = system "runcon -t test_execmem_t $basedir/mmap_hugetlb_anon_shared";
+ok($result, 0);
+$result = system "runcon -t test_no_execmem_t $basedir/mmap_hugetlb_anon_shared 2>&1";
+ok($result);
+
+# Test success and failure for execmem on mprotect w/ hugetlb anonymous shared memory.
+$result = system "runcon -t test_mprotect_anon_shared_t $basedir/mprotect_hugetlb_anon_shared";
+ok($result, 0);
+$result = system "runcon -t test_no_mprotect_anon_shared_t $basedir/mprotect_hugetlb_anon_shared 2>&1";
+ok($result);
+
+# Test success and failure for execmem on mmap w/ hugetlb anonymous private memory.
+$result = system "runcon -t test_execmem_t $basedir/mmap_hugetlb_anon_private";
+ok($result, 0);
+$result = system "runcon -t test_no_execmem_t $basedir/mmap_hugetlb_anon_private 2>&1";
+ok($result);
+
+# Test success and failure for execmem on mprotect w/ hugetlb anonymous private memory.
+$result = system "runcon -t test_mprotect_anon_shared_t $basedir/mprotect_hugetlb_anon_private";
+ok($result, 0);
+$result = system "runcon -t test_no_mprotect_anon_shared_t $basedir/mprotect_hugetlb_anon_private 2>&1";
+ok($result);
+
+system "echo 0 > /proc/sys/vm/nr_hugepages";
+
 # Clean up from prior runs.
 system "rm -f $basedir/temp_file";
 
-- 
2.7.4
