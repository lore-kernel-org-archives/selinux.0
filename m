Return-Path: <SRS0=jdxV=XO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80766C49ED7
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 17:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50EA121A4C
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 17:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="t0qJKLMQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391030AbfISRrF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Sep 2019 13:47:05 -0400
Received: from mailomta19-sa.btinternet.com ([213.120.69.25]:32483 "EHLO
        sa-prd-fep-044.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391010AbfISRrE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Sep 2019 13:47:04 -0400
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-044.btinternet.com with ESMTP
          id <20190919174700.CRWZ25769.sa-prd-fep-044.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Thu, 19 Sep 2019 18:47:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1568915220; 
        bh=/cwZiSW/vwy0L+yxexw1k5S+hkkFy6AmzbF+rU6jdoM=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=t0qJKLMQ9+O0t5zz68XzPz6TMYjpitgyZf7PYPS/VolUx+HfLbcIi3KyuTmyWHYofM4I/PKH1/av6eHOTv1WjCfw29TfY+wy+s5SWeLMTwWFfWgJjGny4xecuvyTPFtYLZvRpsircc1keMVwvbvjbMtEMBoppzGyhzHGHd/VfDyttFOBO2F8//wOebe2FzdRexEYKjsGYI7BkRdkhOoK2Nag3Muo7/m2hySLC9UNGZwkT3aZFNHyRioPr7DPFt/WViIjqYAiI2ixa0d6ynVVFZV+aYFbLchYZ1pJcGvz3876McVMBdUPhtG9pa92w7K78o5KElgOmQQP98gXdKq1dg==
Authentication-Results: btinternet.com; none
X-Originating-IP: [31.49.59.204]
X-OWM-Source-IP: 31.49.59.204 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedufedrvddtgdduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepfedurdegledrheelrddvtdegnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepfedurdegledrheelrddvtdegpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsughssehthigthhhordhnshgrrdhgohhvqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.49.59.204) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5D8362CD000C7E77; Thu, 19 Sep 2019 18:47:00 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org, paul@paul-moore.com, sds@tycho.nsa.gov
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V5 1/3] selinux-testsuite: Add BPF tests
Date:   Thu, 19 Sep 2019 18:46:53 +0100
Message-Id: <20190919174655.17348-2-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190919174655.17348-1-richard_c_haines@btinternet.com>
References: <20190919174655.17348-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This adds basic BPF tests for map and prog functions.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 README.md              |  4 ++-
 defconfig              |  5 +++
 policy/Makefile        |  4 +++
 policy/test_bpf.te     | 77 ++++++++++++++++++++++++++++++++++++++++++
 tests/Makefile         |  7 ++++
 tests/bpf/.gitignore   |  2 ++
 tests/bpf/Makefile     | 10 ++++++
 tests/bpf/bpf_common.c | 69 +++++++++++++++++++++++++++++++++++++
 tests/bpf/bpf_common.h | 34 +++++++++++++++++++
 tests/bpf/bpf_test.c   | 77 ++++++++++++++++++++++++++++++++++++++++++
 tests/bpf/test         | 64 +++++++++++++++++++++++++++++++++++
 11 files changed, 352 insertions(+), 1 deletion(-)
 create mode 100644 policy/test_bpf.te
 create mode 100644 tests/bpf/.gitignore
 create mode 100644 tests/bpf/Makefile
 create mode 100644 tests/bpf/bpf_common.c
 create mode 100644 tests/bpf/bpf_common.h
 create mode 100644 tests/bpf/bpf_test.c
 create mode 100755 tests/bpf/test

diff --git a/README.md b/README.md
index 26784f8..1396c8e 100644
--- a/README.md
+++ b/README.md
@@ -51,6 +51,7 @@ similar dependencies):
 * iptables _(to load the `iptables SECMARK` rules during `inet_socket` tests)_
 * lksctp-tools-devel _(to build the SCTP test programs)_
 * attr _(tools used by the overlayfs tests)_
+* libbpf-devel _(tools used by the bpf tests)_
 
 On a modern Fedora system you can install these dependencies with the
 following command:
@@ -65,7 +66,8 @@ following command:
 		netlabel_tools \
 		iptables \
 		lksctp-tools-devel \
-		attr
+		attr \
+		libbpf-devel
 
 The testsuite requires a pre-existing base policy configuration of SELinux,
 using either the old example policy or the reference policy as the baseline.
diff --git a/defconfig b/defconfig
index d7f0ea5..cb57f22 100644
--- a/defconfig
+++ b/defconfig
@@ -62,3 +62,8 @@ CONFIG_ANDROID_BINDER_IPC=y
 # This will configure the Dynamically Allocated Binder Devices added
 # to 5.0+ kernels:
 CONFIG_ANDROID_BINDERFS=y
+
+# Test BPF + check in selinux_file_receive and selinux_binder_transfer_files.
+# They are not required for SELinux operation itself.
+CONFIG_BPF=y
+CONFIG_BPF_SYSCALL=y
diff --git a/policy/Makefile b/policy/Makefile
index 305b572..16a4469 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -71,6 +71,10 @@ ifeq ($(shell grep -q corenet_sctp_bind_all_nodes $(POLDEV)/include/kernel/coren
 TARGETS += test_sctp.te
 endif
 
+ifeq ($(shell grep -q bpf $(POLDEV)/include/support/all_perms.spt && echo true),true)
+TARGETS += test_bpf.te
+endif
+
 ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
 TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te, $(TARGETS))
 endif
diff --git a/policy/test_bpf.te b/policy/test_bpf.te
new file mode 100644
index 0000000..c9c0bc5
--- /dev/null
+++ b/policy/test_bpf.te
@@ -0,0 +1,77 @@
+#
+################# BPF selinux-testsuite policy module ######################
+#
+
+attribute bpfdomain;
+
+################################### Main ###################################
+type test_bpf_t;
+domain_type(test_bpf_t)
+unconfined_runs_test(test_bpf_t)
+typeattribute test_bpf_t testdomain;
+typeattribute test_bpf_t bpfdomain;
+
+allow test_bpf_t self:process { setrlimit };
+allow test_bpf_t self:capability { sys_resource };
+allow test_bpf_t self:bpf { map_create map_read map_write prog_load prog_run };
+
+############################## Deny map_create #############################
+type test_bpf_deny_map_create_t;
+domain_type(test_bpf_deny_map_create_t)
+unconfined_runs_test(test_bpf_deny_map_create_t)
+typeattribute test_bpf_deny_map_create_t testdomain;
+typeattribute test_bpf_deny_map_create_t bpfdomain;
+
+allow test_bpf_deny_map_create_t self:process { setrlimit };
+allow test_bpf_deny_map_create_t self:capability { sys_resource };
+allow test_bpf_deny_map_create_t self:bpf { map_read map_write prog_load prog_run };
+
+############################## Deny map_read ##############################
+type test_bpf_deny_map_read_t;
+domain_type(test_bpf_deny_map_read_t)
+unconfined_runs_test(test_bpf_deny_map_read_t)
+typeattribute test_bpf_deny_map_read_t testdomain;
+typeattribute test_bpf_deny_map_read_t bpfdomain;
+
+allow test_bpf_deny_map_read_t self:process { setrlimit };
+allow test_bpf_deny_map_read_t self:capability { sys_resource };
+allow test_bpf_deny_map_read_t self:bpf { map_create map_write prog_load prog_run };
+
+############################## Deny map_write ##############################
+type test_bpf_deny_map_write_t;
+domain_type(test_bpf_deny_map_write_t)
+unconfined_runs_test(test_bpf_deny_map_write_t)
+typeattribute test_bpf_deny_map_write_t testdomain;
+typeattribute test_bpf_deny_map_write_t bpfdomain;
+
+allow test_bpf_deny_map_write_t self:process { setrlimit };
+allow test_bpf_deny_map_write_t self:capability { sys_resource };
+allow test_bpf_deny_map_write_t self:bpf { map_create map_read prog_load prog_run };
+
+############################## Deny prog_load ##############################
+type test_bpf_deny_prog_load_t;
+domain_type(test_bpf_deny_prog_load_t)
+unconfined_runs_test(test_bpf_deny_prog_load_t)
+typeattribute test_bpf_deny_prog_load_t testdomain;
+typeattribute test_bpf_deny_prog_load_t bpfdomain;
+
+allow test_bpf_deny_prog_load_t self:process { setrlimit };
+allow test_bpf_deny_prog_load_t self:capability { sys_resource };
+allow test_bpf_deny_prog_load_t self:bpf { map_create map_read map_write prog_run };
+
+############################## Deny prog_run ###############################
+type test_bpf_deny_prog_run_t;
+domain_type(test_bpf_deny_prog_run_t)
+unconfined_runs_test(test_bpf_deny_prog_run_t)
+typeattribute test_bpf_deny_prog_run_t testdomain;
+typeattribute test_bpf_deny_prog_run_t bpfdomain;
+
+allow test_bpf_deny_prog_run_t self:process { setrlimit };
+allow test_bpf_deny_prog_run_t self:capability { sys_resource };
+allow test_bpf_deny_prog_run_t self:bpf { map_create map_read map_write prog_load };
+
+#
+############ Allow these domains to be entered from sysadm domain ############
+#
+miscfiles_domain_entry_test_files(bpfdomain)
+userdom_sysadm_entry_spec_domtrans_to(bpfdomain)
diff --git a/tests/Makefile b/tests/Makefile
index 2984792..e5bdfff 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -41,6 +41,13 @@ ifeq ($(shell grep -q binder $(POLDEV)/include/support/all_perms.spt && test -e
 SUBDIRS += binder
 endif
 
+ifeq ($(shell grep -q bpf $(POLDEV)/include/support/all_perms.spt && echo true),true)
+ifneq ($(shell ./kvercmp $$(uname -r) 4.15),-1)
+SUBDIRS += bpf
+export CFLAGS += -DHAVE_BPF
+endif
+endif
+
 ifeq ($(shell grep "^SELINUX_INFINIBAND_ENDPORT_TEST=" infiniband_endport/ibendport_test.conf | cut -d'=' -f 2),1)
 SUBDIRS += infiniband_endport
 endif
diff --git a/tests/bpf/.gitignore b/tests/bpf/.gitignore
new file mode 100644
index 0000000..1919ff8
--- /dev/null
+++ b/tests/bpf/.gitignore
@@ -0,0 +1,2 @@
+bpf_test
+bpf_common
diff --git a/tests/bpf/Makefile b/tests/bpf/Makefile
new file mode 100644
index 0000000..46817a5
--- /dev/null
+++ b/tests/bpf/Makefile
@@ -0,0 +1,10 @@
+TARGETS = bpf_test
+DEPS = bpf_common.c bpf_common.h
+LDLIBS += -lselinux -lbpf
+
+all: $(TARGETS)
+
+clean:
+	rm -f $(TARGETS)
+
+$(TARGETS): $(DEPS)
diff --git a/tests/bpf/bpf_common.c b/tests/bpf/bpf_common.c
new file mode 100644
index 0000000..681e2eb
--- /dev/null
+++ b/tests/bpf/bpf_common.c
@@ -0,0 +1,69 @@
+#include "bpf_common.h"
+
+int create_bpf_map(void)
+{
+	int map_fd, key;
+	long long value = 0;
+
+	map_fd = bpf_create_map(BPF_MAP_TYPE_ARRAY, sizeof(key),
+				sizeof(value), 256, 0);
+	if (map_fd < 0) {
+		fprintf(stderr, "Failed to create BPF map: %s\n",
+			strerror(errno));
+		return -1;
+	}
+
+	return map_fd;
+}
+
+int create_bpf_prog(void)
+{
+	int prog_fd;
+	size_t insns_cnt;
+
+	struct bpf_insn prog[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_EXIT_INSN(),
+	};
+	insns_cnt = sizeof(prog) / sizeof(struct bpf_insn);
+
+	prog_fd = bpf_load_program(BPF_PROG_TYPE_SOCKET_FILTER, prog,
+				   insns_cnt, "GPL", 0, NULL, 0);
+
+	if (prog_fd < 0) {
+		fprintf(stderr, "Failed to load BPF prog: %s\n",
+			strerror(errno));
+		return -1;
+	}
+
+	return prog_fd;
+}
+
+/*
+ * The default RLIMIT_MEMLOCK is normally 64K, however BPF map/prog requires
+ * more than this so double it unless RLIM_INFINITY is set.
+ */
+void bpf_setrlimit(void)
+{
+	int result;
+	struct rlimit r;
+
+	result = getrlimit(RLIMIT_MEMLOCK, &r);
+	if (result < 0) {
+		fprintf(stderr, "Failed to get resource limit: %s\n",
+			strerror(errno));
+		exit(-1);
+	}
+
+	if (r.rlim_cur != RLIM_INFINITY && r.rlim_cur <= (64 * 1024)) {
+		r.rlim_cur *= 2;
+		r.rlim_max *= 2;
+	}
+
+	result = setrlimit(RLIMIT_MEMLOCK, &r);
+	if (result < 0) {
+		fprintf(stderr, "Failed to set resource limit: %ld Err: %s\n",
+			r.rlim_cur, strerror(errno));
+		exit(-1);
+	}
+}
diff --git a/tests/bpf/bpf_common.h b/tests/bpf/bpf_common.h
new file mode 100644
index 0000000..44ac28f
--- /dev/null
+++ b/tests/bpf/bpf_common.h
@@ -0,0 +1,34 @@
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <selinux/selinux.h>
+#include <bpf/bpf.h>
+#include <linux/bpf.h>
+#include <sys/resource.h>
+
+extern int create_bpf_map(void);
+extern int create_bpf_prog(void);
+extern void bpf_setrlimit(void);
+
+/* edited eBPF instruction library */
+/* Short form of mov, dst_reg = imm32 */
+#define BPF_MOV64_IMM(DST, IMM)				\
+	((struct bpf_insn) {				\
+		.code  = BPF_ALU64 | BPF_MOV | BPF_K,	\
+			 .dst_reg = DST,				\
+				    .src_reg = 0,				\
+					       .off   = 0,				\
+							.imm   = IMM })
+
+/* Program exit */
+#define BPF_EXIT_INSN()				\
+	((struct bpf_insn) {			\
+		.code  = BPF_JMP | BPF_EXIT,	\
+			 .dst_reg = 0,			\
+				    .src_reg = 0,			\
+					       .off   = 0,			\
+							.imm   = 0 })
+
diff --git a/tests/bpf/bpf_test.c b/tests/bpf/bpf_test.c
new file mode 100644
index 0000000..3c6a29c
--- /dev/null
+++ b/tests/bpf/bpf_test.c
@@ -0,0 +1,77 @@
+#include "bpf_common.h"
+
+static void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s -m|-p [-v]\n"
+		"Where:\n\t"
+		"-m    Create BPF map fd\n\t"
+		"-p    Create BPF prog fd\n\t"
+		"-v Print information.\n", progname);
+	exit(-1);
+}
+
+int main(int argc, char *argv[])
+{
+	int opt, result, fd;
+	bool verbose = false;
+	char *context;
+
+	enum {
+		MAP_FD = 1,
+		PROG_FD
+	} bpf_fd_type;
+
+	while ((opt = getopt(argc, argv, "mpv")) != -1) {
+		switch (opt) {
+		case 'm':
+			bpf_fd_type = MAP_FD;
+			break;
+		case 'p':
+			bpf_fd_type = PROG_FD;
+			break;
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	result = getcon(&context);
+	if (result < 0) {
+		fprintf(stderr, "Failed to obtain SELinux context\n");
+		exit(-1);
+	}
+
+	if (verbose)
+		printf("Process context:\n\t%s\n", context);
+
+	free(context);
+
+	/* If BPF enabled, then need to set limits */
+	bpf_setrlimit();
+
+	switch (bpf_fd_type) {
+	case MAP_FD:
+		if (verbose)
+			printf("Creating BPF map\n");
+
+		fd = create_bpf_map();
+		break;
+	case PROG_FD:
+		if (verbose)
+			printf("Creating BPF prog\n");
+
+		fd = create_bpf_prog();
+		break;
+	default:
+		usage(argv[0]);
+	}
+
+	if (fd < 0)
+		return fd;
+
+	close(fd);
+	return 0;
+}
diff --git a/tests/bpf/test b/tests/bpf/test
new file mode 100755
index 0000000..ee00a19
--- /dev/null
+++ b/tests/bpf/test
@@ -0,0 +1,64 @@
+#!/usr/bin/perl
+use Test::More;
+
+BEGIN {
+    $basedir = $0;
+    $basedir =~ s|(.*)/[^/]*|$1|;
+
+    $test_count = 7;
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
+    plan tests => $test_count;
+}
+
+#
+# These tests are run with: kernel.unprivileged_bpf_disabled = FALSE
+#
+
+#
+################ Core BPF Tests #######################
+#
+# BPF map - BPF_MAP_TYPE_ARRAY
+$result = system "runcon -t test_bpf_t $basedir/bpf_test -m $v";
+ok( $result eq 0 );
+
+# BPF prog - BPF_PROG_TYPE_SOCKET_FILTER
+$result = system "runcon -t test_bpf_t $basedir/bpf_test -p $v";
+ok( $result eq 0 );
+
+# Deny map_create permission
+$result =
+  system "runcon -t test_bpf_deny_map_create_t $basedir/bpf_test -m $v 2>&1";
+ok($result);
+
+# Deny map_read permission
+$result =
+  system "runcon -t test_bpf_deny_map_read_t $basedir/bpf_test -m $v 2>&1";
+ok($result);
+
+# Deny map_write permission
+$result =
+  system "runcon -t test_bpf_deny_map_write_t $basedir/bpf_test -m $v 2>&1";
+ok($result);
+
+# Deny prog_load permission
+$result =
+  system "runcon -t test_bpf_deny_prog_load_t $basedir/bpf_test -p $v 2>&1";
+ok($result);
+
+# Deny prog_run permission
+$result =
+  system "runcon -t test_bpf_deny_prog_run_t $basedir/bpf_test -p $v 2>&1";
+ok($result);
+
+exit;
-- 
2.21.0

