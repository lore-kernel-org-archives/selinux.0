Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8932DC4332F
	for <selinux@archiver.kernel.org>; Fri,  3 Nov 2023 17:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345884AbjKCRaf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Nov 2023 13:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377746AbjKCRab (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Nov 2023 13:30:31 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1AA19D
        for <selinux@vger.kernel.org>; Fri,  3 Nov 2023 10:30:27 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-777719639adso137383485a.3
        for <selinux@vger.kernel.org>; Fri, 03 Nov 2023 10:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699032626; x=1699637426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+Tf7YOVEaioUlZTtEbyy/ibpAZAp8IZ6GoymbM+hIk=;
        b=hsZWnW2vsR0OfKBQNuq5+5HEEtMGT4OCgquGQIcVjAP1w2CtOv5/d9yHV51uWoX+QM
         ht5QR4BPvBU6erq+kwaPRnQpg1QAZYkMgKxaVNT8CeKW4MagL+kMLlCr1VeliNam6JJS
         lGP1mm4EG9cXKvwnO62QmJvf4gAvX6t4ONmloRV9YmPWbFJ3EbAqFrhVH0CkRwKqZ5Xd
         yFIWXPlrS2MjJdEKhs/N7GaT/b0FozwFTDcU+18JUbPieiBodagmLNtz6ibaiOgSU0ea
         ca8PUG/eH0V6+o/yQHopjGSZRl9JqkeOp3ehc9XHUz8kPuRQ+QSkeC5EJWEXrkvq90B+
         8WSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699032626; x=1699637426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+Tf7YOVEaioUlZTtEbyy/ibpAZAp8IZ6GoymbM+hIk=;
        b=sZY4n7LMU4AMD2uCXC5GkTgLv4Q/732n90aPmclN/LSowHxDzaP5SB1z3MiXCQB0L3
         +p7xLU+DAawPWSjNopT9lvXUwO3KZlnAeKIlTenNpaH2gC+fZqogWxYUazc+Cch+//pv
         DTA0SvIwtk5ONTrEcDdp36fNWvGoUpPJukxtFT3Rek1bj7ahft1uYnp0C6pK5cIihp4E
         /VxY5DaJXNoK3UY/tWOycqCItYyk8hA9GCeYzf0mkAGCnIb+qOiu4oJiZpIb9D/p9Xtz
         bfw/KTG5c43CcYl1/R72DmxQn+Z32Fiq2Nu0jCzZ4eTGm+bLoObdZJEVtB1nDWdrhkTg
         Zy6w==
X-Gm-Message-State: AOJu0YwxpM2kENVgFMIptw++mxvZKZkW/bQfL3GQmfBcxZeGiN/J5Juu
        AA3HEocNId0N5OUArtEgfZqo5/qlONc=
X-Google-Smtp-Source: AGHT+IFZIVQELdHDl2mG8AADfy3fXSgjq1IOnb11T/1VPOUlpmThIIOgDzB56DxuMrgzQeVCWNjeyg==
X-Received: by 2002:a05:620a:6009:b0:76f:1f8c:cc1b with SMTP id dw9-20020a05620a600900b0076f1f8ccc1bmr21137790qkb.78.1699032626020;
        Fri, 03 Nov 2023 10:30:26 -0700 (PDT)
Received: from ip-10-113-85-151.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id m18-20020a05620a291200b007789a3499casm901426qkp.115.2023.11.03.10.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 10:30:25 -0700 (PDT)
From:   Jacob Satterfield <jsatterfield.linux@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Jacob Satterfield <jsatterfield.linux@gmail.com>,
        stephen.smalley.work@gmail.com, paul@paul-moore.com,
        omosnace@redhat.com
Subject: [PATCH v5 1/3] selinux: refactor avtab_node comparisons
Date:   Fri,  3 Nov 2023 17:29:51 +0000
Message-Id: <20231103172953.24667-2-jsatterfield.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103172953.24667-1-jsatterfield.linux@gmail.com>
References: <20231103172953.24667-1-jsatterfield.linux@gmail.com>
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
2.34.1

