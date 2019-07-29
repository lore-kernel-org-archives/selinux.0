Return-Path: <SRS0=UHz+=V2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842DBC433FF
	for <selinux@archiver.kernel.org>; Mon, 29 Jul 2019 08:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6699620578
	for <selinux@archiver.kernel.org>; Mon, 29 Jul 2019 08:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfG2IlY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Jul 2019 04:41:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55330 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbfG2IlY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Jul 2019 04:41:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so53009894wmj.5
        for <selinux@vger.kernel.org>; Mon, 29 Jul 2019 01:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WtdpKmJ9PlytGNbTigFTWjdLjy1k5dlzQiZqpFImVLI=;
        b=tcFFhwALMOrhD6XkTqwWS2qE8EDv2mfPbdp08iGCyB9wJp1vpNs1I5DzNUjwdUXT5W
         ash0owLkLrFcg8T4cm2MP0VWbA2X/dQ+KtkdqSCJJmwaqx9903v6tk67pPnYTJy0grLx
         A0zSdOjZKWrLrDh7uFiuzO4SDTkOmiCQcGQl8qa2m+9UAe/5c5W1ZDoJMnLJNh/e7Xq3
         NRuvmttOPcbyJ3/HzepOAiKJ7DRVqP2PmBRfZBkAeNuZYafR4UIaFky7dXjLbFQ8CdUR
         XYUl3w5MnyXdp2cfcJcTWiPr6SnuSAj97fyaf/4dOFN27wymGwDy4Su7007dW7RK8W+c
         nOdg==
X-Gm-Message-State: APjAAAX5qHgY2oBIruc+zVIrYKRs1HS5h8FuIHPmip02XK/MjyLygp2v
        9nybLnygGsh3WImbge1Eri6hTM7gXUv+wQ==
X-Google-Smtp-Source: APXvYqzMX8po7f1I1+EWGxdZqy0bzQNSVspAjCigurNBNWFbq9ptZg+ChTlNUrX+4+OAZLjbnwVYuw==
X-Received: by 2002:a7b:c0d0:: with SMTP id s16mr83888709wmh.136.1564389681548;
        Mon, 29 Jul 2019 01:41:21 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id v5sm70190544wre.50.2019.07.29.01.41.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 01:41:21 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH v2 2/3] selinux: policydb - fix some checkpatch.pl warnings
Date:   Mon, 29 Jul 2019 10:41:16 +0200
Message-Id: <20190729084117.18677-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729084117.18677-1-omosnace@redhat.com>
References: <20190729084117.18677-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fix most of the code style warnings discovered when moving code around.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/policydb.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 451f2bcd2d83..ffeae0e252d2 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -334,6 +334,7 @@ static int (*destroy_f[SYM_NUM]) (void *key, void *datum, void *datap) =
 static int filenametr_destroy(void *key, void *datum, void *p)
 {
 	struct filename_trans *ft = key;
+
 	kfree(ft->name);
 	kfree(key);
 	kfree(datum);
@@ -344,6 +345,7 @@ static int filenametr_destroy(void *key, void *datum, void *p)
 static int range_tr_destroy(void *key, void *datum, void *p)
 {
 	struct mls_range *rt = datum;
+
 	kfree(key);
 	ebitmap_destroy(&rt->level[0].cat);
 	ebitmap_destroy(&rt->level[1].cat);
@@ -526,6 +528,7 @@ static int filenametr_cmp(struct hashtab *h, const void *k1, const void *k2)
 static u32 rangetr_hash(struct hashtab *h, const void *k)
 {
 	const struct range_trans *key = k;
+
 	return (key->source_type + (key->target_type << 3) +
 		(key->target_class << 5)) & (h->size - 1);
 }
@@ -575,7 +578,8 @@ static int policydb_init(struct policydb *p)
 	if (rc)
 		goto out;
 
-	p->filename_trans = hashtab_create(filenametr_hash, filenametr_cmp, (1 << 10));
+	p->filename_trans = hashtab_create(filenametr_hash, filenametr_cmp,
+					   (1 << 10));
 	if (!p->filename_trans) {
 		rc = -ENOMEM;
 		goto out;
@@ -751,9 +755,9 @@ static void hash_eval(struct hashtab *h, const char *hash_name)
 	struct hashtab_info info;
 
 	hashtab_stat(h, &info);
-	pr_debug("SELinux: %s:  %d entries and %d/%d buckets used, "
-	       "longest chain length %d\n", hash_name, h->nel,
-	       info.slots_used, h->size, info.max_chain_len);
+	pr_debug("SELinux: %s:  %d entries and %d/%d buckets used, longest chain length %d\n",
+		 hash_name, h->nel, info.slots_used, h->size,
+		 info.max_chain_len);
 }
 
 static void symtab_hash_eval(struct symtab *s)
-- 
2.21.0

