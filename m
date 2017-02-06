From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux-testsuite: add tests for new netlink socket classes
Date: Mon,  6 Feb 2017 16:43:26 -0500
Message-Id: <1486417406-29267-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add tests for the new netlink socket classes introduced by
kernel commit 6c6d2e9bde1c1c87a7ead806f8f5e2181d41a652 ("selinux:
update netlink socket classes") circa Linux 4.2.

A representative sampling of the new netlink socket classes are
tested, including netlink_iscsi_socket, netlink_netfilter_socket,
netlink_generic, and netlink_crypto.  The tests verify that a domain
can create a socket with the corresponding netlink protocol iff it has
the necessary permissions to the corresponding new netlink socket class.

The tests are only run if the new netlink socket classes are defined
in the base policy.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 policy/Makefile                      |  4 ++
 policy/test_netlink_socket.te        | 50 +++++++++++++++++++++++++
 tests/Makefile                       |  4 ++
 tests/netlink_socket/Makefile        |  4 ++
 tests/netlink_socket/netlinkcreate.c | 72 ++++++++++++++++++++++++++++++++++++
 tests/netlink_socket/test            | 38 +++++++++++++++++++
 6 files changed, 172 insertions(+)
 create mode 100644 policy/test_netlink_socket.te
 create mode 100644 tests/netlink_socket/Makefile
 create mode 100644 tests/netlink_socket/netlinkcreate.c
 create mode 100755 tests/netlink_socket/test

diff --git a/policy/Makefile b/policy/Makefile
index 6a9e6e4..de7b950 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -34,6 +34,10 @@ ifeq ($(shell grep -q icmp_socket $(POLDEV)/include/support/all_perms.spt && ech
 TARGETS += test_extended_socket_class.te
 endif
 
+ifeq ($(shell grep -q netlink_iscsi_socket $(POLDEV)/include/support/all_perms.spt && echo true),true)
+TARGETS += test_netlink_socket.te
+endif
+
 ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
 TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te, $(TARGETS))
 endif
diff --git a/policy/test_netlink_socket.te b/policy/test_netlink_socket.te
new file mode 100644
index 0000000..b56c06c
--- /dev/null
+++ b/policy/test_netlink_socket.te
@@ -0,0 +1,50 @@
+########################################
+#
+# Policy for testing the new netlink socket classes.
+
+attribute netlinksocktestdomain;
+
+#
+# netlink_socket_test(newclass)
+#
+# Generate a pair of test domains and rules to test
+# that the kernel checks permission against the
+# 'newclass' security class rather than the generic
+# 'netlink_socket' security class.
+#
+define(`netlink_socket_test', `
+# Domain that is allowed to create $1_socket.
+type test_$1_t;
+domain_type(test_$1_t)
+unconfined_runs_test(test_$1_t)
+typeattribute test_$1_t netlinksocktestdomain;
+typeattribute test_$1_t testdomain;
+
+# Allow $1 but not netlink_socket.
+# This is to ensure that the kernel is checking the right class.
+allow test_$1_t self:$1 create_socket_perms;
+
+# Domain that is not allowed to create $1.
+type test_no_$1_t;
+domain_type(test_no_$1_t)
+unconfined_runs_test(test_no_$1_t)
+typeattribute test_no_$1_t netlinksocktestdomain;
+typeattribute test_no_$1_t testdomain;
+
+# Allow netlink_socket but not $1.
+# This is to ensure that the kernel is checking the right class.
+allow test_no_$1_t self:netlink_socket create_socket_perms;
+')
+
+netlink_socket_test(netlink_iscsi_socket)
+netlink_socket_test(netlink_netfilter_socket)
+netlink_socket_test(netlink_generic_socket)
+netlink_socket_test(netlink_crypto_socket)
+
+#
+# Common rules for all netlink socket class test domains.
+#
+
+# Entry into the test domains via the test program.
+miscfiles_domain_entry_test_files(netlinksocktestdomain)
+userdom_sysadm_entry_spec_domtrans_to(netlinksocktestdomain)
diff --git a/tests/Makefile b/tests/Makefile
index 53f256a..bb5868d 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -20,6 +20,10 @@ ifeq ($(shell grep -q icmp_socket $(POLDEV)/include/support/all_perms.spt && gre
 SUBDIRS += extended_socket_class
 endif
 
+ifeq ($(shell grep -q netlink_iscsi_socket $(POLDEV)/include/support/all_perms.spt && echo true),true)
+SUBDIRS += netlink_socket
+endif
+
 ifeq ($(DISTRO),RHEL4)
     SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap nnp overlay unix_socket, $(SUBDIRS))
 endif
diff --git a/tests/netlink_socket/Makefile b/tests/netlink_socket/Makefile
new file mode 100644
index 0000000..8dce555
--- /dev/null
+++ b/tests/netlink_socket/Makefile
@@ -0,0 +1,4 @@
+TARGETS=$(patsubst %.c,%,$(wildcard *.c))
+all: $(TARGETS)
+clean:
+	rm -f $(TARGETS)
diff --git a/tests/netlink_socket/netlinkcreate.c b/tests/netlink_socket/netlinkcreate.c
new file mode 100644
index 0000000..3f20589
--- /dev/null
+++ b/tests/netlink_socket/netlinkcreate.c
@@ -0,0 +1,72 @@
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <linux/netlink.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+
+struct nameval {
+	const char *name;
+	const int value;
+};
+
+static struct nameval protocols[] = {
+	{ "route", NETLINK_ROUTE },
+	{ "sock_diag", NETLINK_SOCK_DIAG },
+	{ "nflog", NETLINK_NFLOG },
+	{ "xfrm", NETLINK_XFRM },
+	{ "selinux", NETLINK_SELINUX },
+	{ "iscsi", NETLINK_ISCSI },
+	{ "audit", NETLINK_AUDIT },
+	{ "fib_lookup", NETLINK_FIB_LOOKUP },
+	{ "connector", NETLINK_CONNECTOR },
+	{ "netfilter", NETLINK_NETFILTER },
+	{ "dnrtmsg", NETLINK_DNRTMSG },
+	{ "kobject_uevent", NETLINK_KOBJECT_UEVENT },
+	{ "generic", NETLINK_GENERIC },
+	{ "scsitransport", NETLINK_SCSITRANSPORT },
+	{ "rdma", NETLINK_RDMA },
+	{ "crypto", NETLINK_CRYPTO },
+	{ NULL, 0 }
+};
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+static int lookup_value(const char *name, const struct nameval *nvlist)
+{
+	const struct nameval *nv;
+
+	for (nv = nvlist; nv->name; nv++) {
+		if (!strcmp(nv->name, name))
+			return nv->value;
+	}
+	return -1;
+}
+
+int main(int argc, char **argv)
+{
+	int sock;
+	int protocol;
+
+	if (argc != 2) {
+		fprintf(stderr, "usage: %s protocol\n", argv[0]);
+		exit(1);
+	}
+
+	protocol = lookup_value(argv[1], protocols);
+	if (protocol < 0) {
+		fprintf(stderr, "%s: unknown protocol %s\n", argv[0], argv[1]);
+		exit(1);
+	}
+
+	sock = socket(AF_NETLINK, SOCK_DGRAM, protocol);
+	if (sock < 0) {
+		fprintf(stderr, "%s: socket(AF_NETLINK, SOCK_DGRAM, %s/%d): %s\n",
+			argv[0], argv[1], protocol, strerror(errno));
+		exit(1);
+	}
+	close(sock);
+	exit(0);
+}
diff --git a/tests/netlink_socket/test b/tests/netlink_socket/test
new file mode 100755
index 0000000..c38672e
--- /dev/null
+++ b/tests/netlink_socket/test
@@ -0,0 +1,38 @@
+#!/usr/bin/perl
+
+use Test;
+BEGIN { plan tests => 8 };
+
+$basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
+
+# Verify that test_netlink_iscsi_socket_t can create a NETLINK_ISCSI socket.
+$result = system("runcon -t test_netlink_iscsi_socket_t -- $basedir/netlinkcreate iscsi 2>&1");
+ok($result, 0);
+
+# Verify that test_no_netlink_iscsi_socket_t cannot create a NETLINK_ISCSI socket.
+$result = system("runcon -t test_no_netlink_iscsi_socket_t -- $basedir/netlinkcreate iscsi 2>&1");
+ok($result);
+
+# Verify that test_netlink_netfilter_socket_t can create a NETLINK_NETFILTER socket.
+$result = system("runcon -t test_netlink_netfilter_socket_t -- $basedir/netlinkcreate netfilter 2>&1");
+ok($result, 0);
+
+# Verify that test_no_netlink_netfilter_socket_t cannot create a NETLINK_NETFILTER socket.
+$result = system("runcon -t test_no_netlink_netfilter_socket_t -- $basedir/netlinkcreate netfilter 2>&1");
+ok($result);
+
+# Verify that test_netlink_generic_socket_t can create a NETLINK_GENERIC socket.
+$result = system("runcon -t test_netlink_generic_socket_t -- $basedir/netlinkcreate generic 2>&1");
+ok($result, 0);
+
+# Verify that test_no_netlink_generic_socket_t cannot create a NETLINK_GENERIC socket.
+$result = system("runcon -t test_no_netlink_generic_socket_t -- $basedir/netlinkcreate generic 2>&1");
+ok($result);
+
+# Verify that test_netlink_crypto_socket_t can create a NETLINK_CRYPTO socket.
+$result = system("runcon -t test_netlink_crypto_socket_t -- $basedir/netlinkcreate crypto 2>&1");
+ok($result, 0);
+
+# Verify that test_no_netlink_crypto_socket_t cannot create a NETLINK_CRYPTO socket.
+$result = system("runcon -t test_no_netlink_crypto_socket_t -- $basedir/netlinkcreate crypto 2>&1");
+ok($result);
-- 
2.7.4
