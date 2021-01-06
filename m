Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9F6C4332D
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 13:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F1F02311E
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 13:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbhAFN2G (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jan 2021 08:28:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47248 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726456AbhAFN2E (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jan 2021 08:28:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609939598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bkmy+sPRJ3GBQ9N4fTsOS+0JPaHqtBA/WIcoxRE4Kqo=;
        b=bfUaEYcduwk3weIgbRNDOFMU9pqE5mdVvl1AeyVV8k+Szn6Qr5cttIKWGAOypY8XugUcDR
        6FYuRU0Tnc2/mvxsC4TMoA8O1DoFBpM87SfIkPzbtRBF7p01UAaLkMKR3I9KxWqM7e0S/R
        O1KVCGnKDplErrCD306XIZuLGqrojtM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-qSM2VcMMMqKTdWIaArEk0w-1; Wed, 06 Jan 2021 08:26:36 -0500
X-MC-Unique: qSM2VcMMMqKTdWIaArEk0w-1
Received: by mail-ed1-f71.google.com with SMTP id g6so1909763edw.13
        for <selinux@vger.kernel.org>; Wed, 06 Jan 2021 05:26:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bkmy+sPRJ3GBQ9N4fTsOS+0JPaHqtBA/WIcoxRE4Kqo=;
        b=T/BryOGgIPKt/0OU2rS42vqsiGlx8iHM2c+xfo4MfJGQpnIw9wnTUbPxQHvgSkeYK9
         d5Yc1VXb1M5Mbk95F5RuyHJrnGs78+CcRoQm3fitFc+7+ssM0IOZXR1pkiyhAeZFX43I
         rq4NkhTOYGNpID2RnubyUD37rpgPTpsN+enJaLmV/l/mTE+fY5Ac8jfN32lYkBMBR7DN
         oGyvuB0cOu4VDUWKjhpAA+3TsVODMrWc9ttoBQdJKkecVG/9pOZscl1/m0EehoQCdRwA
         NMj8MDyrIy2zwTbP7BQNQjFH5xVOh7rQXt/FJ7S9+2dx1xYmI0WHO0fMx/Ss4Xi0ZOLJ
         gSDA==
X-Gm-Message-State: AOAM532p7xzFIS+D+GYCR+l/0924NQAJzrjWyklYTQtWPTTUnmJzIRyp
        6M8D0/z2WMKs9L8+v+lQ46jNkoPAgPrT9ODyQ6i5kOhwDUwhunl/PXN8PaRRKruse/AB46zNS/a
        CHNNoobXyZRGpBA3U7LiZhh6zlGtzCI8lRLtNsXrEuGXDuhj9TagbaXSny3gfrB2zwMfKOQ==
X-Received: by 2002:a17:906:350b:: with SMTP id r11mr2958682eja.143.1609939595174;
        Wed, 06 Jan 2021 05:26:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwKHYElX2zlnRfoyYzjCpsot7Te0of2+UpUR3Iz4s3GgsiPTf0Jr1Vw6xf+65hiihjoGOMECA==
X-Received: by 2002:a17:906:350b:: with SMTP id r11mr2958666eja.143.1609939594876;
        Wed, 06 Jan 2021 05:26:34 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id bm12sm1225893ejb.117.2021.01.06.05.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 05:26:34 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5/5] selinux: mark selinux_xfrm_refcount as __read_mostly
Date:   Wed,  6 Jan 2021 14:26:22 +0100
Message-Id: <20210106132622.1122033-6-omosnace@redhat.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210106132622.1122033-1-omosnace@redhat.com>
References: <20210106132622.1122033-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is motivated by a perfomance regression of selinux_xfrm_enabled()
that happened on a RHEL kernel due to false sharing between
selinux_xfrm_refcount and (the late) selinux_ss.policy_rwlock (i.e. the
.bss section memory layout changed such that they happened to share the
same cacheline). Since the policy rwlock's memory region was modified
upon each read-side critical section, the readers of
selinux_xfrm_refcount had frequent cache misses, eventually leading to a
significant performance degradation under a TCP SYN flood on a system
with many cores (32 in this case, but it's detectable on less cores as
well).

While upstream has since switched to RCU locking, so the same can no
longer happen here, selinux_xfrm_refcount could still share a cacheline
with another frequently written region, thus marking it __read_mostly
still makes sense. __read_mostly helps, because it will put the symbol
in a separate section along with other read-mostly variables, so there
should never be a clash with frequently written data.

Since selinux_xfrm_refcount is modified only in case of an explicit
action, it should be safe to do this (i.e. it shouldn't disrupt other
read-mostly variables too much).

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/xfrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index c367d36965d4f..634f3db24da67 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -47,7 +47,7 @@
 #include "xfrm.h"
 
 /* Labeled XFRM instance counter */
-atomic_t selinux_xfrm_refcount = ATOMIC_INIT(0);
+atomic_t selinux_xfrm_refcount __read_mostly = ATOMIC_INIT(0);
 
 /*
  * Returns true if the context is an LSM/SELinux context.
-- 
2.29.2

