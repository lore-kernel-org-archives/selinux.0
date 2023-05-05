Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918C3C77B75
	for <selinux@archiver.kernel.org>; Fri,  5 May 2023 22:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbjEEWuC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 May 2023 18:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbjEEWth (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 May 2023 18:49:37 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E465FCF
        for <selinux@vger.kernel.org>; Fri,  5 May 2023 15:49:36 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-61b71b7803bso12820566d6.1
        for <selinux@vger.kernel.org>; Fri, 05 May 2023 15:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1683326975; x=1685918975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QSkMnoxNVH4vWJuJqw5JGkRnHdFNTQMDAlyM9wr5RQA=;
        b=aqStHC4Y3LPKACs1xbkLHKJexjktQBCe5UHe2LdRRMCrdro2bQlqQ6wi6n9PbJp13z
         A0GRi0jrsmo2XXbVVeCrsgWLKBvuqPbZKrMHQT4OUOFZlRT88pYCt3EnLDsP9g6oIB2M
         Pzq10gfLh8BpmzSXcqclx5HnMvO7xuCzbnOEunJUrn87oqlktabn4Wh3xftJSsz0ab3n
         1BZ3CJWWcV/803TFxmp7Ltmx2eVFOdk1HpnhMc5lR9eea/xEpu4RPsvluH8Rhfn3mMbr
         Jc5nvlgFlIDU5RQi9hh75w6M0MgxbKU6NanD/b/UjZoLGvKpmZu5LsnawGHIfA9TPuiv
         WosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683326975; x=1685918975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QSkMnoxNVH4vWJuJqw5JGkRnHdFNTQMDAlyM9wr5RQA=;
        b=gXYnC0amQmndj/GgrqU2VZbqiq/xwWdakOrZ2mXf1MK0qW2eXWQq7ziDwnJe2ShXf0
         VUPXyZ+zVmiXfi3ALB8Ukic2cKA2a+pRkU35zoCqEMnKKtYWXb7RDALO9A4oktpdPggV
         /IjMIko+QH8VyhiASU/ExNdMWF5kiG/Ui9mLiji6KgiMsQ2EodFifk32w4J+lW62BI+f
         jMYYuh08t/pNZmZSQmFmKVcH/IYXlHDvN/LGYAr3slpg++b4MT1XraWLY89zSuDdBkZ0
         9xDCQs15mamUOYOlBOzde0R5de5vl5L+p97Sfg66DZXqRJDGI8AOoCutZMTYQqJU9g/g
         whjw==
X-Gm-Message-State: AC+VfDwq2JQlzrAwvV7Omw0QzbHC1q4wjXPCjEju9dkH4AUuRUVpnUx4
        3S/9B2IByDyjwaunDJ+44hQn9mBi/Mdzop1pUQ==
X-Google-Smtp-Source: ACHHUZ4MSMz7dKpCi9IQelXBUfdfEv6EBtuNmDwue2OHDE+1+SEfiGcjijt1q7K431tLocDVoAY93w==
X-Received: by 2002:a05:6214:1c87:b0:61b:68e1:1211 with SMTP id ib7-20020a0562141c8700b0061b68e11211mr4562802qvb.10.1683326975051;
        Fri, 05 May 2023 15:49:35 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id z7-20020a0cf007000000b00620ea255c72sm682618qvk.35.2023.05.05.15.49.34
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 15:49:34 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] selinux: remove avc_disable() as it is no longer used
Date:   Fri,  5 May 2023 18:49:34 -0400
Message-Id: <20230505224934.645040-1-paul@paul-moore.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

With the removal of the runtime disable functionality we no longer
have any callers of the avc_disable() function, remove it.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/avc.c         | 19 -------------------
 security/selinux/include/avc.h |  3 ---
 2 files changed, 22 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index eaed5c2da02b..6bc65830e1a9 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1203,22 +1203,3 @@ u32 avc_policy_seqno(void)
 {
 	return selinux_avc.avc_cache.latest_notif;
 }
-
-void avc_disable(void)
-{
-	/*
-	 * If you are looking at this because you have realized that we are
-	 * not destroying the avc_node_cachep it might be easy to fix, but
-	 * I don't know the memory barrier semantics well enough to know.  It's
-	 * possible that some other task dereferenced security_ops when
-	 * it still pointed to selinux operations.  If that is the case it's
-	 * possible that it is about to use the avc and is about to need the
-	 * avc_node_cachep.  I know I could wrap the security.c security_ops call
-	 * in an rcu_lock, but seriously, it's not worth it.  Instead I just flush
-	 * the cache and get that memory back.
-	 */
-	if (avc_node_cachep) {
-		avc_flush();
-		/* kmem_cache_destroy(avc_node_cachep); */
-	}
-}
diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
index 9301222c8e55..9e055f74daf6 100644
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -168,9 +168,6 @@ int avc_get_hash_stats(char *page);
 unsigned int avc_get_cache_threshold(void);
 void avc_set_cache_threshold(unsigned int cache_threshold);
 
-/* Attempt to free avc node cache */
-void avc_disable(void);
-
 #ifdef CONFIG_SECURITY_SELINUX_AVC_STATS
 DECLARE_PER_CPU(struct avc_cache_stats, avc_cache_stats);
 #endif
-- 
2.40.1

