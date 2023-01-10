Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726AEC46467
	for <selinux@archiver.kernel.org>; Tue, 10 Jan 2023 13:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238767AbjAJN6J (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Jan 2023 08:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238388AbjAJN51 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Jan 2023 08:57:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACCA81D71
        for <selinux@vger.kernel.org>; Tue, 10 Jan 2023 05:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673358918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HNgh6ar4djnkNyfSh7oCdvOOo2oTOFQSgV7gAuox79M=;
        b=izKwDGXwCHRZSpnnlP3d1+mzO4maF09dkUG6sAqpuPaix+YjayHMbwuhAm1Gc6Gn9yw8TQ
        5Grj7XSIimBBB9hgzKwvaph32x5t0r7NfOJgG7XLuZi98yVClt3OQXeW7YCVEA/8CtoNx7
        qQvJ7y2Zz6xwzInkSAm9oxjGveKKs44=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-119-lKvGghM_NH6_vBMkfGWg_g-1; Tue, 10 Jan 2023 08:55:17 -0500
X-MC-Unique: lKvGghM_NH6_vBMkfGWg_g-1
Received: by mail-ej1-f71.google.com with SMTP id dr5-20020a170907720500b00808d17c4f27so7730966ejc.6
        for <selinux@vger.kernel.org>; Tue, 10 Jan 2023 05:55:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HNgh6ar4djnkNyfSh7oCdvOOo2oTOFQSgV7gAuox79M=;
        b=x/lxEixhMsGvEV3+FiPxkDM4I3pprfqRmEPsEk1ztxTwLj+mi2cg7tQUm63Kw5rdJr
         vezPGLgPTe6EMgigYD+7zn0ggkeG/Ux/epO0yu7sXWYb9sTcgDtFE+QQphe4YLH/1NwS
         Q/CLYgKVMYzvbTgBPEkGhck1PyKgjjbTc+XpQE8QbMjB0mTf3Oh2GPvDxGOxezWlYX3y
         Sh8RMKHODuz/40FBe8ToWoPGPaMLmrDs2FA+rEU/aVPihim0q0QmPYddytQUvA6pVHoN
         9sEK2diUV4EWOmi6JuPYJoGD+aEooOsqhGKmkOAudZuxzTrrZqLUonwHFs5e8iIRtM0/
         gEng==
X-Gm-Message-State: AFqh2kocGGpk8dxkhkfkBViUKgU/eL19ARgiX5VB4sI15RpJ5OPg+nBF
        XB5VY1pi2ZfxfHHJxXi2313lZNxLj9U/STEJF4kXtCxLsvAYef3diq+lLsczUJvuifSVPdSs9gu
        CEPuhJMBUuziEC1ah+jetxEYDQoqc9BlV03lQQm6aZmhOwxT/GNv4va9hrTBSKuesHv+swg==
X-Received: by 2002:a17:907:a585:b0:7b4:edca:739 with SMTP id vs5-20020a170907a58500b007b4edca0739mr53385148ejc.5.1673358915451;
        Tue, 10 Jan 2023 05:55:15 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuUu2+OEkIBc9vTZQeTln2l4uJWZndRFBC7D6fOKmpvzUPlqoZl6JjrTad/y2MTlY8EPN/jRg==
X-Received: by 2002:a17:907:a585:b0:7b4:edca:739 with SMTP id vs5-20020a170907a58500b007b4edca0739mr53385116ejc.5.1673358914711;
        Tue, 10 Jan 2023 05:55:14 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:2e8:ec99:5760:fb52])
        by smtp.gmail.com with ESMTPSA id 22-20020a170906311600b0082535e2da13sm4930508ejx.6.2023.01.10.05.55.13
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 05:55:14 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] tests/filesystem: use native quota support for ext4
Date:   Tue, 10 Jan 2023 14:55:13 +0100
Message-Id: <20230110135513.56005-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use of external quota files is now deprecated for ext4 in favor of
native quota support, which can be enabled by passing -O quota to
mkfs.ext4 when creating the filesystem.

To accommodate to that, modify the [fs_]filesystem tests such that the
native quota support is used on kernels that support it (3.6+ according
to kernel's git history).

The EXT4 native quota support is similar to the XFS one in that it
doesn't require calling quotacheck(8) and the quota support is turned on
implicitly when the filesystem is mounted. However, contrary to XFS it
doesn't use special quota commands. This means that a new helper program
is needed to test the quota operations (neither quotas_test nor
xfs_quotas_test can be reused).

Fixes issue #83.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/filesystem/.gitignore           |  1 +
 tests/filesystem/Filesystem.pm        |  4 +-
 tests/filesystem/Makefile             |  2 +-
 tests/filesystem/native_quotas_test.c | 94 +++++++++++++++++++++++++++
 tests/filesystem/test                 | 86 ++++++++++++++++--------
 tests/fs_filesystem/test              | 88 +++++++++++++++++--------
 6 files changed, 217 insertions(+), 58 deletions(-)
 create mode 100644 tests/filesystem/native_quotas_test.c

diff --git a/tests/filesystem/.gitignore b/tests/filesystem/.gitignore
index e76fcd3..9d5d6b2 100644
--- a/tests/filesystem/.gitignore
+++ b/tests/filesystem/.gitignore
@@ -10,3 +10,4 @@ check_mount_context
 create_file
 grim_reaper
 xfs_quotas_test
+native_quotas_test
diff --git a/tests/filesystem/Filesystem.pm b/tests/filesystem/Filesystem.pm
index bd91a11..1a67a90 100644
--- a/tests/filesystem/Filesystem.pm
+++ b/tests/filesystem/Filesystem.pm
@@ -121,7 +121,7 @@ sub attach_dev {
 }
 
 sub make_fs {
-    my ( $mk_type, $mk_dev, $mk_dir ) = @_;
+    my ( $mk_type, $mk_dev, $mk_dir, $mk_opts ) = @_;
     my $mk_size = 16;
     if ( $mk_type eq "xfs" ) {
         $mk_size = 300;
@@ -137,7 +137,7 @@ sub make_fs {
     attach_dev( $mk_dev, $mk_dir );
 
     print "Make $mk_type filesystem on $mk_dev\n";
-    $result = system("yes | mkfs.$mk_type $mk_dev > /dev/null 2>&1");
+    $result = system("yes | mkfs.$mk_type $mk_opts $mk_dev > /dev/null 2>&1");
     if ( $result != 0 ) {
         system("losetup -d $mk_dev 2>/dev/null");
         print "mkfs.$mk_type failed to create filesystem on $mk_dev\n";
diff --git a/tests/filesystem/Makefile b/tests/filesystem/Makefile
index a863ea2..5172696 100644
--- a/tests/filesystem/Makefile
+++ b/tests/filesystem/Makefile
@@ -3,7 +3,7 @@
 
 TARGETS = mount umount quotas_test statfs_test create_file_change_context \
 fs_relabel check_file_context grim_reaper check_mount_context create_file \
-xfs_quotas_test
+xfs_quotas_test native_quotas_test
 
 LDLIBS += -lselinux
 
diff --git a/tests/filesystem/native_quotas_test.c b/tests/filesystem/native_quotas_test.c
new file mode 100644
index 0000000..4ecfd2a
--- /dev/null
+++ b/tests/filesystem/native_quotas_test.c
@@ -0,0 +1,94 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <sys/quota.h>
+#include <xfs/xqm.h>
+#include <selinux/selinux.h>
+
+static void print_usage(char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s -s src [-v]\n"
+		"Where:\n\t"
+		"-s  Source\n\t"
+		"-v  Print information.\n", progname);
+	exit(-1);
+}
+
+int main(int argc, char *argv[])
+{
+	int opt, result, qcmd, save_err;
+	char *context, *src = NULL;
+	bool verbose = false;
+	uint32_t fmtval;
+
+	while ((opt = getopt(argc, argv, "s:v")) != -1) {
+		switch (opt) {
+		case 's':
+			src = optarg;
+			break;
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			print_usage(argv[0]);
+		}
+	}
+
+	if (!src)
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
+	/* This requires FILESYSTEM__QUOTAGET */
+	qcmd = QCMD(Q_GETFMT, USRQUOTA);
+	result = quotactl(qcmd, src, 0, (void *)&fmtval);
+	save_err = errno;
+	if (result < 0) {
+		fprintf(stderr, "quotactl(Q_GETFMT, USRQUOTA) Failed: %s\n",
+			strerror(errno));
+		return save_err;
+	}
+	if (verbose)
+		printf("User Format: 0x%x\n", fmtval);
+
+	/*
+	 * The filesystem will be set up with quota on, therefore need to
+	 * turn off then on.
+	 * These require FILESYSTEM__QUOTAMOD
+	 */
+	qcmd = QCMD(Q_QUOTAOFF, USRQUOTA);
+	result = quotactl(qcmd, src, 0, NULL);
+	save_err = errno;
+	if (result < 0) {
+		fprintf(stderr, "quotactl(Q_QUOTAOFF, USRQUOTA) Failed: %s\n",
+			strerror(errno));
+		return save_err;
+	}
+	if (verbose)
+		printf("User Quota - OFF\n");
+
+	qcmd = QCMD(Q_QUOTAON, USRQUOTA);
+	result = quotactl(qcmd, src, 0, NULL);
+	save_err = errno;
+	if (result < 0) {
+		fprintf(stderr, "quotactl(Q_QUOTAON, USRQUOTA) Failed: %s\n",
+			strerror(errno));
+		return save_err;
+	}
+	if (verbose)
+		printf("User Quota - ON\n");
+
+	return 0;
+}
diff --git a/tests/filesystem/test b/tests/filesystem/test
index b050997..a7d8b24 100755
--- a/tests/filesystem/test
+++ b/tests/filesystem/test
@@ -26,6 +26,8 @@ BEGIN {
     $quota_checks   = 1;
     $nfs_enabled    = 0;
     $vfat_enabled   = 0;
+    $ext4_quota     = 0;
+    $make_fs_opts   = "";
 
     $i = 0;
     foreach $arg (@ARGV) {
@@ -60,13 +62,22 @@ BEGIN {
           nfs_gen_opts( $fs_type, $basedir, "filesystem" );
         $nfs_enabled = 1;
     }
+    elsif ( $fs_type eq "ext4" ) {
+
+        # EXT4 has native quota support since kernel 3.6
+        $kvercur = `uname -r`;
+        chomp($kvercur);
+        if ( `$basedir/../kvercmp $kvercur 3.6` >= 1 ) {
+            $ext4_quota   = 1;
+            $make_fs_opts = "-O quota";
+        }
+    }
     elsif ( $fs_type eq "vfat" ) {
         $vfat_enabled = 1;
     }
 
-    # XFS supports quotas internally and therefore does not require calling
-    # security_quota_on().
-    if ( $fs_type eq "xfs" ) {
+    # XFS and EXT4 support quotas internally and require special tests.
+    if ( $fs_type eq "xfs" or ( $fs_type eq "ext4" and $ext4_quota ) ) {
         $test_count   = 62;
         $quota_checks = 1;
     }
@@ -173,7 +184,7 @@ if ($nfs_enabled) {
 }
 else {
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
+    make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
 
     # For XFS quota tests.
     if ( $fs_type eq "xfs" ) {
@@ -209,6 +220,13 @@ if ($quota_checks) {
             "runcon -t test_filesystem_t $basedir/xfs_quotas_test $v -s $dev");
         ok( $result eq 0 );
     }
+    elsif ( $fs_type eq "ext4" and $ext4_quota ) {
+        print "# EXT4 quota test\n";
+        $result = system(
+            "runcon -t test_filesystem_t $basedir/native_quotas_test $v -s $dev"
+        );
+        ok( $result eq 0 );
+    }
     else {
         print "Running quotacheck(8) to init user/group quota files\n";
 
@@ -299,7 +317,7 @@ if ($nfs_enabled) {
 }
 else {
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
+    make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
     $mount_opts = "rootcontext=system_u:object_r:test_filesystem_file_t:s0";
 }
 
@@ -355,7 +373,7 @@ if ( ( $nfs_enabled and $seclabel_type ne 0 ) or not $nfs_enabled ) {
     }
     else {
         ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-        make_fs( $fs_type, $dev, $basedir );
+        make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
         $mount_opts =
 "rootcontext=system_u:object_r:test_filesystem_sb_relabel_no_relabelfrom_t:s0";
     }
@@ -384,7 +402,7 @@ if ( ( $nfs_enabled and $seclabel_type eq 1 ) or not $nfs_enabled ) {
     }
     else {
         ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-        make_fs( $fs_type, $dev, $basedir );
+        make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
         $mount_opts =
 "fscontext=system_u:object_r:test_filesystem_sb_relabel_no_relabelto_t:s0";
     }
@@ -413,7 +431,7 @@ if ( ( $nfs_enabled and $seclabel_type ne 0 ) or not $nfs_enabled ) {
     }
     else {
         ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-        make_fs( $fs_type, $dev, $basedir );
+        make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
         $mount_opts =
 "rootcontext=system_u:object_r:test_filesystem_no_inode_no_relabelfrom_t:s0";
     }
@@ -437,7 +455,7 @@ if ( not $nfs_enabled ) {
     mk_mntpoint_1($private_path);
 
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
+    make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
     $mount_opts =
 "rootcontext=system_u:object_r:test_filesystem_inode_relabel_no_associate_t:s0";
 
@@ -460,7 +478,7 @@ if ( not $nfs_enabled ) {
 if ( not $nfs_enabled and not $vfat_enabled ) {
     mk_mntpoint_1($private_path);
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
+    make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
 
 # Use this fscontext= to get sensible audit log entry of:
 #  "allow unlabeled_t test_filesystem_may_create_no_associate_t:filesystem associate;"
@@ -496,7 +514,7 @@ if ($quota_checks) {
     #
     mk_mntpoint_1($private_path);
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
+    make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
 
     if ( $fs_type eq "xfs" ) {
         $opts_no_quotamod =
@@ -521,6 +539,13 @@ if ($quota_checks) {
         );
         ok( $result >> 8 eq 13 );
     }
+    elsif ( $fs_type eq "ext4" and $ext4_quota ) {
+        print "Toggle User quota on/off\n";
+        $result = system(
+"runcon -t test_filesystem_no_quotamod_t $basedir/native_quotas_test $v -s $dev 2>&1"
+        );
+        ok( $result >> 8 eq 13 );
+    }
     else {
       # No need to run quotacheck(8) as never gets far enough to read quota file
         print "Toggle User & Group quotas on/off\n";
@@ -544,7 +569,7 @@ if ($quota_checks) {
     #
     mk_mntpoint_1($private_path);
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
+    make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
 
     if ( $fs_type eq "xfs" ) {
         $opts_no_quotaget =
@@ -569,6 +594,13 @@ if ($quota_checks) {
         );
         ok( $result >> 8 eq 13 );
     }
+    elsif ( $fs_type eq "ext4" and $ext4_quota ) {
+        print "Toggle User quota on/off\n";
+        $result = system(
+"runcon -t test_filesystem_no_quotaget_t $basedir/native_quotas_test $v -s $dev 2>&1"
+        );
+        ok( $result >> 8 eq 13 );
+    }
     else {
         print "Running quotacheck(8) to init user/group quota files\n";
         $result =
@@ -593,12 +625,12 @@ if ($quota_checks) {
 
     ############### Deny file { quotaon } ##########################
     # hooks.c selinux_quota_on() FILE__QUOTAON
-    # XFS does not require this test
+    # XFS and EXT4 do not require this test
     #
-    if ( not $fs_type eq "xfs" ) {
+    if ( $fs_type ne "xfs" and ( $fs_type ne "ext4" or not $ext4_quota ) ) {
         mk_mntpoint_1($private_path);
         ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-        make_fs( $fs_type, $dev, $basedir );
+        make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
 
         $opts_no_quotaon =
 "quota,usrquota,grpquota,context=system_u:object_r:test_file_no_quotaon_t:s0";
@@ -641,7 +673,7 @@ if ($nfs_enabled) {
 }
 else {
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
+    make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
     $mount_opts = "rootcontext=system_u:object_r:test_filesystem_no_mount_t:s0";
 }
 
@@ -664,7 +696,7 @@ if ($nfs_enabled) {
 }
 else {
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
+    make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
     $mount_opts =
       "rootcontext=system_u:object_r:test_filesystem_no_getattr_t:s0";
 }
@@ -699,7 +731,7 @@ if ($nfs_enabled) {
 }
 else {
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
+    make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
     $mount_opts =
       "rootcontext=system_u:object_r:test_filesystem_no_remount_t:s0";
 }
@@ -735,7 +767,7 @@ if ($nfs_enabled) {
 }
 else {
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
+    make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
     $mount_opts =
       "rootcontext=system_u:object_r:test_filesystem_no_unmount_t:s0";
 }
@@ -771,7 +803,7 @@ cleanup1( $basedir, $dev );
 if ( not $nfs_enabled and not $vfat_enabled ) {
     mk_mntpoint_1($private_path);
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
+    make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
     $mount_opts =
 "rootcontext=system_u:object_r:test_filesystem_inode_setxattr_no_associate_t:s0,fscontext=system_u:object_r:test_filesystem_inode_setxattr_no_associate_t:s0";
 
@@ -807,7 +839,7 @@ if ($test_watch) {
     }
     else {
         ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-        make_fs( $fs_type, $dev, $basedir );
+        make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
         $mount_opts = "context=system_u:object_r:test_filesystem_no_watch_t:s0";
     }
 
@@ -842,7 +874,7 @@ if ($test_watch) {
     }
     else {
         ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-        make_fs( $fs_type, $dev, $basedir );
+        make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
         $mount_opts =
           "context=system_u:object_r:test_filesystem_no_watch_sb_t:s0";
     }
@@ -878,7 +910,7 @@ if ($test_watch) {
     }
     else {
         ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-        make_fs( $fs_type, $dev, $basedir );
+        make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
         $mount_opts =
           "context=system_u:object_r:test_filesystem_no_watch_mount_t:s0";
     }
@@ -918,7 +950,7 @@ if ($nfs_enabled) {
 }
 else {
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
+    make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
     $mount_opts = "rootcontext=system_u:object_r:test_filesystem_file_t:s0";
     $mount_inval_opts = "fscontext=system_u:object_r:test_filesystem_file_t:s0";
 
@@ -964,7 +996,7 @@ if ( not $nfs_enabled ) {
     ##########################################################################
     mk_mntpoint_1($private_path);
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
+    make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
 
     # Mount with xttrs to create a file with specific context.
     $context1_opts =
@@ -1048,7 +1080,7 @@ if ( not $nfs_enabled ) {
     ##########################################################################
     mk_mntpoint_1($private_path);
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
+    make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
     $root_opts =
       "rootcontext=system_u:object_r:test_filesystem_context_file_t:s0";
 
@@ -1098,7 +1130,7 @@ if ( not $nfs_enabled ) {
         #######################################################################
         mk_mntpoint_1($private_path);
         ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-        make_fs( $fs_type, $dev, $basedir );
+        make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
         $test_opts =
           "context=system_u:object_r:test_filesystem_context_file_t:s0";
 
diff --git a/tests/fs_filesystem/test b/tests/fs_filesystem/test
index 68f2346..9af8971 100755
--- a/tests/fs_filesystem/test
+++ b/tests/fs_filesystem/test
@@ -29,6 +29,8 @@ BEGIN {
     $quota_checks   = 1;
     $nfs_enabled    = 0;
     $vfat_enabled   = 0;
+    $ext4_quota     = 0;
+    $make_fs_opts   = "";
 
     $i = 0;
     foreach $arg (@ARGV) {
@@ -63,13 +65,22 @@ BEGIN {
           nfs_gen_opts( $fs_type, $basedir, "fs_filesystem" );
         $nfs_enabled = 1;
     }
+    elsif ( $fs_type eq "ext4" ) {
+
+        # EXT4 has native quota support since kernel 3.6
+        $kvercur = `uname -r`;
+        chomp($kvercur);
+        if ( `$basedir/../kvercmp $kvercur 3.6` >= 1 ) {
+            $ext4_quota   = 1;
+            $make_fs_opts = "-O quota";
+        }
+    }
     elsif ( $fs_type eq "vfat" ) {
         $vfat_enabled = 1;
     }
 
-    # XFS supports quotas internally and therefore does not require calling
-    # security_quota_on().
-    if ( $fs_type eq "xfs" ) {
+    # XFS and EXT4 support quotas internally and require special tests.
+    if ( $fs_type eq "xfs" or ( $fs_type eq "ext4" and $ext4_quota ) ) {
         $test_count   = 61;
         $quota_checks = 1;
     }
@@ -176,7 +187,7 @@ if ($nfs_enabled) {
 }
 else {
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
+    make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
 
     # For XFS quota tests.
     if ( $fs_type eq "xfs" ) {
@@ -208,6 +219,13 @@ if ($quota_checks) {
         );
         ok( $result eq 0 );
     }
+    elsif ( $fs_type eq "ext4" and $ext4_quota ) {
+        print "# EXT4 quota test\n";
+        $result = system(
+"runcon -t test_filesystem_t $filesystem_dir/native_quotas_test $v -s $dev"
+        );
+        ok( $result eq 0 );
+    }
     else {
         print "Running quotacheck(8) to init user/group quota files\n";
 
@@ -301,7 +319,7 @@ if ($nfs_enabled) {
 }
 else {
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
+    make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
     $mount_opts = "rootcontext=system_u:object_r:test_filesystem_file_t:s0";
 }
 
@@ -344,7 +362,7 @@ if ($nfs_enabled) {
 }
 else {
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
+    make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
     $mount_opts = "rootcontext=system_u:object_r:test_filesystem_file_t:s0";
 }
 
@@ -387,7 +405,7 @@ if ( ( $nfs_enabled and $seclabel_type ne 0 ) or not $nfs_enabled ) {
     }
     else {
         ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-        make_fs( $fs_type, $dev, $basedir );
+        make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
         $mount_opts =
 "rootcontext=system_u:object_r:test_filesystem_sb_relabel_no_relabelfrom_t:s0";
     }
@@ -415,7 +433,7 @@ if ( ( $nfs_enabled and $seclabel_type eq 1 ) or not $nfs_enabled ) {
     }
     else {
         ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-        make_fs( $fs_type, $dev, $basedir );
+        make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
         $mount_opts =
 "fscontext=system_u:object_r:test_filesystem_sb_relabel_no_relabelto_t:s0";
     }
@@ -443,7 +461,7 @@ if ( ( $nfs_enabled and $seclabel_type ne 0 ) or not $nfs_enabled ) {
     }
     else {
         ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-        make_fs( $fs_type, $dev, $basedir );
+        make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
         $mount_opts =
 "rootcontext=system_u:object_r:test_filesystem_no_inode_no_relabelfrom_t:s0";
     }
@@ -466,7 +484,7 @@ if ( not $nfs_enabled ) {
     mk_mntpoint_1($private_path);
 
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
+    make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
     $mount_opts =
 "rootcontext=system_u:object_r:test_filesystem_inode_relabel_no_associate_t:s0";
 
@@ -488,7 +506,7 @@ if ( not $nfs_enabled ) {
 if ( not $nfs_enabled and not $vfat_enabled ) {
     mk_mntpoint_1($private_path);
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
+    make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
 
 # Use this fscontext= to get sensible audit log entry of:
 #  "allow unlabeled_t test_filesystem_may_create_no_associate_t:filesystem associate;"
@@ -524,7 +542,7 @@ if ($quota_checks) {
     #
     mk_mntpoint_1($private_path);
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
+    make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
 
     if ( $fs_type eq "xfs" ) {
         $opts_no_quotamod =
@@ -549,6 +567,13 @@ if ($quota_checks) {
         );
         ok( $result >> 8 eq 13 );
     }
+    elsif ( $fs_type eq "ext4" and $ext4_quota ) {
+        print "Toggle User quota on/off\n";
+        $result = system(
+"runcon -t test_filesystem_no_quotamod_t $filesystem_dir/native_quotas_test $v -s $dev 2>&1"
+        );
+        ok( $result >> 8 eq 13 );
+    }
     else {
       # No need to run quotacheck(8) as never gets far enough to read quota file
         print "Toggle User & Group quotas on/off\n";
@@ -572,7 +597,7 @@ if ($quota_checks) {
     #
     mk_mntpoint_1($private_path);
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
+    make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
 
     if ( $fs_type eq "xfs" ) {
         $opts_no_quotaget =
@@ -597,6 +622,13 @@ if ($quota_checks) {
         );
         ok( $result >> 8 eq 13 );
     }
+    elsif ( $fs_type eq "ext4" and $ext4_quota ) {
+        print "Toggle User quota on/off\n";
+        $result = system(
+"runcon -t test_filesystem_no_quotaget_t $filesystem_dir/native_quotas_test $v -s $dev 2>&1"
+        );
+        ok( $result >> 8 eq 13 );
+    }
     else {
         print "Running quotacheck(8) to init user/group quota files\n";
         $result =
@@ -621,12 +653,12 @@ if ($quota_checks) {
 
     ############### Deny file { quotaon } ##########################
     # hooks.c selinux_quota_on() FILE__QUOTAON
-    # XFS does not require this test
+    # XFS and EXT4 do not require this test
     #
-    if ( not $fs_type eq "xfs" ) {
+    if ( $fs_type ne "xfs" and ( $fs_type ne "ext4" or not $ext4_quota ) ) {
         mk_mntpoint_1($private_path);
         ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-        make_fs( $fs_type, $dev, $basedir );
+        make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
 
         $opts_no_quotaon =
 "quota,usrquota,grpquota,context=system_u:object_r:test_file_no_quotaon_t:s0";
@@ -668,7 +700,7 @@ if ($nfs_enabled) {
 }
 else {
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
+    make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
     $mount_opts = "rootcontext=system_u:object_r:test_filesystem_no_mount_t:s0";
 }
 
@@ -691,7 +723,7 @@ if ($nfs_enabled) {
 }
 else {
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
+    make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
     $mount_opts =
       "rootcontext=system_u:object_r:test_filesystem_no_getattr_t:s0";
 }
@@ -726,7 +758,7 @@ if ($nfs_enabled) {
 }
 else {
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
+    make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
     $mount_opts =
       "rootcontext=system_u:object_r:test_move_mount_no_mounton_t:s0";
 }
@@ -765,7 +797,7 @@ if ($nfs_enabled) {
 }
 else {
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
+    make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
     $mount_opts =
       "rootcontext=system_u:object_r:test_filesystem_no_unmount_t:s0";
 }
@@ -801,7 +833,7 @@ cleanup1( $basedir, $dev );
 if ( not $nfs_enabled and not $vfat_enabled ) {
     mk_mntpoint_1($private_path);
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
+    make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
     $mount_opts =
 "rootcontext=system_u:object_r:test_filesystem_inode_setxattr_no_associate_t:s0,fscontext=system_u:object_r:test_filesystem_inode_setxattr_no_associate_t:s0";
 
@@ -837,7 +869,7 @@ if ($test_watch) {
     }
     else {
         ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-        make_fs( $fs_type, $dev, $basedir );
+        make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
         $mount_opts = "context=system_u:object_r:test_filesystem_no_watch_t:s0";
     }
 
@@ -872,7 +904,7 @@ if ($test_watch) {
     }
     else {
         ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-        make_fs( $fs_type, $dev, $basedir );
+        make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
         $mount_opts =
           "context=system_u:object_r:test_filesystem_no_watch_sb_t:s0";
     }
@@ -908,7 +940,7 @@ if ($test_watch) {
     }
     else {
         ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-        make_fs( $fs_type, $dev, $basedir );
+        make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
         $mount_opts =
           "context=system_u:object_r:test_filesystem_no_watch_mount_t:s0";
     }
@@ -948,7 +980,7 @@ if ($nfs_enabled) {
 }
 else {
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
+    make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
     $mount_opts = "rootcontext=system_u:object_r:test_filesystem_file_t:s0";
     $mount_inval_opts = "fscontext=system_u:object_r:test_filesystem_file_t:s0";
 
@@ -993,7 +1025,7 @@ if ( not $nfs_enabled ) {
     ##########################################################################
     mk_mntpoint_1($private_path);
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
+    make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
 
     # Mount with xttrs to create a file with specific context.
     $context1_opts =
@@ -1077,7 +1109,7 @@ if ( not $nfs_enabled ) {
     ##########################################################################
     mk_mntpoint_1($private_path);
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
+    make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
     $root_opts =
       "rootcontext=system_u:object_r:test_filesystem_context_file_t:s0";
 
@@ -1127,7 +1159,7 @@ if ( not $nfs_enabled ) {
         #######################################################################
         mk_mntpoint_1($private_path);
         ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-        make_fs( $fs_type, $dev, $basedir );
+        make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
         $test_opts =
           "context=system_u:object_r:test_filesystem_context_file_t:s0";
 
-- 
2.39.0

