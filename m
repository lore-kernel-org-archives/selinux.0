Return-Path: <SRS0=KxHl=TW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84494C072A4
	for <selinux@archiver.kernel.org>; Wed, 22 May 2019 06:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175802173E
	for <selinux@archiver.kernel.org>; Wed, 22 May 2019 06:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="Ovmcczfx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbfEVGPY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 May 2019 02:15:24 -0400
Received: from rgout0406.bt.lon5.cpcloud.co.uk ([65.20.0.219]:34515 "EHLO
        rgout04.bt.lon5.cpcloud.co.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725796AbfEVGPY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 May 2019 02:15:24 -0400
X-OWM-Source-IP: 86.147.201.202 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduuddrudduuddgleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepkeeirddugeejrddvtddurddvtddvnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugeejrddvtddurddvtddvpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehsughssehthigthhhordhnshgrrdhgohhvqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgepge
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduuddrudduuddguddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeekiedrudegjedrvddtuddrvddtvdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudegjedrvddtuddrvddtvddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduuddrudduuddguddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeekiedrudegjedrvddtuddrvddtvdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudegjedrvddtuddrvddtvddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedu
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduuddrudduuddguddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeekiedrudegjedrvddtuddrvddtvdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudegjedrvddtuddrvddtvddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
Received: from localhost.localdomain (86.147.201.202) by rgout04.bt.lon5.cpcloud.co.uk (9.0.019.26-1) (authenticated as richard_c_haines@btinternet.com)
        id 5C55FFA90A73DA7D; Wed, 22 May 2019 06:44:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btcpcloud; t=1558505724; 
        bh=CGww92QVyzGLp88T+AQ40SVk4KmYDXQNtxN5xv32/nw=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=OvmcczfxRG8toukEwceIMe0yA+TfbjAbxaZPq85h4kbL0wI0l9lP9+ez8A3InQqHNSUNY26Atv0n5lX5RLGaXsK2TFqJ/fR3SeGhqI8D/qikHW2JSCO6LU9x5lkoHI03njUrPUElt0YY4jPpvAllW1EhXlABfDd8Se6RLfMNL3s=
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     sds@tycho.nsa.gov, Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC V2 PATCH] selinux-testsuite: Add test for restorecon
Date:   Wed, 22 May 2019 06:44:13 +0100
Message-Id: <20190522054413.3698-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This will test the updated libselinux selinux_restorecon(3) using a
simple test version of "restorecon", or if the test is run locally,
a '-p' option can be used to supply the path of a full version of
restorecon(8) (see note in restorecon/test).

As the SELinux testsuite is primarily a set of regression tests for the
SELinux kernel, this change also adds support to include the testing of
core userspace services such as library functions or utilities. To
install and run these type of tests, the following must be run first:

	# export TEST_USERSPACE=y

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
V2 Changes:
Allow option to run other restorecon binaries.
Only run if userspace tests enabled.
Add tests for "Ignore the stem..." patch

 README.md                          |   7 ++
 policy/Makefile                    |   8 ++
 policy/test_restorecon.te          |  51 +++++++++
 tests/Makefile                     |   7 ++
 tests/restorecon/.gitignore        |   3 +
 tests/restorecon/Makefile          |   7 ++
 tests/restorecon/check_fs.c        |  69 ++++++++++++
 tests/restorecon/get_all_digests.c | 175 +++++++++++++++++++++++++++++
 tests/restorecon/restorecon.c      |  74 ++++++++++++
 tests/restorecon/test              | 147 ++++++++++++++++++++++++
 10 files changed, 548 insertions(+)
 create mode 100644 policy/test_restorecon.te
 create mode 100644 tests/restorecon/.gitignore
 create mode 100644 tests/restorecon/Makefile
 create mode 100644 tests/restorecon/check_fs.c
 create mode 100644 tests/restorecon/get_all_digests.c
 create mode 100644 tests/restorecon/restorecon.c
 create mode 100755 tests/restorecon/test

diff --git a/README.md b/README.md
index 26784f8..329a495 100644
--- a/README.md
+++ b/README.md
@@ -114,6 +114,13 @@ the tests:
 
 ## Running the Tests
 
+The SELinux testsuite is primarily a set of regression tests for the SELinux
+kernel, however it is possible to include the testing of core userspace
+services such as library functions or utilities. To install any relevant
+tests, the following must be run first:
+
+	# export TEST_USERSPACE=y
+
 Create a shell with the `unconfined_r` or `sysadm_r` role and the Linux
 superuser identity, e.g.:
 
diff --git a/policy/Makefile b/policy/Makefile
index 305b572..9c7d173 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -3,6 +3,7 @@ POLDEV ?= /usr/share/selinux/devel
 SEMODULE = /usr/sbin/semodule
 CHECKPOLICY = /usr/bin/checkpolicy
 CHECKMODULE = /usr/bin/checkmodule
+INCLUDEDIR ?= /usr/include
 
 DISTRO=$(shell ../tests/os_detect)
 RHEL_VERS=$(shell echo $(DISTRO) | sed 's/RHEL//')
@@ -79,6 +80,13 @@ ifeq (x$(DISTRO),$(filter x$(DISTRO), xRHEL6))
 TARGETS:=$(filter-out test_ibpkey.te, $(TARGETS))
 endif
 
+# Add any userspace test policy
+ifeq ($(TEST_USERSPACE),y)
+    ifeq ($(shell grep -q selabel_get_digests_all_partial_matches $(INCLUDEDIR)/selinux/label.h && echo true),true)
+        TARGETS += test_restorecon.te
+    endif
+endif
+
 ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5))
 	BUILD_TARGET := build_rhel
 	LOAD_TARGET := load_rhel
diff --git a/policy/test_restorecon.te b/policy/test_restorecon.te
new file mode 100644
index 0000000..e3ffae5
--- /dev/null
+++ b/policy/test_restorecon.te
@@ -0,0 +1,51 @@
+#################################
+#
+# Policy for testing restorecon
+#
+
+require {
+	attribute file_type;
+	type setfiles_exec_t;
+}
+
+attribute restorecon_domain;
+
+type test_restorecon_file_t;
+files_type(test_restorecon_file_t)
+type in_dir_t;
+files_type(in_dir_t)
+type out_dir_t;
+files_type(out_dir_t)
+type in_file_t;
+files_type(in_file_t)
+type out_file_t;
+files_type(out_file_t)
+
+# Domain for restorecon.
+type test_restorecon_t;
+files_type(test_restorecon_t)
+
+domain_type(test_restorecon_t)
+unconfined_runs_test(test_restorecon_t)
+typeattribute test_restorecon_t testdomain;
+typeattribute test_restorecon_t restorecon_domain;
+
+allow test_restorecon_t self:capability sys_admin;
+allow test_restorecon_t test_file_t:file relabelfrom;
+allow test_restorecon_t file_type:dir { relabel_dir_perms manage_dir_perms };
+allow test_restorecon_t file_type:file { rw_file_perms execute relabelto relabelfrom };
+allow_map(test_restorecon_t, file_type, file)
+corecmd_bin_entry_type(test_restorecon_t)
+
+# Allow these for statfs(2) if /tmp = TMPFS_MAGIC test
+allow test_restorecon_t tmpfs_t:filesystem getattr;
+allow test_restorecon_t user_tmp_t:sock_file getattr;
+# and this to add the root test directory
+allow test_restorecon_t fs_t:filesystem getattr;
+
+# Allow restorecon(8) to be used instead of the test program
+allow test_restorecon_t setfiles_exec_t:file entrypoint;
+
+# Allow all of these domains to be entered from sysadm domain
+miscfiles_domain_entry_test_files(restorecon_domain)
+userdom_sysadm_entry_spec_domtrans_to(restorecon_domain)
diff --git a/tests/Makefile b/tests/Makefile
index 63aa325..37ed6af 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -50,6 +50,13 @@ ifeq ($(shell grep "^SELINUX_INFINIBAND_PKEY_TEST=" infiniband_pkey/ibpkey_test.
 SUBDIRS += infiniband_pkey
 endif
 
+# Keep userspace tests last
+ifeq ($(TEST_USERSPACE),y)
+    ifeq ($(shell grep -q selabel_get_digests_all_partial_matches $(INCLUDEDIR)/selinux/label.h && echo true),true)
+        SUBDIRS += restorecon
+    endif
+endif
+
 ifeq ($(DISTRO),RHEL4)
     SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap nnp_nosuid overlay unix_socket, $(SUBDIRS))
 endif
diff --git a/tests/restorecon/.gitignore b/tests/restorecon/.gitignore
new file mode 100644
index 0000000..7a8717a
--- /dev/null
+++ b/tests/restorecon/.gitignore
@@ -0,0 +1,3 @@
+restorecon
+get_all_digests
+check_fs
diff --git a/tests/restorecon/Makefile b/tests/restorecon/Makefile
new file mode 100644
index 0000000..2ea2282
--- /dev/null
+++ b/tests/restorecon/Makefile
@@ -0,0 +1,7 @@
+TARGETS = restorecon get_all_digests check_fs
+LDLIBS += -lselinux
+
+all: $(TARGETS)
+
+clean:
+	rm -f $(TARGETS)
diff --git a/tests/restorecon/check_fs.c b/tests/restorecon/check_fs.c
new file mode 100644
index 0000000..5a3c7b1
--- /dev/null
+++ b/tests/restorecon/check_fs.c
@@ -0,0 +1,69 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <getopt.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <sys/statfs.h>
+#include <linux/magic.h>
+
+static void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s [-v] path\n"
+		"Where:\n\t"
+		"-v  Display filesystem f_type magic number.\n\t"
+		"path  Path to check fs type.\n\n"
+		"Returns 1=RAMFS_MAGIC, 2=TMPFS_MAGIC, 3=SYSFS_MAGIC\n", progname);
+	exit(-1);
+}
+
+int main(int argc, char **argv)
+{
+	int opt, rc;
+	bool verbose = false;
+	struct statfs sfsb;
+
+	while ((opt = getopt(argc, argv, "v")) > 0) {
+		switch (opt) {
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	if (optind >= argc) {
+		fprintf(stderr, "No pathname specified\n");
+		return -1;
+	}
+
+	rc = statfs(argv[optind], &sfsb);
+	if (rc < 0) {
+		fprintf(stderr, "Get filesystem statistics ERROR: %s\n",
+			strerror(errno));
+		return rc;
+	}
+
+	switch (sfsb.f_type) {
+	case RAMFS_MAGIC:
+		if (verbose)
+			printf("RAMFS_MAGIC\n");
+		return 1;
+	case TMPFS_MAGIC:
+		if (verbose)
+			printf("TMPFS_MAGIC\n");
+		return 2;
+	case SYSFS_MAGIC:
+		if (verbose)
+			printf("SYSFS_MAGIC\n");
+		return 3;
+	default:
+		if (verbose)
+			printf("sfsb.f_type: 0x%lx\n", sfsb.f_type);
+		return 0;
+	}
+
+	return rc;
+}
diff --git a/tests/restorecon/get_all_digests.c b/tests/restorecon/get_all_digests.c
new file mode 100644
index 0000000..4a4340f
--- /dev/null
+++ b/tests/restorecon/get_all_digests.c
@@ -0,0 +1,175 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <getopt.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <fts.h>
+#include <selinux/selinux.h>
+#include <selinux/label.h>
+
+#define RESTORECON_PARTIAL_MATCH_DIGEST  "security.sehash"
+
+static void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s [-vr] path\n\n"
+		"Where:\n\t"
+		"-v  Display information.\n\t"
+		"-r  Recursively descend directories.\n\t"
+		"path  Path to check current SHA1 digest against file_contexts entries.\n\n"
+		"This will check the directory selinux.sehash SHA1 digest for "
+		"<path> against\na newly generated digest based on the "
+		"file_context entries for that node\n(using the regx, mode "
+		"and path entries).\n", progname);
+	exit(1);
+}
+
+static int get_digests(struct selabel_handle *hnd, bool verbose, char *path)
+{
+	int rc = 0;
+	size_t i, digest_len = 0;
+	bool status;
+	uint8_t *xattr_digest = NULL;
+	uint8_t *calculated_digest = NULL;
+	char *sha1_buf = NULL;
+
+	status = selabel_get_digests_all_partial_matches(hnd, path,
+							 &calculated_digest,
+							 &xattr_digest,
+							 &digest_len);
+
+	sha1_buf = calloc(1, digest_len * 2 + 1);
+	if (!sha1_buf) {
+		fprintf(stderr, "Could not calloc buffer ERROR: %s\n",
+			strerror(errno));
+		rc = -1;
+		goto out;
+	}
+
+	/* rc = 0 NO MATCH, rc = 1 MATCH, rc = 2 NO calculated_digest
+	 * rc = 4 NO xattr_digest, rc = 6 NO digests
+	 */
+	if (status) { /* They match */
+		if (verbose) {
+			printf("xattr and file_contexts SHA1 digests match for: %s\n",
+			       path);
+
+			if (calculated_digest) {
+				for (i = 0; i < digest_len; i++)
+					sprintf((&sha1_buf[i * 2]), "%02x",
+						calculated_digest[i]);
+				printf("SHA1 digest: %s\n", sha1_buf);
+			}
+		}
+
+		rc = 1;
+		goto out;
+	} else {
+		if (!calculated_digest) {
+			rc = 2;
+			if (verbose) {
+				printf("No SHA1 digest available for: %s\n", path);
+				printf("as file_context entry is \"<<none>>\"\n");
+			}
+		}
+
+		if (calculated_digest && verbose) {
+			printf("The file_context entries for: %s\n", path);
+
+			for (i = 0; i < digest_len; i++)
+				sprintf((&sha1_buf[i * 2]), "%02x", calculated_digest[i]);
+			printf("generated SHA1 digest: %s\n", sha1_buf);
+		}
+		if (!xattr_digest) {
+			rc = rc | 4;
+			if (verbose)
+				printf("however there is no selinux.sehash xattr entry.\n");
+			else
+				goto out;
+
+		} else if (verbose) {
+			printf("however it does NOT match the current entry of:\n");
+			for (i = 0; i < digest_len; i++)
+				sprintf((&sha1_buf[i * 2]), "%02x", xattr_digest[i]);
+			printf("%s\n", sha1_buf);
+		}
+	}
+
+	free(sha1_buf);
+out:
+	free(xattr_digest);
+	free(calculated_digest);
+	return rc;
+}
+
+int main(int argc, char **argv)
+{
+	int opt, fts_flags, status;
+	bool verbose = false, recurse = false;
+	FTS *fts;
+	FTSENT *ftsent;
+	char *paths[2] = { NULL, NULL };
+	struct selabel_handle *hnd;
+
+	if (argc < 2)
+		usage(argv[0]);
+
+	while ((opt = getopt(argc, argv, "vr")) > 0) {
+		switch (opt) {
+		case 'v':
+			verbose = true;
+			break;
+		case 'r':
+			recurse = true;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	if (optind >= argc) {
+		fprintf(stderr, "No pathname specified\n");
+		exit(-1);
+	}
+	paths[0] = argv[optind];
+
+	hnd = selabel_open(SELABEL_CTX_FILE, NULL, 0);
+	if (!hnd) {
+		fprintf(stderr, "ERROR: selabel_open - Could not obtain handle.\n");
+		return -1;
+	}
+
+	fts_flags = FTS_PHYSICAL | FTS_NOCHDIR;
+	fts = fts_open(paths, fts_flags, NULL);
+	if (!fts) {
+		printf("fts error on %s: %s\n",
+		       paths[0], strerror(errno));
+		return -1;
+	}
+
+	while ((ftsent = fts_read(fts)) != NULL) {
+		switch (ftsent->fts_info) {
+		case FTS_D:
+			/* If recurse = TRUE, then 'status' will reflect the
+			 * last path match with 0 = NO MATCH, 1 = MATCH,
+			 * 2 = NO calculated_digest, 4 = NO xattr_digest and
+			 * 6 = NO digests.
+			 */
+			status = get_digests(hnd, verbose, ftsent->fts_path);
+			if (status < 0)
+				goto out;
+			break;
+		default:
+			break;
+		}
+
+		if (!recurse)
+			break;
+	}
+
+out:
+	(void) fts_close(fts);
+	(void) selabel_close(hnd);
+	return status;
+}
diff --git a/tests/restorecon/restorecon.c b/tests/restorecon/restorecon.c
new file mode 100644
index 0000000..7b3bfaf
--- /dev/null
+++ b/tests/restorecon/restorecon.c
@@ -0,0 +1,74 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <getopt.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <selinux/selinux.h>
+#include <selinux/label.h>
+#include <selinux/restorecon.h>
+
+static void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s [-IDrv] path\n\n"
+		"Where:\n\t"
+		"-I  Set SELINUX_RESTORECON_IGNORE_DIGEST\n\t"
+		"-D  Set digests\n\t"
+		"-r  Recursively descend directories.\n\t"
+		"-v  Display information.\n\t"
+		"path  Path of file or directory to check.\n", progname);
+	exit(-1);
+}
+
+int main(int argc, char **argv)
+{
+	int opt, rc, flags = SELINUX_RESTORECON_SKIP_DIGEST;
+
+	struct selabel_handle *hnd;
+
+	if (argc < 2)
+		usage(argv[0]);
+
+	while ((opt = getopt(argc, argv, "IDrv")) > 0) {
+		switch (opt) {
+		case 'I':
+			flags |= SELINUX_RESTORECON_IGNORE_DIGEST;
+			break;
+		case 'D':
+			flags ^= SELINUX_RESTORECON_SKIP_DIGEST;
+			break;
+		case 'r':
+			flags |= SELINUX_RESTORECON_RECURSE;
+			break;
+		case 'v':
+			flags |= SELINUX_RESTORECON_VERBOSE;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	if (optind >= argc) {
+		fprintf(stderr, "No pathname specified\n");
+		return -1;
+	}
+
+	hnd = selabel_open(SELABEL_CTX_FILE, NULL, 0);
+	if (!hnd) {
+		fprintf(stderr, "ERROR: selabel_open - Could not obtain handle.\n");
+		return -1;
+	}
+
+	/* Use own handle */
+	selinux_restorecon_set_sehandle(hnd);
+
+	rc = selinux_restorecon(argv[optind], flags);
+	if (rc < 0)
+		fprintf(stderr, "selinux_restorecon ERROR: %s\n",
+			strerror(errno));
+
+	selabel_close(hnd);
+	return rc;
+}
+
diff --git a/tests/restorecon/test b/tests/restorecon/test
new file mode 100755
index 0000000..648c794
--- /dev/null
+++ b/tests/restorecon/test
@@ -0,0 +1,147 @@
+#!/usr/bin/perl
+use Test::More;
+
+# Options: -v = Verbose, -p <path_to_restorecon>
+# NOTE: If using the -p option to use a different version of restorecon,
+# ensure they are labeled correctly before use. This can be achieved by:
+#    chcon -h -t bin_t .../sbin/restorecon
+#    chcon -h -t setfiles_exec_t .../sbin/setfiles
+# The test_restorecon.te policy has rules for this labeling.
+
+BEGIN {
+    $basedir = $0;
+    $basedir =~ s|(.*)/[^/]*|$1|;
+
+    $v      = " ";
+    $bindir = $basedir;
+    $i      = 0;
+    foreach $arg (@ARGV) {
+        if ( $arg eq "-v" ) {
+            $v = $arg;
+        }
+        elsif ( $arg eq "-p" ) {
+            $bindir = $ARGV[ $i + 1 ];
+            if ( not -e "$bindir/restorecon" ) {
+                plan skip_all => "restorecon not found";
+            }
+        }
+        $i++;
+    }
+
+    # check if /tmp is really type tmpfs (TMPFS_MAGIC).
+    $test_tmpfs = 0;
+    $result     = system("$basedir/check_fs $v /tmp 2>/dev/null");
+    if ( $result >> 8 eq 2 ) {
+        $test_tmpfs = 1;
+        plan tests => 11;
+    }
+    else {
+        plan tests => 10;
+    }
+}
+
+print "Using \"restorecon\" from $bindir\n";
+
+# Make sure test directory removed then generate new. Using a root dir to test
+# libselinux: Ignore the stem when looking up all matches in file context
+print "Generating test directories\n";
+system("rm -rf /restore_test");
+system("mkdir -p /restore_test/in_dir");
+system("mkdir -p /restore_test/out_dir");
+
+# Using semanage is much quicker than using semodule to build fc entries.
+print "semanage adding file context entries\n";
+system("semanage fcontext -a -t test_file_t -f d /restore_test");
+system("semanage fcontext -a -t in_dir_t -f d /restore_test/in_dir");
+system("semanage fcontext -a -t out_dir_t -f d /restore_test/out_dir");
+
+print "Add files to the directories\n";
+system("touch /restore_test/out_dir/out_file1");
+system("touch /restore_test/in_dir/in_file1");
+
+print "Check there are no xattr digest entries\n";
+$result = system(
+    "runcon -t test_restorecon_t $basedir/get_all_digests -r $v /restore_test");
+ok( $result >> 8 eq 4 );
+
+print "Run restorecon to add digest entries, then check they match\n";
+system("runcon -t test_restorecon_t $bindir/restorecon -rD $v /restore_test");
+$result = system(
+    "runcon -t test_restorecon_t $basedir/get_all_digests -r $v /restore_test");
+ok( $result >> 8 eq 1 );
+
+print "Add new file context entries, then check digests do not match\n";
+system("semanage fcontext -a -t in_file_t -f f \"/restore_test/in_dir(/.*)?\"");
+system(
+    "semanage fcontext -a -t out_file_t -f f \"/restore_test/out_dir(/.*)?\"");
+$result = system(
+    "runcon -t test_restorecon_t $basedir/get_all_digests -r $v /restore_test");
+ok( $result eq 0 );
+
+print "Now fix with restorecon and check digests match\n";
+system("runcon -t test_restorecon_t $bindir/restorecon -rD $v /restore_test");
+$result = system(
+    "runcon -t test_restorecon_t $basedir/get_all_digests -r $v /restore_test");
+ok( $result >> 8 eq 1 );
+
+print "Remove sehash entry on /restore_test/out_dir then check if removed\n";
+system(
+"runcon -t test_restorecon_t setfattr -x security.sehash /restore_test/out_dir"
+);
+$result = system(
+"runcon -t test_restorecon_t $basedir/get_all_digests $v /restore_test/out_dir"
+);
+ok( $result >> 8 eq 4 );
+
+print "Run restorecon with SELINUX_RESTORECON_IGNORE_DIGEST = TRUE,\n";
+print "then check that digests match\n";
+system("runcon -t test_restorecon_t $bindir/restorecon -Ir $v /restore_test");
+$result = system(
+    "runcon -t test_restorecon_t $basedir/get_all_digests -r $v /restore_test");
+ok( $result >> 8 eq 1 );
+
+print "Remove some file context entries, then check digests do not match\n";
+system("semanage fcontext -d -t in_dir_t -f d /restore_test/in_dir");
+system("semanage fcontext -d -t out_dir_t -f d /restore_test/out_dir");
+system("semanage fcontext -d -t in_file_t -f f \"/restore_test/in_dir(/.*)?\"");
+$result = system(
+    "runcon -t test_restorecon_t $basedir/get_all_digests -r $v /restore_test");
+ok( $result eq 0 );
+
+print "Run restorecon with SELINUX_RESTORECON_SKIP_DIGEST = TRUE,\n";
+print "then check that digests still do not match as updates were skipped\n";
+system("runcon -t test_restorecon_t $bindir/restorecon -r $v /restore_test");
+$result = system(
+    "runcon -t test_restorecon_t $basedir/get_all_digests -r $v /restore_test");
+ok( $result eq 0 );
+
+print "Run restorecon with SELINUX_RESTORECON_SKIP_DIGEST = FALSE,\n";
+print "then check that digests match\n";
+system("runcon -t test_restorecon_t $bindir/restorecon -rD $v /restore_test");
+$result = system(
+    "runcon -t test_restorecon_t $basedir/get_all_digests -r $v /restore_test");
+ok( $result >> 8 eq 1 );
+
+system(
+    "semanage fcontext -d -t in_file_t -f f \"/restore_test/out_dir(/.*)?\"");
+system("semanage fcontext -d -t test_file_t -f d /restore_test");
+system("rm -rf /restore_test");
+
+print "Run restorecon on /sys with SELINUX_RESTORECON_SKIP_DIGEST = FALSE,\n";
+print "then check the digests are skipped as /sys is SYSFS_MAGIC.\n";
+system("runcon -t test_restorecon_t $bindir/restorecon -rD $v /sys/fs/selinux");
+$result = system(
+    "runcon -t test_restorecon_t $basedir/get_all_digests $v /sys/fs/selinux");
+ok( $result >> 8 eq 4 );
+
+if ($test_tmpfs) {
+    print
+      "Run restorecon on /tmp with SELINUX_RESTORECON_SKIP_DIGEST = FALSE,\n";
+    print "then check the digests are skipped as /tmp is TMPFS_MAGIC\n";
+    system("runcon -t test_restorecon_t $bindir/restorecon -rD $v /tmp");
+    $result =
+      system("runcon -t test_restorecon_t $basedir/get_all_digests $v /tmp");
+    ok( $result >> 8 eq 4 );
+}
+
+exit;
-- 
2.20.1

