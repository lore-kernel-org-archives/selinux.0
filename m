Return-Path: <SRS0=6dkg=6B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54FBC2D0EF
	for <selinux@archiver.kernel.org>; Fri, 17 Apr 2020 16:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 870FD22209
	for <selinux@archiver.kernel.org>; Fri, 17 Apr 2020 16:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="cVQe+ujW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgDQQiM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:38:12 -0400
Received: from mailomta6-re.btinternet.com ([213.120.69.99]:20371 "EHLO
        re-prd-fep-046.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725877AbgDQQiL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Apr 2020 12:38:11 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-046.btinternet.com with ESMTP
          id <20200417163808.SUFO28099.re-prd-fep-046.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Fri, 17 Apr 2020 17:38:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1587141488; 
        bh=QJT1/y24pFDGoeCra8Xq4I4VJ+Y1panPYBLFLmBK+Ks=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=cVQe+ujWKXXyD4axIoZ2+5pjp60OZwwe5fduAV3IlzZija5kpZukmn6PEzEoHvngSiz/J4gC1NJFAJ3632Mc+ZYV8yw1pwaANg6VFp5vIwTpCjaHsia9nISbhxlsC2gUrTeuVEH2o3nRktpZhop2LYY0btX3ovlqUwlkY7ISnF3GXl+UB0V2nbeVsUq1Wws3O4kl4oMENBWo4yDXKyZP5R1igGoI215SmckH2F4CPxceB0IhziMEzkSaS0WP23IwPmw8pjeXmx/R3az4xefokWuSACS2Mq6pTzAqulp5a/YoRUJv38Ootc0vSj77gJm6WC3yuKt2l4In1pnxD6iB3A==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [109.148.52.191]
X-OWM-Source-IP: 109.148.52.191 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduhedrfeejgddutdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepuddtledrudegkedrhedvrdduledunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpedutdelrddugeekrdehvddrudeluddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoeguhhhofigvlhhlshesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeophgruhhlsehprghulhdqmhhoohhrvgdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (109.148.52.191) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A16DE0B96FD44; Fri, 17 Apr 2020 17:38:08 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     paul@paul-moore.com
Cc:     dhowells@redhat.com, selinux@vger.kernel.org,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC PATCH] selinux-testsuite: Add check for key changes on watch_queue
Date:   Fri, 17 Apr 2020 17:38:04 +0100
Message-Id: <20200417163804.307854-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Kernel 5.7 introduced the watch_queue service that allows watching for
key changes. This requires key { view } permission, therefore check if
allowed or not.

Note that the keyctl_watch_key() function is not yet built into the
keyutils library, therefore a syscall() is used.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 defconfig                 |   5 ++
 policy/Makefile           |   2 +-
 policy/test_watchkey.te   |  34 ++++++++++++
 tests/Makefile            |   4 ++
 tests/watchkey/.gitignore |   1 +
 tests/watchkey/Makefile   |   7 +++
 tests/watchkey/test       |  29 ++++++++++
 tests/watchkey/watchkey.c | 113 ++++++++++++++++++++++++++++++++++++++
 8 files changed, 194 insertions(+), 1 deletion(-)
 create mode 100644 policy/test_watchkey.te
 create mode 100644 tests/watchkey/.gitignore
 create mode 100644 tests/watchkey/Makefile
 create mode 100755 tests/watchkey/test
 create mode 100644 tests/watchkey/watchkey.c

diff --git a/defconfig b/defconfig
index 0574f1d..9afbc2f 100644
--- a/defconfig
+++ b/defconfig
@@ -78,3 +78,8 @@ CONFIG_KEY_DH_OPERATIONS=y
 # Test key management socket.
 # This is not required for SELinux operation itself.
 CONFIG_NET_KEY=m
+
+# watch_queue for key changes.
+# They are not required for SELinux operation itself.
+CONFIG_WATCH_QUEUE=y
+CONFIG_KEY_NOTIFICATIONS=y
diff --git a/policy/Makefile b/policy/Makefile
index 87b2856..b3f5e3d 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -86,7 +86,7 @@ TARGETS += test_bpf.te test_fdreceive_bpf.te test_binder_bpf.te
 endif
 
 ifeq ($(shell grep -q all_key_perms $(POLDEV)/include/support/all_perms.spt && echo true),true)
-TARGETS += test_keys.te
+TARGETS += test_keys.te test_watchkey.te
 endif
 
 ifeq ($(shell grep -q all_file_perms.*watch $(POLDEV)/include/support/all_perms.spt && echo true),true)
diff --git a/policy/test_watchkey.te b/policy/test_watchkey.te
new file mode 100644
index 0000000..e1d4c78
--- /dev/null
+++ b/policy/test_watchkey.te
@@ -0,0 +1,34 @@
+#
+######### Check watch_queue for key changes policy module ##########
+#
+attribute watchkeydomain;
+
+################# Allow watch_queue key { view } ##########################
+type test_watchkey_t;
+domain_type(test_watchkey_t)
+unconfined_runs_test(test_watchkey_t)
+typeattribute test_watchkey_t testdomain;
+typeattribute test_watchkey_t keydomain;
+
+allow test_watchkey_t self:capability { ipc_lock };
+allow test_watchkey_t device_t:chr_file { ioctl open read write };
+allow test_watchkey_t self:key { view };
+allow_map(test_watchkey_t, device_t, chr_file)
+
+################# Deny watch_queue key { view } ##########################
+type test_watchkey_no_view_t;
+domain_type(test_watchkey_no_view_t)
+unconfined_runs_test(test_watchkey_no_view_t)
+typeattribute test_watchkey_no_view_t testdomain;
+typeattribute test_watchkey_no_view_t keydomain;
+
+allow test_watchkey_no_view_t self:capability { ipc_lock };
+allow test_watchkey_no_view_t device_t:chr_file { ioctl open read write };
+neverallow test_watchkey_no_view_t self:key { view };
+allow_map(test_watchkey_no_view_t, device_t, chr_file)
+
+#
+########### Allow these domains to be entered from sysadm domain ############
+#
+miscfiles_domain_entry_test_files(watchkeydomain)
+userdom_sysadm_entry_spec_domtrans_to(watchkeydomain)
diff --git a/tests/Makefile b/tests/Makefile
index 1cdb1ac..ed09a49 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -78,6 +78,10 @@ SUBDIRS+=module_load
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
index 0000000..f645a31
--- /dev/null
+++ b/tests/watchkey/watchkey.c
@@ -0,0 +1,113 @@
+/* Based on kernel source samples/watch_queue/watch_test.c */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <linux/watch_queue.h>
+#include <linux/unistd.h>
+#include <linux/keyctl.h>
+#include <selinux/selinux.h>
+
+#define BUF_SIZE 4
+#define W_DEV "/dev/watch_queue"
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
+	int opt, fd, result, save_errno;
+	char *context;
+	bool verbose = false;
+	size_t page_size, mmap_size;
+	struct watch_queue_buffer *buf;
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
+	fd = open(W_DEV, O_RDWR);
+	if (fd < 0) {
+		fprintf(stderr, "Failed to open: %s Error: %s\n", W_DEV,
+			strerror(errno));
+		exit(-1);
+	}
+	if (verbose)
+		printf("Opened %s\n", W_DEV);
+
+	result = ioctl(fd, IOC_WATCH_QUEUE_SET_SIZE, BUF_SIZE);
+	if (result < 0) {
+		fprintf(stderr, "Failed to set watch_queue size: %s\n",
+			strerror(errno));
+		exit(-1);
+	}
+
+	page_size = sysconf(_SC_PAGESIZE);
+	if (page_size < 0) {
+		fprintf(stderr, "Failed sysconf(_SC_PAGESIZE): %s\n",
+			strerror(errno));
+		close(fd);
+		exit(-1);
+	}
+	mmap_size = page_size * BUF_SIZE;
+
+	buf = mmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	if (buf == MAP_FAILED) {
+		fprintf(stderr, "Failed mmap(2): %s\n", strerror(errno));
+		close(fd);
+		exit(-1);
+	}
+
+	save_errno = 0;
+	/* Requires key { view } */
+	result = keyctl_watch_key(KEY_SPEC_PROCESS_KEYRING, fd,
+				  WATCH_TYPE_KEY_NOTIFY);
+	if (result < 0) {
+		fprintf(stderr, "Failed keyctl_watch_key(): %s\n",
+			strerror(errno));
+		save_errno = errno;
+		goto err;
+	}
+	if (verbose)
+		printf("keyctl_watch_key() successful\n");
+
+err:
+	munmap(buf, mmap_size);
+	close(fd);
+	return save_errno;
+}
-- 
2.24.1

