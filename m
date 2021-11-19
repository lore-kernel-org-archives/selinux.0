Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6966FC433EF
	for <selinux@archiver.kernel.org>; Fri, 19 Nov 2021 13:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4971B61A02
	for <selinux@archiver.kernel.org>; Fri, 19 Nov 2021 13:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbhKSNs1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Nov 2021 08:48:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50321 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235424AbhKSNs0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Nov 2021 08:48:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637329524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=B69KSI9ZePhLUlWVxQX+bcaJ5lCjUFrjX2eORAqus18=;
        b=GKonkCUrG54O7b4FuaiilU3ilCRtc5AFlyjAH+vwiczVgV2eoLI70Tn17/A+erZbvI/cyQ
        L/TzeSVdlJwFtB2BegHSsHEswcabiWRnzXqnVJAwb69CIGg7xrDcWCX3CJrZwn5kqSvzWs
        E3LvdEJCszMxeGF6s16be4KQtxWIA9k=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-384-zLZspMKvMiSRZhBnq40Nyw-1; Fri, 19 Nov 2021 08:45:23 -0500
X-MC-Unique: zLZspMKvMiSRZhBnq40Nyw-1
Received: by mail-ed1-f69.google.com with SMTP id t9-20020aa7d709000000b003e83403a5cbso6475104edq.19
        for <selinux@vger.kernel.org>; Fri, 19 Nov 2021 05:45:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B69KSI9ZePhLUlWVxQX+bcaJ5lCjUFrjX2eORAqus18=;
        b=dALfRx59hNTWesVIno7/y27hsUeMb1FPj/c1QKl/bCe8y5rRpgh4JBt2a+YjqBeVof
         MSmsMbzhEjG4IcHyWdpE4QkdyG5qhFVXPwdGGvsF+hbH5W7ZM0RMnRjcx5ubLBMqSNau
         DRj29KfJmT/zxhw4s25+o+HvPqzelgzMlktSH5LY3plY4CNG4JSsPzu0lSW5dG974to9
         ZxuUPTsol8tzsqi7TAiDiHRdBhqlz6rlIJW3+jrGIj1FE+rkBFc8ICqpuhBvnCfYpFnQ
         hiFHdgfJ3YmHqPngB8IaJmEWZVjmmwb8H0XFDZczk27QHMxz3aJ/o8P/Q4yOtFdvSMoM
         sbeA==
X-Gm-Message-State: AOAM530WEdNwrWp7Mdb5wyCkou0N4FNYcr8PLTmo22n0loojpsG2tdRf
        dL5Wx2BH/BjYtj4NvH+C5+qIryx60X1uLckfFfBR48U+zqf0tuLHX8tlq9GdOND6YDJUOov1hmG
        jV2Mos657zMsJuTL2zw==
X-Received: by 2002:a50:d710:: with SMTP id t16mr25009130edi.50.1637329521878;
        Fri, 19 Nov 2021 05:45:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw8gZfr+spV4e3ZkJ/q+mkZ/bFxkpaKEP5OWUh8t5OtOShn+yAu09NiLfFkRFy958phOs/M2A==
X-Received: by 2002:a50:d710:: with SMTP id t16mr25009095edi.50.1637329521738;
        Fri, 19 Nov 2021 05:45:21 -0800 (PST)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id jg32sm1369158ejc.43.2021.11.19.05.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 05:45:20 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Subject: [PATCH] selinux: fix NULL-pointer dereference when hashtab allocation fails
Date:   Fri, 19 Nov 2021 14:45:20 +0100
Message-Id: <20211119134520.943504-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When the hash table slot array allocation fails in hashtab_init(),
h->size is left initialized with a non-zero value, but the h->htable
pointer is NULL. This may then cause a NULL pointer dereference, since
the policydb code relies on the assumption that even after a failed
hashtab_init(), hashtab_map() and hashtab_destroy() can be safely called
on it. Yet, these detect an empty hashtab only by looking at the size.

Fix this by making sure that hashtab_init() always leaves behind a valid
empty hashtab when the allocation fails.

Fixes: 03414a49ad5f ("selinux: do not allocate hashtabs dynamically")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/hashtab.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index 727c3b484bd3..0ae4e4e57a40 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -31,13 +31,20 @@ static u32 hashtab_compute_size(u32 nel)
 
 int hashtab_init(struct hashtab *h, u32 nel_hint)
 {
-	h->size = hashtab_compute_size(nel_hint);
+	u32 size = hashtab_compute_size(nel_hint);
+
+	/* should already be zeroed, but better be safe */
 	h->nel = 0;
-	if (!h->size)
-		return 0;
+	h->size = 0;
+	h->htable = NULL;
 
-	h->htable = kcalloc(h->size, sizeof(*h->htable), GFP_KERNEL);
-	return h->htable ? 0 : -ENOMEM;
+	if (size) {
+		h->htable = kcalloc(size, sizeof(*h->htable), GFP_KERNEL);
+		if (!h->htable)
+			return -ENOMEM;
+		h->size = size;
+	}
+	return 0;
 }
 
 int __hashtab_insert(struct hashtab *h, struct hashtab_node **dst,
-- 
2.33.1

