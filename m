Return-Path: <SRS0=gk/B=V5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5D9C19759
	for <selinux@archiver.kernel.org>; Thu,  1 Aug 2019 11:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3935C2087E
	for <selinux@archiver.kernel.org>; Thu,  1 Aug 2019 11:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="HPorGBbo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfHALMj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Aug 2019 07:12:39 -0400
Received: from mailomta25-sa.btinternet.com ([213.120.69.31]:34075 "EHLO
        sa-prd-fep-040.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725930AbfHALMj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Aug 2019 07:12:39 -0400
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-040.btinternet.com with ESMTP
          id <20190801111236.ESWL10898.sa-prd-fep-040.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Thu, 1 Aug 2019 12:12:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1564657956; 
        bh=EXUM03u+lBJwuDYmLDn1NrdES2+kHYx9gG0Og8CM7og=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=HPorGBbonQwDNI/EeGLck4qRN2xoux9W+NKu34rL2oKkAPNQeO2WzACurWrDYpaG12JApCVsGZ4PGBtDKb7vpouupcpKTifkl7mpaPT9ZGPxMJA9MB4Cfgnb/6tNUqi0n+NU71dV/zbiUFXN2oJZhGwBJKVQT0yceoGEzwzJkQGYKEN+VgIsfW+DGxjPTyDHkpRHGpbSSpqeEH9q/wQtg3trAsqR9yNuavVho8LGqZeFmp0RhiQg7T04T5VSNIxQ1Mv8Wl6F2549qqMysthy2UY+JZl2lReXfJ9clmSoCQmQTY600k0x8GQuDzexbFKbXitVu2lV6eNdUxQB8JLZBw==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [31.49.60.13]
X-OWM-Source-IP: 31.49.60.13 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddrleejgdefiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeefuddrgeelrdeitddrudefnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepfedurdegledriedtrddufedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.49.60.13) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.335.01) (authenticated as richard_c_haines@btinternet.com)
        id 5D3F935D0045CDF1; Thu, 1 Aug 2019 12:12:36 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org, paul@paul-moore.com
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V2 1/2] selinux-testsuite: Add BPF tests
Date:   Thu,  1 Aug 2019 12:12:32 +0100
Message-Id: <20190801111232.5589-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This adds basic BPF tests for map and prog functions.

The check-syntax script has been modified to exclude files listed
in tools/chk_c_exclude. This is because of macros in bpf_common.c
that get horribly reformatted by check-syntax.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
V2 Change - Split BPF code into bpf_common.c for others to use.

 README.md              |  4 +-
 defconfig              |  5 +++
 policy/Makefile        |  4 ++
 policy/test_bpf.te     | 77 ++++++++++++++++++++++++++++++++
 tests/Makefile         |  4 ++
 tests/bpf/.gitignore   |  2 +
 tests/bpf/Makefile     | 12 +++++
 tests/bpf/bpf_common.c | 99 ++++++++++++++++++++++++++++++++++++++++++
 tests/bpf/bpf_test.c   | 83 +++++++++++++++++++++++++++++++++++
 tests/bpf/test         | 57 ++++++++++++++++++++++++
 tools/check-syntax     |  2 +-
 tools/chk_c_exclude    |  1 +
 12 files changed, 348 insertions(+), 2 deletions(-)
 create mode 100644 policy/test_bpf.te
 create mode 100644 tests/bpf/.gitignore
 create mode 100644 tests/bpf/Makefile
 create mode 100644 tests/bpf/bpf_common.c
 create mode 100644 tests/bpf/bpf_test.c
 create mode 100755 tests/bpf/test
 create mode 100644 tools/chk_c_exclude

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
index d7f0ea5..96f6443 100644
--- a/defconfig
+++ b/defconfig
@@ -62,3 +62,8 @@ CONFIG_ANDROID_BINDER_IPC=y
 # This will configure the Dynamically Allocated Binder Devices added
 # to 5.0+ kernels:
 CONFIG_ANDROID_BINDERFS=y
+
+# Test BPF + check in selinux_file_receive and selinux_binder_transfer_files.
+# They are not required for SELinux operation itself.
+CONFIG_BP=y
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
index 0000000..7b212e7
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
+allow test_bpf_t self:process setrlimit;
+allow test_bpf_t self:capability { sys_resource sys_admin };
+allow test_bpf_t self:bpf { map_create map_read map_write prog_load prog_run };
+
+############################## Deny map_create #############################
+type test_bpf_deny_map_create_t;
+domain_type(test_bpf_deny_map_create_t)
+unconfined_runs_test(test_bpf_deny_map_create_t)
+typeattribute test_bpf_deny_map_create_t testdomain;
+typeattribute test_bpf_deny_map_create_t bpfdomain;
+
+allow test_bpf_deny_map_create_t self:process setrlimit;
+allow test_bpf_deny_map_create_t self:capability { sys_resource sys_admin };
+allow test_bpf_deny_map_create_t self:bpf { map_read map_write prog_load prog_run };
+
+############################## Deny map_read ##############################
+type test_bpf_deny_map_read_t;
+domain_type(test_bpf_deny_map_read_t)
+unconfined_runs_test(test_bpf_deny_map_read_t)
+typeattribute test_bpf_deny_map_read_t testdomain;
+typeattribute test_bpf_deny_map_read_t bpfdomain;
+
+allow test_bpf_deny_map_read_t self:process setrlimit;
+allow test_bpf_deny_map_read_t self:capability { sys_resource sys_admin };
+allow test_bpf_deny_map_read_t self:bpf { map_create map_write prog_load prog_run };
+
+############################## Deny map_write ##############################
+type test_bpf_deny_map_write_t;
+domain_type(test_bpf_deny_map_write_t)
+unconfined_runs_test(test_bpf_deny_map_write_t)
+typeattribute test_bpf_deny_map_write_t testdomain;
+typeattribute test_bpf_deny_map_write_t bpfdomain;
+
+allow test_bpf_deny_map_write_t self:process setrlimit;
+allow test_bpf_deny_map_write_t self:capability { sys_resource sys_admin };
+allow test_bpf_deny_map_write_t self:bpf { map_create map_read prog_load prog_run };
+
+############################## Deny prog_load ##############################
+type test_bpf_deny_prog_load_t;
+domain_type(test_bpf_deny_prog_load_t)
+unconfined_runs_test(test_bpf_deny_prog_load_t)
+typeattribute test_bpf_deny_prog_load_t testdomain;
+typeattribute test_bpf_deny_prog_load_t bpfdomain;
+
+allow test_bpf_deny_prog_load_t self:process setrlimit;
+allow test_bpf_deny_prog_load_t self:capability { sys_resource sys_admin };
+allow test_bpf_deny_prog_load_t self:bpf { map_create map_read map_write prog_run };
+
+############################## Deny prog_run ###############################
+type test_bpf_deny_prog_run_t;
+domain_type(test_bpf_deny_prog_run_t)
+unconfined_runs_test(test_bpf_deny_prog_run_t)
+typeattribute test_bpf_deny_prog_run_t testdomain;
+typeattribute test_bpf_deny_prog_run_t bpfdomain;
+
+allow test_bpf_deny_prog_run_t self:process setrlimit;
+allow test_bpf_deny_prog_run_t self:capability { sys_resource sys_admin };
+allow test_bpf_deny_prog_run_t self:bpf { map_create map_read map_write prog_load };
+
+#
+############ Allow these domains to be entered from sysadm domain ############
+#
+miscfiles_domain_entry_test_files(bpfdomain)
+userdom_sysadm_entry_spec_domtrans_to(bpfdomain)
diff --git a/tests/Makefile b/tests/Makefile
index 63aa325..2717452 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -42,6 +42,10 @@ ifeq ($(shell grep -q binder $(POLDEV)/include/support/all_perms.spt && test -e
 SUBDIRS += binder
 endif
 
+ifeq ($(shell grep -q bpf $(POLDEV)/include/support/all_perms.spt && test -e $(INCLUDEDIR)/bpf/bpf.h && echo true),true)
+SUBDIRS += bpf
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
index 0000000..78ae9db
--- /dev/null
+++ b/tests/bpf/Makefile
@@ -0,0 +1,12 @@
+TARGETS = bpf_test
+DEPS = bpf_common.c
+
+LDLIBS += -lselinux -lbpf
+CFLAGS += -DHAVE_BPF
+
+all: $(TARGETS)
+
+clean:
+	rm -f $(TARGETS)
+
+$(TARGETS): $(DEPS)
diff --git a/tests/bpf/bpf_common.c b/tests/bpf/bpf_common.c
new file mode 100644
index 0000000..c20da61
--- /dev/null
+++ b/tests/bpf/bpf_common.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <errno.h>
+
+#if HAVE_BPF /* Start HAVE_BPF */
+#include <bpf/bpf.h>
+#include <linux/bpf.h>
+#include <sys/resource.h>
+
+/* edited eBPF instruction library */
+/* Short form of mov, dst_reg = imm32 */
+#define BPF_MOV64_IMM(DST, IMM)					\
+	((struct bpf_insn) {					\
+		.code  = BPF_ALU64 | BPF_MOV | BPF_K,		\
+		.dst_reg = DST,					\
+		.src_reg = 0,					\
+		.off   = 0,					\
+		.imm   = IMM })
+
+/* Program exit */
+#define BPF_EXIT_INSN()						\
+	((struct bpf_insn) {					\
+		.code  = BPF_JMP | BPF_EXIT,			\
+		.dst_reg = 0,					\
+		.src_reg = 0,					\
+		.off   = 0,					\
+		.imm   = 0 })
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
+	if (prog_fd < 0) {
+		fprintf(stderr, "Failed to load BPF prog: %s\n",
+			strerror(errno));
+		return -1;
+	}
+
+	return prog_fd;
+}
+
+void bpf_setrlimit(void)
+{
+	int result;
+	struct rlimit r = { RLIM_INFINITY, RLIM_INFINITY };
+
+	result = setrlimit(RLIMIT_MEMLOCK, &r);
+	if (result < 0) {
+		fprintf(stderr, "Failed to set resource limit: %s\n",
+			strerror(errno));
+		exit(-1);
+	}
+}
+
+#else
+int create_bpf_map(void)
+{
+	fprintf(stderr, "BPF map not supported\n");
+	return -1;
+}
+
+int create_bpf_prog(void)
+{
+	fprintf(stderr, "BPF prog not supported\n");
+	return -1;
+}
+
+void bpf_setrlimit(void)
+{
+}
+#endif /* End HAVE_BPF */
diff --git a/tests/bpf/bpf_test.c b/tests/bpf/bpf_test.c
new file mode 100644
index 0000000..747552c
--- /dev/null
+++ b/tests/bpf/bpf_test.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <selinux/selinux.h>
+
+int create_bpf_map(void);
+int create_bpf_prog(void);
+void bpf_setrlimit(void);
+
+static void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s [-m|-p] [-v]\n"
+		"Where:\n\t"
+		"-m    Create a BPF map fd\n\t"
+		"-p    Create a BPF prog fd\n\t"
+		"-v Print information.\n", progname);
+	exit(-1);
+}
+
+int main(int argc, char *argv[])
+{
+	int opt, result, fd, bpf_fd_type = 0;
+	bool verbose = false;
+	char *context;
+
+	while ((opt = getopt(argc, argv, "mpv")) != -1) {
+		switch (opt) {
+		case 'm':
+			bpf_fd_type = 1;
+			break;
+		case 'p':
+			bpf_fd_type = 2;
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
+	/* If BPF enabed, then need to set limits */
+	bpf_setrlimit();
+
+	switch (bpf_fd_type) {
+	case 1:
+		if (verbose)
+			printf("Creating BPF map\n");
+
+		fd = create_bpf_map();
+		break;
+	case 2:
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
+		return bpf_fd_type;
+
+	return 0;
+}
diff --git a/tests/bpf/test b/tests/bpf/test
new file mode 100755
index 0000000..0223a4c
--- /dev/null
+++ b/tests/bpf/test
@@ -0,0 +1,57 @@
+#!/usr/bin/perl
+# SPDX-License-Identifier: GPL-2.0
+
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
+    plan tests => 7;
+}
+
+# BPF map
+$result = system "runcon -t test_bpf_t $basedir/bpf_test -m $v";
+ok( $result eq 0 );
+
+# BPF prog
+$result = system "runcon -t test_bpf_t $basedir/bpf_test -p $v";
+ok( $result eq 0 );
+
+# Deny map_create permission
+$result =
+  system "runcon -t test_bpf_deny_map_create_t $basedir/bpf_test -m $v 2>&1";
+ok( $result >> 8 eq 1 );
+
+# Deny map_read permission
+$result =
+  system "runcon -t test_bpf_deny_map_read_t $basedir/bpf_test -m $v 2>&1";
+ok( $result >> 8 eq 1 );
+
+# Deny map_write permission
+$result =
+  system "runcon -t test_bpf_deny_map_write_t $basedir/bpf_test -m $v 2>&1";
+ok( $result >> 8 eq 1 );
+
+# Deny prog_load permission
+$result =
+  system "runcon -t test_bpf_deny_prog_load_t $basedir/bpf_test -p $v 2>&1";
+ok( $result >> 8 eq 2 );
+
+# Deny prog_run permission
+$result =
+  system "runcon -t test_bpf_deny_prog_run_t $basedir/bpf_test -p $v 2>&1";
+ok( $result >> 8 eq 2 );
+
+exit;
diff --git a/tools/check-syntax b/tools/check-syntax
index 7f9768d..5b7c211 100755
--- a/tools/check-syntax
+++ b/tools/check-syntax
@@ -11,7 +11,7 @@
 #
 
 CHK_C_LIST="$(find tests/ -name "*.c") $(find tests/ -name "*.h")"
-CHK_C_EXCLUDE=""
+CHK_C_EXCLUDE="$(cat tools/chk_c_exclude)"
 
 CHK_PERL_LIST="$(find tests/ -name "*.pl") $(find tests/ -name "test")"
 CHK_PERL_EXCLUDE=""
diff --git a/tools/chk_c_exclude b/tools/chk_c_exclude
new file mode 100644
index 0000000..20facbf
--- /dev/null
+++ b/tools/chk_c_exclude
@@ -0,0 +1 @@
+tests/bpf/bpf_common.c
-- 
2.21.0

