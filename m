Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC593C433EF
	for <selinux@archiver.kernel.org>; Mon, 25 Oct 2021 12:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A648A60EE9
	for <selinux@archiver.kernel.org>; Mon, 25 Oct 2021 12:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbhJYMvO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Oct 2021 08:51:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53830 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233207AbhJYMvM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Oct 2021 08:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635166130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mvmbLT9WgPX03SbMT164V1m6GhifzbWvvl01DlPj/XY=;
        b=iY95PMsnZcS8qLw1qXDddkk9U3T2tBQcEcw3kt8ub3HNhTcc7bAl59ZJ4PLXZSfon/qHqc
        akF+OTxSGkK0pNh/yNVGQv9kEa2rV5/OmJvuavoJwTbVsvueYfShOwaya9bRIUgToweRfD
        EzjQT8KHZkFdr+JdbM2JXQf8vSHyCtE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-9D4iMw2DNMyCp-zwv1HlGg-1; Mon, 25 Oct 2021 08:48:48 -0400
X-MC-Unique: 9D4iMw2DNMyCp-zwv1HlGg-1
Received: by mail-wr1-f71.google.com with SMTP id y9-20020a5d6209000000b001684625427eso2030587wru.7
        for <selinux@vger.kernel.org>; Mon, 25 Oct 2021 05:48:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mvmbLT9WgPX03SbMT164V1m6GhifzbWvvl01DlPj/XY=;
        b=UdpkWFMkwrDy/tvpcSDdqVBS5mVl55kZDaLR4CssTfqq86qs4lhHbJ7PgVQHeKvZWr
         iqCccbii39ncsKcgnLrssJr7wMDDGzWqo9NIMd5PWejeMjvuHQxymeSyNObF9DhOP2B+
         wTWozlcer1P3Z7EYcOW949yLJQZi8l8Xq2PT5wnfuNCm2Fh3WyLa5kkVoblz7QcA0uoB
         SCWdnBqHITMuspz/EywUEZ6FUo2FcPdyvJi+sdEevKKGOLmX+5l0QRC7EQY0mZtgG7e1
         s4pfb0ZcOXtOo+37MFJ5i85YVC5RYp7Zkae+8yZAttgc3b7FBr4wopIWxcR3ukhoxbT2
         P1uQ==
X-Gm-Message-State: AOAM5336sNccXSsWwJIMmpk7/QQ8ErSFsV5pDrPLqfQZoy1lChnXbR22
        vh5Dmx/d4viLJhSDttDxultoZS67jpfk+m4JR4uC3yunSp9rPtX4wd3klZu8FHDieBt+FoMjoUo
        GaJ00DcKO9Kp1mM3Y7/pDc7wC8WlNyaC9RUIjJa09W46KzAlEASu/mhgWipLV2lEIYo6/pg==
X-Received: by 2002:a1c:29c2:: with SMTP id p185mr49102532wmp.43.1635166127016;
        Mon, 25 Oct 2021 05:48:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyr0gkDITjY4YB9c1Lt45ympSjyEQsJ2Xno5PP6ZT1Dwu0fJrvA2FiH3Jl0MAYToDpk+PCIQ==
X-Received: by 2002:a1c:29c2:: with SMTP id p185mr49102512wmp.43.1635166126734;
        Mon, 25 Oct 2021 05:48:46 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id k22sm16752086wrd.59.2021.10.25.05.48.46
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 05:48:46 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] tests/inet_socket: make kernel iptables support optional
Date:   Mon, 25 Oct 2021 14:48:45 +0200
Message-Id: <20211025124845.179775-1-omosnace@redhat.com>
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
 tests/inet_socket/test | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

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
-- 
2.31.1

