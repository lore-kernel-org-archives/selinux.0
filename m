Return-Path: <SRS0=Kbw6=XM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2BFC4CECE
	for <selinux@archiver.kernel.org>; Tue, 17 Sep 2019 14:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A800821897
	for <selinux@archiver.kernel.org>; Tue, 17 Sep 2019 14:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="Xn46edtC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfIQO4u (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Sep 2019 10:56:50 -0400
Received: from mailomta18-re.btinternet.com ([213.120.69.111]:64498 "EHLO
        re-prd-fep-048.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728782AbfIQO4u (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Sep 2019 10:56:50 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-048.btinternet.com with ESMTP
          id <20190917145647.KUQS7001.re-prd-fep-048.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Tue, 17 Sep 2019 15:56:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1568732207; 
        bh=NK2F1NKT311a3Ebdb6N7KWDtltdevrgF4KMU7YdXkmk=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=Xn46edtCpzn+bEG4/P5GzWraYvL75WDLUCx15GoI760HjR3CDzWZ17N8BD3hXaSIQ4LJlKWQgcDCpGauWLPjXBFSh2FVTdNi//Nx2LakdLgfn20zBm+dTWUUXOW/CO0axy/CWw3gbK57dhKY0TpYzVm3DJfCOhjO9UesSskM9bS3HMq+SCvMXP/qtpAQsg/K34urRO5MmplpFsfVOouqBXqaGd3eZjrsx1m1plHOBA9RP9RHYhE0LHo8KaJBQSwF0qtU99I3SmJ634SYlrReEHJ0//pwpCNfL5UJq90g3wfuaF5zfaBpLFyrZdZCwwfYgH0MYlTas+KpBSbpBqWnKw==
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.134.6.116]
X-OWM-Source-IP: 86.134.6.116 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedufedrudeigdehhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpehtgihnrdhtrghrghgvthdpthignhdruggrthgrnecukfhppeekiedrudefgedriedrudduieenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefgedriedrudduiedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgushesthihtghhohdrnhhsrgdrghhovheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.6.116) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5D7F5CD800382C76; Tue, 17 Sep 2019 15:56:47 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org, paul@paul-moore.com, sds@tycho.nsa.gov
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V4 3/3] selinux-testsuite: Add BPF support to binder test
Date:   Tue, 17 Sep 2019 15:56:40 +0100
Message-Id: <20190917145640.25629-4-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190917145640.25629-1-richard_c_haines@btinternet.com>
References: <20190917145640.25629-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add BPF map & prog functions to test binder security_binder_transfer_file()

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 policy/Makefile                 |   2 +-
 policy/test_binder_bpf.te       |  73 ++++++++++++++++++++
 tests/binder/Makefile           |   5 ++
 tests/binder/binder_common.c    |  10 +--
 tests/binder/binder_common.h    |  17 ++++-
 tests/binder/client.c           |  28 ++++++--
 tests/binder/manager.c          |   2 +-
 tests/binder/service_provider.c | 118 ++++++++++++++++++++++++--------
 tests/bpf/Makefile              |   2 +-
 tests/bpf/test                  |  84 ++++++++++++++++++++++-
 10 files changed, 297 insertions(+), 44 deletions(-)
 create mode 100644 policy/test_binder_bpf.te

diff --git a/policy/Makefile b/policy/Makefile
index 4ca5486..d72eb62 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -72,7 +72,7 @@ TARGETS += test_sctp.te
 endif
 
 ifeq ($(shell grep -q bpf $(POLDEV)/include/support/all_perms.spt && echo true),true)
-TARGETS += test_bpf.te test_fdreceive_bpf.te
+TARGETS += test_bpf.te test_fdreceive_bpf.te test_binder_bpf.te
 endif
 
 ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
diff --git a/policy/test_binder_bpf.te b/policy/test_binder_bpf.te
new file mode 100644
index 0000000..c545846
--- /dev/null
+++ b/policy/test_binder_bpf.te
@@ -0,0 +1,73 @@
+####### Policy for testing BPF file descriptor transfers via binder #########
+
+attribute binderbpfdomain;
+
+#
+################################## Manager ##################################
+#
+type test_binder_bpf_mgr_t;
+domain_type(test_binder_bpf_mgr_t)
+unconfined_runs_test(test_binder_bpf_mgr_t)
+typeattribute test_binder_bpf_mgr_t testdomain;
+typeattribute test_binder_bpf_mgr_t binderdomain;
+allow test_binder_bpf_mgr_t test_binder_bpf_client_t:binder { transfer };
+allow test_binder_bpf_mgr_t test_binder_client_no_bpf_perm_t:binder { transfer };
+allow test_binder_bpf_mgr_t device_t:chr_file { ioctl open read write };
+allow_map(test_binder_bpf_mgr_t, device_t, chr_file)
+allow test_binder_bpf_mgr_t self:binder { set_context_mgr };
+# For writing to flag file:
+allow test_binder_bpf_mgr_t test_file_t:fifo_file { rw_file_perms };
+
+#
+########################### Service Provider ################################
+#
+type test_binder_bpf_provider_t;
+domain_type(test_binder_bpf_provider_t)
+unconfined_runs_test(test_binder_bpf_provider_t)
+typeattribute test_binder_bpf_provider_t testdomain;
+typeattribute test_binder_bpf_provider_t binderbpfdomain;
+allow test_binder_bpf_provider_t test_binder_bpf_mgr_t:binder { call transfer };
+allow test_binder_bpf_provider_t device_t:chr_file { ioctl open read write };
+allow_map(test_binder_bpf_provider_t, device_t, chr_file)
+# For writing to flag file:
+allow test_binder_bpf_provider_t test_file_t:fifo_file { rw_file_perms };
+# For testing BPF map fd transfer:
+allow test_binder_bpf_provider_t self:bpf { map_create map_read map_write prog_load prog_run };
+allow test_binder_bpf_provider_t self:capability { sys_resource };
+allow test_binder_bpf_provider_t self:process { setrlimit };
+
+#
+################################# Client ####################################
+#
+type test_binder_bpf_client_t;
+domain_type(test_binder_bpf_client_t)
+unconfined_runs_test(test_binder_bpf_client_t)
+typeattribute test_binder_bpf_client_t testdomain;
+typeattribute test_binder_bpf_client_t binderbpfdomain;
+allow test_binder_bpf_client_t test_binder_bpf_provider_t:binder { call impersonate };
+allow test_binder_bpf_client_t test_binder_bpf_mgr_t:binder { call };
+allow test_binder_bpf_client_t test_binder_bpf_provider_t:fd { use };
+allow test_binder_bpf_client_t device_t:chr_file { getattr ioctl open read write };
+allow_map(test_binder_bpf_client_t, device_t, chr_file)
+# For testing BPF map fd transfer:
+allow test_binder_bpf_client_t test_binder_bpf_provider_t:bpf { map_read map_write prog_load prog_run };
+
+#
+######################## Client no BPF perms #############################
+#
+type test_binder_client_no_bpf_perm_t;
+domain_type(test_binder_client_no_bpf_perm_t)
+unconfined_runs_test(test_binder_client_no_bpf_perm_t)
+typeattribute test_binder_client_no_bpf_perm_t testdomain;
+typeattribute test_binder_client_no_bpf_perm_t binderbpfdomain;
+allow test_binder_client_no_bpf_perm_t test_binder_bpf_provider_t:binder { call impersonate };
+allow test_binder_client_no_bpf_perm_t test_binder_bpf_mgr_t:binder { call };
+allow test_binder_client_no_bpf_perm_t test_binder_bpf_provider_t:fd { use };
+allow test_binder_client_no_bpf_perm_t device_t:chr_file { getattr ioctl open read write };
+allow_map(test_binder_client_no_bpf_perm_t, device_t, chr_file)
+
+#
+########### Allow these domains to be entered from sysadm domain ############
+#
+miscfiles_domain_entry_test_files(binderbpfdomain)
+userdom_sysadm_entry_spec_domtrans_to(binderbpfdomain)
diff --git a/tests/binder/Makefile b/tests/binder/Makefile
index 32f9a83..e78ad16 100644
--- a/tests/binder/Makefile
+++ b/tests/binder/Makefile
@@ -10,6 +10,11 @@ CFLAGS += -DHAVE_BINDERFS
 TARGETS += check_binderfs
 endif
 
+ifneq (,$(findstring -DHAVE_BPF,$(CFLAGS)))
+	DEPS += ../bpf/bpf_common.c ../bpf/bpf_common.h
+	LDLIBS += -lbpf
+endif
+
 all: $(TARGETS)
 
 clean:
diff --git a/tests/binder/binder_common.c b/tests/binder/binder_common.c
index a240453..224238b 100644
--- a/tests/binder/binder_common.c
+++ b/tests/binder/binder_common.c
@@ -3,13 +3,15 @@
  * the raw ioctl commands to test the SELinux binder permissions:
  *     set_context_mgr, call, transfer, impersonate.
  *
+ * If configured, the BPF permissions are also tested.
+ *
  * Using binder test policy the following will be validated:
  *    security_binder_set_context_mgr() binder { set_context_mgr }
  *    security_binder_transaction()     binder { call impersonate }
  *    security_binder_transfer_binder() binder { transfer }
  *    security_binder_transfer_file()   fd { use }
- *
- * TODO security_binder_transfer_file() uses BPF if configured in kernel.
+ *					bpf { map_create map_read map_write };
+ *					bpf { prog_load prog_run };
  */
 
 #include "binder_common.h"
@@ -67,8 +69,8 @@ void print_trans_data(const struct binder_transaction_data *txn_in)
 	case TEST_SERVICE_GET:
 		printf("\tcode: TEST_SERVICE_GET\n");
 		break;
-	case TEST_SERVICE_SEND_CLIENT_SP_FD:
-		printf("\tcode: TEST_SERVICE_SEND_CLIENT_SP_FD\n");
+	case TEST_SERVICE_SEND_FD:
+		printf("\tcode: TEST_SERVICE_SEND_FD\n");
 		break;
 	default:
 		printf("Unknown binder_transaction_data->code: %x\n",
diff --git a/tests/binder/binder_common.h b/tests/binder/binder_common.h
index bcf9e0c..30edc75 100644
--- a/tests/binder/binder_common.h
+++ b/tests/binder/binder_common.h
@@ -15,6 +15,9 @@
 #if HAVE_BINDERFS
 #include <linux/android/binderfs.h>
 #endif
+#if HAVE_BPF
+#include "../bpf/bpf_common.h"
+#endif
 
 #define BINDER_DEV "/dev/binder"
 #define BINDERFS_DEV "/dev/binderfs"
@@ -26,12 +29,20 @@
 /* These are the Binder txn->code values used by the Service Provider, Client
  * and Manager to request/retrieve a binder handle or file descriptor.
  */
-#define TEST_SERVICE_ADD		240616 /* Sent by Service Provider */
-#define TEST_SERVICE_GET		290317 /* Sent by Client */
-#define TEST_SERVICE_SEND_CLIENT_SP_FD	120419 /* Sent by Client */
+#define TEST_SERVICE_ADD	240616 /* Sent by Service Provider */
+#define TEST_SERVICE_GET	290317 /* Sent by Client */
+#define TEST_SERVICE_SEND_FD	311019 /* Sent by Client */
 
 bool verbose;
 
 const char *cmd_name(uint32_t cmd);
 void print_trans_data(const struct binder_transaction_data *txn_in);
 int binder_write(int fd, void *data, size_t len);
+
+enum {
+	BINDER_FD,
+	BPF_MAP_FD,
+	BPF_PROG_FD,
+	BPF_TEST
+} fd_type;
+char *fd_type_str;
diff --git a/tests/binder/client.c b/tests/binder/client.c
index e4e2a61..4965563 100644
--- a/tests/binder/client.c
+++ b/tests/binder/client.c
@@ -6,7 +6,7 @@ static int transactions_complete;
 static void usage(char *progname)
 {
 	fprintf(stderr,
-		"usage:  %s [-c] [-n] [-r replies] [-v]\n"
+		"usage:  %s [-c] [-n] [-r replies] [-m|-p] [-v]\n"
 		"Where:\n\t"
 		"-c  Use the number of replies for the BR_TRANSACTION_COMPLETE"
 		" count.\n\t"
@@ -15,6 +15,8 @@ static void usage(char *progname)
 		"    It can be the number of BR_TRANSACTION_COMPLETE if\n\t"
 		"    the -c option is set or number of times to issue the\n\t"
 		"    ioctl - BINDER_WRITE_READ command if -c not set.\n\t"
+		"-m  Service Provider sending BPF map fd.\n\t"
+		"-p  Service Provider sending BPF prog fd.\n\t"
 		"-v  Print context and command information.\n\t"
 		"\nNote: Ensure this boolean command is run when "
 		"testing after a reboot:\n\t"
@@ -67,8 +69,12 @@ static void extract_fd_and_respond(const struct binder_transaction_data *txn_in)
 	}
 
 	if (verbose)
-		printf("Client retrieved Service Providers fd: %d st_dev: %ld\n",
-		       obj->fd, sb.st_dev);
+		printf("Client retrieved %s fd: %d st_dev: %ld\n",
+		       fd_type_str, obj->fd, sb.st_dev);
+
+	/* If testing BPF, then cannot do impersonate check */
+	if (fd_type > BINDER_FD)
+		return;
 
 	memset(&writebuf, 0, sizeof(writebuf));
 	memset(readbuf, 0, sizeof(readbuf));
@@ -141,7 +147,7 @@ static void request_service_provider_fd(int fd, uint32_t handle)
 	writebuf.cmd = BC_TRANSACTION;
 	writebuf.txn.target.handle = handle;
 	writebuf.txn.cookie = 0;
-	writebuf.txn.code = TEST_SERVICE_SEND_CLIENT_SP_FD;
+	writebuf.txn.code = TEST_SERVICE_SEND_FD;
 	writebuf.txn.flags = TF_ACCEPT_FDS;
 
 	writebuf.txn.data_size = 0;
@@ -270,7 +276,7 @@ static int binder_parse(int fd, binder_uintptr_t ptr, binder_size_t size)
 			if (txn->code == TEST_SERVICE_GET)
 				extract_handle_and_acquire(fd, txn);
 
-			if (txn->code == TEST_SERVICE_SEND_CLIENT_SP_FD)
+			if (txn->code == TEST_SERVICE_SEND_FD)
 				extract_fd_and_respond(txn);
 
 			ptr += sizeof(*txn);
@@ -313,8 +319,10 @@ int main(int argc, char **argv)
 	unsigned int readbuf[32];
 
 	transactions_complete = 0;
+	fd_type = BINDER_FD;
+	fd_type_str = "SP";
 
-	while ((opt = getopt(argc, argv, "cnr:v")) != -1) {
+	while ((opt = getopt(argc, argv, "cnr:vmp")) != -1) {
 		switch (opt) {
 		case 'c':
 			use_transactions_complete = true;
@@ -328,6 +336,14 @@ int main(int argc, char **argv)
 		case 'v':
 			verbose = true;
 			break;
+		case 'm':
+			fd_type = BPF_MAP_FD;
+			fd_type_str = "BPF map";
+			break;
+		case 'p':
+			fd_type = BPF_PROG_FD;
+			fd_type_str = "BPF prog";
+			break;
 		default:
 			usage(argv[0]);
 		}
diff --git a/tests/binder/manager.c b/tests/binder/manager.c
index 9922183..8e5f446 100644
--- a/tests/binder/manager.c
+++ b/tests/binder/manager.c
@@ -91,7 +91,7 @@ static void do_service_manager(int fd, struct binder_transaction_data *txn_in)
 		reply_with_handle(fd, txn_in);
 
 		break;
-	case TEST_SERVICE_SEND_CLIENT_SP_FD:
+	case TEST_SERVICE_SEND_FD:
 		if (verbose)
 			printf("Manager Rx'ed SEND_CLIENT_YOUR_BINDER_FD for handle: %d\n",
 			       txn_in->target.handle);
diff --git a/tests/binder/service_provider.c b/tests/binder/service_provider.c
index 2873af8..56d8a43 100644
--- a/tests/binder/service_provider.c
+++ b/tests/binder/service_provider.c
@@ -6,11 +6,14 @@ static int binder_parse(int fd, binder_uintptr_t ptr, binder_size_t size);
 static void usage(char *progname)
 {
 	fprintf(stderr,
-		"usage:  %s [-e expected_ctx] [-f file] [-n] [-v]\n"
+		"usage:  %s -e expected_ctx] [-f file] [-n] [-m|-p|-t] [-v]\n"
 		"Where:\n\t"
 		"-e  Expected security context.\n\t"
 		"-f  Write a line to the file when listening starts.\n\t"
 		"-n  Use the /dev/binderfs name service.\n\t"
+		"-m  Use BPF map fd for transfer.\n\t"
+		"-p  Use BPF prog fd for transfer.\n\t"
+		"-t  Test if BPF enabled.\n\t"
 		"-v  Print context and command information.\n\t"
 		"\nNote: Ensure this boolean command is run when "
 		"testing after a reboot:\n\t"
@@ -34,7 +37,7 @@ static void request_service_provider_fd(int fd,
 	}
 
 	if (verbose)
-		printf("Service Provider sending BC_REPLY with its FD\n");
+		printf("Service Provider sending BC_REPLY with an FD\n");
 
 	memset(writebuf, 0, sizeof(writebuf));
 	memset(&bwr, 0, sizeof(bwr));
@@ -56,17 +59,47 @@ static void request_service_provider_fd(int fd,
 	obj.pad_flags = 0x7f | FLAT_BINDER_FLAG_ACCEPTS_FDS;
 #endif
 	obj.cookie = txn->cookie;
-	/* The Service Providers binder fd is used for testing as it allows
+
+	/*
+	 * The Service Providers binder fd is used for testing as it allows
 	 * policy to set whether the Service Provider and Client can be
 	 * allowed access (fd use) or not.
 	 * This also allows a check for the impersonate permission later as
 	 * the Client will use the Service Provider fd to send a transaction.
+	 *
+	 * If a BPF fd is required, it is generated, however it cannot be
+	 * used to check the impersonate permission.
 	 */
-	obj.fd = fd;
+	switch (fd_type) {
+	case BINDER_FD:
+		obj.fd = fd;
+		break;
+#if HAVE_BPF
+	case BPF_MAP_FD:
+		obj.fd = create_bpf_map();
+		if (obj.fd < 0)
+			exit(70);
+		break;
+	case BPF_PROG_FD:
+		obj.fd = create_bpf_prog();
+		if (obj.fd < 0)
+			exit(71);
+		break;
+#else
+	case BPF_MAP_FD:
+	case BPF_PROG_FD:
+		fprintf(stderr, "BPF not supported - Service Provider\n");
+		exit(72);
+		break;
+#endif
+	default:
+		fprintf(stderr, "Invalid fd_type: %d\n", fd_type);
+		exit(73);
+	}
 
 	if (verbose)
-		printf("Service Provider handle: %d and its FD: %d\n",
-		       txn->target.handle, fd);
+		printf("Service Provider handle: %d and %s FD: %d\n",
+		       txn->target.handle, fd_type_str, obj.fd);
 
 	txn->data_size = sizeof(obj);
 	txn->data.ptr.buffer = (binder_uintptr_t)&obj;
@@ -81,7 +114,7 @@ static void request_service_provider_fd(int fd,
 		fprintf(stderr,
 			"Service Provider ioctl BINDER_WRITE_READ error: %s\n",
 			strerror(errno));
-		exit(70);
+		exit(74);
 	}
 }
 
@@ -119,7 +152,7 @@ static int binder_parse(int fd, binder_uintptr_t ptr, binder_size_t size)
 				print_trans_data(txn);
 			}
 
-			if (txn->code == TEST_SERVICE_SEND_CLIENT_SP_FD)
+			if (txn->code == TEST_SERVICE_SEND_FD)
 				request_service_provider_fd(fd, txn);
 
 			ptr += sizeof(*txn);
@@ -148,8 +181,7 @@ static int binder_parse(int fd, binder_uintptr_t ptr, binder_size_t size)
 				}
 			}
 
-			if (txn_ctx->transaction_data.code ==
-			    TEST_SERVICE_SEND_CLIENT_SP_FD)
+			if (txn_ctx->transaction_data.code == TEST_SERVICE_SEND_FD)
 				request_service_provider_fd(fd,
 							    &txn_ctx->transaction_data);
 
@@ -209,8 +241,10 @@ int main(int argc, char **argv)
 	unsigned int readbuf[32];
 
 	expected_ctx = NULL;
+	fd_type = BINDER_FD;
+	fd_type_str = "SP";
 
-	while ((opt = getopt(argc, argv, "e:f:nv")) != -1) {
+	while ((opt = getopt(argc, argv, "e:f:nvmpt")) != -1) {
 		switch (opt) {
 		case 'e':
 			expected_ctx = optarg;
@@ -224,11 +258,37 @@ int main(int argc, char **argv)
 		case 'v':
 			verbose = true;
 			break;
+		case 'm':
+			fd_type = BPF_MAP_FD;
+			fd_type_str = "BPF map";
+			break;
+		case 'p':
+			fd_type = BPF_PROG_FD;
+			fd_type_str = "BPF prog";
+			break;
+		case 't':
+			fd_type = BPF_TEST;
+			break;
 		default:
 			usage(argv[0]);
 		}
 	}
 
+
+#if HAVE_BPF
+	if (fd_type == BPF_TEST)
+		exit(0);
+
+	/* If BPF enabed, then need to set limits */
+	if (fd_type == BPF_MAP_FD || fd_type == BPF_PROG_FD)
+		bpf_setrlimit();
+#else
+	if (fd_type == BPF_TEST) {
+		fprintf(stderr, "BPF not supported\n");
+		exit(-1);
+	}
+#endif
+
 	/* Get our context and pid */
 	result = getcon(&context);
 	if (result < 0) {
@@ -267,19 +327,6 @@ int main(int argc, char **argv)
 		exit(63);
 	}
 
-	if (flag_file) {
-		flag_fd = fopen(flag_file, "w");
-		if (!flag_fd) {
-			fprintf(stderr,
-				"Service Provider failed to open %s: %s\n",
-				flag_file, strerror(errno));
-			result = 64;
-			goto brexit;
-		}
-		fprintf(flag_fd, "listening\n");
-		fclose(flag_fd);
-	}
-
 	memset(&writebuf, 0, sizeof(writebuf));
 	memset(&obj, 0, sizeof(obj));
 	memset(readbuf, 0, sizeof(readbuf));
@@ -322,7 +369,7 @@ int main(int argc, char **argv)
 		fprintf(stderr,
 			"Service Provider ioctl BINDER_WRITE_READ error: %s\n",
 			strerror(errno));
-		result = 65;
+		result = 64;
 		goto brexit;
 	}
 
@@ -338,7 +385,7 @@ int main(int argc, char **argv)
 	    cmd == BR_DEAD_BINDER) {
 		fprintf(stderr, "Service Provider %s() failing command %s, exiting.\n",
 			__func__, cmd_name(cmd));
-		result = 66;
+		result = 65;
 		goto brexit;
 	}
 
@@ -358,10 +405,27 @@ int main(int argc, char **argv)
 		fprintf(stderr,
 			"Service Provider ioctl BINDER_WRITE_READ error: %s\n",
 			strerror(errno));
-		result = 67;
+		result = 66;
 		goto brexit;
 	}
 
+	/*
+	 * Ensure the Manager and Service Provider have completed the
+	 * TEST_SERVICE_ADD sequence before the Client is allowed to start.
+	 */
+	if (flag_file) {
+		flag_fd = fopen(flag_file, "w");
+		if (!flag_fd) {
+			fprintf(stderr,
+				"Service Provider failed to open %s: %s\n",
+				flag_file, strerror(errno));
+			result = 67;
+			goto brexit;
+		}
+		fprintf(flag_fd, "listening\n");
+		fclose(flag_fd);
+	}
+
 	while (true) {
 		memset(readbuf, 0, sizeof(readbuf));
 		bwr.read_size = sizeof(readbuf);
diff --git a/tests/bpf/Makefile b/tests/bpf/Makefile
index 3513179..6fb230d 100644
--- a/tests/bpf/Makefile
+++ b/tests/bpf/Makefile
@@ -5,7 +5,7 @@ LDLIBS += -lselinux -lbpf
 # export so that BPF_ENABLED entries get built correctly on local build
 export CFLAGS += -DHAVE_BPF
 
-BPF_ENABLED = ../fdreceive
+BPF_ENABLED = ../fdreceive ../binder
 
 all: $(TARGETS)
 	@set -e; for i in $(BPF_ENABLED); do $(MAKE) -C $$i all ; done
diff --git a/tests/bpf/test b/tests/bpf/test
index 36f1f32..e284c7f 100755
--- a/tests/bpf/test
+++ b/tests/bpf/test
@@ -4,10 +4,12 @@ use Test::More;
 BEGIN {
     $basedir = $0;
     $basedir =~ s|(.*)/[^/]*|$1|;
-    $fdr_basedir = "$basedir/../fdreceive/";
+    $fdr_basedir    = "$basedir/../fdreceive/";
+    $binder_basedir = "$basedir/../binder/";
 
     $test_count     = 7;
     $test_fdreceive = 0;
+    $test_binder    = 0;
 
     # allow info to be shown during tests
     $v = $ARGV[0];
@@ -28,6 +30,17 @@ BEGIN {
         $test_count += 4;
     }
 
+    # Test if Binder is supported and BPF enabled
+    $result = system("$binder_basedir/check_binder $v 2>/dev/null");
+
+    if ( $result >> 8 eq 0 ) {
+        $result = system("$binder_basedir/service_provider -t 2>/dev/null");
+        if ( $result >> 8 eq 0 ) {
+            $test_binder = 1;
+            $test_count += 4;
+        }
+    }
+
     plan tests => $test_count;
 }
 
@@ -114,4 +127,73 @@ if ($test_fdreceive) {
     system "rm -rf $basedir/test_sock $basedir/flag";
 }
 
+#
+################ BPF Tests for binder #######################
+#
+sub service_start {
+    my ( $service, $runcon_args, $args ) = @_;
+    my $pid;
+    my $flag = $service . "_flag";
+
+    system("mkfifo $basedir/$flag");
+
+    if ( ( $pid = fork() ) == 0 ) {
+        exec
+"runcon $runcon_args $binder_basedir/$service -f $basedir/$flag $args";
+    }
+
+    # Wait for it to initialize.
+    system("read -t 5 <>$basedir/$flag");
+    return $pid;
+}
+
+sub service_end {
+    my ( $service, $pid ) = @_;
+    my $flag = $service . "_flag";
+
+    kill KILL, $pid;
+    waitpid $pid, 0;
+    system("rm -f $basedir/$flag");
+}
+
+if ($test_binder) {
+    ### Test BPF map fd on transfer ##################
+    $sm_pid = service_start( "manager", "-t test_binder_bpf_mgr_t", "$v" );
+    $sp_pid =
+      service_start( "service_provider", "-t test_binder_bpf_provider_t",
+        "-m $v" );
+
+    # Verify that the BPF map fd can be transferred.
+    $result =
+      system
+      "runcon -t test_binder_bpf_client_t $binder_basedir/client $v -m -r 1";
+    ok( $result eq 0 );
+
+    # Verify BPF no map perms.
+    $result = system
+"runcon -t test_binder_client_no_bpf_perm_t $binder_basedir/client $v -m -r 2 2>&1";
+    ok( $result >> 8 eq 141 );
+
+    ### Test BPF prog fd on transfer ##################
+    service_end( "service_provider", $sp_pid );
+    $sp_pid =
+      service_start( "service_provider", "-t test_binder_bpf_provider_t",
+        "-p $v" );
+
+    # Verify that the BPF prog fd can be transferred.
+    $result =
+      system
+      "runcon -t test_binder_bpf_client_t $binder_basedir/client $v -p -r 1";
+    ok( $result eq 0 );
+
+    # Verify BPF no prog perms.
+    $result = system
+"runcon -t test_binder_client_no_bpf_perm_t $binder_basedir/client $v -p -r 2 2>&1";
+    ok( $result >> 8 eq 141 );
+
+    # Kill the service provider & manager.
+    service_end( "service_provider", $sp_pid );
+    service_end( "manager",          $sm_pid );
+}
+
 exit;
-- 
2.21.0

