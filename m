Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD38E728E2
	for <selinux@archiver.kernel.org>; Fri, 29 Sep 2023 19:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjI2T4q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Sep 2023 15:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbjI2T4p (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Sep 2023 15:56:45 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45068B4
        for <selinux@vger.kernel.org>; Fri, 29 Sep 2023 12:56:43 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-774141bb415so822769485a.3
        for <selinux@vger.kernel.org>; Fri, 29 Sep 2023 12:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696017402; x=1696622202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODNXzeNNHF/CByGHAciz5iR0U8C1f17a+mgg9DaKACY=;
        b=QZ3SksYndFEKKhhEbQOfa/mCbCCAqgV95M3h7RGvBbd8D5DMSE3j62H3pUUpJwpRI6
         a1QIyinV3nv5LPpANNXxDLlfBnYB8rubwg0wf3LkMaEYzcZ2uwfoEwVbMbdSTPJvkW91
         29/X+6Dzb59JeYE0x529Wwd48AfaG+olDcrR+z3jBK0ZC5ctUTd3OPlzTAIPiHPZy2JM
         tX562/XAtxTtIgycK5D1zQaF+1BPO6P5E6tvR2mOcy28WDmyuSKZUj0utcRYPuMnMZAN
         Rqam1ABBz4tHuFSfCbm0wEAOtlJzXwtSVrFexHX5ybZKoTdn6kUo/n+fzAPMzEZZZ2qA
         rxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696017402; x=1696622202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODNXzeNNHF/CByGHAciz5iR0U8C1f17a+mgg9DaKACY=;
        b=tZoy3SAw+qCkcL9jrXe4w7MDqKXtef4ww2yPBTdC7weAO20yaGV8v/7cYDWreVkN1G
         JJlSh+3ilmVL3CFekrWe3vdLY8b7w4cHzDx5+7LsMC3zlYunEpvhYGAu0Mwk+HSQ3H01
         Fb5ZLgIIYs8TiyO5DjOKb/wlbCxd6H1oh5pD14fmFhC6qOpQqLh2VzsWG5R+l418PvHG
         DCFv9JkyzOdWgDAXK3khbdCLR/hqe4wONaKrKthb/hvnMRu47oXgJBNImfPqCYJx2MVi
         tvmfmJMpvldZzz75rXmv7cVeBTZxSQTALh+V3BYL2a0E2s4+vIfTdNFmIb8uddKcE3Rw
         Jz0w==
X-Gm-Message-State: AOJu0YyJX2fBmPYOefX91EGNJb+HYgmozObRjxVBPTIys6kYA7YzQ8HF
        ECJUHx7diOz1GhcZbHhTIYWYGlPR81E=
X-Google-Smtp-Source: AGHT+IElLdGVnUC6cpBsO1/E6lUB+yAzM+ix1AHWHVZCpbodHBPAUxjxsb3JBnjAesGM2gJmBmeT+A==
X-Received: by 2002:a05:620a:470c:b0:773:ad9b:4c81 with SMTP id bs12-20020a05620a470c00b00773ad9b4c81mr6248576qkb.23.1696017401939;
        Fri, 29 Sep 2023 12:56:41 -0700 (PDT)
Received: from 5bc235456ce7.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id t6-20020a05620a034600b00767e98535b7sm5795291qkm.67.2023.09.29.12.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:56:41 -0700 (PDT)
From:   Jacob Satterfield <jsatterfield.linux@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Jacob Satterfield <jsatterfield.linux@gmail.com>,
        stephen.smalley.work@gmail.com, paul@paul-moore.com,
        omosnace@redhat.com
Subject: [PATCH 3/4] selinux: avtab iteration macros
Date:   Fri, 29 Sep 2023 19:56:14 +0000
Message-ID: <20230929195617.65120-4-jsatterfield.linux@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230929195617.65120-1-jsatterfield.linux@gmail.com>
References: <20230929195617.65120-1-jsatterfield.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Similar to the list_for_each macros in list.h, this patch adds two
macros that iterates an avtab_node linked list (avtab_chain_for_each and
avtab_chain_for_each_prev). This has two benefits: it reduces the amount
of duplicative code for iteration and it makes changes to the underlying
hashtable data structure easier as there are fewer places to update.

Signed-off-by: Jacob Satterfield <jsatterfield.linux@gmail.com>
---
 security/selinux/ss/avtab.c | 40 ++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 1cd4fed30bf7..e8046eda7140 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -27,6 +27,13 @@
 static struct kmem_cache *avtab_node_cachep __ro_after_init;
 static struct kmem_cache *avtab_xperms_cachep __ro_after_init;
 
+#define avtab_chain_for_each(pos, tab, slot) \
+	for (pos = (tab)->htable[slot]; pos; pos = pos->next)
+
+#define avtab_chain_for_each_prev(pos, prev, tab, slot) \
+	for (prev = NULL, pos = (tab)->htable[slot]; pos; \
+	prev = pos, pos = pos->next)
+
 /* Based on MurmurHash3, written by Austin Appleby and placed in the
  * public domain.
  */
@@ -129,9 +136,7 @@ static int avtab_insert(struct avtab *h, const struct avtab_key *key,
 		return -EINVAL;
 
 	hvalue = avtab_hash(key, h->mask);
-	for (prev = NULL, cur = h->htable[hvalue];
-	     cur;
-	     prev = cur, cur = cur->next) {
+	avtab_chain_for_each_prev(cur, prev, h, hvalue) {
 		cmp = avtab_node_cmp(key, &cur->key);
 		/* extended perms may not be unique */
 		if (unlikely(cmp == 0 && !(key->specified & AVTAB_XPERMS)))
@@ -163,9 +168,7 @@ struct avtab_node *avtab_insert_nonunique(struct avtab *h,
 	if (!h || !h->nslot || h->nel == U32_MAX)
 		return NULL;
 	hvalue = avtab_hash(key, h->mask);
-	for (prev = NULL, cur = h->htable[hvalue];
-	     cur;
-	     prev = cur, cur = cur->next) {
+	avtab_chain_for_each_prev(cur, prev, h, hvalue) {
 		cmp = avtab_node_cmp(key, &cur->key);
 		if (cmp <= 0)
 			break;
@@ -180,16 +183,13 @@ struct avtab_node *avtab_insert_nonunique(struct avtab *h,
 struct avtab_node *avtab_search_node(struct avtab *h,
 				     const struct avtab_key *key)
 {
-	u32 hvalue;
 	struct avtab_node *cur;
 	int cmp;
 
 	if (!h || !h->nslot)
 		return NULL;
 
-	hvalue = avtab_hash(key, h->mask);
-	for (cur = h->htable[hvalue]; cur;
-	     cur = cur->next) {
+	avtab_chain_for_each(cur, h, avtab_hash(key, h->mask)) {
 		cmp = avtab_node_cmp(key, &cur->key);
 		if (cmp == 0)
 			return cur;
@@ -223,20 +223,17 @@ avtab_search_node_next(struct avtab_node *node, u16 specified)
 void avtab_destroy(struct avtab *h)
 {
 	u32 i;
-	struct avtab_node *cur, *temp;
+	struct avtab_node *cur;
 
 	if (!h)
 		return;
 
 	for (i = 0; i < h->nslot; i++) {
-		cur = h->htable[i];
-		while (cur) {
-			temp = cur;
-			cur = cur->next;
-			if (temp->key.specified & AVTAB_XPERMS)
+		avtab_chain_for_each(cur, h, i) {
+			if (cur->key.specified & AVTAB_XPERMS)
 				kmem_cache_free(avtab_xperms_cachep,
-						temp->datum.u.xperms);
-			kmem_cache_free(avtab_node_cachep, temp);
+						cur->datum.u.xperms);
+			kmem_cache_free(avtab_node_cachep, cur);
 		}
 	}
 	kvfree(h->htable);
@@ -307,10 +304,8 @@ void avtab_hash_eval(struct avtab *h, const char *tag)
 		if (cur) {
 			slots_used++;
 			chain_len = 0;
-			while (cur) {
+			avtab_chain_for_each(cur, h, i)
 				chain_len++;
-				cur = cur->next;
-			}
 
 			if (chain_len > max_chain_len)
 				max_chain_len = chain_len;
@@ -593,8 +588,7 @@ int avtab_write(struct policydb *p, struct avtab *a, void *fp)
 		return rc;
 
 	for (i = 0; i < a->nslot; i++) {
-		for (cur = a->htable[i]; cur;
-		     cur = cur->next) {
+		avtab_chain_for_each(cur, a, i) {
 			rc = avtab_write_item(p, cur, fp);
 			if (rc)
 				return rc;
-- 
2.41.0

