Return-Path: <SRS0=d7nf=43=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93836C18E5B
	for <selinux@archiver.kernel.org>; Tue, 10 Mar 2020 16:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7EA20848
	for <selinux@archiver.kernel.org>; Tue, 10 Mar 2020 16:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="WS6Zt0xh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgCJQZT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Mar 2020 12:25:19 -0400
Received: from mailomta30-sa.btinternet.com ([213.120.69.36]:52284 "EHLO
        sa-prd-fep-047.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726331AbgCJQZT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Mar 2020 12:25:19 -0400
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-047.btinternet.com with ESMTP
          id <20200310162509.ATF7408.sa-prd-fep-047.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Tue, 10 Mar 2020 16:25:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1583857509; 
        bh=WKDVfXGaIRrEESwOqYXl8LwCoEmyK0ajwoI+3U2GwaU=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=WS6Zt0xh+8j7z/hYVGqcHAhGuuD4FskfyJR0MvdBGt+RgOZDDXGYginGv/ZA/CdmXhufbxtXcFeE4vnhc8S6jKXKlQFcJveCM1xDRl5s+vYcabeqQ7OfIkZfxN+kBdqiQfILplGvICqrj5qpLI2cMQr36dnRP4AC1RSu7HMAQGAHoAPKh2PFJOMuEM9ILpf7b3ej7Tli2KuztmwxdGauOXdrx1OxuHXXXfdfM599vKrJpAdH+CaApWEQgGqq3jTesXHqT5GzSn+5Ko2raULZndRS7YW7RW34u1TmpD3tDGz1OKa/oqfNUbJrHUlBuP64IROV/LBREhDMSkROf5+HLA==
Authentication-Results: btinternet.com; none
X-Originating-IP: [31.49.57.243]
X-OWM-Source-IP: 31.49.57.243 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedruddvtddgkedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucfkphepfedurdegledrheejrddvgeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrgeelrdehjedrvdegfedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsughssehthigthhhordhnshgrrdhgohhvqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehsmhgrhihhvgifsehrvgguhhgrthdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.49.57.243) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A2411054C6FBA; Tue, 10 Mar 2020 16:25:09 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org, sds@tycho.nsa.gov
Cc:     smayhew@redhat.com,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC V3 PATCH 2/2] selinux-testsuite: Use native filesystem for tests - Part 2
Date:   Tue, 10 Mar 2020 16:24:56 +0000
Message-Id: <20200310162456.32240-3-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200310162456.32240-1-richard_c_haines@btinternet.com>
References: <20200310162456.32240-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use the filesystem type that the selinux-testsuite is running from to be
used for tests/fs_filesystem.

Add tests/nfs_filesystem to run tests only via tools/nfs.sh. This allows
tests on initial NFS mounts.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 tests/fs_filesystem/fsmount.c |    5 +-
 tests/fs_filesystem/test      | 1306 +++++++++++++++++++++------------
 tests/nfs_filesystem/test     |  359 +++++++++
 3 files changed, 1185 insertions(+), 485 deletions(-)
 create mode 100755 tests/nfs_filesystem/test

diff --git a/tests/fs_filesystem/fsmount.c b/tests/fs_filesystem/fsmount.c
index 320d82a..3eefbe5 100644
--- a/tests/fs_filesystem/fsmount.c
+++ b/tests/fs_filesystem/fsmount.c
@@ -15,7 +15,7 @@ static void print_usage(char *progname)
 
 int main(int argc, char *argv[])
 {
-	int opt, result, fsfd, mfd;
+	int opt, result, fsfd, mfd, save_errno;
 	char *context, *src = NULL, *tgt = NULL, *fs_type = NULL, *opts = NULL;
 	bool verbose = false;
 
@@ -79,9 +79,10 @@ int main(int argc, char *argv[])
 	close(fsfd);
 
 	result = move_mount(mfd, "", AT_FDCWD, tgt, MOVE_MOUNT_F_EMPTY_PATH);
+	save_errno = errno;
 	if (result < 0) {
 		fprintf(stderr, "Failed move_mount(2): %s\n", strerror(errno));
-		return -1;
+		return save_errno;
 	}
 	close(mfd);
 
diff --git a/tests/fs_filesystem/test b/tests/fs_filesystem/test
index 0bf9631..dad45e0 100755
--- a/tests/fs_filesystem/test
+++ b/tests/fs_filesystem/test
@@ -1,43 +1,144 @@
 #!/usr/bin/perl
 use Test::More;
 
+# Load common subroutines.
+use File::Basename qw(dirname);
+use Cwd qw(abs_path);
+use lib dirname( abs_path $0) . '/../filesystem';
+use Filesystem
+  qw(check_config udisks2_stop udisks2_restart get_loop_dev attach_dev make_fs mk_mntpoint_1 mk_mntpoint_2 cleanup cleanup1 reaper nfs_gen_opts);
+
 BEGIN {
     $basedir = $0;
     $basedir =~ s|(.*)/[^/]*|$1|;
 
-    # Load common subroutines from filesystem/Filesystem.pm
-    use File::Basename qw(dirname);
-    use Cwd qw(abs_path);
-    use lib dirname( abs_path $0) . '/../filesystem';
-    use Filesystem
-      qw(check_config udisks2_stop udisks2_restart get_loop_dev attach_dev make_fs mk_mntpoint_1 mk_mntpoint_2 cleanup cleanup1 reaper);
-
     # Some code in tests/filesystem is reused
     $filesystem_dir = "$basedir/../filesystem";
-    $test_count     = 66;
 
-    # Options: -v = Verbose, -d disable udisks(8) daemon
+    # Options: -v = Verbose, -e enable udisks(8) daemon, -f filesystem type
     $v              = " ";
-    $disable_udisks = 0;
+    $disable_udisks = 1;
     $udisks2_status = 0;
+    $quota_checks   = 1;
+    $nfs_enabled    = 0;
+    $vfat_enabled   = 0;
+
+    $i       = 0;
+    $fs_type = " ";
     foreach $arg (@ARGV) {
         if ( $arg eq "-v" ) {
             $v = $arg;
         }
-        elsif ( $arg eq "-d" ) {
-            $disable_udisks = 1;
+        elsif ( $arg eq "-e" ) {
+            $disable_udisks = 0;
         }
+        elsif ( $arg eq "-f" ) {
+            $fs_type = $ARGV[ $i + 1 ];
+        }
+        $i++;
+    }
+
+    # If NFS specified inform how to run
+    if ( $fs_type eq "nfs" or $fs_type eq "nfs4" ) {
+        plan skip_all => "To run NFS use 'tools/nfs.sh fs_filesystem [-v]'";
+    }
+
+    # Get filesystem type if not specified
+    if ( $fs_type eq " " ) {
+        $fs_type = `findmnt -n -o FSTYPE -T $basedir`;
+        chomp $fs_type;
+    }
+    print "Testing filesystem fs_type: $fs_type\n";
+
+    # Obtain an appropriate set of mount options for NFS
+    # rootcontext is not supported.
+    # $seclabel_type: 0 = No seclabel, 1 = fscontext, 2 = context
+    if ( $fs_type eq "nfs4" or $fs_type eq "nfs" ) {
+        ( $dev, $nfs_mount_opts, $nfs_inval_mount_opts, $seclabel_type ) =
+          nfs_gen_opts( $fs_type, $basedir, "fs_filesystem" );
+        $nfs_enabled = 1;
+    }
+    elsif ( $fs_type eq "vfat" ) {
+        $vfat_enabled = 1;
+    }
+
+    # XFS supports quotas internally and therefore does not require calling
+    # security_quota_on(). There is a patch for selinux/hooks.c to add
+    # quotactl(2) triggers such as Q_XQUOTAOFF.
+    if ( $fs_type eq "xfs" ) {
+        $test_count   = 61;
+        $quota_checks = 1;
+    }
+    elsif ( $fs_type eq "nfs4" or $fs_type eq "nfs" ) {
+        $test_count   = 54;
+        $quota_checks = 0;
+    }
+    elsif ( $fs_type eq "vfat" ) {
+        $test_count   = 54;
+        $quota_checks = 0;
+    }
+    else {
+        $test_count = 68;
     }
 
     # Check if watch and/or named type_transition rules configured
-    ( $addit, $test_watch, $test_name_trans ) =
-      check_config( $basedir, "$filesystem_dir/fanotify_fs" );
+    ( $addit, $test_watch, $test_name_trans, $test_type_trans ) =
+      check_config( $basedir, "$filesystem_dir/fanotify_fs", $nfs_enabled,
+        $vfat_enabled );
+
+    if ($nfs_enabled) {
+
+        # hooks.c may_create() FILESYSTEM__ASSOCIATE is tested via
+        # may_create_no_associate() test in nfs_filesystem/test
+        $test_count -= 3;
 
-    plan tests => ( $test_count += $addit );
+        # hooks.c selinux_inode_setxattr() FILESYSTEM__ASSOCIATE is tested
+        # via inode_setxattr_no_associate() test in nfs_filesystem/test
+        $test_count -= 3;
+
+        # Remove additional Test Invalid Mount tests
+        $test_count -= 1;
+
+        # Remove tests involving multiple *context= options as invalid
+        $test_count -= 20;
+
+        # Removed when no context option is set in a test
+        if ( $seclabel_type eq 0 ) {
+            $test_count -= 4;
+        }
+
+        # Removed if fscontext option set in a test
+        elsif ( $seclabel_type eq 1 ) {
+            $test_count -= 1;
+        }
+    }
+    elsif ($vfat_enabled) {
+
+        # For hooks.c may_create() FILESYSTEM__ASSOCIATE as not supported
+        $test_count -= 3;
+
+        # For hooks.c selinux_inode_setxattr() FILESYSTEM__ASSOCIATE
+        # as not supported
+        $test_count -= 3;
+
+        # For tests with defcontext= options as not supported
+        $test_count -= 6;
+    }
+
+    $test_count += $addit;
+    plan tests => $test_count;
 }
 
-# Set initial filesystem type
-$fs_type = "ext4";
+# Generate an absolute path to a private mount
+$cwd = `pwd 2>/dev/null`;
+chomp($cwd);
+$private_path = "$cwd";
+if ( $basedir eq "." ) {
+    $private_path = "$cwd/mntpoint";
+}
+else {
+    $private_path = "$cwd/$basedir/mntpoint";
+}
 
 # Keep a list of devices used for removal at end of test.
 $device_count = 0;
@@ -49,36 +150,83 @@ if ($disable_udisks) {
 
 cleanup($basedir);
 
-############### Test Basic Mount/Unmount ##########################
-mk_mntpoint_1("$basedir/mntpoint");
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-make_fs( $fs_type, $dev, $basedir );
-$mount_opts1 =
-"quota,usrquota,grpquota,defcontext=system_u:object_r:test_filesystem_file_t:s0";
+############### Test setfscreatecon(3) ##########################
+system("mkdir -p $basedir/mntpoint 2>/dev/null");
 
-print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
-print "Using mount options:\n\t$mount_opts1\n";
-$result = system(
-"runcon -t test_filesystem_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts1 $v"
+print "Test setfscreatecon(3)\n";
+$result = (
+    system
+"runcon -t test_setfscreatecon_t $filesystem_dir/fs_relabel $v -b $basedir/mntpoint -t test_setfscreatecon_newcon_t"
 );
 ok( $result eq 0 );
 
-# On RHEL-6, there is a type transition to quota_t when running quotacheck
-# as unconfined_t. Using "runcon `id -Z` quotacheck ..." resolves this.
-print "Running quotacheck(8) to init user/group quota files\n";
-$result = system("runcon `id -Z` quotacheck -ugF vfsv0 $basedir/mntpoint/mp1");
-ok( $result eq 0 );
-
-print "Toggle User & Group quotas on/off\n";
 $result = system(
-"runcon -t test_filesystem_t $filesystem_dir/quotas_test -s $dev -t $basedir/mntpoint/mp1/aquota.user $v"
+"runcon -t test_no_setfscreatecon_t $filesystem_dir/fs_relabel $v -b $basedir/mntpoint -t test_setfscreatecon_newcon_t 2>&1"
 );
-ok( $result eq 0 );
+ok( $result >> 8 eq 13 );
+
+system("rm -rf $basedir/mntpoint 2>/dev/null");
+
+############### Test Basic Mount/Unmount ##########################
+mk_mntpoint_1($private_path);
+
+if ($nfs_enabled) {
+    $mount_opts = $nfs_mount_opts;
+}
+else {
+    ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+    make_fs( $fs_type, $dev, $basedir );
+
+    # For XFS quota tests.
+    if ( $fs_type eq "xfs" ) {
+        $mount_opts =
+"uquota,prjquota,rootcontext=system_u:object_r:test_filesystem_file_t:s0";
+    }
+    elsif ($quota_checks) {
+        $mount_opts =
+"quota,usrquota,grpquota,rootcontext=system_u:object_r:test_filesystem_file_t:s0";
+    }
+    else {
+        $mount_opts = "rootcontext=system_u:object_r:test_filesystem_file_t:s0";
+    }
+}
+
+print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+print "Using mount options:\n\t$mount_opts\n";
+
 $result = system(
-"runcon -t test_filesystem_t $filesystem_dir/quotas_test -s $dev -t $basedir/mntpoint/mp1/aquota.group $v"
+"runcon -t test_filesystem_t $basedir/fsmount -s $dev -t $private_path/mp1 -f $fs_type -o $mount_opts $v"
 );
 ok( $result eq 0 );
 
+if ($quota_checks) {
+    if ( $fs_type eq "xfs" ) {
+        print "# XFS quota test with mount options: uquota,prjquota\n";
+        $result = system(
+"runcon -t test_filesystem_t $filesystem_dir/xfs_quotas_test $v -s $dev"
+        );
+        ok( $result eq 0 );
+    }
+    else {
+        print "Running quotacheck(8) to init user/group quota files\n";
+
+      # On RHEL-6, there is a type transition to quota_t when running quotacheck
+      # as unconfined_t. Using "runcon `id -Z` quotacheck ..." resolves this.
+        $result =
+          system("runcon `id -Z` quotacheck -ugF vfsv0 $private_path/mp1");
+        ok( $result eq 0 );
+
+        print "Toggle User & Group quotas on/off\n";
+        $result = system(
+"runcon -t test_filesystem_t $filesystem_dir/quotas_test -s $dev -t $private_path/mp1/aquota.user $v"
+        );
+        ok( $result eq 0 );
+        $result = system(
+"runcon -t test_filesystem_t $filesystem_dir/quotas_test -s $dev -t $private_path/mp1/aquota.group $v"
+        );
+        ok( $result eq 0 );
+    }
+}
 print "Get statfs(2)\n";
 $result =
   system(
@@ -86,26 +234,32 @@ $result =
   );
 ok( $result eq 0 );
 
-print
+if ($test_type_trans) {
+    print
 "Creating 'trans_test_file' and checking context changed via type_transition rule\n";
-$result =
-  system(
-"runcon -t test_filesystem_t $filesystem_dir/create_file -f $basedir/mntpoint/mp1/trans_test_file -e test_filesystem_filetranscon_t $v"
-  );
-ok( $result eq 0 );
+    $result = system(
+"runcon -t test_filesystem_t $filesystem_dir/create_file -f $private_path/mp1/trans_test_file -e test_filesystem_filetranscon_t $v"
+    );
+    ok( $result eq 0 );
+}
 
 print "Creating 'test_file' and changing its context via setfilecon(3)\n";
 $result =
   system(
-"runcon -t test_filesystem_t $filesystem_dir/create_file_change_context -t test_filesystem_filecon_t -f $basedir/mntpoint/mp1/test_file $v"
+"runcon -t test_filesystem_t $filesystem_dir/create_file_change_context -t test_filesystem_filecon_t -f $private_path/mp1/test_file $v"
   );
-ok( $result eq 0 );
+if ($vfat_enabled) {
+    ok( $result >> 8 eq 95 );    # EOPNOTSUPP
+}
+else {
+    ok( $result eq 0 );
+}
 
 if ($test_name_trans) {
     print
 "Creating 'name_trans_test_file1' and checking context changed via name-based type_transition rule\n";
     $result = system(
-"runcon -t test_filesystem_t $filesystem_dir/create_file -f $basedir/mntpoint/mp1/name_trans_test_file1 -e test_filesystem_filenametranscon1_t $v"
+"runcon -t test_filesystem_t $filesystem_dir/create_file -f $private_path/mp1/name_trans_test_file1 -e test_filesystem_filenametranscon1_t $v"
     );
     ok( $result eq 0 );
 
@@ -134,7 +288,7 @@ if ($test_watch) {
 print "Unmount filesystem from $basedir/mntpoint/mp1\n";
 $result =
   system(
-"runcon -t test_filesystem_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v"
+    "runcon -t test_filesystem_t $filesystem_dir/umount -t $private_path/mp1 $v"
   );
 ok( $result eq 0 );
 
@@ -142,60 +296,74 @@ print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
 cleanup1( $basedir, $dev );
 
 ############### Test Move Mount ##########################
-mk_mntpoint_1("$basedir/mntpoint");
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-make_fs( $fs_type, $dev, $basedir );
-$mount_opts2 =
-"quota,usrquota,grpquota,rootcontext=system_u:object_r:test_filesystem_file_t:s0";
+mk_mntpoint_1($private_path);
+
+if ($nfs_enabled) {
+    $mount_opts = $nfs_mount_opts;
+}
+else {
+    ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+    make_fs( $fs_type, $dev, $basedir );
+    $mount_opts = "rootcontext=system_u:object_r:test_filesystem_file_t:s0";
+}
 
 print "Mount on $basedir/mntpoint/mp1\n";
 $result = system(
-"runcon -t test_filesystem_t  $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts2 $v"
+"runcon -t test_filesystem_t  $basedir/fsmount -s $dev -t $private_path/mp1 -f $fs_type -o $mount_opts $v"
 );
 ok( $result eq 0 );
 
-mk_mntpoint_2("$basedir/mntpoint");
+mk_mntpoint_2($private_path);
 
 print "Now move_mount(2) filesystem to $basedir/mntpoint/mp2\n";
 $result = system(
-"runcon -t test_filesystem_t $basedir/move_mount -s $basedir/mntpoint/mp1 -t $basedir/mntpoint/mp2 $v"
+"runcon -t test_filesystem_t $basedir/move_mount -s $private_path/mp1 -t $private_path/mp2 $v"
 );
 ok( $result eq 0 );
 
 print "Unmount filesystem from $basedir/mntpoint/mp2\n";
 $result =
   system(
-"runcon -t test_filesystem_t $filesystem_dir/umount -t $basedir/mntpoint/mp2 $v"
+    "runcon -t test_filesystem_t $filesystem_dir/umount -t $private_path/mp2 $v"
   );
 ok( $result eq 0 );
 
 print "Unmount filesystem from $basedir/mntpoint/mp1\n";
 $result =
   system(
-"runcon -t test_filesystem_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v"
+    "runcon -t test_filesystem_t $filesystem_dir/umount -t $private_path/mp1 $v"
   );
 ok( $result eq 0 );
 
 print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
 cleanup1( $basedir, $dev );
 
-############### Test Change Mount Options ##########################
+############### Test Change Mount Option ##########################
 mk_mntpoint_1("$basedir/mntpoint");
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-make_fs( $fs_type, $dev, $basedir );
-$mount_opts2 =
-"quota,usrquota,grpquota,rootcontext=system_u:object_r:test_filesystem_file_t:s0";
+
+if ($nfs_enabled) {
+    $mount_opts = $nfs_mount_opts;
+}
+else {
+    ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+    make_fs( $fs_type, $dev, $basedir );
+    $mount_opts = "rootcontext=system_u:object_r:test_filesystem_file_t:s0";
+}
 
 print "Mount on $basedir/mntpoint/mp1\n";
 $result = system(
-"runcon -t test_filesystem_t  $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts2 $v"
+"runcon -t test_filesystem_t  $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts $v"
 );
 ok( $result eq 0 );
 
-$change_opts = "rootcontext=system_u:object_r:test_filesystem_file_t:s0";
-print "Now change options with fspick(2)\n";
+print "Change 'rw' option to 'ro' and back to 'rw' with fspick(2)\n";
 $result = system(
-"runcon -t test_filesystem_t $basedir/fspick -t $basedir/mntpoint/mp1 -o $change_opts $v"
+"runcon -t test_filesystem_t $basedir/fspick -t $basedir/mntpoint/mp1 -o ro $v"
+);
+ok( $result eq 0 );
+
+$result = system(
+"runcon -t test_filesystem_t $basedir/fspick -t $basedir/mntpoint/mp1 -o rw $v"
 );
 ok( $result eq 0 );
 
@@ -211,223 +379,311 @@ cleanup1( $basedir, $dev );
 
 ############### Deny filesystem { relabelfrom } ##########################
 # hooks.c may_context_mount_sb_relabel() FILESYSTEM__RELABELFROM
-mk_mntpoint_1("$basedir/mntpoint");
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-make_fs( $fs_type, $dev, $basedir );
-$opts_no_relabelfrom =
-  "defcontext=system_u:object_r:test_filesystem_sb_relabel_no_relabelfrom_t:s0";
+# Also tested in nfs_filesystem/test
+#
+if ( ( $nfs_enabled and $seclabel_type ne 0 ) or not $nfs_enabled ) {
+    mk_mntpoint_1($private_path);
 
-print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
-print "Using mount options:\n\t$opts_no_relabelfrom\n";
-$result = system(
-"runcon -t test_filesystem_sb_relabel_no_relabelfrom_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_relabelfrom $v 2>&1"
-);
-ok( $result >> 8 eq 13 );
+    if ($nfs_enabled) {
+        $mount_opts = $nfs_mount_opts;
+    }
+    else {
+        ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+        make_fs( $fs_type, $dev, $basedir );
+        $mount_opts =
+"rootcontext=system_u:object_r:test_filesystem_sb_relabel_no_relabelfrom_t:s0";
+    }
 
-print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
-cleanup1( $basedir, $dev );
+    print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+    print "Using mount options:\n\t$mount_opts\n";
+    $result = system(
+"runcon -t test_filesystem_sb_relabel_no_relabelfrom_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts $v 2>&1"
+    );
+    ok( $result >> 8 eq 13 );
+
+    print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+    cleanup1( $basedir, $dev );
+}
 
 ############### Deny filesystem { relabelto } ##########################
 # hooks.c may_context_mount_sb_relabel() FILESYSTEM__RELABELTO
-mk_mntpoint_1("$basedir/mntpoint");
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-make_fs( $fs_type, $dev, $basedir );
-$opts_no_relabelto =
-  "fscontext=system_u:object_r:test_filesystem_sb_relabel_no_relabelto_t:s0";
+# Also tested in nfs_filesystem/test
+#
+if ( ( $nfs_enabled and $seclabel_type eq 1 ) or not $nfs_enabled ) {
+    mk_mntpoint_1($private_path);
 
-print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
-print "Using mount options:\n\t$opts_no_relabelto\n";
-$result = system(
-"runcon -t test_filesystem_sb_relabel_no_relabelto_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_relabelto $v 2>&1"
-);
-ok( $result >> 8 eq 13 );
+    if ($nfs_enabled) {
+        $mount_opts = $nfs_mount_opts;
+    }
+    else {
+        ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+        make_fs( $fs_type, $dev, $basedir );
+        $mount_opts =
+"fscontext=system_u:object_r:test_filesystem_sb_relabel_no_relabelto_t:s0";
+    }
 
-print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
-cleanup1( $basedir, $dev );
+    print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+    print "Using mount options:\n\t$mount_opts\n";
+    $result = system(
+"runcon -t test_filesystem_sb_relabel_no_relabelto_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts $v 2>&1"
+    );
+    ok( $result >> 8 eq 13 );
+
+    print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+    cleanup1( $basedir, $dev );
+}
 
 ############### Deny filesystem { relabelfrom } ##########################
 # hooks.c may_context_mount_inode_relabel() FILESYSTEM__RELABELFROM
-mk_mntpoint_1("$basedir/mntpoint");
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-make_fs( $fs_type, $dev, $basedir );
-$opts_no_relabelfrom =
-  "rootcontext=system_u:object_r:test_filesystem_no_inode_no_relabelfrom_t:s0";
+# Also tested in nfs_filesystem/test
+#
+if ( ( $nfs_enabled and $seclabel_type ne 0 ) or not $nfs_enabled ) {
+    mk_mntpoint_1($private_path);
 
-print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
-print "Using mount options:\n\t$opts_no_relabelfrom\n";
-$result = system(
-"runcon -t test_filesystem_no_inode_no_relabelfrom_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_relabelfrom $v 2>&1"
-);
-ok( $result >> 8 eq 13 );
+    if ($nfs_enabled) {
+        $mount_opts = $nfs_mount_opts;
+    }
+    else {
+        ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+        make_fs( $fs_type, $dev, $basedir );
+        $mount_opts =
+"rootcontext=system_u:object_r:test_filesystem_no_inode_no_relabelfrom_t:s0";
+    }
 
-print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
-cleanup1( $basedir, $dev );
+    print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+    print "Using mount options:\n\t$mount_opts\n";
+    $result = system(
+"runcon -t test_filesystem_no_inode_no_relabelfrom_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts $v 2>&1"
+    );
+    ok( $result >> 8 eq 13 );
 
+    print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+    cleanup1( $basedir, $dev );
+}
 ############### Deny filesystem { associate } ##########################
 # hooks.c may_context_mount_inode_relabel() FILESYSTEM__ASSOCIATE
-mk_mntpoint_1("$basedir/mntpoint");
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-make_fs( $fs_type, $dev, $basedir );
+# Tested in nfs_filesystem/test
+#
+if ( not $nfs_enabled ) {
+    mk_mntpoint_1($private_path);
 
-# This defcontext will trigger denial.
-$opts_no_associate =
-"defcontext=system_u:object_r:test_filesystem_inode_relabel_no_associate_t:s0";
+    ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+    make_fs( $fs_type, $dev, $basedir );
+    $mount_opts =
+"rootcontext=system_u:object_r:test_filesystem_inode_relabel_no_associate_t:s0";
 
-print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
-print "Using mount options:\n\t$opts_no_associate\n";
-$result = system(
-"runcon -t test_filesystem_inode_relabel_no_associate_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_associate $v 2>&1"
-);
-ok( $result >> 8 eq 13 );
+    print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+    print "Using mount options:\n\t$mount_opts\n";
+    $result = system(
+"runcon -t test_filesystem_inode_relabel_no_associate_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts $v 2>&1"
+    );
+    ok( $result >> 8 eq 13 );
 
-print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
-cleanup1( $basedir, $dev );
+    print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+    cleanup1( $basedir, $dev );
+}
 
 ############### Deny filesystem { associate } ##########################
 # hooks.c may_create() FILESYSTEM__ASSOCIATE
-mk_mntpoint_1("$basedir/mntpoint");
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-make_fs( $fs_type, $dev, $basedir );
+# Tested in nfs_filesystem/test
+#
+if ( not $nfs_enabled and not $vfat_enabled ) {
+    mk_mntpoint_1($private_path);
+    ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+    make_fs( $fs_type, $dev, $basedir );
 
 # Use this fscontext= to get sensible audit log entry of:
 #  "allow unlabeled_t test_filesystem_may_create_no_associate_t:filesystem associate;"
-$opts_no_associate_file =
-  "fscontext=system_u:object_r:test_filesystem_may_create_no_associate_t:s0";
+    $mount_opts =
+"fscontext=system_u:object_r:test_filesystem_may_create_no_associate_t:s0";
 
-print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
-print "Using mount options:\n\t$opts_no_associate_file\n";
-$result = system(
-"runcon -t test_filesystem_may_create_no_associate_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_associate_file $v"
-);
-ok( $result eq 0 );
+    print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+    print "Using mount options:\n\t$mount_opts\n";
+    $result = system(
+"runcon -t test_filesystem_may_create_no_associate_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts $v"
+    );
+    ok( $result eq 0 );
 
-print "Creating test file $basedir/mntpoint/mp1/test_file\n";
-$result =
-  system(
+    print "Creating test file $basedir/mntpoint/mp1/test_file\n";
+    $result = system(
 "runcon -t test_filesystem_may_create_no_associate_t $filesystem_dir/create_file_change_context -t unconfined_t -f $basedir/mntpoint/mp1/test_file $v 2>&1"
-  );
-ok( $result >> 8 eq 13 );
+    );
+    ok( $result >> 8 eq 13 );    # EACCES
 
-print "Unmount filesystem from $basedir/mntpoint/mp1\n";
-$result =
-  system(
+    print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+    $result = system(
 "runcon -t test_filesystem_may_create_no_associate_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v"
-  );
-ok( $result eq 0 );
+    );
+    ok( $result eq 0 );
 
-print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
-cleanup1( $basedir, $dev );
+    print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+    cleanup1( $basedir, $dev );
+}
 
-############### Deny filesystem { quotamod } ##########################
-# hooks.c selinux_quotactl() FILESYSTEM__QUOTAMOD
-mk_mntpoint_1("$basedir/mntpoint");
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-make_fs( $fs_type, $dev, $basedir );
-$opts_no_quotamod =
+if ($quota_checks) {
+    ############### Deny filesystem { quotamod } ##########################
+    # hooks.c selinux_quotactl() FILESYSTEM__QUOTAMOD
+    #
+    # This test requires a patch to hooks.c to implement: Q_XQUOTAOFF,
+    # Q_XQUOTAON and Q_XSETQLIM.
+    #
+    mk_mntpoint_1($private_path);
+    ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+    make_fs( $fs_type, $dev, $basedir );
+
+    if ( $fs_type eq "xfs" ) {
+        $opts_no_quotamod =
+"quota,uquota,prjquota,fscontext=system_u:object_r:test_filesystem_no_quotamod_t:s0";
+    }
+    else {
+        $opts_no_quotamod =
 "quota,usrquota,grpquota,fscontext=system_u:object_r:test_filesystem_no_quotamod_t:s0";
+    }
 
-print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
-print "Using mount options:\n\t$opts_no_quotamod\n";
-$result = system(
+    print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+    print "Using mount options:\n\t$opts_no_quotamod\n";
+    $result = system(
 "runcon -t test_filesystem_no_quotamod_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_quotamod $v 2>&1"
-);
-ok( $result eq 0 );
+    );
+    ok( $result eq 0 );
 
-# No need to run quotacheck(8) as never gets far enough to read quota file
-print "Toggle User & Group quotas on/off\n";
-$result = system(
-"runcon -t test_filesystem_no_quotamod_t $filesystem_dir/quotas_test -s $dev -t $basedir/mntpoint/mp1/aquota.user $v 2>&1"
-);
-ok( $result >> 8 eq 13 );
+    if ( $fs_type eq "xfs" ) {
+        print "Toggle xfs quotas on/off\n";
+        $result = system(
+"runcon -t test_filesystem_no_quotamod_t $filesystem_dir/xfs_quotas_test -s $dev $v 2>&1"
+        );
+        ok( $result >> 8 eq 13 );
+    }
+    else {
+      # No need to run quotacheck(8) as never gets far enough to read quota file
+        print "Toggle User & Group quotas on/off\n";
+        $result = system(
+"runcon -t test_filesystem_no_quotamod_t $filesystem_dir/quotas_test -s $dev -t $private_path/mp1/aquota.user $v 2>&1"
+        );
+        ok( $result >> 8 eq 13 );
+    }
 
-print "Unmount filesystem from $basedir/mntpoint/mp1\n";
-$result = system(
+    print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+    $result = system(
 "runcon -t test_filesystem_no_quotamod_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v"
-);
-ok( $result eq 0 );
+    );
+    ok( $result eq 0 );
 
-print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
-cleanup1( $basedir, $dev );
+    print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+    cleanup1( $basedir, $dev );
 
-############### Deny filesystem { quotaget } ##########################
-# hooks.c selinux_quotactl() FILESYSTEM__QUOTAGET
-mk_mntpoint_1("$basedir/mntpoint");
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-make_fs( $fs_type, $dev, $basedir );
-$opts_no_quotaget =
+    ############### Deny filesystem { quotaget } ##########################
+    # hooks.c selinux_quotactl() FILESYSTEM__QUOTAGET
+    #
+    # This test requires a patch to hooks.c to implement: Q_XGETQUOTA,
+    # Q_XGETQSTAT, Q_XGETQSTATV and Q_XGETNEXTQUOTA.
+    #
+    mk_mntpoint_1($private_path);
+    ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+    make_fs( $fs_type, $dev, $basedir );
+
+    if ( $fs_type eq "xfs" ) {
+        $opts_no_quotaget =
+"quota,uquota,prjquota,context=system_u:object_r:test_filesystem_no_quotaget_t:s0";
+    }
+    else {
+        $opts_no_quotaget =
 "quota,usrquota,grpquota,context=system_u:object_r:test_filesystem_no_quotaget_t:s0";
+    }
 
-print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
-print "Using mount options:\n\t$opts_no_quotaget\n";
-$result = system(
+    print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+    print "Using mount options:\n\t$opts_no_quotaget\n";
+    $result = system(
 "runcon -t test_filesystem_no_quotaget_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_quotaget $v"
-);
-ok( $result eq 0 );
-
-print "Running quotacheck(8) to init user/group quota files\n";
-$result = system("runcon `id -Z` quotacheck -ugF vfsv0 $basedir/mntpoint/mp1");
-ok( $result eq 0 );
+    );
+    ok( $result eq 0 );
 
-print "Toggle User & Group quotas on/off\n";
-$result = system(
-"runcon -t test_filesystem_no_quotaget_t $filesystem_dir/quotas_test -s $dev -t $basedir/mntpoint/mp1/aquota.user $v 2>&1"
-);
-ok( $result >> 8 eq 13 );
+    if ( $fs_type eq "xfs" ) {
+        print "Toggle xfs quotas on/off\n";
+        $result = system(
+"runcon -t test_filesystem_no_quotaget_t $filesystem_dir/xfs_quotas_test -s $dev $v 2>&1"
+        );
+        ok( $result >> 8 eq 13 );
+    }
+    else {
+        print "Running quotacheck(8) to init user/group quota files\n";
+        $result =
+          system("runcon `id -Z` quotacheck -ugF vfsv0 $private_path/mp1");
+        ok( $result eq 0 );
+
+        print "Toggle User & Group quotas on/off\n";
+        $result = system(
+"runcon -t test_filesystem_no_quotaget_t $filesystem_dir/quotas_test -s $dev -t $private_path/mp1/aquota.user $v 2>&1"
+        );
+        ok( $result >> 8 eq 13 );
+    }
 
-print "Unmount filesystem from $basedir/mntpoint/mp1\n";
-$result = system(
+    print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+    $result = system(
 "runcon -t test_filesystem_no_quotaget_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v"
-);
-ok( $result eq 0 );
-
-print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
-cleanup1( $basedir, $dev );
-
-############### Deny file { quotaon } ##########################
-# hooks.c selinux_quota_on() FILE__QUOTAON
-mk_mntpoint_1("$basedir/mntpoint");
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-make_fs( $fs_type, $dev, $basedir );
-$opts_no_quotaon =
-  "quota,usrquota,grpquota,context=system_u:object_r:test_file_no_quotaon_t:s0";
-
-print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
-print "Using mount options:\n\t$opts_no_quotaon\n";
-$result = system(
-"runcon -t test_file_no_quotaon_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_quotaon $v"
-);
-ok( $result eq 0 );
-
-print "Running quotacheck(8) to init user/group quota files\n";
-$result = system("runcon `id -Z` quotacheck -ugF vfsv0 $basedir/mntpoint/mp1");
-ok( $result eq 0 );
+    );
+    ok( $result eq 0 );
 
-print "Toggle User quotas on/off\n";
-$result = system(
-"runcon -t test_file_no_quotaon_t $filesystem_dir/quotas_test -s $dev -t $basedir/mntpoint/mp1/aquota.user $v 2>&1"
-);
-ok( $result >> 8 eq 13 );
+    print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+    cleanup1( $basedir, $dev );
 
-print "Unmount filesystem from $basedir/mntpoint/mp1\n";
-$result = system(
+    ############### Deny file { quotaon } ##########################
+    # hooks.c selinux_quota_on() FILE__QUOTAON
+    # XFS does not require this test
+    #
+    if ( not $fs_type eq "xfs" ) {
+        mk_mntpoint_1($private_path);
+        ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+        make_fs( $fs_type, $dev, $basedir );
+
+        $opts_no_quotaon =
+"quota,usrquota,grpquota,context=system_u:object_r:test_file_no_quotaon_t:s0";
+        print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+        print "Using mount options:\n\t$opts_no_quotaon\n";
+        $result = system(
+"runcon -t test_file_no_quotaon_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_quotaon $v"
+        );
+        ok( $result eq 0 );
+
+        print "Running quotacheck(8) to init user/group quota files\n";
+        $result =
+          system("runcon `id -Z` quotacheck -ugF vfsv0 $private_path/mp1");
+        ok( $result eq 0 );
+
+        print "Toggle User quotas on/off\n";
+        $result = system(
+"runcon -t test_file_no_quotaon_t $filesystem_dir/quotas_test -s $dev -t $private_path/mp1/aquota.user $v 2>&1"
+        );
+        ok( $result >> 8 eq 13 );
+
+        print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+        $result = system(
 "runcon -t test_file_no_quotaon_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v"
-);
-ok( $result eq 0 );
+        );
+        ok( $result eq 0 );
 
-print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
-cleanup1( $basedir, $dev );
+        print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+        cleanup1( $basedir, $dev );
+    }
+}    # End quota checks
 
 ############### Deny filesystem { mount } ##########################
 # hooks.c selinux_sb_kern_mount() FILESYSTEM__MOUNT
-mk_mntpoint_1("$basedir/mntpoint");
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-make_fs( $fs_type, $dev, $basedir );
-$opts_no_mount = "rootcontext=system_u:object_r:test_filesystem_no_mount_t:s0";
+mk_mntpoint_1($private_path);
+
+if ($nfs_enabled) {
+    $mount_opts = $nfs_mount_opts;
+}
+else {
+    ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+    make_fs( $fs_type, $dev, $basedir );
+    $mount_opts = "rootcontext=system_u:object_r:test_filesystem_no_mount_t:s0";
+}
 
 print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
-print "Using mount options:\n\t$opts_no_mount\n";
+print "Using mount options:\n\t$mount_opts\n";
 $result = system(
-"runcon -t test_filesystem_no_mount_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_mount $v 2>&1"
+"runcon -t test_filesystem_no_mount_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts $v 2>&1"
 );
 ok( $result >> 8 eq 13 );
 
@@ -436,16 +692,22 @@ cleanup1( $basedir, $dev );
 
 ############### Deny filesystem { getattr } ##########################
 # hooks.c selinux_sb_statfs() FILESYSTEM__GETATTR
-mk_mntpoint_1("$basedir/mntpoint");
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-make_fs( $fs_type, $dev, $basedir );
-$opts_no_getattr =
-  "rootcontext=system_u:object_r:test_filesystem_no_getattr_t:s0";
+mk_mntpoint_1($private_path);
+
+if ($nfs_enabled) {
+    $mount_opts = $nfs_mount_opts;
+}
+else {
+    ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+    make_fs( $fs_type, $dev, $basedir );
+    $mount_opts =
+      "rootcontext=system_u:object_r:test_filesystem_no_getattr_t:s0";
+}
 
 print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
-print "Using mount options:\n\t$opts_no_getattr\n";
+print "Using mount options:\n\t$mount_opts\n";
 $result = system(
-"runcon -t test_filesystem_no_getattr_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_getattr $v"
+"runcon -t test_filesystem_no_getattr_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts $v"
 );
 ok( $result eq 0 );
 
@@ -466,21 +728,22 @@ cleanup1( $basedir, $dev );
 ################ Deny file { mounton } ##########################
 # hooks.c selinux_move_mount() FILE__MOUNTON
 mk_mntpoint_1("$basedir/mntpoint");
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-make_fs( $fs_type, $dev, $basedir );
-$opts_no_remount =
-  "rootcontext=system_u:object_r:test_move_mount_no_mounton_t:s0";
 
-print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
-print "Using mount options:\n\t$opts_no_remount\n";
-$result = system(
-"runcon -t test_move_mount_no_mounton_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_remount $v"
-);
-ok( $result eq 0 );
+if ($nfs_enabled) {
+    $mount_opts = $nfs_mount_opts;
+}
+else {
+    ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+    make_fs( $fs_type, $dev, $basedir );
+    $mount_opts =
+      "rootcontext=system_u:object_r:test_move_mount_no_mounton_t:s0";
+}
 
-print "Now move filesystem. This operation should fail\n";
+print
+"Mount and move the $fs_type filesystem onto $basedir/mntpoint/mp1 - This operation should fail\n";
+print "Using mount options:\n\t$mount_opts\n";
 $result = system(
-"runcon -t test_move_mount_no_mounton_t $basedir/move_mount -s $basedir/mntpoint/mp1 -t $basedir/mntpoint/mp1 $v 2>&1"
+"runcon -t test_move_mount_no_mounton_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts $v 2>&1"
 );
 if ( $result eq 0 ) {
     $kvercur = `uname -r`;
@@ -497,27 +760,28 @@ if ( $result eq 0 ) {
 else {
     ok( $result >> 8 eq 13 );
 }
-print "Unmount filesystem from $basedir/mntpoint/mp1\n";
-$result = system(
-"runcon -t test_move_mount_no_mounton_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v"
-);
-ok( $result eq 0 );
 
 print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
 cleanup1( $basedir, $dev );
 
 ############### Deny filesystem { unmount } ##########################
 # hooks.c selinux_umount() FILESYSTEM__UNMOUNT
-mk_mntpoint_1("$basedir/mntpoint");
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-make_fs( $fs_type, $dev, $basedir );
-$opts_no_unmount =
-  "rootcontext=system_u:object_r:test_filesystem_no_unmount_t:s0";
+mk_mntpoint_1($private_path);
+
+if ($nfs_enabled) {
+    $mount_opts = $nfs_mount_opts;
+}
+else {
+    ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+    make_fs( $fs_type, $dev, $basedir );
+    $mount_opts =
+      "rootcontext=system_u:object_r:test_filesystem_no_unmount_t:s0";
+}
 
 print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
-print "Using mount options:\n\t$opts_no_unmount\n";
+print "Using mount options:\n\t$mount_opts\n";
 $result = system(
-"runcon -t test_filesystem_no_unmount_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_unmount $v"
+"runcon -t test_filesystem_no_unmount_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts $v"
 );
 ok( $result eq 0 );
 
@@ -540,48 +804,55 @@ cleanup1( $basedir, $dev );
 
 ############### Deny filesystem { associate }  ##########################
 # hooks.c selinux_inode_setxattr() FILESYSTEM__ASSOCIATE
-mk_mntpoint_1("$basedir/mntpoint");
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-make_fs( $fs_type, $dev, $basedir );
-$opts_no_associate_xattr =
-"defcontext=system_u:object_r:test_filesystem_inode_setxattr_no_associate_t:s0,fscontext=system_u:object_r:test_filesystem_inode_setxattr_no_associate_t:s0";
+# Tested in nfs_filesystem/test
+#
+if ( not $nfs_enabled and not $vfat_enabled ) {
+    mk_mntpoint_1($private_path);
+    ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+    make_fs( $fs_type, $dev, $basedir );
+    $mount_opts =
+"rootcontext=system_u:object_r:test_filesystem_inode_setxattr_no_associate_t:s0,fscontext=system_u:object_r:test_filesystem_inode_setxattr_no_associate_t:s0";
 
-print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
-print "Using mount options:\n\t$opts_no_associate_xattr\n";
-$result = system(
-"runcon -t test_filesystem_inode_setxattr_no_associate_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_associate_xattr $v"
-);
-ok( $result eq 0 );
+    print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+    print "Using mount options:\n\t$mount_opts\n";
+    $result = system(
+"runcon -t test_filesystem_inode_setxattr_no_associate_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts $v"
+    );
+    ok( $result eq 0 );
 
-print "Creating test file $basedir/mntpoint/mp1/test_file\n";
-$result =
-  system(
+    $result = system(
 "runcon -t test_filesystem_inode_setxattr_no_associate_t $filesystem_dir/create_file_change_context -t unconfined_t -f $basedir/mntpoint/mp1/test_file $v 2>&1"
-  );
-ok( $result >> 8 eq 13 );
+    );
+    ok( $result >> 8 eq 13 );    # EACCES
 
-print "Unmount filesystem from $basedir/mntpoint/mp1\n";
-$result =
-  system(
+    print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+    $result = system(
 "runcon -t test_filesystem_inode_setxattr_no_associate_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v"
-  );
-ok( $result eq 0 );
+    );
+    ok( $result eq 0 );
 
-print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
-cleanup1( $basedir, $dev );
+    print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+    cleanup1( $basedir, $dev );
+}
 
 if ($test_watch) {
     ############### Deny filesystem { watch }  ##########################
     # hooks.c selinux_path_notify() FILESYSTEM__WATCH
-    mk_mntpoint_1("$basedir/mntpoint");
-    ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
-    $opts_no_watch = "context=system_u:object_r:test_filesystem_no_watch_t:s0";
+    mk_mntpoint_1($private_path);
+
+    if ($nfs_enabled) {
+        $mount_opts = $nfs_mount_opts;
+    }
+    else {
+        ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+        make_fs( $fs_type, $dev, $basedir );
+        $mount_opts = "context=system_u:object_r:test_filesystem_no_watch_t:s0";
+    }
 
     print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
-    print "Using mount options:\n\t$opts_no_watch\n";
+    print "Using mount options:\n\t$mount_opts\n";
     $result = system(
-"runcon -t test_filesystem_no_watch_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_watch $v"
+"runcon -t test_filesystem_no_watch_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts $v"
     );
     ok( $result eq 0 );
 
@@ -602,16 +873,22 @@ if ($test_watch) {
 
     ############### Deny file { watch_sb }  ##########################
     # hooks.c selinux_path_notify() FILE__WATCH_SB
-    mk_mntpoint_1("$basedir/mntpoint");
-    ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
-    $opts_no_watch_sb =
-      "context=system_u:object_r:test_filesystem_no_watch_sb_t:s0";
+    mk_mntpoint_1($private_path);
+
+    if ($nfs_enabled) {
+        $mount_opts = $nfs_mount_opts;
+    }
+    else {
+        ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+        make_fs( $fs_type, $dev, $basedir );
+        $mount_opts =
+          "context=system_u:object_r:test_filesystem_no_watch_sb_t:s0";
+    }
 
     print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
-    print "Using mount options:\n\t$opts_no_watch_sb\n";
+    print "Using mount options:\n\t$mount_opts\n";
     $result = system(
-"runcon -t test_filesystem_no_watch_sb_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_watch_sb $v"
+"runcon -t test_filesystem_no_watch_sb_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts $v"
     );
     ok( $result eq 0 );
 
@@ -632,16 +909,22 @@ if ($test_watch) {
 
     ############### Deny file { watch_mount }  ##########################
     # hooks.c selinux_path_notify() FILE__WATCH_MOUNT
-    mk_mntpoint_1("$basedir/mntpoint");
-    ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
-    $opts_no_watch_mount =
-      "context=system_u:object_r:test_filesystem_no_watch_mount_t:s0";
+    mk_mntpoint_1($private_path);
+
+    if ($nfs_enabled) {
+        $mount_opts = $nfs_mount_opts;
+    }
+    else {
+        ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+        make_fs( $fs_type, $dev, $basedir );
+        $mount_opts =
+          "context=system_u:object_r:test_filesystem_no_watch_mount_t:s0";
+    }
 
     print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
-    print "Using mount options:\n\t$opts_no_watch_mount\n";
+    print "Using mount options:\n\t$mount_opts\n";
     $result = system(
-"runcon -t test_filesystem_no_watch_mount_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_watch_mount $v"
+"runcon -t test_filesystem_no_watch_mount_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts $v"
     );
     ok( $result eq 0 );
 
@@ -661,238 +944,295 @@ if ($test_watch) {
     cleanup1( $basedir, $dev );
 }
 
-##########################################################################
-# context     - Useful when mounting filesystems that do not support extended
-#               attributes.
-#   Tested by - Creating a filesystem that has xattrs set to a different value,
-#               then mount with context= and confirm that the files have that
-#               context as well as any newly created files (even if fscreate
-#               was set to something else), and that setfilecon/setxattr() on
-#               files within the mount fails with errno EOPNOTSUPP.
-##########################################################################
-mk_mntpoint_1("$basedir/mntpoint");
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-make_fs( $fs_type, $dev, $basedir );
+############### Test Invalid Mount ##########################
+# This will generate a log entry "SELinux: mount invalid. Same superblock,
+#    different security settings for (dev 0:49, type nfs4)"
+# Note that NFS is already mounted at this point by nfs.sh
+#
+mk_mntpoint_1($private_path);
 
-# Mount with xttrs to create a file with specific context.
-$context1_opts =
-  "defcontext=system_u:object_r:test_filesystem_context_file_t:s0";
+if ($nfs_enabled) {
+    $mount_inval_opts = $nfs_inval_mount_opts;
+}
+else {
+    ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+    make_fs( $fs_type, $dev, $basedir );
+    $mount_opts = "rootcontext=system_u:object_r:test_filesystem_file_t:s0";
+    $mount_inval_opts = "fscontext=system_u:object_r:test_filesystem_file_t:s0";
 
-print "Testing 'context=' mount option\n";
-print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
-print "Using mount options:\n\t$context1_opts\n";
+    print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+    print "Using mount options:\n\t$mount_opts\n";
+    $result = system(
+"runcon -t test_filesystem_t $basedir/fsmount -s $dev -t $private_path/mp1 -f $fs_type -o $mount_opts $v"
+    );
+    ok( $result eq 0 );
+}
+
+print "Test 'Invalid Mount' $fs_type filesystem on $private_path/mp1\n";
+print "Using mount options:\n\t$mount_inval_opts\n";
 $result = system(
-"runcon -t test_filesystem_context_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $context1_opts $v"
+"runcon -t test_filesystem_t $basedir/fsmount -s $dev -t $private_path/mp1 -f $fs_type -o $mount_inval_opts $v 2>&1"
 );
-ok( $result eq 0 );
+if ( $nfs_enabled and $result >> 8 eq 16 ) {
+    ok( 1, "Returned EBUSY, known bug" );
+}
+else {    # Still gets mounted, so need to unmount
+    system(
+"runcon -t test_filesystem_t $filesystem_dir/umount -t $private_path/mp1 $v 2>&1"
+    );
+    ok( $result >> 8 eq 22 );    # EINVAL
+}
 
-# Create file with 'test_filesystem_filecon_t' context
-print "Creating test file $basedir/mntpoint/mp1/test_file\n";
-$result =
-  system(
-"runcon -t test_filesystem_context_t $filesystem_dir/create_file_change_context -t test_filesystem_filecon_t -f $basedir/mntpoint/mp1/test_file $v"
-  );
-ok( $result eq 0 );
+print "Removing: $basedir/mntpoint\n";
+cleanup1( $basedir, $dev );
 
-print "Unmount filesystem from $basedir/mntpoint/mp1\n";
-$result = system(
+if ( not $nfs_enabled ) {
+    ##########################################################################
+    # context     - Useful when mounting filesystems that do not support
+    #               extended attributes.
+    #               Note when testing vfat the test will fail earlier, but
+    #               just carry on
+    #   Tested by - Creating a filesystem that has xattrs set to a different
+    #               value, then mount with context= and confirm that the files
+    #               have that context as well as any newly created files (even
+    #               if fscreate was set to something else), and that
+    #               setfilecon/setxattr() on files within the mount fails with
+    #               errno EOPNOTSUPP.
+    ##########################################################################
+    mk_mntpoint_1($private_path);
+    ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+    make_fs( $fs_type, $dev, $basedir );
+
+    # Mount with xttrs to create a file with specific context.
+    $context1_opts =
+      "rootcontext=system_u:object_r:test_filesystem_context_file_t:s0";
+
+    print "Testing 'context=' mount option\n";
+    print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+    print "Using mount options:\n\t$context1_opts\n";
+    $result = system(
+"runcon -t test_filesystem_context_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $context1_opts $v"
+    );
+    ok( $result eq 0 );
+
+    # Create file with 'test_filesystem_filecon_t' context
+    print "Creating test file $basedir/mntpoint/mp1/test_file\n";
+    $result =
+      system(
+"runcon -t test_filesystem_context_t $filesystem_dir/create_file_change_context -t test_filesystem_filecon_t -f $private_path/mp1/test_file $v"
+      );
+    if ($vfat_enabled) {
+        ok( $result >> 8 eq 95 );    # EOPNOTSUPP
+    }
+    else {
+        ok( $result eq 0 );
+    }
+
+    print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+    $result = system(
 "runcon -t test_filesystem_context_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v"
-);
-ok( $result eq 0 );
+    );
+    ok( $result eq 0 );
 
-# Need to free the loop device, then get new one and attach
-system("losetup -d $dev 2>/dev/null");
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-attach_dev( $dev, $basedir );
+    # Need to free the loop device, then get new one and attach
+    system("losetup -d $dev 2>/dev/null");
+    ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+    attach_dev( $dev, $basedir );
 
-# Mount again with no xttr support
-$context2_opts = "context=system_u:object_r:test_filesystem_context_file_t:s0";
-print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
-print "Using mount options:\n\t$context2_opts\n";
-$result = system(
+    # Mount again with no xttr support
+    $context2_opts =
+      "context=system_u:object_r:test_filesystem_context_file_t:s0";
+    print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+    print "Using mount options:\n\t$context2_opts\n";
+    $result = system(
 "runcon -t test_filesystem_context_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $context2_opts $v"
-);
-ok( $result eq 0 );
+    );
+    ok( $result eq 0 );
 
 # Now check the context on file is system_u:object_r:test_filesystem_context_file_t:s0
-print "Check test file context $basedir/mntpoint/mp1/test_file\n";
-$result =
-  system(
-"runcon -t test_filesystem_context_t $filesystem_dir/check_file_context -f $basedir/mntpoint/mp1/test_file -e system_u:object_r:test_filesystem_context_file_t:s0 $v"
-  );
-ok( $result eq 0 );
+    print "Check test file context $basedir/mntpoint/mp1/test_file\n";
+    $result =
+      system(
+"runcon -t test_filesystem_context_t $filesystem_dir/check_file_context -f $private_path/mp1/test_file -e system_u:object_r:test_filesystem_context_file_t:s0 $v"
+      );
+    ok( $result eq 0 );
 
 # Then create a file with 'test_filesystem_filecon_t' context, this should fail with EOPNOTSUPP
-print "Creating test file $basedir/mntpoint/mp1/test_file\n";
-$result =
-  system(
-"runcon -t test_filesystem_context_t $filesystem_dir/create_file_change_context -t test_filesystem_filecon_t -f $basedir/mntpoint/mp1/test_file $v 2>/dev/null"
-  );
-ok( $result >> 8 eq 95 );
+    print "Creating test file $basedir/mntpoint/mp1/test_file\n";
+    $result =
+      system(
+"runcon -t test_filesystem_context_t $filesystem_dir/create_file_change_context -t test_filesystem_filecon_t -f $private_path/mp1/test_file $v 2>/dev/null"
+      );
+    ok( $result >> 8 eq 95 );
 
-print "Unmount filesystem from $basedir/mntpoint/mp1\n";
-$result =
-  system(
+    print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+    $result =
+      system(
 "runcon -t test_filesystem_context_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v"
-  );
-ok( $result eq 0 );
+      );
+    ok( $result eq 0 );
 
-print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
-cleanup1( $basedir, $dev );
+    print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+    cleanup1( $basedir, $dev );
 
-##########################################################################
-# rootcontext - Explicitly label the root inode of the filesystem being
-#               mounted before that filesystem or inode becomes visible
-#               to userspace.
-#   Tested by - Set mountpoint to unlabeled_t and then check that the
-#               context of the root directory matches rootcontext= after
-#               the mount operation.
-##########################################################################
-mk_mntpoint_1("$basedir/mntpoint");
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-make_fs( $fs_type, $dev, $basedir );
-$root_opts = "rootcontext=system_u:object_r:test_filesystem_context_file_t:s0";
+    ##########################################################################
+    # rootcontext - Explicitly label the root inode of the filesystem being
+    #               mounted before that filesystem or inode becomes visible
+    #               to userspace.
+    #   Tested by - Set mountpoint to unlabeled_t and then check that the
+    #               context of the root directory matches rootcontext= after
+    #               the mount operation.
+    ##########################################################################
+    mk_mntpoint_1($private_path);
+    ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+    make_fs( $fs_type, $dev, $basedir );
+    $root_opts =
+      "rootcontext=system_u:object_r:test_filesystem_context_file_t:s0";
 
-print "Testing 'rootcontext=' mount option\n";
+    print "Testing 'rootcontext=' mount option\n";
 
 # Reset mountpoint to 'unlabeled_t' so it is different to any other possible test values.
-print "Resetting MP to unlabeled_t $basedir/mntpoint/mp1\n";
-$result =
-  system(
+    print "Resetting MP to unlabeled_t $basedir/mntpoint/mp1\n";
+    $result =
+      system(
 "runcon -t test_filesystem_context_t $filesystem_dir/check_mount_context -r -m $basedir/mntpoint/mp1 $v"
-  );
-ok( $result eq 0 );
+      );
+    ok( $result eq 0 );
 
-print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
-print "Using mount options:\n\t$root_opts\n";
-$result = system(
+    print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+    print "Using mount options:\n\t$root_opts\n";
+    $result = system(
 "runcon -t test_filesystem_context_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $root_opts $v"
-);
-ok( $result eq 0 );
+    );
+    ok( $result eq 0 );
 
-# Now check the mountpoint is the 'rootcontext=' value
-print "Check MP context $basedir/mntpoint/mp1\n";
-$result =
-  system(
+    # Now check the mountpoint is the 'rootcontext=' value
+    print "Check MP context $basedir/mntpoint/mp1\n";
+    $result =
+      system(
 "runcon -t test_filesystem_context_t $filesystem_dir/check_mount_context -m $basedir/mntpoint/mp1 -e system_u:object_r:test_filesystem_context_file_t:s0 $v"
-  );
-ok( $result eq 0 );
+      );
+    ok( $result eq 0 );
 
-print "Unmount filesystem from $basedir/mntpoint/mp1\n";
-$result = system(
+    print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+    $result = system(
 "runcon -t test_filesystem_context_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v"
-);
-ok( $result eq 0 );
-
-print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
-cleanup1( $basedir, $dev );
+    );
+    ok( $result eq 0 );
 
-##########################################################################
-# defcontext  - Set default security context for unlabeled files.
-#               This overrides the value set for unlabeled files in policy
-#               and requires a filesystem that supports xattr labeling.
-#   Tested by - Create filesystem that has files w/o xattrs and then confirm
-#               that they are mapped to the specified defcontext upon mount,
-#               where defcontext differs from the policy default.
-##########################################################################
-mk_mntpoint_1("$basedir/mntpoint");
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-make_fs( $fs_type, $dev, $basedir );
-$test_opts = "context=system_u:object_r:test_filesystem_context_file_t:s0";
+    print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+    cleanup1( $basedir, $dev );
 
-print "Testing 'defcontext=' mount option\n";
-print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
-print "Using mount options:\n\t$test_opts\n";
-$result = system(
+    if ( not $vfat_enabled ) {
+        #######################################################################
+      # defcontext  - Set default security context for unlabeled files.
+      #               This overrides the value set for unlabeled files in policy
+      #               and requires a filesystem that supports xattr labeling.
+      #   Tested by - Create filesystem that has files w/o xattrs and then
+      #               confirm that they are mapped to the specified defcontext
+      #               upon mount, where defcontext differs from the policy
+      #               default.
+        #######################################################################
+        mk_mntpoint_1($private_path);
+        ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+        make_fs( $fs_type, $dev, $basedir );
+        $test_opts =
+          "context=system_u:object_r:test_filesystem_context_file_t:s0";
+
+        print "Testing 'defcontext=' mount option\n";
+        print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+        print "Using mount options:\n\t$test_opts\n";
+        $result = system(
 "runcon -t test_filesystem_context_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $test_opts $v"
-);
-ok( $result eq 0 );
+        );
+        ok( $result eq 0 );
 
-# Create file, its context will be system_u:object_r:test_filesystem_context_file_t:s0 from $test_opts
-print "Creating test file $basedir/mntpoint/mp1/test_file\n";
-$result =
-  system(
+        # Create file, its context will be:
+        #   system_u:object_r:test_filesystem_context_file_t:s0 from $test_opts
+        print "Creating test file $basedir/mntpoint/mp1/test_file\n";
+        $result = system(
 "runcon -u system_u -t test_filesystem_fscontext_t $filesystem_dir/create_file -f $basedir/mntpoint/mp1/test_file -e test_filesystem_context_file_t $v"
-  );
-ok( $result eq 0 );
+        );
+        ok( $result eq 0 );
 
-print "Unmount filesystem from $basedir/mntpoint/mp1\n";
-$result = system(
+        print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+        $result = system(
 "runcon -t test_filesystem_context_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v"
-);
-ok( $result eq 0 );
-
-# Need to free the loop device, then get new dev one and attach
-system("losetup -d $dev 2>/dev/null");
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-attach_dev( $dev, $basedir );
-
-# Mount again with defcontext=
-$defcontext_opts = "defcontext=system_u:object_r:test_filesystem_filecon_t:s0";
-print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
-print "Using mount options:\n\t$defcontext_opts\n";
-$result = system(
+        );
+        ok( $result eq 0 );
+
+        # Need to free the loop device, then get new dev one and attach
+        system("losetup -d $dev 2>/dev/null");
+        ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+        attach_dev( $dev, $basedir );
+
+        # Mount again with defcontext=
+        $defcontext_opts =
+          "defcontext=system_u:object_r:test_filesystem_filecon_t:s0";
+        print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+        print "Using mount options:\n\t$defcontext_opts\n";
+        $result = system(
 "runcon -t test_filesystem_context_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $defcontext_opts $v"
-);
-ok( $result eq 0 );
+        );
+        ok( $result eq 0 );
 
 # Now check the file context is now system_u:object_r:test_filesystem_filecon_t:s0
-print "Check test file context $basedir/mntpoint/mp1/test_file\n";
-$result =
-  system(
+        print "Check test file context $basedir/mntpoint/mp1/test_file\n";
+        $result = system(
 "runcon -t test_filesystem_context_t $filesystem_dir/check_file_context -f $basedir/mntpoint/mp1/test_file -e system_u:object_r:test_filesystem_filecon_t:s0 $v"
-  );
-ok( $result eq 0 );
+        );
+        ok( $result eq 0 );
 
-print "Unmount filesystem from $basedir/mntpoint/mp1\n";
-$result =
-  system(
+        print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+        $result = system(
 "runcon -t test_filesystem_context_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v"
-  );
-ok( $result eq 0 );
+        );
+        ok( $result eq 0 );
 
-print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
-cleanup1( $basedir, $dev );
+        print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+        cleanup1( $basedir, $dev );
+    }
 
-##########################################################################
-# fscontext   - Sets the overarching filesystem label to a specific security
-#               context. This filesystem label is separate from the individual
-#               labels on the files.
-#   Tested by - Mount a tmpfs (fs_use_trans) filesystem with fscontext= and
-#               then create a file within it, checking its context.
-##########################################################################
-$fs_type = "tmpfs";
-mk_mntpoint_1("$basedir/mntpoint");
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-$fscontext_opts =
+    ##########################################################################
+    # fscontext   - Sets the overarching filesystem label to a specific
+    #               security context. This filesystem label is separate from
+    #               the individual labels on the files.
+    #   Tested by - Mount a tmpfs (fs_use_trans) filesystem with fscontext=
+    #               and then create a file within it, checking its context.
+    ##########################################################################
+    $fs_type = "tmpfs";
+    mk_mntpoint_1($private_path);
+    ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+    $fscontext_opts =
 "fscontext=system_u:object_r:test_filesystem_fscontext_fs_t:s0,size=10M,mode=0770";
 
-print "Testing 'fscontext=' mount option\n";
-print "Mount tmpfs filesystem on $basedir/mntpoint/mp1\n";
-print "Using mount options:\n\t$fscontext_opts\n";
-$result = system(
+    print "Testing 'fscontext=' mount option\n";
+    print "Mount tmpfs filesystem on $basedir/mntpoint/mp1\n";
+    print "Using mount options:\n\t$fscontext_opts\n";
+    $result = system(
 "runcon -t test_filesystem_fscontext_t $basedir/fsmount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $fscontext_opts $v"
-);
-ok( $result eq 0 );
+    );
+    ok( $result eq 0 );
 
-print "Creating test file $basedir/mntpoint/mp1/test_file\n";
-$result =
-  system(
-"runcon -t test_filesystem_fscontext_t $filesystem_dir/create_file_change_context -t test_filesystem_filecon_t -f $basedir/mntpoint/mp1/test_file $v"
-  );
-ok( $result eq 0 );
+    print "Creating test file $basedir/mntpoint/mp1/test_file\n";
+    $result =
+      system(
+"runcon -t test_filesystem_fscontext_t $filesystem_dir/create_file_change_context -t test_filesystem_filecon_t -f $private_path/mp1/test_file $v"
+      );
+    ok( $result eq 0 );
 
-print "Unmount filesystem from $basedir/mntpoint/mp1\n";
-$result =
-  system(
+    print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+    $result =
+      system(
 "runcon -t test_filesystem_fscontext_t $filesystem_dir/umount -t $basedir/mntpoint/mp1 $v"
-  );
-ok( $result eq 0 );
+      );
+    ok( $result eq 0 );
 
-print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
-cleanup1( $basedir, $dev );
+    print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+    cleanup1( $basedir, $dev );
+}
 
-reaper( \@device_list, $filesystem_dir, $v );
+reaper( \@device_list, $basedir, $v );
 
 if ($disable_udisks) {
     udisks2_restart($udisks2_status);
diff --git a/tests/nfs_filesystem/test b/tests/nfs_filesystem/test
new file mode 100755
index 0000000..a98e749
--- /dev/null
+++ b/tests/nfs_filesystem/test
@@ -0,0 +1,359 @@
+#!/usr/bin/perl
+use Test::More;
+
+# These are specific NFS tests that must run on an initial mount with various
+# context mount options.
+#
+# This script is entered with the following set by tools/nfs.sh:
+#    export NFS_TESTDIR=$TESTDIR
+#    export NFS_MOUNT=$MOUNT
+#    exportfs -orw,no_root_squash,security_label localhost:$MOUNT
+
+BEGIN {
+    $basedir = $0;
+    $basedir =~ s|(.*)/[^/]*|$1|;
+
+    $filesystem_dir    = "$basedir/../filesystem";
+    $fs_filesystem_dir = "$basedir/../fs_filesystem";
+
+    $testdir = $ENV{'NFS_TESTDIR'};
+    $mount   = $ENV{'NFS_MOUNT'};
+    if ( defined $testdir and defined $mount ) {
+        $fs_type = "nfs";
+        $dev     = "localhost:$testdir";
+        $target  = "/mnt/selinux-testsuite";
+    }
+    else {
+        plan skip_all => "These tests must be run via tools/nfs.sh";
+    }
+
+    # Allow info to be shown.
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
+    plan tests => 56;
+}
+
+# Set for testing mount(2) on first run
+$mount_cmd = "$filesystem_dir/mount";
+$test_msg  = "Using mount(2)";
+$net_opts  = "nfsvers=4.2,proto=tcp,clientaddr=127.0.0.1,addr=127.0.0.1";
+
+$i = 0;
+while ( $i < 2 ) {
+
+    #
+    # NFS: Ensure security label is set for root inode patch.
+    # Perform mount of a security_label exported filesystem, check the
+    # label of the mounted directory to confirm it isn't unlabeled.
+    #
+    system("mkdir -p $basedir/mntpoint/mp1 2>/dev/null");
+
+    # Setting MP to unlabeled_t
+    $result =
+      system(
+"runcon -t test_filesystem_t $filesystem_dir/check_mount_context -r -m $basedir/mntpoint/mp1 $v"
+      );
+    ok( $result eq 0 );
+
+    $mount_opts =
+      "$net_opts,context=system_u:object_r:test_filesystem_file_t:s0";
+
+    #    $mount_opts = $net_opts;
+    $result = system(
+"runcon -t test_filesystem_t $mount_cmd $v -s $dev -t $target -f $fs_type -o $mount_opts"
+    );
+    ok( $result eq 0, $test_msg );
+
+    # Check MP context
+    $result = system(
+"runcon -t test_filesystem_t $filesystem_dir/check_mount_context -m $target/tests/nfs_filesystem/mntpoint/mp1 -e system_u:object_r:test_filesystem_file_t:s0 $v"
+    );
+    ok( $result eq 0 );
+
+    $result =
+      system(
+        "runcon -t test_filesystem_t $filesystem_dir/umount $v -t $target");
+    ok( $result eq 0, $test_msg );
+
+    system("rm -rf $basedir/mntpoint 2>/dev/null");
+
+    #
+    # Mount a security_label exported NFS filesystem twice, confirm that
+    # NFS security labeling support isn't silently disabled by trying to
+    # set a label on a file and confirm it is set (fixed by  kernel commit
+    # 3815a245b50124f0865415dcb606a034e97494d4).
+    #
+    system("mkdir -p $basedir/mntpoint/mp1 2>/dev/null");
+
+    $mount_opts = $net_opts;
+    $result     = system(
+"runcon -t test_filesystem_t $mount_cmd $v -s $dev -t $target -f $fs_type -o $mount_opts"
+    );
+    ok( $result eq 0, $test_msg );
+
+    # First mount(2) ok, second currently fails with EBUSY
+    $result = system(
+"runcon -t test_filesystem_t $mount_cmd $v -s $dev -t $target -f $fs_type -o $mount_opts 2>&1"
+    );
+    if ( $i eq 0 and $result >> 8 eq 16 ) {
+        ok( 1, "$test_msg - returned EBUSY, possible bug/feature" );
+    }
+    else {
+        ok( $result eq 0 );
+    }
+
+    # Create file and change context via type_transition rule, check ok:
+    $result = system(
+"runcon -t test_filesystem_t $filesystem_dir/create_file -f $target/tests/nfs_filesystem/mntpoint/mp1/test_file -e test_filesystem_filetranscon_t $v"
+    );
+    ok( $result eq 0 );
+
+    $result =
+      system(
+        "runcon -t test_filesystem_t $filesystem_dir/umount $v -t $target");
+    ok( $result eq 0, $test_msg );
+
+    system(
+        "runcon -t test_filesystem_t $filesystem_dir/umount $v -t $target 2>&1"
+    );
+
+    system("rm -rf $basedir/mntpoint 2>/dev/null");
+
+    #
+    # Perform a context= mount of a security_label exported NFS
+    # filesystem, check that pre-existing files within the mount show up
+    # with the context= value not the underlying xattr value (fixed by kernel
+    # commit 0b4d3452b8b4a5309b4445b900e3cec022cca95a).
+    #
+    system("mkdir -p $basedir/mntpoint/mp1 2>/dev/null");
+
+    $result = system(
+"runcon -t test_filesystem_t $filesystem_dir/create_file -f $basedir/mntpoint/mp1/test_file -e test_filesystem_filetranscon_t $v"
+    );
+    ok( $result eq 0 );
+
+    $mount_opts =
+      "$net_opts,context=system_u:object_r:test_filesystem_file_t:s0";
+
+    $result = system(
+"runcon -t test_filesystem_t $mount_cmd $v -s $dev -t $target -f $fs_type -o $mount_opts"
+    );
+    ok( $result eq 0, $test_msg );
+
+    $result = system(
+"runcon -t test_filesystem_t $filesystem_dir/check_file_context -f $target/tests/nfs_filesystem/mntpoint/mp1/test_file -e system_u:object_r:test_filesystem_file_t:s0 $v"
+    );
+    ok( $result eq 0 );
+
+    $result =
+      system(
+        "runcon -t test_filesystem_t $filesystem_dir/umount $v -t $target");
+    ok( $result eq 0, $test_msg );
+
+    system("rm -rf $basedir/mntpoint 2>/dev/null");
+
+    #
+    # Deny filesystem { relabelfrom } for hooks.c may_context_mount_sb_relabel()
+    #
+    system("rm -rf $basedir/mntpoint 2>/dev/null");
+    system("mkdir -p $basedir/mntpoint/mp1 2>/dev/null");
+    $mount_opts =
+"$net_opts,fscontext=system_u:object_r:test_filesystem_sb_relabel_no_relabelfrom_t:s0";
+
+    $result = system(
+"runcon -t test_filesystem_sb_relabel_no_relabelfrom_t $mount_cmd $v -s $dev -t $target -f $fs_type -o $mount_opts 2>&1"
+    );
+    ok( $result >> 8 eq 13, $test_msg );
+
+    system("rm -rf $basedir/mntpoint 2>/dev/null");
+
+    #
+    # Deny filesystem { relabelto } for hooks.c may_context_mount_sb_relabel()
+    #
+    system("rm -rf $basedir/mntpoint 2>/dev/null");
+    system("mkdir -p $basedir/mntpoint/mp1 2>/dev/null");
+    $mount_opts =
+"$net_opts,fscontext=system_u:object_r:test_filesystem_sb_relabel_no_relabelto_t:s0";
+
+    $result = system(
+"runcon -t test_filesystem_sb_relabel_no_relabelto_t $mount_cmd $v -s $dev -t $target -f $fs_type -o $mount_opts 2>&1"
+    );
+    ok( $result >> 8 eq 13, $test_msg );
+
+    system("rm -rf $basedir/mntpoint 2>/dev/null");
+
+    #
+    # Deny filesystem { associate } for hooks.c
+    # may_context_mount_inode_relabel()
+    #
+    system("rm -rf $basedir/mntpoint 2>/dev/null");
+    system("mkdir -p $basedir/mntpoint/mp1 2>/dev/null");
+    $mount_opts =
+"$net_opts,context=system_u:object_r:test_filesystem_inode_relabel_no_associate_t:s0";
+
+    $result = system(
+"runcon -t test_filesystem_inode_relabel_no_associate_t $mount_cmd $v -s $dev -t $target -f $fs_type -o $mount_opts 2>&1"
+    );
+    ok( $result >> 8 eq 13, $test_msg );
+
+    system("rm -rf $basedir/mntpoint 2>/dev/null");
+
+    #
+    # Deny filesystem { relabelfrom } for hooks.c
+    # may_context_mount_inode_relabel()
+    #
+    system("mkdir -p $basedir/mntpoint/mp1 2>/dev/null");
+    $mount_opts =
+      "$net_opts,fscontext=system_u:object_r:test_filesystem_file_t:s0";
+
+    $result = system(
+"runcon -t test_filesystem_no_inode_no_relabelfrom_t $mount_cmd $v -s $dev -t $target -f $fs_type -o $mount_opts 2>&1"
+    );
+    ok( $result >> 8 eq 13, $test_msg );
+
+    system("rm -rf $basedir/mntpoint 2>/dev/null");
+
+    #
+    # Deny filesystem { associate } for hooks.c may_create()
+    #
+    system("mkdir -p $basedir/mntpoint/mp1 2>/dev/null");
+
+    system("rm -f $target/tests/nfs_filesystem/mntpoint/mp1/test_file");
+
+    $mount_opts =
+"$net_opts,fscontext=system_u:object_r:test_filesystem_may_create_no_associate_t:s0";
+
+    $result = system(
+"runcon -t test_filesystem_may_create_no_associate_t $mount_cmd $v -s $dev -t $target -f $fs_type -o $mount_opts"
+    );
+    ok( $result eq 0, $test_msg );
+
+    $result = system(
+"runcon -t test_filesystem_may_create_no_associate_t $filesystem_dir/create_file_change_context $v -t unconfined_t -f $target/tests/nfs_filesystem/mntpoint/mp1/test_file 2>&1"
+    );
+    ok( $result >> 8 eq 13, $test_msg );    # EACCES
+
+    $result = system(
+"runcon -t test_filesystem_may_create_no_associate_t $filesystem_dir/umount $v -t $target"
+    );
+    ok( $result eq 0, $test_msg );
+
+    system("rm -rf $basedir/mntpoint 2>/dev/null");
+
+    #
+    # Deny filesystem { associate } for hooks.c selinux_inode_setxattr()
+    #
+    system("mkdir -p $basedir/mntpoint/mp1 2>/dev/null");
+    $mount_opts =
+"$net_opts,fscontext=system_u:object_r:test_filesystem_inode_setxattr_no_associate_t:s0";
+
+    $result = system(
+"runcon -t test_filesystem_inode_setxattr_no_associate_t $mount_cmd $v -s $dev -t $target -f $fs_type -o $mount_opts"
+    );
+    ok( $result eq 0, $test_msg );
+
+    $result = system(
+"runcon -t test_filesystem_inode_setxattr_no_associate_t $filesystem_dir/create_file_change_context $v -t unconfined_t -f $target/tests/nfs_filesystem/mntpoint/mp1/test_file 2>&1"
+    );
+    ok( $result >> 8 eq 13, $test_msg );    # EACCES
+
+    $result = system(
+"runcon -t test_filesystem_inode_setxattr_no_associate_t $filesystem_dir/umount $v -t $target"
+    );
+    ok( $result eq 0, $test_msg );
+
+    system("rm -rf $basedir/mntpoint 2>/dev/null");
+
+    #
+    # Test context mounts when exported with security_label.
+    #
+    system("mkdir -p $basedir/mntpoint/mp1 2>/dev/null");
+    $mount_opts = "$net_opts,context=system_u:object_r:etc_t:s0";
+
+    $result = system(
+"runcon -t test_filesystem_t $mount_cmd $v -s $dev -t $target -f $fs_type -o $mount_opts"
+    );
+    $fctx = `secon -t -f /mnt/selinux-testsuite`;
+    chomp($fctx);
+    if ( $fctx ne "etc_t" ) {
+        ok( 0, "$test_msg - got $fctx instead of etc_t" );
+    }
+    else {
+        ok( $result eq 0, $test_msg );
+    }
+
+    $result =
+      system(
+        "runcon -t test_filesystem_t $filesystem_dir/umount $v -t $target");
+    ok( $result eq 0, $test_msg );
+
+    system("rm -rf $basedir/mntpoint 2>/dev/null");
+
+    #
+    # Test context mounts when not exported with security_label.
+    #
+    system("mkdir -p $basedir/mntpoint/mp1 2>/dev/null");
+    `exportfs -u localhost:$mount`;
+    `exportfs -orw,no_root_squash localhost:$mount`;
+    $mount_opts = "$net_opts,context=system_u:object_r:etc_t:s0";
+
+    $result = system(
+"runcon -t test_filesystem_t $mount_cmd $v -s $dev -t $target -f $fs_type -o $mount_opts"
+    );
+    $fctx = `secon -t -f /mnt/selinux-testsuite`;
+    chomp($fctx);
+    if ( $fctx ne "etc_t" ) {
+        ok( 0, "$test_msg - got $fctx instead of etc_t" );
+    }
+    else {
+        ok( $result eq 0, $test_msg );
+    }
+
+    $result =
+      system(
+        "runcon -t test_filesystem_t $filesystem_dir/umount $v -t $target");
+    ok( $result eq 0, $test_msg );
+
+    system("rm -rf $basedir/mntpoint 2>/dev/null");
+
+    #
+    # Test non-context mount when not exported with security_label.
+    #
+    system("mkdir -p $basedir/mntpoint/mp1 2>/dev/null");
+    $mount_opts = $net_opts;
+
+    $result = system(
+"runcon -t test_filesystem_t $mount_cmd $v -s $dev -t $target -f $fs_type -o $mount_opts"
+    );
+    $fctx = `secon -t -f /mnt/selinux-testsuite`;
+    chomp($fctx);
+    if ( $fctx ne "nfs_t" ) {
+        ok( 0, "$test_msg - got $fctx instead of nfs_t" );
+    }
+    else {
+        ok( $result eq 0, $test_msg );
+    }
+
+    $result =
+      system(
+        "runcon -t test_filesystem_t $filesystem_dir/umount $v -t $target");
+    ok( $result eq 0, $test_msg );
+
+    system("rm -rf $basedir/mntpoint 2>/dev/null");
+
+    # Reset for testing fsopen(2), fsconfig(2), fsmount(2) and move_mount(2)
+    $mount_cmd = "$fs_filesystem_dir/fsmount";
+    $test_msg  = "Using fsmount(2)";
+    `exportfs -orw,no_root_squash,security_label localhost:$mount`;
+    $i++;
+}
+
+exit;
-- 
2.24.1

