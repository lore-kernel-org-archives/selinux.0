Return-Path: <SRS0=FZ6t=4J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F6AC35647
	for <selinux@archiver.kernel.org>; Fri, 21 Feb 2020 13:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0272073A
	for <selinux@archiver.kernel.org>; Fri, 21 Feb 2020 13:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="Zg9W9cJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgBUNSc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:18:32 -0500
Received: from mailomta26-sa.btinternet.com ([213.120.69.32]:56709 "EHLO
        sa-prd-fep-043.btinternet.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727928AbgBUNSc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Feb 2020 08:18:32 -0500
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-043.btinternet.com with ESMTP
          id <20200221131829.VDTY27567.sa-prd-fep-043.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Fri, 21 Feb 2020 13:18:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1582291109; 
        bh=gevB4j3T6uHtFUNdqcGlhrEyexfJnuUqK8ulEnSL81w=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version;
        b=Zg9W9cJkgTHFgI29CMn3hKbJEVvDuF/zQQLqLleZJgNrDGCdPrE/T1tCQpotRzMdrPMvGGyi9mTKmEeoUqjA5KV0+dFsTBR4MhXT6D5PEZ7qyOhUSGNw57zrWX8vBEwnDhhT54mz+avVR0S+iHHKShs7KA3MKxIFu/HSs+qWept6WqM2IqrvX/pLN1/98CObWhnFbUW6IOET1NJxzyhSLvxKq+ubKL5NbDf+Ddnt06B8UG7tA1zzsmEw6sO5BjdNmhdxH6Y4rtPC2iXIikrCUnKcS0PqNLLEEmgUarJ4ErwTuoQmuwQmJM9adOm1a6reW4jlHNQ3oyRo9R1yAdWDMg==
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=richard_c_haines@btinternet.com
X-Originating-IP: [86.134.5.24]
X-OWM-Source-IP: 86.134.5.24 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedugedrkeeggdehtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheptfhitghhrghrugcujfgrihhnvghsuceorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqnecukfhppeekiedrudefgedrhedrvdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefgedrhedrvdegpdhmrghilhhfrhhomhepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqedprhgtphhtthhopeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhequcfqtfevrffvpehrfhgtkedvvdenrhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomhdprhgtphhtthhopeeoshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.134.5.24) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5E3A268A029036C3; Fri, 21 Feb 2020 13:18:29 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V2] selinux-testsuite: Allow nfs test script to close cleanly
Date:   Fri, 21 Feb 2020 13:18:25 +0000
Message-Id: <20200221131825.91499-1-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Whenever a failure, close NFS cleanly.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
V2 Changes:
Revamp error handling to cover all cases

 tools/nfs.sh | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/tools/nfs.sh b/tools/nfs.sh
index 314f898..7ba4cfc 100755
--- a/tools/nfs.sh
+++ b/tools/nfs.sh
@@ -1,14 +1,33 @@
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
+
+trap 'err_exit $LINENO' ERR
 
+systemctl start nfs-server
 # Run the full testsuite on a labeled NFS mount.
 exportfs -orw,no_root_squash,security_label localhost:$MOUNT
 mkdir -p /mnt/selinux-testsuite
 mount -t nfs -o vers=4.2 localhost:$TESTDIR /mnt/selinux-testsuite
 pushd /mnt/selinux-testsuite
+MAKE_TEST=1
 make test
+MAKE_TEST=0
 popd
 umount /mnt/selinux-testsuite
 
@@ -18,7 +37,7 @@ echo "Testing context mount of a security_label export."
 fctx=`secon -t -f /mnt/selinux-testsuite`
 if [ "$fctx" != "etc_t" ]; then
     echo "Context mount failed: got $fctx instead of etc_t."
-    exit 1
+    err_exit $LINENO
 fi
 umount /mnt/selinux-testsuite
 exportfs -u localhost:$MOUNT
@@ -30,7 +49,7 @@ echo "Testing context mount of a non-security_label export."
 fctx=`secon -t -f /mnt/selinux-testsuite`
 if [ "$fctx" != "etc_t" ]; then
     echo "Context mount failed: got $fctx instead of etc_t."
-    exit 1
+    err_exit $LINENO
 fi
 umount /mnt/selinux-testsuite
 
@@ -40,7 +59,7 @@ echo "Testing non-context mount of a non-security_label export."
 fctx=`secon -t -f /mnt/selinux-testsuite`
 if [ "$fctx" != "nfs_t" ]; then
     echo "Context mount failed: got $fctx instead of nfs_t."
-    exit 1
+    err_exit $LINENO
 fi
 umount /mnt/selinux-testsuite
 
-- 
2.24.1

