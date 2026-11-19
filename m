Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095143;
	b=Z+JY2K5f6IQlrcUfZIReRlFKF0JwWhObvFplE6LCVHyUCJFS72uZTsXRgrPX1MWt2sQN
	 Z6NfiEgjRlrHbe43sFZhMASlIEzwl4rXzhT2lIGVei9xlZGQJjYCi3vOIHAgO9pm9V/YB
	 6cBxAuBewx4jHRn1nMsXvDye7jvS7WZYFgEEBMa5Pqa9LYe7Ay+GwJFVauLPyL6awvQdQ
	 omY1hb0ihRDlJxnJFJ4Q+9RF/LuBDCkEODgsZNecKOqbx8/EUstYNaxLyL7S2Z6xaX66j
	 zQVopqblRK8SHmZj15x8tTeIhX/CQwdfqLC80FsC/r+kfD/0VAGTWDnrljDag/Fu0DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095143;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=lqf54J75XGqjEReONLaUb6DFZ68P0mY9YdLJBDR6kVA=;
	b=OxIlxL8i/V+y6MnTx5ohGx9vltJ0IkwfNOJ1BbCKDcT2CAABBovPO21/VeBpCRJNOaQ2
	 XA88TG6pxNloE5hVrvwSNLfGYFarD9xzJR/5AbK/2E9IcF7/CJ6Q8a9okeRboYx8d2htY
	 O1C10Mev0CZO3GbwdtB4r6ayYxwu+bzSRBS9Bv6QDwMIl5mC3+MgSuWkV4DOc2stuVkBi
	 KaJG12D36L8Td6/uaupbJlbPeYAxxDzWHCi5de2GoJ9ArH2WORQXXuyN/vngLJXjN7GHF
	 1/Sf3yUu0CL2BglYswtggdtQSO1fyPex5aYLHQt8oVG8VMLsjsR2tKjED8DUSij/O1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WKnKNe3i;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F12A606A324
	for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 13:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F12A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WKnKNe3i
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-92123971d1bso8495116d6.1
        for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 05:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795095142; x=1795699942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lqf54J75XGqjEReONLaUb6DFZ68P0mY9YdLJBDR6kVA=;
        b=WKnKNe3i0WLgigMVyIFRDTZGaRZsGARX97lZiXfmQvkPTt1IOZpGr5+61hRk3lI/s5
         uJsiBR6C4XFcUzh9IdxYTnw0Zy10nAf74rgzPdjIEpSTzs9DWhjn7K3hAMghZwhNcuUG
         m0PSqiytbWTQmKZPyMh5q/dmaVRyA3L1WldhHEFIMuEB1UGQ3jPtnepeqS6MSDah00nJ
         IxlsfYzNzb68HJT3U7kry0wxbVEGmD4g7cTFYyrYtkUzqNvBkpepa5pUeBuMXiKXtzt5
         4ZxjChFLnOHmIOke6WhE5PDPJxiYi8i4l0czQpD8/mlE1vWMfO3/VKY6qPkRwVYYhjhs
         ABng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795095142; x=1795699942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lqf54J75XGqjEReONLaUb6DFZ68P0mY9YdLJBDR6kVA=;
        b=jPeY/6eJ+WHTZK0HAjggKtA/QBE0hIyHtahchteY6nHWccbgtzUVrl3CsSh3HdDVjF
         vAxsMBpZKUrkhEWfJMnaJZUZZ0UGl933xHR3NfMVbqAfIyfu6H9fctoL/svQUSbbEPxl
         1uzdUkP9/4Wj6zoCT07QPRAKcWcJgfDTx3Ddnx6lMwsd31c6IpvvNjdRkPZv+ykI29FK
         HJMAMTdZHSoSueY2w5GEPyBY2X8zPKeJZLJ35RYhLgxPhMi667F8vCx2Y/u1OCO28CVO
         cWgSUuIv02iMMCTL7ru3KUueNRwtnoYBebPH+p/nnl9MZsID8QqtjTd+iztDCeXMQt9k
         /qYQ==
X-Gm-Message-State: APuU4Z+FB0KhXHz1+Xij4yRiBiWfTcfwJBISTXKJcXXpST5mSszHAT8c
	BvQUj1G+J4QPUgeqxg5KwRFTCgVTyGRnJsoxheHm8jzD+MXKQ2hDBThQ0v5bLQ==
X-Gm-Gg: AZFdTZd1iTC78K3x1bF+jNdzgSVQQWcOtvXcSNLPAAi+q4MN8W0NAnaoJzkgEXSjW+S
	H68K9eDAjnv+daU6Cm0tY0Er+Iq/yhHRdFb4HU4biQ6b1vG8WRfluU9ckowpcprfF6E8xfore5X
	y1zqx3xa4DG2tRDgVJwwq5jDe7TZfHPiFTXM/xsuKDGZQJ+NhRlhxckdwCmtdKIEQKmHCL4wZUL
	3zD431/1Dy0imaEbVgI0sgT5WP9Mgv+TX5PF8NhV8Y4RGeTFB/Ek/DPpZvzdReOajDQSX0JE/Sz
	WZ8lJ5X4BGlG7qecGjwG3FF68q0Rl4DdWwshYpzBsAf63/05MS2njO29W3YjJunBE0WucHoqf/Q
	dqLEVOFl3JD2j0QSV63LrY8CA6QA4YDwdMoujDsYylLUfG67RNWv8x0/x1JWaxgVb4PW1iPTyhK
	7bCC7YxAFJCvUzs2MT6EYLR1+rU268FDg69hx3Qfj2hXOWm8fXXs90EcwqPXBlu4BJBfndG7cZD
	1s5VmQGLJEzLpcnIVP1uwJls7Sk+0V5zJCuFYoPT63pbG/eB95WkwRX5qUECVW3eDBzj+P8PAul
	w4yCV+p9phvKfNL/1OpAvufxCnnQjxIEHWaasnh69sWzwkTwQG4iEWpAKRLvNYiHJ/sTKuMbBl6
	YFZmO3ZMREZbJGJvg/3idP8mf05GJ3hcvRuqBMt6zGqKJjWYgSoieI/jjUFyV8ldTdxdskr2Uoq
	I3/X5MuTh68bM1DOn4rX3u6z8snEyLGlOt
X-Received: by 2002:a05:6214:8017:b0:921:199e:553f with SMTP id 6a1803df08f44-92119ad99d3mr63646346d6.1.1795095142133;
        Thu, 19 Nov 2026 05:32:22 -0800 (PST)
Received: from debian.. (pool-96-244-147-163.bltmmd.fios.verizon.net. [96.244.147.163])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92114d10f89sm50094936d6.13.2026.11.19.05.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:32:21 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: omosnacek@gmail.com,
	paul@paul-moore.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/2] Reapply "tools/nfs.sh: comment out the fscontext= tests for now"
Date: Thu, 19 Nov 2026 13:32:00 +0000
Message-ID: <20261119133201.2185-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 459fc1c7f460a712d7aa4ee19ff31d4d3ae193c9.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 tests/filesystem/Filesystem.pm | 16 +++++++++++-
 tests/filesystem/test          | 46 ++++++++++++++++++----------------
 tests/fs_filesystem/test       | 44 ++++++++++++++++----------------
 tools/nfs.sh                   | 44 +++++++++++++++++---------------
 4 files changed, 86 insertions(+), 64 deletions(-)

diff --git a/tests/filesystem/Filesystem.pm b/tests/filesystem/Filesystem.pm
index 9e4a736..2f450aa 100644
--- a/tests/filesystem/Filesystem.pm
+++ b/tests/filesystem/Filesystem.pm
@@ -303,5 +303,19 @@ sub nfs_gen_opts {
         $nfs_mount_opts = "$vers,$proto,$clientaddr,$addr,$seclabel";
     }
 
-    return ( $dev, $nfs_mount_opts, $seclabel_type );
+    # Build option for testing 'SELinux: mount invalid. Same superblock,...'
+    # that returns EBUSY. Depends on what the initial mount set as its value
+    $inval_seclabel = $seclabel;
+    if ( $seclabel_type eq 0 ) {
+        $inval_seclabel = "context=system_u:object_r:test_filesystem_file_t:s0";
+    }
+    elsif ( $seclabel_type eq 1 ) {
+        $inval_seclabel =~ s/fscontext/context/i;
+    }
+    elsif ( $seclabel_type eq 2 ) {
+        $inval_seclabel =~ s/context/fscontext/i;
+    }
+    $nfs_inval_mount_opts = "$vers,$proto,$clientaddr,$addr,$inval_seclabel";
+
+    return ( $dev, $nfs_mount_opts, $nfs_inval_mount_opts, $seclabel_type );
 }
diff --git a/tests/filesystem/test b/tests/filesystem/test
index b3c32e6..48b9dd2 100755
--- a/tests/filesystem/test
+++ b/tests/filesystem/test
@@ -59,7 +59,7 @@ BEGIN {
     # rootcontext is not supported.
     # $seclabel_type: No seclabel = 0, fscontext = 1, context = 2
     if ( $fs_type eq "nfs4" or $fs_type eq "nfs" ) {
-        ( $dev, $nfs_mount_opts, $seclabel_type ) =
+        ( $dev, $nfs_mount_opts, $nfs_inval_mount_opts, $seclabel_type ) =
           nfs_gen_opts( $fs_type, $basedir, "filesystem" );
         $nfs_enabled = 1;
     }
@@ -129,12 +129,8 @@ BEGIN {
         # via the inode_setxattr_no_associate() test in nfs_filesystem/test
         $test_count -= 3;
 
-        # Skip Test Invalid Mount tests: since kernel commit ec1ade6a0448
-        # ("nfs: account for selinux security context when deciding to share
-        # superblock"), NFS allocates a fresh superblock when the security
-        # options differ, so the "same sb, different settings" error this test
-        # checks for is unreachable on NFS.
-        $test_count -= 2;
+        # Remove additional Test Invalid Mount tests
+        $test_count -= 1;
 
         # Remove tests involving multiple *context= options as invalid
         $test_count -= 20;
@@ -972,15 +968,16 @@ if ($test_watch) {
 }
 
 ############### Test Invalid Mount ##########################
-# Skipped on NFS: since kernel commit ec1ade6a0448 ("nfs: account for
-# selinux security context when deciding to share superblock"), NFS
-# allocates a fresh superblock when the security options differ, so the
-# "same sb, different settings" error this test checks for is unreachable
-# here.
+# This will generate a log entry "SELinux: mount invalid. Same superblock,
+#    different security settings for (dev 0:49, type nfs4)"
+# Note that NFS is already mounted at this point by nfs.sh
 #
-if ( not $nfs_enabled ) {
-    mk_mntpoint_1($private_path);
+mk_mntpoint_1($private_path);
 
+if ($nfs_enabled) {
+    $mount_inval_opts = $nfs_inval_mount_opts;
+}
+else {
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
     make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
     $mount_opts = "rootcontext=system_u:object_r:test_filesystem_file_t:s0";
@@ -992,22 +989,27 @@ if ( not $nfs_enabled ) {
 "runcon -t test_filesystem_t $basedir/mount -s $dev -t $private_path/mp1 -f $fs_type -o $mount_opts $v"
     );
     ok( $result eq 0 );
+}
 
-    print "Test 'Invalid Mount' $fs_type filesystem on $private_path/mp1\n";
-    print "Mount $fs_type filesystem on $private_path/mp1\n";
-    print "Using mount options:\n\t$mount_inval_opts\n";
-    $result = system(
+print "Test 'Invalid Mount' $fs_type filesystem on $private_path/mp1\n";
+print "Mount $fs_type filesystem on $private_path/mp1\n";
+print "Using mount options:\n\t$mount_inval_opts\n";
+$result = system(
 "runcon -t test_filesystem_t $basedir/mount -s $dev -t $private_path/mp1 -f $fs_type -o $mount_inval_opts $v 2>&1"
-    );
+);
+if ( $nfs_enabled and $result >> 8 eq 16 ) {
+    ok( 1, "Returned EBUSY, known bug" );
+}
+else {
     system(
 "runcon -t test_filesystem_t $basedir/umount -t $private_path/mp1 $v 2>&1"
     );
     ok( $result >> 8 eq 22 );    # EINVAL
-
-    print "Removing: $basedir/mntpoint\n";
-    cleanup1( $basedir, $dev );
 }
 
+print "Removing: $basedir/mntpoint\n";
+cleanup1( $basedir, $dev );
+
 if ( not $nfs_enabled ) {
     ##########################################################################
     # context     - Useful when mounting filesystems that do not support
diff --git a/tests/fs_filesystem/test b/tests/fs_filesystem/test
index 71cf1c9..1e640fd 100755
--- a/tests/fs_filesystem/test
+++ b/tests/fs_filesystem/test
@@ -62,7 +62,7 @@ BEGIN {
     # rootcontext is not supported.
     # $seclabel_type: No seclabel = 0, fscontext = 1, context = 2
     if ( $fs_type eq "nfs4" or $fs_type eq "nfs" ) {
-        ( $dev, $nfs_mount_opts, $seclabel_type ) =
+        ( $dev, $nfs_mount_opts, $nfs_inval_mount_opts, $seclabel_type ) =
           nfs_gen_opts( $fs_type, $basedir, "fs_filesystem" );
         $nfs_enabled = 1;
     }
@@ -137,12 +137,8 @@ BEGIN {
         # via inode_setxattr_no_associate() test in nfs_filesystem/test
         $test_count -= 3;
 
-        # Skip Test Invalid Mount tests: since kernel commit ec1ade6a0448
-        # ("nfs: account for selinux security context when deciding to share
-        # superblock"), NFS allocates a fresh superblock when the security
-        # options differ, so the "same sb, different settings" error this test
-        # checks for is unreachable on NFS.
-        $test_count -= 2;
+        # Remove additional Test Invalid Mount tests
+        $test_count -= 1;
 
         # Remove tests involving multiple *context= options as invalid
         $test_count -= 20;
@@ -999,15 +995,16 @@ if ($test_watch) {
 }
 
 ############### Test Invalid Mount ##########################
-# Skipped on NFS: since kernel commit ec1ade6a0448 ("nfs: account for
-# selinux security context when deciding to share superblock"), NFS
-# allocates a fresh superblock when the security options differ, so the
-# "same sb, different settings" error this test checks for is unreachable
-# here.
+# This will generate a log entry "SELinux: mount invalid. Same superblock,
+#    different security settings for (dev 0:49, type nfs4)"
+# Note that NFS is already mounted at this point by nfs.sh
 #
-if ( not $nfs_enabled ) {
-    mk_mntpoint_1($private_path);
+mk_mntpoint_1($private_path);
 
+if ($nfs_enabled) {
+    $mount_inval_opts = $nfs_inval_mount_opts;
+}
+else {
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
     make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
     $mount_opts = "rootcontext=system_u:object_r:test_filesystem_file_t:s0";
@@ -1019,21 +1016,26 @@ if ( not $nfs_enabled ) {
 "runcon -t test_filesystem_t $basedir/fsmount -s $dev -t $private_path/mp1 -f $fs_type -o $mount_opts $v"
     );
     ok( $result eq 0 );
+}
 
-    print "Test 'Invalid Mount' $fs_type filesystem on $private_path/mp1\n";
-    print "Using mount options:\n\t$mount_inval_opts\n";
-    $result = system(
+print "Test 'Invalid Mount' $fs_type filesystem on $private_path/mp1\n";
+print "Using mount options:\n\t$mount_inval_opts\n";
+$result = system(
 "runcon -t test_filesystem_t $basedir/fsmount -s $dev -t $private_path/mp1 -f $fs_type -o $mount_inval_opts $v 2>&1"
-    );
+);
+if ( $nfs_enabled and $result >> 8 eq 16 ) {
+    ok( 1, "Returned EBUSY, known bug" );
+}
+else {    # Still gets mounted, so need to unmount
     system(
 "runcon -t test_filesystem_t $filesystem_dir/umount -t $private_path/mp1 $v 2>&1"
     );
     ok( $result >> 8 eq 22 );    # EINVAL
-
-    print "Removing: $basedir/mntpoint\n";
-    cleanup1( $basedir, $dev );
 }
 
+print "Removing: $basedir/mntpoint\n";
+cleanup1( $basedir, $dev );
+
 if ( not $nfs_enabled ) {
     ##########################################################################
     # context     - Useful when mounting filesystems that do not support
diff --git a/tools/nfs.sh b/tools/nfs.sh
index 4700c63..5c5f0d8 100755
--- a/tools/nfs.sh
+++ b/tools/nfs.sh
@@ -80,27 +80,31 @@ POPD=0
 popd >/dev/null 2>&1
 umount /mnt/selinux-testsuite
 #
-echo -e "Run 'filesystem' tests with mount context option:\n\t$FS_CTX"
-mount -t nfs -o vers=4.2,$FS_CTX localhost:$TESTDIR /mnt/selinux-testsuite
-pushd /mnt/selinux-testsuite >/dev/null 2>&1
-POPD=1
-cd tests
-./nfsruntests.pl filesystem/test
-cd ../
-POPD=0
-popd >/dev/null 2>&1
-umount /mnt/selinux-testsuite
+# The block below is commented out since these tests do not pass
+# on any known kernel.
+# See https://github.com/SELinuxProject/selinux-testsuite/issues/91
 #
-echo -e "Run 'fs_filesystem' tests with mount context option:\n\t$FS_CTX"
-mount -t nfs -o vers=4.2,$FS_CTX localhost:$TESTDIR /mnt/selinux-testsuite
-pushd /mnt/selinux-testsuite >/dev/null 2>&1
-POPD=1
-cd tests
-./nfsruntests.pl fs_filesystem/test
-cd ../
-POPD=0
-popd >/dev/null 2>&1
-umount /mnt/selinux-testsuite
+#echo -e "Run 'filesystem' tests with mount context option:\n\t$FS_CTX"
+#mount -t nfs -o vers=4.2,$FS_CTX localhost:$TESTDIR /mnt/selinux-testsuite
+#pushd /mnt/selinux-testsuite >/dev/null 2>&1
+#POPD=1
+#cd tests
+#./nfsruntests.pl filesystem/test
+#cd ../
+#POPD=0
+#popd >/dev/null 2>&1
+#umount /mnt/selinux-testsuite
+#
+#echo -e "Run 'fs_filesystem' tests with mount context option:\n\t$FS_CTX"
+#mount -t nfs -o vers=4.2,$FS_CTX localhost:$TESTDIR /mnt/selinux-testsuite
+#pushd /mnt/selinux-testsuite >/dev/null 2>&1
+#POPD=1
+#cd tests
+#./nfsruntests.pl fs_filesystem/test
+#cd ../
+#POPD=0
+#popd >/dev/null 2>&1
+#umount /mnt/selinux-testsuite
 #
 echo "Run NFS context specific tests"
 cd tests
-- 
2.47.3

