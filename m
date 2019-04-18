Return-Path: <SRS0=jmdh=SU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D684DC10F0E
	for <selinux@archiver.kernel.org>; Thu, 18 Apr 2019 08:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91BE4217D7
	for <selinux@archiver.kernel.org>; Thu, 18 Apr 2019 08:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="fG7RKWvp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388323AbfDRI7Y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:59:24 -0400
Received: from rgout05.bt.lon5.cpcloud.co.uk ([65.20.0.182]:61727 "EHLO
        rgout05.bt.lon5.cpcloud.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728074AbfDRI7X (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 04:59:23 -0400
X-OWM-Source-IP: 31.49.61.120 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduuddrfeehgddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeefuddrgeelrdeiuddruddvtdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrgeelrdeiuddruddvtddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduuddrfeehgddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeefuddrgeelrdeiuddruddvtdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrgeelrdeiuddruddvtddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade-Verdict: clean 0
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-SNCR-VADESECURE: CLEAN
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduuddrfeehgddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeefuddrgeelrdeiuddruddvtdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrgeelrdeiuddruddvtddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqeenucevlhhushhtvghrufhiiigvpedt
Received: from localhost.localdomain (31.49.61.120) by rgout05.bt.lon5.cpcloud.co.uk (9.0.019.26-1) (authenticated as richard_c_haines@btinternet.com)
        id 5C24804F0A79DBF2; Thu, 18 Apr 2019 09:41:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btcpcloud; t=1555577962; 
        bh=O+qZXpvoWVmRZ3KNdnriZxPz09HJk5AIYEEjMBfCfn8=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=fG7RKWvpcrnYfXhgs9szTTmH09sY1xJs+Kd8PNaC18bPfDasn3m1fYb2DSRp247Hp8CNSmxf2EpIsYrpbemyXPjDrSDoMwsha83epEpRTYg+xDO4qErv3BVFIJsIy//Xsig7AjC2af2KvXFbOQcsbc0xblxXGE6EPA9QVsBabDw=
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC PATCH] selinux-testsuite: Add test for restorecon
Date:   Thu, 18 Apr 2019 09:41:18 +0100
Message-Id: <20190418084118.3157-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This will test the updated selinux_restorecon(3) that is currently in
Android.

Only use this to test the "libselinux: Save digest of all partial matches
for directory" patch as it will probably change.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 policy/Makefile                       |   2 +-
 policy/test_restorecon.te             |  40 +++++++++
 tests/Makefile                        |   4 +
 tests/restorecon/.gitignore           |   2 +
 tests/restorecon/Makefile             |   8 ++
 tests/restorecon/get_digests.c        | 125 ++++++++++++++++++++++++++
 tests/restorecon/selinux_restorecon.c |  68 ++++++++++++++
 tests/restorecon/test                 | 101 +++++++++++++++++++++
 8 files changed, 349 insertions(+), 1 deletion(-)
 create mode 100644 policy/test_restorecon.te
 create mode 100644 tests/restorecon/.gitignore
 create mode 100644 tests/restorecon/Makefile
 create mode 100644 tests/restorecon/get_digests.c
 create mode 100644 tests/restorecon/selinux_restorecon.c
 create mode 100755 tests/restorecon/test

diff --git a/policy/Makefile b/policy/Makefile
index cc70d33..a8c8b8a 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -25,7 +25,7 @@ TARGETS = \
 	test_task_getsid.te test_task_setpgid.te test_task_setsched.te \
 	test_transition.te test_inet_socket.te test_unix_socket.te \
 	test_mmap.te test_overlayfs.te test_mqueue.te test_mac_admin.te \
-	test_ibpkey.te test_atsecure.te
+	test_ibpkey.te test_atsecure.te test_restorecon.te
 
 ifeq ($(shell [ $(POL_VERS) -ge 24 ] && echo true),true)
 TARGETS += test_bounds.te
diff --git a/policy/test_restorecon.te b/policy/test_restorecon.te
new file mode 100644
index 0000000..91cc6ea
--- /dev/null
+++ b/policy/test_restorecon.te
@@ -0,0 +1,40 @@
+#################################
+#
+# Policy for testing restorecon
+#
+
+require {
+	attribute file_type;
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
+# Domain for process that can restorecon the test file.
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
+
+# Allow all of these domains to be entered from sysadm domain
+miscfiles_domain_entry_test_files(restorecon_domain)
+userdom_sysadm_entry_spec_domtrans_to(restorecon_domain)
diff --git a/tests/Makefile b/tests/Makefile
index fb6de5c..94eca9f 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -47,6 +47,10 @@ ifeq ($(shell grep "^SELINUX_INFINIBAND_PKEY_TEST=" infiniband_pkey/ibpkey_test.
 SUBDIRS += infiniband_pkey
 endif
 
+ifeq ($(shell grep -q selabel_get_digests_all_partial_matches $(INCLUDEDIR)/selinux/label.h && echo true),true)
+SUBDIRS += restorecon
+endif
+
 ifeq ($(DISTRO),RHEL4)
     SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap nnp_nosuid overlay unix_socket, $(SUBDIRS))
 endif
diff --git a/tests/restorecon/.gitignore b/tests/restorecon/.gitignore
new file mode 100644
index 0000000..c37f923
--- /dev/null
+++ b/tests/restorecon/.gitignore
@@ -0,0 +1,2 @@
+selinux_restorecon
+get_digests
diff --git a/tests/restorecon/Makefile b/tests/restorecon/Makefile
new file mode 100644
index 0000000..5c0d6e2
--- /dev/null
+++ b/tests/restorecon/Makefile
@@ -0,0 +1,8 @@
+TARGETS = selinux_restorecon get_digests
+
+LDLIBS += -lselinux
+
+all: $(TARGETS)
+
+clean:
+	rm -f $(TARGETS)
diff --git a/tests/restorecon/get_digests.c b/tests/restorecon/get_digests.c
new file mode 100644
index 0000000..875ba3b
--- /dev/null
+++ b/tests/restorecon/get_digests.c
@@ -0,0 +1,125 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <getopt.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <selinux/selinux.h>
+#include <selinux/label.h>
+
+#define RESTORECON_PARTIAL_MATCH_DIGEST  "security.sehash"
+
+static void usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s [-v] path\n\n"
+		"Where:\n\t"
+		"-v  Display information.\n\t"
+		"path  Path to check current SHA1 digest against file_contexts entries.\n\n"
+		"This will check the directory selinux.sehash SHA1 digest for "
+		"<path> against\na newly generated digest based on the "
+		"file_context entries for that node\n(using the regx, mode "
+		"and path entries).\n", progname);
+	exit(1);
+}
+
+int main(int argc, char **argv)
+{
+	int opt, rc = 0; /* The hashes do NOT match */
+	size_t i, digest_len = 0;
+	bool status, verbose = false;
+	uint8_t *xattr_digest = NULL;
+	uint8_t *calculated_digest = NULL;
+	char *sha1_buf = NULL;
+
+	struct selabel_handle *hnd;
+
+	if (argc < 2)
+		usage(argv[0]);
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
+		exit(-1);
+	}
+
+	hnd = selabel_open(SELABEL_CTX_FILE, NULL, 0);
+	if (!hnd) {
+		fprintf(stderr, "ERROR: selabel_open - Could not obtain handle.\n");
+		return -1;
+	}
+
+	status = selabel_get_digests_all_partial_matches(hnd, argv[optind],
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
+	if (status) { /* They match */
+		if (verbose) {
+			printf("xattr and file_contexts SHA1 digests match for: %s\n",
+			       argv[optind]);
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
+				printf("No SHA1 digest available for: %s\n", argv[optind]);
+				printf("as file_context entry is \"<<none>>\"\n");
+			}
+		}
+
+		if (calculated_digest && verbose) {
+			printf("The file_context entries for: %s\n", argv[optind]);
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
+out:
+	selabel_close(hnd);
+	free(xattr_digest);
+	free(calculated_digest);
+	free(sha1_buf);
+	return rc;
+}
diff --git a/tests/restorecon/selinux_restorecon.c b/tests/restorecon/selinux_restorecon.c
new file mode 100644
index 0000000..7ea9387
--- /dev/null
+++ b/tests/restorecon/selinux_restorecon.c
@@ -0,0 +1,68 @@
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
+		"usage:  %s [-vr]\n"
+		"Where:\n\t"
+		"-v  Display information.\n\t"
+		"-r  Recursively descend directories.\n", progname);
+	exit(-1);
+}
+
+int main(int argc, char **argv)
+{
+	int opt, rc, flags = 0;
+	bool verbose = false;
+
+	struct selabel_handle *hnd;
+
+	if (argc < 2)
+		usage(argv[0]);
+
+	while ((opt = getopt(argc, argv, "rv")) > 0) {
+		switch (opt) {
+		case 'r':
+			flags = SELINUX_RESTORECON_RECURSE;
+			break;
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
+		exit(-1);
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
+	if (verbose)
+		flags |= SELINUX_RESTORECON_VERBOSE;
+
+	rc = selinux_restorecon(argv[optind], flags);
+	if (rc < 0)
+		fprintf(stderr, "selinux_restorecon ERROR: %s\n",
+			strerror(errno));
+
+	return rc;
+}
+
diff --git a/tests/restorecon/test b/tests/restorecon/test
new file mode 100755
index 0000000..208b6c4
--- /dev/null
+++ b/tests/restorecon/test
@@ -0,0 +1,101 @@
+#!/usr/bin/perl
+use Test::More;
+
+BEGIN {
+    $basedir = $0;
+    $basedir =~ s|(.*)/[^/]*|$1|;
+
+    # allow info to be shown
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
+    plan tests => 6;
+}
+
+# Need to get full path for semanage and tests progs
+use Cwd qw(cwd);
+$cwd = cwd;
+if ( $basedir ne "." ) {
+    $path = "$cwd/$basedir";
+}
+else {
+    $path = $cwd;
+}
+
+# Make sure removed then generate new
+system("rm -rf $basedir/restore_test");
+system("mkdir -p $basedir/restore_test/in_dir");
+system("mkdir -p $basedir/restore_test/out_dir");
+
+system("semanage fcontext -a -t test_file_t -f d $path/restore_test");
+system("semanage fcontext -a -t in_dir_t -f d $path/restore_test/in_dir");
+system("semanage fcontext -a -t out_dir_t -f d $path/restore_test/out_dir");
+
+# Add some files
+system("touch $path/restore_test/out_dir/out_file1");
+system("touch $path/restore_test/in_dir/in_file1");
+
+# There is no selinux.sehash xattr entry
+$result =
+  system(
+    "runcon -t test_restorecon_t $basedir/get_digests $v $path/restore_test");
+ok( $result >> 8 eq 4 );
+
+$result =
+  system(
+"runcon -t test_restorecon_t $basedir/selinux_restorecon -r $v $path/restore_test"
+  );
+ok( $result eq 0 );
+
+# After restorecon they match
+$result =
+  system(
+    "runcon -t test_restorecon_t $basedir/get_digests $v $path/restore_test");
+ok( $result >> 8 eq 1 );
+
+# Add new file_context enties to get the files relabeled:
+system(
+    "semanage fcontext -a -t in_file_t -f f \"$path/restore_test/in_dir(/.*)?\""
+);
+system(
+"semanage fcontext -a -t out_file_t -f f \"$path/restore_test/out_dir(/.*)?\""
+);
+
+# Now the digests do NOT match
+$result =
+  system(
+    "runcon -t test_restorecon_t $basedir/get_digests $v $path/restore_test");
+ok( $result eq 0 );
+
+$result =
+  system(
+"runcon -t test_restorecon_t $basedir/selinux_restorecon -r $v $path/restore_test"
+  );
+ok( $result eq 0 );
+
+# After restorecon they match again
+$result =
+  system(
+    "runcon -t test_restorecon_t $basedir/get_digests $v $path/restore_test");
+ok( $result >> 8 eq 1 );
+
+# semanage x 10 takes 50s. Using semodule loading 2 x *.cil + 1 delete is slower 1m:40s
+system("semanage fcontext -d -t in_dir_t -f d $path/restore_test/in_dir");
+system("semanage fcontext -d -t out_dir_t -f d $path/restore_test/out_dir");
+system(
+    "semanage fcontext -d -t in_file_t -f f \"$path/restore_test/in_dir(/.*)?\""
+);
+system(
+"semanage fcontext -d -t in_file_t -f f \"$path/restore_test/out_dir(/.*)?\""
+);
+system("semanage fcontext -d -t test_file_t -f d $path/restore_test");
+system("rm -rf $basedir/restore_test");
+
+exit;
-- 
2.20.1

