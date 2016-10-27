From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, toiwoton@gmail.com,
 Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux-testsuite: mmap: add shmat SHM_EXEC test
Date: Thu, 27 Oct 2016 10:22:21 -0400
Message-Id: <1477578141-13143-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Topi Miettinen asked whether execmem should disable
shmat(...,SHM_EXEC) and provided a test program for it.
SELinux does check execmem in this case already via
the security_mmap_file hook call in do_shmat(), but this
test is useful to ensure we do not regress in this area.
Modified the test program to test for shmget() failure since
that is possible and would render the shmat() test moot,
and to remove the arch-specific portion since we are only
testing SELinux enforcement during shmat() itself, not
the subsequent ability to execute the code and since
the selinux-testsuite is run on multiple architectures.
The test program is run twice by the test script, once
in a domain that is allowed execmem and once in a domain
that is not, in order to ensure that it succeeds
in the former case and fails in the latter, as we do for
all of the tests.

Suggested-by: Topi Miettinen <toiwoton@gmail.com>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 tests/mmap/shmat.c | 26 ++++++++++++++++++++++++++
 tests/mmap/test    |  8 +++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 tests/mmap/shmat.c

diff --git a/tests/mmap/shmat.c b/tests/mmap/shmat.c
new file mode 100644
index 0000000..4467d64
--- /dev/null
+++ b/tests/mmap/shmat.c
@@ -0,0 +1,26 @@
+#include <sys/ipc.h>
+#include <sys/types.h>
+#include <sys/shm.h>
+#include <stdlib.h>
+#include <stdio.h>
+
+int main(void)
+{
+	int shmid, rc = 0;
+	char *execmem;
+
+	shmid = shmget(IPC_PRIVATE, 4096, IPC_CREAT | 0777);
+	if (shmid < 0) {
+		perror("shmget");
+		exit(1);
+	}
+	execmem = shmat(shmid, 0, SHM_EXEC);
+	if (execmem == ((void *) -1)) {
+		perror("shmat SHM_EXEC");
+		rc = 1;
+	} else {
+		shmdt(execmem);
+	}
+	shmctl(shmid, IPC_RMID, 0);
+	exit(rc);
+}
diff --git a/tests/mmap/test b/tests/mmap/test
index 1e16db0..831a854 100755
--- a/tests/mmap/test
+++ b/tests/mmap/test
@@ -1,7 +1,7 @@
 #!/usr/bin/perl
 
 use Test;
-BEGIN { plan tests => 44}
+BEGIN { plan tests => 46}
 
 $basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
 
@@ -150,6 +150,12 @@ ok($result);
 
 system "echo 0 > /proc/sys/vm/nr_hugepages";
 
+# Test success and failure for execmem on shmat SHM_EXEC.
+$result = system "runcon -t test_execmem_t $basedir/shmat";
+ok($result, 0);
+$result = system "runcon -t test_no_execmem_t $basedir/shmat 2>&1";
+ok($result);
+
 # Clean up from prior runs.
 system "rm -f $basedir/temp_file";
 
-- 
2.7.4
