Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AEBEB64DC
	for <selinux@archiver.kernel.org>; Tue, 18 Jul 2023 18:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjGRSGm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jul 2023 14:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjGRSGf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jul 2023 14:06:35 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6F6A1
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 11:06:34 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-992f6d7c7fbso844019866b.3
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 11:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1689703592; x=1692295592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QObGTUzyeuaqk3opL63afTdaTzFQl4HyqZVgXpF9Chw=;
        b=b5WQstkkaDhq9JLS7rAcKwtabRmRa18MMHvp/tGFvS/oa9F09twLUkDela+1gh2MaM
         WCu6IOvj3fV3qz5FhJYVahzqRx4Ko6tpiyv44/F2/VGCJr3lq45DgoWt4n5arQnFbbJF
         sA5GhZZfwZtowqjADxp3RN16U1rDUVx2amikOnlMVwfZIWT+G1XQRLhbtWWrFX45eFsC
         fa9GAE9UXjD/Dj92LKi5xRtClwx8ir0UJ3JhLKO4DwZ7slWavZJYNzxs9fe5f1LQ91eR
         7YO+qgJvtzfdLOfY1h4VqcXgdmE8OnNUp1IMztvan7Kh/AvhKL6aulLyTGbCMFmU/t+Y
         e7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689703592; x=1692295592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QObGTUzyeuaqk3opL63afTdaTzFQl4HyqZVgXpF9Chw=;
        b=GkP31VVpXrvIlgVqrBsRvxpuMBga9HwuDawMfkz1+g6aS8qHLT1/eqp2ZcjRDKpWNO
         /z2+ozYqQDjo8o+rmf6QdxynKO2UsFauvEu5i6Abn9qrjSYdfXB+tQ0vRWB0fWAEAKFb
         Wv71nuwwGYrWwwa4JAdnm50REwbMaTq5KYAQTcHMO8gp6dNxJvxiVqFHr/xX8UguDjI8
         kR71d7CaURMJdASkm34Z3xUIGYuamE+7JiX3ZjoIV0Xd722HWUfLyow/ot90JLY0WzeN
         p6C7KUPeDu+V4/wBgCjIIwO0Y2h9y5MoY6/6Nhdh5D5OZp1RrNytcqqZmkQOo6P89hQL
         d42Q==
X-Gm-Message-State: ABy/qLadDI89XB+XyzgwyOtvZNtL1P5z9Vj+WmSLnnoQBX8NWz5cqUhb
        aMvSlpYBvUkRqDmsgrsCFVy0NLgjBVZbCw==
X-Google-Smtp-Source: APBJJlFEDh3z4XR7EIUI4WIqXQ/CS7YufpmU/dLW2N/0FsRw2iFIDIu7keYbLIIwZoHJQJguCF6sjA==
X-Received: by 2002:a17:907:2d88:b0:973:ca9c:3e43 with SMTP id gt8-20020a1709072d8800b00973ca9c3e43mr394490ejc.45.1689703592448;
        Tue, 18 Jul 2023 11:06:32 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-119-136-221.95.119.pool.telefonica.de. [95.119.136.221])
        by smtp.gmail.com with ESMTPSA id a22-20020a170906191600b009934b1eb577sm1303236eje.77.2023.07.18.11.06.32
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 11:06:32 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] selinux: drop avtab_search()
Date:   Tue, 18 Jul 2023 20:06:27 +0200
Message-Id: <20230718180627.91873-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

avtab_search() shares the same logic with avtab_search_node(), except
that it returns, if found, a pointer to the struct avtab_node member
datum instead of the node itself.  Since the member is an embedded
struct, and not a pointer, the returned value of avtab_search() and
avtab_search_node() will always in unison either be NULL or non-NULL.

Drop avtab_search() and replace its calls by avtab_search_node() to
deduplicate logic and adopt the only caller caring for the type of
the returned value accordingly.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/avtab.c       | 32 -------------------------------
 security/selinux/ss/avtab.h       |  1 -
 security/selinux/ss/conditional.c |  4 ++--
 security/selinux/ss/services.c    | 13 ++++++-------
 4 files changed, 8 insertions(+), 42 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 6766edc0fe68..33a54fbd989b 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -180,38 +180,6 @@ struct avtab_node *avtab_insert_nonunique(struct avtab *h,
 	return avtab_insert_node(h, hvalue, prev, key, datum);
 }
 
-struct avtab_datum *avtab_search(struct avtab *h, const struct avtab_key *key)
-{
-	int hvalue;
-	struct avtab_node *cur;
-	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
-
-	if (!h || !h->nslot)
-		return NULL;
-
-	hvalue = avtab_hash(key, h->mask);
-	for (cur = h->htable[hvalue]; cur;
-	     cur = cur->next) {
-		if (key->source_type == cur->key.source_type &&
-		    key->target_type == cur->key.target_type &&
-		    key->target_class == cur->key.target_class &&
-		    (specified & cur->key.specified))
-			return &cur->datum;
-
-		if (key->source_type < cur->key.source_type)
-			break;
-		if (key->source_type == cur->key.source_type &&
-		    key->target_type < cur->key.target_type)
-			break;
-		if (key->source_type == cur->key.source_type &&
-		    key->target_type == cur->key.target_type &&
-		    key->target_class < cur->key.target_class)
-			break;
-	}
-
-	return NULL;
-}
-
 /* This search function returns a node pointer, and can be used in
  * conjunction with avtab_search_next_node()
  */
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index d6742fd9c560..5355dcdf1b09 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -90,7 +90,6 @@ struct avtab {
 void avtab_init(struct avtab *h);
 int avtab_alloc(struct avtab *, u32);
 int avtab_alloc_dup(struct avtab *new, const struct avtab *orig);
-struct avtab_datum *avtab_search(struct avtab *h, const struct avtab_key *k);
 void avtab_destroy(struct avtab *h);
 void avtab_hash_eval(struct avtab *h, const char *tag);
 
diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index b156c181c3c1..81ff676f209a 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -272,7 +272,7 @@ static int cond_insertf(struct avtab *a, const struct avtab_key *k,
 	 * cond_te_avtab.
 	 */
 	if (k->specified & AVTAB_TYPE) {
-		if (avtab_search(&p->te_avtab, k)) {
+		if (avtab_search_node(&p->te_avtab, k)) {
 			pr_err("SELinux: type rule already exists outside of a conditional.\n");
 			return -EINVAL;
 		}
@@ -304,7 +304,7 @@ static int cond_insertf(struct avtab *a, const struct avtab_key *k,
 				}
 			}
 		} else {
-			if (avtab_search(&p->te_cond_avtab, k)) {
+			if (avtab_search_node(&p->te_cond_avtab, k)) {
 				pr_err("SELinux: conflicting type rules when adding type rule for true.\n");
 				return -EINVAL;
 			}
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 78946b71c1c1..d63a0fa8a7f1 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1706,8 +1706,7 @@ static int security_compute_sid(u32 ssid,
 	struct context *scontext, *tcontext, newcontext;
 	struct sidtab_entry *sentry, *tentry;
 	struct avtab_key avkey;
-	struct avtab_datum *avdatum;
-	struct avtab_node *node;
+	struct avtab_node *avnode, *node;
 	u16 tclass;
 	int rc = 0;
 	bool sock;
@@ -1815,22 +1814,22 @@ static int security_compute_sid(u32 ssid,
 	avkey.target_type = tcontext->type;
 	avkey.target_class = tclass;
 	avkey.specified = specified;
-	avdatum = avtab_search(&policydb->te_avtab, &avkey);
+	avnode = avtab_search_node(&policydb->te_avtab, &avkey);
 
 	/* If no permanent rule, also check for enabled conditional rules */
-	if (!avdatum) {
+	if (!avnode) {
 		node = avtab_search_node(&policydb->te_cond_avtab, &avkey);
 		for (; node; node = avtab_search_node_next(node, specified)) {
 			if (node->key.specified & AVTAB_ENABLED) {
-				avdatum = &node->datum;
+				avnode = node;
 				break;
 			}
 		}
 	}
 
-	if (avdatum) {
+	if (avnode) {
 		/* Use the type from the type transition/member/change rule. */
-		newcontext.type = avdatum->u.data;
+		newcontext.type = avnode->datum.u.data;
 	}
 
 	/* if we have a objname this is a file trans check so check those rules */
-- 
2.40.1

