Return-Path: <SRS0=4oDv=3J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3397BC33CB8
	for <selinux@archiver.kernel.org>; Mon, 20 Jan 2020 11:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01D12087E
	for <selinux@archiver.kernel.org>; Mon, 20 Jan 2020 11:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="c0caiG8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgATLLX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Jan 2020 06:11:23 -0500
Received: from mailomta21-re.btinternet.com ([213.120.69.114]:36506 "EHLO
        re-prd-fep-043.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726451AbgATLLX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Jan 2020 06:11:23 -0500
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
          by re-prd-fep-043.btinternet.com with ESMTP
          id <20200120111118.GWUQ11959.re-prd-fep-043.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;
          Mon, 20 Jan 2020 11:11:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1579518678; 
        bh=UYf43kSmNIecqwEjploXH/5XhCtbKaspomIWeP6o/iE=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=c0caiG8VXkWAUHGE95r1Tf85I7T5ZLxRnz5JRiO8fEyq3Y3QYz/wCskTgSlALFQtoU4cSz0NNZfptmVHWycFU1IBzTJdx56eK6yTeElNLH8XhlNKq9aGebCOl7X0DNpIIJR8kXgiifyDoDyX+/B5lrmXSDie0coxvRdik3Z/h7y4NS3zlMZ0bbwCRl9zWE/orqT8peIfHil7PhPwJOqL7LEJP9SsMp4ANuCd3FD3k6hXLhPFuPqsonMSyoV0C0U7ktvpHEvs1bBIfq0idQ0BDwGmTN/WSbsHAfcbTLS4uEn1g2LSL0TrP9eofALWruijB1XZwUS/nbhnt0LbGAni+A==
Authentication-Results: btinternet.com; none
X-Originating-IP: [31.49.56.209]
X-OWM-Source-IP: 31.49.56.209 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrudehgddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeefuddrgeelrdehiedrvddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepfedurdegledrheeirddvtdelpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.49.56.209) by re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5DEE078D0731A120; Mon, 20 Jan 2020 11:11:18 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 2/2] selinux-testsuite: Add fs*(2) API filesystem tests
Date:   Mon, 20 Jan 2020 11:11:13 +0000
Message-Id: <20200120111113.23349-3-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200120111113.23349-1-richard_c_haines@btinternet.com>
References: <20200120111113.23349-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Test filesystem permissions using the fsopen(2), fsconfig(2), fsmount(2),
fspick(2) and fsmount(2) api's introduced in kernel 5.2.

Also tests move_mount(2) using open_tree(2).

These tests use common code from tests/filesystem.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 tests/Makefile                   |   6 +
 tests/fs_filesystem/.gitignore   |   3 +
 tests/fs_filesystem/Makefile     |  16 +
 tests/fs_filesystem/fs_common.c  | 110 ++++
 tests/fs_filesystem/fs_common.h  |  30 ++
 tests/fs_filesystem/fsmount.c    |  89 ++++
 tests/fs_filesystem/fspick.c     |  68 +++
 tests/fs_filesystem/move_mount.c |  76 +++
 tests/fs_filesystem/test         | 833 +++++++++++++++++++++++++++++++
 9 files changed, 1231 insertions(+)
 create mode 100644 tests/fs_filesystem/.gitignore
 create mode 100644 tests/fs_filesystem/Makefile
 create mode 100644 tests/fs_filesystem/fs_common.c
 create mode 100644 tests/fs_filesystem/fs_common.h
 create mode 100644 tests/fs_filesystem/fsmount.c
 create mode 100644 tests/fs_filesystem/fspick.c
 create mode 100644 tests/fs_filesystem/move_mount.c
 create mode 100755 tests/fs_filesystem/test

diff --git a/tests/Makefile b/tests/Makefile
index a1478f1..46a1641 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -98,6 +98,12 @@ export CFLAGS += -DHAVE_FS_WATCH_PERM
 endif
 endif
 
+ifeq ($(shell grep -q filesystem $(POLDEV)/include/support/all_perms.spt && echo true),true)
+ifneq ($(shell ./kvercmp $$(uname -r) 5.2),-1)
+SUBDIRS += fs_filesystem
+endif
+endif
+
 ifeq ($(DISTRO),RHEL4)
     SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap nnp_nosuid overlay unix_socket, $(SUBDIRS))
 endif
diff --git a/tests/fs_filesystem/.gitignore b/tests/fs_filesystem/.gitignore
new file mode 100644
index 0000000..449f625
--- /dev/null
+++ b/tests/fs_filesystem/.gitignore
@@ -0,0 +1,3 @@
+fsmount
+fspick
+move_mount
diff --git a/tests/fs_filesystem/Makefile b/tests/fs_filesystem/Makefile
new file mode 100644
index 0000000..f7ae89d
--- /dev/null
+++ b/tests/fs_filesystem/Makefile
@@ -0,0 +1,16 @@
+TARGETS = fsmount fspick move_mount
+
+DEPS = fs_common.c fs_common.h
+
+LDLIBS += -lselinux
+
+USE_FS = ../filesystem
+
+all: $(TARGETS)
+	@set -e; for i in $(USE_FS); do $(MAKE) -C $$i all ; done
+
+clean:
+	rm -f $(TARGETS)
+	@set -e; for i in $(USE_FS); do $(MAKE) -C $$i clean ; done
+
+$(TARGETS): $(DEPS)
diff --git a/tests/fs_filesystem/fs_common.c b/tests/fs_filesystem/fs_common.c
new file mode 100644
index 0000000..79200ac
--- /dev/null
+++ b/tests/fs_filesystem/fs_common.c
@@ -0,0 +1,110 @@
+#include "fs_common.h"
+
+int fsopen(const char *fs_name, unsigned int flags)
+{
+	return syscall(__NR_fsopen, fs_name, flags);
+}
+
+int fsmount(int fsfd, unsigned int flags, unsigned int ms_flags)
+{
+	return syscall(__NR_fsmount, fsfd, flags, ms_flags);
+}
+
+int fsconfig(int fsfd, unsigned int cmd, const char *key,
+	     const void *val, int aux)
+{
+	return syscall(__NR_fsconfig, fsfd, cmd, key, val, aux);
+}
+
+int fspick(int dirfd, const char *pathname, unsigned int flags)
+{
+	return syscall(__NR_fspick, dirfd, pathname, flags);
+}
+
+int move_mount(int from_dfd, const char *from_pathname, int to_dfd,
+	       const char *to_pathname, unsigned int flags)
+{
+	return syscall(__NR_move_mount, from_dfd, from_pathname,
+		       to_dfd, to_pathname, flags);
+}
+
+int open_tree(int dirfd, const char *pathname, unsigned int flags)
+{
+	return syscall(__NR_open_tree, dirfd, pathname, flags);
+}
+
+int fsconfig_opts(int fd, char *src, char *tgt, char *opts, bool verbose)
+{
+	int result, i, save_errno, start_count, max_entries = 0;
+	int cmd[MAX_OPS];
+	char *key[MAX_OPS], *value[MAX_OPS];
+	char *src_str = "source";
+
+	/* If src then fsmount(2), else its going to be fspick(2) */
+	if (src) {
+		cmd[0] = FSCONFIG_SET_STRING;
+		key[0] = src_str;
+		value[0] = src;
+		start_count = 1;
+	} else {
+		start_count = 0;
+	}
+
+	for (i = start_count; i < MAX_OPS; i++) {
+		value[i] = strsep(&opts, ",");
+		if (!value[i]) {
+			max_entries = i + 1;
+			break;
+		}
+		cmd[i] = FSCONFIG_SET_STRING;
+	}
+
+	for (i = start_count; value[i] != NULL; i++) {
+		key[i] = strsep(&value[i], "=");
+		if (!value[i])
+			cmd[i] = FSCONFIG_SET_FLAG;
+	}
+
+	if (src) {
+		cmd[i] = FSCONFIG_CMD_CREATE;
+		key[i] = NULL;
+		value[i] = NULL;
+	} else {
+		cmd[i] = FSCONFIG_CMD_RECONFIGURE;
+		key[i] = NULL;
+		value[i] = NULL;
+	}
+
+	for (i = 0; i != max_entries; i++) {
+		if (verbose) {
+			switch (cmd[i]) {
+			case FSCONFIG_CMD_CREATE:
+				printf("fsconfig(FSCONFIG_CMD_CREATE, %s, %s, 0)\n",
+				       key[i], value[i]);
+				break;
+			case FSCONFIG_CMD_RECONFIGURE:
+				printf("fsconfig(FSCONFIG_CMD_RECONFIGURE, %s, %s, 0)\n",
+				       key[i], value[i]);
+				break;
+			case FSCONFIG_SET_FLAG:
+				printf("fsconfig(FSCONFIG_SET_FLAG, %s, %s, 0)\n",
+				       key[i], value[i]);
+				break;
+			case FSCONFIG_SET_STRING:
+				printf("fsconfig(FSCONFIG_SET_STRING, %s, %s, 0)\n",
+				       key[i], value[i]);
+				break;
+			}
+		}
+
+		result = fsconfig(fd, cmd[i], key[i], value[i], 0);
+		save_errno = errno;
+		if (result < 0) {
+			fprintf(stderr, "Failed fsconfig(2): %s\n",
+				strerror(save_errno));
+			return save_errno;
+		}
+	}
+
+	return 0;
+}
diff --git a/tests/fs_filesystem/fs_common.h b/tests/fs_filesystem/fs_common.h
new file mode 100644
index 0000000..e2fd08f
--- /dev/null
+++ b/tests/fs_filesystem/fs_common.h
@@ -0,0 +1,30 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <sys/prctl.h>
+#include <linux/mount.h>
+#include <linux/unistd.h>
+#include <selinux/selinux.h>
+
+#ifndef AT_EMPTY_PATH
+#define AT_EMPTY_PATH		0x1000
+#endif
+#ifndef AT_RECURSIVE
+#define AT_RECURSIVE		0x8000
+#endif
+
+int fsopen(const char *fs_name, unsigned int flags);
+int fsmount(int fsfd, unsigned int flags, unsigned int ms_flags);
+int fsconfig(int fsfd, unsigned int cmd, const char *key,
+	     const void *val, int aux);
+int move_mount(int from_dfd, const char *from_pathname, int to_dfd,
+	       const char *to_pathname, unsigned int flags);
+int open_tree(int dirfd, const char *pathname, unsigned int flags);
+int fspick(int dirfd, const char *pathname, unsigned int flags);
+
+#define MAX_OPS 40
+int fsconfig_opts(int fd, char *src, char *tgt, char *opts, bool verbose);
diff --git a/tests/fs_filesystem/fsmount.c b/tests/fs_filesystem/fsmount.c
new file mode 100644
index 0000000..320d82a
--- /dev/null
+++ b/tests/fs_filesystem/fsmount.c
@@ -0,0 +1,89 @@
+#include "fs_common.h"
+
+static void print_usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s -s src -t tgt -f fs_type [-o options] [-v]\n"
+		"Where:\n\t"
+		"-s  Source path\n\t"
+		"-t  Target path\n\t"
+		"-f  Filesystem type\n\t"
+		"-o  Options list (comma separated list)\n\t"
+		"-v  Print information.\n", progname);
+	exit(-1);
+}
+
+int main(int argc, char *argv[])
+{
+	int opt, result, fsfd, mfd;
+	char *context, *src = NULL, *tgt = NULL, *fs_type = NULL, *opts = NULL;
+	bool verbose = false;
+
+	while ((opt = getopt(argc, argv, "s:t:f:o:v")) != -1) {
+		switch (opt) {
+		case 's':
+			src = optarg;
+			break;
+		case 't':
+			tgt = optarg;
+			break;
+		case 'f':
+			fs_type = optarg;
+			break;
+		case 'o':
+			opts = optarg;
+			break;
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			print_usage(argv[0]);
+		}
+	}
+
+	if (!src || !tgt || !fs_type)
+		print_usage(argv[0]);
+
+	if (verbose) {
+		result = getcon(&context);
+		if (result < 0) {
+			fprintf(stderr, "Failed to obtain process context\n");
+			return -1;
+		}
+		printf("Process context:\n\t%s\n", context);
+		free(context);
+	}
+
+	if (verbose)
+		printf("Mounting\n\tsrc: %s\n\ttgt: %s\n\tfs_type: %s\n\topts: %s\n",
+		       src, tgt, fs_type, opts);
+
+	fsfd = fsopen(fs_type, 0);
+	if (fsfd < 0) {
+		fprintf(stderr, "Failed fsopen(2): %s\n", strerror(errno));
+		return -1;
+	}
+
+	/* config_opts() will return 0 or errno from fsconfig(2) */
+	result = fsconfig_opts(fsfd, src, NULL, opts, verbose);
+	if (result) {
+		fprintf(stderr, "Failed config_opts\n");
+		return result;
+	}
+
+	mfd = fsmount(fsfd, 0, 0);
+	if (mfd < 0) {
+		fprintf(stderr, "Failed fsmount(2): %s\n", strerror(errno));
+		return -1;
+	}
+	close(fsfd);
+
+	result = move_mount(mfd, "", AT_FDCWD, tgt, MOVE_MOUNT_F_EMPTY_PATH);
+	if (result < 0) {
+		fprintf(stderr, "Failed move_mount(2): %s\n", strerror(errno));
+		return -1;
+	}
+	close(mfd);
+
+	return 0;
+}
diff --git a/tests/fs_filesystem/fspick.c b/tests/fs_filesystem/fspick.c
new file mode 100644
index 0000000..b1e221d
--- /dev/null
+++ b/tests/fs_filesystem/fspick.c
@@ -0,0 +1,68 @@
+#include "fs_common.h"
+
+static void print_usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s -t tgt -o options [-v]\n"
+		"Where:\n\t"
+		"-t  Target path\n\t"
+		"-f  Filesystem type\n\t"
+		"-o  Options list (comma separated list)\n\t"
+		"-v  Print information.\n", progname);
+	exit(-1);
+}
+
+int main(int argc, char *argv[])
+{
+	int opt, result, pfd;
+	char *context, *tgt = NULL, *opts = NULL;
+	bool verbose = false;
+
+	while ((opt = getopt(argc, argv, "t:o:v")) != -1) {
+		switch (opt) {
+		case 't':
+			tgt = optarg;
+			break;
+		case 'o':
+			opts = optarg;
+			break;
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			print_usage(argv[0]);
+		}
+	}
+
+	if (!tgt || !opts)
+		print_usage(argv[0]);
+
+	if (verbose) {
+		result = getcon(&context);
+		if (result < 0) {
+			fprintf(stderr, "Failed to obtain process context\n");
+			return -1;
+		}
+		printf("Process context:\n\t%s\n", context);
+		free(context);
+	}
+
+	if (verbose)
+		printf("Mounting\n\ttgt: %s\n\topts: %s\n", tgt, opts);
+
+	pfd = fspick(AT_FDCWD, tgt, 0);
+	if (pfd < 0) {
+		fprintf(stderr, "Failed fspick(2): %s\n", strerror(errno));
+		return -1;
+	}
+
+	/* config_opts() will return 0 or errno from fsconfig(2) */
+	result = fsconfig_opts(pfd, NULL, tgt, opts, verbose);
+	if (result) {
+		fprintf(stderr, "Failed config_opts\n");
+		return result;
+	}
+
+	close(pfd);
+	return 0;
+}
diff --git a/tests/fs_filesystem/move_mount.c b/tests/fs_filesystem/move_mount.c
new file mode 100644
index 0000000..1b17df9
--- /dev/null
+++ b/tests/fs_filesystem/move_mount.c
@@ -0,0 +1,76 @@
+#include "fs_common.h"
+
+static void print_usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s -s src -t tgt [-v]\n"
+		"Where:\n\t"
+		"-s  Source path\n\t"
+		"-t  Target path\n\t"
+		"-v  Print information.\n", progname);
+	exit(-1);
+}
+
+int main(int argc, char *argv[])
+{
+	int opt, result, fd1, fd2, save_errno;
+	char *context, *src = NULL, *tgt = NULL;
+	bool verbose = false;
+
+	while ((opt = getopt(argc, argv, "s:t:v")) != -1) {
+		switch (opt) {
+		case 's':
+			src = optarg;
+			break;
+		case 't':
+			tgt = optarg;
+			break;
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			print_usage(argv[0]);
+		}
+	}
+
+	if (!src || !tgt)
+		print_usage(argv[0]);
+
+	if (verbose) {
+		result = getcon(&context);
+		if (result < 0) {
+			fprintf(stderr, "Failed to obtain process context\n");
+			return -1;
+		}
+		printf("Process context:\n\t%s\n", context);
+		free(context);
+	}
+
+	if (verbose)
+		printf("Mounting\n\tsrc: %s\n\ttgt: %s\n", src, tgt);
+
+	fd1 = open_tree(AT_FDCWD, src, 0);
+	if (fd1 < 0) {
+		fprintf(stderr, "Failed fd1 open_tree(2): %s\n",
+			strerror(errno));
+		return -1;
+	}
+
+	fd2 = open_tree(fd1, "", AT_EMPTY_PATH | OPEN_TREE_CLONE | AT_RECURSIVE);
+	if (fd2 < 0) {
+		fprintf(stderr, "Failed fd2 open_tree(2): %s\n",
+			strerror(errno));
+		return -1;
+	}
+
+	result = move_mount(fd2, "", AT_FDCWD, tgt, MOVE_MOUNT_F_EMPTY_PATH);
+	save_errno = errno;
+	if (result < 0) {
+		fprintf(stderr, "Failed move_mount(2): %s\n", strerror(errno));
+		return save_errno;
+	}
+
+	close(fd1);
+	close(fd2);
+	return 0;
+}
diff --git a/tests/fs_filesystem/test b/tests/fs_filesystem/test
new file mode 100755
index 0000000..bda7fcf
--- /dev/null
+++ b/tests/fs_filesystem/test
@@ -0,0 +1,833 @@
+#!/usr/bin/perl
+use Test::More;
+
+BEGIN {
+    $basedir = $0;
+    $basedir =~ s|(.*)/[^/]*|$1|;
+
+    # Load common subroutines from filesystem/Filesystem.pm
+    use File::Basename qw(dirname);
+    use Cwd qw(abs_path);
+    use lib dirname( abs_path $0) . '/../filesystem';
+    use Filesystem
+      qw(check_config udisks2_stop udisks2_restart get_loop_dev attach_dev make_fs mk_mntpoint_1 mk_mntpoint_2 cleanup cleanup1 reaper);
+
+    # Some code in tests/filesystem is reused
+    $filesystem_dir = "$basedir/../filesystem";
+    $test_count     = 63;
+
+    # Options: -v = Verbose, -d disable udisks(8) daemon
+    $v              = " ";
+    $disable_udisks = 0;
+    $udisks2_status = 0;
+    foreach $arg (@ARGV) {
+        if ( $arg eq "-v" ) {
+            $v = $arg;
+        }
+        elsif ( $arg eq "-d" ) {
+            $disable_udisks = 1;
+        }
+    }
+
+    # Check if watch and/or named type_transition rules configured
+    ( $addit, $test_watch, $test_name_trans ) =
+      check_config( $basedir, "$filesystem_dir/fanotify_fs" );
+
+    # Set to '1' for testing 'hooks.c selinux_move_mount() FILE__MOUNTON'
+    # Once kernel patch is mainline, add kernel version test.
+    $test_move_mount = 0;
+    if ($test_move_mount) {
+        $test_count += 3;
+    }
+
+    plan tests => ( $test_count += $addit );
+}
+
+# Set initial filesystem type
+$fs_type = "ext4";
+
+# Keep a list of devices used for removal at end of test.
+$device_count = 0;
+my @device_list;
+
+if ($disable_udisks) {
+    $udisks2_status = udisks2_stop();
+}
+
+cleanup($basedir);
+
+############### Test Basic Mount/Unmount ##########################
+mk_mntpoint_1("$basedir/mntpoint");
+( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+make_fs( $fs_type, $dev, $basedir );
+$mount_opts1 =
+"quota,usrquota,grpquota,defcontext=system_u:object_r:test_filesystem_file_t:s0";
+
+print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+print "Using mount options:\n\t$mount_opts1\n";
+$result = system(
+"runcon -t test_filesystem_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts1 $v"
+);
+ok( $result eq 0 );
+
+# On RHEL-6, there is a type transition to quota_t when running quotacheck
+# as unconfined_t. Using "runcon `id -Z` quotacheck ..." resolves this.
+print "Running quotacheck(8) to init user/group quota files\n";
+$result = system("runcon `id -Z` quotacheck -ugF vfsv0 $basedir/mntpoint/mp1");
+ok( $result eq 0 );
+
+print "Toggle User & Group quotas on/off\n";
+$result = system(
+"runcon -t test_filesystem_t $filesystem_dir/quotas_test -s $dev -t $basedir/mntpoint/mp1/aquota.user $v"
+);
+ok( $result eq 0 );
+$result = system(
+"runcon -t test_filesystem_t $filesystem_dir/quotas_test -s $dev -t $basedir/mntpoint/mp1/aquota.group $v"
+);
+ok( $result eq 0 );
+
+print "Get statfs(2)\n";
+$result =
+  system(
+"runcon -t test_filesystem_t $filesystem_dir/statfs_test -t $basedir/mntpoint $v"
+  );
+ok( $result eq 0 );
+
+print
+"Creating 'trans_test_file' and checking context changed via type_transition rule\n";
+$result =
+  system(
+"runcon -t test_filesystem_t $filesystem_dir/create_file -f $basedir/mntpoint/mp1/trans_test_file -e test_filesystem_filetranscon_t $v"
+  );
+ok( $result eq 0 );
+
+print "Creating 'test_file' and changing its context via setfilecon(3)\n";
+$result =
+  system(
+"runcon -t test_filesystem_t $filesystem_dir/create_file_change_context -t test_filesystem_filecon_t -f $basedir/mntpoint/mp1/test_file $v"
+  );
+ok( $result eq 0 );
+
+if ($test_name_trans) {
+    print
+"Creating 'name_trans_test_file1' and checking context changed via name-based type_transition rule\n";
+    $result = system(
+"runcon -t test_filesystem_t $filesystem_dir/create_file -f $basedir/mntpoint/mp1/name_trans_test_file1 -e test_filesystem_filenametranscon1_t $v"
+    );
+    ok( $result eq 0 );
+
+    print
+"Creating 'name_trans_test_file2' and checking context changed via name-based type_transition rule\n";
+    $result = system(
+"runcon -t test_filesystem_t $filesystem_dir/create_file -f $basedir/mntpoint/mp1/name_trans_test_file2 -e test_filesystem_filenametranscon2_t $v"
+    );
+    ok( $result eq 0 );
+}
+
+if ($test_watch) {
+    print "fanotify(7) test\n";
+    $result = system(
+"runcon -t test_filesystem_t $filesystem_dir/fanotify_fs $v -t $basedir/mntpoint/mp1"
+    );
+    ok( $result eq 0 );
+}
+
+print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+$result =
+  system(
+"runcon -t test_filesystem_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v"
+  );
+ok( $result eq 0 );
+
+print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+cleanup1( $basedir, $dev );
+
+############### Test Move Mount ##########################
+mk_mntpoint_1("$basedir/mntpoint");
+( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+make_fs( $fs_type, $dev, $basedir );
+$mount_opts2 =
+"quota,usrquota,grpquota,rootcontext=system_u:object_r:test_filesystem_file_t:s0";
+
+print "Mount on $basedir/mntpoint/mp1\n";
+$result = system(
+"runcon -t test_filesystem_t  $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts2 $v"
+);
+ok( $result eq 0 );
+
+mk_mntpoint_2("$basedir/mntpoint");
+
+print "Now move_mount(2) filesystem to $basedir/mntpoint/mp2\n";
+$result = system(
+"runcon -t test_filesystem_t $basedir/move_mount -s $basedir/mntpoint/mp1 -t $basedir/mntpoint/mp2 $v"
+);
+ok( $result eq 0 );
+
+print "Unmount filesystem from $basedir/mntpoint/mp2\n";
+$result =
+  system(
+"runcon -t test_filesystem_t $filesystem_dir/umount -t $basedir/mntpoint/mp2 $v"
+  );
+ok( $result eq 0 );
+
+print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+$result =
+  system(
+"runcon -t test_filesystem_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v"
+  );
+ok( $result eq 0 );
+
+print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+cleanup1( $basedir, $dev );
+
+############### Test Change Mount Options ##########################
+mk_mntpoint_1("$basedir/mntpoint");
+( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+make_fs( $fs_type, $dev, $basedir );
+$mount_opts2 =
+"quota,usrquota,grpquota,rootcontext=system_u:object_r:test_filesystem_file_t:s0";
+
+print "Mount on $basedir/mntpoint/mp1\n";
+$result = system(
+"runcon -t test_filesystem_t  $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts2 $v"
+);
+ok( $result eq 0 );
+
+$change_opts = "rootcontext=system_u:object_r:test_filesystem_file_t:s0";
+print "Now change options with fspick(2)\n";
+$result = system(
+"runcon -t test_filesystem_t $basedir/fspick -t $basedir/mntpoint/mp1 -o $change_opts $v"
+);
+ok( $result eq 0 );
+
+print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+$result =
+  system(
+"runcon -t test_filesystem_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v"
+  );
+ok( $result eq 0 );
+
+print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+cleanup1( $basedir, $dev );
+
+############### Deny filesystem { relabelfrom } ##########################
+# hooks.c may_context_mount_sb_relabel() FILESYSTEM__RELABELFROM
+mk_mntpoint_1("$basedir/mntpoint");
+( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+make_fs( $fs_type, $dev, $basedir );
+$opts_no_relabelfrom =
+  "defcontext=system_u:object_r:test_filesystem_sb_relabel_no_relabelfrom_t:s0";
+
+print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+print "Using mount options:\n\t$opts_no_relabelfrom\n";
+$result = system(
+"runcon -t test_filesystem_sb_relabel_no_relabelfrom_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_relabelfrom $v 2>&1"
+);
+ok( $result >> 8 eq 13 );
+
+print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+cleanup1( $basedir, $dev );
+
+############### Deny filesystem { relabelto } ##########################
+# hooks.c may_context_mount_sb_relabel() FILESYSTEM__RELABELTO
+mk_mntpoint_1("$basedir/mntpoint");
+( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+make_fs( $fs_type, $dev, $basedir );
+$opts_no_relabelto =
+  "fscontext=system_u:object_r:test_filesystem_sb_relabel_no_relabelto_t:s0";
+
+print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+print "Using mount options:\n\t$opts_no_relabelto\n";
+$result = system(
+"runcon -t test_filesystem_sb_relabel_no_relabelto_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_relabelto $v 2>&1"
+);
+ok( $result >> 8 eq 13 );
+
+print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+cleanup1( $basedir, $dev );
+
+############### Deny filesystem { relabelfrom } ##########################
+# hooks.c may_context_mount_inode_relabel() FILESYSTEM__RELABELFROM
+mk_mntpoint_1("$basedir/mntpoint");
+( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+make_fs( $fs_type, $dev, $basedir );
+$opts_no_relabelfrom =
+  "rootcontext=system_u:object_r:test_filesystem_no_inode_no_relabelfrom_t:s0";
+
+print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+print "Using mount options:\n\t$opts_no_relabelfrom\n";
+$result = system(
+"runcon -t test_filesystem_no_inode_no_relabelfrom_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_relabelfrom $v 2>&1"
+);
+ok( $result >> 8 eq 13 );
+
+print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+cleanup1( $basedir, $dev );
+
+############### Deny filesystem { associate } ##########################
+# hooks.c may_context_mount_inode_relabel() FILESYSTEM__ASSOCIATE
+mk_mntpoint_1("$basedir/mntpoint");
+( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+make_fs( $fs_type, $dev, $basedir );
+
+# This defcontext will trigger denial.
+$opts_no_associate =
+"defcontext=system_u:object_r:test_filesystem_inode_relabel_no_associate_t:s0";
+
+print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+print "Using mount options:\n\t$opts_no_associate\n";
+$result = system(
+"runcon -t test_filesystem_inode_relabel_no_associate_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_associate $v 2>&1"
+);
+ok( $result >> 8 eq 13 );
+
+print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+cleanup1( $basedir, $dev );
+
+############### Deny filesystem { associate } ##########################
+# hooks.c may_create() FILESYSTEM__ASSOCIATE
+mk_mntpoint_1("$basedir/mntpoint");
+( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+make_fs( $fs_type, $dev, $basedir );
+
+# Use this fscontext= to get sensible audit log entry of:
+#  "allow unlabeled_t test_filesystem_may_create_no_associate_t:filesystem associate;"
+$opts_no_associate_file =
+  "fscontext=system_u:object_r:test_filesystem_may_create_no_associate_t:s0";
+
+print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+print "Using mount options:\n\t$opts_no_associate_file\n";
+$result = system(
+"runcon -t test_filesystem_may_create_no_associate_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_associate_file $v"
+);
+ok( $result eq 0 );
+
+print "Creating test file $basedir/mntpoint/mp1/test_file\n";
+$result =
+  system(
+"runcon -t test_filesystem_may_create_no_associate_t $filesystem_dir/create_file_change_context -t unconfined_t -f $basedir/mntpoint/mp1/test_file $v 2>&1"
+  );
+ok( $result >> 8 eq 13 );
+
+print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+$result =
+  system(
+"runcon -t test_filesystem_may_create_no_associate_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v"
+  );
+ok( $result eq 0 );
+
+print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+cleanup1( $basedir, $dev );
+
+############### Deny filesystem { quotamod } ##########################
+# hooks.c selinux_quotactl() FILESYSTEM__QUOTAMOD
+mk_mntpoint_1("$basedir/mntpoint");
+( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+make_fs( $fs_type, $dev, $basedir );
+$opts_no_quotamod =
+"quota,usrquota,grpquota,fscontext=system_u:object_r:test_filesystem_no_quotamod_t:s0";
+
+print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+print "Using mount options:\n\t$opts_no_quotamod\n";
+$result = system(
+"runcon -t test_filesystem_no_quotamod_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_quotamod $v 2>&1"
+);
+ok( $result eq 0 );
+
+# No need to run quotacheck(8) as never gets far enough to read quota file
+print "Toggle User & Group quotas on/off\n";
+$result = system(
+"runcon -t test_filesystem_no_quotamod_t $filesystem_dir/quotas_test -s $dev -t $basedir/mntpoint/mp1/aquota.user $v 2>&1"
+);
+ok( $result >> 8 eq 13 );
+
+print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+$result = system(
+"runcon -t test_filesystem_no_quotamod_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v"
+);
+ok( $result eq 0 );
+
+print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+cleanup1( $basedir, $dev );
+
+############### Deny filesystem { quotaget } ##########################
+# hooks.c selinux_quotactl() FILESYSTEM__QUOTAGET
+mk_mntpoint_1("$basedir/mntpoint");
+( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+make_fs( $fs_type, $dev, $basedir );
+$opts_no_quotaget =
+"quota,usrquota,grpquota,context=system_u:object_r:test_filesystem_no_quotaget_t:s0";
+
+print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+print "Using mount options:\n\t$opts_no_quotaget\n";
+$result = system(
+"runcon -t test_filesystem_no_quotaget_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_quotaget $v"
+);
+ok( $result eq 0 );
+
+print "Running quotacheck(8) to init user/group quota files\n";
+$result = system("runcon `id -Z` quotacheck -ugF vfsv0 $basedir/mntpoint/mp1");
+ok( $result eq 0 );
+
+print "Toggle User & Group quotas on/off\n";
+$result = system(
+"runcon -t test_filesystem_no_quotaget_t $filesystem_dir/quotas_test -s $dev -t $basedir/mntpoint/mp1/aquota.user $v 2>&1"
+);
+ok( $result >> 8 eq 13 );
+
+print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+$result = system(
+"runcon -t test_filesystem_no_quotaget_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v"
+);
+ok( $result eq 0 );
+
+print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+cleanup1( $basedir, $dev );
+
+############### Deny file { quotaon } ##########################
+# hooks.c selinux_quota_on() FILE__QUOTAON
+mk_mntpoint_1("$basedir/mntpoint");
+( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+make_fs( $fs_type, $dev, $basedir );
+$opts_no_quotaon =
+  "quota,usrquota,grpquota,context=system_u:object_r:test_file_no_quotaon_t:s0";
+
+print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+print "Using mount options:\n\t$opts_no_quotaon\n";
+$result = system(
+"runcon -t test_file_no_quotaon_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_quotaon $v"
+);
+ok( $result eq 0 );
+
+print "Running quotacheck(8) to init user/group quota files\n";
+$result = system("runcon `id -Z` quotacheck -ugF vfsv0 $basedir/mntpoint/mp1");
+ok( $result eq 0 );
+
+print "Toggle User quotas on/off\n";
+$result = system(
+"runcon -t test_file_no_quotaon_t $filesystem_dir/quotas_test -s $dev -t $basedir/mntpoint/mp1/aquota.user $v 2>&1"
+);
+ok( $result >> 8 eq 13 );
+
+print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+$result = system(
+"runcon -t test_file_no_quotaon_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v"
+);
+ok( $result eq 0 );
+
+print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+cleanup1( $basedir, $dev );
+
+############### Deny filesystem { mount } ##########################
+# hooks.c selinux_sb_kern_mount() FILESYSTEM__MOUNT
+mk_mntpoint_1("$basedir/mntpoint");
+( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+make_fs( $fs_type, $dev, $basedir );
+$opts_no_mount = "rootcontext=system_u:object_r:test_filesystem_no_mount_t:s0";
+
+print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+print "Using mount options:\n\t$opts_no_mount\n";
+$result = system(
+"runcon -t test_filesystem_no_mount_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_mount $v 2>&1"
+);
+ok( $result >> 8 eq 13 );
+
+print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+cleanup1( $basedir, $dev );
+
+############### Deny filesystem { getattr } ##########################
+# hooks.c selinux_sb_statfs() FILESYSTEM__GETATTR
+mk_mntpoint_1("$basedir/mntpoint");
+( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+make_fs( $fs_type, $dev, $basedir );
+$opts_no_getattr =
+  "rootcontext=system_u:object_r:test_filesystem_no_getattr_t:s0";
+
+print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+print "Using mount options:\n\t$opts_no_getattr\n";
+$result = system(
+"runcon -t test_filesystem_no_getattr_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_getattr $v"
+);
+ok( $result eq 0 );
+
+$result = system(
+"runcon -t test_filesystem_no_getattr_t $filesystem_dir/statfs_test -t $basedir/mntpoint $v 2>&1"
+);
+ok( $result >> 8 eq 13 );
+
+print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+$result = system(
+"runcon -t test_filesystem_no_getattr_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v"
+);
+ok( $result eq 0 );
+
+print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+cleanup1( $basedir, $dev );
+
+################ Deny file { mounton } ##########################
+# hooks.c selinux_move_mount() FILE__MOUNTON
+if ($test_move_mount) {
+    mk_mntpoint_1("$basedir/mntpoint");
+    ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+    make_fs( $fs_type, $dev, $basedir );
+    $opts_no_remount =
+      "rootcontext=system_u:object_r:test_move_mount_no_mounton_t:s0";
+
+    print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+    print "Using mount options:\n\t$opts_no_remount\n";
+    $result = system(
+"runcon -t test_move_mount_no_mounton_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_remount $v"
+    );
+    ok( $result eq 0 );
+
+    mk_mntpoint_2("$basedir/mntpoint");
+
+    print "Now move filesystem, should fail\n";
+    $result = system(
+"runcon -t test_move_mount_no_mounton_t $basedir/move_mount -s $basedir/mntpoint/mp2 -t $basedir/mntpoint/mp1 $v 2>&1"
+    );
+    ok( $result >> 8 eq 13 );
+
+    print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+    $result = system(
+"runcon -t test_move_mount_no_mounton_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v"
+    );
+    ok( $result eq 0 );
+
+    print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+    cleanup1( $basedir, $dev );
+}
+
+############### Deny filesystem { unmount } ##########################
+# hooks.c selinux_umount() FILESYSTEM__UNMOUNT
+mk_mntpoint_1("$basedir/mntpoint");
+( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+make_fs( $fs_type, $dev, $basedir );
+$opts_no_unmount =
+  "rootcontext=system_u:object_r:test_filesystem_no_unmount_t:s0";
+
+print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+print "Using mount options:\n\t$opts_no_unmount\n";
+$result = system(
+"runcon -t test_filesystem_no_unmount_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_unmount $v"
+);
+ok( $result eq 0 );
+
+print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+$result = system(
+"runcon -t test_filesystem_no_unmount_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v 2>&1"
+);
+ok( $result >> 8 eq 13 );
+
+# Make sure it does get unmounted
+print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+$result =
+  system(
+"runcon -t test_filesystem_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v"
+  );
+ok( $result eq 0 );
+
+print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+cleanup1( $basedir, $dev );
+
+############### Deny filesystem { associate }  ##########################
+# hooks.c selinux_inode_setxattr() FILESYSTEM__ASSOCIATE
+mk_mntpoint_1("$basedir/mntpoint");
+( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+make_fs( $fs_type, $dev, $basedir );
+$opts_no_associate_xattr =
+"defcontext=system_u:object_r:test_filesystem_inode_setxattr_no_associate_t:s0,fscontext=system_u:object_r:test_filesystem_inode_setxattr_no_associate_t:s0";
+
+print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+print "Using mount options:\n\t$opts_no_associate_xattr\n";
+$result = system(
+"runcon -t test_filesystem_inode_setxattr_no_associate_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_associate_xattr $v"
+);
+ok( $result eq 0 );
+
+print "Creating test file $basedir/mntpoint/mp1/test_file\n";
+$result =
+  system(
+"runcon -t test_filesystem_inode_setxattr_no_associate_t $filesystem_dir/create_file_change_context -t unconfined_t -f $basedir/mntpoint/mp1/test_file $v 2>&1"
+  );
+ok( $result >> 8 eq 13 );
+
+print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+$result =
+  system(
+"runcon -t test_filesystem_inode_setxattr_no_associate_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v"
+  );
+ok( $result eq 0 );
+
+print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+cleanup1( $basedir, $dev );
+
+############### Deny filesystem { watch }  ##########################
+# hooks.c selinux_path_notify() FILESYSTEM__WATCH
+if ($test_watch) {
+    mk_mntpoint_1("$basedir/mntpoint");
+    ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+    make_fs( $fs_type, $dev, $basedir );
+    $opts_no_watch = "context=system_u:object_r:test_filesystem_no_watch_t:s0";
+
+    print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+    print "Using mount options:\n\t$opts_no_watch\n";
+    $result = system(
+"runcon -t test_filesystem_no_watch_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_watch $v"
+    );
+    ok( $result eq 0 );
+
+    print "test_fanotify\n";
+    $result = system(
+"runcon -t test_filesystem_no_watch_t $filesystem_dir/fanotify_fs $v -t $basedir/mntpoint/mp1 2>&1"
+    );
+    ok( $result >> 8 eq 13 );
+
+    print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+    $result = system(
+"runcon -t test_filesystem_no_watch_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v"
+    );
+    ok( $result eq 0 );
+
+    print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+    cleanup1( $basedir, $dev );
+}
+
+##########################################################################
+# context     - Useful when mounting filesystems that do not support extended
+#               attributes.
+#   Tested by - Creating a filesystem that has xattrs set to a different value,
+#               then mount with context= and confirm that the files have that
+#               context as well as any newly created files (even if fscreate
+#               was set to something else), and that setfilecon/setxattr() on
+#               files within the mount fails with errno EOPNOTSUPP.
+##########################################################################
+mk_mntpoint_1("$basedir/mntpoint");
+( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+make_fs( $fs_type, $dev, $basedir );
+
+# Mount with xttrs to create a file with specific context.
+$context1_opts =
+  "defcontext=system_u:object_r:test_filesystem_context_file_t:s0";
+
+print "Testing 'context=' mount option\n";
+print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+print "Using mount options:\n\t$context1_opts\n";
+$result = system(
+"runcon -t test_filesystem_context_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $context1_opts $v"
+);
+ok( $result eq 0 );
+
+# Create file with 'test_filesystem_filecon_t' context
+print "Creating test file $basedir/mntpoint/mp1/test_file\n";
+$result =
+  system(
+"runcon -t test_filesystem_context_t $filesystem_dir/create_file_change_context -t test_filesystem_filecon_t -f $basedir/mntpoint/mp1/test_file $v"
+  );
+ok( $result eq 0 );
+
+print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+$result = system(
+"runcon -t test_filesystem_context_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v"
+);
+ok( $result eq 0 );
+
+# Need to free the loop device, then get new one and attach
+system("losetup -d $dev 2>/dev/null");
+( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+attach_dev( $dev, $basedir );
+
+# Mount again with no xttr support
+$context2_opts = "context=system_u:object_r:test_filesystem_context_file_t:s0";
+print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+print "Using mount options:\n\t$context2_opts\n";
+$result = system(
+"runcon -t test_filesystem_context_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $context2_opts $v"
+);
+ok( $result eq 0 );
+
+# Now check the context on file is system_u:object_r:test_filesystem_context_file_t:s0
+print "Check test file context $basedir/mntpoint/mp1/test_file\n";
+$result =
+  system(
+"runcon -t test_filesystem_context_t $filesystem_dir/check_file_context -f $basedir/mntpoint/mp1/test_file -e system_u:object_r:test_filesystem_context_file_t:s0 $v"
+  );
+ok( $result eq 0 );
+
+# Then create a file with 'test_filesystem_filecon_t' context, this should fail with EOPNOTSUPP
+print "Creating test file $basedir/mntpoint/mp1/test_file\n";
+$result =
+  system(
+"runcon -t test_filesystem_context_t $filesystem_dir/create_file_change_context -t test_filesystem_filecon_t -f $basedir/mntpoint/mp1/test_file $v 2>/dev/null"
+  );
+ok( $result >> 8 eq 95 );
+
+print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+$result =
+  system(
+"runcon -t test_filesystem_context_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v"
+  );
+ok( $result eq 0 );
+
+print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+cleanup1( $basedir, $dev );
+
+##########################################################################
+# rootcontext - Explicitly label the root inode of the filesystem being
+#               mounted before that filesystem or inode becomes visible
+#               to userspace.
+#   Tested by - Set mountpoint to unlabeled_t and then check that the
+#               context of the root directory matches rootcontext= after
+#               the mount operation.
+##########################################################################
+mk_mntpoint_1("$basedir/mntpoint");
+( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+make_fs( $fs_type, $dev, $basedir );
+$root_opts = "rootcontext=system_u:object_r:test_filesystem_context_file_t:s0";
+
+print "Testing 'rootcontext=' mount option\n";
+
+# Reset mountpoint to 'unlabeled_t' so it is different to any other possible test values.
+print "Resetting MP to unlabeled_t $basedir/mntpoint/mp1\n";
+$result =
+  system(
+"runcon -t test_filesystem_context_t $filesystem_dir/check_mount_context -r -m $basedir/mntpoint/mp1 $v"
+  );
+ok( $result eq 0 );
+
+print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+print "Using mount options:\n\t$root_opts\n";
+$result = system(
+"runcon -t test_filesystem_context_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $root_opts $v"
+);
+ok( $result eq 0 );
+
+# Now check the mountpoint is the 'rootcontext=' value
+print "Check MP context $basedir/mntpoint/mp1\n";
+$result =
+  system(
+"runcon -t test_filesystem_context_t $filesystem_dir/check_mount_context -m $basedir/mntpoint/mp1 -e system_u:object_r:test_filesystem_context_file_t:s0 $v"
+  );
+ok( $result eq 0 );
+
+print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+$result = system(
+"runcon -t test_filesystem_context_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v"
+);
+ok( $result eq 0 );
+
+print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+cleanup1( $basedir, $dev );
+
+##########################################################################
+# defcontext  - Set default security context for unlabeled files.
+#               This overrides the value set for unlabeled files in policy
+#               and requires a filesystem that supports xattr labeling.
+#   Tested by - Create filesystem that has files w/o xattrs and then confirm
+#               that they are mapped to the specified defcontext upon mount,
+#               where defcontext differs from the policy default.
+##########################################################################
+mk_mntpoint_1("$basedir/mntpoint");
+( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+make_fs( $fs_type, $dev, $basedir );
+$test_opts = "context=system_u:object_r:test_filesystem_context_file_t:s0";
+
+print "Testing 'defcontext=' mount option\n";
+print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+print "Using mount options:\n\t$test_opts\n";
+$result = system(
+"runcon -t test_filesystem_context_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $test_opts $v"
+);
+ok( $result eq 0 );
+
+# Create file, its context will be system_u:object_r:test_filesystem_context_file_t:s0 from $test_opts
+print "Creating test file $basedir/mntpoint/mp1/test_file\n";
+$result =
+  system(
+"runcon -u system_u -t test_filesystem_fscontext_t $filesystem_dir/create_file -f $basedir/mntpoint/mp1/test_file -e test_filesystem_context_file_t $v"
+  );
+ok( $result eq 0 );
+
+print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+$result = system(
+"runcon -t test_filesystem_context_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v"
+);
+ok( $result eq 0 );
+
+# Need to free the loop device, then get new dev one and attach
+system("losetup -d $dev 2>/dev/null");
+( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+attach_dev( $dev, $basedir );
+
+# Mount again with defcontext=
+$defcontext_opts = "defcontext=system_u:object_r:test_filesystem_filecon_t:s0";
+print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+print "Using mount options:\n\t$defcontext_opts\n";
+$result = system(
+"runcon -t test_filesystem_context_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $defcontext_opts $v"
+);
+ok( $result eq 0 );
+
+# Now check the file context is now system_u:object_r:test_filesystem_filecon_t:s0
+print "Check test file context $basedir/mntpoint/mp1/test_file\n";
+$result =
+  system(
+"runcon -t test_filesystem_context_t $filesystem_dir/check_file_context -f $basedir/mntpoint/mp1/test_file -e system_u:object_r:test_filesystem_filecon_t:s0 $v"
+  );
+ok( $result eq 0 );
+
+print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+$result =
+  system(
+"runcon -t test_filesystem_context_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v"
+  );
+ok( $result eq 0 );
+
+print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+cleanup1( $basedir, $dev );
+
+##########################################################################
+# fscontext   - Sets the overarching filesystem label to a specific security
+#               context. This filesystem label is separate from the individual
+#               labels on the files.
+#   Tested by - Mount a tmpfs (fs_use_trans) filesystem with fscontext= and
+#               then create a file within it, checking its context.
+##########################################################################
+$fs_type = "tmpfs";
+mk_mntpoint_1("$basedir/mntpoint");
+( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+$fscontext_opts =
+"fscontext=system_u:object_r:test_filesystem_fscontext_fs_t:s0,size=10M,mode=0770";
+
+print "Testing 'fscontext=' mount option\n";
+print "Mount tmpfs filesystem on $basedir/mntpoint/mp1\n";
+print "Using mount options:\n\t$fscontext_opts\n";
+$result = system(
+"runcon -t test_filesystem_fscontext_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $fscontext_opts $v"
+);
+ok( $result eq 0 );
+
+print "Creating test file $basedir/mntpoint/mp1/test_file\n";
+$result =
+  system(
+"runcon -t test_filesystem_fscontext_t $filesystem_dir/create_file_change_context -t test_filesystem_filecon_t -f $basedir/mntpoint/mp1/test_file $v"
+  );
+ok( $result eq 0 );
+
+print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+$result =
+  system(
+"runcon -t test_filesystem_fscontext_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v"
+  );
+ok( $result eq 0 );
+
+print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+cleanup1( $basedir, $dev );
+
+reaper( \@device_list, $filesystem_dir, $v );
+
+if ($disable_udisks) {
+    udisks2_restart($udisks2_status);
+}
+
+exit;
-- 
2.24.1

