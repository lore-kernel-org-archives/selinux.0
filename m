Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659E3C64ED6
	for <selinux@archiver.kernel.org>; Wed,  1 Mar 2023 09:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjCAJmV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Mar 2023 04:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjCAJmV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Mar 2023 04:42:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79BD3A870
        for <selinux@vger.kernel.org>; Wed,  1 Mar 2023 01:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677663695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cAARSsCfM3S5WFX9YuHmKUOmUz+uWTN8L7rRJ1zFhts=;
        b=gjikQJNjV/Qzcwd0uQwtXbkW6OdmeOtuXa5NjfbXZL4GQVKhK3dRsfjPV6WOqGAd1pE6qx
        giRYGKMHjGgkRQjtGXTO4uJNohj5MRAaYpm/pv02uEgxy1+++W7TLeCeXYu0AYcwjGY+VP
        arC0StpdIglwUEI4nVE4mcnGxcJkOvI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-649-yeBCbSf9OjisuF6s-UMjaA-1; Wed, 01 Mar 2023 04:41:34 -0500
X-MC-Unique: yeBCbSf9OjisuF6s-UMjaA-1
Received: by mail-wr1-f72.google.com with SMTP id l14-20020a5d526e000000b002cd851d79b2so1211958wrc.5
        for <selinux@vger.kernel.org>; Wed, 01 Mar 2023 01:41:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cAARSsCfM3S5WFX9YuHmKUOmUz+uWTN8L7rRJ1zFhts=;
        b=4w9sxWxpgRnZMF8L55/09dZwC0e8Zs1upODBpL6qdTRwuVUpUQoiG9Q5WQ/qt3dXu0
         257+2cGZEzrqQTAWhIqQBOVbm/FqiC6tP+uQ0XyNudeUC+Yat2rhYcVxHBCyFOZ75JRC
         IHfgazOxXKnLb9ZJ/EAHpm97M9Qj724lbW6MvRr0FWOzCroyn+Dg36i9ChkFzGbKCDuj
         Xta5VmrKSw6401JN4M5uyJNoxU8iBztsKx5/Zpgt9zEC4kHegYbPma4fz0yz9PHEIznY
         OOTzxX2WCrWEkVqZI/nhT7h+2LuWEnQs+mLMEHjonuCmQO5H60InJsFnuQwrIPMHnbKf
         yvng==
X-Gm-Message-State: AO0yUKVZ14hdzVy/PF0le70t3b+wxHdXyFwjPb//sns7bdfurz6BVsMp
        Kg2Y3f3QjztH85yRRcnyXrwjMbtbBfCmNj3rKxUOHqfADKxziwJN7IlhfP0onMpBm7JrlwvguY4
        7NLo4SlY7mnog/A/2d3gb8Aq4oKf/BzJSjIJULdaCObON41N/PY/DWth12cjnO8FGIbMNEafcUx
        Q3xQ==
X-Received: by 2002:a5d:684f:0:b0:2c7:6bf:16cc with SMTP id o15-20020a5d684f000000b002c706bf16ccmr4413549wrw.32.1677663692585;
        Wed, 01 Mar 2023 01:41:32 -0800 (PST)
X-Google-Smtp-Source: AK7set9CpHdqDTA0vypDxWYsjTPRFS2juhAhbLk2i7v/ixid9B0LazR8aaAunwk75AkqLvRXIDIfbw==
X-Received: by 2002:a5d:684f:0:b0:2c7:6bf:16cc with SMTP id o15-20020a5d684f000000b002c706bf16ccmr4413535wrw.32.1677663692236;
        Wed, 01 Mar 2023 01:41:32 -0800 (PST)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id z9-20020a05600c114900b003eb5a531232sm1125798wmz.38.2023.03.01.01.41.31
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 01:41:31 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite] tests/file: make the SIGIO tests work with CONFIG_LEGACY_TIOCSTI=n
Date:   Wed,  1 Mar 2023 10:41:30 +0100
Message-Id: <20230301094130.736231-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Adjust the test to temporarily set the dev.tty.legacy_tiocsti sysctl to
1 if it is 0 and re-enable the SIGIO tests.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

The dev.tty.legacy_tiocsti sysctl fix is now in mainline as commit
f1aa2eb5ea05 ("sysctl: fix proc_dobool() usability"), so we can use
it to re-enable the SIGIO tests.

Passes the CI with the latest kernel-secnext kernel.

 tests/file/test | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/tests/file/test b/tests/file/test
index 0d5ed0e..fa28b7c 100755
--- a/tests/file/test
+++ b/tests/file/test
@@ -26,6 +26,12 @@ system "rm -f $basedir/temp_file 2>&1";
 system "rm -f $basedir/temp_file2 2>&1";
 system "rm -f $basedir/temp_file3 2>&1";
 
+# The test relies on the legacy TIOCSTI ioctl
+$flip_legacy_tiocsti = `sysctl -bn dev.tty.legacy_tiocsti 2>/dev/null` eq "0";
+if ($flip_legacy_tiocsti) {
+    system "sysctl -w dev.tty.legacy_tiocsti=1";
+}
+
 #
 # Create the temp files
 #
@@ -99,10 +105,8 @@ ok( $result, 0 );
 #
 # Attempt to create a SIGIO as the 'good' domain.
 #
-# Temporarily disabled - see:
-# https://lore.kernel.org/selinux/CAHC9VhQwrjwdW27+ktcT_9q-N7AmuUK8GYgoYbPXGVAcjwA4nQ@mail.gmail.com/T/
-#$result = system "runcon -t test_fileop_t -- $basedir/test_sigiotask 2>&1";
-ok(1);
+$result = system "runcon -t test_fileop_t -- $basedir/test_sigiotask 2>&1";
+ok( $result, 0 );
 
 #
 # Attempt to access the restricted file as the 'bad' domain. The first test
@@ -153,10 +157,8 @@ ok( $result, 0 );
 #
 # Attempt to create a SIGIO as the 'bad' domain.
 #
-# Temporarily disabled - see:
-# https://lore.kernel.org/selinux/CAHC9VhQwrjwdW27+ktcT_9q-N7AmuUK8GYgoYbPXGVAcjwA4nQ@mail.gmail.com/T/
-#$result = system "runcon -t test_nofileop_t -- $basedir/test_sigiotask 2>&1";
-ok(1);
+$result = system "runcon -t test_nofileop_t -- $basedir/test_sigiotask 2>&1";
+ok($result);
 
 #
 # Delete the temp files
@@ -165,4 +167,8 @@ system "rm -f $basedir/temp_file 2>&1";
 system "rm -f $basedir/temp_file2 2>&1";
 system "rm -f $basedir/temp_file3 2>&1";
 
+if ($flip_legacy_tiocsti) {
+    system "sysctl -w dev.tty.legacy_tiocsti=0";
+}
+
 exit;
-- 
2.39.2

