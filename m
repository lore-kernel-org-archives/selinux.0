Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDFFCDB482
	for <selinux@archiver.kernel.org>; Wed, 18 Oct 2023 17:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbjJRR7c (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Oct 2023 13:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbjJRR7N (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Oct 2023 13:59:13 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7546312C
        for <selinux@vger.kernel.org>; Wed, 18 Oct 2023 10:58:46 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-66d13ac2796so42349886d6.2
        for <selinux@vger.kernel.org>; Wed, 18 Oct 2023 10:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697651925; x=1698256725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8aepVRLppsETLeY14poy0HJ426mGKOWWrQ/QdTsmr4=;
        b=cEGaQmbFxNZWCuMHYtQGCO0OfU/QlLgjuCu2c4ihs6G/9d1H8hFs6OxsOZTUGp+kdw
         kDRj2/BnbW8aCDUM8ThR20v1+vDgs8mhaeGBOk308byOjN98PhfmJ4dmQQkzkGlS3kir
         mfIDuw+bwOUsWfoFFp03rSO4gvPUcOmVMDJ0rl78bmgJ6SY6c8xuW3Pk24kG2SXmMXwN
         rl3GWN0CwwLvofbTdkCAchF1iW2n6vPHGoq6ZvuzEXSMpRcJwdzADqtckHPKVJN3Z2ie
         qF/uuMrCHvQp5fbYyT3OvN4zRpYfEPvzfaJ2iX18/xUe2UxguQng3wHCIq161eT0lyEi
         KaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697651925; x=1698256725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8aepVRLppsETLeY14poy0HJ426mGKOWWrQ/QdTsmr4=;
        b=d6edBOgal0FxyYgwBBhZkdBt5Y9Z90BJsS1sgJIv7rhRSi4Fma0w9fGOm7CJiv3M+z
         Tv6Go9BHmW1zL0PfuUcA+Wa6NoIwSX1tOiaT4sPIsQYVVu6a1QfyR7vnIlWawJZ//sfs
         WzkVajQyDzBNFG2RoCeBpezcRQOnPLW+oFEitmjvZGyyDH2Ks2CEB6hcZ7Z9f2/+0DA2
         0Q/kwv+z851XD/dsl9OBJ7d6OO7N8knUgUQ39a7tgPsQG8LXknlYfK+kJc/fHW48sZGW
         icM+FwgrCwCrMnLhuBJ2DlWChoDOXnGjRi68/Ivb+W3PUBMl1feuHJa93+wM2NpqkbRx
         1fOg==
X-Gm-Message-State: AOJu0YzdA23cGI+OlaWUAScUJzUIzJBNYjjIzfOV/eyrciPwohxx9wIA
        zW8qQTqs9Txk0RM5KYOpYOYKdZI3UWQ=
X-Google-Smtp-Source: AGHT+IG1/7xtitifRxZfICIxCTDGkj67GQAmj/TbzM5ySm72dC8q1IRy5H6T7iC2zEUnD6aeK98TIQ==
X-Received: by 2002:ad4:5be5:0:b0:66d:15c3:62ca with SMTP id k5-20020ad45be5000000b0066d15c362camr7199739qvc.24.1697651925019;
        Wed, 18 Oct 2023 10:58:45 -0700 (PDT)
Received: from 5bc235456ce7.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id k15-20020a0cfa4f000000b00655d711180dsm133289qvo.17.2023.10.18.10.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 10:58:44 -0700 (PDT)
From:   Jacob Satterfield <jsatterfield.linux@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Jacob Satterfield <jsatterfield.linux@gmail.com>,
        stephen.smalley.work@gmail.com, paul@paul-moore.com,
        omosnace@redhat.com
Subject: [PATCH v3 2/3] selinux: avtab iteration macros
Date:   Wed, 18 Oct 2023 17:57:35 +0000
Message-ID: <20231018175744.39667-3-jsatterfield.linux@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018175744.39667-1-jsatterfield.linux@gmail.com>
References: <20231018175744.39667-1-jsatterfield.linux@gmail.com>
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
 security/selinux/ss/avtab.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 697eb4352439..f0d448e7807a 100644
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
 		if (cmp == 0 && !(key->specified & AVTAB_XPERMS))
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
@@ -229,7 +229,6 @@ void avtab_destroy(struct avtab *h)
 		return;
 
 	for (i = 0; i < h->nslot; i++) {
-		cur = h->htable[i];
 		while (cur) {
 			temp = cur;
 			cur = cur->next;
@@ -307,10 +306,8 @@ void avtab_hash_eval(struct avtab *h, const char *tag)
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
@@ -593,8 +590,7 @@ int avtab_write(struct policydb *p, struct avtab *a, void *fp)
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

