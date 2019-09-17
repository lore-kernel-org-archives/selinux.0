Return-Path: <SRS0=Kbw6=XM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D4CC4CECE
	for <selinux@archiver.kernel.org>; Tue, 17 Sep 2019 14:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D5E21897
	for <selinux@archiver.kernel.org>; Tue, 17 Sep 2019 14:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="JMlY2P/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfIQO4t (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Sep 2019 10:56:49 -0400
Received: from mailomta27-re.btinternet.com ([213.120.69.120]:32272 "EHLO
        re-prd-fep-040.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728187AbfIQO4t (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Sep 2019 10:56:49 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-040.btinternet.com with ESMTP
          id <20190917145646.DSE17605.re-prd-fep-040.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Tue, 17 Sep 2019 15:56:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1568732206; 
        bh=dcV9ClDPs0Id7kcPTy9ltrPsP9UUCyuwD9uzEhAQa3M=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=JMlY2P/xtRCiqUJZXExZ1UmoUGBLkkMEuTomjNZviIlLj3NGuIY3E88rGst81x0c4X+VPRQR5KX3b/JDl9D5sml0V4MgkuK/TRwRo20rHDSv48OWiCry3Jp7owcv7mKloXOmSE380k6y+ppHda5cvKeAhXQYyXbBEIlnndifA1lahsHVj4ND3jhDs7I1rD2e/aC/h/VunKf2s+lPaZg1F+0Q/0y/0CPHhvH/KbVORZj5NdXz4gnDMzLWVj4oc9fwm+yUdkQFWe+oXwZPsTCus5L2TM3YZa24rOHloVevvluGQPYqm/7+UqyXqnyJX8iTPUsVFTjWewcjQKxo9eCu0Q==
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.134.6.116]
X-OWM-Source-IP: 86.134.6.116 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedufedrudeigdehhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeekiedrudefgedriedrudduieenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefgedriedrudduiedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgushesthihtghhohdrnhhsrgdrghhovheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.6.116) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5D7F5CD800382C67; Tue, 17 Sep 2019 15:56:46 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org, paul@paul-moore.com, sds@tycho.nsa.gov
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V4 2/3] selinux-testsuite: Add BPF support to fdreceive test
Date:   Tue, 17 Sep 2019 15:56:39 +0100
Message-Id: <20190917145640.25629-3-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190917145640.25629-1-richard_c_haines@btinternet.com>
References: <20190917145640.25629-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add BPF map & prog functions to test fdreceive security_file_receive path()

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 policy/Makefile              |  2 +-
 policy/test_fdreceive_bpf.te | 60 +++++++++++++++++++++++
 tests/bpf/Makefile           |  7 +++
 tests/bpf/test               | 55 ++++++++++++++++++++-
 tests/fdreceive/Makefile     | 14 +++++-
 tests/fdreceive/client.c     | 93 ++++++++++++++++++++++++++++++++----
 6 files changed, 218 insertions(+), 13 deletions(-)
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
index 0000000..961de79
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
+allow test_fdreceive_bpf_client_t self:capability { sys_resource };
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
+allow test_fdreceive_bpf_client2_t self:capability { sys_resource };
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
+allow test_fdreceive_bpf_client3_t self:capability { sys_resource };
+allow test_fdreceive_bpf_client3_t self:process { setrlimit };
+# Server side rules:
+allow test_fdreceive_server_t test_fdreceive_bpf_client3_t:fd { use };
+allow test_fdreceive_server_t test_fdreceive_bpf_client3_t:bpf { map_write };
+
+# Allow all of these domains to be entered from the sysadm domain.
+miscfiles_domain_entry_test_files(fdreceivebpfdomain)
+userdom_sysadm_entry_spec_domtrans_to(fdreceivebpfdomain)
diff --git a/tests/bpf/Makefile b/tests/bpf/Makefile
index 46817a5..3513179 100644
--- a/tests/bpf/Makefile
+++ b/tests/bpf/Makefile
@@ -2,9 +2,16 @@ TARGETS = bpf_test
 DEPS = bpf_common.c bpf_common.h
 LDLIBS += -lselinux -lbpf
 
+# export so that BPF_ENABLED entries get built correctly on local build
+export CFLAGS += -DHAVE_BPF
+
+BPF_ENABLED = ../fdreceive
+
 all: $(TARGETS)
+	@set -e; for i in $(BPF_ENABLED); do $(MAKE) -C $$i all ; done
 
 clean:
 	rm -f $(TARGETS)
+	@set -e; for i in $(BPF_ENABLED); do $(MAKE) -C $$i clean ; done
 
 $(TARGETS): $(DEPS)
diff --git a/tests/bpf/test b/tests/bpf/test
index ee00a19..36f1f32 100755
--- a/tests/bpf/test
+++ b/tests/bpf/test
@@ -4,8 +4,10 @@ use Test::More;
 BEGIN {
     $basedir = $0;
     $basedir =~ s|(.*)/[^/]*|$1|;
+    $fdr_basedir = "$basedir/../fdreceive/";
 
-    $test_count = 7;
+    $test_count     = 7;
+    $test_fdreceive = 0;
 
     # allow info to be shown during tests
     $v = $ARGV[0];
@@ -18,6 +20,14 @@ BEGIN {
         $v = " ";
     }
 
+    # Test if fdreceive is BPF enabled
+    $result = system("$fdr_basedir/client -t $basedir/test_sock 2>/dev/null");
+
+    if ( $result >> 8 eq 0 ) {
+        $test_fdreceive = 1;
+        $test_count += 4;
+    }
+
     plan tests => $test_count;
 }
 
@@ -61,4 +71,47 @@ $result =
   system "runcon -t test_bpf_deny_prog_run_t $basedir/bpf_test -p $v 2>&1";
 ok($result);
 
+if ($test_fdreceive) {
+    #
+    ################ BPF Tests for fdreceive #######################
+    #
+    # Remove any leftover test file from prior failed runs.
+    system("rm -rf $basedir/test_sock");
+
+    # Start server process in test_fdreceive_server_t.
+    system("mkfifo $basedir/flag");
+    if ( ( $pid = fork() ) == 0 ) {
+        exec
+"runcon -t test_fdreceive_server_t $fdr_basedir/server $basedir/flag $basedir/test_sock";
+    }
+
+    # Wait for it to initialize.
+    system("read -t 5 <>$basedir/flag");
+
+    # Test BPF map & prog fd on transfer:
+    $result = system
+"runcon -t test_fdreceive_bpf_client_t -- $fdr_basedir/client -m $basedir/test_sock";
+    ok( $result eq 0 );
+
+    $result = system
+"runcon -t test_fdreceive_bpf_client_t -- $fdr_basedir/client -p $basedir/test_sock";
+    ok( $result eq 0 );
+
+    # Remove BPF prog_run permission from server:
+    $result = system
+"runcon -t test_fdreceive_bpf_client2_t -- $fdr_basedir/client -p $basedir/test_sock";
+    ok($result);
+
+    # Remove BPF map_read permission from server:
+    $result = system
+"runcon -t test_fdreceive_bpf_client3_t -- $fdr_basedir/client -m $basedir/test_sock";
+    ok($result);
+
+    # Kill the server.
+    kill KILL, $pid;
+
+    # Clean up.
+    system "rm -rf $basedir/test_sock $basedir/flag";
+}
+
 exit;
diff --git a/tests/fdreceive/Makefile b/tests/fdreceive/Makefile
index bc33f1b..895f91c 100644
--- a/tests/fdreceive/Makefile
+++ b/tests/fdreceive/Makefile
@@ -1,3 +1,13 @@
-all: client server
+TARGETS = client server
+
+ifneq (,$(findstring -DHAVE_BPF,$(CFLAGS)))
+	DEPS = ../bpf/bpf_common.c ../bpf/bpf_common.h
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
index de40bc7..770cc99 100644
--- a/tests/fdreceive/client.c
+++ b/tests/fdreceive/client.c
@@ -8,11 +8,29 @@
 #include <stdio.h>
 #include <stdlib.h>
 
+#if HAVE_BPF
+#include "../bpf/bpf_common.h"
+#endif
+
+static void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s [-m|-p|t] [file] addr\n"
+		"\nWhere:\n\t"
+		"-m    Create BPF map fd\n\t"
+		"-p    Create BPF prog fd\n\t"
+		"-t    Test if BPF enabled\n\t"
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
+	int opt, s, sunlen, ret, buflen;
 	struct msghdr msg = { 0 };
 	struct iovec iov;
 	struct cmsghdr *cmsg;
@@ -20,15 +38,71 @@ int main(int argc, char **argv)
 	char cmsgbuf[CMSG_SPACE(sizeof myfd)];
 	int *fdptr;
 
-	if (argc != 3) {
-		fprintf(stderr, "usage:  %s testfile address\n", argv[0]);
-		exit(-1);
+	enum {
+		FILE_FD,
+		MAP_FD,
+		PROG_FD,
+		BPF_TEST
+	} client_fd_type;
+
+	client_fd_type = FILE_FD;
+
+	while ((opt = getopt(argc, argv, "mpt")) != -1) {
+		switch (opt) {
+		case 'm':
+			client_fd_type = MAP_FD;
+			break;
+		case 'p':
+			client_fd_type = PROG_FD;
+			break;
+		case 't':
+			client_fd_type = BPF_TEST;
+			break;
+		}
 	}
 
-	myfd = open(argv[1], O_RDWR);
-	if (myfd < 0) {
-		perror(argv[1]);
+	if ((client_fd_type == FILE_FD && (argc - optind) != 2) ||
+	    (client_fd_type > FILE_FD && (argc - optind) != 1))
+		usage(argv[0]);
+
+	switch (client_fd_type) {
+	case FILE_FD:
+		myfd = open(argv[optind], O_RDWR);
+		if (myfd < 0) {
+			perror(argv[optind]);
+			exit(-1);
+		}
+
+		addr = argv[optind + 1];
+		printf("client: Using a file fd\n");
+		break;
+#if HAVE_BPF
+	case MAP_FD:
+		/* If BPF enabled, then need to set limits */
+		bpf_setrlimit();
+		addr = argv[optind];
+		myfd = create_bpf_map();
+		printf("client: Using a BPF map fd\n");
+		break;
+	case PROG_FD:
+		bpf_setrlimit();
+		addr = argv[optind];
+		myfd = create_bpf_prog();
+		printf("client: Using a BPF prog fd\n");
+		break;
+	case BPF_TEST:
+		exit(0);
+		break;
+#else
+	case MAP_FD:
+	case PROG_FD:
+	case BPF_TEST:
+		fprintf(stderr, "BPF not supported by Client\n");
 		exit(-1);
+		break;
+#endif
+	default:
+		usage(argv[0]);
 	}
 
 	s = socket(AF_UNIX, SOCK_STREAM, 0);
@@ -38,7 +112,8 @@ int main(int argc, char **argv)
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

