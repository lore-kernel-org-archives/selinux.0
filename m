Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D240C00144
	for <selinux@archiver.kernel.org>; Fri, 29 Jul 2022 12:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbiG2MCk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Jul 2022 08:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbiG2MCj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Jul 2022 08:02:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0E0D863E2
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659096157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ru7AO4+krIi1b4RrFRybUL38uPz5oXMkGuUPMxkiesU=;
        b=EUN7zWKStpZPp6eTFnD7mwsPf/uc5/chvTmJWPhiOzveZIx6X1v+/EHCE8zLmSSYaa+LLM
        xb8y5j/uGutEO/xSfxRuFJamqkzAb2NtUEXK71gAeyUWpPYx4U8ZDyFyGXN2KDv0jizvZx
        /jt1231I5IJfaTdn3Fp8UGJbJsPT9Yc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-470-3qpG9hXBPn2lYeh5cYToIA-1; Fri, 29 Jul 2022 08:02:36 -0400
X-MC-Unique: 3qpG9hXBPn2lYeh5cYToIA-1
Received: by mail-wm1-f72.google.com with SMTP id z20-20020a1c4c14000000b003a3020da654so790519wmf.5
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=Ru7AO4+krIi1b4RrFRybUL38uPz5oXMkGuUPMxkiesU=;
        b=LOAEZQFuh9Y7L9IXyJ1JtbQbeAUuM8+X9NA2cD93LOSCtkTvgnZY5YPjutGarCFM3h
         L5h0tLf1J7Io57w6CJOl7xT6emzDN4RjWzKtSpsZ1fPntaoVwGe9Z0qFmRZrxTttOJaM
         QkI/sVeQwuQmotTk5DM0QZyDnweClAbc0HC/CAEFOlEDqQxCbGx8f/2yuq77URtUH3kk
         mN+yoD9gOV+oiQGlTSztnPvWRN0CtIFzPz+jR7HMAp5ucAqeNCWi+S49EY1LEE8aINN8
         VrWcGw9zfyh2ozREmBFf18xclkE/gV7+a2ZDkw492pfgmtab2+kTV5JfgTjgzN4URuNw
         00rQ==
X-Gm-Message-State: AJIora/MQoDBxEdy/PTruhl6KO17l3NwgtX+iABEm59ZoYoF3dBxiPmE
        /aWWRobJglE+9h1ctGtOhO9Ab3IJqDUnu8EQmq2b48F1FGOqXL7ka3giJ0fssb1XxzkpshXIfUo
        wk4AzMDdRIsXVepayvV2Zyxvgn4TNF2RK5nb6Pw1Xaqqs/CWcXe9W+tQJqGizxsHVeLEBow==
X-Received: by 2002:a05:600c:1c2a:b0:3a3:25f7:184d with SMTP id j42-20020a05600c1c2a00b003a325f7184dmr2293408wms.2.1659096154713;
        Fri, 29 Jul 2022 05:02:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t0+1NEwF7/qJMf/MN/zj59ilFonMjkPhgXITTlvUuXX0FJWw7tTe84Tw1NKUsAnhmFcygw5w==
X-Received: by 2002:a05:600c:1c2a:b0:3a3:25f7:184d with SMTP id j42-20020a05600c1c2a00b003a325f7184dmr2293375wms.2.1659096154205;
        Fri, 29 Jul 2022 05:02:34 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id i3-20020a05600c354300b003a2e92edeccsm9590622wmq.46.2022.07.29.05.02.33
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 05:02:33 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 01/24] keys: change test_newcon_key_t to be just an object context
Date:   Fri, 29 Jul 2022 14:02:06 +0200
Message-Id: <20220729120229.207584-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729120229.207584-1-omosnace@redhat.com>
References: <20220729120229.207584-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It's only used to test chaing the label of a key, so there is no need to
declare it as a domain type.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_keys.te | 4 ----
 tests/keys/test     | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/policy/test_keys.te b/policy/test_keys.te
index 78c0663..f6a3f2c 100644
--- a/policy/test_keys.te
+++ b/policy/test_keys.te
@@ -40,10 +40,6 @@ allow test_key_t self:key { create write search read view link setattr };
 
 # Set new context on a keyring:
 type test_newcon_key_t;
-key_domain_type(test_newcon_key_t)
-unconfined_runs_test(test_newcon_key_t)
-typeattribute test_newcon_key_t testdomain;
-typeattribute test_newcon_key_t keydomain;
 
 allow test_key_t test_newcon_key_t:key { create write search view };
 
diff --git a/tests/keys/test b/tests/keys/test
index 2dafb17..061bc62 100755
--- a/tests/keys/test
+++ b/tests/keys/test
@@ -67,7 +67,7 @@ ok( $result >> 8 eq 11 );
 
 print "Change keyring context\n";
 $result = system
-"runcon -t test_key_t $basedir/keyctl_relabel $v system_u:system_r:test_newcon_key_t:s0";
+"runcon -t test_key_t $basedir/keyctl_relabel $v system_u:object_r:test_newcon_key_t:s0";
 ok( $result eq 0 );
 
 print "Test permission checks between a keyring created by another process\n";
-- 
2.37.1

