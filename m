Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC489C43460
	for <selinux@archiver.kernel.org>; Thu,  1 Apr 2021 18:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB64D60FE6
	for <selinux@archiver.kernel.org>; Thu,  1 Apr 2021 18:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237390AbhDASDm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Apr 2021 14:03:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52255 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237518AbhDASAR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Apr 2021 14:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617300016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gRE5GcGcin1rGCTya2tDyS72EKxIVRDPfIUXPACOCGU=;
        b=DeObkn5soCHiCyzvrxaouyGansU7HlzU6NZBf4dKIv5BApVDOtU8l6ni1Gitv2GPWgCYYV
        h1LgG4EtjEOCBJW41OlqYp3PfzyGKbe4U7eYruQ6wP0bkcCrcdoHUL1vBcs7bLiyIUuRR+
        lISxs0gLLVlf081PyO6G7YHyAAjXCH0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-8QAlfLM0POuCFFJpSktcNg-1; Thu, 01 Apr 2021 11:59:18 -0400
X-MC-Unique: 8QAlfLM0POuCFFJpSktcNg-1
Received: by mail-ed1-f71.google.com with SMTP id p6so3036690edq.21
        for <selinux@vger.kernel.org>; Thu, 01 Apr 2021 08:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gRE5GcGcin1rGCTya2tDyS72EKxIVRDPfIUXPACOCGU=;
        b=e6eWSH64Q9oolTFV15o7GsPjYZftfC65mjR+iXt7xYVLDp4+JCNcJyScEejcyzISjm
         LGQDKwjW84a47HwhHPlCynuzQZfg7eL1OYKQv1rWxtVI1v/+LfPQn5oRlfr0Hk/w87Fz
         XmS62iket0olAd/nKHUToPPdKjPPqFlys3uXt6MPC1/FQcFCoWbZwm5OkgwX/TlU1XDK
         QUgiVYleQzTm6GFg5A34HfEsArGEg073eH4stfJxUSiXJTAxwThtr9ti0rgiGhAXUTdF
         eX16kotqzBPgiXHcVNlKjwI1WXJGwDKoFeSOuZjJujbY5M26rl0eKqZJcaCGKxneJJRz
         X/aA==
X-Gm-Message-State: AOAM530n/lTRf4JllT7INwgY3FW5FRdQqfrrm/SNjjBBCxkkSFiNpGU8
        ImxDSF35aJ/tkX88TjIyZm4xPQlkIDTmA9mdTMOv9ykm3qMSyuZ0WgHjm8YxPRmkD3cE3gVMbbG
        jEpQBaccxSkFiCoiIXQ1Q1tt53Z0TVIVAwIwhb3h7QzjID7GE7T1WmsC4blZrNghgqihwqw==
X-Received: by 2002:aa7:d484:: with SMTP id b4mr10679752edr.63.1617292756550;
        Thu, 01 Apr 2021 08:59:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzM55CJGCVSgTsOBemDRFZul0STHaDNtENro0wQhmbmjr2ho9BjyAPbsBmZAxtJ87eVvDxxiw==
X-Received: by 2002:aa7:d484:: with SMTP id b4mr10679734edr.63.1617292756400;
        Thu, 01 Apr 2021 08:59:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id x4sm3537000edd.58.2021.04.01.08.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:59:15 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 1/2] selinux: make nslot handling in avtab more robust
Date:   Thu,  1 Apr 2021 17:59:12 +0200
Message-Id: <20210401155913.1693097-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210401155913.1693097-1-omosnace@redhat.com>
References: <20210401155913.1693097-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

1. Make sure all fileds are initialized in avtab_init().
2. Slightly refactor avtab_alloc() to use the above fact.
3. Use h->nslot == 0 as a sentinel in the access functions to prevent
   dereferencing h->htable when it's not allocated.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/avtab.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 6dcb6aa4db7f..2aee4c965c25 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -109,7 +109,7 @@ static int avtab_insert(struct avtab *h, struct avtab_key *key, struct avtab_dat
 	struct avtab_node *prev, *cur, *newnode;
 	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
-	if (!h)
+	if (!h || !h->nslot)
 		return -EINVAL;
 
 	hvalue = avtab_hash(key, h->mask);
@@ -154,7 +154,7 @@ avtab_insert_nonunique(struct avtab *h, struct avtab_key *key, struct avtab_datu
 	struct avtab_node *prev, *cur;
 	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
-	if (!h)
+	if (!h || !h->nslot)
 		return NULL;
 	hvalue = avtab_hash(key, h->mask);
 	for (prev = NULL, cur = h->htable[hvalue];
@@ -184,7 +184,7 @@ struct avtab_datum *avtab_search(struct avtab *h, struct avtab_key *key)
 	struct avtab_node *cur;
 	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
-	if (!h)
+	if (!h || !h->nslot)
 		return NULL;
 
 	hvalue = avtab_hash(key, h->mask);
@@ -220,7 +220,7 @@ avtab_search_node(struct avtab *h, struct avtab_key *key)
 	struct avtab_node *cur;
 	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
-	if (!h)
+	if (!h || !h->nslot)
 		return NULL;
 
 	hvalue = avtab_hash(key, h->mask);
@@ -295,6 +295,7 @@ void avtab_destroy(struct avtab *h)
 	}
 	kvfree(h->htable);
 	h->htable = NULL;
+	h->nel = 0;
 	h->nslot = 0;
 	h->mask = 0;
 }
@@ -303,14 +304,15 @@ void avtab_init(struct avtab *h)
 {
 	h->htable = NULL;
 	h->nel = 0;
+	h->nslot = 0;
+	h->mask = 0;
 }
 
 int avtab_alloc(struct avtab *h, u32 nrules)
 {
-	u32 mask = 0;
 	u32 shift = 0;
 	u32 work = nrules;
-	u32 nslot = 0;
+	u32 nslot;
 
 	if (nrules == 0)
 		goto avtab_alloc_out;
@@ -324,16 +326,15 @@ int avtab_alloc(struct avtab *h, u32 nrules)
 	nslot = 1 << shift;
 	if (nslot > MAX_AVTAB_HASH_BUCKETS)
 		nslot = MAX_AVTAB_HASH_BUCKETS;
-	mask = nslot - 1;
 
 	h->htable = kvcalloc(nslot, sizeof(void *), GFP_KERNEL);
 	if (!h->htable)
 		return -ENOMEM;
 
- avtab_alloc_out:
-	h->nel = 0;
 	h->nslot = nslot;
-	h->mask = mask;
+	h->mask = nslot - 1;
+
+avtab_alloc_out:
 	pr_debug("SELinux: %d avtab hash slots, %d rules.\n",
 	       h->nslot, nrules);
 	return 0;
-- 
2.30.2

