Return-Path: <SRS0=pl+I=WK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA188C433FF
	for <selinux@archiver.kernel.org>; Wed, 14 Aug 2019 09:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E4D2083B
	for <selinux@archiver.kernel.org>; Wed, 14 Aug 2019 09:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="CdypWPmP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfHNJWN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Aug 2019 05:22:13 -0400
Received: from mailomta20-re.btinternet.com ([213.120.69.113]:22723 "EHLO
        re-prd-fep-044.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726019AbfHNJWM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Aug 2019 05:22:12 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-044.btinternet.com with ESMTP
          id <20190814092207.OJIY3723.re-prd-fep-044.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Wed, 14 Aug 2019 10:22:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1565774527; 
        bh=Q5JwdMsFV/94fPpujogCDuDCoz0QoMxzddZ6Hy8tHdo=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=CdypWPmPP/voiBn0GcnSVyDpYuA+ohK16Tp1qOaskTTg2FdpifsKFFue0hdNi7FYh/XaAf+boSqmQKOQEOK9ub3FwDFHn0d1YjQeYJ+Ef/MHlAujOz5ywavn+HPiAFXSmZfRXyfHYMOY09tr8xadwWTZkzzzc1CnPUrJRRqtpdAU6ukeb9mqmAzG7kN+KqzwRsTX3c206+CoaqWEq4kalPK4EOwL1aTruEzOh9g71h3tnqTIB8WDkWXytBDb61NXaehmP69d4NjPH0WQuX/MklBOgdYgFjhx9zS1jwUiglmQIcRuIbgw/qpicTgMGSS8uEfMeb+e6wWqYRy8yVrEmg==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.7.87]
X-OWM-Source-IP: 86.134.7.87 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddruddvkedgudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepkeeirddufeegrdejrdekjeenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefgedrjedrkeejpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.7.87) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.335.01) (authenticated as richard_c_haines@btinternet.com)
        id 5D3F8DB101DEF9BA; Wed, 14 Aug 2019 10:22:07 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org, paul@paul-moore.com
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V3 2/2] selinux-testsuite: Add BPF support to fdreceive test
Date:   Wed, 14 Aug 2019 10:22:04 +0100
Message-Id: <20190814092204.3943-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add BPF map & prog functions to test fdreceive security_file_receive path()

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
V2 Change - Added to use tests/bpf/bpf_common.c for BPF tests.
V3 Changes - Run tests under tests/bpf not tests/fdreceive, fix typos.

 policy/Makefile              |  2 +-
 policy/test_fdreceive_bpf.te | 60 ++++++++++++++++++++++++++++++
 tests/bpf/Makefile           |  4 ++
 tests/bpf/test               | 44 +++++++++++++++++++++-
 tests/fdreceive/Makefile     | 18 ++++++++-
 tests/fdreceive/client.c     | 72 +++++++++++++++++++++++++++++++-----
 6 files changed, 186 insertions(+), 14 deletions(-)
 create mode 100644 policy/test_fdreceive_bpf.te

diff --git a/policy/Makefile b/policy/Makefile
index 16a4469..4ca5486 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -72,7 +72,7 @@ TARGETS += test_sctp.te
 endif
 
 ifeq ($(shell grep -q bpf $(POLDEV)/include/support/all_perms.spt && echo true),true)
-TARGETS += test_bpf.te
+TARGETS += test_bpf.te test_fdreceive_bpf.te
 endif
 
 ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
diff --git a/policy/test_fdreceive_bpf.te b/policy/test_fdreceive_bpf.te
new file mode 100644
index 0000000..653f88d
--- /dev/null
+++ b/policy/test_fdreceive_bpf.te
@@ -0,0 +1,60 @@
+#################################
+#
+# Policy for testing BPF file descriptor transfer via socket IPC
+#
+
+attribute fdreceivebpfdomain;
+
+# Domain for bpf client process.
+type test_fdreceive_bpf_client_t;
+domain_type(test_fdreceive_bpf_client_t)
+unconfined_runs_test(test_fdreceive_bpf_client_t)
+typeattribute test_fdreceive_bpf_client_t fdreceivebpfdomain;
+typeattribute test_fdreceive_bpf_client_t testdomain;
+allow test_fdreceive_bpf_client_t test_fdreceive_file_t:file { rw_file_perms };
+allow test_fdreceive_bpf_client_t test_file_t:sock_file { rw_sock_file_perms };
+allow test_fdreceive_bpf_client_t test_fdreceive_server_t:unix_stream_socket { connectto };
+allow test_fdreceive_bpf_client_t self:bpf { map_create map_read map_write prog_load prog_run };
+allow test_fdreceive_bpf_client_t self:capability { sys_admin sys_resource };
+allow test_fdreceive_bpf_client_t self:process { setrlimit };
+# Server side rules:
+allow test_fdreceive_server_t test_fdreceive_bpf_client_t:fd { use };
+allow test_fdreceive_server_t test_fdreceive_bpf_client_t:bpf { map_read map_write };
+allow test_fdreceive_server_t test_fdreceive_bpf_client_t:bpf { prog_run} ;
+
+# Domain for bpf client2 process - Removes BPF prog_run perm from server.
+# Tests security_file_receive flow.
+type test_fdreceive_bpf_client2_t;
+domain_type(test_fdreceive_bpf_client2_t)
+unconfined_runs_test(test_fdreceive_bpf_client2_t)
+typeattribute test_fdreceive_bpf_client2_t fdreceivebpfdomain;
+typeattribute test_fdreceive_bpf_client2_t testdomain;
+allow test_fdreceive_bpf_client2_t test_fdreceive_file_t:file { rw_file_perms };
+allow test_fdreceive_bpf_client2_t test_file_t:sock_file { rw_sock_file_perms };
+allow test_fdreceive_bpf_client2_t test_fdreceive_server_t:unix_stream_socket { connectto };
+allow test_fdreceive_bpf_client2_t self:bpf { prog_load prog_run };
+allow test_fdreceive_bpf_client2_t self:capability { sys_admin sys_resource };
+allow test_fdreceive_bpf_client2_t self:process { setrlimit };
+# Server side rules:
+allow test_fdreceive_server_t test_fdreceive_bpf_client2_t:fd { use };
+
+# Domain for bpf client3 process - Removes BPF map_read perm from server.
+# Tests security_file_receive flow.
+type test_fdreceive_bpf_client3_t;
+domain_type(test_fdreceive_bpf_client3_t)
+unconfined_runs_test(test_fdreceive_bpf_client3_t)
+typeattribute test_fdreceive_bpf_client3_t fdreceivebpfdomain;
+typeattribute test_fdreceive_bpf_client3_t testdomain;
+allow test_fdreceive_bpf_client3_t test_fdreceive_file_t:file { rw_file_perms };
+allow test_fdreceive_bpf_client3_t test_file_t:sock_file { rw_sock_file_perms };
+allow test_fdreceive_bpf_client3_t test_fdreceive_server_t:unix_stream_socket { connectto };
+allow test_fdreceive_bpf_client3_t self:bpf { map_create map_read map_write };
+allow test_fdreceive_bpf_client3_t self:capability { sys_admin sys_resource };
+allow test_fdreceive_bpf_client3_t self:process { setrlimit };
+# Server side rules:
+allow test_fdreceive_server_t test_fdreceive_bpf_client3_t:fd { use };
+allow test_fdreceive_server_t test_fdreceive_bpf_client3_t:bpf { map_write };
+
+# Allow all of these domains to be entered from the sysadm domain.
+miscfiles_domain_entry_test_files(fdreceivebpfdomain)
+userdom_sysadm_entry_spec_domtrans_to(fdreceivebpfdomain)
diff --git a/tests/bpf/Makefile b/tests/bpf/Makefile
index 78ae9db..5149d76 100644
--- a/tests/bpf/Makefile
+++ b/tests/bpf/Makefile
@@ -4,9 +4,13 @@ DEPS = bpf_common.c
 LDLIBS += -lselinux -lbpf
 CFLAGS += -DHAVE_BPF
 
+BPF_ENABLED = ../fdreceive
+
 all: $(TARGETS)
+	@set -e; for i in $(BPF_ENABLED); do $(MAKE) -C $$i all ; done
 
 clean:
 	rm -f $(TARGETS)
+	@set -e; for i in $(BPF_ENABLED); do $(MAKE) -C $$i clean ; done
 
 $(TARGETS): $(DEPS)
diff --git a/tests/bpf/test b/tests/bpf/test
index 1d41d72..5cc1249 100755
--- a/tests/bpf/test
+++ b/tests/bpf/test
@@ -4,6 +4,7 @@ use Test::More;
 BEGIN {
     $basedir = $0;
     $basedir =~ s|(.*)/[^/]*|$1|;
+    $fdr_basedir = "$basedir/../fdreceive/";
 
     # allow info to be shown during tests
     $v = $ARGV[0];
@@ -16,7 +17,7 @@ BEGIN {
         $v = " ";
     }
 
-    plan tests => 7;
+    plan tests => 11;
 }
 
 #
@@ -55,4 +56,45 @@ $result =
   system "runcon -t test_bpf_deny_prog_run_t $basedir/bpf_test -p $v 2>&1";
 ok( $result >> 8 eq 2 );
 
+#
+################ BPF Tests for fdreceive #######################
+#
+# Remove any leftover test file from prior failed runs.
+system("rm -rf $basedir/test_sock");
+
+# Start server process in test_fdreceive_server_t.
+system("mkfifo $basedir/flag");
+if ( ( $pid = fork() ) == 0 ) {
+    exec
+"runcon -t test_fdreceive_server_t $fdr_basedir/server $basedir/flag $basedir/test_sock";
+}
+
+# Wait for it to initialize.
+system("read -t 5 <>$basedir/flag");
+
+# Test BPF map & prog fd on transfer:
+$result = system
+"runcon -t test_fdreceive_bpf_client_t -- $fdr_basedir/client -m $basedir/test_sock";
+ok( $result eq 0 );
+
+$result = system
+"runcon -t test_fdreceive_bpf_client_t -- $fdr_basedir/client -p $basedir/test_sock";
+ok( $result eq 0 );
+
+# Remove BPF prog_run permission from server:
+$result = system
+"runcon -t test_fdreceive_bpf_client2_t -- $fdr_basedir/client -p $basedir/test_sock";
+ok($result);
+
+# Remove BPF map_read permission from server:
+$result = system
+"runcon -t test_fdreceive_bpf_client3_t -- $fdr_basedir/client -m $basedir/test_sock";
+ok($result);
+
+# Kill the server.
+kill KILL, $pid;
+
+# Clean up.
+system "rm -rf $basedir/test_sock $basedir/flag";
+
 exit;
diff --git a/tests/fdreceive/Makefile b/tests/fdreceive/Makefile
index bc33f1b..7afe230 100644
--- a/tests/fdreceive/Makefile
+++ b/tests/fdreceive/Makefile
@@ -1,3 +1,17 @@
-all: client server
+# Required for local building
+INCLUDEDIR ?= /usr/include
+
+TARGETS = client server
+DEPS = ../bpf/bpf_common.c
+
+ifeq ($(shell test -e $(INCLUDEDIR)/bpf/bpf.h && echo true),true)
+	CFLAGS += -DHAVE_BPF
+	LDLIBS += -lbpf
+endif
+
+all: $(TARGETS)
+
 clean:
-	rm -f client server
+	rm -f $(TARGETS)
+
+client: $(DEPS)
diff --git a/tests/fdreceive/client.c b/tests/fdreceive/client.c
index de40bc7..e330afc 100644
--- a/tests/fdreceive/client.c
+++ b/tests/fdreceive/client.c
@@ -8,11 +8,28 @@
 #include <stdio.h>
 #include <stdlib.h>
 
+int create_bpf_map(void);
+int create_bpf_prog(void);
+void bpf_setrlimit(void);
+
+static void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s [-m|-p] [file] addr\n"
+		"\nWhere:\n\t"
+		"-m    Create BPF map fd\n\t"
+		"-p    Create BPF prog fd\n\t"
+		"   If -m or -p not supplied, create a file fd using:\n\t"
+		"file  Test file fd sent to server\n\t"
+		"addr  Servers address\n", progname);
+	exit(-1);
+}
+
 int main(int argc, char **argv)
 {
 	struct sockaddr_un sun;
-	char buf[1024];
-	int s, sunlen, ret, buflen;
+	char buf[1024], *addr = NULL;
+	int opt, s, sunlen, ret, buflen, bpf_fd_type;
 	struct msghdr msg = { 0 };
 	struct iovec iov;
 	struct cmsghdr *cmsg;
@@ -20,15 +37,49 @@ int main(int argc, char **argv)
 	char cmsgbuf[CMSG_SPACE(sizeof myfd)];
 	int *fdptr;
 
-	if (argc != 3) {
-		fprintf(stderr, "usage:  %s testfile address\n", argv[0]);
-		exit(-1);
+	bpf_fd_type = 0;
+
+	while ((opt = getopt(argc, argv, "mp")) != -1) {
+		switch (opt) {
+		case 'm':
+			bpf_fd_type = 1;
+			break;
+		case 'p':
+			bpf_fd_type = 2;
+			break;
+		}
 	}
 
-	myfd = open(argv[1], O_RDWR);
-	if (myfd < 0) {
-		perror(argv[1]);
-		exit(-1);
+	if ((bpf_fd_type == 0 && (argc - optind) != 2) ||
+	    (bpf_fd_type > 0 && (argc - optind) != 1))
+		usage(argv[0]);
+
+	switch (bpf_fd_type) {
+	case 0:
+		myfd = open(argv[optind], O_RDWR);
+		if (myfd < 0) {
+			perror(argv[optind]);
+			exit(-1);
+		}
+
+		addr = argv[optind + 1];
+		printf("client: Using a file fd\n");
+		break;
+	case 1:
+		/* If BPF enabled, then need to set limits */
+		bpf_setrlimit();
+		myfd = create_bpf_map();
+		addr = argv[optind];
+		printf("client: Using a BPF map fd\n");
+		break;
+	case 2:
+		bpf_setrlimit();
+		myfd = create_bpf_prog();
+		addr = argv[optind];
+		printf("client: Using a BPF prog fd\n");
+		break;
+	default:
+		usage(argv[0]);
 	}
 
 	s = socket(AF_UNIX, SOCK_STREAM, 0);
@@ -38,7 +89,8 @@ int main(int argc, char **argv)
 	}
 
 	sun.sun_family = AF_UNIX;
-	strcpy(sun.sun_path, argv[2]);
+	strcpy(sun.sun_path, addr);
+
 	sunlen = strlen(sun.sun_path) + 1 + sizeof(short);
 	ret = connect(s, (struct sockaddr *)&sun, sunlen);
 	if (ret < 0) {
-- 
2.21.0

