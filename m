Return-Path: <SRS0=lyW+=Z2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F235FC43603
	for <selinux@archiver.kernel.org>; Wed,  4 Dec 2019 16:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961FE20659
	for <selinux@archiver.kernel.org>; Wed,  4 Dec 2019 16:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="NC8gg7B9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbfLDQnb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:43:31 -0500
Received: from mailomta32-re.btinternet.com ([213.120.69.125]:37759 "EHLO
        re-prd-fep-042.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727008AbfLDQnb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Dec 2019 11:43:31 -0500
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
          by re-prd-fep-042.btinternet.com with ESMTP
          id <20191204164325.NKOW28894.re-prd-fep-042.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
          Wed, 4 Dec 2019 16:43:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1575477805; 
        bh=FhfmZgbvJnb8mg1qTLd0GZenhi53ZLztOcfWTiLdZh8=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=NC8gg7B9Ws9mqSxdLVg5a3p+kM52l7R360wvuTQTOCB5lGs6zK1jxMOV3C0gg7CNI+X7WGSNgS5p5bMkIPsoDZKUJZt3MP+w9TMqF/FwhcYjlZy0KBw/iG/PWFmHBV0U3JML1Zdtz/hLQoTcWv72JAvlYfKtItkqTjbQlCAOmape2iy1tp96kclgOgmr5c9r921wqXcFiibJMKtPIABCsxjxWQ8RCfz0X5Ak3qMoyFVEidytbGDvmW1nXe8wfbqM5dhPypwrJhuGUtPsCaXf8qahcS+y09s468P7+1VQhcCimog5VTyMxttD9c3vSxm9wceUsCZX+3cLJq7iz6mR7g==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.3.29]
X-OWM-Source-IP: 86.134.3.29 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedufedrudejledgledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepkeeirddufeegrdefrddvleenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefgedrfedrvdelpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.3.29) by re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5DE2575E00BB6720; Wed, 4 Dec 2019 16:43:25 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V2] selinux_testsuite: Add socketpair test
Date:   Wed,  4 Dec 2019 16:43:22 +0000
Message-Id: <20191204164322.27083-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Test SO_PEERSEC for sockets created by socketpair(2) added in kernel 4.18

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
V2 Changes:
In run_parent replace sizeof(peerlabel) with strlen(peerlabel)) and set
peerlabel[0] = 0;
Build socketpair unconditionally and check whether to run in test script.
 
 policy/test_unix_socket.te     |   7 ++
 tests/unix_socket/.gitignore   |   1 +
 tests/unix_socket/Makefile     |   2 +-
 tests/unix_socket/socketpair.c | 191 +++++++++++++++++++++++++++++++++
 tests/unix_socket/test         |  32 +++++-
 5 files changed, 229 insertions(+), 4 deletions(-)
 create mode 100644 tests/unix_socket/socketpair.c

diff --git a/policy/test_unix_socket.te b/policy/test_unix_socket.te
index 7dd3362..0ff790a 100644
--- a/policy/test_unix_socket.te
+++ b/policy/test_unix_socket.te
@@ -60,6 +60,13 @@ allow test_unix_dgram_client_t test_unix_server_t:unix_dgram_socket sendto;
 allow test_unix_server_t test_unix_client_sockfile_t:sock_file write;
 allow test_unix_server_t test_unix_dgram_client_t:unix_dgram_socket sendto;
 
+# Domain for socketpair(2) process.
+type test_socketpair_t;
+domain_type(test_socketpair_t)
+unconfined_runs_test(test_socketpair_t)
+typeattribute test_socketpair_t testdomain;
+typeattribute test_socketpair_t unixsocketdomain;
+
 # Allow all of these domains to be entered from the sysadm domain.
 miscfiles_domain_entry_test_files(unixsocketdomain)
 userdom_sysadm_entry_spec_domtrans_to(unixsocketdomain)
diff --git a/tests/unix_socket/.gitignore b/tests/unix_socket/.gitignore
index f2ad853..05ed268 100644
--- a/tests/unix_socket/.gitignore
+++ b/tests/unix_socket/.gitignore
@@ -1,2 +1,3 @@
 client
 server
+socketpair
diff --git a/tests/unix_socket/Makefile b/tests/unix_socket/Makefile
index 5266096..51ba2c6 100644
--- a/tests/unix_socket/Makefile
+++ b/tests/unix_socket/Makefile
@@ -1,4 +1,4 @@
-TARGETS=client server
+TARGETS=client server socketpair
 
 LDLIBS+= -lselinux
 
diff --git a/tests/unix_socket/socketpair.c b/tests/unix_socket/socketpair.c
new file mode 100644
index 0000000..d547d10
--- /dev/null
+++ b/tests/unix_socket/socketpair.c
@@ -0,0 +1,191 @@
+#include <stdlib.h>
+#include <stdio.h>
+#include <stddef.h>
+#include <string.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <selinux/selinux.h>
+
+#ifndef SO_PEERSEC
+#define SO_PEERSEC 31
+#endif
+
+#ifndef SCM_SECURITY
+#define SCM_SECURITY 0x03
+#endif
+
+void print_usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s stream|dgram\n"
+		"Where:\n\t"
+		"stream     Use TCP protocol or:\n\t"
+		"dgram      use UDP protocol.\n", progname);
+	exit(-1);
+}
+
+int run_parent(int sock, int type)
+{
+	int result, on = 1;
+	char byte, peerlabel[256];
+	socklen_t labellen = sizeof(peerlabel);
+
+	result = setsockopt(sock, SOL_SOCKET, SO_PASSSEC, &on, sizeof(on));
+	if (result < 0) {
+		perror("setsockopt: SO_PASSSEC");
+		goto err;
+	}
+
+	if (type == SOCK_STREAM) {
+		result = read(sock, &byte, 1);
+		if (result < 0) {
+			perror("read");
+			goto err;
+		}
+
+		peerlabel[0] = 0;
+		result = getsockopt(sock, SOL_SOCKET, SO_PEERSEC, peerlabel,
+				    &labellen);
+		if (result < 0) {
+			perror("getsockopt: SO_PEERSEC");
+			goto err;
+		}
+		printf("Parent got peer label=%s\n", peerlabel);
+
+		result = write(sock, peerlabel, strlen(peerlabel));
+		if (result < 0) {
+			perror("write");
+			goto err;
+		}
+	} else {
+		struct iovec iov;
+		struct msghdr msg;
+		struct cmsghdr *cmsg;
+		char msglabel[256];
+		union {
+			struct cmsghdr cmsghdr;
+			char buf[CMSG_SPACE(sizeof(msglabel))];
+		} control;
+
+		memset(&iov, 0, sizeof(iov));
+		iov.iov_base = &byte;
+		iov.iov_len = 1;
+		memset(&msg, 0, sizeof(msg));
+		msg.msg_iov = &iov;
+		msg.msg_iovlen = 1;
+		msg.msg_control = &control;
+		msg.msg_controllen = sizeof(control);
+		result = recvmsg(sock, &msg, 0);
+		if (result < 0) {
+			perror("recvmsg");
+			goto err;
+		}
+
+		for (cmsg = CMSG_FIRSTHDR(&msg); cmsg;
+		     cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+			;
+			if (cmsg->cmsg_level == SOL_SOCKET &&
+			    cmsg->cmsg_type == SCM_SECURITY) {
+				size_t len = cmsg->cmsg_len - CMSG_LEN(0);
+
+				if (len > 0 && len < sizeof(msglabel)) {
+					memcpy(msglabel, CMSG_DATA(cmsg), len);
+					msglabel[len] = 0;
+					printf("Parent got SCM_SECURITY=%s\n",
+					       msglabel);
+				}
+			}
+		}
+
+		result = sendto(sock, msglabel, strlen(msglabel), 0,
+				msg.msg_name, msg.msg_namelen);
+		if (result < 0) {
+			perror("sendto");
+			goto err;
+		}
+	}
+
+	result = 0;
+err:
+	close(sock);
+	return result;
+}
+
+int run_child(int sock)
+{
+	int result;
+	char byte = 0, label[256], *mycon;
+
+	result = write(sock, &byte, 1);
+	if (result < 0) {
+		perror("write");
+		goto err;
+	}
+
+	result = read(sock, label, sizeof(label));
+	if (result < 0) {
+		perror("read");
+		goto err;
+	}
+	label[result] = 0;
+
+	result = getcon(&mycon);
+	if (result < 0) {
+		perror("getcon");
+		goto err1;
+	}
+
+	if (strcmp(mycon, label)) {
+		fprintf(stderr, "Child expected %s, got %s\n", mycon, label);
+		result = -1;
+		goto err1;
+	}
+
+	result = 0;
+err1:
+	free(mycon);
+err:
+	close(sock);
+	return result;
+}
+
+int main(int argc, char **argv)
+{
+	int type, result, sockets[2];
+
+	if (argc != 2)
+		print_usage(argv[0]);
+
+	if (!strcmp(argv[1], "stream"))
+		type = SOCK_STREAM;
+	else if (!strcmp(argv[1], "dgram"))
+		type = SOCK_DGRAM;
+	else
+		print_usage(argv[0]);
+
+	result = socketpair(AF_UNIX, type, 0, sockets);
+	if (result < 0) {
+		perror("socketpair");
+		return -1;
+	}
+
+	result = fork();
+	if (result < 0) {
+		perror("fork");
+		close(sockets[0]);
+		close(sockets[1]);
+		return -1;
+	} else if (result > 0) {
+		close(sockets[0]);
+		result = run_parent(sockets[1], type);
+		return result;
+
+	} else {
+		close(sockets[1]);
+		result = run_child(sockets[0]);
+		return result;
+	}
+}
diff --git a/tests/unix_socket/test b/tests/unix_socket/test
index f5f03e8..c48d1ad 100755
--- a/tests/unix_socket/test
+++ b/tests/unix_socket/test
@@ -1,10 +1,27 @@
 #!/usr/bin/perl
 
 use Test;
-BEGIN { plan tests => 8 }
 
-$basedir = $0;
-$basedir =~ s|(.*)/[^/]*|$1|;
+BEGIN {
+    $basedir = $0;
+    $basedir =~ s|(.*)/[^/]*|$1|;
+
+    $test_count = 8;
+    $socketpair = 0;
+
+    $kvercur = `uname -r`;
+    chomp($kvercur);
+
+    # Test SO_PEERSEC for sockets created by socketpair(2).
+    $kverminstream = "4.18";
+    $result        = `$basedir/../kvercmp $kvercur $kverminstream`;
+    if ( $result >= 0 ) {
+        $test_count += 2;
+        $socketpair = 1;
+    }
+
+    plan tests => $test_count;
+}
 
 #
 # Tests for sockets in the abstract namespace.
@@ -106,4 +123,13 @@ server_end($pid);
 # Clean up.
 system "rm -f $basedir/test_client_sock $basedir/test_server_sock";
 
+if ($socketpair) {
+    #### Test SO_PEERSEC for sockets created by socketpair(2) #####
+    $result = system "runcon -t test_socketpair_t $basedir/socketpair stream";
+    ok( $result, 0 );
+
+    $result = system "runcon -t test_socketpair_t $basedir/socketpair dgram";
+    ok( $result, 0 );
+}
+
 exit;
-- 
2.23.0

