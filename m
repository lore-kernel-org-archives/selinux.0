Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2942DC00144
	for <selinux@archiver.kernel.org>; Fri, 29 Jul 2022 12:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbiG2MEX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Jul 2022 08:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiG2MEW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Jul 2022 08:04:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8803187F78
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659096255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KRxjHHqzHBqY4RziYhDHZxHV/fCKj6E/Apg+1qTky88=;
        b=DA6v6f5LeJqHZ2VdWyg/HuEVUzQAnZk8fZKrJw0n7SuCiLv0DLIhA3fm7r5K/74vhGTNp1
        Ix4pKSkCoRdS+5f14IQ8qI1gZq0ker6UWP/VRW1bH2hSzz8lG+ptdDjcuhtaRHQ8LhaM1+
        tO+zy4DQ8gdWTA1Wx/xhujDvAaVJ6Gg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-257-Pcp24iJIMC2KZzlcr9iMbg-1; Fri, 29 Jul 2022 08:03:06 -0400
X-MC-Unique: Pcp24iJIMC2KZzlcr9iMbg-1
Received: by mail-wr1-f72.google.com with SMTP id x5-20020adfbb45000000b0021ee56506dfso1150122wrg.11
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=KRxjHHqzHBqY4RziYhDHZxHV/fCKj6E/Apg+1qTky88=;
        b=KMn8V/8NAAeHlexOTtciqJOuC2a2Ah7e/P63reoIghBB483QB3AahZwh7OpEn49CqP
         /p5mepeFMiljPe0PDLOn/lDsWatfMIPmmoLxlcaKr5iDl0rRJ+uhonicnjSI+/dGNk+m
         Ivj4nqVtTeyGVt6xg7EqHZPrIiMI8j4ekoR7h7LMA7tbMP0PbCrNig1mMGPBPHfgqZa6
         DTC3+r7fIUIpBIiEGp1ng/yVXPZjFY4wvBU0rxywIeTZbVjSmD8A81GKTHmD2gjwhVh6
         mM9EE4YqOANrlmlWhJnbpNAH5/rVDj+CJIDMolAZSEiEc0UULAcv9VAYc3e0VwLTfbVY
         SYtg==
X-Gm-Message-State: ACgBeo3Zfe0HLVvRyZGGR5/YVSE9xga58TWBsZiJ4BpcTmJXC9qOVCT1
        DDy/lnRvKxIkZ88KPTFeIhbEz5A2WoI6QBOg4pePx2ov4Tv1GV5ZK/GnpAwiiKsYk/TJ6dpZcHS
        lLzHg9f668GUJMsbqwRQZyFA1sDrVvAjVYLBWPuR2iJ58GI01IC7piyDoPjIW/s4MHeTrjg==
X-Received: by 2002:a5d:6608:0:b0:21f:127d:6f8c with SMTP id n8-20020a5d6608000000b0021f127d6f8cmr1448864wru.75.1659096184349;
        Fri, 29 Jul 2022 05:03:04 -0700 (PDT)
X-Google-Smtp-Source: AA6agR58kdwYip8qx1eyOJ1ZEWncXLKx+bj6ZULlFn7RmmFxUhlX4DPIJA33z7zVe0peraMN04dZhA==
X-Received: by 2002:a5d:6608:0:b0:21f:127d:6f8c with SMTP id n8-20020a5d6608000000b0021f127d6f8cmr1448833wru.75.1659096183998;
        Fri, 29 Jul 2022 05:03:03 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id i3-20020a05600c354300b003a2e92edeccsm9590622wmq.46.2022.07.29.05.03.02
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 05:03:02 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 21/24] tests/overlay: don't hard-code SELinux user of the caller
Date:   Fri, 29 Jul 2022 14:02:26 +0200
Message-Id: <20220729120229.207584-22-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729120229.207584-1-omosnace@redhat.com>
References: <20220729120229.207584-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

We want to allow the testsuite caller to be other than unconfined, so
extract the user from current context and use it instead of hard-coding
unconfined_u.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/overlay/setup-overlay |  2 +-
 tests/overlay/test          | 34 ++++++++++++++++------------------
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/tests/overlay/setup-overlay b/tests/overlay/setup-overlay
index 4fcd023..3f33499 100755
--- a/tests/overlay/setup-overlay
+++ b/tests/overlay/setup-overlay
@@ -41,7 +41,7 @@ setup () {
 
     # Create upper, work, and overlay directories per container.
     mkdir -p $BASEDIR/container1/upper $BASEDIR/container1/work $BASEDIR/container1/merged
-    chcon -R unconfined_u:object_r:test_overlay_files_ro_t:s0:c10,c20 $BASEDIR/container1
+    chcon -R -t test_overlay_files_ro_t -l s0:c10,c20 $BASEDIR/container1
 
     # Label the container directories to match the container context.
     # This is simply to ensure correct label inheritance on new file
diff --git a/tests/overlay/test b/tests/overlay/test
index 2b28c47..c8367dd 100755
--- a/tests/overlay/test
+++ b/tests/overlay/test
@@ -5,6 +5,10 @@ BEGIN {
     $basedir = $0;
     $basedir =~ s|(.*)/[^/]*|$1|;
 
+    $seuser = `id -Z`;
+    chop($seuser);
+    $seuser =~ s|^(\w+):.*$|$1|;
+
     $isnfs = `stat -f --print %T $basedir`;
 
     # check if kernel supports overlayfs and SELinux labeling
@@ -92,7 +96,7 @@ sub test_4_0 {
     $output = getfilecon("$basedir/container1/upper/writefile");
 
     # Newly created writefile should have s0 MCS Label since it was copied up
-    ok( $output eq "unconfined_u:object_r:test_overlay_files_rwx_t:s0" );
+    ok( $output eq "$seuser:object_r:test_overlay_files_rwx_t:s0" );
 }
 
 sub test_4_0_ctx {
@@ -100,8 +104,7 @@ sub test_4_0_ctx {
     $output = getfilecon("$basedir/container1/upper/writefile");
 
     # Newly created writefile should have s0 MCS Label since it was copied up
-    ok( $output eq
-          "unconfined_u:object_r:test_overlay_files_rwx_t:s0:c10,c20" );
+    ok( $output eq "$seuser:object_r:test_overlay_files_rwx_t:s0:c10,c20" );
 }
 
 sub test_5 {
@@ -127,8 +130,7 @@ sub test_5_1 {
     $output = getfilecon("$basedir/container1/upper/newdir");
 
     # Newly created writedir should have s0:c10,c20 since it was created new
-    ok( $output eq
-          "unconfined_u:object_r:test_overlay_files_rwx_t:s0:c10,c20" );
+    ok( $output eq "$seuser:object_r:test_overlay_files_rwx_t:s0:c10,c20" );
 }
 
 sub test_5_2 {
@@ -146,8 +148,7 @@ sub test_5_3 {
     $output = getfilecon("$basedir/container1/upper/newdir/touchlink");
 
     # Newly created writelink should have s0:c10,c20 since it was created new
-    ok( $output eq
-          "unconfined_u:object_r:test_overlay_files_rwx_t:s0:c10,c20" );
+    ok( $output eq "$seuser:object_r:test_overlay_files_rwx_t:s0:c10,c20" );
 }
 
 sub test_6 {
@@ -173,7 +174,7 @@ sub test_7_0 {
     $output = getfilecon("$basedir/container1/upper/writedir/bar");
 
     # Newly created bar should have s0:c10,c20 since it was created new
-    ok( $output eq "unconfined_u:object_r:test_overlay_files_rwx_t:s0" );
+    ok( $output eq "$seuser:object_r:test_overlay_files_rwx_t:s0" );
 }
 
 sub test_7_0_ctx {
@@ -181,8 +182,7 @@ sub test_7_0_ctx {
     $output = getfilecon("$basedir/container1/upper/writedir/bar");
 
     # Newly created bar should have s0:c10,c20 since it was created new
-    ok( $output eq
-          "unconfined_u:object_r:test_overlay_files_rwx_t:s0:c10,c20" );
+    ok( $output eq "$seuser:object_r:test_overlay_files_rwx_t:s0:c10,c20" );
 }
 
 sub test_7_1 {
@@ -200,7 +200,7 @@ sub test_7_1_0 {
     $output = getfilecon("$basedir/container1/upper/writedir/writelink");
 
     # Newly created writelink should have s0:c10,c20 since it was created new
-    ok( $output eq "unconfined_u:object_r:test_overlay_files_rwx_t:s0" );
+    ok( $output eq "$seuser:object_r:test_overlay_files_rwx_t:s0" );
 }
 
 sub test_7_1_0_ctx {
@@ -208,8 +208,7 @@ sub test_7_1_0_ctx {
     $output = getfilecon("$basedir/container1/upper/writedir/writelink");
 
     # Newly created writelink should have s0:c10,c20 since it was created new
-    ok( $output eq
-          "unconfined_u:object_r:test_overlay_files_rwx_t:s0:c10,c20" );
+    ok( $output eq "$seuser:object_r:test_overlay_files_rwx_t:s0:c10,c20" );
 }
 
 sub test_7_2 {
@@ -445,7 +444,7 @@ sub test_42 {
 
     # Newly created writeout should have s0:c10,c20 since it was created new
     ok( $output eq
-          "unconfined_u:object_r:test_overlay_transition_files_t:s0:c10,c20" );
+          "$seuser:object_r:test_overlay_transition_files_t:s0:c10,c20" );
 }
 
 sub test_42_ctx {
@@ -453,8 +452,7 @@ sub test_42_ctx {
     $output = getfilecon("$basedir/container1/upper/transition");
 
     # Newly created writeout should have s0:c10,c20 since it was created new
-    ok( $output eq
-          "unconfined_u:object_r:test_overlay_files_rwx_t:s0:c10,c20" );
+    ok( $output eq "$seuser:object_r:test_overlay_files_rwx_t:s0:c10,c20" );
 }
 
 sub test_43 {
@@ -822,7 +820,7 @@ sub nocontext_test {
 sub context_test {
 
     cleanup();
-    $context = "unconfined_u:object_r:test_overlay_files_rwx_t:s0:c10,c20";
+    $context = "$seuser:object_r:test_overlay_files_rwx_t:s0:c10,c20";
     print "\n\n=====================================================\n";
     print "Testing mounting overlayfs with context switch\n";
     print "context=$context\n";
@@ -943,7 +941,7 @@ sub context_test {
 sub context_rot_t_test {
 
     cleanup();
-    $context = "unconfined_u:object_r:test_overlay_files_ro_t:s0:c10,c20";
+    $context = "$seuser:object_r:test_overlay_files_ro_t:s0:c10,c20";
     print "\n\n=====================================================\n";
     print "Testing mounting overlayfs with context switch\n";
     print "context=$context\n";
-- 
2.37.1

