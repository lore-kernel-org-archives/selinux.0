Return-Path: <SRS0=MTWr=ZE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2740C43331
	for <selinux@archiver.kernel.org>; Tue, 12 Nov 2019 17:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB7A21872
	for <selinux@archiver.kernel.org>; Tue, 12 Nov 2019 17:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="TvmOVJ+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfKLRQL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Nov 2019 12:16:11 -0500
Received: from mailomta9-re.btinternet.com ([213.120.69.102]:10451 "EHLO
        re-prd-fep-049.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726388AbfKLRQL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Nov 2019 12:16:11 -0500
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
          by re-prd-fep-049.btinternet.com with ESMTP
          id <20191112171607.QPUI30084.re-prd-fep-049.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>;
          Tue, 12 Nov 2019 17:16:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1573578967; 
        bh=bRyHBWMgq8eOjLUAjB8cMzWWJUJXCBBdq/nbnZAf1OI=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=TvmOVJ+gdZl37CpWzMHMsj+UP0Sa/lef6LA0jxry8DwUYWFjBbvKSiDHD91UaawNw+wgj8gHJXkcUFz0bNhqrVqt5D33/8zznxBQ7xPzU7i0f4wHKG4R5oodMT5qIV5dAaZETBEoKYQIoKq0AnD+CY6n6D2YGwhVKwg0Ydwc5iIA/Enb1wrAK9yxhlkGL5ZSD6/tHxJVnTEk/7e02c8CLuin9+l5qjuEnPn4RKtiPEFJQfLVxXtLV7UhS7kcgQHdEhUqCNZ8cGYfIT60YreERv73dOmwFC4OAu6UDw7AcK4MvFkC/4tnaTI8B8pVvvccyHzxCnBEakdsJgSPKXonoA==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.6.226]
X-OWM-Source-IP: 86.134.6.226 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedufedruddvledguddttdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeekiedrudefgedriedrvddvieenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefgedriedrvddviedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.6.226) by re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5DB07BDD03BD2EA3; Tue, 12 Nov 2019 17:16:07 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V2] selinux-testsuite: Add key_socket tests
Date:   Tue, 12 Nov 2019 17:15:57 +0000
Message-Id: <20191112171557.3067-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Test relevant key management socket permissions.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
V2 Change: Rework error handling

 defconfig                   |   4 ++
 policy/Makefile             |   4 ++
 policy/test_key_socket.te   |  75 ++++++++++++++++++++
 tests/Makefile              |   4 ++
 tests/key_socket/.gitignore |   1 +
 tests/key_socket/Makefile   |   7 ++
 tests/key_socket/key_sock.c | 137 ++++++++++++++++++++++++++++++++++++
 tests/key_socket/test       |  45 ++++++++++++
 8 files changed, 277 insertions(+)
 create mode 100644 policy/test_key_socket.te
 create mode 100644 tests/key_socket/.gitignore
 create mode 100644 tests/key_socket/Makefile
 create mode 100644 tests/key_socket/key_sock.c
 create mode 100755 tests/key_socket/test

diff --git a/defconfig b/defconfig
index b13075d..0574f1d 100644
--- a/defconfig
+++ b/defconfig
@@ -74,3 +74,7 @@ CONFIG_BPF_SYSCALL=y
 CONFIG_KEYS=y
 CONFIG_KEYS_COMPAT=y
 CONFIG_KEY_DH_OPERATIONS=y
+
+# Test key management socket.
+# This is not required for SELinux operation itself.
+CONFIG_NET_KEY=m
diff --git a/policy/Makefile b/policy/Makefile
index ff65153..ad94c43 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -90,6 +90,10 @@ ifeq ($(shell grep -q all_file_perms.*watch $(POLDEV)/include/support/all_perms.
 TARGETS+=test_notify.te
 endif
 
+ifeq ($(shell grep -q key_socket $(POLDEV)/include/support/all_perms.spt && echo true),true)
+TARGETS += test_key_socket.te
+endif
+
 ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
 TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te test_ibpkey.te, $(TARGETS))
 endif
diff --git a/policy/test_key_socket.te b/policy/test_key_socket.te
new file mode 100644
index 0000000..5c36c72
--- /dev/null
+++ b/policy/test_key_socket.te
@@ -0,0 +1,75 @@
+#
+############## Test key management socket 'key_socket' #####################
+#
+attribute keysockdomain;
+
+type test_key_sock_t;
+domain_type(test_key_sock_t)
+unconfined_runs_test(test_key_sock_t)
+typeattribute test_key_sock_t testdomain;
+typeattribute test_key_sock_t keysockdomain;
+
+# key_socket rules:
+allow test_key_sock_t self:rawip_socket { create };
+allow test_key_sock_t self:capability { net_admin };
+allow test_key_sock_t self:key_socket { create write read setopt };
+# For CONFIG_NET_KEY=m
+allow test_key_sock_t kernel_t:system { module_request };
+
+################## Deny capability { net_admin } ##########################
+#
+# Note that when capability { net_admin } is removed for the test
+# there will not be an audit message in the log as the Fedora policy
+# is built with 'hide_broken_symptoms' that adds the following:
+#   dontaudit test_key_sock_no_net_admin_t self:capability { net_admin sys_module };
+#
+type test_key_sock_no_net_admin_t;
+domain_type(test_key_sock_no_net_admin_t)
+unconfined_runs_test(test_key_sock_no_net_admin_t)
+typeattribute test_key_sock_no_net_admin_t testdomain;
+typeattribute test_key_sock_no_net_admin_t keysockdomain;
+
+allow test_key_sock_no_net_admin_t self:rawip_socket { create };
+allow test_key_sock_no_net_admin_t self:key_socket { create write read setopt };
+allow test_key_sock_no_net_admin_t kernel_t:system { module_request };
+
+####################### Deny key_socket { create } ##########################
+type test_key_sock_no_create_t;
+domain_type(test_key_sock_no_create_t)
+unconfined_runs_test(test_key_sock_no_create_t)
+typeattribute test_key_sock_no_create_t testdomain;
+typeattribute test_key_sock_no_create_t keysockdomain;
+
+allow test_key_sock_no_create_t self:rawip_socket { create };
+allow test_key_sock_no_create_t self:capability { net_admin };
+allow test_key_sock_no_create_t self:key_socket { write read setopt };
+
+####################### Deny key_socket { write } ##########################
+type test_key_sock_no_write_t;
+domain_type(test_key_sock_no_write_t)
+unconfined_runs_test(test_key_sock_no_write_t)
+typeattribute test_key_sock_no_write_t testdomain;
+typeattribute test_key_sock_no_write_t keysockdomain;
+
+allow test_key_sock_no_write_t self:rawip_socket { create };
+allow test_key_sock_no_write_t self:capability { net_admin };
+allow test_key_sock_no_write_t self:key_socket { create read setopt };
+allow test_key_sock_no_write_t kernel_t:system { module_request };
+
+####################### Deny key_socket { read } ##########################
+type test_key_sock_no_read_t;
+domain_type(test_key_sock_no_read_t)
+unconfined_runs_test(test_key_sock_no_read_t)
+typeattribute test_key_sock_no_read_t testdomain;
+typeattribute test_key_sock_no_read_t keysockdomain;
+
+allow test_key_sock_no_read_t self:rawip_socket { create };
+allow test_key_sock_no_read_t self:capability { net_admin };
+allow test_key_sock_no_read_t self:key_socket { create write setopt };
+allow test_key_sock_no_read_t kernel_t:system { module_request };
+
+#
+########### Allow these domains to be entered from sysadm domain ############
+#
+miscfiles_domain_entry_test_files(keysockdomain)
+userdom_sysadm_entry_spec_domtrans_to(keysockdomain)
diff --git a/tests/Makefile b/tests/Makefile
index 0021590..cca6648 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -52,6 +52,10 @@ ifeq ($(shell grep -q all_key_perms $(POLDEV)/include/support/all_perms.spt && e
 SUBDIRS += keys
 endif
 
+ifeq ($(shell grep -q key_socket $(POLDEV)/include/support/all_perms.spt && test -e $(INCLUDEDIR)/keyutils.h && echo true),true)
+SUBDIRS += key_socket
+endif
+
 ifeq ($(shell grep "^SELINUX_INFINIBAND_ENDPORT_TEST=" infiniband_endport/ibendport_test.conf | cut -d'=' -f 2),1)
 SUBDIRS += infiniband_endport
 endif
diff --git a/tests/key_socket/.gitignore b/tests/key_socket/.gitignore
new file mode 100644
index 0000000..1a532c0
--- /dev/null
+++ b/tests/key_socket/.gitignore
@@ -0,0 +1 @@
+key_sock
diff --git a/tests/key_socket/Makefile b/tests/key_socket/Makefile
new file mode 100644
index 0000000..e5e6a58
--- /dev/null
+++ b/tests/key_socket/Makefile
@@ -0,0 +1,7 @@
+TARGETS = key_sock
+LDLIBS += -lselinux
+
+all: $(TARGETS)
+
+clean:
+	rm -f $(TARGETS)
diff --git a/tests/key_socket/key_sock.c b/tests/key_socket/key_sock.c
new file mode 100644
index 0000000..29beb0e
--- /dev/null
+++ b/tests/key_socket/key_sock.c
@@ -0,0 +1,137 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdint.h>
+#include <unistd.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <sys/socket.h>
+#include <linux/pfkeyv2.h>
+#include <selinux/selinux.h>
+
+static void print_usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s [-v]\n"
+		"Where:\n\t"
+		"-v  Print information.\n", progname);
+	exit(-1);
+}
+
+int main(int argc, char *argv[])
+{
+	char *context;
+	int opt, sock, result;
+	bool verbose = false;
+	struct timeval tm;
+	struct sadb_msg w_msg, r_msg;
+	int mlen = sizeof(struct sadb_msg);
+
+	while ((opt = getopt(argc, argv, "v")) != -1) {
+		switch (opt) {
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			print_usage(argv[0]);
+		}
+	}
+
+	result = getcon(&context);
+	if (result < 0) {
+		fprintf(stderr, "Failed to obtain process context\n");
+		exit(-1);
+	}
+
+	if (verbose)
+		printf("Process context:\n\t%s\n", context);
+
+	free(context);
+
+	sock = socket(PF_KEY, SOCK_RAW, PF_KEY_V2);
+	if (sock < 0) {
+		fprintf(stderr, "Failed to open key management socket: %s\n",
+			strerror(errno));
+		/* Return errno as denying net_admin=EPERM, create=EACCES */
+		exit(errno);
+	}
+
+	if (verbose)
+		printf("Opened key management socket\n");
+
+	/* Set socket timeout for read in case no response from kernel */
+	tm.tv_sec = 3;
+	tm.tv_usec = 0;
+	result = setsockopt(sock, SOL_SOCKET, SO_RCVTIMEO, &tm, sizeof(tm));
+	if (result < 0) {
+		fprintf(stderr, "Failed setsockopt SO_RCVTIMEO: %s\n",
+			strerror(errno));
+		close(sock);
+		exit(-1);
+	}
+
+	if (verbose)
+		printf("setsocketopt: SO_RCVTIMEO - %ld seconds\n", tm.tv_sec);
+
+	memset(&w_msg, 0, mlen);
+	w_msg.sadb_msg_version = PF_KEY_V2;
+	w_msg.sadb_msg_type = SADB_FLUSH;
+	w_msg.sadb_msg_satype = SADB_SATYPE_AH;
+	/* sadb_msg_len contains length in 64-bit words */
+	w_msg.sadb_msg_len = (mlen / sizeof(uint64_t));
+	w_msg.sadb_msg_seq = 99;
+	w_msg.sadb_msg_pid = getpid();
+
+	result = write(sock, &w_msg, mlen);
+	if (result < 0) {
+		fprintf(stderr, "Failed write to key management socket: %s\n",
+			strerror(errno));
+		close(sock);
+		exit(errno); /* Return errno to test if EACCES */
+	}
+
+	if (verbose) {
+		printf("Write sadb_msg data to key management socket:\n");
+		printf("\tver: PF_KEY_V2 type: SADB_FLUSH sa_type: SADB_SATYPE_AH\n");
+		printf("\tseq: %d pid: %d\n", w_msg.sadb_msg_seq,
+		       w_msg.sadb_msg_pid);
+	}
+
+	memset(&r_msg, 0, mlen);
+
+	result = read(sock, &r_msg, mlen);
+	if (result < 0) {
+		fprintf(stderr, "Failed to read key management socket: %s\n",
+			strerror(errno));
+		close(sock);
+		exit(errno); /* Return errno to test if EACCES */
+	}
+
+	if (r_msg.sadb_msg_version != w_msg.sadb_msg_version ||
+	    r_msg.sadb_msg_type != w_msg.sadb_msg_type ||
+	    r_msg.sadb_msg_satype != w_msg.sadb_msg_satype ||
+	    r_msg.sadb_msg_seq != w_msg.sadb_msg_seq ||
+	    r_msg.sadb_msg_pid != getpid()) {
+		fprintf(stderr, "Failed to read correct sadb_msg data:\n");
+		fprintf(stderr, "\tSent - ver: %d type: %d sa_type: %d seq: %d pid: %d\n",
+			w_msg.sadb_msg_version, w_msg.sadb_msg_type,
+			w_msg.sadb_msg_satype, w_msg.sadb_msg_seq,
+			w_msg.sadb_msg_pid);
+		fprintf(stderr, "\tRecv - ver: %d type: %d sa_type: %d seq: %d pid: %d\n",
+			r_msg.sadb_msg_version, r_msg.sadb_msg_type,
+			r_msg.sadb_msg_satype, r_msg.sadb_msg_seq,
+			r_msg.sadb_msg_pid);
+		close(sock);
+		exit(-1);
+	}
+
+	if (verbose) {
+		printf("Read sadb_msg data from key management socket:\n");
+		printf("\tver: PF_KEY_V2 type: SADB_FLUSH sa_type: SADB_SATYPE_AH\n");
+		printf("\tseq: %d pid: %d\n", r_msg.sadb_msg_seq,
+		       r_msg.sadb_msg_pid);
+	}
+
+	close(sock);
+	return 0;
+}
diff --git a/tests/key_socket/test b/tests/key_socket/test
new file mode 100755
index 0000000..a13327f
--- /dev/null
+++ b/tests/key_socket/test
@@ -0,0 +1,45 @@
+#!/usr/bin/perl
+use Test::More;
+
+BEGIN {
+    $basedir = $0;
+    $basedir =~ s|(.*)/[^/]*|$1|;
+
+    # allow info to be shown during tests
+    $v = $ARGV[0];
+    if ($v) {
+        if ( $v ne "-v" ) {
+            plan skip_all => "Invalid option (use -v)";
+        }
+    }
+    else {
+        $v = " ";
+    }
+
+    plan tests => 5;
+}
+
+############ Test key_socket #############
+print "Test key management key_socket\n";
+$result = system "runcon -t test_key_sock_t $basedir/key_sock $v";
+ok( $result eq 0 );
+
+# Deny capability { net_admin } - EPERM
+$result =
+  system "runcon -t test_key_sock_no_net_admin_t $basedir/key_sock $v 2>&1";
+ok( $result >> 8 eq 1 );
+
+# Deny key_socket { create } - EACCES
+$result =
+  system "runcon -t test_key_sock_no_create_t $basedir/key_sock $v 2>&1";
+ok( $result >> 8 eq 13 );
+
+# Deny key_socket { write } - EACCES
+$result = system "runcon -t test_key_sock_no_write_t $basedir/key_sock $v 2>&1";
+ok( $result >> 8 eq 13 );
+
+# Deny key_socket { read } - EACCES
+$result = system "runcon -t test_key_sock_no_read_t $basedir/key_sock $v 2>&1";
+ok( $result >> 8 eq 13 );
+
+exit;
-- 
2.23.0

