From: Jan Stancek <jstancek@redhat.com>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, sds@tycho.nsa.gov, jstancek@redhat.com
Subject: [selinux-testsuite PATCH v2 3/4] mmap/mprotect_heap: make sure memory
 is allocated from heap
Date: Mon, 16 Nov 2015 10:46:26 +0100
Message-Id: <e216aafa0f8ba1092e721c7c985385dc9a95f44a.1447666725.git.jstancek@redhat.com>
In-Reply-To: <53398a996e0230fa07c82955624a474524bee50b.1446805443.git.jstancek@redhat.com>
References: <53398a996e0230fa07c82955624a474524bee50b.1446805443.git.jstancek@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This test failed on ppc64 with 64k pagesize because memory
allocation used mmap() instead of advancing heap.

Use mallopt(M_MMAP_THRESHOLD,..) with large enough value
to discourage use of mmap().

Also set length in mprotect to pagesize, kernel silently aligns
it to pagesize anyway.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
---
 tests/mmap/mprotect_heap.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tests/mmap/mprotect_heap.c b/tests/mmap/mprotect_heap.c
index 691299493c3f..23de4de5be62 100644
--- a/tests/mmap/mprotect_heap.c
+++ b/tests/mmap/mprotect_heap.c
@@ -3,6 +3,11 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <sys/mman.h>
+#include <malloc.h>
+
+#ifndef DEFAULT_MMAP_THRESHOLD_MAX
+#define DEFAULT_MMAP_THRESHOLD_MAX 512*1024
+#endif
 
 int main(void)
 {
@@ -10,13 +15,19 @@ int main(void)
 	int rc;
 	int pagesize = getpagesize();
 
+	rc = mallopt(M_MMAP_THRESHOLD, DEFAULT_MMAP_THRESHOLD_MAX);
+	if (rc != 1) {
+		fprintf(stderr, "mallopt failed: %d\n", rc);
+		exit(1);
+	}
+
 	rc = posix_memalign(&ptr, pagesize, pagesize);
 	if (rc) {
 		fprintf(stderr, "posix_memalign failed: %d\n", rc);
 		exit(1);
 	}
 
-	rc = mprotect(ptr, 4096, PROT_READ | PROT_EXEC);
+	rc = mprotect(ptr, pagesize, PROT_READ | PROT_EXEC);
 	if (rc < 0) {
 		perror("mprotect");
 		exit(1);
-- 
1.8.3.1
