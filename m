From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux-testsuite: Add tests for prlimit(2) permission checks
Date: Mon, 13 Feb 2017 15:23:45 -0500
Message-Id: <1487017425-26654-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add tests for prlimit(2) permission checks for getting and
setting resource limits of other processes.  The tests are only
executed if the new getrlimit permission is defined by the base policy.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policy/Makefile        |   4 ++
 policy/test_prlimit.te |  52 ++++++++++++++++
 tests/Makefile         |   4 ++
 tests/prlimit/Makefile |   7 +++
 tests/prlimit/child.c  |  22 +++++++
 tests/prlimit/parent.c | 164 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/prlimit/test     |  30 +++++++++
 7 files changed, 283 insertions(+)
 create mode 100644 policy/test_prlimit.te
 create mode 100644 tests/prlimit/Makefile
 create mode 100644 tests/prlimit/child.c
 create mode 100644 tests/prlimit/parent.c
 create mode 100755 tests/prlimit/test

diff --git a/policy/Makefile b/policy/Makefile
index de7b950..6537b68 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -38,6 +38,10 @@ ifeq ($(shell grep -q netlink_iscsi_socket $(POLDEV)/include/support/all_perms.s
 TARGETS += test_netlink_socket.te
 endif
 
+ifeq ($(shell grep -q getrlimit $(POLDEV)/include/support/all_perms.spt && echo true),true)
+TARGETS += test_prlimit.te
+endif
+
 ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
 TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te, $(TARGETS))
 endif
diff --git a/policy/test_prlimit.te b/policy/test_prlimit.te
new file mode 100644
index 0000000..d51d692
--- /dev/null
+++ b/policy/test_prlimit.te
@@ -0,0 +1,52 @@
+########################################
+#
+# Policy for testing prlimit(2) permission checks.
+
+attribute prlimittestdomain;
+
+# prlimit_test(permission)
+# Generate a pair of test domains and rules for
+# testing the specified permission check.
+#
+define(`prlimit_test', `
+# Domain that is allowed $1 permission to the child.
+type test_$1_t;
+domain_type(test_$1_t)
+unconfined_runs_test(test_$1_t)
+typeattribute test_$1_t prlimittestdomain;
+typeattribute test_$1_t testdomain;
+
+# Child domain
+type test_$1_child_t;
+domain_type(test_$1_child_t)
+unconfined_runs_test(test_$1_child_t)
+typeattribute test_$1_child_t prlimittestdomain;
+typeattribute test_$1_child_t testdomain;
+
+# Transition from parent to child.
+spec_domtrans_pattern(test_$1_t, test_file_t, test_$1_child_t)
+
+# Allow parent $1 to child.
+allow test_$1_t test_$1_child_t:process $1;
+
+# Domain that is not allowed $1 permission.
+type test_no_$1_t;
+domain_type(test_no_$1_t)
+unconfined_runs_test(test_no_$1_t)
+typeattribute test_no_$1_t prlimittestdomain;
+typeattribute test_no_$1_t testdomain;
+
+# Transition from parent to child.
+spec_domtrans_pattern(test_no_$1_t, test_file_t, test_$1_child_t)
+')
+
+prlimit_test(setrlimit)
+prlimit_test(getrlimit)
+
+#
+# Common rules for all prlimit test domains.
+#
+
+# Entry into the test domains via the test program.
+miscfiles_domain_entry_test_files(prlimittestdomain)
+userdom_sysadm_entry_spec_domtrans_to(prlimittestdomain)
diff --git a/tests/Makefile b/tests/Makefile
index bb5868d..1311234 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -24,6 +24,10 @@ ifeq ($(shell grep -q netlink_iscsi_socket $(POLDEV)/include/support/all_perms.s
 SUBDIRS += netlink_socket
 endif
 
+ifeq ($(shell grep -q getrlimit $(POLDEV)/include/support/all_perms.spt && echo true),true)
+SUBDIRS += prlimit
+endif
+
 ifeq ($(DISTRO),RHEL4)
     SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap nnp overlay unix_socket, $(SUBDIRS))
 endif
diff --git a/tests/prlimit/Makefile b/tests/prlimit/Makefile
new file mode 100644
index 0000000..f11debe
--- /dev/null
+++ b/tests/prlimit/Makefile
@@ -0,0 +1,7 @@
+TARGETS=parent child
+
+LDLIBS += -lselinux
+
+all: $(TARGETS)
+clean:
+	rm -f $(TARGETS)
diff --git a/tests/prlimit/child.c b/tests/prlimit/child.c
new file mode 100644
index 0000000..0c385d6
--- /dev/null
+++ b/tests/prlimit/child.c
@@ -0,0 +1,22 @@
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+
+int main(void)
+{
+	char buf[1];
+	int rc;
+
+	buf[0] = 0;
+	rc = write(1, buf, sizeof buf);
+	if (rc < 0) {
+		perror("write");
+		exit(-1);
+	}
+	rc = read(0, buf, sizeof buf);
+	if (rc < 0) {
+		perror("read");
+		exit(-1);
+	}
+	exit(0);
+}
diff --git a/tests/prlimit/parent.c b/tests/prlimit/parent.c
new file mode 100644
index 0000000..be320f0
--- /dev/null
+++ b/tests/prlimit/parent.c
@@ -0,0 +1,164 @@
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+#include <errno.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/time.h>
+#include <sys/resource.h>
+#include <selinux/selinux.h>
+#include <selinux/context.h>
+
+void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s [-g] [-s soft|hard] newdomain program\n",
+		progname);
+	exit(-1);
+}
+
+#define RESOURCE RLIMIT_NOFILE
+
+int main(int argc, char **argv)
+{
+	char buf[1];
+	int pid, rc, fd[2], fd2[2], opt;
+	security_context_t context_s;
+	context_t context;
+	struct rlimit newrlim, oldrlim, *newrlimp = NULL, *oldrlimp = NULL;
+	bool get = false, set = false, soft = false;
+
+	while ((opt = getopt(argc, argv, "gs:")) != -1) {
+		switch (opt) {
+		case 'g':
+			get = true;
+			break;
+		case 's':
+			set = true;
+			if (!strcasecmp(optarg, "soft"))
+				soft = true;
+			else if (!strcasecmp(optarg, "hard"))
+				soft = false;
+			else
+				usage(argv[0]);
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	if (!get && !set) {
+		usage(argv[0]);
+		exit(-1);
+	}
+
+	if ((argc - optind) != 2) {
+		usage(argv[0]);
+		exit(-1);
+	}
+
+	rc = getcon(&context_s);
+	if (rc < 0) {
+		fprintf(stderr, "%s:  unable to get my context\n", argv[0]);
+		exit(-1);
+
+	}
+
+	context = context_new(context_s);
+	if (!context) {
+		fprintf(stderr, "%s:  unable to create context structure\n", argv[0]);
+		exit(-1);
+	}
+
+	if (context_type_set(context, argv[optind])) {
+		fprintf(stderr, "%s:  unable to set new type\n", argv[0]);
+		exit(-1);
+	}
+
+	freecon(context_s);
+	context_s = context_str(context);
+	if (!context_s) {
+		fprintf(stderr, "%s:  unable to obtain new context string\n", argv[0]);
+		exit(-1);
+	}
+
+	rc = setexeccon(context_s);
+	if (rc < 0) {
+		fprintf(stderr, "%s:  unable to set exec context to %s\n", argv[0], context_s);
+		exit(-1);
+	}
+
+	rc = getrlimit(RESOURCE, &oldrlim);
+	if (rc < 0) {
+		perror("getrlimit");
+		exit(-1);
+	}
+
+	rc = pipe(fd);
+	if (rc < 0) {
+		perror("pipe");
+		exit(-1);
+	}
+
+	rc = pipe(fd2);
+	if (rc < 0) {
+		perror("pipe");
+		exit(-1);
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		perror("fork");
+		exit(-1);
+	} else if (pid == 0) {
+		dup2(fd[0], 0);
+		dup2(fd2[1], 1);
+		execv(argv[optind + 1], argv + optind + 1);
+		buf[0] = -1;
+		write(1, buf, 1);
+		close(1);
+		perror(argv[optind + 1]);
+		exit(-1);
+	}
+
+	rc = read(fd2[0], buf, 1);
+	if (rc < 0) {
+		perror("read");
+		exit(-1);
+	}
+
+	if (get)
+		oldrlimp = &oldrlim;
+
+	if (set) {
+		newrlimp = &newrlim;
+		if (soft) {
+			newrlim.rlim_max = oldrlim.rlim_max;
+			if (newrlim.rlim_cur == RLIM_INFINITY)
+				newrlim.rlim_cur = 1024;
+			else
+				newrlim.rlim_cur = oldrlim.rlim_cur / 2;
+		} else {
+			newrlim.rlim_cur = oldrlim.rlim_cur;
+			if (newrlim.rlim_max == RLIM_INFINITY)
+				newrlim.rlim_max = 1024;
+			else
+				newrlim.rlim_max = oldrlim.rlim_max / 2;
+		}
+	}
+
+	rc =  prlimit(pid, RESOURCE, newrlimp, oldrlimp);
+	if (rc < 0) {
+		perror("prlimit");
+		write(fd[1], buf, 1);
+		close(fd[1]);
+		exit(1);
+	}
+
+	write(fd[1], buf, 1);
+	close(fd[1]);
+	exit(0);
+}
diff --git a/tests/prlimit/test b/tests/prlimit/test
new file mode 100755
index 0000000..5456ad5
--- /dev/null
+++ b/tests/prlimit/test
@@ -0,0 +1,30 @@
+#!/usr/bin/perl
+
+use Test;
+BEGIN { plan tests => 6}
+
+$basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
+
+# Verify that test_setrlimit_t can set soft limit of test_setrlimit_child_t
+$result = system ("runcon -t test_setrlimit_t $basedir/parent -s soft test_setrlimit_child_t $basedir/child 2>&1");
+ok($result, 0); # we expect this to succeed.
+
+# Verify that test_no_setrlimit_t cannot set soft limit of test_setrlimit_child_t
+$result = system ("runcon -t test_no_setrlimit_t $basedir/parent -s soft test_setrlimit_child_t $basedir/child 2>&1");
+ok($result); # we expect this to fail.
+
+# Verify that test_setrlimit_t can set hard limit of test_setrlimit_child_t
+$result = system ("runcon -t test_setrlimit_t $basedir/parent -s hard test_setrlimit_child_t $basedir/child 2>&1");
+ok($result, 0); # we expect this to succeed.
+
+# Verify that test_no_setrlimit_t cannot set hard limit of test_setrlimit_child_t
+$result = system ("runcon -t test_no_setrlimit_t $basedir/parent -s hard test_setrlimit_child_t $basedir/child 2>&1");
+ok($result); # we expect this to fail.
+
+# Verify that test_getrlimit_t can get limits of test_setrlimit_child_t
+$result = system ("runcon -t test_getrlimit_t $basedir/parent -g test_getrlimit_child_t $basedir/child 2>&1");
+ok($result, 0); # we expect this to succeed.
+
+# Verify that test_no_getrlimit_t cannot get limit of test_setrlimit_child_t
+$result = system ("runcon -t test_no_getrlimit_t $basedir/parent -g test_getrlimit_child_t $basedir/child 2>&1");
+ok($result); # we expect this to fail.
-- 
2.7.4
