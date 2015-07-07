From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] selinux-testsuite: Add tests for mmap/mprotect
Date: Tue,  7 Jul 2015 16:35:43 -0400
Message-Id: <1436301343-3945-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add a set of tests for mmap and mprotect, covering
mmap_zero, execmem, execstack, execheap, execmod,
file execute for shared anonymous mappings (internal
shmem /dev/zero file), and file execute for regular files.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 ToDo                                       |   1 -
 policy/Makefile                            |   3 +-
 policy/test_mmap.te                        | 116 +++++++++++++++++++++++++++++
 tests/Makefile                             |   2 +-
 tests/mmap/Makefile                        |   6 ++
 tests/mmap/mmap_anon_private.c             |  19 +++++
 tests/mmap/mmap_anon_shared.c              |  19 +++++
 tests/mmap/mmap_file_private.c             |  34 +++++++++
 tests/mmap/mmap_file_shared.c              |  34 +++++++++
 tests/mmap/mmap_zero.c                     |  19 +++++
 tests/mmap/mprotect_anon_private.c         |  26 +++++++
 tests/mmap/mprotect_anon_shared.c          |  26 +++++++
 tests/mmap/mprotect_file_private_execmod.c |  41 ++++++++++
 tests/mmap/mprotect_file_private_rwx.c     |  39 ++++++++++
 tests/mmap/mprotect_file_private_rx.c      |  39 ++++++++++
 tests/mmap/mprotect_file_shared.c          |  39 ++++++++++
 tests/mmap/mprotect_heap.c                 |  26 +++++++
 tests/mmap/mprotect_stack.c                |  23 ++++++
 tests/mmap/test                            |  96 ++++++++++++++++++++++++
 19 files changed, 605 insertions(+), 3 deletions(-)
 create mode 100644 policy/test_mmap.te
 create mode 100644 tests/mmap/Makefile
 create mode 100644 tests/mmap/mmap_anon_private.c
 create mode 100644 tests/mmap/mmap_anon_shared.c
 create mode 100644 tests/mmap/mmap_file_private.c
 create mode 100644 tests/mmap/mmap_file_shared.c
 create mode 100644 tests/mmap/mmap_zero.c
 create mode 100644 tests/mmap/mprotect_anon_private.c
 create mode 100644 tests/mmap/mprotect_anon_shared.c
 create mode 100644 tests/mmap/mprotect_file_private_execmod.c
 create mode 100644 tests/mmap/mprotect_file_private_rwx.c
 create mode 100644 tests/mmap/mprotect_file_private_rx.c
 create mode 100644 tests/mmap/mprotect_file_shared.c
 create mode 100644 tests/mmap/mprotect_heap.c
 create mode 100644 tests/mmap/mprotect_stack.c
 create mode 100755 tests/mmap/test

diff --git a/ToDo b/ToDo
index 8b656c5..06f8aaf 100644
--- a/ToDo
+++ b/ToDo
@@ -11,7 +11,6 @@ Add tests for netlink sockets, including nlmsg_read/write/... permissions.
 ioctl: Test new ioctl whitelisting feature.
 Generalize or duplicate nnp tests for nosuid mount case.
 Add tests for mount and umount, including permission checks and context-related mount options.
-Add tests for mmap/mprotect for execmem, execstack, execheap, execmod, mmap_zero.
 Add tests for CAP_MAC_ADMIN/mac_admin and its effect on setting/getting security contexts unknown to the currently loaded policy.
 Add tests for new file labeling: type_transition, setfscreatecon, context mounts.
 Add tests for inheritance across domain-changing exec: noatsecure, siginh, rlimitinh.
diff --git a/policy/Makefile b/policy/Makefile
index 742fd03..98fccbc 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -19,7 +19,8 @@ TARGETS = \
 	test_setnice.te test_sigkill.te test_stat.te test_sysctl.te \
 	test_task_create.te test_task_getpgid.te test_task_getsched.te \
 	test_task_getsid.te test_task_setpgid.te test_task_setsched.te \
-	test_transition.te test_inet_socket.te test_unix_socket.te test_wait.te
+	test_transition.te test_inet_socket.te test_unix_socket.te \
+	test_wait.te test_mmap.te
 
 ifeq ($(shell [ $(POL_VERS) -ge 24 ] && echo true),true)
 TARGETS += test_bounds.te
diff --git a/policy/test_mmap.te b/policy/test_mmap.te
new file mode 100644
index 0000000..0246e31
--- /dev/null
+++ b/policy/test_mmap.te
@@ -0,0 +1,116 @@
+#################################
+#
+# Policy for testing mmap/mprotect
+#
+
+attribute mmaptestdomain;
+
+type test_mmap_zero_t;
+domain_type(test_mmap_zero_t)
+unconfined_runs_test(test_mmap_zero_t)
+typeattribute test_mmap_zero_t testdomain;
+typeattribute test_mmap_zero_t mmaptestdomain;
+allow test_mmap_zero_t self:memprotect mmap_zero;
+
+type test_no_mmap_zero_t;
+domain_type(test_no_mmap_zero_t)
+unconfined_runs_test(test_no_mmap_zero_t)
+typeattribute test_no_mmap_zero_t testdomain;
+typeattribute test_no_mmap_zero_t mmaptestdomain;
+
+type test_mmap_file_t;
+files_type(test_mmap_file_t)
+
+type test_execmem_t;
+domain_type(test_execmem_t)
+unconfined_runs_test(test_execmem_t)
+typeattribute test_execmem_t testdomain;
+typeattribute test_execmem_t mmaptestdomain;
+allow test_execmem_t self:process execmem;
+# For mprotect_file_private test.
+allow test_execmem_t test_mmap_file_t:file { open read execute };
+
+type test_no_execmem_t;
+domain_type(test_no_execmem_t)
+unconfined_runs_test(test_no_execmem_t)
+typeattribute test_no_execmem_t testdomain;
+typeattribute test_no_execmem_t mmaptestdomain;
+# For mprotect_file_private test.
+allow test_no_execmem_t test_mmap_file_t:file { open read };
+
+type test_tmpfs_execute_t;
+domain_type(test_tmpfs_execute_t)
+unconfined_runs_test(test_tmpfs_execute_t)
+typeattribute test_tmpfs_execute_t testdomain;
+typeattribute test_tmpfs_execute_t mmaptestdomain;
+
+gen_require(`
+	type tmpfs_t;
+')
+allow test_tmpfs_execute_t tmpfs_t:file { read write execute };
+
+type test_no_tmpfs_execute_t;
+domain_type(test_no_tmpfs_execute_t)
+unconfined_runs_test(test_no_tmpfs_execute_t)
+typeattribute test_no_tmpfs_execute_t testdomain;
+typeattribute test_no_tmpfs_execute_t mmaptestdomain;
+allow test_no_tmpfs_execute_t tmpfs_t:file { read write };
+
+type test_file_rwx_t;
+domain_type(test_file_rwx_t)
+unconfined_runs_test(test_file_rwx_t)
+typeattribute test_file_rwx_t testdomain;
+typeattribute test_file_rwx_t mmaptestdomain;
+allow test_file_rwx_t test_mmap_file_t:file { open read write execute };
+
+type test_file_rx_t;
+domain_type(test_file_rx_t)
+unconfined_runs_test(test_file_rx_t)
+typeattribute test_file_rx_t testdomain;
+typeattribute test_file_rx_t mmaptestdomain;
+allow test_file_rx_t test_mmap_file_t:file { open read execute };
+
+type test_file_rw_t;
+domain_type(test_file_rw_t)
+unconfined_runs_test(test_file_rw_t)
+typeattribute test_file_rw_t testdomain;
+typeattribute test_file_rw_t mmaptestdomain;
+allow test_file_rw_t test_mmap_file_t:file { open read write };
+
+type test_file_r_t;
+domain_type(test_file_r_t)
+unconfined_runs_test(test_file_r_t)
+typeattribute test_file_r_t testdomain;
+typeattribute test_file_r_t mmaptestdomain;
+allow test_file_r_t test_mmap_file_t:file { open read };
+
+type test_execstack_t;
+domain_type(test_execstack_t)
+unconfined_runs_test(test_execstack_t)
+typeattribute test_execstack_t testdomain;
+typeattribute test_execstack_t mmaptestdomain;
+allow test_execstack_t self:process { execmem execstack };
+
+type test_execheap_t;
+domain_type(test_execheap_t)
+unconfined_runs_test(test_execheap_t)
+typeattribute test_execheap_t testdomain;
+typeattribute test_execheap_t mmaptestdomain;
+allow test_execheap_t self:process { execmem execheap };
+
+type test_execmod_t;
+domain_type(test_execmod_t)
+unconfined_runs_test(test_execmod_t)
+typeattribute test_execmod_t testdomain;
+typeattribute test_execmod_t mmaptestdomain;
+allow test_execmod_t test_mmap_file_t:file { open read execute execmod };
+
+type test_no_execmod_t;
+domain_type(test_no_execmod_t)
+unconfined_runs_test(test_no_execmod_t)
+typeattribute test_no_execmod_t testdomain;
+typeattribute test_no_execmod_t mmaptestdomain;
+allow test_no_execmod_t test_mmap_file_t:file { open read execute };
+
+# Allow entrypoint via the test programs.
+miscfiles_domain_entry_test_files(mmaptestdomain)
diff --git a/tests/Makefile b/tests/Makefile
index 507123b..f92e6a1 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -3,7 +3,7 @@ export CFLAGS+=-g -O0 -Wall -D_GNU_SOURCE
 
 DISTRO=$(shell ./os_detect)
 
-SUBDIRS_COMMON:=domain_trans entrypoint execshare exectrace execute_no_trans fdreceive inherit link mkdir msg open ptrace readlink relabel rename rxdir sem setattr setnice shm sigkill stat sysctl task_create task_setnice task_setscheduler task_getscheduler task_getsid task_getpgid task_setpgid wait file ioctl capable_file capable_net capable_sys unix_socket
+SUBDIRS_COMMON:=domain_trans entrypoint execshare exectrace execute_no_trans fdreceive inherit link mkdir msg open ptrace readlink relabel rename rxdir sem setattr setnice shm sigkill stat sysctl task_create task_setnice task_setscheduler task_getscheduler task_getsid task_getpgid task_setpgid wait file ioctl capable_file capable_net capable_sys unix_socket mmap
 
 SUBDIRS:= $(SUBDIRS_COMMON) dyntrans dyntrace bounds nnp inet_socket
 
diff --git a/tests/mmap/Makefile b/tests/mmap/Makefile
new file mode 100644
index 0000000..f2f486c
--- /dev/null
+++ b/tests/mmap/Makefile
@@ -0,0 +1,6 @@
+TARGETS=$(patsubst %.c,%,$(wildcard *.c))
+
+all: $(TARGETS)
+
+clean:
+	rm -f $(TARGETS)
diff --git a/tests/mmap/mmap_anon_private.c b/tests/mmap/mmap_anon_private.c
new file mode 100644
index 0000000..43be6f7
--- /dev/null
+++ b/tests/mmap/mmap_anon_private.c
@@ -0,0 +1,19 @@
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <sys/mman.h>
+
+int main(void)
+{
+	char *ptr;
+
+	ptr = mmap(NULL, 4096, PROT_READ | PROT_WRITE | PROT_EXEC,
+		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (ptr == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+	exit(0);
+}
+
diff --git a/tests/mmap/mmap_anon_shared.c b/tests/mmap/mmap_anon_shared.c
new file mode 100644
index 0000000..821ca04
--- /dev/null
+++ b/tests/mmap/mmap_anon_shared.c
@@ -0,0 +1,19 @@
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <sys/mman.h>
+
+int main(void)
+{
+	char *ptr;
+
+	ptr = mmap(NULL, 4096, PROT_READ | PROT_WRITE | PROT_EXEC,
+		   MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	if (ptr == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+	exit(0);
+}
+
diff --git a/tests/mmap/mmap_file_private.c b/tests/mmap/mmap_file_private.c
new file mode 100644
index 0000000..148701e
--- /dev/null
+++ b/tests/mmap/mmap_file_private.c
@@ -0,0 +1,34 @@
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+
+int main(int argc, char **argv)
+{
+	char *ptr;
+	int fd;
+
+	if (argc != 2) {
+		fprintf(stderr, "usage: %s file\n", argv[0]);
+		exit(1);
+	}
+
+	fd = open(argv[1], O_RDONLY);
+	if (fd < 0) {
+		perror(argv[1]);
+		exit(1);
+	}
+
+	ptr = mmap(NULL, 4096, PROT_READ | PROT_WRITE | PROT_EXEC,
+		   MAP_PRIVATE, fd, 0);
+	if (ptr == MAP_FAILED) {
+		perror("mmap");
+		close(fd);
+		exit(1);
+	}
+	close(fd);
+	exit(0);
+}
+
diff --git a/tests/mmap/mmap_file_shared.c b/tests/mmap/mmap_file_shared.c
new file mode 100644
index 0000000..e64ec5f
--- /dev/null
+++ b/tests/mmap/mmap_file_shared.c
@@ -0,0 +1,34 @@
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+
+int main(int argc, char **argv)
+{
+	char *ptr;
+	int fd;
+
+	if (argc != 2) {
+		fprintf(stderr, "usage: %s file\n", argv[0]);
+		exit(1);
+	}
+
+	fd = open(argv[1], O_RDWR);
+	if (fd < 0) {
+		perror(argv[1]);
+		exit(1);
+	}
+
+	ptr = mmap(NULL, 4096, PROT_READ | PROT_WRITE | PROT_EXEC,
+		   MAP_SHARED, fd, 0);
+	if (ptr == MAP_FAILED) {
+		perror("mmap");
+		close(fd);
+		exit(1);
+	}
+	close(fd);
+	exit(0);
+}
+
diff --git a/tests/mmap/mmap_zero.c b/tests/mmap/mmap_zero.c
new file mode 100644
index 0000000..8b6e19c
--- /dev/null
+++ b/tests/mmap/mmap_zero.c
@@ -0,0 +1,19 @@
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <sys/mman.h>
+
+int main(void)
+{
+	char *ptr;
+
+	ptr = mmap(0, 4096, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
+	if (ptr == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+	exit(0);
+}
+
diff --git a/tests/mmap/mprotect_anon_private.c b/tests/mmap/mprotect_anon_private.c
new file mode 100644
index 0000000..6bea5eb
--- /dev/null
+++ b/tests/mmap/mprotect_anon_private.c
@@ -0,0 +1,26 @@
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <sys/mman.h>
+
+int main(void)
+{
+	char *ptr;
+	int rc;
+
+	ptr = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1,
+		   0);
+	if (ptr == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+
+	rc = mprotect(ptr, 4096, PROT_READ | PROT_EXEC);
+	if (rc < 0) {
+		perror("mprotect");
+		exit(1);
+	}
+	exit(0);
+}
+
diff --git a/tests/mmap/mprotect_anon_shared.c b/tests/mmap/mprotect_anon_shared.c
new file mode 100644
index 0000000..a6bed97
--- /dev/null
+++ b/tests/mmap/mprotect_anon_shared.c
@@ -0,0 +1,26 @@
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <sys/mman.h>
+
+int main(void)
+{
+	char *ptr;
+	int rc;
+
+	ptr = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1,
+		   0);
+	if (ptr == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+
+	rc = mprotect(ptr, 4096, PROT_READ | PROT_EXEC);
+	if (rc < 0) {
+		perror("mprotect");
+		exit(1);
+	}
+	exit(0);
+}
+
diff --git a/tests/mmap/mprotect_file_private_execmod.c b/tests/mmap/mprotect_file_private_execmod.c
new file mode 100644
index 0000000..ade1981
--- /dev/null
+++ b/tests/mmap/mprotect_file_private_execmod.c
@@ -0,0 +1,41 @@
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+
+int main(int argc, char **argv)
+{
+	char *ptr;
+	int rc;
+	int fd;
+
+	if (argc != 2) {
+		fprintf(stderr, "usage: %s file\n", argv[0]);
+		exit(1);
+	}
+
+	fd = open(argv[1], O_RDONLY);
+	if (fd < 0) {
+		perror(argv[1]);
+		exit(1);
+	}
+
+	ptr = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd,
+		   0);
+	if (ptr == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+
+	*((char *)ptr) = 42;
+
+	rc = mprotect(ptr, 4096, PROT_READ | PROT_EXEC);
+	if (rc < 0) {
+		perror("mprotect");
+		exit(1);
+	}
+	exit(0);
+}
+
diff --git a/tests/mmap/mprotect_file_private_rwx.c b/tests/mmap/mprotect_file_private_rwx.c
new file mode 100644
index 0000000..1fd26ca
--- /dev/null
+++ b/tests/mmap/mprotect_file_private_rwx.c
@@ -0,0 +1,39 @@
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+
+int main(int argc, char **argv)
+{
+	char *ptr;
+	int rc;
+	int fd;
+
+	if (argc != 2) {
+		fprintf(stderr, "usage: %s file\n", argv[0]);
+		exit(1);
+	}
+
+	fd = open(argv[1], O_RDONLY);
+	if (fd < 0) {
+		perror(argv[1]);
+		exit(1);
+	}
+
+	ptr = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd,
+		   0);
+	if (ptr == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+
+	rc = mprotect(ptr, 4096, PROT_READ | PROT_WRITE | PROT_EXEC);
+	if (rc < 0) {
+		perror("mprotect");
+		exit(1);
+	}
+	exit(0);
+}
+
diff --git a/tests/mmap/mprotect_file_private_rx.c b/tests/mmap/mprotect_file_private_rx.c
new file mode 100644
index 0000000..7cb1eb9
--- /dev/null
+++ b/tests/mmap/mprotect_file_private_rx.c
@@ -0,0 +1,39 @@
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+
+int main(int argc, char **argv)
+{
+	char *ptr;
+	int rc;
+	int fd;
+
+	if (argc != 2) {
+		fprintf(stderr, "usage: %s file\n", argv[0]);
+		exit(1);
+	}
+
+	fd = open(argv[1], O_RDONLY);
+	if (fd < 0) {
+		perror(argv[1]);
+		exit(1);
+	}
+
+	ptr = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd,
+		   0);
+	if (ptr == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+
+	rc = mprotect(ptr, 4096, PROT_READ | PROT_EXEC);
+	if (rc < 0) {
+		perror("mprotect");
+		exit(1);
+	}
+	exit(0);
+}
+
diff --git a/tests/mmap/mprotect_file_shared.c b/tests/mmap/mprotect_file_shared.c
new file mode 100644
index 0000000..d1e5465
--- /dev/null
+++ b/tests/mmap/mprotect_file_shared.c
@@ -0,0 +1,39 @@
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+
+int main(int argc, char **argv)
+{
+	char *ptr;
+	int rc;
+	int fd;
+
+	if (argc != 2) {
+		fprintf(stderr, "usage: %s file\n", argv[0]);
+		exit(1);
+	}
+
+	fd = open(argv[1], O_RDWR);
+	if (fd < 0) {
+		perror(argv[1]);
+		exit(1);
+	}
+
+	ptr = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
+		   0);
+	if (ptr == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+
+	rc = mprotect(ptr, 4096, PROT_READ | PROT_EXEC);
+	if (rc < 0) {
+		perror("mprotect");
+		exit(1);
+	}
+	exit(0);
+}
+
diff --git a/tests/mmap/mprotect_heap.c b/tests/mmap/mprotect_heap.c
new file mode 100644
index 0000000..6912994
--- /dev/null
+++ b/tests/mmap/mprotect_heap.c
@@ -0,0 +1,26 @@
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <sys/mman.h>
+
+int main(void)
+{
+	void *ptr;
+	int rc;
+	int pagesize = getpagesize();
+
+	rc = posix_memalign(&ptr, pagesize, pagesize);
+	if (rc) {
+		fprintf(stderr, "posix_memalign failed: %d\n", rc);
+		exit(1);
+	}
+
+	rc = mprotect(ptr, 4096, PROT_READ | PROT_EXEC);
+	if (rc < 0) {
+		perror("mprotect");
+		exit(1);
+	}
+	exit(0);
+}
+
diff --git a/tests/mmap/mprotect_stack.c b/tests/mmap/mprotect_stack.c
new file mode 100644
index 0000000..0d5a628
--- /dev/null
+++ b/tests/mmap/mprotect_stack.c
@@ -0,0 +1,23 @@
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <sys/mman.h>
+
+int main(void)
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
+	exit(0);
+}
+
diff --git a/tests/mmap/test b/tests/mmap/test
new file mode 100755
index 0000000..4337b43
--- /dev/null
+++ b/tests/mmap/test
@@ -0,0 +1,96 @@
+#!/usr/bin/perl
+
+use Test;
+BEGIN { plan tests => 26}
+
+$basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
+
+# Clean up from prior runs.
+system "rm -f $basedir/temp_file";
+
+# Create temporary file.
+system "dd if=/dev/zero of=$basedir/temp_file count=8 2>&1 > /dev/null";
+system "chcon -t test_mmap_file_t $basedir/temp_file";
+
+# Test success and failure for mmap_zero.
+$result = system "runcon -t test_mmap_zero_t $basedir/mmap_zero";
+ok($result, 0);
+$result = system "runcon -t test_no_mmap_zero_t $basedir/mmap_zero 2>&1";
+ok($result);
+
+# Test success and failure for execmem on mmap w/ anonymous private memory.
+$result = system "runcon -t test_execmem_t $basedir/mmap_anon_private";
+ok($result, 0);
+$result = system "runcon -t test_no_execmem_t $basedir/mmap_anon_private 2>&1";
+ok($result);
+
+# Test success and failure for execmem on mprotect w/ anonymous private memory.
+$result = system "runcon -t test_execmem_t $basedir/mprotect_anon_private";
+ok($result, 0);
+$result = system "runcon -t test_no_execmem_t $basedir/mprotect_anon_private 2>&1";
+ok($result);
+
+# Test success and failure for execmem on mmap w/ anonymous shared memory.
+$result = system "runcon -t test_execmem_t $basedir/mmap_anon_shared";
+ok($result, 0);
+$result = system "runcon -t test_no_execmem_t $basedir/mmap_anon_shared 2>&1";
+ok($result);
+
+# Test success and failure for tmpfs execute on mprotect w/ anonymous shared memory.
+$result = system "runcon -t test_tmpfs_execute_t $basedir/mprotect_anon_shared";
+ok($result, 0);
+$result = system "runcon -t test_no_tmpfs_execute_t $basedir/mprotect_anon_shared 2>&1";
+ok($result);
+
+# Test success and failure for execheap, independent of execmem.
+$result = system "runcon -t test_execheap_t $basedir/mprotect_heap";
+ok($result, 0);
+$result = system "runcon -t test_execmem_t $basedir/mprotect_heap 2>&1";
+ok($result);
+
+# Test success and failure for execstack, independent of execmem.
+$result = system "runcon -t test_execstack_t $basedir/mprotect_stack";
+ok($result, 0);
+$result = system "runcon -t test_execmem_t $basedir/mprotect_stack 2>&1";
+ok($result);
+
+# Test success and failure for file execute on mmap w/ file shared mapping.
+$result = system "runcon -t test_file_rwx_t $basedir/mmap_file_shared $basedir/temp_file";
+ok($result, 0);
+$result = system "runcon -t test_file_rw_t $basedir/mmap_file_shared $basedir/temp_file 2>&1";
+ok($result);
+
+# Test success and failure for file execute on mprotect w/ file shared mapping.
+$result = system "runcon -t test_file_rwx_t $basedir/mprotect_file_shared $basedir/temp_file";
+ok($result, 0);
+$result = system "runcon -t test_file_rw_t $basedir/mprotect_file_shared $basedir/temp_file 2>&1";
+ok($result);
+
+# Test success and failure for execmem on mmap w/ file private mapping.
+$result = system "runcon -t test_execmem_t $basedir/mmap_file_private $basedir/temp_file";
+ok($result, 0);
+$result = system "runcon -t test_no_execmem_t $basedir/mmap_file_private $basedir/temp_file 2>&1";
+ok($result);
+
+# Test success and failure for file execute on mprotect w/ file private mapping.
+$result = system "runcon -t test_file_rx_t $basedir/mprotect_file_private_rx $basedir/temp_file";
+ok($result, 0);
+$result = system "runcon -t test_file_r_t $basedir/mprotect_file_private_rx $basedir/temp_file 2>&1";
+ok($result);
+
+# Test success and failure for execmem on mprotect w/ file private mapping.
+$result = system "runcon -t test_execmem_t $basedir/mprotect_file_private_rwx $basedir/temp_file";
+ok($result, 0);
+$result = system "runcon -t test_no_execmem_t $basedir/mprotect_file_private_rwx $basedir/temp_file 2>&1";
+ok($result);
+
+# Test success and failure for file execmod on mprotect w/ file private mapping.
+$result = system "runcon -t test_execmod_t $basedir/mprotect_file_private_execmod $basedir/temp_file";
+ok($result, 0);
+$result = system "runcon -t test_no_execmod_t $basedir/mprotect_file_private_execmod $basedir/temp_file 2>&1";
+ok($result);
+
+# Clean up from prior runs.
+system "rm -f $basedir/temp_file";
+
+exit;
-- 
2.1.0
