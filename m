Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B2BC433E0
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 13:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFA18206D4
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 13:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="Gw7nZBg0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgEONMh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 09:12:37 -0400
Received: from mailomta20-re.btinternet.com ([213.120.69.113]:47344 "EHLO
        re-prd-fep-042.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726298AbgEONMc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 09:12:32 -0400
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
          by re-prd-fep-042.btinternet.com with ESMTP
          id <20200515131228.QNKH4070.re-prd-fep-042.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>;
          Fri, 15 May 2020 14:12:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1589548348; 
        bh=w1YyunV4D+tpvg1ZXCBnc9k5E3Mjw8lD12hfMRPUCsg=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=Gw7nZBg0lttXl7YmZe+eCmVWMlZilSMLLK7Bo0ZoUEgCiC8GrHC6YvZg3o7H1ii86TAu5Ck82NAWr+B/cAdoIs6LhUFkleXG6AetxR/DHTKEZkrxT7twDYT83QHTvHS3Xu32Li41qn9Wt8+gNJh1YaqoPLqF+sYSmVSw6qzyPJe/Di8Xsir0EMOLNSqKz2Pomb1NwZC6Z/pIlABbDVoeHUgD/kJTE4LLvydir2zk1tSMllGi/UOKuArhAyUeipd7SE6bfh/TC94xmBAR9k1oP5KUTUqv1gzOV5yAAVrDgMKE5MSu6HApPBbNo+5YutC7laPE7twJfBMdOHczMzMhbA==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.190.32.24]
X-OWM-Source-IP: 86.190.32.24 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduhedrleekgdeitdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepueeffeduffefteejveehtedvkeeuueevffdtgfekgfetgfekgeeiheevueehvdffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkeeirdduledtrdefvddrvdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudeltddrfedvrddvgedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoeguhhhofigvlhhlshesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeoohhmohhsnhgrtggvsehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehprghulhesphgruhhlqdhmohhorhgvrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhi
        tghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.190.32.24) by re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A181A10A246F5; Fri, 15 May 2020 14:12:28 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     omosnace@redhat.com
Cc:     paul@paul-moore.com, dhowells@redhat.com, selinux@vger.kernel.org,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC PATCH V2] selinux-testsuite: Add check for key changes on watch_queue
Date:   Fri, 15 May 2020 14:12:22 +0100
Message-Id: <20200515131222.7969-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Kernel 5.? introduced the watch_queue service that allows watching for
key changes. This requires key { view } permission, therefore check if
allowed or not.

Note that the keyctl_watch_key() function is not yet built into the
keyutils library, therefore a syscall() is used.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
Tested on kernel.org 'linux-next: next-20200514'
V2 Changes:
1) The watch_queue changed from using /dev/watch_queue to pipe2(2), therefore
update watchkey.c
2) Update policy to reflect the changes.

 defconfig                 |  5 +++
 policy/Makefile           |  2 +-
 policy/test_watchkey.te   | 27 +++++++++++
 tests/Makefile            |  4 ++
 tests/watchkey/.gitignore |  1 +
 tests/watchkey/Makefile   |  7 +++
 tests/watchkey/test       | 29 ++++++++++++
 tests/watchkey/watchkey.c | 94 +++++++++++++++++++++++++++++++++++++++
 8 files changed, 168 insertions(+), 1 deletion(-)
 create mode 100644 policy/test_watchkey.te
 create mode 100644 tests/watchkey/.gitignore
 create mode 100644 tests/watchkey/Makefile
 create mode 100755 tests/watchkey/test
 create mode 100644 tests/watchkey/watchkey.c

diff --git a/defconfig b/defconfig
index 00bf9f3..68155dd 100644
--- a/defconfig
+++ b/defconfig
@@ -110,3 +110,8 @@ CONFIG_NFSD_V4_SECURITY_LABEL=y
 CONFIG_XFS_FS=m
 CONFIG_XFS_QUOTA=y
 CONFIG_VFAT_FS=m
+
+# watch_queue for key changes.
+# They are not required for SELinux operation itself.
+CONFIG_WATCH_QUEUE=y
+CONFIG_KEY_NOTIFICATIONS=y
diff --git a/policy/Makefile b/policy/Makefile
index 386bbce..672733e 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -104,7 +104,7 @@ TARGETS += test_bpf.te test_fdreceive_bpf.te test_binder_bpf.te
 endif
 
 ifeq ($(shell grep -q all_key_perms $(POLDEV)/include/support/all_perms.spt && echo true),true)
-TARGETS += test_keys.te
+TARGETS += test_keys.te test_watchkey.te
 endif
 
 ifeq ($(shell grep -q all_file_perms.*watch $(POLDEV)/include/support/all_perms.spt && echo true),true)
diff --git a/policy/test_watchkey.te b/policy/test_watchkey.te
new file mode 100644
index 0000000..00ade15
--- /dev/null
+++ b/policy/test_watchkey.te
@@ -0,0 +1,27 @@
+#
+######### Check watch_queue for key changes policy module ##########
+#
+attribute watchkeydomain;
+
+################# Allow watch_queue key { view } ##########################
+type test_watchkey_t;
+# Note: allow rules for pipe2(2) 'fifo_file { ioctl }' are set via domain_type()
+domain_type(test_watchkey_t)
+unconfined_runs_test(test_watchkey_t)
+typeattribute test_watchkey_t testdomain;
+typeattribute test_watchkey_t watchkeydomain;
+
+allow test_watchkey_t self:key { view };
+
+################# Deny watch_queue key { view } ##########################
+type test_watchkey_no_view_t;
+domain_type(test_watchkey_no_view_t)
+unconfined_runs_test(test_watchkey_no_view_t)
+typeattribute test_watchkey_no_view_t testdomain;
+typeattribute test_watchkey_no_view_t watchkeydomain;
+
+#
+########### Allow these domains to be entered from sysadm domain ############
+#
+miscfiles_domain_entry_test_files(watchkeydomain)
+userdom_sysadm_entry_spec_domtrans_to(watchkeydomain)
diff --git a/tests/Makefile b/tests/Makefile
index 5b86a2b..bdbdf3e 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -119,6 +119,10 @@ SUBDIRS += fs_filesystem
 endif
 endif
 
+ifeq ($(shell grep -q all_key_perms $(POLDEV)/include/support/all_perms.spt && test -e $(INCLUDEDIR)/linux/watch_queue.h && grep -qs KEYCTL_WATCH_KEY $(INCLUDEDIR)/linux/keyctl.h && echo true),true)
+SUBDIRS += watchkey
+endif
+
 ifeq ($(DISTRO),RHEL4)
     SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap nnp_nosuid overlay unix_socket, $(SUBDIRS))
 endif
diff --git a/tests/watchkey/.gitignore b/tests/watchkey/.gitignore
new file mode 100644
index 0000000..04db718
--- /dev/null
+++ b/tests/watchkey/.gitignore
@@ -0,0 +1 @@
+watchkey
diff --git a/tests/watchkey/Makefile b/tests/watchkey/Makefile
new file mode 100644
index 0000000..c2796fb
--- /dev/null
+++ b/tests/watchkey/Makefile
@@ -0,0 +1,7 @@
+TARGETS = watchkey
+LDLIBS += -lselinux
+
+all: $(TARGETS)
+
+clean:
+	rm -f $(TARGETS)
diff --git a/tests/watchkey/test b/tests/watchkey/test
new file mode 100755
index 0000000..f61ff78
--- /dev/null
+++ b/tests/watchkey/test
@@ -0,0 +1,29 @@
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
+    plan tests => 2;
+}
+
+$result = system "runcon -t test_watchkey_t $basedir/watchkey $v";
+ok( $result eq 0 );
+
+# Deny key { view } - EACCES
+$result = system "runcon -t test_watchkey_no_view_t $basedir/watchkey $v 2>&1";
+ok( $result >> 8 eq 13 );
+
+exit;
diff --git a/tests/watchkey/watchkey.c b/tests/watchkey/watchkey.c
new file mode 100644
index 0000000..c7f3274
--- /dev/null
+++ b/tests/watchkey/watchkey.c
@@ -0,0 +1,94 @@
+/* Based on kernel source samples/watch_queue/watch_test.c */
+
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+#include <stdbool.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <errno.h>
+#include <sys/ioctl.h>
+#include <linux/watch_queue.h>
+#include <linux/unistd.h>
+#include <linux/keyctl.h>
+#include <selinux/selinux.h>
+
+#define BUF_SIZE 256
+
+/* Require syscall() as function not yet in libkeyutils */
+static long keyctl_watch_key(int key, int watch_fd, int watch_id)
+{
+	return syscall(__NR_keyctl, KEYCTL_WATCH_KEY, key, watch_fd, watch_id);
+}
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
+int main(int argc, char **argv)
+{
+	int opt, fd, pipefd[2], result, save_errno;
+	char *context;
+	bool verbose = false;
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
+	if (verbose) {
+		result = getcon(&context);
+		if (result < 0) {
+			fprintf(stderr, "Failed to obtain process context\n");
+			exit(-1);
+		}
+
+		printf("Process context:\n\t%s\n", context);
+		free(context);
+	}
+
+	result = pipe2(pipefd, O_NOTIFICATION_PIPE);
+	if (result < 0) {
+		fprintf(stderr, "Failed to create pipe2(2): %s\n",
+			strerror(errno));
+		exit(-1);
+	}
+	fd = pipefd[0];
+
+	result = ioctl(fd, IOC_WATCH_QUEUE_SET_SIZE, BUF_SIZE);
+	if (result < 0) {
+		fprintf(stderr, "Failed to set watch_queue size: %s\n",
+			strerror(errno));
+		exit(-1);
+	}
+
+	save_errno = 0;
+	/* Requires key { view } */
+	result = keyctl_watch_key(KEY_SPEC_PROCESS_KEYRING, fd,
+				  WATCH_TYPE_KEY_NOTIFY);
+	if (result < 0) {
+		save_errno = errno;
+		fprintf(stderr, "Failed keyctl_watch_key(): %s\n",
+			strerror(errno));
+		goto err;
+	}
+	if (verbose)
+		printf("keyctl_watch_key() successful\n");
+
+err:
+	close(fd);
+	return save_errno;
+}
-- 
2.25.3

