Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4D2C433DF
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 11:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B61F20774
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 11:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aGPXla08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgHXLan (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 07:30:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22980 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726337AbgHXLah (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 07:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598268623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jRbF9eqt+fCBbJGPV0nNnxFNxJFBANrDtCOL4UOfKs4=;
        b=aGPXla08jbrGUYBsfJU3P9G15p1MSr10vHeBt0CYOYIST/bajjyS4HeaYsXq4k/bHGRgU+
        xz3fTERALwNAXVVlNaGbeFEYWBRFWJLnnImw8ZJGe7NHftgKfF2iPzd/qatpoKTYtIXGXE
        /O/7DQr9GXsgpPuYDQWvowmR8EBKiJE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-W0ns5G5GNya6d02XSM08UA-1; Mon, 24 Aug 2020 07:30:20 -0400
X-MC-Unique: W0ns5G5GNya6d02XSM08UA-1
Received: by mail-wr1-f70.google.com with SMTP id g3so3717575wrx.1
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 04:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jRbF9eqt+fCBbJGPV0nNnxFNxJFBANrDtCOL4UOfKs4=;
        b=gn+ec8ot8TKQmLRq9dinADsioHtSpgLYKaEBoKV1E+ZS/Uhu/WGN5jdIgGwbh0cXH9
         l3ffSr9vVl/LCXFyyVnZAaZqt3JkpNVO/Kps9bEvszzwt9dtjVHg0RwvvPiNYQjPOA5J
         OLOVXsQIMM1TSQv/6t60aVfrUGRPbmvyihGryoQoom8xyEhtA8tsBEIOcezNmmXWCp9Q
         C7vDezBHfR3a3ZaF6WbYoxg9vNw43wRbJLN+XDqGAtwd/ye4etZ0DoIvVf8f0xwQ39dB
         b2jbDZ+fmi2ZpiKB5KhJ3ZObKVOHrpUaAyUi/TJ+SNS0j2lixcO2Fj4gSCnFk3Jr95Hf
         vYSw==
X-Gm-Message-State: AOAM531TPV8xZGdbLXVkxuT06eh2ZLK2GFGAm2B/bmAHH2zj1Uge3nn4
        Xx5sqYrqA4PW8D8SY9jNFU4k/le7AHzQIPBmRtlNk31/vLIr/Ka2xumelJldYWXss42buyqJFm4
        u8N6Gud/B4DECrbkDeA==
X-Received: by 2002:a1c:dc45:: with SMTP id t66mr5499241wmg.17.1598268618793;
        Mon, 24 Aug 2020 04:30:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnZb6xSf+SmZ+4Fag6NCRqjC5oelQUR3r8b9Sj1VewgihYa0okDjJE94vxthwcRebW499IBg==
X-Received: by 2002:a1c:dc45:: with SMTP id t66mr5499218wmg.17.1598268618601;
        Mon, 24 Aug 2020 04:30:18 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:e83d:a4fb:e589:6902])
        by smtp.gmail.com with ESMTPSA id l1sm25092434wrb.12.2020.08.24.04.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 04:30:18 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/2] selinux: fix a race condition in security_read_policy()
Date:   Mon, 24 Aug 2020 13:30:14 +0200
Message-Id: <20200824113015.1375857-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200824113015.1375857-1-omosnace@redhat.com>
References: <20200824113015.1375857-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In security_read_policy(), the policy length is computed using
security_policydb_len(), which does a separate transaction, and then
another transaction is done to write the policydb into a buffer of this
length.

The bug is that the policy might be re-loaded in between the two
transactions and so the length can be wrong. In case the new length is
lower than the old length, the length is corrected at the end of the
function. In case the new length is higher than the old one, an error is
returned.

Since we can't call vmalloc_user() under read_lock(), fix it by checking
if the allocated buffer is sufficiently large after doing the allocation
and taking the read lock and if not, retry the whole operation with the
new size.

Fixes: cee74f47a6ba ("SELinux: allow userspace to read policy back out of the kernel")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/services.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index a48fc1b337ba9..2c9072f095985 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3849,14 +3849,22 @@ int security_read_policy(struct selinux_state *state,
 
 	*len = security_policydb_len(state);
 
+again:
 	*data = vmalloc_user(*len);
 	if (!*data)
 		return -ENOMEM;
 
+	read_lock(&state->ss->policy_rwlock);
+	if (*len < state->ss->policy->policydb.len) {
+		*len = state->ss->policy->policydb.len;
+		read_unlock(&state->ss->policy_rwlock);
+		vfree(*data);
+		goto again;
+	}
+
 	fp.data = *data;
 	fp.len = *len;
 
-	read_lock(&state->ss->policy_rwlock);
 	rc = policydb_write(&state->ss->policy->policydb, &fp);
 	read_unlock(&state->ss->policy_rwlock);
 
-- 
2.26.2

