Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF720C19F29
	for <selinux@archiver.kernel.org>; Fri, 29 Jul 2022 12:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbiG2MDG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Jul 2022 08:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236038AbiG2MDF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Jul 2022 08:03:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5447863DF
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659096183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LCF9DGlA9T4PWbunOsop8821ncNHZnLOj3MQvujaMv4=;
        b=MBOWZ3KpstogPo1kopzMWkyyB8HQTnTVv2A4Ky6ot4nbQ+unJZld86mcUgRE8Jhgc9nT1t
        0YykTf1xPqE+uLc9Gd0oiVzxkP2GvPSXA/DsrjTPzi9lnOkWs26bU6udi1PaAKRmUE+4Pm
        nsm6IHJRTmS7AfDZ6jVfOtKQy4PNvZ4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-3rp0qJnVM1qxWRkS_n59rg-1; Fri, 29 Jul 2022 08:03:02 -0400
X-MC-Unique: 3rp0qJnVM1qxWRkS_n59rg-1
Received: by mail-wm1-f71.google.com with SMTP id h189-20020a1c21c6000000b003a2fdf9bd2aso2107837wmh.8
        for <selinux@vger.kernel.org>; Fri, 29 Jul 2022 05:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=LCF9DGlA9T4PWbunOsop8821ncNHZnLOj3MQvujaMv4=;
        b=nPVrICQPzQ3tMsphMOQPxPpeqcSuamIq9FzY6yJWzMUbmWWNay+h4IlSclxWNL9cRT
         ipD/mHXqQRzoEqBEyx4j16Rdx7r3JlhyRxdFaB3vMSIdfeuQNyL2NjITQ86YQmMpkOPj
         RnkmfKXUDBfOa8HqRM3Xi8dXCp2U2JiH+54j7ROMsVw03lIg+lDRMJmIweY+YOvHTWWI
         7gp2sOsFqGzz5pbes9p81VwyR38+6kF6J952m8PJUb52/XeFUv5WP/sHNHMy8XE0CZfK
         qx0VA9i89cgvWdDi5PI4BFphnb+Z7IImtI0bWkMrnZ0wgNosySdh/GCVZZkOWCgPhLA1
         U34A==
X-Gm-Message-State: ACgBeo3vkEBtTm9WNNAmgbzrBMKwyhpASz9pe61DIHh3b3BpLLqboJlZ
        1RYQDllOi4s8tOBf7PP6o5i5wKe0aUEGLZyLamBlqrb5g/KgmaceacfYIQ2I2S/dMUYE2PhkvWP
        PbFVSFAKMTyVCwYAdq5prsVvX3A/TtTQy2hV0E+HXsfZUp9BH8BQx8OFktYayUCwkc4AYbA==
X-Received: by 2002:a05:6000:1789:b0:21e:87cd:beba with SMTP id e9-20020a056000178900b0021e87cdbebamr2309243wrg.252.1659096180590;
        Fri, 29 Jul 2022 05:03:00 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6LWcSeZ/2dyMJOgdPJKSxU/lbRqcgCBH76GA/oNNfjSQK/sI346EGv1/DQ/IxVUS2craAT5A==
X-Received: by 2002:a05:6000:1789:b0:21e:87cd:beba with SMTP id e9-20020a056000178900b0021e87cdbebamr2309181wrg.252.1659096179732;
        Fri, 29 Jul 2022 05:02:59 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id i3-20020a05600c354300b003a2e92edeccsm9590622wmq.46.2022.07.29.05.02.58
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 05:02:58 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 18/24] policy: don't audit testsuite programs searching the caller's keys
Date:   Fri, 29 Jul 2022 14:02:23 +0200
Message-Id: <20220729120229.207584-19-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729120229.207584-1-omosnace@redhat.com>
References: <20220729120229.207584-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

During the test such denials may occur. Since they don't affect testing,
prevent them from being audited to have a cleaner AVC log.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_global.te | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/policy/test_global.te b/policy/test_global.te
index 91bddd8..7d399e6 100644
--- a/policy/test_global.te
+++ b/policy/test_global.te
@@ -66,6 +66,9 @@ optional_policy(`
 # Needed for domains outside domain_type()
 dontaudit testsuite_caller_domain testsuite_domain:process { noatsecure rlimitinh siginh };
 
+# keys test may trigger search AVCs for root's keys
+dontaudit testsuite_domain testsuite_caller_domain:key { search };
+
 # Allow the test domains to access the sysadm terminal.
 # This allows read and write sysadm ttys and ptys.
 term_use_all_terms(testsuite_domain)
-- 
2.37.1

