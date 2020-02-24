Return-Path: <SRS0=m/sx=4M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D28C11D2F
	for <selinux@archiver.kernel.org>; Mon, 24 Feb 2020 14:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5002082F
	for <selinux@archiver.kernel.org>; Mon, 24 Feb 2020 14:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="efLHrxaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgBXOPh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Feb 2020 09:15:37 -0500
Received: from mailomta29-sa.btinternet.com ([213.120.69.35]:63854 "EHLO
        sa-prd-fep-044.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727691AbgBXOPh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Feb 2020 09:15:37 -0500
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-044.btinternet.com with ESMTP
          id <20200224141529.BZRG14120.sa-prd-fep-044.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>;
          Mon, 24 Feb 2020 14:15:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1582553729; 
        bh=KyOQ2efYW1B4nfF9F5rWuvekLh7RX4qqoecFst4aU5o=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=efLHrxaEvKdU6nwRk8YgpP5gnei1dSB4PAlhozB5F73EiuCETSp6cHg9M04WD9HBqJz2TG5EdGdk5dRvGJ9adFaRqRWILZ7dYdUxFPIWxXNvU01claYVkEcyBf5nYaX6mOB2LB2s1jbI9SnZB6BO9WB9ClPNZvNeGKxygZn2TnG1QtUksZh08nM15vkh/32G/vEfhhuak4b/g/RwL3SIWEZmZcjZA4utHvDorXOha7V7fjtMWwEG8KIX4LaVlBDI7NlEX21YWAebQ0NfsQiPk6+arZuCe1UyuP/OCW7AYdb1s7BGDGF+LjWNETxCCPok9kn6jn4FZoNxw5Sp+MXTmQ==
Authentication-Results: btinternet.com; none
X-Originating-IP: [31.49.59.100]
X-OWM-Source-IP: 31.49.59.100 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrledtgdeivdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuffhomhgrihhnpehrvgguhhgrthdrtghomhenucfkphepfedurdegledrheelrddutddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrgeelrdehledruddttddpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsughssehthigthhhordhnshgrrdhgohhvqedprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.49.59.100) by sa-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A290C0309E38E; Mon, 24 Feb 2020 14:15:29 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org, sds@tycho.nsa.gov
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [RFC V2 PATCH 1/2] selinux-testsuite: Use native filesystem for tests - Part 1
Date:   Mon, 24 Feb 2020 14:15:23 +0000
Message-Id: <20200224141524.407114-2-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200224141524.407114-1-richard_c_haines@btinternet.com>
References: <20200224141524.407114-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use the filesystem type that the selinux-testsuite is running from to be
used for tests/filesystem. Tested types: ext4, xfs, vfat and nfs.

If testing locally -f <fs_type> can be used to test a specific type.

For NFS the following example shows how this should be run:
    ./tools/nfs.sh filesystem -v -e -f ext4

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 README.md                          |   10 +-
 defconfig                          |    6 +
 policy/test_filesystem.te          |   78 +-
 policy/test_filesystem_notify.te   |   56 +-
 tests/filesystem/.gitignore        |    1 +
 tests/filesystem/Filesystem.pm     |  127 ++-
 tests/filesystem/Makefile          |    3 +-
 tests/filesystem/test              | 1184 ++++++++++++++++++----------
 tests/filesystem/xfs_quotas_test.c |   96 +++
 tools/nfs.sh                       |   39 +-
 10 files changed, 1131 insertions(+), 469 deletions(-)
 create mode 100644 tests/filesystem/xfs_quotas_test.c

diff --git a/README.md b/README.md
index 27c9d56..21c1e74 100644
--- a/README.md
+++ b/README.md
@@ -73,7 +73,9 @@ following command:
 		libbpf-devel \
 		keyutils-libs-devel \
 		kernel-devel \
-		quota
+		quota \
+		xfsprogs-devel \
+		libuuid-devel
 
 The testsuite requires a pre-existing base policy configuration of SELinux,
 using either the old example policy or the reference policy as the baseline.
@@ -164,6 +166,12 @@ security_label export option and will test default NFS file labeling
 in the absence of any options.  When finished, it will unmount and
 unexport the mount and then stop the nfs-server.
 
+There is also an option to allow individual tests to be run on NFS as
+shown by the following example (ensure a valid policy is loaded):
+
+       # cd selinux-testsuite
+       # ./tools/nfs.sh fs_filesystem -v
+
 ## Running the Tests
 
 Create a shell with the `unconfined_r` or `sysadm_r` role and the Linux
diff --git a/defconfig b/defconfig
index 8419e40..00bf9f3 100644
--- a/defconfig
+++ b/defconfig
@@ -104,3 +104,9 @@ CONFIG_NFS_V4_SECURITY_LABEL=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V4=y
 CONFIG_NFSD_V4_SECURITY_LABEL=y
+
+# Test XFS and VFAT filesystems.
+# This is not required for SELinux operation itself.
+CONFIG_XFS_FS=m
+CONFIG_XFS_QUOTA=y
+CONFIG_VFAT_FS=m
diff --git a/policy/test_filesystem.te b/policy/test_filesystem.te
index 09f9d4a..c7d6fc1 100644
--- a/policy/test_filesystem.te
+++ b/policy/test_filesystem.te
@@ -6,6 +6,28 @@
 attribute filesystemdomain;
 kernel_setsched(filesystemdomain)
 
+# For module filesystems
+kernel_request_load_module(filesystemdomain)
+
+# Lots of searches required, however this covers up the unlabeled_t NFS bug
+#files_search_all(filesystemdomain)
+
+#
+########## NFS BUG 'unlabeled_t rules' NFS BUG ########################
+# Ref: https://bugzilla.redhat.com/show_bug.cgi?id=1625955
+# These rules can be commented out to cause the NFS bug when using:
+#     mount -t nfs -o vers=4.2 localhost:$TESTDIR /mnt/selinux-testsuite
+# And:
+#     mount -t nfs -o vers=4.2,fscontext=system_u:object_r:test_filesystem_file_t:s0
+#           localhost:$TESTDIR /mnt/selinux-testsuite
+#
+allow test_filesystem_no_getattr_t unlabeled_t:dir { search };
+allow test_filesystem_no_mount_t unlabeled_t:dir { search };
+allow test_filesystem_no_remount_t unlabeled_t:dir { search };
+allow test_filesystem_no_unmount_t unlabeled_t:dir { search };
+allow test_move_mount_no_mounton_t unlabeled_t:dir { search };
+######################## End NFS bug ####################
+
 #################### Create test file contexts ######################
 type test_filesystem_filecon_t;
 files_type(test_filesystem_filecon_t)
@@ -26,9 +48,9 @@ typeattribute test_filesystem_t filesystemdomain;
 
 allow test_filesystem_t self:capability { sys_admin };
 allow test_filesystem_t self:filesystem { mount remount quotamod relabelfrom relabelto unmount quotaget };
-allow test_filesystem_t test_file_t:dir { add_name mounton write remove_name rmdir };
+allow test_filesystem_t test_file_t:dir { add_name mounton read write remove_name rmdir };
 # Create test file
-allow test_filesystem_t test_filesystem_file_t:dir { read add_name write search };
+allow test_filesystem_t test_filesystem_file_t:dir { read add_name write search mounton };
 allow test_filesystem_t test_filesystem_file_t:file { open getattr create write relabelfrom relabelto };
 
 fs_mount_all_fs(test_filesystem_t)
@@ -58,6 +80,9 @@ type_transition test_filesystem_t test_filesystem_file_t:file test_filesystem_fi
 allow test_filesystem_t test_filesystem_filetranscon_t:file { create getattr open write relabelfrom };
 dontaudit unconfined_t test_filesystem_filetranscon_t:file { getattr read };
 
+# Allow enabling XFS quotas:
+allow test_filesystem_t test_filesystem_file_t:dir { quotaon };
+
 #################### Deny filesystem { relabelfrom } ######################
 # hooks.c may_context_mount_sb_relabel() FILESYSTEM__RELABELFROM
 type test_filesystem_sb_relabel_no_relabelfrom_t;
@@ -182,9 +207,11 @@ typeattribute test_file_no_quotaon_t testdomain;
 typeattribute test_file_no_quotaon_t filesystemdomain;
 
 allow test_file_no_quotaon_t self:capability { sys_admin };
-allow test_file_no_quotaon_t self:filesystem { quotamod relabelto mount unmount relabelfrom };
+allow test_file_no_quotaon_t self:filesystem { quotamod quotaget relabelto mount unmount relabelfrom };
 allow test_file_no_quotaon_t test_file_t:dir { mounton write remove_name rmdir };
 # neverallow test_file_no_quotaon_t self:file { quotaon };
+# For XFS:
+# neverallow allow test_file_no_quotaon_t self:dir { quotaon };
 fs_mount_all_fs(test_file_no_quotaon_t)
 fs_relabelfrom_all_fs(test_file_no_quotaon_t)
 fs_associate(test_file_no_quotaon_t)
@@ -249,8 +276,8 @@ fs_mount_all_fs(test_move_mount_no_mounton_t)
 fs_unmount_all_fs(test_move_mount_no_mounton_t)
 fs_relabelfrom_all_fs(test_move_mount_no_mounton_t)
 fs_associate(test_move_mount_no_mounton_t)
-allow test_move_mount_no_mounton_t test_file_t:dir { mounton write remove_name rmdir };
-# neverallow test_move_mount_no_mounton_t self:dir { mounton };
+allow test_move_mount_no_mounton_t test_file_t:dir { write remove_name rmdir };
+# neverallow test_move_mount_no_mounton_t test_file_t:dir { mounton };
 
 #################### Deny filesystem { unmount } ######################
 # hooks.c selinux_umount() FILESYSTEM__UNMOUNT
@@ -373,6 +400,47 @@ allow test_filesystem_fscontext_t test_filesystem_context_file_t:file { create g
 allow test_filesystem_context_t test_file_t:dir { relabelfrom };
 allow test_filesystem_context_t unlabeled_t:dir { mounton relabelto };
 
+#
+############### Rules for NFS mount with no context option ##################
+#
+userdom_search_user_home_content(filesystemdomain)
+fs_search_nfs(filesystemdomain)
+allow test_filesystem_t test_file_t:file { create write relabelfrom };
+
+#
+############### Rules for NFS mount with rootcontext option #################
+#
+allow test_filesystem_no_getattr_t test_filesystem_file_t:dir { search mounton };
+allow test_filesystem_no_mount_t test_filesystem_file_t:dir { search mounton };
+allow test_filesystem_no_remount_t test_filesystem_file_t:dir { search mounton };
+allow test_filesystem_no_unmount_t test_filesystem_file_t:dir { search mounton };
+allow test_filesystem_t test_filesystem_file_t:filesystem { getattr mount remount unmount relabelto relabelfrom };
+
+#
+############### Rules for NFS mount with fscontext option ####################
+#
+allow test_file_t test_filesystem_file_t:filesystem { associate };
+allow test_setfscreatecon_newcon_t test_filesystem_file_t:filesystem { associate };
+allow test_filesystem_filecon_t test_filesystem_file_t:filesystem { associate };
+allow test_filesystem_no_getattr_t test_filesystem_file_t:filesystem { mount unmount relabelfrom relabelto };
+allow test_filesystem_no_mount_t test_filesystem_file_t:filesystem { relabelfrom relabelto };
+allow test_filesystem_no_remount_t test_filesystem_file_t:filesystem { mount unmount relabelfrom relabelto };
+allow test_filesystem_no_unmount_t test_filesystem_file_t:filesystem { mount relabelfrom relabelto };
+
+#
+############ Rules for VFAT ##############################
+#
+gen_require(`
+	type dosfs_t;
+')
+allow test_filesystem_t dosfs_t:file { open getattr write };
+allow test_filesystem_context_t dosfs_t:file { open getattr write };
+allow test_filesystem_no_getattr_t dosfs_t:filesystem { associate };
+allow test_filesystem_no_mount_t dosfs_t:filesystem { associate };
+allow test_filesystem_no_remount_t dosfs_t:filesystem { associate };
+allow test_filesystem_no_unmount_t dosfs_t:filesystem { associate };
+allow test_move_mount_no_mounton_t dosfs_t:filesystem { associate };
+
 #
 ########### Allow these domains to be entered from sysadm domain ############
 #
diff --git a/policy/test_filesystem_notify.te b/policy/test_filesystem_notify.te
index 3e8a246..c9ef73a 100644
--- a/policy/test_filesystem_notify.te
+++ b/policy/test_filesystem_notify.te
@@ -2,15 +2,55 @@
 ######### Test filesystem fanotify(7) policy module ##########
 #
 
+#
+########## NFS BUG 'unlabeled_t rules' NFS BUG ########################
+# Ref: https://bugzilla.redhat.com/show_bug.cgi?id=1625955
+# These rules can be commented out to cause the NFS bug when using:
+#     mount -t nfs -o vers=4.2 localhost:$TESTDIR /mnt/selinux-testsuite
+# And:
+#     mount -t nfs -o vers=4.2,fscontext=system_u:object_r:test_filesystem_file_t:s0
+#           localhost:$TESTDIR /mnt/selinux-testsuite
+#
+allow test_filesystem_no_watch_mount_t unlabeled_t:dir { search };
+allow test_filesystem_no_watch_sb_t unlabeled_t:dir { search };
+allow test_filesystem_no_watch_t unlabeled_t:dir { search };
+######################## End NFS bug ####################
+
 ################# Test all functions ##########################
 # For fanotify tests
 allow test_filesystem_t self:filesystem { watch };
-# Until 'fs_watch_all_fs(test_filesystem_t)' in Policy use:
-gen_require(`
-	type fs_t;
-')
-allow test_filesystem_t fs_t:filesystem { watch };
 allow test_filesystem_t test_filesystem_file_t:dir { watch_sb watch_mount };
+# For nfs
+allow test_filesystem_t nfs_t:filesystem { watch };
+allow test_filesystem_t test_file_t:dir { watch_mount watch_sb };
+# For vfat
+allow test_filesystem_t dosfs_t:filesystem { watch };
+
+#
+############### Rules for NFS mount with rootcontext option #################
+#
+userdom_search_user_home_content(filesystemdomain)
+allow test_filesystem_no_watch_mount_t nfs_t:filesystem { unmount };
+allow test_filesystem_no_watch_mount_t test_filesystem_file_t:dir { search };
+allow test_filesystem_no_watch_sb_t nfs_t:filesystem { unmount watch };
+allow test_filesystem_no_watch_sb_t test_filesystem_file_t:dir { search };
+allow test_filesystem_no_watch_t nfs_t:filesystem { unmount };
+allow test_filesystem_no_watch_t test_filesystem_file_t:dir { search };
+
+#
+############### Rules for NFS mount with no context option ##################
+#
+allow test_filesystem_no_watch_mount_t nfs_t:dir { search };
+allow test_filesystem_no_watch_sb_t nfs_t:dir { search };
+allow test_filesystem_no_watch_t nfs_t:dir { search };
+
+#
+############### Rules for NFS mount with fscontext option ####################
+#
+allow test_filesystem_no_watch_mount_t test_filesystem_file_t:filesystem { mount unmount relabelto };
+allow test_filesystem_no_watch_sb_t test_filesystem_file_t:filesystem { mount unmount relabelto watch };
+allow test_filesystem_no_watch_t test_filesystem_file_t:filesystem { mount unmount relabelto };
+allow test_filesystem_t test_filesystem_file_t:filesystem watch;
 
 #################### Deny filesystem { watch } ######################
 # hooks.c selinux_path_notify() FILESYSTEM__WATCH
@@ -22,7 +62,7 @@ typeattribute test_filesystem_no_watch_t filesystemdomain;
 
 allow test_filesystem_no_watch_t self:capability { sys_admin };
 allow test_filesystem_no_watch_t self:filesystem { associate relabelto mount unmount relabelfrom };
-allow test_filesystem_no_watch_t test_file_t:dir { mounton write remove_name rmdir };
+allow test_filesystem_no_watch_t test_file_t:dir { mounton read write remove_name rmdir watch_sb };
 fs_mount_all_fs(test_filesystem_no_watch_t)
 fs_relabelfrom_all_fs(test_filesystem_no_watch_t)
 fs_associate(test_filesystem_no_watch_t)
@@ -37,7 +77,7 @@ typeattribute test_filesystem_no_watch_sb_t filesystemdomain;
 
 allow test_filesystem_no_watch_sb_t self:capability { sys_admin };
 allow test_filesystem_no_watch_sb_t self:filesystem { watch associate relabelto mount unmount relabelfrom };
-allow test_filesystem_no_watch_sb_t test_file_t:dir { mounton write remove_name rmdir };
+allow test_filesystem_no_watch_sb_t test_file_t:dir { mounton read write remove_name rmdir };
 
 fs_mount_all_fs(test_filesystem_no_watch_sb_t)
 fs_relabelfrom_all_fs(test_filesystem_no_watch_sb_t)
@@ -53,7 +93,7 @@ typeattribute test_filesystem_no_watch_mount_t filesystemdomain;
 
 allow test_filesystem_no_watch_mount_t self:capability { sys_admin };
 allow test_filesystem_no_watch_mount_t self:filesystem { watch associate relabelto mount unmount relabelfrom };
-allow test_filesystem_no_watch_mount_t test_file_t:dir { mounton write remove_name rmdir };
+allow test_filesystem_no_watch_mount_t test_file_t:dir { mounton read write remove_name rmdir };
 
 fs_mount_all_fs(test_filesystem_no_watch_mount_t)
 fs_relabelfrom_all_fs(test_filesystem_no_watch_mount_t)
diff --git a/tests/filesystem/.gitignore b/tests/filesystem/.gitignore
index 5ac18d0..e76fcd3 100644
--- a/tests/filesystem/.gitignore
+++ b/tests/filesystem/.gitignore
@@ -9,3 +9,4 @@ check_file_context
 check_mount_context
 create_file
 grim_reaper
+xfs_quotas_test
diff --git a/tests/filesystem/Filesystem.pm b/tests/filesystem/Filesystem.pm
index a08570a..8a18ddb 100644
--- a/tests/filesystem/Filesystem.pm
+++ b/tests/filesystem/Filesystem.pm
@@ -1,10 +1,10 @@
 package Filesystem;
 use Exporter qw(import);
 our @EXPORT_OK =
-  qw(check_config udisks2_stop udisks2_restart get_loop_dev attach_dev make_fs mk_mntpoint_1 mk_mntpoint_2 cleanup cleanup1 reaper);
+  qw(check_config udisks2_stop udisks2_restart get_loop_dev attach_dev make_fs mk_mntpoint_1 mk_mntpoint_2 cleanup cleanup1 reaper nfs_gen_opts);
 
 sub check_config {
-    my ( $base, $fanotify_fs ) = @_;
+    my ( $base, $fanotify_fs, $nfs_enabled, $vfat_enabled ) = @_;
 
     $tst_count = 0;
 
@@ -25,15 +25,26 @@ sub check_config {
     $mod_pol_vers      = `checkmodule -V | cut -f 2 -d '-'`;
     $max_kernel_policy = `cat /sys/fs/selinux/policyvers`;
 
-    if ( $mod_pol_vers >= 11 and $pol_vers >= 25 and $max_kernel_policy >= 25 )
-    {
-        $name_trans = 1;
-        $tst_count += 2;
+    if ( not $nfs_enabled and not $vfat_enabled ) {
+        if (    $mod_pol_vers >= 11
+            and $pol_vers >= 25
+            and $max_kernel_policy >= 25 )
+        {
+            $name_trans = 1;
+            $tst_count += 2;
+        }
+    }
+
+    $type_trans = 0;
+    if ( not $nfs_enabled and not $vfat_enabled ) {
+        $type_trans = 1;
+        $tst_count += 1;
     }
-    return ( $tst_count, $watch, $name_trans );
+
+    return ( $tst_count, $watch, $name_trans, $type_trans );
 }
 
-# Optionally stop the udisks(8) daemon, then restart on exit.
+# Stop the udisks(8) daemon, then restart on exit.
 sub udisks2_stop {
     $status = 0;
 
@@ -111,9 +122,11 @@ sub attach_dev {
 
 sub make_fs {
     my ( $mk_type, $mk_dev, $mk_dir ) = @_;
+
     print "Create $mk_dir/fstest with dd\n";
-    $result = system(
-        "dd if=/dev/zero of=$mk_dir/fstest bs=1024 count=10240 2>/dev/null");
+    $result =
+      system(
+        "dd if=/dev/zero of=$mk_dir/fstest bs=4096 count=4096 2>/dev/null");
     if ( $result != 0 ) {
         print "dd failed to create $mk_dir/fstest\n";
     }
@@ -121,7 +134,7 @@ sub make_fs {
     attach_dev( $mk_dev, $mk_dir );
 
     print "Make $mk_type filesystem on $mk_dev\n";
-    $result = system("mkfs.$mk_type -I 256 $mk_dev >& /dev/null");
+    $result = system("mkfs.$mk_type $mk_dev >& /dev/null");
     if ( $result != 0 ) {
         system("losetup -d $mk_dev 2>/dev/null");
         print "mkfs.$mk_type failed to create filesystem on $mk_dev\n";
@@ -164,3 +177,95 @@ sub reaper {
         system("$base/grim_reaper -t $n $v 2>/dev/null");
     }
 }
+
+sub nfs_gen_opts {
+
+    my ( $type, $base, $filesys ) = @_;
+
+    $mnt_entry = `findmnt -fUln -t $type -T $base`;
+    my @mnt_item = split " ", $mnt_entry;
+
+    $tgt  = $mnt_item[0];
+    $src  = $mnt_item[1];
+    $type = $mnt_item[2];
+
+    # Use a common $dev entry for all tests
+    $dev = "$src/tests/$filesys/mntpoint";
+
+    # Build mandatory nfs options, some of which mount.nfs(8) would resolve
+    ($clientaddr) = ( $mnt_item[3] =~ /clientaddr=([^,\/]+)/ );
+    chomp($clientaddr);
+    $clientaddr = "clientaddr=$clientaddr";
+
+    # Remove items that could match e.g. clientaddr, addr
+    $mnt_item[3] =~ s/clientaddr=$clientaddr/xxxx/i;
+    ($addr) = ( $mnt_item[3] =~ /addr=([^,\/]+)/ );
+    chomp($addr);
+    $addr = "addr=$addr";
+    $mnt_item[3] =~ s/addr=$addr/xxxx/i;
+    ($proto) = ( $mnt_item[3] =~ /proto=([^,\/]+)/ );
+    chomp($proto);
+    $proto = "proto=$proto";
+    ($vers) = ( $mnt_item[3] =~ /vers=([^,\/]+)/ );
+    chomp($vers);
+    $vers = "vers=$vers";
+
+    $root_context  = " ";
+    $fs_context    = " ";
+    $rootcontext   = " ";
+    $fscontext     = " ";
+    $seclabel      = " ";
+    $seclabel_type = 0;
+    ($rootcontext) = ( $mnt_item[3] =~ /rootcontext=([^,\/]+)/ );
+    $mnt_item[3] =~ s/rootcontext=$root_context/xxxx/i;
+    ($fscontext) = ( $mnt_item[3] =~ /fscontext=([^,\/]+)/ );
+    $mnt_item[3] =~ s/fscontext=$fs_context/xxxx/i;
+    ($context) = ( $mnt_item[3] =~ /context=([^,\/]+)/ );
+
+    if ( defined $rootcontext ) {
+        $seclabel      = "rootcontext=$rootcontext";
+        $seclabel_type = 1;
+    }
+    elsif ( defined $fscontext ) {
+        $seclabel      = "fscontext=$fscontext";
+        $seclabel_type = 2;
+    }
+    elsif ( defined $context ) {
+        $seclabel      = "context=$context";
+        $seclabel_type = 3;
+    }
+    chomp($seclabel);
+
+    print "NFS mount entries:\n\ttype: $type\n\tsrc: $src\n";
+    print "\ttgt: $tgt\n\t$clientaddr\n\t$addr\n\t$proto\n\t$seclabel\n";
+
+    # Use a common set of NFS options. Note fsconfig(2) returns
+    # 'Invalid argument' if a blank entry (as $seclabel can be) is passed
+    # as a parameter (as NFS sees this as an invalid option).
+    if ( $seclabel eq " " ) {
+        $nfs_mount_opts = "$vers,$proto,$clientaddr,$addr";
+    }
+    else {
+        $nfs_mount_opts = "$vers,$proto,$clientaddr,$addr,$seclabel";
+    }
+
+    # Build option for testing 'SELinux: mount invalid. Same superblock,...'
+    # that returns EBUSY. Depends on what the initial mount set as its value
+    $inval_seclabel = $seclabel;
+    if ( $seclabel_type eq 0 ) {
+        $inval_seclabel =
+          "rootcontext=system_u:object_r:test_filesystem_file_t:s0";
+    }
+    elsif ( $seclabel_type eq 1 ) {
+        $inval_seclabel =~ s/rootcontext/fscontext/i;
+    }
+    elsif ( $seclabel_type eq 2 ) {
+        $inval_seclabel =~ s/fscontext/rootcontext/i;
+    }
+    elsif ( $seclabel_type eq 3 ) {
+        $inval_seclabel =~ s/context/fscontext/i;
+    }
+    $nfs_inval_mount_opts = "$vers,$proto,$clientaddr,$addr,$inval_seclabel";
+
+    return ( $dev, $nfs_mount_opts, $nfs_inval_mount_opts, $seclabel_type );
+}
diff --git a/tests/filesystem/Makefile b/tests/filesystem/Makefile
index d2fad63..a863ea2 100644
--- a/tests/filesystem/Makefile
+++ b/tests/filesystem/Makefile
@@ -2,7 +2,8 @@
 #export CFLAGS += -DHAVE_FS_WATCH_PERM
 
 TARGETS = mount umount quotas_test statfs_test create_file_change_context \
-fs_relabel check_file_context grim_reaper check_mount_context create_file
+fs_relabel check_file_context grim_reaper check_mount_context create_file \
+xfs_quotas_test
 
 LDLIBS += -lselinux
 
diff --git a/tests/filesystem/test b/tests/filesystem/test
index 78faf72..7074f36 100755
--- a/tests/filesystem/test
+++ b/tests/filesystem/test
@@ -10,28 +10,105 @@ BEGIN {
     use Cwd qw(abs_path);
     use lib dirname( abs_path $0);
     use Filesystem
-      qw(check_config udisks2_stop udisks2_restart get_loop_dev attach_dev make_fs mk_mntpoint_1 mk_mntpoint_2 cleanup cleanup1 reaper);
+      qw(check_config udisks2_stop udisks2_restart get_loop_dev attach_dev make_fs mk_mntpoint_1 mk_mntpoint_2 cleanup cleanup1 reaper nfs_gen_opts);
 
-    $test_count = 68;
-
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
+        plan skip_all => "To run NFS use 'tools/nfs.sh filesystem [-v]'";
+    }
+
+    # Get filesystem type if not specified
+    if ( $fs_type eq " " ) {
+        $fs_type = `findmnt -n -o FSTYPE -T $basedir`;
+        chomp $fs_type;
+    }
+
+    print "Testing filesystem fs_type: $fs_type\n";
+
+    # Obtain an appropriate set of mount options for NFS
+    # $seclabel_type: 0 = No seclabel, 1 = rootcontext, 2 = fscontext,
+    # 3 = context
+    if ( $fs_type eq "nfs4" or $fs_type eq "nfs" ) {
+        ( $dev, $nfs_mount_opts, $nfs_inval_mount_opts, $seclabel_type ) =
+          nfs_gen_opts( $fs_type, $basedir, "filesystem" );
+        $nfs_enabled = 1;
+    }
+    elsif ( $fs_type eq "vfat" ) {
+        $vfat_enabled = 1;
+    }
+
+   # XFS supports quotas internally but does not yet support security_quota_on()
+   # There is a patch for selinux/hooks.c to add quotactl(2) triggers such as
+   # Q_XQUOTAOFF.
+    if ( $fs_type eq "xfs" ) {
+        $test_count   = 66;
+        $quota_checks = 1;
+    }
+    elsif ( $fs_type eq "nfs4" or $fs_type eq "nfs" ) {
+        $test_count   = 56;
+        $quota_checks = 0;
+    }
+    elsif ( $fs_type eq "vfat" ) {
+        $test_count   = 56;
+        $quota_checks = 0;
+    }
+    else {
+        $test_count = 70;
     }
 
     # Check if watch and/or named type_transition rules configured
-    ( $addit, $test_watch, $test_name_trans ) =
-      check_config( $basedir, "$basedir/fanotify_fs" );
+    ( $addit, $test_watch, $test_name_trans, $test_type_trans ) =
+      check_config( $basedir, "$basedir/fanotify_fs", $nfs_enabled,
+        $vfat_enabled );
+
+    if ($nfs_enabled) {
+        $test_count -= 3;    # For hooks.c may_create() FILESYSTEM__ASSOCIATE
+        $test_count -=
+          3;    # For hooks.c selinux_inode_setxattr() FILESYSTEM__ASSOCIATE
+        $test_count -= 2;     # For additional Test Invalid Mount tests
+        $test_count -= 20;    # For tests involving multiple *context= options
+        if ( $seclabel_type eq 0 ) {
+            $test_count -= 4;    # If no context option set
+        }
+        elsif ( $seclabel_type eq 1 ) {
+            $test_count -= 2;    # If rootcontext option set
+        }
+        elsif ( $seclabel_type eq 2 ) {
+            $test_count -= 2;    # If fscontext option set
+        }
+    }
+    elsif ($vfat_enabled) {
+        $test_count -= 3;    # For hooks.c may_create() FILESYSTEM__ASSOCIATE
+        $test_count -=
+          3;    # For hooks.c selinux_inode_setxattr() FILESYSTEM__ASSOCIATE
+        $test_count -= 6;    # For tests with defcontext= options
+    }
 
-    plan tests => ( $test_count += $addit );
+    $test_count += $addit;
+    plan tests => $test_count;
 }
 
 # mount(2) MS_BIND | MS_PRIVATE requires an absolute path to a private mount
@@ -46,9 +123,6 @@ else {
     $private_path = "$cwd/$basedir/mntpoint";
 }
 
-# Set initial filesystem type
-$fs_type = "ext4";
-
 # Keep a list of devices used for removal at end of test.
 $device_count = 0;
 my @device_list;
@@ -63,73 +137,108 @@ cleanup($basedir);
 system("mkdir -p $basedir/mntpoint 2>/dev/null");
 
 print "Test setfscreatecon(3)\n";
-$result = system
-"runcon -t test_setfscreatecon_t $basedir/fs_relabel $v -b $basedir/mntpoint -t test_setfscreatecon_newcon_t";
+$result = system(
+"runcon -t test_setfscreatecon_t $basedir/fs_relabel $v -b $basedir/mntpoint -t test_setfscreatecon_newcon_t"
+);
 ok( $result eq 0 );
 
-$result = system
-"runcon -t test_no_setfscreatecon_t $basedir/fs_relabel $v -b $basedir/mntpoint -t test_setfscreatecon_newcon_t 2>&1";
+$result = system(
+"runcon -t test_no_setfscreatecon_t $basedir/fs_relabel $v -b $basedir/mntpoint -t test_setfscreatecon_newcon_t 2>&1"
+);
 ok( $result >> 8 eq 13 );
 
 system("rm -rf $basedir/mntpoint 2>/dev/null");
 
 ############### Test Basic Mount/Unmount ##########################
 mk_mntpoint_1($private_path);
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-make_fs( $fs_type, $dev, $basedir );
-$mount_opts1 =
-"quota,usrquota,grpquota,defcontext=system_u:object_r:test_filesystem_file_t:s0";
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
 
 print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
-print "Using mount options:\n\t$mount_opts1\n";
+print "Using mount options:\n\t$mount_opts\n";
 $result = system(
-"runcon -t test_filesystem_t $basedir/mount -s $dev -t $private_path/mp1 -f $fs_type -o $mount_opts1 $v"
+"runcon -t test_filesystem_t $basedir/mount -s $dev -t $private_path/mp1 -f $fs_type -o $mount_opts $v"
 );
 ok( $result eq 0 );
 
 print "Then remount\n";
 $result = system(
-"runcon -t test_filesystem_t $basedir/mount -r -s $dev -t $private_path/mp1 -f $fs_type -o $mount_opts1 $v"
+"runcon -t test_filesystem_t $basedir/mount -r -s $dev -t $private_path/mp1 -f $fs_type -o $mount_opts $v"
 );
 ok( $result eq 0 );
 
-print "Running quotacheck(8) to init user/group quota files\n";
+if ($quota_checks) {
+    if ( $fs_type eq "xfs" ) {
+        print "# XFS quota test with mount options: uquota,prjquota\n";
+        $result = system(
+            "runcon -t test_filesystem_t $basedir/xfs_quotas_test $v -s $dev");
+        ok( $result eq 0 );
+    }
+    else {
+        print "Running quotacheck(8) to init user/group quota files\n";
 
-# On RHEL-6, there is a type transition to quota_t when running quotacheck
-# as unconfined_t. Using "runcon `id -Z` quotacheck ..." resolves this.
-$result = system("runcon `id -Z` quotacheck -ugF vfsv0 $private_path/mp1");
-ok( $result eq 0 );
+      # On RHEL-6, there is a type transition to quota_t when running quotacheck
+      # as unconfined_t. Using "runcon `id -Z` quotacheck ..." resolves this.
+        $result =
+          system("runcon `id -Z` quotacheck -ugF vfsv0 $private_path/mp1");
+        ok( $result eq 0 );
 
-print "Toggle User & Group quotas on/off\n";
-$result = system(
+        print "Toggle User & Group quotas on/off\n";
+        $result = system(
 "runcon -t test_filesystem_t $basedir/quotas_test -s $dev -t $private_path/mp1/aquota.user $v"
-);
-ok( $result eq 0 );
-$result = system(
+        );
+        ok( $result eq 0 );
+        $result = system(
 "runcon -t test_filesystem_t $basedir/quotas_test -s $dev -t $private_path/mp1/aquota.group $v"
-);
-ok( $result eq 0 );
-
+        );
+        ok( $result eq 0 );
+    }
+}
 print "Get statfs(2)\n";
 $result =
   system(
     "runcon -t test_filesystem_t $basedir/statfs_test -t $basedir/mntpoint $v");
 ok( $result eq 0 );
 
-print
+if ($test_type_trans) {
+    print
 "Creating 'trans_test_file' and checking context changed via type_transition rule\n";
-$result =
-  system(
+    $result = system(
 "runcon -t test_filesystem_t $basedir/create_file -f $private_path/mp1/trans_test_file -e test_filesystem_filetranscon_t $v"
-  );
-ok( $result eq 0 );
+    );
+    ok( $result eq 0 );
+}
 
 print "Creating 'test_file' and changing its context via setfilecon(3)\n";
 $result =
   system(
 "runcon -t test_filesystem_t $basedir/create_file_change_context -t test_filesystem_filecon_t -f $private_path/mp1/test_file $v"
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
@@ -171,10 +280,15 @@ cleanup1( $basedir, $dev );
 
 ############### Test Move Mount ##########################
 mk_mntpoint_1($private_path);
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
 
 print "Set mount MS_BIND on filesystem\n";
 $result = system(
@@ -190,9 +304,9 @@ ok( $result eq 0 );
 mk_mntpoint_2($private_path);
 
 print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
-print "Using mount options:\n\t$mount_opts2\n";
+print "Using mount options:\n\t$mount_opts\n";
 $result = system(
-"runcon -t test_filesystem_t $basedir/mount -s $dev -t $private_path/mp1 -f $fs_type -o $mount_opts2 $v"
+"runcon -t test_filesystem_t $basedir/mount -s $dev -t $private_path/mp1 -f $fs_type -o $mount_opts $v"
 );
 ok( $result eq 0 );
 
@@ -217,223 +331,321 @@ cleanup1( $basedir, $dev );
 
 ############### Deny filesystem { relabelfrom } ##########################
 # hooks.c may_context_mount_sb_relabel() FILESYSTEM__RELABELFROM
-mk_mntpoint_1($private_path);
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-make_fs( $fs_type, $dev, $basedir );
-$opts_no_relabelfrom =
-  "defcontext=system_u:object_r:test_filesystem_sb_relabel_no_relabelfrom_t:s0";
+#
+# Cannot test on NFS with no context options set ($seclabel_type eq 0)
+if ( ( $nfs_enabled and $seclabel_type ne 0 ) or not $nfs_enabled ) {
+    mk_mntpoint_1($private_path);
 
-print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
-print "Using mount options:\n\t$opts_no_relabelfrom\n";
-$result = system(
-"runcon -t test_filesystem_sb_relabel_no_relabelfrom_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_relabelfrom $v 2>&1"
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
+"runcon -t test_filesystem_sb_relabel_no_relabelfrom_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts $v 2>&1"
+    );
+    ok( $result >> 8 eq 13 );
+
+    print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+    cleanup1( $basedir, $dev );
+}
 
 ############### Deny filesystem { relabelto } ##########################
 # hooks.c may_context_mount_sb_relabel() FILESYSTEM__RELABELTO
-mk_mntpoint_1($private_path);
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-make_fs( $fs_type, $dev, $basedir );
-$opts_no_relabelto =
-  "fscontext=system_u:object_r:test_filesystem_sb_relabel_no_relabelto_t:s0";
+# Cannot test on NFS
+if ( not $nfs_enabled ) {
+    mk_mntpoint_1($private_path);
 
-print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
-print "Using mount options:\n\t$opts_no_relabelto\n";
-$result = system(
-"runcon -t test_filesystem_sb_relabel_no_relabelto_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_relabelto $v 2>&1"
-);
-ok( $result >> 8 eq 13 );
+    ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+    make_fs( $fs_type, $dev, $basedir );
+    $mount_opts =
+"fscontext=system_u:object_r:test_filesystem_sb_relabel_no_relabelto_t:s0";
 
-print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
-cleanup1( $basedir, $dev );
+    print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+    print "Using mount options:\n\t$mount_opts\n";
+    $result = system(
+"runcon -t test_filesystem_sb_relabel_no_relabelto_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts $v 2>&1"
+    );
+    ok( $result >> 8 eq 13 );
+
+    print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+    cleanup1( $basedir, $dev );
+}
 
 ############### Deny filesystem { relabelfrom } ##########################
 # hooks.c may_context_mount_inode_relabel() FILESYSTEM__RELABELFROM
-mk_mntpoint_1($private_path);
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-make_fs( $fs_type, $dev, $basedir );
-$opts_no_relabelfrom =
-  "rootcontext=system_u:object_r:test_filesystem_no_inode_no_relabelfrom_t:s0";
+#
+# Cannot test on NFS with no context options set ($seclabel_type eq 0)
+if ( ( $nfs_enabled and $seclabel_type ne 0 ) or not $nfs_enabled ) {
+    mk_mntpoint_1($private_path);
 
-print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
-print "Using mount options:\n\t$opts_no_relabelfrom\n";
-$result = system(
-"runcon -t test_filesystem_no_inode_no_relabelfrom_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_relabelfrom $v 2>&1"
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
+"runcon -t test_filesystem_no_inode_no_relabelfrom_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts $v 2>&1"
+    );
+    ok( $result >> 8 eq 13 );
 
+    print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+    cleanup1( $basedir, $dev );
+}
 ############### Deny filesystem { associate } ##########################
 # hooks.c may_context_mount_inode_relabel() FILESYSTEM__ASSOCIATE
-mk_mntpoint_1($private_path);
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-make_fs( $fs_type, $dev, $basedir );
+# Cannot test on NFS
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
-"runcon -t test_filesystem_inode_relabel_no_associate_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_associate $v 2>&1"
-);
-ok( $result >> 8 eq 13 );
+    print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+    print "Using mount options:\n\t$mount_opts\n";
+    $result = system(
+"runcon -t test_filesystem_inode_relabel_no_associate_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts $v 2>&1"
+    );
+    ok( $result >> 8 eq 13 );
 
-print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
-cleanup1( $basedir, $dev );
+    print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+    cleanup1( $basedir, $dev );
+}
 
 ############### Deny filesystem { associate } ##########################
 # hooks.c may_create() FILESYSTEM__ASSOCIATE
-mk_mntpoint_1($private_path);
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-make_fs( $fs_type, $dev, $basedir );
+#
+# Cannot test on NFS or vfat as to trigger need a different mount context
+# entry that is not possible in these scenarios.
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
-"runcon -t test_filesystem_may_create_no_associate_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_associate_file $v"
-);
-ok( $result eq 0 );
+    print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+    print "Using mount options:\n\t$mount_opts\n";
+    $result = system(
+"runcon -t test_filesystem_may_create_no_associate_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts $v"
+    );
+    ok( $result eq 0 );
 
-print "Creating test file $basedir/mntpoint/mp1/test_file\n";
-$result =
-  system(
+    print "Creating test file $basedir/mntpoint/mp1/test_file\n";
+    $result = system(
 "runcon -t test_filesystem_may_create_no_associate_t $basedir/create_file_change_context -t unconfined_t -f $basedir/mntpoint/mp1/test_file $v 2>&1"
-  );
-ok( $result >> 8 eq 13 );
+    );
+    ok( $result >> 8 eq 13 );    # EACCES
 
-print "Unmount filesystem from $basedir/mntpoint/mp1\n";
-$result =
-  system(
+    print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+    $result = system(
 "runcon -t test_filesystem_may_create_no_associate_t $basedir/umount -t $basedir/mntpoint/mp1 $v"
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
-mk_mntpoint_1($private_path);
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
 "runcon -t test_filesystem_no_quotamod_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_quotamod $v 2>&1"
-);
-ok( $result eq 0 );
+    );
+    ok( $result eq 0 );
 
-# No need to run quotacheck(8) as never gets far enough to read quota file
-print "Toggle User & Group quotas on/off\n";
-$result = system(
+    if ( $fs_type eq "xfs" ) {
+        print "Toggle xfs quotas on/off\n";
+        $result = system(
+"runcon -t test_filesystem_no_quotamod_t $basedir/xfs_quotas_test -s $dev $v 2>&1"
+        );
+        ok( $result >> 8 eq 13 );
+    }
+    else {
+      # No need to run quotacheck(8) as never gets far enough to read quota file
+        print "Toggle User & Group quotas on/off\n";
+        $result = system(
 "runcon -t test_filesystem_no_quotamod_t $basedir/quotas_test -s $dev -t $private_path/mp1/aquota.user $v 2>&1"
-);
-ok( $result >> 8 eq 13 );
+        );
+        ok( $result >> 8 eq 13 );
+    }
 
-print "Unmount filesystem from $basedir/mntpoint/mp1\n";
-$result = system(
+    print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+    $result = system(
 "runcon -t test_filesystem_no_quotamod_t $basedir/umount -t $basedir/mntpoint/mp1 $v"
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
-mk_mntpoint_1($private_path);
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
 "runcon -t test_filesystem_no_quotaget_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_quotaget $v"
-);
-ok( $result eq 0 );
-
-print "Running quotacheck(8) to init user/group quota files\n";
-$result = system("runcon `id -Z` quotacheck -ugF vfsv0 $private_path/mp1");
-ok( $result eq 0 );
+    );
+    ok( $result eq 0 );
 
-print "Toggle User & Group quotas on/off\n";
-$result = system(
+    if ( $fs_type eq "xfs" ) {
+        print "Toggle xfs quotas on/off\n";
+        $result = system(
+"runcon -t test_filesystem_no_quotaget_t $basedir/xfs_quotas_test -s $dev $v 2>&1"
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
 "runcon -t test_filesystem_no_quotaget_t $basedir/quotas_test -s $dev -t $private_path/mp1/aquota.user $v 2>&1"
-);
-ok( $result >> 8 eq 13 );
+        );
+        ok( $result >> 8 eq 13 );
+    }
 
-print "Unmount filesystem from $basedir/mntpoint/mp1\n";
-$result = system(
+    print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+    $result = system(
 "runcon -t test_filesystem_no_quotaget_t $basedir/umount -t $basedir/mntpoint/mp1 $v"
-);
-ok( $result eq 0 );
+    );
+    ok( $result eq 0 );
 
-print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
-cleanup1( $basedir, $dev );
+    print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+    cleanup1( $basedir, $dev );
 
-############### Deny file { quotaon } ##########################
-# hooks.c selinux_quota_on() FILE__QUOTAON
-mk_mntpoint_1($private_path);
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-make_fs( $fs_type, $dev, $basedir );
-$opts_no_quotaon =
-  "quota,usrquota,grpquota,context=system_u:object_r:test_file_no_quotaon_t:s0";
+    ############### Deny file { quotaon } ##########################
+    # hooks.c selinux_quota_on() FILE__QUOTAON
+    #
+    # This test requires an XFS patch to trigger security_quota_on()
+    #
+    mk_mntpoint_1($private_path);
+    ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+    make_fs( $fs_type, $dev, $basedir );
 
-print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
-print "Using mount options:\n\t$opts_no_quotaon\n";
-$result = system(
-"runcon -t test_file_no_quotaon_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_quotaon $v"
-);
-ok( $result eq 0 );
+    if ( $fs_type eq "xfs" ) {
+        $opts_no_quotaon =
+"quota,uquota,prjquota,context=system_u:object_r:test_file_no_quotaon_t:s0";
+    }
+    else {
+        $opts_no_quotaon =
+"quota,usrquota,grpquota,context=system_u:object_r:test_file_no_quotaon_t:s0";
+    }
 
-print "Running quotacheck(8) to init user/group quota files\n";
-$result = system("runcon `id -Z` quotacheck -ugF vfsv0 $private_path/mp1");
-ok( $result eq 0 );
+    print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+    print "Using mount options:\n\t$opts_no_quotaon\n";
+    $result = system(
+"runcon -t test_file_no_quotaon_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_quotaon $v"
+    );
+    ok( $result eq 0 );
 
-print "Toggle User quotas on/off\n";
-$result = system(
+    if ( $fs_type eq "xfs" ) {
+        print "Toggle xfs quotas on/off\n";
+        $result = system(
+"runcon -t test_file_no_quotaon_t $basedir/xfs_quotas_test -s $dev $v 2>&1"
+        );
+        ok( $result >> 8 eq 13 );
+    }
+    else {
+        print "Running quotacheck(8) to init user/group quota files\n";
+        $result =
+          system("runcon `id -Z` quotacheck -ugF vfsv0 $private_path/mp1");
+        ok( $result eq 0 );
+
+        print "Toggle User quotas on/off\n";
+        $result = system(
 "runcon -t test_file_no_quotaon_t $basedir/quotas_test -s $dev -t $private_path/mp1/aquota.user $v 2>&1"
-);
-ok( $result >> 8 eq 13 );
+        );
+        ok( $result >> 8 eq 13 );
+    }
 
-print "Unmount filesystem from $basedir/mntpoint/mp1\n";
-$result = system(
+    print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+    $result = system(
 "runcon -t test_file_no_quotaon_t $basedir/umount -t $basedir/mntpoint/mp1 $v"
-);
-ok( $result eq 0 );
+    );
+    ok( $result eq 0 );
 
-print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
-cleanup1( $basedir, $dev );
+    print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+    cleanup1( $basedir, $dev );
+}    # End quota checks
 
 ############### Deny filesystem { mount } ##########################
 # hooks.c selinux_sb_kern_mount() FILESYSTEM__MOUNT
 mk_mntpoint_1($private_path);
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-make_fs( $fs_type, $dev, $basedir );
-$opts_no_mount = "rootcontext=system_u:object_r:test_filesystem_no_mount_t:s0";
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
-"runcon -t test_filesystem_no_mount_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_mount $v 2>&1"
+"runcon -t test_filesystem_no_mount_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts $v 2>&1"
 );
 ok( $result >> 8 eq 13 );
 
@@ -443,15 +655,21 @@ cleanup1( $basedir, $dev );
 ############### Deny filesystem { getattr } ##########################
 # hooks.c selinux_sb_statfs() FILESYSTEM__GETATTR
 mk_mntpoint_1($private_path);
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-make_fs( $fs_type, $dev, $basedir );
-$opts_no_getattr =
-  "rootcontext=system_u:object_r:test_filesystem_no_getattr_t:s0";
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
-"runcon -t test_filesystem_no_getattr_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_getattr $v"
+"runcon -t test_filesystem_no_getattr_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts $v"
 );
 ok( $result eq 0 );
 
@@ -472,21 +690,27 @@ cleanup1( $basedir, $dev );
 ############### Deny filesystem { remount } ##########################
 # hooks.c selinux_mount() FILESYSTEM__REMOUNT
 mk_mntpoint_1($private_path);
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-make_fs( $fs_type, $dev, $basedir );
-$opts_no_remount =
-  "rootcontext=system_u:object_r:test_filesystem_no_remount_t:s0";
+
+if ($nfs_enabled) {
+    $mount_opts = $nfs_mount_opts;
+}
+else {
+    ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
+    make_fs( $fs_type, $dev, $basedir );
+    $mount_opts =
+      "rootcontext=system_u:object_r:test_filesystem_no_remount_t:s0";
+}
 
 print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
-print "Using mount options:\n\t$opts_no_remount\n";
+print "Using mount options:\n\t$mount_opts\n";
 $result = system(
-"runcon -t test_filesystem_no_remount_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_remount $v"
+"runcon -t test_filesystem_no_remount_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts $v"
 );
 ok( $result eq 0 );
 
 print "Then remount\n";
 $result = system(
-"runcon -t test_filesystem_no_remount_t $basedir/mount -r -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_remount $v 2>&1"
+"runcon -t test_filesystem_no_remount_t $basedir/mount -r -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts $v 2>&1"
 );
 ok( $result >> 8 eq 13 );
 
@@ -502,15 +726,21 @@ cleanup1( $basedir, $dev );
 ############### Deny filesystem { unmount } ##########################
 # hooks.c selinux_umount() FILESYSTEM__UNMOUNT
 mk_mntpoint_1($private_path);
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-make_fs( $fs_type, $dev, $basedir );
-$opts_no_unmount =
-  "rootcontext=system_u:object_r:test_filesystem_no_unmount_t:s0";
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
-"runcon -t test_filesystem_no_unmount_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_unmount $v"
+"runcon -t test_filesystem_no_unmount_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts $v"
 );
 ok( $result eq 0 );
 
@@ -532,48 +762,57 @@ cleanup1( $basedir, $dev );
 
 ############### Deny filesystem { associate }  ##########################
 # hooks.c selinux_inode_setxattr() FILESYSTEM__ASSOCIATE
-mk_mntpoint_1($private_path);
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-make_fs( $fs_type, $dev, $basedir );
-$opts_no_associate_xattr =
-"defcontext=system_u:object_r:test_filesystem_inode_setxattr_no_associate_t:s0,fscontext=system_u:object_r:test_filesystem_inode_setxattr_no_associate_t:s0";
+#
+# Cannot test on NFS and vfat as to trigger need a different mount context
+# entry that is not possible in these scenarios.
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
-"runcon -t test_filesystem_inode_setxattr_no_associate_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_associate_xattr $v"
-);
-ok( $result eq 0 );
+    print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
+    print "Using mount options:\n\t$mount_opts\n";
+    $result = system(
+"runcon -t test_filesystem_inode_setxattr_no_associate_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts $v"
+    );
+    ok( $result eq 0 );
 
-print "Creating test file $basedir/mntpoint/mp1/test_file\n";
-$result =
-  system(
+    $result = system(
 "runcon -t test_filesystem_inode_setxattr_no_associate_t $basedir/create_file_change_context -t unconfined_t -f $basedir/mntpoint/mp1/test_file $v 2>&1"
-  );
-ok( $result >> 8 eq 13 );
+    );
+    ok( $result >> 8 eq 13 );    # EACCES
 
-print "Unmount filesystem from $basedir/mntpoint/mp1\n";
-$result =
-  system(
+    print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+    $result = system(
 "runcon -t test_filesystem_inode_setxattr_no_associate_t $basedir/umount -t $basedir/mntpoint/mp1 $v"
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
     mk_mntpoint_1($private_path);
-    ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
-    $opts_no_watch = "context=system_u:object_r:test_filesystem_no_watch_t:s0";
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
-"runcon -t test_filesystem_no_watch_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_watch $v"
+"runcon -t test_filesystem_no_watch_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts $v"
     );
     ok( $result eq 0 );
 
@@ -595,15 +834,21 @@ if ($test_watch) {
     ############### Deny file { watch_sb }  ##########################
     # hooks.c selinux_path_notify() FILE__WATCH_SB
     mk_mntpoint_1($private_path);
-    ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
-    $opts_no_watch_sb =
-      "context=system_u:object_r:test_filesystem_no_watch_sb_t:s0";
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
-"runcon -t test_filesystem_no_watch_sb_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_watch_sb $v"
+"runcon -t test_filesystem_no_watch_sb_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts $v"
     );
     ok( $result eq 0 );
 
@@ -625,15 +870,21 @@ if ($test_watch) {
     ############### Deny file { watch_mount }  ##########################
     # hooks.c selinux_path_notify() FILE__WATCH_MOUNT
     mk_mntpoint_1($private_path);
-    ( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-    make_fs( $fs_type, $dev, $basedir );
-    $opts_no_watch_mount =
-      "context=system_u:object_r:test_filesystem_no_watch_mount_t:s0";
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
-"runcon -t test_filesystem_no_watch_mount_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $opts_no_watch_mount $v"
+"runcon -t test_filesystem_no_watch_mount_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts $v"
     );
     ok( $result eq 0 );
 
@@ -653,236 +904,295 @@ if ($test_watch) {
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
+############### Test Invalid Mount ##########################
+# This will generate a log entry "SELinux: mount invalid. Same superblock,
+#    different security settings for (dev 0:49, type nfs4)"
+# Note that NFS is already mounted.
+#
 mk_mntpoint_1($private_path);
-( $dev, $device_count ) = get_loop_dev( \@device_list, $device_count );
-make_fs( $fs_type, $dev, $basedir );
 
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
+"runcon -t test_filesystem_t $basedir/mount -s $dev -t $private_path/mp1 -f $fs_type -o $mount_opts $v"
+    );
+    ok( $result eq 0 );
+}
+
+print "Mount $fs_type filesystem on $private_path/mp1\n";
+print "Using mount options:\n\t$mount_inval_opts\n";
 $result = system(
-"runcon -t test_filesystem_context_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $context1_opts $v"
+"runcon -t test_filesystem_t $basedir/mount -s $dev -t $private_path/mp1 -f $fs_type -o $mount_inval_opts $v 2>&1"
 );
-ok( $result eq 0 );
+if ($nfs_enabled) {
+    ok( $result >> 8 eq 16 );    # EBUSY
+}
+else {
+    ok( $result >> 8 eq 22 );    # EINVAL
 
-# Create file with 'test_filesystem_filecon_t' context
-print "Creating test file $basedir/mntpoint/mp1/test_file\n";
-$result =
-  system(
+    print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+    $result = system(
+        "runcon -t test_filesystem_t $basedir/umount -t $private_path/mp1 $v");
+    ok( $result eq 0 );
+}
+
+print "Removing: $basedir/mntpoint\n";
+cleanup1( $basedir, $dev );
+
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
+"runcon -t test_filesystem_context_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $context1_opts $v"
+    );
+    ok( $result eq 0 );
+
+    # Create file with 'test_filesystem_filecon_t' context
+    print "Creating test file $basedir/mntpoint/mp1/test_file\n";
+    $result =
+      system(
 "runcon -t test_filesystem_context_t $basedir/create_file_change_context -t test_filesystem_filecon_t -f $private_path/mp1/test_file $v"
-  );
-ok( $result eq 0 );
+      );
+    if ($vfat_enabled) {
+        ok( $result >> 8 eq 95 );    # EOPNOTSUPP
+    }
+    else {
+        ok( $result eq 0 );
+    }
 
-print "Unmount filesystem from $basedir/mntpoint/mp1\n";
-$result = system(
+    print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+    $result = system(
 "runcon -t test_filesystem_context_t $basedir/umount -t $basedir/mntpoint/mp1 $v"
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
 "runcon -t test_filesystem_context_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $context2_opts $v"
-);
-ok( $result eq 0 );
+    );
+    ok( $result eq 0 );
 
 # Now check the context on file is system_u:object_r:test_filesystem_context_file_t:s0
-print "Check test file context $basedir/mntpoint/mp1/test_file\n";
-$result =
-  system(
+    print "Check test file context $basedir/mntpoint/mp1/test_file\n";
+    $result =
+      system(
 "runcon -t test_filesystem_context_t $basedir/check_file_context -f $private_path/mp1/test_file -e system_u:object_r:test_filesystem_context_file_t:s0 $v"
-  );
-ok( $result eq 0 );
+      );
+    ok( $result eq 0 );
 
 # Then create a file with 'test_filesystem_filecon_t' context, this should fail with EOPNOTSUPP
-print "Creating test file $basedir/mntpoint/mp1/test_file\n";
-$result =
-  system(
+    print "Creating test file $basedir/mntpoint/mp1/test_file\n";
+    $result =
+      system(
 "runcon -t test_filesystem_context_t $basedir/create_file_change_context -t test_filesystem_filecon_t -f $private_path/mp1/test_file $v 2>/dev/null"
-  );
-ok( $result >> 8 eq 95 );
+      );
+    ok( $result >> 8 eq 95 );
 
-print "Unmount filesystem from $basedir/mntpoint/mp1\n";
-$result =
-  system(
+    print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+    $result =
+      system(
 "runcon -t test_filesystem_context_t $basedir/umount -t $basedir/mntpoint/mp1 $v"
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
-mk_mntpoint_1($private_path);
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
 "runcon -t test_filesystem_context_t $basedir/check_mount_context -r -m $basedir/mntpoint/mp1 $v"
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
 "runcon -t test_filesystem_context_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $root_opts $v"
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
 "runcon -t test_filesystem_context_t $basedir/check_mount_context -m $basedir/mntpoint/mp1 -e system_u:object_r:test_filesystem_context_file_t:s0 $v"
-  );
-ok( $result eq 0 );
+      );
+    ok( $result eq 0 );
 
-print "Unmount filesystem from $basedir/mntpoint/mp1\n";
-$result = system(
+    print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+    $result = system(
 "runcon -t test_filesystem_context_t $basedir/umount -t $basedir/mntpoint/mp1 $v"
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
-mk_mntpoint_1($private_path);
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
 "runcon -t test_filesystem_context_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $test_opts $v"
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
 "runcon -u system_u -t test_filesystem_fscontext_t $basedir/create_file -f $basedir/mntpoint/mp1/test_file -e test_filesystem_context_file_t $v"
-  );
-ok( $result eq 0 );
+        );
+        ok( $result eq 0 );
 
-print "Unmount filesystem from $basedir/mntpoint/mp1\n";
-$result = system(
+        print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+        $result = system(
 "runcon -t test_filesystem_context_t $basedir/umount -t $basedir/mntpoint/mp1 $v"
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
 "runcon -t test_filesystem_context_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $defcontext_opts $v"
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
 "runcon -t test_filesystem_context_t $basedir/check_file_context -f $basedir/mntpoint/mp1/test_file -e system_u:object_r:test_filesystem_filecon_t:s0 $v"
-  );
-ok( $result eq 0 );
+        );
+        ok( $result eq 0 );
 
-print "Unmount filesystem from $basedir/mntpoint/mp1\n";
-$result =
-  system(
+        print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+        $result = system(
 "runcon -t test_filesystem_context_t $basedir/umount -t $basedir/mntpoint/mp1 $v"
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
-mk_mntpoint_1($private_path);
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
 "runcon -t test_filesystem_fscontext_t $basedir/mount -s $dev -t $basedir/mntpoint/mp1 -f $fs_type -o $fscontext_opts $v"
-);
-ok( $result eq 0 );
+    );
+    ok( $result eq 0 );
 
-print "Creating test file $basedir/mntpoint/mp1/test_file\n";
-$result =
-  system(
+    print "Creating test file $basedir/mntpoint/mp1/test_file\n";
+    $result =
+      system(
 "runcon -t test_filesystem_fscontext_t $basedir/create_file_change_context -t test_filesystem_filecon_t -f $private_path/mp1/test_file $v"
-  );
-ok( $result eq 0 );
+      );
+    ok( $result eq 0 );
 
-print "Unmount filesystem from $basedir/mntpoint/mp1\n";
-$result =
-  system(
+    print "Unmount filesystem from $basedir/mntpoint/mp1\n";
+    $result =
+      system(
 "runcon -t test_filesystem_fscontext_t $basedir/umount -t $basedir/mntpoint/mp1 $v"
-  );
-ok( $result eq 0 );
+      );
+    ok( $result eq 0 );
 
-print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
-cleanup1( $basedir, $dev );
+    print "Removing: $dev $basedir/mntpoint $basedir/fstest\n";
+    cleanup1( $basedir, $dev );
+}
 
 reaper( \@device_list, $basedir, $v );
 
diff --git a/tests/filesystem/xfs_quotas_test.c b/tests/filesystem/xfs_quotas_test.c
new file mode 100644
index 0000000..fd4475f
--- /dev/null
+++ b/tests/filesystem/xfs_quotas_test.c
@@ -0,0 +1,96 @@
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
+	int on_flags = XFS_QUOTA_UDQ_ACCT | XFS_QUOTA_UDQ_ENFD;
+	int off_flags = XFS_QUOTA_UDQ_ENFD;
+	struct fs_quota_stat q_stat;
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
+	qcmd = QCMD(Q_XGETQSTAT, USRQUOTA);
+	result = quotactl(qcmd, src, 0, (void *)&q_stat);
+	save_err = errno;
+	if (result < 0) {
+		fprintf(stderr, "quotactl(Q_XGETQSTAT, USRQUOTA) Failed: %s\n",
+			strerror(errno));
+		return save_err;
+	}
+	if (verbose)
+		printf("XFS Q_XGETQSTAT Version: %d Flags: 0x%04x Number of dquots: %d\n",
+		       q_stat.qs_version, q_stat.qs_flags, q_stat.qs_incoredqs);
+
+	/*
+	 * The tests turn XFS quotas on, therefore need to turn off then on
+	 * These require FILESYSTEM__QUOTAMOD
+	 */
+	qcmd = QCMD(Q_XQUOTAOFF, USRQUOTA);
+	result = quotactl(qcmd, src, 0, (void *)&off_flags);
+	save_err = errno;
+	if (result < 0) {
+		fprintf(stderr, "quotactl(Q_XQUOTAOFF, USRQUOTA) Failed: %s\n",
+			strerror(errno));
+		return save_err;
+	}
+	if (verbose)
+		printf("XFS User Quota - OFF\n");
+
+	qcmd = QCMD(Q_XQUOTAON, USRQUOTA);
+	result = quotactl(qcmd, src, 0, (void *)&on_flags);
+	save_err = errno;
+	if (result < 0) {
+		fprintf(stderr, "quotactl(Q_XQUOTAON, USRQUOTA) Failed: %s\n",
+			strerror(errno));
+		return save_err;
+	}
+	if (verbose)
+		printf("XFS User Quota - ON\n");
+
+	return 0;
+}
diff --git a/tools/nfs.sh b/tools/nfs.sh
index 314f898..6644860 100755
--- a/tools/nfs.sh
+++ b/tools/nfs.sh
@@ -1,14 +1,41 @@
 #!/bin/sh -e
 MOUNT=`stat --print %m .`
 TESTDIR=`pwd`
-systemctl start nfs-server
+MAKE_TEST=0
+
+function err_exit() {
+    if [ $MAKE_TEST -eq 1 ]; then
+        echo "Closing down NFS"
+        popd
+    else
+        echo "Error on line: $1 - Closing down NFS"
+    fi
+    umount /mnt/selinux-testsuite
+    exportfs -u localhost:$MOUNT
+    rmdir /mnt/selinux-testsuite
+    systemctl stop nfs-server
+    exit 1
+}
 
-# Run the full testsuite on a labeled NFS mount.
+trap 'err_exit $LINENO' ERR
+
+systemctl start nfs-server
+# Run the testsuite on a labeled NFS mount.
 exportfs -orw,no_root_squash,security_label localhost:$MOUNT
 mkdir -p /mnt/selinux-testsuite
 mount -t nfs -o vers=4.2 localhost:$TESTDIR /mnt/selinux-testsuite
 pushd /mnt/selinux-testsuite
-make test
+MAKE_TEST=1
+if [ $1 ]; then
+    cd tests/$1
+    make
+    # $2-$5 for tests with options: filesystem -v -e -f ext4
+    ./test $2 $3 $4 $5
+    cd ../../
+else
+    make test
+fi
+MAKE_TEST=0
 popd
 umount /mnt/selinux-testsuite
 
@@ -18,7 +45,7 @@ echo "Testing context mount of a security_label export."
 fctx=`secon -t -f /mnt/selinux-testsuite`
 if [ "$fctx" != "etc_t" ]; then
     echo "Context mount failed: got $fctx instead of etc_t."
-    exit 1
+    err_exit $LINENO
 fi
 umount /mnt/selinux-testsuite
 exportfs -u localhost:$MOUNT
@@ -30,7 +57,7 @@ echo "Testing context mount of a non-security_label export."
 fctx=`secon -t -f /mnt/selinux-testsuite`
 if [ "$fctx" != "etc_t" ]; then
     echo "Context mount failed: got $fctx instead of etc_t."
-    exit 1
+    err_exit $LINENO
 fi
 umount /mnt/selinux-testsuite
 
@@ -40,7 +67,7 @@ echo "Testing non-context mount of a non-security_label export."
 fctx=`secon -t -f /mnt/selinux-testsuite`
 if [ "$fctx" != "nfs_t" ]; then
     echo "Context mount failed: got $fctx instead of nfs_t."
-    exit 1
+    err_exit $LINENO
 fi
 umount /mnt/selinux-testsuite
 
-- 
2.24.1

