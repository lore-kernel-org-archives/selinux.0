Return-Path: <SRS0=m98w=3S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A853AC33CB7
	for <selinux@archiver.kernel.org>; Wed, 29 Jan 2020 20:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8112C20702
	for <selinux@archiver.kernel.org>; Wed, 29 Jan 2020 20:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="KNNBkpbL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgA2U2n (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Jan 2020 15:28:43 -0500
Received: from UPDC19PA24.eemsg.mail.mil ([214.24.27.199]:42070 "EHLO
        UPDC19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgA2U2n (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Jan 2020 15:28:43 -0500
X-EEMSG-check-017: 51496060|UPDC19PA24_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,379,1574121600"; 
   d="scan'208";a="51496060"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 29 Jan 2020 20:28:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580329718; x=1611865718;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Yf92bjS1Sz/3Gx2zzw5y1c52MBW3Jy7bwrLUGq9BKx0=;
  b=KNNBkpbLlnjprOAfNuroDHTUWwLTqO9cekDiFQDc9MSoGS4g7ctMTM9+
   edGDHgkvfbVdwBU0Dk5awUVWDKlxP/M6X52PhH17G3gPcA8i6Ij7w6dZ2
   wD9DkEkUnRAYO3JHznsWCbxDXW+98ZA2KkK5ZUifDds8uogEw9fDahme7
   k2FZdS15gOodABVxh8czcO1BlRrNt2fA5mav76L6qSXerUivOkSyXWwXt
   uevQGEB/ZqSDvwetfnH2Bx5mEZ17Qv8u7tE1UxOTjgXzS20GCxNyv9Alp
   Zukaljym4bwuLjWpMHAUj82JN1mXvumeZzDf8nZmJ1m/rbx4w3VV+dgss
   g==;
X-IronPort-AV: E=Sophos;i="5.70,379,1574121600"; 
   d="scan'208";a="38427954"
IronPort-PHdr: =?us-ascii?q?9a23=3Ap7wQkh1MMYV28elKsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesWKP3xwZ3uMQTl6Ol3ixeRBMOHsq4C0LSd6vu7ESxYuNDd6StEKMQNHz?=
 =?us-ascii?q?Y+yuwu1zQ6B8CEDUCpZNXLVAcdWPp4aVl+4nugOlJUEsutL3fbo3m18CJAUk?=
 =?us-ascii?q?6nbVk9Kev6AJPdgNqq3O6u5ZLTfx9IhD2gar9uMRm6twrcutQZjId4JKs8yx?=
 =?us-ascii?q?TFrmZGdulY2GhkIU6fkwvm6sq/4ZJu/T5ct+49+8JFTK73Y7k2QbtEATo8Lm?=
 =?us-ascii?q?s7/tfrtR7NTQuO4nsTTGAbmQdWDgbG8R/3QI7/vjP1ueRh1iaaO9b2Ta0vVj?=
 =?us-ascii?q?S586hrUh7ohzwZODM/7Wral9Z/jKNfoBKmuhx/34vZa5ybOfZiYq/Qe84RSm?=
 =?us-ascii?q?RbXsZVSidPHIWyYYUSBOYFJOpVoY3wq14IoBCjBwejGfnvxydIiHHowKM03e?=
 =?us-ascii?q?cvHwbJ0wIvBN8CrHfZoc/pOKoITey50K/FxijDYfNM3jf97ZDFfA09of6SRb?=
 =?us-ascii?q?JwcdTeyU8yHA3Yi1Wfs4jlPzeL2eUNrmOW6PFgWv+0i2M8twFwoiSgxscrio?=
 =?us-ascii?q?XTgIIV0UrL+T92wIYyO921UUh2asOqHptXsiGVLYp2QsU6TmFnuSY61r0GuY?=
 =?us-ascii?q?OgcyQQ1JsnwBvfZvqaeIaL+hLuTPudLDh3iX5/eL+zmgy+/Vavx+HiTMW4zV?=
 =?us-ascii?q?BHpTdfnNbWrHACzRnT59CCSvt640iuxy6C1xvW6uFYOUA0krfbK4I5zr4wiJ?=
 =?us-ascii?q?UTtUPDEzfqmErslq+Wd1gk+vOy5+TmZLXmqJicN5RqhQ7iKKguhsy+Dvg4Mg?=
 =?us-ascii?q?gJRWSb//iz1Kb/8kHjRbVKj/k2nrHYsJDcO8sbura0DxJa34ss8RqyDyqq3M?=
 =?us-ascii?q?4GkXQIMl5JYg+Lg5DsO17UIfD4Cfm/g06rkDdu3/3GJaDuAo7WI3jfkLbuYb?=
 =?us-ascii?q?Z960lGxAo11tBQ/YhYCr4GIPLtQkPxrsDXDgclMwyoxObqEM991oICVmKPGK?=
 =?us-ascii?q?CZKr7dvkeU6e03I+mDfo4VuDDjJPg+/PPhlmM5mV4bfam1w5QXcna4Eep6I0?=
 =?us-ascii?q?mDfXXshdIBG38QvgUiVOzqlEGCUTlLana1WqI84So7CIS8AojfWI+gm6aB0z?=
 =?us-ascii?q?mmEZ1WfG9GFkqAHmvvd4WBQ/0Mcj6dItd9kjwYUrisU5Qh2g+qtA/7zbpnM+?=
 =?us-ascii?q?XV9zYGtZLsytd1/ffflRIs+jxuCcSSzWWNQ3tznmMSSD88xLp/rlBlylefza?=
 =?us-ascii?q?h4hORVFcRJ6PNUVgc3LobcwPZnC9D2Qw7Be9CJSFG8Qtq4Gz0+UtUxw9pdK3?=
 =?us-ascii?q?p6Ts2rkxTrxyO3B/oQkLuRCdo/9aeP8WL2IpNG13ve1KQnx2IjS89LOHzu0r?=
 =?us-ascii?q?Vz7CDPFoXJlAOfjK/seqMCin2evFyfxHaD6RkLGDV7Vr/ICDVEN0Y=3D?=
X-IPAS-Result: =?us-ascii?q?A2BTAABO6DFe/wHyM5BmHQEBAQkBEQUFAYFoBwELAYF8g?=
 =?us-ascii?q?RhUASASKo0XhloGiyaPToF7CQEBAQEBAQEBARsQDAEBhECCUDUIDgIQAQEBB?=
 =?us-ascii?q?AEBAQEBBQMBAWyFNwyCOymDMwFGgVGCZz8BglYlD689iHuBPoE4AYdBhHh5g?=
 =?us-ascii?q?QeBR4MbgksZAoFNhgQEl3qXXoJDgkyEdo5pDBuafgGKf4xFlCQBN4FYKwgCG?=
 =?us-ascii?q?AghD4MnCUcYDZIQhlGEICMDMI5HAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 29 Jan 2020 20:28:34 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00TKRkuV259121;
        Wed, 29 Jan 2020 15:27:48 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, omosnace@redhat.com,
        richard_c_haines@btinternet.com,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] testsuite: enable running over labeled NFS
Date:   Wed, 29 Jan 2020 15:29:22 -0500
Message-Id: <20200129202922.88027-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Certain tests cannot succeed on nfs and therefore should
be skipped in that case.  This allows the testsuite to
be run on a labeled NFS mount as described below without
triggering any (additional) failures relative to running
on a local filesystem like ext4.

The tests that are skipped or modified and the corresponding rationale is:
file: 1 test skipped - flock not supported over NFS
capable_file: all tests skipped - file capabilities not supported over NFS
capable_sys: 1 test skipped - CAP_SYS_RAWIO not supported over NFS
overlay: all tests skipped - NFS not supported as an upperdir
mac_admin: one test modified - undefined contexts not exported over NFS

This partly addresses
https://github.com/SELinuxProject/selinux-testsuite/issues/32.

Test sequence for labeled NFS is:
$ cat nfs.sh
MOUNT=/home # must be a top-level mount
TESTDIR=$MOUNT/path/to/selinux-testsuite
systemctl start nfs-server
exportfs -orw,no_root_squash,security_label localhost:$MOUNT
mkdir -p /mnt/selinux-testsuite
mount -t nfs -o vers=4.2 localhost:$TESTDIR /mnt/selinux-testsuite
pushd /mnt/selinux-testsuite
make test
popd
umount /mnt/selinux-testsuite
exportfs -u localhost:$MOUNT
systemctl stop nfs-server

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 tests/capable_file/test | 28 +++++++++++++++++++---------
 tests/capable_sys/test  | 32 +++++++++++++++++++++++---------
 tests/file/test         | 22 +++++++++++++++++-----
 tests/mac_admin/test    | 18 ++++++++++++++----
 tests/overlay/test      | 11 ++++++++---
 5 files changed, 81 insertions(+), 30 deletions(-)

diff --git a/tests/capable_file/test b/tests/capable_file/test
index 12322d320dd4..8d0acc9742af 100755
--- a/tests/capable_file/test
+++ b/tests/capable_file/test
@@ -3,11 +3,21 @@
 # This test performs capability tests for file operations.
 #
 
-use Test;
-BEGIN { plan tests => 10 }
+use Test::More;
 
-$basedir = $0;
-$basedir =~ s|(.*)/[^/]*|$1|;
+BEGIN {
+    $basedir = $0;
+    $basedir =~ s|(.*)/[^/]*|$1|;
+
+    $isnfs = `stat -f --print %T $basedir`;
+
+    if ( $isnfs eq "nfs" ) {
+        plan skip_all => "file capabilities not supported over NFS";
+    }
+    else {
+        plan tests => 10;
+    }
+}
 
 # Clean up from a previous run
 system "rm -f $basedir/temp_file 2>&1";
@@ -20,12 +30,12 @@ system "rm -f $basedir/temp_file2 2>&1";
 system "touch $basedir/temp_file 2>&1";
 $result =
   system "runcon -t test_fcap_t -- chown daemon $basedir/temp_file 2>&1";
-ok( $result, 0 );
+ok( $result eq 0 );
 
 # CAP_FOWNER
 system "chown daemon.tty $basedir/temp_file 2>&1";
 $result = system "runcon -t test_fcap_t -- chmod 0400 $basedir/temp_file 2>&1";
-ok( $result, 0 );
+ok( $result eq 0 );
 
 # CAP_FSETID
 $fn   = "$basedir/temp_file";
@@ -42,12 +52,12 @@ ok($result);
 # CAP_LEASE
 $result = system
   "runcon -t test_fcap_t --  $basedir/test_lease $basedir/temp_file 2>&1";
-ok( $result, 0 );
+ok( $result eq 0 );
 
 # CAP_MKNOD
 $result =
   system "runcon -t test_fcap_t -- mknod $basedir/temp_file2 c 5 5 2>&1";
-ok( $result, 0 );
+ok( $result eq 0 );
 
 # Cleanup time.
 system "rm -f $basedir/temp_file 2>&1";
@@ -79,7 +89,7 @@ if ( $mode eq ( stat($fn) )[2] ) {
 }
 
 # prior mode should be same as current mode
-ok( $result, 0 );
+ok( $result eq 0 );
 
 # CAP_LEASE - Needs DAC_OVERRIDE
 $result = system
diff --git a/tests/capable_sys/test b/tests/capable_sys/test
index 2d9edf450800..cd50ebcada1b 100755
--- a/tests/capable_sys/test
+++ b/tests/capable_sys/test
@@ -1,13 +1,23 @@
 #!/usr/bin/perl
 #
-# This test performs checks for network-related capabilties.
+# This test performs checks for system-related capabilties.
 #
 
 use Test;
-BEGIN { plan tests => 8 }
 
-$basedir = $0;
-$basedir =~ s|(.*)/[^/]*|$1|;
+BEGIN {
+    $basedir = $0;
+    $basedir =~ s|(.*)/[^/]*|$1|;
+
+    $isnfs = `stat -f --print %T $basedir`;
+
+    $test_count = 7;
+    if ( $isnfs ne "nfs" ) {
+        $test_count += 1;
+    }
+
+    plan tests => $test_count;
+}
 
 # Clean up from a previous run
 system "rm -f $basedir/temp_file 2>&1";
@@ -16,11 +26,15 @@ system "rm -f $basedir/temp_file 2>&1";
 # Tests for the good domain.
 #
 
-# CAP_SYS_RAWIO
-system "touch $basedir/temp_file 2>&1";
-$result =
-  system "runcon -t test_scap_t -- $basedir/test_rawio $basedir/temp_file 2>&1";
-ok( $result, 0 );
+if ( $isnfs ne "nfs" ) {
+
+    # CAP_SYS_RAWIO
+    system "touch $basedir/temp_file 2>&1";
+    $result =
+      system
+      "runcon -t test_scap_t -- $basedir/test_rawio $basedir/temp_file 2>&1";
+    ok( $result, 0 );
+}
 
 # CAP_SYS_CHROOT
 $result = system "runcon -t test_scap_t -- $basedir/test_chroot $basedir/ 2>&1";
diff --git a/tests/file/test b/tests/file/test
index 5e080fc6d4e9..465054802fc5 100755
--- a/tests/file/test
+++ b/tests/file/test
@@ -4,10 +4,20 @@
 #
 
 use Test;
-BEGIN { plan tests => 16 }
 
-$basedir = $0;
-$basedir =~ s|(.*)/[^/]*|$1|;
+BEGIN {
+    $basedir = $0;
+    $basedir =~ s|(.*)/[^/]*|$1|;
+
+    $isnfs = `stat -f --print %T $basedir`;
+
+    $test_count = 15;
+    if ( $isnfs ne "nfs" ) {
+        $test_count++;
+    }
+
+    plan tests => $test_count;
+}
 
 #
 # Clean up from a previous run
@@ -72,9 +82,11 @@ $result = system
 "runcon -t test_fileop_t -- $basedir/test_mprotect $basedir/temp_file $good_file_sid 2>&1";
 ok( $result, 0 );
 
-$result = system
+if ( $isnfs ne "nfs" ) {
+    $result = system
 "runcon -t test_fileop_t -- $basedir/test_lock $basedir/temp_file $good_file_sid 2>&1";
-ok( $result, 0 );
+    ok( $result, 0 );
+}
 
 $result = system
 "runcon -t test_fileop_t -- $basedir/test_rw $basedir/temp_file $good_file_sid 2>&1";
diff --git a/tests/mac_admin/test b/tests/mac_admin/test
index e8e0bbf8cf19..32161f391643 100755
--- a/tests/mac_admin/test
+++ b/tests/mac_admin/test
@@ -1,10 +1,15 @@
 #!/usr/bin/perl
 
 use Test;
-BEGIN { plan tests => 8 }
 
-$basedir = $0;
-$basedir =~ s|(.*)/[^/]*|$1|;
+BEGIN {
+    $basedir = $0;
+    $basedir =~ s|(.*)/[^/]*|$1|;
+
+    $isnfs = `stat -f --print %T $basedir`;
+
+    plan tests => 8;
+}
 
 # Verify that test_mac_admin_t can relabel a file to an undefined context.
 system("rm -f $basedir/test_file; touch $basedir/test_file");
@@ -36,7 +41,12 @@ ok( $result, 0 );    # we expect this to succeed.
 # Verify that test_mac_admin_t sees the undefined label value.
 $result = `runcon -t test_mac_admin_t -- secon -t -f $basedir/test_dir 2>&1`;
 chomp($result);
-ok( $result, "UNDEFINED" );
+if ( $isnfs ne "nfs" ) {
+    ok( $result, "UNDEFINED" );
+}
+else {
+    ok( $result, "unlabeled_t" );
+}
 
 # Verify that test_no_mac_admin_t sees the unlabeled context.
 $result = `runcon -t test_no_mac_admin_t -- secon -t -f $basedir/test_dir 2>&1`;
diff --git a/tests/overlay/test b/tests/overlay/test
index 33eb0d1c2178..72affdfaa7ff 100755
--- a/tests/overlay/test
+++ b/tests/overlay/test
@@ -2,10 +2,18 @@
 use Test::More;
 
 BEGIN {
+    $basedir = $0;
+    $basedir =~ s|(.*)/[^/]*|$1|;
+
+    $isnfs = `stat -f --print %T $basedir`;
+
     # check if kernel supports overlayfs and SELinux labeling
     if ( system("grep -q security_inode_copy_up /proc/kallsyms") ) {
         plan skip_all => "overlayfs not supported with SELinux in this kernel";
     }
+    elsif ( $isnfs eq "nfs" ) {
+        plan skip_all => "overlayfs upperdir not supported on NFS";
+    }
     else {
         plan tests => 119;
     }
@@ -695,9 +703,6 @@ sub test_93_1 {
     return;
 }
 
-$basedir = $0;
-$basedir =~ s|(.*)/[^/]*|$1|;
-
 cleanup();
 
 sub nocontext_test {
-- 
2.24.1

