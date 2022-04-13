Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483B2C433EF
	for <selinux@archiver.kernel.org>; Wed, 13 Apr 2022 16:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbiDMQul (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Apr 2022 12:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbiDMQui (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Apr 2022 12:50:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44641692B5
        for <selinux@vger.kernel.org>; Wed, 13 Apr 2022 09:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649868496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6rnhRM9s7OjNJewdWTy2bviOlrGMf1a39vu1l1OhdVY=;
        b=CemJfzV5RXa7amPFe7ZKBOb6nu4Q2qYnf0tY0Hg5XWqNmFkhNhO6FYG2AEUDJdeusKnoNH
        KUnDyxZkdRFNWqXgJVnuKxttjKpR40KLPH93LDLOV8fOjeRp4FNgMnjWbvlpCSh5FuCuq8
        tLgD+yDa7OBDnlcL9XSuckhuuMxsneY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-DNFWaNx6PteJ-fvebkJjew-1; Wed, 13 Apr 2022 12:48:15 -0400
X-MC-Unique: DNFWaNx6PteJ-fvebkJjew-1
Received: by mail-wm1-f72.google.com with SMTP id g13-20020a1c4e0d000000b0038eba16aa46so994609wmh.7
        for <selinux@vger.kernel.org>; Wed, 13 Apr 2022 09:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6rnhRM9s7OjNJewdWTy2bviOlrGMf1a39vu1l1OhdVY=;
        b=mEiEUwlwWo91KaXbHLSiVmyeXPcO7NSKAbHtema9IrhOOZzvSCWjy+hTx4g4dpmBFb
         sMF9KEbc9NTnisSahSXmwhme3WuxD1ohuG5zukv92dA+SDpIlfk1nza5PTALJmIZoUTc
         8kdu+00UOUaSS9rwWN0LBg/K0y2Oh2efi/86PTDqDRCiYZu0ZVp/jc0mHX+W4/O8gOf5
         65cz3mMU7c0aEYha/RN3+AWJjsAZiiVnuPCapTTgv7akFWLG4R8EDudGu6TETADxpy4e
         8c2O2nMtqKZTQdsaPOIR94/QUtOaUjHereDx/8LlL26Cxf0zinsS6zYzvFizb4fRGHk3
         Szbg==
X-Gm-Message-State: AOAM5314sRedf3NnkGUe+KustS8F5n6H6WOJX9/0UqR7mtoXPmkSArw9
        RCwTDnYAd9kCoZJCwW2tS4PRvdh0JCQao/85rxcoM0RXskhEWqe9UFvBUXwjSjlkwVd79yAzcKJ
        WUuw0qskMctK3AIwZH0KkpXuXF/t5OlxNCF/mmWvUTyBHtNc8TFJ3P8q0V/ShSjsC2FUwXQ==
X-Received: by 2002:a5d:514e:0:b0:207:ac9c:878b with SMTP id u14-20020a5d514e000000b00207ac9c878bmr8077257wrt.252.1649868493652;
        Wed, 13 Apr 2022 09:48:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2i138Mb9Hn/EuKNMUS8E5RE9zePzxOlY+E7iW5Rvznoi03U8TIdWdautNruNmzIjp1uG9gQ==
X-Received: by 2002:a5d:514e:0:b0:207:ac9c:878b with SMTP id u14-20020a5d514e000000b00207ac9c878bmr8077244wrt.252.1649868493336;
        Wed, 13 Apr 2022 09:48:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id l126-20020a1c2584000000b00387d4f35651sm2991747wml.10.2022.04.13.09.48.12
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 09:48:12 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 2/2] tests: check more thoroughly for SCTP support
Date:   Wed, 13 Apr 2022 18:48:10 +0200
Message-Id: <20220413164810.2122305-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413164810.2122305-1-omosnace@redhat.com>
References: <20220413164810.2122305-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

1. Add SCTP support checking also to extended_socket_class test, where
   it was missing previously.
2. Attempt to explicitly load the 'sctp' module as part of the check to
   ensure that SCTP support is activated and detected also when it is
   excluded from autoloading (as is the case e.g. on RHEL 8+).

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/extended_socket_class/test | 77 ++++++++++++++++++--------------
 tests/sctp/test                  |  4 +-
 2 files changed, 46 insertions(+), 35 deletions(-)

diff --git a/tests/extended_socket_class/test b/tests/extended_socket_class/test
index 022993d..86c706b 100755
--- a/tests/extended_socket_class/test
+++ b/tests/extended_socket_class/test
@@ -3,14 +3,22 @@
 use Test;
 
 BEGIN {
-    $test_count     = 14;
+    $test_count     = 6;
     $test_bluetooth = 0;
+    $test_sctp      = 0;
+
+    # check if SCTP is enabled
+    if ( system("modprobe sctp 2>/dev/null && checksctp 2>/dev/null") eq 0 ) {
+        $test_count += 8;
+        $test_sctp = 1;
+    }
 
     # check if Bluetooth is supported (commonly disabled e.g. on s390x)
     if ( system("modprobe bluetooth 2>/dev/null") eq 0 ) {
         $test_count += 2;
         $test_bluetooth = 1;
     }
+
     plan tests => $test_count;
 }
 
@@ -46,53 +54,56 @@ ok($result);
 # Restore to the kernel defaults - no one allowed to create ICMP sockets.
 system("echo 1 0 > /proc/sys/net/ipv4/ping_group_range");
 
-# Verify that test_sctp_socket_t can create an IPv4 stream SCTP socket.
-$result = system(
-    "runcon -t test_sctp_socket_t -- $basedir/sockcreate inet stream sctp 2>&1"
-);
-ok( $result, 0 );
+if ($test_sctp) {
 
-# Verify that test_no_sctp_socket_t cannot create an IPv4 stream SCTP socket.
-$result = system(
+    # Verify that test_sctp_socket_t can create an IPv4 stream SCTP socket.
+    $result = system(
+"runcon -t test_sctp_socket_t -- $basedir/sockcreate inet stream sctp 2>&1"
+    );
+    ok( $result, 0 );
+
+   # Verify that test_no_sctp_socket_t cannot create an IPv4 stream SCTP socket.
+    $result = system(
 "runcon -t test_no_sctp_socket_t -- $basedir/sockcreate inet stream sctp 2>&1"
-);
-ok($result);
+    );
+    ok($result);
 
-# Verify that test_sctp_socket_t can create an IPv4 seqpacket SCTP socket.
-$result = system(
+    # Verify that test_sctp_socket_t can create an IPv4 seqpacket SCTP socket.
+    $result = system(
 "runcon -t test_sctp_socket_t -- $basedir/sockcreate inet seqpacket sctp 2>&1"
-);
-ok( $result, 0 );
+    );
+    ok( $result, 0 );
 
 # Verify that test_no_sctp_socket_t cannot create an IPv4 seqpacket SCTP socket.
-$result = system(
+    $result = system(
 "runcon -t test_no_sctp_socket_t -- $basedir/sockcreate inet seqpacket sctp 2>&1"
-);
-ok($result);
+    );
+    ok($result);
 
-# Verify that test_sctp_socket_t can create an IPv6 stream SCTP socket.
-$result = system(
-    "runcon -t test_sctp_socket_t -- $basedir/sockcreate inet6 stream sctp 2>&1"
-);
-ok( $result, 0 );
+    # Verify that test_sctp_socket_t can create an IPv6 stream SCTP socket.
+    $result = system(
+"runcon -t test_sctp_socket_t -- $basedir/sockcreate inet6 stream sctp 2>&1"
+    );
+    ok( $result, 0 );
 
-# Verify that test_no_sctp_socket_t cannot create an IPv6 stream SCTP socket.
-$result = system(
+   # Verify that test_no_sctp_socket_t cannot create an IPv6 stream SCTP socket.
+    $result = system(
 "runcon -t test_no_sctp_socket_t -- $basedir/sockcreate inet6 stream sctp 2>&1"
-);
-ok($result);
+    );
+    ok($result);
 
-# Verify that test_sctp_socket_t can create an IPv6 seqpacket SCTP socket.
-$result = system(
+    # Verify that test_sctp_socket_t can create an IPv6 seqpacket SCTP socket.
+    $result = system(
 "runcon -t test_sctp_socket_t -- $basedir/sockcreate inet6 seqpacket sctp 2>&1"
-);
-ok( $result, 0 );
+    );
+    ok( $result, 0 );
 
 # Verify that test_no_sctp_socket_t cannot create an IPv6 seqpacket SCTP socket.
-$result = system(
+    $result = system(
 "runcon -t test_no_sctp_socket_t -- $basedir/sockcreate inet6 seqpacket sctp 2>&1"
-);
-ok($result);
+    );
+    ok($result);
+}
 
 if ($test_bluetooth) {
 
diff --git a/tests/sctp/test b/tests/sctp/test
index 0f017e8..1258de4 100755
--- a/tests/sctp/test
+++ b/tests/sctp/test
@@ -28,8 +28,8 @@ BEGIN {
         $v = " ";
     }
 
-    # check if sctp enabled
-    if ( system("checksctp 2> /dev/null") != 0 ) {
+    # check if SCTP is enabled
+    if ( system("modprobe sctp 2>/dev/null && checksctp 2>/dev/null") != 0 ) {
         plan skip_all => "SCTP not supported";
     }
     else {
-- 
2.35.1

