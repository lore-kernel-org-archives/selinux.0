Return-Path: <SRS0=kuBz=3Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5004EC3524D
	for <selinux@archiver.kernel.org>; Tue,  4 Feb 2020 14:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132072082E
	for <selinux@archiver.kernel.org>; Tue,  4 Feb 2020 14:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="OhIWaqCV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbgBDOhM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Feb 2020 09:37:12 -0500
Received: from mailomta26-re.btinternet.com ([213.120.69.119]:34773 "EHLO
        re-prd-fep-044.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727302AbgBDOhM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Feb 2020 09:37:12 -0500
Received: from re-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.54.8])
          by re-prd-fep-044.btinternet.com with ESMTP
          id <20200204143710.XOEV28737.re-prd-fep-044.btinternet.com@re-prd-rgout-005.btmx-prd.synchronoss.net>;
          Tue, 4 Feb 2020 14:37:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1580827030; 
        bh=gFmcoErQlqEfwFa7rXWrY+qQImlv+K6Vaf7+sqK4eL4=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=OhIWaqCVJ2bLei7S0YRbvKP9mqlwCubgYMQ5//r8yeWpBPctkFj9sGLWGtcgJSieZhHPNeNFKDIplRVDpNkc/1m7azeRRwO9ZHXAp8661gub6l8W07UoLQ6cQ/gIQPTI2aegChPJagNyzVdmQJJylrxbaC/e5a6+udpQBLhlDsy7AuQB5u8pYn7cbDRSglSPIytlZYKq1jK8IUXwKEUmE5YW9oDHtSUef4l+1kdp2wW6ZTkAjcwmkVSVxcIIgcIGF1+vbXsoogygpjyh+MUUNkYpsie73YAPju1NuPjjq/k8Ih9N4EDTBImrfdaiJrVPFae2HED6r/2RwNcjBJ9+Tw==
Authentication-Results: btinternet.com; none
X-Originating-IP: [31.49.56.10]
X-OWM-Source-IP: 31.49.56.10 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrgeelgdeiiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeefuddrgeelrdehiedruddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrgeelrdehiedruddtpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.49.56.10) by re-prd-rgout-005.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5E207A3302CE304E; Tue, 4 Feb 2020 14:37:10 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC PATCH 1/1] selinux-testsuite: Test all mount option context types
Date:   Tue,  4 Feb 2020 14:37:07 +0000
Message-Id: <20200204143707.318337-2-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204143707.318337-1-richard_c_haines@btinternet.com>
References: <20200204143707.318337-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Test supported filesystems for mount options: context, defcontext,
rootcontext and fscontext. The tests use fsconfig(2) and therefore does
not actually mount the filesystem to a target.

All /sbin/mkfs.* entries are read and if supported, tested with each option.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 policy/test_filesystem.te      |  12 +++
 tests/Makefile                 |   2 +-
 tests/filesystem/Filesystem.pm |  19 +++-
 tests/fs_contexts/.gitignore   |   1 +
 tests/fs_contexts/Makefile     |  13 +++
 tests/fs_contexts/fsconfig.c   |  72 ++++++++++++++++
 tests/fs_contexts/test         | 153 +++++++++++++++++++++++++++++++++
 7 files changed, 268 insertions(+), 4 deletions(-)
 create mode 100644 tests/fs_contexts/.gitignore
 create mode 100644 tests/fs_contexts/Makefile
 create mode 100644 tests/fs_contexts/fsconfig.c
 create mode 100755 tests/fs_contexts/test

diff --git a/policy/test_filesystem.te b/policy/test_filesystem.te
index 4ff493a..220f79e 100644
--- a/policy/test_filesystem.te
+++ b/policy/test_filesystem.te
@@ -6,6 +6,9 @@
 attribute filesystemdomain;
 kernel_setsched(filesystemdomain)
 
+# For module filesystems
+kernel_request_load_module(filesystemdomain)
+
 #################### Create test file contexts ######################
 type test_filesystem_filecon_t;
 files_type(test_filesystem_filecon_t)
@@ -58,6 +61,15 @@ type_transition test_filesystem_t test_filesystem_file_t:file test_filesystem_fi
 allow test_filesystem_t test_filesystem_filetranscon_t:file { create getattr open write relabelfrom };
 dontaudit unconfined_t test_filesystem_filetranscon_t:file { getattr read };
 
+#
+# For fs_contexts tests
+#
+allow test_filesystem_t test_filesystem_file_t:filesystem { mount relabelfrom relabelto };
+allow test_filesystem_t unlabeled_t:filesystem { relabelfrom };
+# For fs_context test rootcontext= minix
+allow test_filesystem_file_t unlabeled_t:filesystem { associate };
+allow test_filesystem_t unlabeled_t:filesystem { mount };
+
 #################### Deny filesystem { relabelfrom } ######################
 # hooks.c may_context_mount_sb_relabel() FILESYSTEM__RELABELFROM
 type test_filesystem_sb_relabel_no_relabelfrom_t;
diff --git a/tests/Makefile b/tests/Makefile
index 46a1641..87708fb 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -100,7 +100,7 @@ endif
 
 ifeq ($(shell grep -q filesystem $(POLDEV)/include/support/all_perms.spt && echo true),true)
 ifneq ($(shell ./kvercmp $$(uname -r) 5.2),-1)
-SUBDIRS += fs_filesystem
+SUBDIRS += fs_filesystem fs_contexts
 endif
 endif
 
diff --git a/tests/filesystem/Filesystem.pm b/tests/filesystem/Filesystem.pm
index 3d4194d..680bf0b 100644
--- a/tests/filesystem/Filesystem.pm
+++ b/tests/filesystem/Filesystem.pm
@@ -111,17 +111,30 @@ sub attach_dev {
 
 sub make_fs {
     my ( $mk_type, $mk_dev, $mk_dir ) = @_;
+
+    if ( $mk_type eq "btrfs" or $mk_type eq "reiserfs" ) {
+        $count = "count=27904";
+    }
+    else {
+        $count = "count=4096";
+    }
+
     print "Create $mk_dir/fstest with dd\n";
-    $result = system(
-        "dd if=/dev/zero of=$mk_dir/fstest bs=1024 count=10240 2>/dev/null");
+    $result =
+      system("dd if=/dev/zero of=$mk_dir/fstest bs=4096 $count 2>/dev/null");
     if ( $result != 0 ) {
         print "dd failed to create $mk_dir/fstest\n";
     }
 
     attach_dev( $mk_dev, $mk_dir );
 
+    $opt = " ";
+    if ( $mk_type eq "reiserfs" ) {
+        $opt = "-q";    # Otherwise asks to proceed
+    }
+
     print "Make $mk_type filesystem on $mk_dev\n";
-    $result = system("mkfs.$mk_type -I 256 $mk_dev >& /dev/null");
+    $result = system("mkfs.$mk_type $opt $mk_dev >& /dev/null");
     if ( $result != 0 ) {
         system("losetup -d $mk_dev 2>/dev/null");
         print "mkfs.$mk_type failed to create filesystem on $mk_dev\n";
diff --git a/tests/fs_contexts/.gitignore b/tests/fs_contexts/.gitignore
new file mode 100644
index 0000000..c870437
--- /dev/null
+++ b/tests/fs_contexts/.gitignore
@@ -0,0 +1 @@
+fsconfig
diff --git a/tests/fs_contexts/Makefile b/tests/fs_contexts/Makefile
new file mode 100644
index 0000000..012c4fa
--- /dev/null
+++ b/tests/fs_contexts/Makefile
@@ -0,0 +1,13 @@
+TARGETS = fsconfig
+USE_FS = ../fs_filesystem
+DEPS = $(USE_FS)/fs_common.c $(USE_FS)/fs_common.h
+LDLIBS += -lselinux
+
+all: $(TARGETS)
+	@set -e; for i in $(USE_FS); do $(MAKE) -C $$i all ; done
+
+clean:
+	rm -f $(TARGETS)
+	@set -e; for i in $(USE_FS); do $(MAKE) -C $$i clean ; done
+
+$(TARGETS): $(DEPS)
diff --git a/tests/fs_contexts/fsconfig.c b/tests/fs_contexts/fsconfig.c
new file mode 100644
index 0000000..e4cd8d8
--- /dev/null
+++ b/tests/fs_contexts/fsconfig.c
@@ -0,0 +1,72 @@
+#include "../fs_filesystem/fs_common.h"
+
+static void print_usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s -s src -f fs_type -o options [-v]\n"
+		"Where:\n\t"
+		"-s  Source path\n\t"
+		"-f  Filesystem type\n\t"
+		"-o  Options list (comma separated list)\n\t"
+		"-v  Print information.\n", progname);
+	exit(-1);
+}
+
+int main(int argc, char *argv[])
+{
+	int opt, result, fsfd;
+	char *context, *src = NULL, *opts1, *fs_type = NULL, *opts = NULL;
+	bool verbose = false;
+
+	while ((opt = getopt(argc, argv, "s:f:o:v")) != -1) {
+		switch (opt) {
+		case 's':
+			src = optarg;
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
+	if (!src || !fs_type || !opts)
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
+	fsfd = fsopen(fs_type, 0);
+	if (fsfd < 0) {
+		fprintf(stderr, "Failed fsopen(2): %s\n", strerror(errno));
+		return -1;
+	}
+
+	opts1 = strdup(opts);
+
+	/* fsconfig_opts() will return 0 or errno from fsconfig(2) */
+	result = fsconfig_opts(fsfd, src, NULL, opts, verbose);
+	if (result) {
+		fprintf(stderr, "Failed config_opts\n");
+		return result;
+	}
+	if (verbose)
+		printf("Successfully added options: %s\n", opts1);
+
+	close(fsfd);
+	return 0;
+}
diff --git a/tests/fs_contexts/test b/tests/fs_contexts/test
new file mode 100755
index 0000000..8437dcb
--- /dev/null
+++ b/tests/fs_contexts/test
@@ -0,0 +1,153 @@
+#!/usr/bin/perl
+use Test::More;
+
+my @mkfs_list;
+my @fs_type_list;
+
+BEGIN {
+    $basedir = $0;
+    $basedir =~ s|(.*)/[^/]*|$1|;
+
+    # Load common subroutines.
+    use File::Basename qw(dirname);
+    use Cwd qw(abs_path);
+    use lib dirname( abs_path $0) . '/../filesystem';
+    use Filesystem
+      qw(udisks2_stop udisks2_restart get_loop_dev make_fs mk_mntpoint_1 cleanup1 reaper);
+
+    # Options: -v = Verbose, -e enable udisks(8) daemon
+    $v = " ";
+
+    # MUST stop udisksd(8) as it interferes with creating/deleting
+    # filesystems during these tests
+    $disable_udisks = 1;
+    $udisks2_status = 0;
+    foreach $arg (@ARGV) {
+        if ( $arg eq "-v" ) {
+            $v = $arg;
+        }
+        elsif ( $arg eq "-e" ) {
+            $disable_udisks = 0;
+        }
+    }
+
+    my @mkfs_list = map { chomp; $_ } `find /sbin/mkfs.* -printf "%f\n"`;
+    $i = 0;
+    foreach my $fstype (@mkfs_list) {
+        @split_fn = split( /\./, $fstype );
+        if ( $split_fn[1] eq "cramfs" ) {
+            print "$split_fn[1] - unsupported\n";
+            next;
+        }
+        elsif ($split_fn[1] eq "btrfs"
+            or $split_fn[1] eq "ext2"
+            or $split_fn[1] eq "ext3"
+            or $split_fn[1] eq "ext4"
+            or $split_fn[1] eq "fat"
+            or $split_fn[1] eq "hfsplus"
+            or $split_fn[1] eq "minix"
+            or $split_fn[1] eq "msdos"
+            or $split_fn[1] eq "ntfs"
+            or $split_fn[1] eq "reiserfs"
+            or $split_fn[1] eq "vfat"
+            or $split_fn[1] eq "xfs" )
+        {
+            $fs_type_list[$i] = $split_fn[1];
+            print "$split_fn[1] - supported\n";
+            $i++;
+        }
+    }
+
+    plan tests => ( $i * 4 );
+}
+
+# Keep a list of devices used for removal at end of test.
+$device_count = 0;
+my @device_list;
+
+if ($disable_udisks) {
+    $udisks2_status = udisks2_stop();
+}
+
+$context_opt     = "context=system_u:object_r:test_filesystem_file_t:s0";
+$rootcontext_opt = "rootcontext=system_u:object_r:test_filesystem_file_t:s0";
+$defcontext_opt  = "defcontext=system_u:object_r:test_filesystem_file_t:s0";
+$fscontext_opt   = "fscontext=system_u:object_r:test_filesystem_file_t:s0";
+
+foreach my $fs_type (@fs_type_list) {
+    mk_mntpoint_1("$basedir/mntpoint");
+    ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+    make_fs( $fs_type, $dev, $basedir );
+
+    if ( $fs_type eq "ntfs" ) {
+        $fs_type = "fuseblk";
+    }
+    if ( $fs_type eq "fat" ) {
+        $fs_type = "vfat";
+    }
+
+    # Test context
+    print "Testing context= for $fs_type\n";
+    $result = system(
+"runcon -t test_filesystem_t $basedir/fsconfig $v -f $fs_type -s $dev -o $context_opt 2>&1"
+    );
+    if ( $fs_type eq "fuseblk" ) {    # This is expected to fail
+        ok(1);
+    }
+    else {
+        ok( $result eq 0 );
+    }
+
+    # Test defcontext
+    print "Testing defcontext= for $fs_type\n";
+    $result = system(
+"runcon -t test_filesystem_t $basedir/fsconfig $v -f $fs_type -s $dev -o $defcontext_opt 2>&1"
+    );
+    if (   $fs_type eq "vfat"
+        or $fs_type eq "hfsplus"
+        or $fs_type eq "minix"
+        or $fs_type eq "msdos"
+        or $fs_type eq "fuseblk"
+        or $fs_type eq "reiserfs" )
+    {    # These are expected to fail
+        ok(1);
+    }
+    else {
+        ok( $result eq 0 );
+    }
+
+    # Test rootcontext
+    print "Testing rootcontext= for $fs_type\n";
+    $result = system(
+"runcon -t test_filesystem_t $basedir/fsconfig $v -f $fs_type -s $dev -o $rootcontext_opt 2>&1"
+    );
+    if ( $fs_type eq "fuseblk" ) {    # This is expected to fail
+        ok(1);
+    }
+    else {
+        ok( $result eq 0 );
+    }
+
+    # Test fscontext
+    print "Testing fscontext= for $fs_type\n";
+    $result = system(
+"runcon -t test_filesystem_t $basedir/fsconfig $v -f $fs_type -s $dev -o $fscontext_opt 2>&1"
+    );
+    if ( $fs_type eq "fuseblk" ) {    # This is expected to fail
+        ok(1);
+    }
+    else {
+        ok( $result eq 0 );
+    }
+
+    cleanup1( $basedir, $dev );
+}
+
+cleanup1( $basedir, $dev );
+reaper( \@device_list, $basedir, $v );
+
+if ($disable_udisks) {
+    udisks2_restart($udisks2_status);
+}
+
+exit;
-- 
2.24.1

