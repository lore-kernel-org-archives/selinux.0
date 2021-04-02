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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2401CC433ED
	for <selinux@archiver.kernel.org>; Fri,  2 Apr 2021 08:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E192761105
	for <selinux@archiver.kernel.org>; Fri,  2 Apr 2021 08:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhDBI4b (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Apr 2021 04:56:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59866 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229742AbhDBI42 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Apr 2021 04:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617353787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gRE5GcGcin1rGCTya2tDyS72EKxIVRDPfIUXPACOCGU=;
        b=NEj5Kzzh3Zr2zSPzmdjeCGvqTPTBgm8jvJOtgsxCNnTGyE618NImUGN5kezaKMsnqsVpO0
        yPFefAoyfq6dR9EvWQ28ZYfxwR1Ahpf42r0PKfFu9OX5NKXQ5W5KIosVxkBVeFZlBbpTFV
        CPMPaIvXxkafBlI1CQj7pQIxHMtIHYQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-O5tANISkOTG6XV5qcQ1IKA-1; Fri, 02 Apr 2021 04:56:25 -0400
X-MC-Unique: O5tANISkOTG6XV5qcQ1IKA-1
Received: by mail-ed1-f70.google.com with SMTP id q12so4304756edv.9
        for <selinux@vger.kernel.org>; Fri, 02 Apr 2021 01:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gRE5GcGcin1rGCTya2tDyS72EKxIVRDPfIUXPACOCGU=;
        b=VnBz2NtrQ2qMTtaJLZwddno6nye1J4WlgswYhVOSSp6gTVfJqQ6Ci837h7i8T/sRQE
         OCBRxXVHnsZzEWwkqG2F4r9VObFPXI013vcKZHqYmXWIxlwcDvHcLMqE7O1M2xCvUWPM
         Swvx1aWzRPN9q10X1wLsKc263O2z1nJMedOIsAW7J6H5Z84vdAMAg/uKRpUJnlXvvp1z
         UEz3tr8oHrOum6TFphq/EYY4OmZsBiAJn6t4tGGRa6AquSX9IM8EtBsvTV1Wa5VEiWc0
         XZCCSgDdZYUxer6ZzI6ip5lm0k3UfpDxtATk358d9qwyH0vVHXMSdYcfsSJtAyGp8KeJ
         Vijw==
X-Gm-Message-State: AOAM530IL+LbGiG+vAmuQQjGFzBH9C45+NrgkmHOX2uPpmmzg9D/LJLc
        154S6V74MclbwWzi1Zp7g4k4oTsigUsVzDQjdw1zPsCCMsbsZ5Y4OlJlrsbO58vn0xncqzmE3NK
        VcAT45E1bk5STtGSDtA9wiqnGLs0EFL3eB+gRMVd93wNXawQ0nNbYW7ECrN/h9ZOruFtcQQ==
X-Received: by 2002:a17:906:170f:: with SMTP id c15mr12883562eje.358.1617353784167;
        Fri, 02 Apr 2021 01:56:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPfpOIfR/UA/rl15S6eS+RFwSxWLL1pqNRudvqtCVap5xf6bTwfgZdPD5Rjy8Z4Gwem1947Q==
X-Received: by 2002:a17:906:170f:: with SMTP id c15mr12883547eje.358.1617353783995;
        Fri, 02 Apr 2021 01:56:23 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id u13sm4019726ejn.59.2021.04.02.01.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 01:56:23 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 1/2] selinux: make nslot handling in avtab more robust
Date:   Fri,  2 Apr 2021 10:56:18 +0200
Message-Id: <20210402085619.1763971-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210402085619.1763971-1-omosnace@redhat.com>
References: <20210402085619.1763971-1-omosnace@redhat.com>
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

