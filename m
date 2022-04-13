Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D57C433FE
	for <selinux@archiver.kernel.org>; Wed, 13 Apr 2022 16:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbiDMQul (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Apr 2022 12:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235357AbiDMQuh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Apr 2022 12:50:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29059694A8
        for <selinux@vger.kernel.org>; Wed, 13 Apr 2022 09:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649868495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hr6zrDMIEqWAmyjpPwyMqgOOAysOXSxntLvl/qPR2EE=;
        b=gqidc+ErJUsA2p90IXfy1AiG7dmYmBlttrWEdXOSFHVW1iH606cZwb0Bqcg+pQurRpkZ+8
        ijHvfHBR4Rag3tyn5TqaeZ/1l5fBGg9MUUHwHaK/s6SwFwSxS0yeKdBm2pkNv5utSGvyC6
        CGcs7A26QPQ7uNtUjJ2t6ns7QOF1cWQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-F_J65YTVM2uIjgZtRXvN5w-1; Wed, 13 Apr 2022 12:48:13 -0400
X-MC-Unique: F_J65YTVM2uIjgZtRXvN5w-1
Received: by mail-wm1-f71.google.com with SMTP id o35-20020a05600c512300b0038e83a52c71so1115193wms.7
        for <selinux@vger.kernel.org>; Wed, 13 Apr 2022 09:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hr6zrDMIEqWAmyjpPwyMqgOOAysOXSxntLvl/qPR2EE=;
        b=oaDXI3aX2ch3IDWSlAEAb6mNlNndjv9eULvyDDfZso+Xk/Oam0lr2R+ykykzpr9JgC
         zELoJ73SUaDChItqth0dkb6RWwLTadJLwgP68pIb4+pPzsgt9m5X9ciJl6OkrjvG24Ag
         K1+iC+RvQMKu6sfxCHDb5opAwGgP5XgJER5IWbRdx2ocCVzL0EwpckpvZOl7pjpdLi+3
         awqHSozeHHXNhDaC/zr28cP50jSjaJndsDiQZJJlyKCHlGKCFXiNKe9Ueeapo9NWJnR0
         x5QmjCFdoVQs0hzkctO6xeCFqSrx/EFvz3/Ffmz5fk0DEDuR6TXuzjzgjw0nOzx2EEzd
         WCZw==
X-Gm-Message-State: AOAM532wFOS5G3vQwLvud64eBg3kEzBv9mBfTmKl2htKL0ZKifJdk0dU
        cq6NnzlgVEpBX3gP8jk75X9dKywqkLMMJ3M61QMclay4lWeJMLlP8HeraqpVDJ4qefevHHSpENj
        c4DKoqRf1SowFSzricujlbULJUVBgIoCBLZyDaEYJYhjTGgv9BFewmnZAvLhUerhMSlaQDg==
X-Received: by 2002:a05:600c:1f0f:b0:38e:c9c8:9983 with SMTP id bd15-20020a05600c1f0f00b0038ec9c89983mr7610862wmb.105.1649868492538;
        Wed, 13 Apr 2022 09:48:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWlPrS0a8yV9nLThQuMrB15Wq0wUFB5K9koUB1vxWIEDjCZTzABWccxtcmJTLaR6yQcXws6Q==
X-Received: by 2002:a05:600c:1f0f:b0:38e:c9c8:9983 with SMTP id bd15-20020a05600c1f0f00b0038ec9c89983mr7610843wmb.105.1649868492312;
        Wed, 13 Apr 2022 09:48:12 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id l126-20020a1c2584000000b00387d4f35651sm2991747wml.10.2022.04.13.09.48.11
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 09:48:11 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 1/2] tests/extended_socket_class: make Bluetooth support optional
Date:   Wed, 13 Apr 2022 18:48:09 +0200
Message-Id: <20220413164810.2122305-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413164810.2122305-1-omosnace@redhat.com>
References: <20220413164810.2122305-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

CONFIG_BT is commonly disabled on some architectures due to lack of
relevant HW - for example s390x on Fedora/RHEL and aarch64 on RHEL. Make
the testsuite work without it to make testing easier in such
environments.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/extended_socket_class/test | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/tests/extended_socket_class/test b/tests/extended_socket_class/test
index 6e334d1..022993d 100755
--- a/tests/extended_socket_class/test
+++ b/tests/extended_socket_class/test
@@ -1,7 +1,18 @@
 #!/usr/bin/perl
 
 use Test;
-BEGIN { plan tests => 16 }
+
+BEGIN {
+    $test_count     = 14;
+    $test_bluetooth = 0;
+
+    # check if Bluetooth is supported (commonly disabled e.g. on s390x)
+    if ( system("modprobe bluetooth 2>/dev/null") eq 0 ) {
+        $test_count += 2;
+        $test_bluetooth = 1;
+    }
+    plan tests => $test_count;
+}
 
 $basedir = $0;
 $basedir =~ s|(.*)/[^/]*|$1|;
@@ -83,17 +94,20 @@ $result = system(
 );
 ok($result);
 
-# Verify that test_bluetooth_socket_t can create a Bluetooth socket.
-$result = system(
+if ($test_bluetooth) {
+
+    # Verify that test_bluetooth_socket_t can create a Bluetooth socket.
+    $result = system(
 "runcon -t test_bluetooth_socket_t -- $basedir/sockcreate bluetooth stream default 2>&1"
-);
-ok( $result, 0 );
+    );
+    ok( $result, 0 );
 
-# Verify that test_no_bluetooth_socket_t cannot create a Bluetooth socket.
-$result = system(
+    # Verify that test_no_bluetooth_socket_t cannot create a Bluetooth socket.
+    $result = system(
 "runcon -t test_no_bluetooth_socket_t -- $basedir/sockcreate bluetooth stream default 2>&1"
-);
-ok($result);
+    );
+    ok($result);
+}
 
 # Verify that test_alg_socket_t can create a Crypto API socket.
 $result = system(
-- 
2.35.1

