Return-Path: <SRS0=hBaa=DU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09726C433E7
	for <selinux@archiver.kernel.org>; Tue, 13 Oct 2020 14:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8358C2489E
	for <selinux@archiver.kernel.org>; Tue, 13 Oct 2020 14:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="AUxhheJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbgJMOzD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Oct 2020 10:55:03 -0400
Received: from mailomta14-re.btinternet.com ([213.120.69.107]:29065 "EHLO
        re-prd-fep-043.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726371AbgJMOzD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Oct 2020 10:55:03 -0400
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-043.btinternet.com with ESMTP
          id <20201013145500.BOCE29506.re-prd-fep-043.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Tue, 13 Oct 2020 15:55:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1602600900; 
        bh=vzpLlkFj1uCYlx0qSqt94MHv3mjl5y1ZofqGGpYuZnE=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=AUxhheJXODrXdxcfWIjzOMnKfAYlEMVYe5pEoGmGeyMg2kyGAQkz3DJWOD9j0TELsZ2O4atbo7UXfLBBNB3jLqu0S/gtXbZU37pOhNtXd6U3px841YGVttvaNcN/iYwUMY9cAIKvl/E9n048dthRBlIKoDRqEtS3ui5XcKKTdLrXzGy8Y6HXGvZ0UomMnXAQDT2Xno4M/iKO+hmuNPKp2H2Liyx8Dl3QPitg5ZPgsvJlI+R394Zu9yKF7r35lCBiNcmTVuXUYTX16hJ95O8bwLGxjyafEr9l8yonxo3OqUEoz11y7EzYe/w30TSHgPsKSQlDtfP94/wzzU5ge0NpyA==
Authentication-Results: btinternet.com; none
X-Originating-IP: [81.147.56.93]
X-OWM-Source-IP: 81.147.56.93 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrheelgdekvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepuedttdelleehueeggfeihfeitdehueekffeviedtffegffeiueegleejgeevgfeinecukfhppeekuddrudegjedrheeirdelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurddugeejrdehiedrleefpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (81.147.56.93) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C2FD15AD1892; Tue, 13 Oct 2020 15:54:59 +0100
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 1/1] selinux-testsuite: Add btrfs support for filesystem tests
Date:   Tue, 13 Oct 2020 15:54:56 +0100
Message-Id: <20201013145456.77253-2-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013145456.77253-1-richard_c_haines@btinternet.com>
References: <20201013145456.77253-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This allows btrfs filesystems to be created to support the
filesystem mount(2) type calls and the fs_filesystem fsmount(2)
type calls.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 tests/filesystem/Filesystem.pm | 10 +++++++++-
 tests/filesystem/test          |  6 ++++++
 tests/fs_filesystem/test       |  6 ++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/tests/filesystem/Filesystem.pm b/tests/filesystem/Filesystem.pm
index 2365ce8..3108eec 100644
--- a/tests/filesystem/Filesystem.pm
+++ b/tests/filesystem/Filesystem.pm
@@ -122,10 +122,18 @@ sub attach_dev {
 
 sub make_fs {
     my ( $mk_type, $mk_dev, $mk_dir ) = @_;
+
+    # BTRFS requires a larger minimum size that takes >2x longer to generate
+    if ( $mk_type eq "btrfs" ) {
+        $count = "28000";
+    }
+    else {
+        $count = "4096";
+    }
     print "Create $mk_dir/fstest with dd\n";
     $result =
       system(
-        "dd if=/dev/zero of=$mk_dir/fstest bs=4096 count=4096 2>/dev/null");
+        "dd if=/dev/zero of=$mk_dir/fstest bs=4096 count=$count 2>/dev/null");
     if ( $result != 0 ) {
         print "dd failed to create $mk_dir/fstest\n";
     }
diff --git a/tests/filesystem/test b/tests/filesystem/test
index 7d4654d..af59690 100755
--- a/tests/filesystem/test
+++ b/tests/filesystem/test
@@ -72,6 +72,12 @@ BEGIN {
         $test_count   = 55;
         $quota_checks = 0;
     }
+
+    # BTRFS uses internal quotas requiring no security hooks
+    elsif ( $fs_type eq "btrfs" ) {
+        $test_count   = 55;
+        $quota_checks = 0;
+    }
     else {
         $test_count = 69;
     }
diff --git a/tests/fs_filesystem/test b/tests/fs_filesystem/test
index 5dedf83..6bdcc50 100755
--- a/tests/fs_filesystem/test
+++ b/tests/fs_filesystem/test
@@ -75,6 +75,12 @@ BEGIN {
         $test_count   = 54;
         $quota_checks = 0;
     }
+
+    # BTRFS uses internal quotas requiring no security hooks
+    elsif ( $fs_type eq "btrfs" ) {
+        $test_count   = 54;
+        $quota_checks = 0;
+    }
     else {
         $test_count = 68;
     }
-- 
2.26.2

