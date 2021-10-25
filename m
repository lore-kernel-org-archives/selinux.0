Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16437C433EF
	for <selinux@archiver.kernel.org>; Mon, 25 Oct 2021 14:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED60160184
	for <selinux@archiver.kernel.org>; Mon, 25 Oct 2021 14:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhJYOVf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Oct 2021 10:21:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24168 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231246AbhJYOVe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Oct 2021 10:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635171552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Vea8bVc1scjt+1LQ4CK9bdh+xixEG9vzJDJgk3tsrJA=;
        b=as6aYMCo7ITuczK0dm7t2YrVePQFM/129stYJ8KmlEhfBYqgTxKackuEdc2Wust6XhYHog
        DnrQA1iUKlgVWfe70/4dpsc5TYCPXQUtvcE2mLXHfj8WIkFzuY15zkqNEpNgy2//okvR3c
        OaBssD81juC9uaKq88VYVtp/6Sqz6vM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-_Jn5nnsQO8Gh16PnEKmotA-1; Mon, 25 Oct 2021 10:19:10 -0400
X-MC-Unique: _Jn5nnsQO8Gh16PnEKmotA-1
Received: by mail-wm1-f70.google.com with SMTP id u14-20020a05600c19ce00b0030d8549d49aso57656wmq.0
        for <selinux@vger.kernel.org>; Mon, 25 Oct 2021 07:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vea8bVc1scjt+1LQ4CK9bdh+xixEG9vzJDJgk3tsrJA=;
        b=XYtRLb+PG/X3opzQf+OiRkoMnBvIKXCStZXwb+5AfuR0+9rmzvAnv0Ns7lv/fKj6W5
         5XESLum2byGCpSNK24C3UmAe55J3awI41ib+72WFnRq3k3sU4pF0eKBTmRmcgumBLMWf
         Y/z/vMFn6XX1IoBCYD7bBd2f4Lo3WDPKPHJ7xsDWgjINd4XUFkzvRUKJhdbdJjk6JYZz
         ZryOj8LkHAod5DrGXPXfoEwwPkiki6haU7xZpzptrFcrnG4O27mTDBLdMIO0roH7vvJa
         /sJ4Xguy+eodezUOydHm/9npYU6L/Vy35M/92o1d3D+MoiOXeOvn5NAYBtR6X9wnpWT+
         EGlQ==
X-Gm-Message-State: AOAM532KbjIOisprsYXpH2KyvIRaspidDx9DAhMY3wfcUxs8pvcIdxtI
        VNrbc7ybemWHsBWwWSUQ98SVK9owS2WlaTQ++4OmLj1J1KjJtapO6/jV/mi3LRMCsv53stjRJgO
        HD6gBywfsueNbG98d/7tQOobTPWixTqj9LTtTgi2ex6lcZUcPxGeugAIpPFWgIUeJWDHp1g==
X-Received: by 2002:a1c:2541:: with SMTP id l62mr49742093wml.11.1635171549121;
        Mon, 25 Oct 2021 07:19:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMP0d/PWhrtGglhw4mhZMA+igB3eqscUt8xO6ZOwxIqjT6/Jq6WOUzq+e1FC96RPUHEJKzNg==
X-Received: by 2002:a1c:2541:: with SMTP id l62mr49742041wml.11.1635171548627;
        Mon, 25 Oct 2021 07:19:08 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 10sm20794675wme.27.2021.10.25.07.19.07
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 07:19:08 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite v2] tests: make kernel iptables support optional
Date:   Mon, 25 Oct 2021 16:19:07 +0200
Message-Id: <20211025141907.189316-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The legacy iptables API is being deprecated in favor of netfilter and
some distributions are starting to disable it in their kernels (e.g.
Fedora ELN, RHEL 10+). To allow getting a clean run of the testsuite on
such kernels, detect the availability of the ip_tables kernel module and
skip the iptables tests if it's not available (either as a loadable
module or built in).

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

v2: do the same also in tests/sctp, not just tests/inet_socket

 tests/inet_socket/test | 21 ++++++++++++++++-----
 tests/sctp/test        | 21 ++++++++++++++++-----
 2 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/tests/inet_socket/test b/tests/inet_socket/test
index 56a947b..f09b4e3 100755
--- a/tests/inet_socket/test
+++ b/tests/inet_socket/test
@@ -5,7 +5,7 @@ BEGIN {
     $basedir = $0;
     $basedir =~ s|(.*)/[^/]*|$1|;
 
-    $test_count = 38;
+    $test_count = 30;
 
     $test_ipsec = 0;
     if ( system("ip xfrm policy help 2>&1 | grep -q ctx") eq 0 ) {
@@ -27,6 +27,15 @@ BEGIN {
         $test_calipso_stream = 1;
     }
 
+    # Determine if kernel has legacy iptables support
+    $test_iptables = 0;
+
+    $rc = system("modprobe ip_tables 2>/dev/null");
+    if ( $rc == 0 ) {
+        $test_count += 8;
+        $test_iptables = 1;
+    }
+
     # Determine if nftables has secmark support
     $test_nft = 0;
 
@@ -415,10 +424,12 @@ sub test_tables {
     server_end($pid);
 }
 
-print "Testing iptables (IPv4/IPv6).\n";
-system "/bin/sh $basedir/iptables-load";
-test_tables();
-system "/bin/sh $basedir/iptables-flush";
+if ($test_iptables) {
+    print "Testing iptables (IPv4/IPv6).\n";
+    system "/bin/sh $basedir/iptables-load";
+    test_tables();
+    system "/bin/sh $basedir/iptables-flush";
+}
 
 if ($test_nft) {
     print "Testing nftables (IPv4/IPv6).\n";
diff --git a/tests/sctp/test b/tests/sctp/test
index 1170921..0f017e8 100755
--- a/tests/sctp/test
+++ b/tests/sctp/test
@@ -33,7 +33,7 @@ BEGIN {
         plan skip_all => "SCTP not supported";
     }
     else {
-        $test_count = 75;
+        $test_count = 67;
 
         # Set up a GRE tunnel over loopback to ensure we have enough addresses
         # for the ASCONF tests.
@@ -74,6 +74,15 @@ BEGIN {
             $test_calipso = 1;
         }
 
+        # Determine if kernel has legacy iptables support
+        $test_iptables = 0;
+
+        $rc = system("modprobe ip_tables 2>/dev/null");
+        if ( $rc == 0 ) {
+            $test_count += 8;
+            $test_iptables = 1;
+        }
+
         # Determine if nftables has secmark support
         $test_nft = 0;
 
@@ -903,10 +912,12 @@ sub test_tables {
     server_end($pid);
 }
 
-print "# Testing iptables (IPv4/IPv6).\n";
-system "/bin/sh $basedir/iptables-load";
-test_tables();
-system "/bin/sh $basedir/iptables-flush";
+if ($test_iptables) {
+    print "# Testing iptables (IPv4/IPv6).\n";
+    system "/bin/sh $basedir/iptables-load";
+    test_tables();
+    system "/bin/sh $basedir/iptables-flush";
+}
 
 if ($test_nft) {
     print "# Testing nftables (IPv4/IPv6).\n";
-- 
2.31.1

