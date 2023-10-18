Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F82CDB483
	for <selinux@archiver.kernel.org>; Wed, 18 Oct 2023 17:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjJRR7b (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Oct 2023 13:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjJRR7L (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Oct 2023 13:59:11 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6E219AC
        for <selinux@vger.kernel.org>; Wed, 18 Oct 2023 10:58:43 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7788ebea620so102865485a.3
        for <selinux@vger.kernel.org>; Wed, 18 Oct 2023 10:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697651922; x=1698256722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QteVyWxaDl25wYgiD43SEQkNLNzkK7UcKwoMmAAEl5w=;
        b=WRNCWzmQ06x90Q/TpqJsfex2tEjwaBbhwYTkRC7OrW4ZoMklylsmxMrpDJTJqp4ens
         Dq7qtlttWUQCP0RHHXCEVTfu+ws7RbF57TMU3TwyZgZTDaB7wuT/9Bu7sToQw5x0xrwt
         vKjXO0MtJTg3tzZLPgr1E2rItWPrVhsRZzTrw/ezqx48NSCQHM55ZNBTbP9ob6MoUSUv
         N9LBSPEdSMjD+YsGogBNVixFcZfTDB1PfBugTUqqEf4+o6mk8EdcqC3GR6hKMRf3xAkc
         Sp+nd5NTKaNLUMGZfkIF7DjkVgymy8Wyw+NcRyRpZAyCQdaN9/aHBpKJ9mjhVyIjklcs
         4MmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697651922; x=1698256722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QteVyWxaDl25wYgiD43SEQkNLNzkK7UcKwoMmAAEl5w=;
        b=Ok2/p17/pxtWZ3JS6jOnfxBXhTKN7v9VBqFuQYLEhx+2lkhYyOyXao33bqynpiGrAu
         wUUVdsd2Bkb9ha5Q3Re949x4ZN5Mxvyewr8FCSzcSa9sA4pQM7i4LmEChcE8g3b6AV2f
         u31O4/kJCtc5MuD/fczLmqb2pHH0svGUjHw7dl6AESVDtDGoD1SmQPdms8zrE2UuLLwU
         yqd2/6p+Ij73piYXayqmWzlwfnZGZaan3Ug7BPj9vmqhG1c7zHhaJsYst7FzNPWl+2O2
         FWfwx+FQnuiy+P+WVmYF85+GPM0kCL2XSnLR5Fz913CkpEq7fRF59qz1hSQHK7DeexkZ
         /iiw==
X-Gm-Message-State: AOJu0YzxQLbc+bXCeHtQXONmMKSTY1voNtmn23y0C7s9nrYx/PaLep1v
        YnmlkGMJ08q9ozJXbokL+9SyWv+c59s=
X-Google-Smtp-Source: AGHT+IFtsfVaj1VFwgIW0mqdMxbTqr3rlVd1WhWqX2fN6No3P8bdjH9O+Rev388Nd92+Ph9S6braKQ==
X-Received: by 2002:a05:6214:2582:b0:658:71e1:5490 with SMTP id fq2-20020a056214258200b0065871e15490mr6846105qvb.21.1697651921960;
        Wed, 18 Oct 2023 10:58:41 -0700 (PDT)
Received: from 5bc235456ce7.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id k15-20020a0cfa4f000000b00655d711180dsm133289qvo.17.2023.10.18.10.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 10:58:41 -0700 (PDT)
From:   Jacob Satterfield <jsatterfield.linux@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Jacob Satterfield <jsatterfield.linux@gmail.com>,
        stephen.smalley.work@gmail.com, paul@paul-moore.com,
        omosnace@redhat.com
Subject: [PATCH v3 1/3] selinux: refactor avtab_node comparisons
Date:   Wed, 18 Oct 2023 17:57:34 +0000
Message-ID: <20231018175744.39667-2-jsatterfield.linux@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018175744.39667-1-jsatterfield.linux@gmail.com>
References: <20231018175744.39667-1-jsatterfield.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In four separate functions within avtab, the same comparison logic is
used. The only difference is how the result is handled or whether there
is a unique specifier value to be checked for or used.

Extracting this functionality into the avtab_node_cmp() function unifies
the comparison logic between searching and insertion and gets rid of
duplicative code so that the implementation is easier to maintain.

Signed-off-by: Jacob Satterfield <jsatterfield.linux@gmail.com>
Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/ss/avtab.c | 101 +++++++++++++++---------------------
 1 file changed, 41 insertions(+), 60 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 8751a602ead2..697eb4352439 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -96,12 +96,34 @@ avtab_insert_node(struct avtab *h, struct avtab_node **dst,
 	return newnode;
 }
 
+static int avtab_node_cmp(const struct avtab_key *key1,
+			  const struct avtab_key *key2)
+{
+	u16 specified = key1->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
+
+	if (key1->source_type == key2->source_type &&
+	    key1->target_type == key2->target_type &&
+	    key1->target_class == key2->target_class &&
+	    (specified & key2->specified))
+		return 0;
+	if (key1->source_type < key2->source_type)
+		return -1;
+	if (key1->source_type == key2->source_type &&
+	    key1->target_type < key2->target_type)
+		return -1;
+	if (key1->source_type == key2->source_type &&
+	    key1->target_type == key2->target_type &&
+	    key1->target_class < key2->target_class)
+		return -1;
+	return 1;
+}
+
 static int avtab_insert(struct avtab *h, const struct avtab_key *key,
 			const struct avtab_datum *datum)
 {
 	u32 hvalue;
 	struct avtab_node *prev, *cur, *newnode;
-	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
+	int cmp;
 
 	if (!h || !h->nslot || h->nel == U32_MAX)
 		return -EINVAL;
@@ -110,23 +132,11 @@ static int avtab_insert(struct avtab *h, const struct avtab_key *key,
 	for (prev = NULL, cur = h->htable[hvalue];
 	     cur;
 	     prev = cur, cur = cur->next) {
-		if (key->source_type == cur->key.source_type &&
-		    key->target_type == cur->key.target_type &&
-		    key->target_class == cur->key.target_class &&
-		    (specified & cur->key.specified)) {
-			/* extended perms may not be unique */
-			if (specified & AVTAB_XPERMS)
-				break;
+		cmp = avtab_node_cmp(key, &cur->key);
+		/* extended perms may not be unique */
+		if (cmp == 0 && !(key->specified & AVTAB_XPERMS))
 			return -EEXIST;
-		}
-		if (key->source_type < cur->key.source_type)
-			break;
-		if (key->source_type == cur->key.source_type &&
-		    key->target_type < cur->key.target_type)
-			break;
-		if (key->source_type == cur->key.source_type &&
-		    key->target_type == cur->key.target_type &&
-		    key->target_class < cur->key.target_class)
+		if (cmp <= 0)
 			break;
 	}
 
@@ -148,7 +158,7 @@ struct avtab_node *avtab_insert_nonunique(struct avtab *h,
 {
 	u32 hvalue;
 	struct avtab_node *prev, *cur;
-	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
+	int cmp;
 
 	if (!h || !h->nslot || h->nel == U32_MAX)
 		return NULL;
@@ -156,19 +166,8 @@ struct avtab_node *avtab_insert_nonunique(struct avtab *h,
 	for (prev = NULL, cur = h->htable[hvalue];
 	     cur;
 	     prev = cur, cur = cur->next) {
-		if (key->source_type == cur->key.source_type &&
-		    key->target_type == cur->key.target_type &&
-		    key->target_class == cur->key.target_class &&
-		    (specified & cur->key.specified))
-			break;
-		if (key->source_type < cur->key.source_type)
-			break;
-		if (key->source_type == cur->key.source_type &&
-		    key->target_type < cur->key.target_type)
-			break;
-		if (key->source_type == cur->key.source_type &&
-		    key->target_type == cur->key.target_type &&
-		    key->target_class < cur->key.target_class)
+		cmp = avtab_node_cmp(key, &cur->key);
+		if (cmp <= 0)
 			break;
 	}
 	return avtab_insert_node(h, prev ? &prev->next : &h->htable[hvalue],
@@ -183,7 +182,7 @@ struct avtab_node *avtab_search_node(struct avtab *h,
 {
 	u32 hvalue;
 	struct avtab_node *cur;
-	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
+	int cmp;
 
 	if (!h || !h->nslot)
 		return NULL;
@@ -191,20 +190,10 @@ struct avtab_node *avtab_search_node(struct avtab *h,
 	hvalue = avtab_hash(key, h->mask);
 	for (cur = h->htable[hvalue]; cur;
 	     cur = cur->next) {
-		if (key->source_type == cur->key.source_type &&
-		    key->target_type == cur->key.target_type &&
-		    key->target_class == cur->key.target_class &&
-		    (specified & cur->key.specified))
+		cmp = avtab_node_cmp(key, &cur->key);
+		if (cmp == 0)
 			return cur;
-
-		if (key->source_type < cur->key.source_type)
-			break;
-		if (key->source_type == cur->key.source_type &&
-		    key->target_type < cur->key.target_type)
-			break;
-		if (key->source_type == cur->key.source_type &&
-		    key->target_type == cur->key.target_type &&
-		    key->target_class < cur->key.target_class)
+		if (cmp < 0)
 			break;
 	}
 	return NULL;
@@ -213,27 +202,19 @@ struct avtab_node *avtab_search_node(struct avtab *h,
 struct avtab_node*
 avtab_search_node_next(struct avtab_node *node, u16 specified)
 {
+	struct avtab_key tmp_key;
 	struct avtab_node *cur;
+	int cmp;
 
 	if (!node)
 		return NULL;
-
-	specified &= ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
+	tmp_key = node->key;
+	tmp_key.specified = specified;
 	for (cur = node->next; cur; cur = cur->next) {
-		if (node->key.source_type == cur->key.source_type &&
-		    node->key.target_type == cur->key.target_type &&
-		    node->key.target_class == cur->key.target_class &&
-		    (specified & cur->key.specified))
+		cmp = avtab_node_cmp(&tmp_key, &cur->key);
+		if (cmp == 0)
 			return cur;
-
-		if (node->key.source_type < cur->key.source_type)
-			break;
-		if (node->key.source_type == cur->key.source_type &&
-		    node->key.target_type < cur->key.target_type)
-			break;
-		if (node->key.source_type == cur->key.source_type &&
-		    node->key.target_type == cur->key.target_type &&
-		    node->key.target_class < cur->key.target_class)
+		if (cmp < 0)
 			break;
 	}
 	return NULL;
-- 
2.41.0

