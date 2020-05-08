Return-Path: <SRS0=piI6=6W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BA3C38A2A
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 15:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D189321841
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 15:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fdt2fSEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgEHPmb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 May 2020 11:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgEHPmb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 May 2020 11:42:31 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54C3C05BD43
        for <selinux@vger.kernel.org>; Fri,  8 May 2020 08:42:30 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id q13so1585464qtp.7
        for <selinux@vger.kernel.org>; Fri, 08 May 2020 08:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g3CfCyomGKkI7j5Zij2KCwJJL94XupDKU7TXHJp/Chc=;
        b=Fdt2fSEgChKPcvNlrtvxBiLd20uKTb3zCZrBqPic6BhxFTIfHgnhNawRnZdcbt4Ait
         Z8JvRJ5tR8u4gIC8IdOXuB2ElwVTWlRxHPfzhg3CW6PnJlqiGwk19Z7VZTzhb3oHSLsj
         7Y4XiPk2Z5EmddJBjcEN0ZrcD9Ta0FK1tPC/orx0vWYIFuKBMz1OGmpb93uQuqzSj2jL
         9Kwo0uldeHclbZyWNOHhXldlkUf/Fzx8kMnaBpXLKQyhxWSWQHPPo4eYZNqZ6X7QA01p
         dlEffQGBdv75sGK3FFowdnAc0i91oRkpak4BF+GGl/Za4AwyPPsQxOjsMRpMBCAL57JX
         SoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g3CfCyomGKkI7j5Zij2KCwJJL94XupDKU7TXHJp/Chc=;
        b=IhW6MCr7mge941twxz2FCDOxPENPyW2uHUrYV1PbqsecmVaO2MB8qA23K0vfl5VtoW
         AUub9iyPxYWhEhYpKiRIbzCgQEKEeuRFnj3AhLtiJypiFLGssv1Dh6u13wrbGtKDMTvn
         bPRqZwXhXCiIrpHsBqww3gEAuFCTnWYcSfQeGvv0T6Aj9QfCaiX3yrar9wDl8rbe+GxQ
         sy49r5ySJl9YUOnLZJEFBELDORimHmaE6xaiMdkFf0zO7dfqaOozGQ9Si3x5deHPwFL3
         hBR3Pz5ic99ee0+00/22t6TiR+5Dy0/IYr62Qxf/bRnBiXW1a4s+Bx9GM9BLC8rSxvGd
         KiiA==
X-Gm-Message-State: AGi0PuY80dZEnunq/jiXwmCYWGpu2eW7uGDPWMZtx276KuztOIWia5ow
        AvGk6+u4KkO5lPKNCGm3EI6GIzRt
X-Google-Smtp-Source: APiQypIp/vuN7PnIPusDECQ3zVeSTNpulfsezKhKgQsM+5/VF+UrAUtS5gm+tBp9e0xU/0xwxdDYwQ==
X-Received: by 2002:aed:308e:: with SMTP id 14mr3680124qtf.146.1588952549885;
        Fri, 08 May 2020 08:42:29 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id g5sm309055qkl.114.2020.05.08.08.42.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2020 08:42:28 -0700 (PDT)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     selinux@vger.kernel.org
Cc:     omosnace@redhat.com, paul@paul-moore.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 testsuite 14/15] tests/mmap: skip /dev/zero tests if /dev is noexec
Date:   Fri,  8 May 2020 11:41:37 -0400
Message-Id: <20200508154138.24217-15-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.23.1
In-Reply-To: <20200508154138.24217-1-stephen.smalley.work@gmail.com>
References: <20200508154138.24217-1-stephen.smalley.work@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

If /dev is mounted noexec (as in Debian unstable), then
we cannot mmap/mprotect PROT_EXEC /dev/zero regardless of SELinux.
Check for this situation and skip those tests in that case to avoid
extraneous failures.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 tests/mmap/test | 48 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/tests/mmap/test b/tests/mmap/test
index fe6f184..b7cd56a 100755
--- a/tests/mmap/test
+++ b/tests/mmap/test
@@ -3,10 +3,11 @@
 use Test;
 
 BEGIN {
-    $test_count         = 34;
-    $test_hugepages     = 0;
-    $test_exec_checking = 0;
-    $test_map_checking  = 0;
+    $test_count            = 30;
+    $test_hugepages        = 0;
+    $test_exec_checking    = 0;
+    $test_map_checking     = 0;
+    $test_devzero_checking = 0;
 
     system("echo 1 > /proc/sys/vm/nr_hugepages 2> /dev/null");
     if ( system("grep -q 1 /proc/sys/vm/nr_hugepages 2> /dev/null") == 0 ) {
@@ -19,6 +20,12 @@ BEGIN {
         $test_count += 4;
     }
 
+    if ( system("grep -q '/dev .*noexec' /proc/self/mounts 2> /dev/null") != 0 )
+    {
+        $test_devzero_checking = 1;
+        $test_count += 4;
+    }
+
     if ( -e '/sys/fs/selinux/class/file/perms/map' ) {
         $test_map_checking = 1;
         $test_count += 1;
@@ -62,13 +69,17 @@ ok( $result, 0 );
 $result = system "runcon -t test_no_execmem_t $basedir/mmap_anon_shared 2>&1";
 ok($result);
 
-# Test success and failure for mmap /dev/zero.
-$result =
-  system "runcon -t test_mmap_dev_zero_t $basedir/mmap_file_shared /dev/zero";
-ok( $result, 0 );
-$result = system
-  "runcon -t test_no_mmap_dev_zero_t $basedir/mmap_file_shared /dev/zero 2>&1";
-ok($result);
+if ($test_devzero_checking) {
+
+    # Test success and failure for mmap /dev/zero.
+    $result =
+      system
+      "runcon -t test_mmap_dev_zero_t $basedir/mmap_file_shared /dev/zero";
+    ok( $result, 0 );
+    $result = system
+"runcon -t test_no_mmap_dev_zero_t $basedir/mmap_file_shared /dev/zero 2>&1";
+    ok($result);
+}
 
 # Test success and failure for mprotect w/ anonymous shared memory.
 # In old kernels, this triggers a tmpfs file execute check.
@@ -80,13 +91,16 @@ $result = system
   "runcon -t test_no_mprotect_anon_shared_t $basedir/mprotect_anon_shared 2>&1";
 ok($result);
 
-# Test success and failure for mprotect /dev/zero.
-$result = system
-  "runcon -t test_mprotect_dev_zero_t $basedir/mprotect_file_shared /dev/zero";
-ok( $result, 0 );
-$result = system
+if ($test_devzero_checking) {
+
+    # Test success and failure for mprotect /dev/zero.
+    $result = system
+"runcon -t test_mprotect_dev_zero_t $basedir/mprotect_file_shared /dev/zero";
+    ok( $result, 0 );
+    $result = system
 "runcon -t test_no_mprotect_dev_zero_t $basedir/mprotect_file_shared /dev/zero 2>&1";
-ok($result);
+    ok($result);
+}
 
 # Test success and failure for execheap, independent of execmem.
 $result = system "runcon -t test_execheap_t $basedir/mprotect_heap";
-- 
2.23.1

