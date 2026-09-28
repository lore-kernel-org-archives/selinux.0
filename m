Received: from mail-qv2-f43.google.com (mail-qv2-f43.google.com [74.125.230.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685444E780E
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610230; cv=none; b=JjLDtL9cglGkylFGDriRF3YgF/blOB0YyTm6zy0F5bYq2koKj9iMk5bX4DD+nAquDeFteUYOtDxji2+wuZDxuveXfLSqs9g79Qg2X6tYM/76Wp8OCm8EWLK7bCB5vaBFZX8VrLHIJm60hmQ3SzPawvqNlubVcE65JSBmnZuBvuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610230; c=relaxed/simple;
	bh=fmy9MUsbGyKLIWdSphOQ6yy/tx5XPSz1OFr9s8nUBpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CEF5AmgCcyVAsIV8JGqfhcBWnMi8HhTk2tOQ1em+DmNXVmcwYlYRbfu9NCLbrNsm/7tLxmc8NglfHxCj6hVAad2IsViRZe8zFtFsVpRbanNDg4z+8oBNfRhUax6o6UWS8RaVPc73z+/IbCaiASZEVXK9SwzKVx7UGJHjFrFnK+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2s7a21O; arc=none smtp.client-ip=74.125.230.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2s7a21O"
Received: by mail-qv2-f43.google.com with SMTP id 6a1803df08f44-9142e0b0668so34909606d6.2
        for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 08:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790610227; x=1791215027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KcK9Ufip3hxy1zUn/XUvvhBIVWlRngaxqcZhJnGhlMg=;
        b=c2s7a21ONBSBd9F9w7huxyUyxnayDaxsvC+kQqvx6F2g7gHct+5N4NKPmKBAzciHYf
         OOcr9DRIWPKvBA2Iey1XZx/Uz87ymBfoVxoUEemDH7y0quzPWuk7FQ4XXb7CxxdtyCVG
         p1hvEbBQcNJLR9eWhrDEAoErp+8PcfIvnEqAF25CPpYUkiF+wYBbivKhCh8izKOyBsVi
         /yb9liMoQp0jwIE9TPvvgqc8yJdmY1Yd9dDo34xnG3LHH283jD9YMLNRBLc224wlGEJn
         qGiyFAXEHMpf5bIseWz44m9y2dmGlyBSUB/cv50q/MXnISq0k4Xv/4dOo3wI87Nnyu/a
         akpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790610227; x=1791215027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KcK9Ufip3hxy1zUn/XUvvhBIVWlRngaxqcZhJnGhlMg=;
        b=vogjT/NzpeKGGgOjWcgaEXLkJyR6k7myLKcE3gs4eH+ce1Qa63jXLZpNofgbIX8SuU
         uLrT2ebjz4Zt7T2xba95fGf5LbeWoyIh9oN/UCLQr8fodpl+8tWInHvIaVIjIcJUMQsy
         x8aSaz08ImumzvgnJPzBFIFEv+d9egE5XSGgp4uzLHx5WlxrHuiu1gzxWuZb0PzREzHQ
         YekHF+AgTbk+uxYDuPvt+87JNH5D6qiGRS0TxhM0fuOwfOXJLVO5n+nkbURjFIL146yH
         oVDbg3smzUI2iZdv1Q86whdBBwj7JjQGNt+kPSz550oAqb8aN9hOnJMWuWtopEwDUvIt
         xKoA==
X-Gm-Message-State: AFuF++lvXqErHdztQ+eoGHe3ROCl1ZVxeJWDF4/OBqdl5Zdvj8OwOtdg
	B561DPNxEyFQfIMmCM0ZNwHLIMmGokOraami5p6dA4tING/8jBgbiQTKFsBp3A==
X-Gm-Gg: AYBFou3A/pTgzqu5jFuAosURCrz8lGBN6No8zGYJMnrSowgvt04JvWTLlkWuQJGMBec
	Pwqiv+KlqFx0+pLkpspt2hPXnvaAQzWuzJm57DrZfFhey7XNXUtxUTtGp9lzW1fbrUZXNi2ZNEu
	3DX7H9XZDmp2egeAcfYsMzwKj0Q3VG72Vj79ya4K04jXugCN7DMkrWJtdDm+6tOCwbADWUZ0JqF
	Pu3aXHthXZ0WwgsNqQP/vZT3NIJHxLiWFB0TNDYqFfGPdpatGo6pe6/ehc7wTywa17O0JS1WQKK
	rcZShAHk/jr0wGio3cLiT2fdCd7WVnnA2bA0DOLPx984bvTQu0kSJHvsKB3RdKaabDcy1UwrUEQ
	RHjcZuFFYGHYIXIao4CtBDfnqqgWU3fs/Jm5X5Ogs6NLif/ap/Q9fjGzu1ehuuQWrsFzdUwZ3XU
	oNvkW5JFEgrhvYTIP7RosDsEHrTmP5NsnpSieq/pt2XcZqteMGB7kMMPs+7ZDPbrKPlXTRKym2H
	zbNf/UNAl8sa/wwQaHzxkAk8vqaLdeBQMHw/XXBmhRxztPlBDPdWRXuEKKhyPBS4r6gnpGwAO0=
X-Received: by 2002:a05:620a:2548:b0:92e:76a1:96cd with SMTP id af79cd13be357-93c43b5af2dmr2135678785a.13.1790610226841;
        Mon, 28 Sep 2026 08:43:46 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c813fee09sm174718785a.24.2026.09.28.08.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 08:43:46 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnacek@gmail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH testsuite] Revert "tools/nfs.sh: comment out the fscontext= tests for now"
Date: Mon, 28 Sep 2026 11:43:24 -0400
Message-ID: <20260928154323.48910-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 7738f9f68cedfe36ace71a15ae49ed3d9dd85b36. The
linked kernel patch below fixes the underlying kernel bug that
prevented us from successfully running this test.

This change also updates the test scripts to skip a second Test
Invalid Mount test on NFS because since kernel commit ec1ade6a0448
("nfs: account for selinux security context when deciding to share
superblock"), NFS allocates a fresh superblock when the security
options differ, so the "same sb, different settings" error this test
checks for is unreachable on NFS.

Link: https://lore.kernel.org/selinux/20260928141917.17577-1-stephen.smalley.work@gmail.com/
Fixes: https://github.com/SELinuxProject/selinux-testsuite/issues/91
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 tests/filesystem/Filesystem.pm | 16 +-----------
 tests/filesystem/test          | 46 ++++++++++++++++------------------
 tests/fs_filesystem/test       | 44 ++++++++++++++++----------------
 tools/nfs.sh                   | 44 +++++++++++++++-----------------
 4 files changed, 64 insertions(+), 86 deletions(-)

diff --git a/tests/filesystem/Filesystem.pm b/tests/filesystem/Filesystem.pm
index ff6daec..0322e05 100644
--- a/tests/filesystem/Filesystem.pm
+++ b/tests/filesystem/Filesystem.pm
@@ -249,19 +249,5 @@ sub nfs_gen_opts {
         $nfs_mount_opts = "$vers,$proto,$clientaddr,$addr,$seclabel";
     }
 
-    # Build option for testing 'SELinux: mount invalid. Same superblock,...'
-    # that returns EBUSY. Depends on what the initial mount set as its value
-    $inval_seclabel = $seclabel;
-    if ( $seclabel_type eq 0 ) {
-        $inval_seclabel = "context=system_u:object_r:test_filesystem_file_t:s0";
-    }
-    elsif ( $seclabel_type eq 1 ) {
-        $inval_seclabel =~ s/fscontext/context/i;
-    }
-    elsif ( $seclabel_type eq 2 ) {
-        $inval_seclabel =~ s/context/fscontext/i;
-    }
-    $nfs_inval_mount_opts = "$vers,$proto,$clientaddr,$addr,$inval_seclabel";
-
-    return ( $dev, $nfs_mount_opts, $nfs_inval_mount_opts, $seclabel_type );
+    return ( $dev, $nfs_mount_opts, $seclabel_type );
 }
diff --git a/tests/filesystem/test b/tests/filesystem/test
index 56f116a..3df63d2 100755
--- a/tests/filesystem/test
+++ b/tests/filesystem/test
@@ -58,7 +58,7 @@ BEGIN {
     # rootcontext is not supported.
     # $seclabel_type: No seclabel = 0, fscontext = 1, context = 2
     if ( $fs_type eq "nfs4" or $fs_type eq "nfs" ) {
-        ( $dev, $nfs_mount_opts, $nfs_inval_mount_opts, $seclabel_type ) =
+        ( $dev, $nfs_mount_opts, $seclabel_type ) =
           nfs_gen_opts( $fs_type, $basedir, "filesystem" );
         $nfs_enabled = 1;
     }
@@ -109,8 +109,12 @@ BEGIN {
         # via the inode_setxattr_no_associate() test in nfs_filesystem/test
         $test_count -= 3;
 
-        # Remove additional Test Invalid Mount tests
-        $test_count -= 1;
+        # Skip Test Invalid Mount tests: since kernel commit ec1ade6a0448
+        # ("nfs: account for selinux security context when deciding to share
+        # superblock"), NFS allocates a fresh superblock when the security
+        # options differ, so the "same sb, different settings" error this test
+        # checks for is unreachable on NFS.
+        $test_count -= 2;
 
         # Remove tests involving multiple *context= options as invalid
         $test_count -= 20;
@@ -945,16 +949,15 @@ if ($test_watch) {
 }
 
 ############### Test Invalid Mount ##########################
-# This will generate a log entry "SELinux: mount invalid. Same superblock,
-#    different security settings for (dev 0:49, type nfs4)"
-# Note that NFS is already mounted at this point by nfs.sh
+# Skipped on NFS: since kernel commit ec1ade6a0448 ("nfs: account for
+# selinux security context when deciding to share superblock"), NFS
+# allocates a fresh superblock when the security options differ, so the
+# "same sb, different settings" error this test checks for is unreachable
+# here.
 #
-mk_mntpoint_1($private_path);
+if ( not $nfs_enabled ) {
+    mk_mntpoint_1($private_path);
 
-if ($nfs_enabled) {
-    $mount_inval_opts = $nfs_inval_mount_opts;
-}
-else {
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
     make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
     $mount_opts = "rootcontext=system_u:object_r:test_filesystem_file_t:s0";
@@ -966,26 +969,21 @@ else {
 "runcon -t test_filesystem_t $basedir/mount -s $dev -t $private_path/mp1 -f $fs_type -o $mount_opts $v"
     );
     ok( $result eq 0 );
-}
 
-print "Test 'Invalid Mount' $fs_type filesystem on $private_path/mp1\n";
-print "Mount $fs_type filesystem on $private_path/mp1\n";
-print "Using mount options:\n\t$mount_inval_opts\n";
-$result = system(
+    print "Test 'Invalid Mount' $fs_type filesystem on $private_path/mp1\n";
+    print "Mount $fs_type filesystem on $private_path/mp1\n";
+    print "Using mount options:\n\t$mount_inval_opts\n";
+    $result = system(
 "runcon -t test_filesystem_t $basedir/mount -s $dev -t $private_path/mp1 -f $fs_type -o $mount_inval_opts $v 2>&1"
-);
-if ( $nfs_enabled and $result >> 8 eq 16 ) {
-    ok( 1, "Returned EBUSY, known bug" );
-}
-else {
+    );
     system(
 "runcon -t test_filesystem_t $basedir/umount -t $private_path/mp1 $v 2>&1"
     );
     ok( $result >> 8 eq 22 );    # EINVAL
-}
 
-print "Removing: $basedir/mntpoint\n";
-cleanup1( $basedir, $dev );
+    print "Removing: $basedir/mntpoint\n";
+    cleanup1( $basedir, $dev );
+}
 
 if ( not $nfs_enabled ) {
     ##########################################################################
diff --git a/tests/fs_filesystem/test b/tests/fs_filesystem/test
index 1d04bbc..7ac6aeb 100755
--- a/tests/fs_filesystem/test
+++ b/tests/fs_filesystem/test
@@ -61,7 +61,7 @@ BEGIN {
     # rootcontext is not supported.
     # $seclabel_type: No seclabel = 0, fscontext = 1, context = 2
     if ( $fs_type eq "nfs4" or $fs_type eq "nfs" ) {
-        ( $dev, $nfs_mount_opts, $nfs_inval_mount_opts, $seclabel_type ) =
+        ( $dev, $nfs_mount_opts, $seclabel_type ) =
           nfs_gen_opts( $fs_type, $basedir, "fs_filesystem" );
         $nfs_enabled = 1;
     }
@@ -117,8 +117,12 @@ BEGIN {
         # via inode_setxattr_no_associate() test in nfs_filesystem/test
         $test_count -= 3;
 
-        # Remove additional Test Invalid Mount tests
-        $test_count -= 1;
+        # Skip Test Invalid Mount tests: since kernel commit ec1ade6a0448
+        # ("nfs: account for selinux security context when deciding to share
+        # superblock"), NFS allocates a fresh superblock when the security
+        # options differ, so the "same sb, different settings" error this test
+        # checks for is unreachable on NFS.
+        $test_count -= 2;
 
         # Remove tests involving multiple *context= options as invalid
         $test_count -= 20;
@@ -975,16 +979,15 @@ if ($test_watch) {
 }
 
 ############### Test Invalid Mount ##########################
-# This will generate a log entry "SELinux: mount invalid. Same superblock,
-#    different security settings for (dev 0:49, type nfs4)"
-# Note that NFS is already mounted at this point by nfs.sh
+# Skipped on NFS: since kernel commit ec1ade6a0448 ("nfs: account for
+# selinux security context when deciding to share superblock"), NFS
+# allocates a fresh superblock when the security options differ, so the
+# "same sb, different settings" error this test checks for is unreachable
+# here.
 #
-mk_mntpoint_1($private_path);
+if ( not $nfs_enabled ) {
+    mk_mntpoint_1($private_path);
 
-if ($nfs_enabled) {
-    $mount_inval_opts = $nfs_inval_mount_opts;
-}
-else {
     ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
     make_fs( $fs_type, $dev, $basedir, $make_fs_opts );
     $mount_opts = "rootcontext=system_u:object_r:test_filesystem_file_t:s0";
@@ -996,25 +999,20 @@ else {
 "runcon -t test_filesystem_t $basedir/fsmount -s $dev -t $private_path/mp1 -f $fs_type -o $mount_opts $v"
     );
     ok( $result eq 0 );
-}
 
-print "Test 'Invalid Mount' $fs_type filesystem on $private_path/mp1\n";
-print "Using mount options:\n\t$mount_inval_opts\n";
-$result = system(
+    print "Test 'Invalid Mount' $fs_type filesystem on $private_path/mp1\n";
+    print "Using mount options:\n\t$mount_inval_opts\n";
+    $result = system(
 "runcon -t test_filesystem_t $basedir/fsmount -s $dev -t $private_path/mp1 -f $fs_type -o $mount_inval_opts $v 2>&1"
-);
-if ( $nfs_enabled and $result >> 8 eq 16 ) {
-    ok( 1, "Returned EBUSY, known bug" );
-}
-else {    # Still gets mounted, so need to unmount
+    );
     system(
 "runcon -t test_filesystem_t $filesystem_dir/umount -t $private_path/mp1 $v 2>&1"
     );
     ok( $result >> 8 eq 22 );    # EINVAL
-}
 
-print "Removing: $basedir/mntpoint\n";
-cleanup1( $basedir, $dev );
+    print "Removing: $basedir/mntpoint\n";
+    cleanup1( $basedir, $dev );
+}
 
 if ( not $nfs_enabled ) {
     ##########################################################################
diff --git a/tools/nfs.sh b/tools/nfs.sh
index 80eba92..cf4912c 100755
--- a/tools/nfs.sh
+++ b/tools/nfs.sh
@@ -77,31 +77,27 @@ POPD=0
 popd >/dev/null 2>&1
 umount /mnt/selinux-testsuite
 #
-# The block below is commented out since these tests do not pass
-# on any known kernel.
-# See https://github.com/SELinuxProject/selinux-testsuite/issues/91
-#
-#echo -e "Run 'filesystem' tests with mount context option:\n\t$FS_CTX"
-#mount -t nfs -o vers=4.2,$FS_CTX localhost:$TESTDIR /mnt/selinux-testsuite
-#pushd /mnt/selinux-testsuite >/dev/null 2>&1
-#POPD=1
-#cd tests
-#./nfsruntests.pl filesystem/test
-#cd ../
-#POPD=0
-#popd >/dev/null 2>&1
-#umount /mnt/selinux-testsuite
+echo -e "Run 'filesystem' tests with mount context option:\n\t$FS_CTX"
+mount -t nfs -o vers=4.2,$FS_CTX localhost:$TESTDIR /mnt/selinux-testsuite
+pushd /mnt/selinux-testsuite >/dev/null 2>&1
+POPD=1
+cd tests
+./nfsruntests.pl filesystem/test
+cd ../
+POPD=0
+popd >/dev/null 2>&1
+umount /mnt/selinux-testsuite
 #
-#echo -e "Run 'fs_filesystem' tests with mount context option:\n\t$FS_CTX"
-#mount -t nfs -o vers=4.2,$FS_CTX localhost:$TESTDIR /mnt/selinux-testsuite
-#pushd /mnt/selinux-testsuite >/dev/null 2>&1
-#POPD=1
-#cd tests
-#./nfsruntests.pl fs_filesystem/test
-#cd ../
-#POPD=0
-#popd >/dev/null 2>&1
-#umount /mnt/selinux-testsuite
+echo -e "Run 'fs_filesystem' tests with mount context option:\n\t$FS_CTX"
+mount -t nfs -o vers=4.2,$FS_CTX localhost:$TESTDIR /mnt/selinux-testsuite
+pushd /mnt/selinux-testsuite >/dev/null 2>&1
+POPD=1
+cd tests
+./nfsruntests.pl fs_filesystem/test
+cd ../
+POPD=0
+popd >/dev/null 2>&1
+umount /mnt/selinux-testsuite
 #
 echo "Run NFS context specific tests"
 cd tests
-- 
2.55.0

