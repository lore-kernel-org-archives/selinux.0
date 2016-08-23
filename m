Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7NN3xAg026193
 for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2016 19:03:59 -0400
Message-ID: <1471993428.12192.1.camel@trentalancia.net>
Subject: Re: [PATCH v5] Classify AF_ALG sockets
From: Guido Trentalancia <guido@trentalancia.net>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Date: Wed, 24 Aug 2016 01:03:48 +0200
In-Reply-To: <CAHC9VhRp80bRirP=p8gqzdf_37ZeuKGxfUVqZqS5p0_X_z71Ug@mail.gmail.com>
References: <1471709886.22998.1.camel@trentalancia.net>
 <CAHC9VhRouoqqrq_Vn1A3wh7kwvodUK-j7xR3=uwep7t0Ktdh3w@mail.gmail.com>
 <89E5C3EA-9794-4496-A195-1C997A5BBF44@trentalancia.net>
 <CAGH-KguvJZVLAUYQP_iFk2KG7DDFe9kGADWK_dkbGPHuStjpcQ@mail.gmail.com>
 <43BE5B4F-9AE4-4EDB-825A-F1C15042B385@trentalancia.net>
 <CAHC9VhQOTQNsNT7T53qE5g1pK8BN270ZAFyUJ0xAnzsbPg57YA@mail.gmail.com>
 <1471799849.2544.2.camel@trentalancia.net>
 <1471870947.2354.1.camel@trentalancia.net>
 <1471899875.19333.3.camel@trentalancia.net>
 <1471961693.30659.7.camel@trentalancia.net>
 <082767a3-acab-4d46-6195-06e35251d53e@tycho.nsa.gov>
 <CAHC9VhRp80bRirP=p8gqzdf_37ZeuKGxfUVqZqS5p0_X_z71Ug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This patch for the SELinux testsuite aims to add a very simple test
for sockets in the AF_ALG namespace.

However, I met some problems while trying to run it, so testing is
needed.

 policy/Makefile           |    2 -
 policy/test_alg_socket.te |   25 +++++++++++++++++
 tests/alg_socket/Makefile |    5 +++
 tests/alg_socket/client.c |   66 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/alg_socket/test     |   22 +++++++++++++++
 5 files changed, 119 insertions(+), 1 deletion(-)

diff -pruN selinux-testsuite-git-23082016-orig/policy/Makefile selinux-testsuite-git-23082016/policy/Makefile
--- selinux-testsuite-git-23082016-orig/policy/Makefile	2016-08-23 20:50:08.527633728 +0200
+++ selinux-testsuite-git-23082016/policy/Makefile	2016-08-24 00:56:38.114854854 +0200
@@ -20,7 +20,7 @@ TARGETS = \
 	test_task_create.te test_task_getpgid.te test_task_getsched.te \
 	test_task_getsid.te test_task_setpgid.te test_task_setsched.te \
 	test_transition.te test_inet_socket.te test_unix_socket.te \
-	test_wait.te test_mmap.te
+	test_alg_socket.te test_wait.te test_mmap.te
 
 ifeq ($(shell [ $(POL_VERS) -ge 24 ] && echo true),true)
 TARGETS += test_bounds.te
diff -pruN selinux-testsuite-git-23082016-orig/policy/test_alg_socket.te selinux-testsuite-git-23082016/policy/test_alg_socket.te
--- selinux-testsuite-git-23082016-orig/policy/test_alg_socket.te	1970-01-01 01:00:00.000000000 +0100
+++ selinux-testsuite-git-23082016/policy/test_alg_socket.te	2016-08-24 00:31:51.588695889 +0200
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
diff -pruN selinux-testsuite-git-23082016-orig/tests/alg_socket/client.c selinux-testsuite-git-23082016/tests/alg_socket/client.c
--- selinux-testsuite-git-23082016-orig/tests/alg_socket/client.c	1970-01-01 01:00:00.000000000 +0100
+++ selinux-testsuite-git-23082016/tests/alg_socket/client.c	2016-08-24 00:58:47.075516771 +0200
@@ -0,0 +1,66 @@
+#include <sys/socket.h>
+#include <linux/if_alg.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
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
+		if (bind(sock, (struct sockaddr *) &sa_good, sizeof(sa_good)) < 0) {
+			perror("bind (algorithm available)");
+			close(sock);
+			exit(1);
+		}
+	} else {
+		struct sockaddr_alg sa_bad = {
+			.salg_family = AF_ALG,
+			.salg_type = "hash",
+			.salg_name = "NOTAVAILABLE",
+		};
+
+		if (bind(sock, (struct sockaddr *) &sa_bad, sizeof(sa_bad)) < 0) {
+			perror("bind (algorithm not available)");
+			close(sock);
+			exit(1);
+		}
+	}
+
+	close(sock);
+	exit(0);
+}
diff -pruN selinux-testsuite-git-23082016-orig/tests/alg_socket/Makefile selinux-testsuite-git-23082016/tests/alg_socket/Makefile
--- selinux-testsuite-git-23082016-orig/tests/alg_socket/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ selinux-testsuite-git-23082016/tests/alg_socket/Makefile	2016-08-23 23:07:46.866079516 +0200
@@ -0,0 +1,5 @@
+TARGETS=client
+
+all: $(TARGETS)
+clean:
+	rm -f $(TARGETS)
diff -pruN selinux-testsuite-git-23082016-orig/tests/alg_socket/test selinux-testsuite-git-23082016/tests/alg_socket/test
--- selinux-testsuite-git-23082016-orig/tests/alg_socket/test	1970-01-01 01:00:00.000000000 +0100
+++ selinux-testsuite-git-23082016/tests/alg_socket/test	2016-08-24 00:24:26.678950567 +0200
@@ -0,0 +1,22 @@
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
