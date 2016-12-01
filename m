Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uB1LcOpc030395
 for <selinux@tycho.nsa.gov>; Thu, 1 Dec 2016 16:38:26 -0500
Message-ID: <1480628227.7565.7.camel@trentalancia.net>
Subject: Re: [RFC][PATCH] selinux: support distinctions among all network
 address families
From: Guido Trentalancia <guido@trentalancia.net>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
In-Reply-To: <e3cd8c15-eb4a-24a7-f5b1-04dbb90d780b@tycho.nsa.gov>
References: <1480604861-13982-1-git-send-email-sds@tycho.nsa.gov>
 <f89685d0-2088-6b27-2671-bfaafea57786@tycho.nsa.gov>
 <1480613322.4558.29.camel@trentalancia.net>
 <9b023671-606f-d3b2-9d70-3bbcbf5e5dba@tycho.nsa.gov>
 <e3cd8c15-eb4a-24a7-f5b1-04dbb90d780b@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 01 Dec 2016 22:37:07 +0100
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello again !

On Thu, 01/12/2016 at 13.53 -0500, Stephen Smalley wrote:
> On 12/01/2016 01:03 PM, Stephen Smalley wrote:

[...]

> > Actually, I realized belatedly that CIL makes it possible to enable
> > testing of this change just through a policy module.  Attached is a
> > CIL
> > policy module that one can insert via semodule -i
> > testextsockclass.cil (caveat: may break your system if using any of
> > these socket classes). Also attached is the libsepol patch.  So now
> > I
> > just need a test case - will have a look at your AF_ALG patch.
> 
> So I confirmed that using your test program, I get an avc denial for
> create on alg_socket unless I allow that permission to the domain
> running the program, as expected.  So no surprises there.  I'll defer
> putting together a real patch for selinux-testsuite until it is clear
> that the kernel patch is going to be accepted, and regardless, we'll
> have to work through how to make it conditional on all the right
> factors
> (kernel version, policy defines the capability and the new socket
> classes or we add them temporarily for the tests via the CIL policy
> module).

I have modified the SELinux Testsuite patch that I originally posted on
the 24th of August 2016 with subject "Re: [PATCH v5] Classify AF_ALG
sockets", so that it checks the kernel version (you have to edit the
minimum version in the test source file)...

If you decide to use the standard tests instead of the CIL module, you
can save some time by using the following:

[cut]

This patch for the SELinux testsuite aims to add a very simple test
for sockets in the AF_ALG namespace.

Such test is representative of the new set of socket families that
the kernel supports if it supports the new extended_socket_class
SELinux policy capability.

BEFORE USING PLEASE EDIT THE KER_VERSION, KER_PATCHLEVEL AND
KER_SUBLEVEL DEFINED IN THE TEST SOURCE FILE.

Signed-off-by: Guido Trentalancia <guido@trentalancia.net>
---
 policy/Makefile           |    2
 policy/test_alg_socket.te |   25 ++++++++++++
 tests/alg_socket/Makefile |    5 ++
 tests/alg_socket/client.c |   94 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/alg_socket/test     |   26 ++++++++++++
 5 files changed, 151 insertions(+), 1 deletion(-)

diff -pruN selinux-testsuite-01122016-orig/policy/Makefile selinux-testsuite-01122016/policy/Makefile
--- selinux-testsuite-01122016-orig/policy/Makefile	2016-12-01 21:52:49.170252694 +0100
+++ selinux-testsuite-01122016/policy/Makefile	2016-12-01 22:24:44.388153327 +0100
@@ -20,7 +20,7 @@ TARGETS = \
 	test_task_create.te test_task_getpgid.te test_task_getsched.te \
 	test_task_getsid.te test_task_setpgid.te test_task_setsched.te \
 	test_transition.te test_inet_socket.te test_unix_socket.te \
-	test_wait.te test_mmap.te test_overlayfs.te
+	test_alg_socket.te test_wait.te test_mmap.te test_overlayfs.te
 
 ifeq ($(shell [ $(POL_VERS) -ge 24 ] && echo true),true)
 TARGETS += test_bounds.te
diff -pruN selinux-testsuite-01122016-orig/policy/test_alg_socket.te selinux-testsuite-01122016/policy/test_alg_socket.te
--- selinux-testsuite-01122016-orig/policy/test_alg_socket.te	1970-01-01 01:00:00.000000000 +0100
+++ selinux-testsuite-01122016/policy/test_alg_socket.te	2016-12-01 21:53:30.813685402 +0100
@@ -0,0 +1,25 @@
+#################################
+#
+# Policy for testing sockets in
+# the AF_ALG namespace (Crypto
+# API).
+#
+
+attribute algsocketdomain;
+
+# Domain for client process.
+type test_alg_socket_client_t;
+domain_type(test_alg_socket_client_t)
+unconfined_runs_test(test_alg_socket_client_t)
+typeattribute test_alg_socket_client_t testdomain;
+typeattribute test_alg_socket_client_t algsocketdomain;
+
+# client can bind socket.
+allow test_alg_socket_client_t self:alg_socket bind;
+
+# client can request to load a kernel module
+kernel_request_load_module(algsocketdomain)
+
+# Allow all of these domains to be entered from the sysadm domain.
+miscfiles_domain_entry_test_files(algsocketdomain)
+userdom_sysadm_entry_spec_domtrans_to(algsocketdomain)
diff -pruN selinux-testsuite-01122016-orig/tests/alg_socket/client.c selinux-testsuite-01122016/tests/alg_socket/client.c
--- selinux-testsuite-01122016-orig/tests/alg_socket/client.c	1970-01-01 01:00:00.000000000 +0100
+++ selinux-testsuite-01122016/tests/alg_socket/client.c	2016-12-01 22:19:23.143815343 +0100
@@ -0,0 +1,94 @@
+/*
+ * The alg_socket is representative of the new set of
+ * socket families that the kernel is able to classify
+ * when it supports the new extended_socket_class policy
+ * capability.
+ *
+ * This test simply checks the result of bind() using
+ * the Kernel Crypto API.
+ */
+
+#include <sys/socket.h>
+#include <linux/if_alg.h>
+#include <linux/version.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+
+/*
+ * First kernel version that supports the new
+ * extended_socket_class policy capability.
+ */
+
+#define KER_VERSION	4
+#define KER_PATCHLEVEL	99
+#define KER_SUBLEVEL	99
+
+void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s [succeed|fail]\n",
+		progname);
+	exit(1);
+}
+
+int
+main(int argc, char **argv)
+{
+	int succeed;
+	int sock;
+
+	if (argc != 2)
+		usage(argv[0]);
+
+	if (!strcmp(argv[1], "succeed"))
+		succeed = 1;
+	else if (!strcmp(argv[1], "fail"))
+		succeed = 0;
+	else
+		usage(argv[0]);
+
+	sock = socket(AF_ALG, SOCK_SEQPACKET, 0);
+	if (sock < 0) {
+		perror("socket");
+		exit(1);
+	}
+
+	if (succeed == 1) {
+		struct sockaddr_alg sa_good = {
+			.salg_family = AF_ALG,
+			.salg_type = "hash",
+			.salg_name = "sha256",
+		};
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(KER_VERSION,KER_PATCHLEVEL,KER_SUBLEVEL)
+		if (bind(sock, (struct sockaddr *) &sa_good, sizeof(sa_good)) < 0) {
+			perror("bind (algorithm available)");
+			close(sock);
+			exit(1);
+		}
+#else /* kernel does not support the new policy capability */
+	exit(0);
+#endif
+	} else {
+		struct sockaddr_alg sa_bad = {
+			.salg_family = AF_ALG,
+			.salg_type = "hash",
+			.salg_name = "NOTAVAILABLE",
+		};
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(KER_VERSION,KER_PATCHLEVEL,KER_SUBLEVEL)
+		if (bind(sock, (struct sockaddr *) &sa_bad, sizeof(sa_bad)) < 0) {
+			perror("bind (algorithm not available)");
+			close(sock);
+			exit(1);
+		}
+#else /* kernel does not support the new policy capability */
+	exit(1);
+#endif
+	}
+
+	close(sock);
+	exit(0);
+}
diff -pruN selinux-testsuite-01122016-orig/tests/alg_socket/Makefile selinux-testsuite-01122016/tests/alg_socket/Makefile
--- selinux-testsuite-01122016-orig/tests/alg_socket/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ selinux-testsuite-01122016/tests/alg_socket/Makefile	2016-12-01 21:53:30.814685412 +0100
@@ -0,0 +1,5 @@
+TARGETS=client
+
+all: $(TARGETS)
+clean:
+	rm -f $(TARGETS)
diff -pruN selinux-testsuite-01122016-orig/tests/alg_socket/test selinux-testsuite-01122016/tests/alg_socket/test
--- selinux-testsuite-01122016-orig/tests/alg_socket/test	1970-01-01 01:00:00.000000000 +0100
+++ selinux-testsuite-01122016/tests/alg_socket/test	2016-12-01 22:19:42.868020293 +0100
@@ -0,0 +1,26 @@
+#!/usr/bin/perl
+
+use Test;
+BEGIN { plan tests => 2}
+
+$basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
+
+#
+# Tests for sockets in the AF_ALG namespace (Crypto API).
+#
+# The AF_ALG socket is representative of the new set of
+# socket families that the kernel can classify when it
+# supports the new extended_socket_class policy capability.
+#
+
+# Verify that the client can initialize the server with an
+# available algorithm.
+$result = system "runcon -t test_alg_socket_client_t $basedir/client succeed";
+ok($result, 0);
+
+# Verify that the client cannot initialize the server with an
+# unavailable algorithm.
+$result = system "runcon -t test_alg_socket_client_t $basedir/client fail";
+ok($result);
+
+exit;
