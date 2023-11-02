Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56A9C4167B
	for <selinux@archiver.kernel.org>; Thu,  2 Nov 2023 15:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376817AbjKBPp4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Nov 2023 11:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376904AbjKBPpw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Nov 2023 11:45:52 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B991F194
        for <selinux@vger.kernel.org>; Thu,  2 Nov 2023 08:45:49 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7788f513872so61033885a.1
        for <selinux@vger.kernel.org>; Thu, 02 Nov 2023 08:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698939948; x=1699544748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+Tf7YOVEaioUlZTtEbyy/ibpAZAp8IZ6GoymbM+hIk=;
        b=H0UlDpp1+yCP9kJgpb/SNq9mKqYds9P2709Umi/JJP6+0wnCcbTB2oLrVnmCRD9XdY
         dO14Zc5FgXOMI8Fb3HuS5D68J2WxMF9tmuLAlhnWz8yPROfoDdDoOT3FqmYiIOAGy6rJ
         QivEJOSPoWm611P44JTe3EL+tT5BPZyIyN8I+q+hle2XSy2cPYKiZMgg03pw7HwJafku
         PkfOy3W57aVMILEwVG+QLzcZNgFYBmgl++ZHeG84pmc/XUo+Nrje9irI9XyY/t+lzNKg
         a5yFXc/zENfa7ZLhVA2b/ReUlQz5W6HydDU/3e2jMHOIIqyyNIDQXvJlfTnOfcGIRj8H
         AqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698939948; x=1699544748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+Tf7YOVEaioUlZTtEbyy/ibpAZAp8IZ6GoymbM+hIk=;
        b=PIfASuzA4sj3ou07F4v38XRV1f4VdQKGPjoWgnLHy9DQcJv6S3APz/4YDPIpKB1KX6
         n4ATGC6d4sszWsdYKlW9KE6OZhF+Ltr69OVGoVPeq7NtEyKK75Yb705FtFsCohXSnxEV
         V0xNiGFJ19U7kg9RROa3fZb89aFDpfIp+RSKJvpS7kWboa0HzKI6+hYpoJX/KxpFfWnv
         AYePLVTlQ/F3VEoZR7eNO2j4EwOQ7oujYsHq0CXTgMm6HOosxa+VUV72wmutuhJkIhDR
         jRpn4nUW45kEVRA4ydERknbstRYVsQMI1r8xE0EfsA7ASFBek4K0yUcL++qH4Gt7qA9f
         X1kg==
X-Gm-Message-State: AOJu0YyFBknoQegUhhkYTW9RXKqovZ8KIH6fDSogiVFm4MCQTaJc19r/
        ++3H7RHWSysvXePUSJC1HSSmaY0ICCA=
X-Google-Smtp-Source: AGHT+IGcgWQD1ZQjZLnJ7WpktGLYXb75msW66mWDD/uf4ZUxe49IUjNa9A67SOT12UEA8CKjlZogsg==
X-Received: by 2002:a05:620a:44c1:b0:778:920a:7a70 with SMTP id y1-20020a05620a44c100b00778920a7a70mr20193548qkp.66.1698939948014;
        Thu, 02 Nov 2023 08:45:48 -0700 (PDT)
Received: from ip-10-113-85-151.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id l1-20020a05620a210100b0076e1e2d6496sm37691qkl.104.2023.11.02.08.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 08:45:47 -0700 (PDT)
From:   Jacob Satterfield <jsatterfield.linux@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Jacob Satterfield <jsatterfield.linux@gmail.com>,
        stephen.smalley.work@gmail.com, paul@paul-moore.com,
        omosnace@redhat.com
Subject: [PATCH v4 1/3] selinux: refactor avtab_node comparisons
Date:   Thu,  2 Nov 2023 15:45:22 +0000
Message-Id: <20231102154524.12006-2-jsatterfield.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102154524.12006-1-jsatterfield.linux@gmail.com>
References: <20231102154524.12006-1-jsatterfield.linux@gmail.com>
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

