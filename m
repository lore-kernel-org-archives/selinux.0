From: Jan Stancek <jstancek@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, paul@paul-moore.com, jstancek@redhat.com
Subject: [selinux-testsuite PATCH 4/4] mmap/mprotect_file_private_execmod:
 clear READ_IMPLIES_EXEC
Date: Fri,  6 Nov 2015 14:07:24 +0100
Message-Id: <c1be558e303328e7d4cc3d592789588da7de2f4a.1446805443.git.jstancek@redhat.com>
In-Reply-To: <cover.1446805443.git.jstancek@redhat.com>
References: <cover.1446805443.git.jstancek@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

If READ_IMPLIES_EXEC personality is set, mmap-ed area will have
VM_EXEC vm_flag set, which causes selinux_file_mprotect() to
skip check for FILE__EXECMOD.

This caused that older (2.6.32) kernels on s390x always allowed
mprotect to succeed.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
---
 tests/mmap/mprotect_file_private_execmod.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tests/mmap/mprotect_file_private_execmod.c b/tests/mmap/mprotect_file_private_execmod.c
index ade19811290a..6d6b995fc03c 100644
--- a/tests/mmap/mprotect_file_private_execmod.c
+++ b/tests/mmap/mprotect_file_private_execmod.c
@@ -4,6 +4,11 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <sys/mman.h>
+#include <sys/personality.h>
+
+#ifndef READ_IMPLIES_EXEC
+#define READ_IMPLIES_EXEC 0x0400000
+#endif
 
 int main(int argc, char **argv)
 {
@@ -16,6 +21,14 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
+	/* clear READ_IMPLIES_EXEC if present, because it skips
+	 * check for FILE__EXECMOD in selinux_file_mprotect() */
+	rc = personality(0xffffffff);
+	if ((rc != -1) && (rc & READ_IMPLIES_EXEC)) {
+		rc &= ~READ_IMPLIES_EXEC;
+		personality(rc);
+	}
+
 	fd = open(argv[1], O_RDONLY);
 	if (fd < 0) {
 		perror(argv[1]);
-- 
1.8.3.1
