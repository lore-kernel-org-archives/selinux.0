Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u36K1t8o008319
 for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2016 16:01:55 -0400
Received: by mail-pa0-f53.google.com with SMTP id td3so39311241pab.2
 for <selinux@tycho.nsa.gov>; Wed, 06 Apr 2016 13:01:53 -0700 (PDT)
Message-ID: <1459972910.5403.5.camel@gmail.com>
Subject: [RFC][PATCH]  selinux-testsuite: Add test for execstack on thread
 stack
From: Stephen Smalley <stephen.smalley@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Date: Wed, 06 Apr 2016 13:01:50 -0700
In-Reply-To: <1459972627.5403.2.camel@gmail.com>
References: <1459972627.5403.2.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Test execstack permission checking for thread stacks.
This depends on the corresponding kernel patch to apply
the check for thread stacks in addition to the main process
stack.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 tests/mmap/Makefile                |  2 ++
 tests/mmap/mprotect_stack_thread.c | 33 +++++++++++++++++++++++++++++++++
 tests/mmap/test                    |  8 +++++++-
 3 files changed, 42 insertions(+), 1 deletion(-)
 create mode 100644 tests/mmap/mprotect_stack_thread.c

diff --git a/tests/mmap/Makefile b/tests/mmap/Makefile
index f2f486c..e330f3e 100644
--- a/tests/mmap/Makefile
+++ b/tests/mmap/Makefile
@@ -1,5 +1,7 @@
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
+LDLIBS += -lpthread
+
 all: $(TARGETS)
 
 clean:
diff --git a/tests/mmap/mprotect_stack_thread.c b/tests/mmap/mprotect_stack_thread.c
new file mode 100644
index 0000000..457b294
--- /dev/null
+++ b/tests/mmap/mprotect_stack_thread.c
@@ -0,0 +1,33 @@
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <sys/mman.h>
+#include <pthread.h>
+
+static void *test_thread(void *p)
+{
+	char buf[4096];
+	int rc;
+	void *ptr;
+	long pagesize = sysconf(_SC_PAGESIZE);
+
+	ptr = (void *) (((unsigned long) buf) & ~(pagesize - 1));
+
+	rc = mprotect(ptr, pagesize, PROT_READ | PROT_WRITE | PROT_EXEC);
+	if (rc < 0) {
+		perror("mprotect");
+		exit(1);
+	}
+	return NULL;
+}
+
+int main(void)
+{
+	pthread_t thread;
+
+	pthread_create(&thread, NULL, test_thread, NULL);
+	pthread_join(thread, NULL);
+	exit(0);
+}
+
diff --git a/tests/mmap/test b/tests/mmap/test
index 6b1de55..89badda 100755
--- a/tests/mmap/test
+++ b/tests/mmap/test
@@ -1,7 +1,7 @@
 #!/usr/bin/perl
 
 use Test;
-BEGIN { plan tests => 30}
+BEGIN { plan tests => 32}
 
 $basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
 
@@ -68,6 +68,12 @@ ok($result, 0);
 $result = system "runcon -t test_execmem_t $basedir/mprotect_stack 2>&1";
 ok($result);
 
+# Test success and failure for thread execstack, independent of execmem.
+$result = system "runcon -t test_execstack_t $basedir/mprotect_stack_thread";
+ok($result, 0);
+$result = system "runcon -t test_execmem_t $basedir/mprotect_stack_thread 2>&1";
+ok($result);
+
 # Test success and failure for file execute on mmap w/ file shared mapping.
 $result = system "runcon -t test_file_rwx_t $basedir/mmap_file_shared $basedir/temp_file";
 ok($result, 0);
-- 
2.8.0
