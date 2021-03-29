Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-31.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BD8C433DB
	for <selinux@archiver.kernel.org>; Mon, 29 Mar 2021 18:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3BF560C3D
	for <selinux@archiver.kernel.org>; Mon, 29 Mar 2021 18:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhC2Sjs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Mar 2021 14:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbhC2Sjo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Mar 2021 14:39:44 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6246EC061574
        for <selinux@vger.kernel.org>; Mon, 29 Mar 2021 11:39:43 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id 11so8143917qtz.7
        for <selinux@vger.kernel.org>; Mon, 29 Mar 2021 11:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Z8LmjYvTDA3Rqdf43Su8tINnRaKJ1hMb5QuxNwOXRwo=;
        b=uv+APcpv9Jwpz3BR2EQYSTDIDEvqNXk/ZbLOJPHs4bSIKFSz6MG8zTuMyrsqkuevt6
         vDjl8UOGV+IQCqk5B8PaHAl55q90a8KCfiV3qSH8yaYCkGCjoyASCZA945G2X4LK6ZUW
         11SG+FM85AGw0UpS7lg12zyszQiQHbPhzwFhUIic5c6/3orKLBNgNfVohuYCuMKkgfRC
         NFPpUWoMbiIuBKhviwVulNrEmEJ6JXbAnNMG1nfl35odi9bqyl3tsOLNtTv2BMoNL9R6
         AjHJxSY3LSTAs+nOKiGreX8welPAXg36TI5L64znz7rmrcObFyl2BJUiddikALoSGPbb
         PwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Z8LmjYvTDA3Rqdf43Su8tINnRaKJ1hMb5QuxNwOXRwo=;
        b=a/oejE5EpRr7ICN4XbjMJbGh7oc7YJdu0Eh2fo4k5zUMEPPbVZHPA5JmbSGCZYVhOi
         zvpigogI3adNj3peHOGvXg82QdYx93vnDhifiAT5bWsOjWIJ/ECeQTKPsUFzwxgWFwVC
         QhCQBV+gjI3DqpdZqWKnJ3vUMS53hxd3iKx5xz8pZfde8CvI46HusReyJVsbwh3AqOTK
         V1GkRKAp9dUhud7F7g0EfoZbdRTzY6kIdmNjPpgNCheDM1VZrM9LYfB+k0KFhsl+BDad
         l+5vIIOR9dnvFwtg00fLX2vN+tgw2A6QuXQO1q+78rL+tyGlQvlLQV7R8CmDActDHfCF
         WUdQ==
X-Gm-Message-State: AOAM532Tdxbz6UFqtrF9Da6JTzSbK+LEgki4MtZXGn3eLQB6TDOLryyO
        hZqzO+WlZtqOClL4qaeM5TfJFCLqdxl5/j69O9auqM5tV79BjL0tFehJtYcawX4gO5BLxzh9+CA
        E/j8PVkUw+RI3OjPHufMWfjWBNEmFXdZ2a9ERgi0/ibqgfIRG7bVNERjecUhEVuiXFGpY
X-Google-Smtp-Source: ABdhPJwiI+3+KDbBvFfLRVhIoJlbHaKaTlxRlxX4zUxNyyCPkcI7bVPuHOqeBqYQcT+ix/9iVKx8EfRBFaXFhw==
X-Received: from dbrazdil.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:7f9b])
 (user=dbrazdil job=sendgmr) by 2002:ad4:52c2:: with SMTP id
 p2mr26527132qvs.45.1617043182504; Mon, 29 Mar 2021 11:39:42 -0700 (PDT)
Date:   Mon, 29 Mar 2021 18:39:39 +0000
Message-Id: <20210329183939.1964411-1-dbrazdil@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH testsuite] Add AF_VSOCK SOCK_STREAM client/server tests
From:   David Brazdil <dbrazdil@google.com>
To:     selinux@vger.kernel.org
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        David Brazdil <dbrazdil@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

If AF_VSOCK and vsock_loopback are supported by the system, run tests
that exchange a byte of data between a client and a server listening on
VMADDR_CID_LOCAL and a random port.

Various permissions are removed from the client/server between runs and
it is checked that the corresponding syscalls returned error.

A newly created vsock_socket inherits the SID of the current process and
it is tested that the vsock_socket returned by accept() inherits the same
SID from its parent.

SOCK_DGRAM is not tested as it is only supported in the VMCI transport.

These tests depend on an upstream commit 1f935e8e72ec ("selinux: vsock:
Set SID for socket returned by accept()"). It was first released in v5.12
and backported to all the stable branches.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
This is also posted on GitHub as pull request #75:
  https://github.com/SELinuxProject/selinux-testsuite/pull/75

The patch that fixes the vsock_socket bug has been merged to 5.12 and
backported to 5.10-stable and 5.11-stable. Backport all the way back
to 4.4-stable is awaiting merging here:
  https://lkml.kernel.org/stable/20210329182443.1960963-1-dbrazdil@google.com
Since the expectation is that all stable kernels will soon have the patch,
I skipped a kernel version check in this test.

 policy/Makefile                  |   2 +-
 policy/test_vsock_socket.te      |  52 ++++++++++++
 tests/Makefile                   |   2 +-
 tests/vsock_socket/.gitignore    |   3 +
 tests/vsock_socket/Makefile      |   7 ++
 tests/vsock_socket/check_vsock.c |  47 +++++++++++
 tests/vsock_socket/client.c      | 129 ++++++++++++++++++++++++++++
 tests/vsock_socket/server.c      | 140 +++++++++++++++++++++++++++++++
 tests/vsock_socket/test          | 118 ++++++++++++++++++++++++++
 9 files changed, 498 insertions(+), 2 deletions(-)
 create mode 100644 policy/test_vsock_socket.te
 create mode 100644 tests/vsock_socket/.gitignore
 create mode 100644 tests/vsock_socket/Makefile
 create mode 100644 tests/vsock_socket/check_vsock.c
 create mode 100644 tests/vsock_socket/client.c
 create mode 100644 tests/vsock_socket/server.c
 create mode 100755 tests/vsock_socket/test

diff --git a/policy/Makefile b/policy/Makefile
index b092bb3..0b30a46 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -27,7 +27,7 @@ TARGETS = \
 	test_setnice.te test_sigkill.te test_stat.te test_sysctl.te \
 	test_task_create.te test_task_getpgid.te test_task_getsched.te \
 	test_task_getsid.te test_task_setpgid.te test_task_setsched.te \
-	test_transition.te test_unix_socket.te \
+	test_transition.te test_unix_socket.te test_vsock_socket.te \
 	test_mmap.te test_overlayfs.te test_mqueue.te \
 	test_ibpkey.te test_atsecure.te test_cgroupfs.te test_userfaultfd.te
 
diff --git a/policy/test_vsock_socket.te b/policy/test_vsock_socket.te
new file mode 100644
index 0000000..c1cbb36
--- /dev/null
+++ b/policy/test_vsock_socket.te
@@ -0,0 +1,52 @@
+#################################
+#
+# Policy for testing vsock/local domain sockets.
+#
+
+attribute vsocksocketdomain;
+
+define(`vsock_server', `
+# Domain for server process.
+type test_vsock_server_$1_t;
+domain_type(test_vsock_server_$1_t)
+unconfined_runs_test(test_vsock_server_$1_t)
+typeattribute test_vsock_server_$1_t testdomain;
+typeattribute test_vsock_server_$1_t vsocksocketdomain;
+
+# Permissions of the server process.
+allow test_vsock_server_$1_t self:vsock_socket { $2 };
+
+# For writing to flag file:
+allow test_vsock_server_$1_t test_file_t:fifo_file rw_file_perms;
+')
+
+define(`vsock_client', `
+# Domain for stream client process.
+type test_vsock_client_$1_t;
+domain_type(test_vsock_client_$1_t)
+unconfined_runs_test(test_vsock_client_$1_t)
+typeattribute test_vsock_client_$1_t testdomain;
+typeattribute test_vsock_client_$1_t vsocksocketdomain;
+
+# client can connect to the server via the socket file or via abstract sockets.
+allow test_vsock_client_$1_t self:vsock_socket { $2 };
+')
+
+vsock_server(all, accept bind create getattr listen read write)
+vsock_server(nobind, accept create getattr listen read write)
+vsock_server(nolisten, accept bind create getattr read write)
+vsock_server(noaccept, bind create getattr listen read write)
+
+vsock_client(all, connect create getattr getopt setopt read shutdown write)
+vsock_client(nocreate, connect getattr getopt setopt read shutdown write)
+vsock_client(noconnect, create getattr getopt setopt read shutdown write)
+vsock_client(nowrite, connect create getattr getopt setopt read shutdown)
+vsock_client(noshutdown, connect create getattr getopt setopt read write)
+vsock_client(noread, connect create getattr getopt setopt shutdown write)
+vsock_client(nogetattr, connect create getopt setopt read shutdown write)
+vsock_client(nogetopt, connect create getattr setopt read shutdown write)
+vsock_client(nosetopt, connect create getattr getopt read shutdown write)
+
+# Allow all of these domains to be entered from the sysadm domain.
+miscfiles_domain_entry_test_files(vsocksocketdomain)
+userdom_sysadm_entry_spec_domtrans_to(vsocksocketdomain)
diff --git a/tests/Makefile b/tests/Makefile
index c19fcd7..fb95a97 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -27,7 +27,7 @@ SUBDIRS:= domain_trans entrypoint execshare exectrace execute_no_trans \
 	task_setnice task_setscheduler task_getscheduler task_getsid \
 	task_getpgid task_setpgid file ioctl capable_file capable_net \
 	capable_sys dyntrans dyntrace bounds nnp_nosuid mmap unix_socket \
-	inet_socket overlay checkreqprot mqueue mac_admin atsecure
+	inet_socket overlay checkreqprot mqueue mac_admin atsecure vsock_socket
 
 ifeq ($(shell grep -q cap_userns $(POLDEV)/include/support/all_perms.spt && echo true),true)
 ifneq ($(shell ./kvercmp $$(uname -r) 4.7),-1)
diff --git a/tests/vsock_socket/.gitignore b/tests/vsock_socket/.gitignore
new file mode 100644
index 0000000..13eeb1b
--- /dev/null
+++ b/tests/vsock_socket/.gitignore
@@ -0,0 +1,3 @@
+client
+server
+check_vsock
diff --git a/tests/vsock_socket/Makefile b/tests/vsock_socket/Makefile
new file mode 100644
index 0000000..bf6ec7b
--- /dev/null
+++ b/tests/vsock_socket/Makefile
@@ -0,0 +1,7 @@
+TARGETS=client server check_vsock
+
+LDLIBS+= -lselinux
+
+all: $(TARGETS)
+clean:
+	rm -f $(TARGETS)
diff --git a/tests/vsock_socket/check_vsock.c b/tests/vsock_socket/check_vsock.c
new file mode 100644
index 0000000..6eecd62
--- /dev/null
+++ b/tests/vsock_socket/check_vsock.c
@@ -0,0 +1,47 @@
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+
+// Must be included after sys/socket.h
+#include <linux/vm_sockets.h>
+
+int main(int argc, char **argv)
+{
+	int sock;
+	struct sockaddr_vm svm;
+
+	sock = socket(AF_VSOCK, SOCK_STREAM, 0);
+	if (sock < 0) {
+		if (errno == EAFNOSUPPORT) {
+			// AF_VSOCK not supported
+			exit(2);
+		} else {
+			perror("socket");
+			exit(1);
+		}
+	}
+
+	bzero(&svm, sizeof(svm));
+	svm.svm_family = AF_VSOCK;
+	svm.svm_port = VMADDR_PORT_ANY;
+	svm.svm_cid = VMADDR_CID_LOCAL;
+
+	if (bind(sock, (struct sockaddr *)&svm, sizeof(svm)) < 0) {
+		if (errno == EADDRNOTAVAIL) {
+			// vsock_loopback not supported
+			close(sock);
+			exit(3);
+		} else {
+			perror("bind");
+			close(sock);
+			exit(1);
+		}
+	}
+
+	close(sock);
+	exit(0);
+}
diff --git a/tests/vsock_socket/client.c b/tests/vsock_socket/client.c
new file mode 100644
index 0000000..7362459
--- /dev/null
+++ b/tests/vsock_socket/client.c
@@ -0,0 +1,129 @@
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <stdio.h>
+
+// Must be included after sys/socket.h
+#include <linux/vm_sockets.h>
+
+void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s cid port\n"
+		"\nWhere:\n\t"
+		"cid     Context Identifier of the server\n\t"
+		"port    Server port\n", progname);
+	exit(1);
+}
+
+#define TEST_VALUE	42
+
+int
+main(int argc, char **argv)
+{
+	unsigned cid;
+	unsigned port;
+	int sock;
+	int opt;
+	int result;
+	char byte;
+	socklen_t len;
+	uint64_t bufsize;
+	struct sockaddr_vm svm;
+
+	while ((opt = getopt(argc, argv, ":")) != -1) {
+		switch (opt) {
+		default:
+			usage(argv[0]);
+			break;
+		}
+	}
+
+	if ((argc - optind) != 2)
+		usage(argv[0]);
+
+	cid = strtoul(argv[optind], NULL, 10);
+	if (!cid)
+		usage(argv[0]);
+
+	port = strtoull(argv[optind + 1], NULL, 10);
+	if (!port)
+		usage(argv[0]);
+
+	sock = socket(AF_VSOCK, SOCK_STREAM, 0);
+	if (sock < 0) {
+		perror("socket");
+		exit(2);
+	}
+
+	bzero(&svm, sizeof(svm));
+	svm.svm_family = AF_VSOCK;
+	svm.svm_port = port;
+	svm.svm_cid = cid;
+
+	result = connect(sock, (struct sockaddr *)&svm, sizeof(svm));
+	if (result < 0) {
+		perror("connect");
+		close(sock);
+		exit(3);
+	}
+
+	byte = TEST_VALUE;
+	result = write(sock, &byte, 1);
+	if (result < 0) {
+		perror("write");
+		close(sock);
+		exit(4);
+	}
+
+	result = shutdown(sock, SHUT_WR);
+	if (result < 0) {
+		perror("shutdown");
+		close(sock);
+		exit(5);
+	}
+
+	result = read(sock, &byte, 1);
+	if (result < 0) {
+		perror("read");
+		close(sock);
+		exit(6);
+	} else if (result != 1) {
+		fprintf(stderr, "%s: expected 1 byte, got %d\n",
+			argv[0], result);
+		close(sock);
+		exit(1);
+	} else if (byte != TEST_VALUE) {
+		fprintf(stderr, "%s: expected %d, got %d\n",
+			argv[0], TEST_VALUE, byte);
+		exit(1);
+	}
+
+	len = sizeof(svm);
+	result = getsockname(sock, (struct sockaddr *)&svm, &len);
+	if (result < 0) {
+		perror("getsockname");
+		close(sock);
+		exit(7);
+	}
+
+	result = getsockopt(sock, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE, &bufsize, &len);
+	if (result < 0) {
+		perror("getsockopt");
+		close(sock);
+		exit(8);
+	}
+
+	result = setsockopt(sock, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE, &bufsize, len);
+	if (result < 0) {
+		perror("setsockopt");
+		close(sock);
+		exit(9);
+	}
+
+	close(sock);
+	exit(0);
+}
diff --git a/tests/vsock_socket/server.c b/tests/vsock_socket/server.c
new file mode 100644
index 0000000..dd135d0
--- /dev/null
+++ b/tests/vsock_socket/server.c
@@ -0,0 +1,140 @@
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <stdio.h>
+
+// Must be included after sys/socket.h
+#include <linux/vm_sockets.h>
+
+void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s [-f file] [-p port]\n"
+		"\nWhere:\n\t"
+		"-f      Flag file signaling server readiness\n\t"
+		"-p      Listening port, otherwise random\n\t"
+		"-s      Single-client mode\n", progname);
+	exit(1);
+}
+
+int main(int argc, char **argv)
+{
+	unsigned port = VMADDR_PORT_ANY;
+	int sock;
+	int opt;
+	int result;
+	struct sockaddr_vm svm;
+	socklen_t svmlen;
+	char *flag_file = NULL;
+	int single_client = 0;
+
+	while ((opt = getopt(argc, argv, "p:f:s")) != -1) {
+		switch (opt) {
+		case 'p':
+			port = strtoul(optarg, NULL, 10);
+			if (!port)
+				usage(argv[0]);
+			break;
+		case 'f':
+			flag_file = optarg;
+			break;
+		case 's':
+			single_client = 1;
+			break;
+		default:
+			usage(argv[0]);
+			break;
+		}
+	}
+
+	if ((argc - optind) != 0)
+		usage(argv[0]);
+
+	sock = socket(AF_VSOCK, SOCK_STREAM, 0);
+	if (sock < 0) {
+		perror("socket");
+		exit(2);
+	}
+
+	bzero(&svm, sizeof(svm));
+	svm.svm_family = AF_VSOCK;
+	svm.svm_port = port;
+	svm.svm_cid = VMADDR_CID_LOCAL;
+
+	svmlen = sizeof(svm);
+	if (bind(sock, (struct sockaddr *)&svm, svmlen) < 0) {
+		perror("bind");
+		close(sock);
+		exit(3);
+	}
+
+	/* Update svm with the port number selected by the kernel. */
+	if (getsockname(sock, (struct sockaddr *)&svm, &svmlen) < 0) {
+		perror("getsockname");
+		close(sock);
+		exit(4);
+	}
+
+	if (listen(sock, SOMAXCONN)) {
+		perror("listen");
+		close(sock);
+		exit(5);
+	}
+
+	if (flag_file) {
+		FILE *f = fopen(flag_file, "w");
+		if (!f) {
+			perror("Flag file open");
+			close(sock);
+			exit(1);
+		}
+		fprintf(f, "%u\n", svm.svm_port);
+		fclose(f);
+	}
+
+	for(;;) {
+		char byte;
+		int newsock;
+		int pid;
+		struct sockaddr_vm newsvm;
+		socklen_t newsvmlen;
+
+		newsvmlen = sizeof(newsvm);
+		newsock = accept(sock, (struct sockaddr *)&newsvm, &newsvmlen);
+		if (newsock < 0) {
+			perror("accept");
+			close(sock);
+			exit(6);
+		}
+
+		if (!single_client) {
+			pid = fork();
+			if (pid < 0) {
+				perror("fork");
+				close(sock);
+				exit(7);
+			} else if (pid > 0) {
+				close(newsock);
+				continue;
+			}
+		}
+
+		result = read(newsock, &byte, 1);
+		if (result < 0) {
+			perror("read");
+			exit(8);
+		}
+
+		result = write(newsock, &byte, 1);
+		if (result < 0 && errno != EPIPE) {
+			perror("write");
+			exit(9);
+		}
+
+		close(newsock);
+		exit(0);
+	}
+}
diff --git a/tests/vsock_socket/test b/tests/vsock_socket/test
new file mode 100755
index 0000000..41d9bc8
--- /dev/null
+++ b/tests/vsock_socket/test
@@ -0,0 +1,118 @@
+#!/usr/bin/perl
+use Test::More;
+
+BEGIN {
+    $basedir = $0;
+    $basedir =~ s|(.*)/[^/]*|$1|;
+
+    # check if vsock and vsock_loopback are available
+    $rc = system("$basedir/check_vsock");
+
+    if ( $rc eq 0 ) {
+        plan tests => 12;
+    }
+    elsif ( $rc eq 2 << 8 ) {
+        plan skip_all => "vsock socket family not supported";
+    }
+    elsif ( $rc eq 3 << 8 ) {
+        plan skip_all => "vsock_loopback transport not supported";
+    }
+    else {
+        plan skip_all => "unexpected error when checking vsock support";
+    }
+}
+
+sub server_start {
+    my ( $runcon_args, $args ) = @_;
+    my $pid;
+
+    system("rm -f $basedir/flag");
+    system("mkfifo $basedir/flag");
+
+    if ( ( $pid = fork() ) == 0 ) {
+        exec "runcon $runcon_args $basedir/server -f $basedir/flag $args";
+    }
+
+    # Wait for it to initialize, read port number.
+    my $port = `read -t 5 <>$basedir/flag; echo \$REPLY`;
+
+    return ( $pid, $port );
+}
+
+sub server_kill {
+    my ($pid) = @_;
+
+    kill KILL, $pid;
+    waitpid $pid, 0;
+    system("rm -f $basedir/flag");
+}
+
+# Start server for client tests.
+( $pid, $port ) = server_start( "-t test_vsock_server_all_t", "" );
+ok( $port =~ /^[0-9]+$/ );
+
+# Verify that client can connect to server.
+$result = system "runcon -t test_vsock_client_all_t $basedir/client 1 $port";
+ok( $result eq 0 );
+
+# Verify that client cannot create vsock_socket without permission.
+$result =
+  system
+  "runcon -t test_vsock_client_nocreate_t 2>/dev/null $basedir/client 1 $port";
+ok( $result eq 2 << 8 );
+
+# Verify that client cannot connect to vsock_socket without permission.
+$result =
+  system
+  "runcon -t test_vsock_client_noconnect_t 2>/dev/null $basedir/client 1 $port";
+ok( $result eq 3 << 8 );
+
+# Verify that client cannot write to vsock_socket without permission.
+$result =
+  system(
+    "runcon -t test_vsock_client_nowrite_t 2>/dev/null $basedir/client 1 $port"
+  );
+ok( $result eq 4 << 8 );
+
+# Verify that client cannot read from vsock_socket without permission.
+$result =
+  system
+  "runcon -t test_vsock_client_noread_t 2>/dev/null $basedir/client 1 $port";
+ok( $result eq 6 << 8 );
+
+# Verify that client cannot getsockname from vsock_socket without permission.
+$result =
+  system
+  "runcon -t test_vsock_client_nogetattr_t 2>/dev/null $basedir/client 1 $port";
+ok( $result eq 7 << 8 );
+
+# Verify that client cannot getsockopt from vsock_socket without permission.
+$result =
+  system
+  "runcon -t test_vsock_client_nogetopt_t 2>/dev/null $basedir/client 1 $port";
+ok( $result eq 8 << 8 );
+
+# Verify that client cannot setsockopt from vsock_socket without permission.
+$result =
+  system
+  "runcon -t test_vsock_client_nosetopt_t 2>/dev/null $basedir/client 1 $port";
+ok( $result eq 9 << 8 );
+
+server_kill($pid);
+
+# Verify that server cannot bind to vsock_socket without permission.
+$result =
+  system "runcon -t test_vsock_server_nobind_t $basedir/server 2>/dev/null";
+ok( $result eq 3 << 8 );
+
+# Verify that server cannot listen on vsock_socket without permission.
+$result =
+  system "runcon -t test_vsock_server_nolisten_t $basedir/server 2>/dev/null";
+ok( $result eq 5 << 8 );
+
+# Verify that server cannot accept a vsock_socket connection without permission.
+$result =
+  system "runcon -t test_vsock_server_noaccept_t $basedir/server 2>/dev/null";
+ok( $result eq 6 << 8 );
+
+exit;
-- 
2.30.2

