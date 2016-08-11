From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux-testsuite: mmap: test personality(READ_IMPLIES_EXEC)
Date: Thu, 11 Aug 2016 13:52:13 -0400
Message-Id: <1470937933-2194-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add a couple of tests to confirm that SELinux exec* checking
is applied when the program calls personality(READ_IMPLIES_EXEC)
and then calls mmap() or mprotect() without explicit PROT_EXEC.

This presumes that /sys/fs/selinux/checkreqprot == 0; otherwise,
these tests will fail.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 tests/mmap/mmap_file_shared.c | 35 +++++++++++++++++++++++++++--------
 tests/mmap/mprotect_stack.c   | 28 +++++++++++++++++++++++++---
 tests/mmap/test               | 14 +++++++++++++-
 3 files changed, 65 insertions(+), 12 deletions(-)

diff --git a/tests/mmap/mmap_file_shared.c b/tests/mmap/mmap_file_shared.c
index e64ec5f..ad349a4 100644
--- a/tests/mmap/mmap_file_shared.c
+++ b/tests/mmap/mmap_file_shared.c
@@ -4,25 +4,44 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <sys/mman.h>
+#include <sys/personality.h>
+
+void usage(const char *progname)
+{
+	fprintf(stderr, "usage: %s [-r] file\n", progname);
+	exit(1);
+}
 
 int main(int argc, char **argv)
 {
 	char *ptr;
-	int fd;
+	int fd, opt, prot = PROT_READ | PROT_WRITE | PROT_EXEC;
 
-	if (argc != 2) {
-		fprintf(stderr, "usage: %s file\n", argv[0]);
-		exit(1);
+	while ((opt = getopt(argc, argv, "r")) != -1) {
+		switch (opt) {
+		case 'r':
+			if (personality(READ_IMPLIES_EXEC) == -1) {
+				perror("personality");
+				exit(1);
+			}
+			prot &= ~PROT_EXEC;
+			break;
+		default:
+			usage(argv[0]);
+			break;
+		}
 	}
 
-	fd = open(argv[1], O_RDWR);
+	if ((argc - optind) != 1)
+		usage(argv[0]);
+
+	fd = open(argv[optind], O_RDWR);
 	if (fd < 0) {
-		perror(argv[1]);
+		perror(argv[optind]);
 		exit(1);
 	}
 
-	ptr = mmap(NULL, 4096, PROT_READ | PROT_WRITE | PROT_EXEC,
-		   MAP_SHARED, fd, 0);
+	ptr = mmap(NULL, 4096, prot, MAP_SHARED, fd, 0);
 	if (ptr == MAP_FAILED) {
 		perror("mmap");
 		close(fd);
diff --git a/tests/mmap/mprotect_stack.c b/tests/mmap/mprotect_stack.c
index 0d5a628..002bf58 100644
--- a/tests/mmap/mprotect_stack.c
+++ b/tests/mmap/mprotect_stack.c
@@ -3,17 +3,39 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <sys/mman.h>
+#include <sys/personality.h>
 
-int main(void)
+void usage(const char *progname)
+{
+	fprintf(stderr, "usage: %s [-r]\n", progname);
+	exit(1);
+}
+
+int main(int argc, char **argv)
 {
 	char buf[4096];
-	int rc;
+	int rc, opt, prot = PROT_READ | PROT_WRITE | PROT_EXEC;
 	void *ptr;
 	long pagesize = sysconf(_SC_PAGESIZE);
 
+	while ((opt = getopt(argc, argv, "r")) != -1) {
+		switch (opt) {
+		case 'r':
+			if (personality(READ_IMPLIES_EXEC) == -1) {
+				perror("personality");
+				exit(1);
+			}
+			prot &= ~PROT_EXEC;
+			break;
+		default:
+			usage(argv[0]);
+			break;
+		}
+	}
+
 	ptr = (void *) (((unsigned long) buf) & ~(pagesize - 1));
 
-	rc = mprotect(ptr, pagesize, PROT_READ | PROT_WRITE | PROT_EXEC);
+	rc = mprotect(ptr, pagesize, prot);
 	if (rc < 0) {
 		perror("mprotect");
 		exit(1);
diff --git a/tests/mmap/test b/tests/mmap/test
index 6711ba7..1e16db0 100755
--- a/tests/mmap/test
+++ b/tests/mmap/test
@@ -1,7 +1,7 @@
 #!/usr/bin/perl
 
 use Test;
-BEGIN { plan tests => 40}
+BEGIN { plan tests => 44}
 
 $basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
 
@@ -68,6 +68,12 @@ ok($result, 0);
 $result = system "runcon -t test_execmem_t $basedir/mprotect_stack 2>&1";
 ok($result);
 
+# Repeat tests using personality(READ_IMPLIES_EXEC) instead of explicit PROT_EXEC.
+$result = system "runcon -t test_execstack_t -- $basedir/mprotect_stack -r";
+ok($result, 0);
+$result = system "runcon -t test_execmem_t -- $basedir/mprotect_stack -r 2>&1";
+ok($result);
+
 # Test success and failure for thread execstack, independent of execmem.
 $result = system "runcon -t test_execstack_t $basedir/mprotect_stack_thread pass";
 ok($result, 0);
@@ -80,6 +86,12 @@ ok($result, 0);
 $result = system "runcon -t test_file_rw_t $basedir/mmap_file_shared $basedir/temp_file 2>&1";
 ok($result);
 
+# Repeat tests using personality(READ_IMPLIES_EXEC) instead of explicit PROT_EXEC.
+$result = system "runcon -t test_file_rwx_t -- $basedir/mmap_file_shared -r $basedir/temp_file";
+ok($result, 0);
+$result = system "runcon -t test_file_rw_t -- $basedir/mmap_file_shared -r $basedir/temp_file 2>&1";
+ok($result);
+
 # Test success and failure for file execute on mprotect w/ file shared mapping.
 $result = system "runcon -t test_file_rwx_t $basedir/mprotect_file_shared $basedir/temp_file";
 ok($result, 0);
-- 
2.7.4
