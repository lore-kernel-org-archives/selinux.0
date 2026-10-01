Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDB752CCF0
	for <selinux@vger.kernel.org>; Thu,  1 Oct 2026 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868763; cv=none; b=YIDQUgvFmX95nTbHEWeTvoZ3mzM3nhLCA6cAJ0+3t6pYuQ8FRvCbzGF01ijBI56SiRqMzIlixSAfpd7GiGCBj3sqOMw6kGhOyRK9ZgtVgu1quZw1KZ8lb9QyLOAPi7AqMGwGN9qjH3n2y0Nt9uyqCGHFABh4o08eP0rpjvduEc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868763; c=relaxed/simple;
	bh=4LRCxK0zTzuHZbrJdcsrUrjtPVrY4kkgf5pcLfd3DXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r50HtNnxNOzdCS8xBaXwX0pylXklBklKGkHdEYoTjLbUiVKFtMN5WB46MwYP5F4EbSUh+yLGJRW1OlftNzsh1a/D4QDLIbOFeqURh1HM6H9jyYeNtZAlyTJDN3NnyiddIme95Bn/3YCn9YMbSpMuuiweyKMOUIxcwdiUDpq5gW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c4Wbysvk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4Wbysvk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790868760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O2gRipicT1VE6U/+CGPkQmGBPfbUXmnRwTQnn+KF0IE=;
	b=c4Wbysvk4q4dUthOzPzrXxG4eM+qtDzGNC5Sbkqm6V8Bq+Z4zmQeFJVLDC4xMIL22lV+7W
	FG4Bl+7jkV2zm88c48g5glzUxp2fljc7Ic8tnbfRn80w33So+Xns95TwPzGQNAlWx0IRFX
	73eaDSK6fgzo54TVZr0gbQp8uaA6p9M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-91NxPyDTNCOS-iqUMxqzpg-1; Thu,
 01 Oct 2026 11:32:39 -0400
X-MC-Unique: 91NxPyDTNCOS-iqUMxqzpg-1
X-Mimecast-MFC-AGG-ID: 91NxPyDTNCOS-iqUMxqzpg_1790868758
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C3941800767
	for <selinux@vger.kernel.org>; Thu,  1 Oct 2026 15:32:38 +0000 (UTC)
Received: from bgrech-thinkpadp1gen3.rmtustx.csb (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E9C6630000E6;
	Thu,  1 Oct 2026 15:32:37 +0000 (UTC)
From: Brian Grech <bgrech@redhat.com>
To: selinux@vger.kernel.org
Cc: Brian Grech <bgrech@redhat.com>
Subject: [PATCH 3/3] tests/filesystem: probe ext4 quota support before enabling it
Date: Thu,  1 Oct 2026 10:32:12 -0500
Message-ID: <20261001153212.102261-3-bgrech@redhat.com>
In-Reply-To: <20261001153212.102261-1-bgrech@redhat.com>
References: <20261001153212.102261-1-bgrech@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add ext4_native_quota_supported() and legacy_quota_supported() to
Filesystem.pm: instead of inferring quota support from kernel version,
actually create a small loopback ext4 filesystem and try to mount it
(with the native quota feature, and separately via the legacy
quotacheck(8)/quotaon(8) mechanism) to see if the kernel can really
handle it. Use native quota only when supported; fall back to the
legacy path only when that works either; and skip quota testing
entirely (without breaking basic ext4 mount/unmount tests) when neither
mechanism is usable.

The probe uses an isolated tempdir under /tmp rather than the ext4
test's own $basedir: per-filesystem test directories (tests/filesystem/
ext4, .../jfs, etc.) are symlinks back to tests/filesystem itself, so
writing probe files into $basedir would share state with every other
filesystem test, and incomplete cleanup (a stuck loop device or mount)
could corrupt whichever filesystem test runs next in SUBDIRS order.

Assisted-by: Claude Code:claude-sonnet-5
Signed-off-by: Brian Grech <bgrech@redhat.com>
---
 tests/filesystem/Filesystem.pm | 58 ++++++++++++++++++++++++++++++++--
 tests/filesystem/test          | 42 +++++++++++++++++-------
 tests/fs_filesystem/test       | 42 +++++++++++++++++-------
 3 files changed, 118 insertions(+), 24 deletions(-)

diff --git a/tests/filesystem/Filesystem.pm b/tests/filesystem/Filesystem.pm
index ff6daec..04babba 100644
--- a/tests/filesystem/Filesystem.pm
+++ b/tests/filesystem/Filesystem.pm
@@ -1,7 +1,61 @@
 package Filesystem;
-use Exporter qw(import);
+use Exporter   qw(import);
+use File::Temp qw(tempdir);
 our @EXPORT_OK =
-  qw(check_config udisks2_stop udisks2_restart get_loop_dev attach_dev make_fs mk_mntpoint_1 mk_mntpoint_2 cleanup cleanup1 reaper nfs_gen_opts);
+  qw(check_config udisks2_stop udisks2_restart get_loop_dev attach_dev make_fs mk_mntpoint_1 mk_mntpoint_2 cleanup cleanup1 reaper nfs_gen_opts ext4_native_quota_supported legacy_quota_supported);
+
+# EXT4 native quota (-O quota) is a RO_COMPAT feature: any kernel that
+# doesn't support it (e.g. built without CONFIG_QUOTA) will refuse to
+# mount *any* filesystem carrying that feature bit, not just quota-using
+# ones. Probe it directly instead of relying on kernel version alone, so
+# a single unmountable feature flag can't take down the whole test.
+#
+# Use an isolated tempdir under /tmp rather than the caller's $basedir:
+# per-filesystem test directories (tests/filesystem/ext4, .../jfs, etc.)
+# are symlinks back to tests/filesystem itself, so writing probe files
+# into $basedir would pollute the directory every other filesystem test
+# shares, and any incomplete cleanup here (a stuck loop device or mount)
+# could corrupt whichever filesystem test runs next.
+sub ext4_native_quota_supported {
+    my $dir = tempdir( "ext4_quota_probe.XXXXXX", TMPDIR => 1, CLEANUP => 1 );
+    my $img = "$dir/probe.img";
+    my $mnt = "$dir/probe.mnt";
+
+    system("dd if=/dev/zero of=$img bs=1M count=8 status=none 2>/dev/null");
+    system("mkfs.ext4 -q -F -O quota $img >/dev/null 2>&1");
+    mkdir($mnt);
+    my $rc = system("mount -o loop $img $mnt >/dev/null 2>&1");
+    system("umount $mnt >/dev/null 2>&1") if $rc == 0;
+
+    return $rc == 0 ? 1 : 0;
+}
+
+# The legacy quota mechanism (external vfsv0 quota files, activated via
+# quotacheck(8) + quotaon(8)) needs a registered kernel quota format
+# (CONFIG_QFMT_V1/V2) just as much as native quota does - it is not a
+# fallback that works whenever native quota doesn't. Probe it the same
+# way, so callers can tell "use legacy" apart from "no quota mechanism
+# is usable at all on this kernel". Uses an isolated tempdir for the same
+# reason as ext4_native_quota_supported().
+sub legacy_quota_supported {
+    my $dir = tempdir( "ext4_quota_probe.XXXXXX", TMPDIR => 1, CLEANUP => 1 );
+    my $img = "$dir/probe.img";
+    my $mnt = "$dir/probe.mnt";
+
+    system("dd if=/dev/zero of=$img bs=1M count=8 status=none 2>/dev/null");
+    system("mkfs.ext4 -q -F $img >/dev/null 2>&1");
+    mkdir($mnt);
+    my $rc =
+      system("mount -o loop,usrquota,grpquota $img $mnt >/dev/null 2>&1");
+    if ( $rc == 0 ) {
+        system("quotacheck -ugF vfsv0 $mnt >/dev/null 2>&1");
+        $rc = system("quotaon -ug $mnt >/dev/null 2>&1");
+        system("quotaoff -ug $mnt >/dev/null 2>&1") if $rc == 0;
+    }
+    system("umount $mnt >/dev/null 2>&1");
+
+    return $rc == 0 ? 1 : 0;
+}
 
 sub check_config {
     my ( $base, $fanotify_fs, $nfs_enabled, $vfat_enabled ) = @_;
diff --git a/tests/filesystem/test b/tests/filesystem/test
index 56f116a..b7bcb8a 100755
--- a/tests/filesystem/test
+++ b/tests/filesystem/test
@@ -12,7 +12,7 @@ BEGIN {
 }
 use lib $basedir;
 use Filesystem
-  qw(check_config udisks2_stop udisks2_restart get_loop_dev attach_dev make_fs mk_mntpoint_1 mk_mntpoint_2 cleanup cleanup1 reaper nfs_gen_opts);
+  qw(check_config udisks2_stop udisks2_restart get_loop_dev attach_dev make_fs mk_mntpoint_1 mk_mntpoint_2 cleanup cleanup1 reaper nfs_gen_opts ext4_native_quota_supported legacy_quota_supported);
 
 BEGIN {
     # extract fs_type
@@ -20,14 +20,15 @@ BEGIN {
     $fs_type   = $test_name ne "filesystem" ? $test_name : " ";
 
     # Options: -v Verbose, -e enable udisks(8) daemon, -f filesystem type
-    $v              = " ";
-    $disable_udisks = 1;
-    $udisks2_status = 0;
-    $quota_checks   = 1;
-    $nfs_enabled    = 0;
-    $vfat_enabled   = 0;
-    $ext4_quota     = 0;
-    $make_fs_opts   = "";
+    $v                      = " ";
+    $disable_udisks         = 1;
+    $udisks2_status         = 0;
+    $quota_checks           = 1;
+    $nfs_enabled            = 0;
+    $vfat_enabled           = 0;
+    $ext4_quota             = 0;
+    $ext4_quota_unsupported = 0;
+    $make_fs_opts           = "";
 
     $i = 0;
     foreach $arg (@ARGV) {
@@ -64,13 +65,26 @@ BEGIN {
     }
     elsif ( $fs_type eq "ext4" ) {
 
-        # EXT4 has native quota support since kernel 3.6
+        # EXT4 has native quota support since kernel 3.6, but some kernels
+        # (e.g. built without CONFIG_QUOTA) can't mount a filesystem with
+        # the quota feature at all, which would break every ext4 mount in
+        # this script since mkfs always sets the feature. Probe it.
         $kvercur = `uname -r`;
         chomp($kvercur);
-        if ( `$basedir/../kvercmp $kvercur 3.6` >= 1 ) {
+        if ( `$basedir/../kvercmp $kvercur 3.6` >= 1
+            && ext4_native_quota_supported() )
+        {
             $ext4_quota   = 1;
             $make_fs_opts = "-O quota";
         }
+        elsif ( not legacy_quota_supported() ) {
+
+            # Neither native nor legacy ext4 quota mechanisms work on this
+            # kernel (e.g. no quota format registered at all). Don't fall
+            # into the legacy quotacheck(8)/quotaon(8) path - it needs the
+            # same missing kernel support and is guaranteed to fail too.
+            $ext4_quota_unsupported = 1;
+        }
     }
     elsif ( $fs_type eq "vfat" ) {
         $vfat_enabled = 1;
@@ -95,6 +109,12 @@ BEGIN {
         $test_count   = 55;
         $quota_checks = 0;
     }
+
+    # No quota mechanism at all is usable on this kernel for ext4
+    elsif ( $fs_type eq "ext4" and $ext4_quota_unsupported ) {
+        $test_count   = 55;
+        $quota_checks = 0;
+    }
     else {
         $test_count = 69;
     }
diff --git a/tests/fs_filesystem/test b/tests/fs_filesystem/test
index 1d04bbc..1e640fd 100755
--- a/tests/fs_filesystem/test
+++ b/tests/fs_filesystem/test
@@ -15,7 +15,7 @@ BEGIN {
 }
 use lib $filesystem_dir;
 use Filesystem
-  qw(check_config udisks2_stop udisks2_restart get_loop_dev attach_dev make_fs mk_mntpoint_1 mk_mntpoint_2 cleanup cleanup1 reaper nfs_gen_opts);
+  qw(check_config udisks2_stop udisks2_restart get_loop_dev attach_dev make_fs mk_mntpoint_1 mk_mntpoint_2 cleanup cleanup1 reaper nfs_gen_opts ext4_native_quota_supported legacy_quota_supported);
 
 BEGIN {
     # extract fs_type
@@ -23,14 +23,15 @@ BEGIN {
     $fs_type   = $test_name ne "fs_filesystem" ? $test_name : " ";
 
     # Options: -v = Verbose, -e enable udisks(8) daemon, -f filesystem type
-    $v              = " ";
-    $disable_udisks = 1;
-    $udisks2_status = 0;
-    $quota_checks   = 1;
-    $nfs_enabled    = 0;
-    $vfat_enabled   = 0;
-    $ext4_quota     = 0;
-    $make_fs_opts   = "";
+    $v                      = " ";
+    $disable_udisks         = 1;
+    $udisks2_status         = 0;
+    $quota_checks           = 1;
+    $nfs_enabled            = 0;
+    $vfat_enabled           = 0;
+    $ext4_quota             = 0;
+    $ext4_quota_unsupported = 0;
+    $make_fs_opts           = "";
 
     $i = 0;
     foreach $arg (@ARGV) {
@@ -67,13 +68,26 @@ BEGIN {
     }
     elsif ( $fs_type eq "ext4" ) {
 
-        # EXT4 has native quota support since kernel 3.6
+        # EXT4 has native quota support since kernel 3.6, but some kernels
+        # (e.g. built without CONFIG_QUOTA) can't mount a filesystem with
+        # the quota feature at all, which would break every ext4 mount in
+        # this script since mkfs always sets the feature. Probe it.
         $kvercur = `uname -r`;
         chomp($kvercur);
-        if ( `$basedir/../kvercmp $kvercur 3.6` >= 1 ) {
+        if ( `$basedir/../kvercmp $kvercur 3.6` >= 1
+            && ext4_native_quota_supported() )
+        {
             $ext4_quota   = 1;
             $make_fs_opts = "-O quota";
         }
+        elsif ( not legacy_quota_supported() ) {
+
+            # Neither native nor legacy ext4 quota mechanisms work on this
+            # kernel (e.g. no quota format registered at all). Don't fall
+            # into the legacy quotacheck(8)/quotaon(8) path - it needs the
+            # same missing kernel support and is guaranteed to fail too.
+            $ext4_quota_unsupported = 1;
+        }
     }
     elsif ( $fs_type eq "vfat" ) {
         $vfat_enabled = 1;
@@ -98,6 +112,12 @@ BEGIN {
         $test_count   = 54;
         $quota_checks = 0;
     }
+
+    # No quota mechanism at all is usable on this kernel for ext4
+    elsif ( $fs_type eq "ext4" and $ext4_quota_unsupported ) {
+        $test_count   = 54;
+        $quota_checks = 0;
+    }
     else {
         $test_count = 68;
     }
-- 
2.55.0

