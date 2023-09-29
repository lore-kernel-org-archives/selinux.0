Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4224FE728DE
	for <selinux@archiver.kernel.org>; Fri, 29 Sep 2023 19:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjI2T4p (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Sep 2023 15:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbjI2T4o (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Sep 2023 15:56:44 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489DB1BD
        for <selinux@vger.kernel.org>; Fri, 29 Sep 2023 12:56:42 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-65b08bbd8b1so62627276d6.2
        for <selinux@vger.kernel.org>; Fri, 29 Sep 2023 12:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696017401; x=1696622201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/MRuryTfTYas9thOxLxXlU5pgemWnUJNDOe7pAn7Yw=;
        b=A4UHtu5+vmzDEW0e1kawVmWOZUaAPX28ZFJoRi8ApvFIZ5qcz6Cf/eu21qt4pqyVIO
         67SYO+3ucRprLeKwnK7BwyhZFRoPugc02sSYkM5MdN9Tg042ONGRIc7G4TgfaJEU8WnI
         9RDwGhR+ZTc4dwLEi0qlrSGyf4r6zxTtlWY9hdtXAmrKuO0adntm/wy+XYgIk0uW1GHs
         2iKXs+lbdMJ/zbqH69uOMl4jNAVj5PUeAmnBkxRKM0Dr8BOQxL9VnFEgNqfgmzUprnRI
         1lOEoYxiDuBcqVFJvXqerI6ClRhYraZIAmlOa2vF2DchP+33rVv5MaPdvJ9Nt5oW1E1F
         v/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696017401; x=1696622201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/MRuryTfTYas9thOxLxXlU5pgemWnUJNDOe7pAn7Yw=;
        b=MTxwq1iF1zsd5cUJbnLSuFv5yNBKCpBQnb6WlNqHE2u9kB95UGemP9u0pfNjsF4+dh
         oBqvch8amLT7Xv4IUVR/vHHiux1x3iHO8l9OIS1so44vEwznYVvu2WJrrGMQGGf6IS9i
         NNOB150wlaBR1ni2Bf4CH7+vVl0hR0/WY2zrUWNvAxJ4DQdTcWH/hI5N/fRVm6CU3FvP
         0481h5pRCNJTUMXG2kIAjfagcvQaFitKprCabjp5HLpkIKbGlUhBTA+PmShdJdgC+8xS
         lTn60vJ036qDuIfdqs7eQjyzxWpE3UmQPzK1uFO4qABHnyN8jGE7BN3ucDtkZWskLcCU
         aEog==
X-Gm-Message-State: AOJu0Yx0lIy5apOJeA9ZGMqIg/1uBMbM/d19gXRsGQdA0Q3JNgFwxE7V
        15mn4rkzFzY6HcX+4ndHmJKhiunZ5Ew=
X-Google-Smtp-Source: AGHT+IHXF5U5crAgQ8U/mT4ncUuW8gapXBg9P0de+5PKhTr5CE9OzLAV4OC4pgZgAvEbgrCb/1eX4w==
X-Received: by 2002:a0c:f1c1:0:b0:658:9168:e6b6 with SMTP id u1-20020a0cf1c1000000b006589168e6b6mr5051388qvl.52.1696017400987;
        Fri, 29 Sep 2023 12:56:40 -0700 (PDT)
Received: from 5bc235456ce7.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id t6-20020a05620a034600b00767e98535b7sm5795291qkm.67.2023.09.29.12.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:56:40 -0700 (PDT)
From:   Jacob Satterfield <jsatterfield.linux@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Jacob Satterfield <jsatterfield.linux@gmail.com>,
        stephen.smalley.work@gmail.com, paul@paul-moore.com,
        omosnace@redhat.com
Subject: [PATCH 2/4] selinux: refactor avtab_node comparisons
Date:   Fri, 29 Sep 2023 19:56:13 +0000
Message-ID: <20230929195617.65120-3-jsatterfield.linux@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230929195617.65120-1-jsatterfield.linux@gmail.com>
References: <20230929195617.65120-1-jsatterfield.linux@gmail.com>
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
---
 security/selinux/ss/avtab.c | 101 +++++++++++++++---------------------
 1 file changed, 41 insertions(+), 60 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 8751a602ead2..1cd4fed30bf7 100644
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
+		key1->target_type == key2->target_type &&
+		key1->target_class == key2->target_class &&
+		(specified & key2->specified))
+		return 0;
+	if (key1->source_type < key2->source_type)
+		return -1;
+	if (key1->source_type == key2->source_type &&
+		key1->target_type < key2->target_type)
+		return -1;
+	if (key1->source_type == key2->source_type &&
+		key1->target_type == key2->target_type &&
+		key1->target_class < key2->target_class)
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
+		if (unlikely(cmp == 0 && !(key->specified & AVTAB_XPERMS)))
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

