Return-Path: <SRS0=XEA0=3T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D9DC2D0DB
	for <selinux@archiver.kernel.org>; Thu, 30 Jan 2020 19:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606FB20658
	for <selinux@archiver.kernel.org>; Thu, 30 Jan 2020 19:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="Bj9p5HD8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbgA3THl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jan 2020 14:07:41 -0500
Received: from mailomta25-re.btinternet.com ([213.120.69.118]:41160 "EHLO
        re-prd-fep-041.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727476AbgA3THl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jan 2020 14:07:41 -0500
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
          by re-prd-fep-041.btinternet.com with ESMTP
          id <20200130190736.HRZJ19270.re-prd-fep-041.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;
          Thu, 30 Jan 2020 19:07:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1580411256; 
        bh=VU7B6I3t3AGkFtRsQy4/zC5Is43RK/Carm++lcSdNd8=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=Bj9p5HD8M6+aLLfWv93UgIbshYbTsZ3EnnKBRcR36ZgwPH+MTyTwv7tyxtUH/xxkBBYMSW635UhoK3ucUGt5cfqzzkq7+YAf+AKsynBkjyMJfMF+BsX5fCR0pJJIWlns2pLD/fgRORciWOhES+KJL6m2D1VLPvWDprZn86KIE/5itRBLEt0upNSYKU3CeV8BRsJ6bnPCQ5CN9Xd9k3Q1DDzpXrqkPQBntcRLheUh5teZm7dxRHcNNmK8cekYTl4Fsj9REMlxpa7en7EEZy9Z02hQ/hczmDgGaJxAmx7hjnGoD8ba8io29mVTMtmb57l6/mt8+CK/cSUtQLr+i3nqvA==
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.134.6.114]
X-OWM-Source-IP: 86.134.6.114 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrfeekgdduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepkeeirddufeegrdeirdduudegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefgedriedruddugedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.6.114) by re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.337) (authenticated as richard_c_haines@btinternet.com)
        id 5DEE078D08AF5F9A; Thu, 30 Jan 2020 19:07:36 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 1/1] selinux-testsuite: Add watch_sb and watch_mount checks
Date:   Thu, 30 Jan 2020 19:07:32 +0000
Message-Id: <20200130190732.110012-2-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200130190732.110012-1-richard_c_haines@btinternet.com>
References: <20200130190732.110012-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Test watch_sb and watch_mount permissions.
The policy is contained in test_filesystem_notify.te as it can then be
built if the policy supports the permissions.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 policy/Makefile                  |  3 ++
 policy/test_filesystem.te        | 15 -------
 policy/test_filesystem_notify.te | 60 ++++++++++++++++++++++++++
 tests/filesystem/Filesystem.pm   |  6 +--
 tests/filesystem/fanotify_fs.c   | 18 ++++++--
 tests/filesystem/test            | 74 ++++++++++++++++++++++++++++++--
 tests/fs_filesystem/test         | 74 ++++++++++++++++++++++++++++++--
 7 files changed, 221 insertions(+), 29 deletions(-)
 create mode 100644 policy/test_filesystem_notify.te

diff --git a/policy/Makefile b/policy/Makefile
index 33378b5..cf8d431 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -118,6 +118,9 @@ ifeq ($(shell grep -q filesystem $(POLDEV)/include/support/all_perms.spt && echo
 TARGETS += test_filesystem.te
 ifeq ($(shell [ $(MOD_POL_VERS) -ge 11 -a $(POL_VERS) -ge 25 ] && echo true),true)
 TARGETS += test_filesystem_name_trans.te
+ifeq ($(shell grep -q all_file_perms.*watch $(POLDEV)/include/support/all_perms.spt && echo true),true)
+TARGETS+= test_filesystem_notify.te
+endif
 endif
 endif
 
diff --git a/policy/test_filesystem.te b/policy/test_filesystem.te
index 4ff493a..09f9d4a 100644
--- a/policy/test_filesystem.te
+++ b/policy/test_filesystem.te
@@ -292,21 +292,6 @@ dontaudit unconfined_t test_filesystem_filecon_t:file { getattr read };
 allow test_filesystem_inode_setxattr_no_associate_t unconfined_t:dir { add_name write };
 allow test_filesystem_inode_setxattr_no_associate_t unconfined_t:file { create relabelfrom relabelto };
 
-#################### Deny filesystem { watch } ######################
-# hooks.c selinux_path_notify() FILESYSTEM__WATCH
-type test_filesystem_no_watch_t;
-domain_type(test_filesystem_no_watch_t)
-unconfined_runs_test(test_filesystem_no_watch_t)
-typeattribute test_filesystem_no_watch_t testdomain;
-typeattribute test_filesystem_no_watch_t filesystemdomain;
-
-allow test_filesystem_no_watch_t self:capability { sys_admin };
-allow test_filesystem_no_watch_t self:filesystem { associate relabelto mount unmount relabelfrom };
-allow test_filesystem_no_watch_t test_file_t:dir { mounton write remove_name rmdir };
-fs_mount_all_fs(test_filesystem_no_watch_t)
-fs_relabelfrom_all_fs(test_filesystem_no_watch_t)
-fs_associate(test_filesystem_no_watch_t)
-
 ################# Test process { setfscreate } #############
 type test_setfscreatecon_t;
 domain_type(test_setfscreatecon_t)
diff --git a/policy/test_filesystem_notify.te b/policy/test_filesystem_notify.te
new file mode 100644
index 0000000..3e8a246
--- /dev/null
+++ b/policy/test_filesystem_notify.te
@@ -0,0 +1,60 @@
+#
+######### Test filesystem fanotify(7) policy module ##########
+#
+
+################# Test all functions ##########################
+# For fanotify tests
+allow test_filesystem_t self:filesystem { watch };
+# Until 'fs_watch_all_fs(test_filesystem_t)' in Policy use:
+gen_require(`
+	type fs_t;
+')
+allow test_filesystem_t fs_t:filesystem { watch };
+allow test_filesystem_t test_filesystem_file_t:dir { watch_sb watch_mount };
+
+#################### Deny filesystem { watch } ######################
+# hooks.c selinux_path_notify() FILESYSTEM__WATCH
+type test_filesystem_no_watch_t;
+domain_type(test_filesystem_no_watch_t)
+unconfined_runs_test(test_filesystem_no_watch_t)
+typeattribute test_filesystem_no_watch_t testdomain;
+typeattribute test_filesystem_no_watch_t filesystemdomain;
+
+allow test_filesystem_no_watch_t self:capability { sys_admin };
+allow test_filesystem_no_watch_t self:filesystem { associate relabelto mount unmount relabelfrom };
+allow test_filesystem_no_watch_t test_file_t:dir { mounton write remove_name rmdir };
+fs_mount_all_fs(test_filesystem_no_watch_t)
+fs_relabelfrom_all_fs(test_filesystem_no_watch_t)
+fs_associate(test_filesystem_no_watch_t)
+
+#################### Deny file { watch_sb } ######################
+# hooks.c selinux_path_notify() FILE__WATCH_SB
+type test_filesystem_no_watch_sb_t;
+domain_type(test_filesystem_no_watch_sb_t)
+unconfined_runs_test(test_filesystem_no_watch_sb_t)
+typeattribute test_filesystem_no_watch_sb_t testdomain;
+typeattribute test_filesystem_no_watch_sb_t filesystemdomain;
+
+allow test_filesystem_no_watch_sb_t self:capability { sys_admin };
+allow test_filesystem_no_watch_sb_t self:filesystem { watch associate relabelto mount unmount relabelfrom };
+allow test_filesystem_no_watch_sb_t test_file_t:dir { mounton write remove_name rmdir };
+
+fs_mount_all_fs(test_filesystem_no_watch_sb_t)
+fs_relabelfrom_all_fs(test_filesystem_no_watch_sb_t)
+fs_associate(test_filesystem_no_watch_sb_t)
+
+#################### Deny file { watch_mount } ######################
+# hooks.c selinux_path_notify() FILE__WATCH_MOUNT
+type test_filesystem_no_watch_mount_t;
+domain_type(test_filesystem_no_watch_mount_t)
+unconfined_runs_test(test_filesystem_no_watch_mount_t)
+typeattribute test_filesystem_no_watch_mount_t testdomain;
+typeattribute test_filesystem_no_watch_mount_t filesystemdomain;
+
+allow test_filesystem_no_watch_mount_t self:capability { sys_admin };
+allow test_filesystem_no_watch_mount_t self:filesystem { watch associate relabelto mount unmount relabelfrom };
+allow test_filesystem_no_watch_mount_t test_file_t:dir { mounton write remove_name rmdir };
+
+fs_mount_all_fs(test_filesystem_no_watch_mount_t)
+fs_relabelfrom_all_fs(test_filesystem_no_watch_mount_t)
+fs_associate(test_filesystem_no_watch_mount_t)
diff --git a/tests/filesystem/Filesystem.pm b/tests/filesystem/Filesystem.pm
index 3d4194d..a08570a 100644
--- a/tests/filesystem/Filesystem.pm
+++ b/tests/filesystem/Filesystem.pm
@@ -8,16 +8,16 @@ sub check_config {
 
     $tst_count = 0;
 
-    # From kernel 5.5 support for fanotify(7) with filesystem { watch }
+    # From kernel 5.4 support for fanotify(7) LSM hooks
     $kvercur = `uname -r`;
     chomp($kvercur);
-    $kverminstream = "5.5";
+    $kverminstream = "5.4";
     $watch         = 0;
 
     $result = `$base/../kvercmp $kvercur $kverminstream`;
     if ( $result > 0 && -e $fanotify_fs ) {
         $watch = 1;
-        $tst_count += 4;
+        $tst_count += 11;
     }
 
     $name_trans        = 0;
diff --git a/tests/filesystem/fanotify_fs.c b/tests/filesystem/fanotify_fs.c
index c525d69..2a8f90e 100644
--- a/tests/filesystem/fanotify_fs.c
+++ b/tests/filesystem/fanotify_fs.c
@@ -11,29 +11,38 @@
 #ifndef FAN_MARK_FILESYSTEM
 #define FAN_MARK_FILESYSTEM	0x00000100
 #endif
+#ifndef FAN_MARK_MOUNT
+#define FAN_MARK_MOUNT		0x00000010
+#endif
 
 static void print_usage(char *progname)
 {
 	fprintf(stderr,
-		"usage:  %s -t path [-v]\n"
+		"usage:  %s -t path [-m] [-v]\n"
 		"Where:\n\t"
 		"-t  Target mount point to mark\n\t"
+		"-m  Set flag to FAN_MARK_MOUNT, default is FAN_MARK_FILESYSTEM\n\t"
 		"-v  Print information.\n", progname);
 	exit(-1);
 }
 
 int main(int argc, char *argv[])
 {
-	int mask = FAN_OPEN, flags = FAN_MARK_ADD | FAN_MARK_FILESYSTEM;
+	int mask = FAN_OPEN, flags;
 	int fd, result, opt, save_err;
 	char *context, *tgt = NULL;
 	bool verbose = false;
 
-	while ((opt = getopt(argc, argv, "t:v")) != -1) {
+	flags = 0;
+
+	while ((opt = getopt(argc, argv, "t:mv")) != -1) {
 		switch (opt) {
 		case 't':
 			tgt = optarg;
 			break;
+		case 'm':
+			flags = FAN_MARK_ADD | FAN_MARK_MOUNT;
+			break;
 		case 'v':
 			verbose = true;
 			break;
@@ -42,6 +51,9 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (!flags)
+		flags = FAN_MARK_ADD | FAN_MARK_FILESYSTEM;
+
 	if (!tgt)
 		print_usage(argv[0]);
 
diff --git a/tests/filesystem/test b/tests/filesystem/test
index 5bdd124..78faf72 100755
--- a/tests/filesystem/test
+++ b/tests/filesystem/test
@@ -148,11 +148,17 @@ if ($test_name_trans) {
 }
 
 if ($test_watch) {
-    print "fanotify(7) test\n";
+    print "fanotify(7) test - FAN_MARK_FILESYSTEM\n";
     $result = system(
 "runcon -t test_filesystem_t $basedir/fanotify_fs $v -t $basedir/mntpoint/mp1"
     );
     ok( $result eq 0 );
+
+    print "fanotify(7) test - FAN_MARK_MOUNT\n";
+    $result = system(
+"runcon -t test_filesystem_t $basedir/fanotify_fs $v -m -t $basedir/mntpoint/mp1"
+    );
+    ok( $result eq 0 );
 }
 
 print "Unmount filesystem from $basedir/mntpoint/mp1\n";
@@ -556,9 +562,9 @@ ok( $result eq 0 );
 print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
 cleanup1( $basedir, $dev );
 
-############### Deny filesystem { watch }  ##########################
-# hooks.c selinux_path_notify() FILESYSTEM__WATCH
 if ($test_watch) {
+    ############### Deny filesystem { watch }  ##########################
+    # hooks.c selinux_path_notify() FILESYSTEM__WATCH
     mk_mntpoint_1($private_path);
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
     make_fs( $fs_type, $dev, $basedir );
@@ -571,7 +577,7 @@ if ($test_watch) {
     );
     ok( $result eq 0 );
 
-    print "test_fanotify\n";
+    print "fanotify(7) test - FAN_MARK_FILESYSTEM\n";
     $result = system(
 "runcon -t test_filesystem_no_watch_t $basedir/fanotify_fs $v -t $basedir/mntpoint/mp1 2>&1"
     );
@@ -585,6 +591,66 @@ if ($test_watch) {
 
     print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
     cleanup1( $basedir, $dev );
+
+    ############### Deny file { watch_sb }  ##########################
+    # hooks.c selinux_path_notify() FILE__WATCH_SB
+    mk_mntpoint_1($private_path);
+    ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+    make_fs( $fs_type, $dev, $basedir );
+    $opts_no_watch_sb =
+      "context=system_u:object_r:test_filesystem_no_watch_sb_t:s0";
+
+    print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+    print "Using mount options:\n\t$opts_no_watch_sb\n";
+    $result = system(
+"runcon -t test_filesystem_no_watch_sb_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_watch_sb $v"
+    );
+    ok( $result eq 0 );
+
+    print "fanotify(7) test - FAN_MARK_FILESYSTEM\n";
+    $result = system(
+"runcon -t test_filesystem_no_watch_sb_t $basedir/fanotify_fs $v -t $basedir/mntpoint/mp1 2>&1"
+    );
+    ok( $result >> 8 eq 13 );
+
+    print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+    $result = system(
+"runcon -t test_filesystem_no_watch_sb_t $basedir/umount -t $basedir/mntpoint/mp1 $v"
+    );
+    ok( $result eq 0 );
+
+    print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+    cleanup1( $basedir, $dev );
+
+    ############### Deny file { watch_mount }  ##########################
+    # hooks.c selinux_path_notify() FILE__WATCH_MOUNT
+    mk_mntpoint_1($private_path);
+    ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+    make_fs( $fs_type, $dev, $basedir );
+    $opts_no_watch_mount =
+      "context=system_u:object_r:test_filesystem_no_watch_mount_t:s0";
+
+    print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+    print "Using mount options:\n\t$opts_no_watch_mount\n";
+    $result = system(
+"runcon -t test_filesystem_no_watch_mount_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_watch_mount $v"
+    );
+    ok( $result eq 0 );
+
+    print "fanotify(7) test - FAN_MARK_MOUNT\n";
+    $result = system(
+"runcon -t test_filesystem_no_watch_mount_t $basedir/fanotify_fs $v -m -t $basedir/mntpoint/mp1 2>&1"
+    );
+    ok( $result >> 8 eq 13 );
+
+    print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+    $result = system(
+"runcon -t test_filesystem_no_watch_mount_t $basedir/umount -t $basedir/mntpoint/mp1 $v"
+    );
+    ok( $result eq 0 );
+
+    print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+    cleanup1( $basedir, $dev );
 }
 
 ##########################################################################
diff --git a/tests/fs_filesystem/test b/tests/fs_filesystem/test
index 4ff352d..0bf9631 100755
--- a/tests/fs_filesystem/test
+++ b/tests/fs_filesystem/test
@@ -118,11 +118,17 @@ if ($test_name_trans) {
 }
 
 if ($test_watch) {
-    print "fanotify(7) test\n";
+    print "fanotify(7) test - FAN_MARK_FILESYSTEM\n";
     $result = system(
 "runcon -t test_filesystem_t $filesystem_dir/fanotify_fs $v -t $basedir/mntpoint/mp1"
     );
     ok( $result eq 0 );
+
+    print "fanotify(7) test - FAN_MARK_MOUNT\n";
+    $result = system(
+"runcon -t test_filesystem_t $filesystem_dir/fanotify_fs $v -m -t $basedir/mntpoint/mp1"
+    );
+    ok( $result eq 0 );
 }
 
 print "Unmount filesystem from $basedir/mntpoint/mp1\n";
@@ -564,9 +570,9 @@ ok( $result eq 0 );
 print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
 cleanup1( $basedir, $dev );
 
-############### Deny filesystem { watch }  ##########################
-# hooks.c selinux_path_notify() FILESYSTEM__WATCH
 if ($test_watch) {
+    ############### Deny filesystem { watch }  ##########################
+    # hooks.c selinux_path_notify() FILESYSTEM__WATCH
     mk_mntpoint_1("$basedir/mntpoint");
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
     make_fs( $fs_type, $dev, $basedir );
@@ -579,7 +585,7 @@ if ($test_watch) {
     );
     ok( $result eq 0 );
 
-    print "test_fanotify\n";
+    print "fanotify(7) test - FAN_MARK_FILESYSTEM\n";
     $result = system(
 "runcon -t test_filesystem_no_watch_t $filesystem_dir/fanotify_fs $v -t $basedir/mntpoint/mp1 2>&1"
     );
@@ -593,6 +599,66 @@ if ($test_watch) {
 
     print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
     cleanup1( $basedir, $dev );
+
+    ############### Deny file { watch_sb }  ##########################
+    # hooks.c selinux_path_notify() FILE__WATCH_SB
+    mk_mntpoint_1("$basedir/mntpoint");
+    ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+    make_fs( $fs_type, $dev, $basedir );
+    $opts_no_watch_sb =
+      "context=system_u:object_r:test_filesystem_no_watch_sb_t:s0";
+
+    print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+    print "Using mount options:\n\t$opts_no_watch_sb\n";
+    $result = system(
+"runcon -t test_filesystem_no_watch_sb_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_watch_sb $v"
+    );
+    ok( $result eq 0 );
+
+    print "fanotify(7) test - FAN_MARK_FILESYSTEM\n";
+    $result = system(
+"runcon -t test_filesystem_no_watch_sb_t $filesystem_dir/fanotify_fs $v -t $basedir/mntpoint/mp1 2>&1"
+    );
+    ok( $result >> 8 eq 13 );
+
+    print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+    $result = system(
+"runcon -t test_filesystem_no_watch_sb_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v"
+    );
+    ok( $result eq 0 );
+
+    print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+    cleanup1( $basedir, $dev );
+
+    ############### Deny file { watch_mount }  ##########################
+    # hooks.c selinux_path_notify() FILE__WATCH_MOUNT
+    mk_mntpoint_1("$basedir/mntpoint");
+    ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+    make_fs( $fs_type, $dev, $basedir );
+    $opts_no_watch_mount =
+      "context=system_u:object_r:test_filesystem_no_watch_mount_t:s0";
+
+    print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+    print "Using mount options:\n\t$opts_no_watch_mount\n";
+    $result = system(
+"runcon -t test_filesystem_no_watch_mount_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_watch_mount $v"
+    );
+    ok( $result eq 0 );
+
+    print "fanotify(7) test - FAN_MARK_MOUNT\n";
+    $result = system(
+"runcon -t test_filesystem_no_watch_mount_t $filesystem_dir/fanotify_fs $v -m -t $basedir/mntpoint/mp1 2>&1"
+    );
+    ok( $result >> 8 eq 13 );
+
+    print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+    $result = system(
+"runcon -t test_filesystem_no_watch_mount_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v"
+    );
+    ok( $result eq 0 );
+
+    print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+    cleanup1( $basedir, $dev );
 }
 
 ##########################################################################
-- 
2.24.1

