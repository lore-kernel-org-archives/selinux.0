Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E459AC00144
	for <selinux@archiver.kernel.org>; Fri, 29 Jul 2022 12:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbiG2MCn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Jul 2022 08:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbiG2MCn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Jul 2022 08:02:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 92AB1863DF
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659096161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BnOxdtziTPCBTKHzOjlnSAKt875y/kRGevMuZoFMUWE=;
        b=Pu8mg2mV41BRh9q8i3Y0rNB8nqCK0fnRwiLkdoTkPUnhTTxueoHWDWtrlNZLXVkrta0Bfr
        CuwsAZvGCH4QTvBTHCY/yU54CLE7OpKcBe/aqKK8dopm4UnrOvuqYIS2roj4mEbgbCKW2R
        uODgIlqgrQYPmKEXXONufZzLpW1XrTM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-wc1fZsQPOVWHGjv3y0b6Tw-1; Fri, 29 Jul 2022 08:02:40 -0400
X-MC-Unique: wc1fZsQPOVWHGjv3y0b6Tw-1
Received: by mail-wm1-f72.google.com with SMTP id p36-20020a05600c1da400b003a33a8c14f2so2111202wms.7
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=BnOxdtziTPCBTKHzOjlnSAKt875y/kRGevMuZoFMUWE=;
        b=ul0Y6IRJn6GjuausGrSBJypB5rpNzeUPOjQq+ZytWIdy2nELHPPBnDrk7xnz2I8mND
         DDtUXHb0mZAyj2JgXfguYxh7XK0EvZhA/r4HJIvUdaAO06Wj7QUlOhf6bsCgo3it68OZ
         Vxh+5rk1KhmWXPoEV3HFbd+leZL2ui0xzX6DgU7lWiuo0ltnJi7mZA+8fIA2pJxwpwzB
         lBI5in45FCU1C1FMQHeYCPEPdNb/MiQL3ukoRSS8a+mBAypW25aWOpN0qTYmfS2TDkEw
         lU51kXbOJRZ7rHqYsT1IDPgkvcVYeQdlFE2nRErUekc9OsoFefgl+y8w1LqncE/5w1sI
         cdEQ==
X-Gm-Message-State: ACgBeo1BMa/EDc/EZ4ANniyzA/hkGvyVu04nI+7dS9/V1v2b8nk6GktL
        3cgnQkDSMQPnWsHMyEPxrYdBjMvySAyGmqmESaoKX4pP5fsDhBxfWdpbaEAoAqUNEP1YPlKCKNp
        K77E2x+zoNJdOAXw4a2yZzaX2kM9hho+BZA12B1Mp2IM6VMVM3wtGs9OAnLNT2fwSyx2RQA==
X-Received: by 2002:adf:f7c7:0:b0:21e:fc10:b81b with SMTP id a7-20020adff7c7000000b0021efc10b81bmr2307333wrq.51.1659096158267;
        Fri, 29 Jul 2022 05:02:38 -0700 (PDT)
X-Google-Smtp-Source: AA6agR51t/tRTDu3qJlq5JgfmYumNMzuOQX9XXNyxB1eH71W8Nhn/w5EKVx9PxnoCDJi3ynakpXzjg==
X-Received: by 2002:adf:f7c7:0:b0:21e:fc10:b81b with SMTP id a7-20020adff7c7000000b0021efc10b81bmr2307311wrq.51.1659096157896;
        Fri, 29 Jul 2022 05:02:37 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id i3-20020a05600c354300b003a2e92edeccsm9590622wmq.46.2022.07.29.05.02.35
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 05:02:36 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 03/24] test_global.te: don't add domains to system_r
Date:   Fri, 29 Jul 2022 14:02:08 +0200
Message-Id: <20220729120229.207584-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729120229.207584-1-omosnace@redhat.com>
References: <20220729120229.207584-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It doesn't seem to be useful and is unlikely to work without extra rules
anyway.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_global.te | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/policy/test_global.te b/policy/test_global.te
index dae20d6..800e55f 100644
--- a/policy/test_global.te
+++ b/policy/test_global.te
@@ -9,13 +9,11 @@ policy_module(test_policy,1.0.0)
 attribute testdomain;
 
 gen_require(`
-	role system_r;
 	role sysadm_r;
 ')
 
-# Authorize sysadm_r and system_r for the test domains.
+# Authorize sysadm_r for the test domains.
 role sysadm_r types testdomain;
-role system_r types testdomain;
 
 # Allow the test domains to access the sysadm terminal.
 # This allows read and write sysadm ttys and ptys.
-- 
2.37.1

