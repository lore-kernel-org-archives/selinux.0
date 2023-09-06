Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E81EE14A0
	for <selinux@archiver.kernel.org>; Wed,  6 Sep 2023 15:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238173AbjIFPrH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Sep 2023 11:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjIFPrG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Sep 2023 11:47:06 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A84F1733
        for <selinux@vger.kernel.org>; Wed,  6 Sep 2023 08:47:00 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-64aaf3c16c2so22794926d6.3
        for <selinux@vger.kernel.org>; Wed, 06 Sep 2023 08:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694015219; x=1694620019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWHZ5S5d1KhZzLzXKDUuG+rDLVVjB8cIQ4hL8NJxhjU=;
        b=j5U2VP5NAxdXVWCGiFgYk07Yg+9w7oPVI551tldm3Y3WH7MNFsukLUXQUkAQmeoYX7
         OzWp1AWesOUONrsPHEcZPkSEfezjneXMwYL/Rw/mKYhaCyRRBHM2Kck5SXBQ/7Xi0cES
         ZMDTnu3kLrebtjF5Uy2cTJzFiGjvjfhF76atbIaTAdd805ZqytNhlExj0IRRfBY1IFPb
         i8+gr+KsZhAxxiKH64f/lZa4QeOb8wXDmYd7cpTVQDP2cq9PKAIxyjiHKfi9G3iOa0qs
         6+hSrjpxZ2gg0iYa60f9eNvr+dIYVzwU0JMa8BJieyveQ4uPR+dbcyN3aApErSufUtqp
         1FCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694015219; x=1694620019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qWHZ5S5d1KhZzLzXKDUuG+rDLVVjB8cIQ4hL8NJxhjU=;
        b=Dyo1MZ0tjnZaalK/cwsagiLu4dSo4Qed0lI7LBsvKC0uZy8+mgueO0kgLRtKeMZNVr
         MLvVr8zkavJqdutCkduQO5yJGUtwnPMOOBAh6aZh3OlBzukqWxCtCjGeqpMSUjiYiu5u
         ZFReLgWbwx6wkyPRkrTB3ShAh87eUs6q/iISd0Pva/uhDad7X1IcRDkSueH9aVAzzXTw
         ZhhIhWVH+nEJiY2aAEfk0xQx5qVo+HMVDfx+Bx0ktX/aFEVQ4fcM3kpNDcMTstqW/wr+
         5EN6m4Z48jpoOOU34Kmd+7TYImEEbqa2X9JZfzLlqmCpVlSsdsUdrBbf+0LMQbrZY2aV
         IfkA==
X-Gm-Message-State: AOJu0YxlxnmhydlN3CUzqGsJ1rQNVwpVu+3fcrQsDJtW1AlDXCtsqBJE
        imR2+oHSG/WZPSvcJzNblCKovtA/Ll4=
X-Google-Smtp-Source: AGHT+IEpXiTyYn9951Id3kQNZaLsJEZup/K+A3egKuLxCeGOcWU8gz0959FdP3cX7B2Uc1aE2UJenw==
X-Received: by 2002:a0c:e442:0:b0:64f:6fa5:d7b6 with SMTP id d2-20020a0ce442000000b0064f6fa5d7b6mr15369118qvm.59.1694015219179;
        Wed, 06 Sep 2023 08:46:59 -0700 (PDT)
Received: from 5bc235456ce7.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id g25-20020a0caad9000000b0064f778c8165sm5518835qvb.64.2023.09.06.08.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 08:46:58 -0700 (PDT)
From:   Jacob Satterfield <jsatterfield.linux@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Jacob Satterfield <jsatterfield.linux@gmail.com>,
        stephen.smalley.work@gmail.com, paul@paul-moore.com,
        omosnace@redhat.com
Subject: [PATCH 2/3] selinux: shrink conditional avtab node array
Date:   Wed,  6 Sep 2023 15:46:05 +0000
Message-ID: <20230906154611.31762-3-jsatterfield.linux@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230906154611.31762-1-jsatterfield.linux@gmail.com>
References: <20230906154611.31762-1-jsatterfield.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Due to how conditional rules are written in the binary policy, the
code responsible for loading does not know how many conditional rules
there are before creating the avtab structure. Instead, it uses the
number of elements in the non-conditional avtab as a hint and allocates
the hash table based on it. Therefore, pre-allocating an array of nodes
based on this hint over-allocates at best and under-allocates at worst.

This patch includes two functions, avtab_grow_nodes and
avtab_shrink_nodes, which help manage the size of the nodes array in the
unlikely case when there are more conditional rules than non-conditional
and in the likely case when there are more non-conditional rules than
conditional rules respectively.

This patch required struct cond_av_list to become an array of indices
instead of pointers so that the nodes array can be copied and moved.
This coveniently results in a reduction of memory usage on 64-bit archs
as pointers become u32 integers.

Future improvements to the binary policy to provide the correct hint to
the loader code will make these functions obsolete. But as this would be
a breaking change to the format, it is not a part of this patch series.

Signed-off-by: Jacob Satterfield <jsatterfield.linux@gmail.com>
---
 security/selinux/ss/avtab.c       | 61 +++++++++++++++++++++++++------
 security/selinux/ss/avtab.h       |  8 ++--
 security/selinux/ss/conditional.c | 46 ++++++++++++++---------
 security/selinux/ss/conditional.h |  2 +-
 4 files changed, 84 insertions(+), 33 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 620ea0a03e41..b7a11f417f0a 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -64,7 +64,9 @@ static inline u32 avtab_hash(const struct avtab_key *keyp, u32 mask)
 	return hash & mask;
 }
 
-static struct avtab_node*
+static int avtab_grow_nodes(struct avtab *h);
+
+static u32
 avtab_insert_node(struct avtab *h, u32 hvalue,
 		  struct avtab_node *prev,
 		  const struct avtab_key *key, const struct avtab_datum *datum)
@@ -72,6 +74,8 @@ avtab_insert_node(struct avtab *h, u32 hvalue,
 	u32 newnodei;
 	struct avtab_node *newnode;
 	struct avtab_extended_perms *xperms;
+	if (unlikely(h->nel == h->nnodes) && avtab_grow_nodes(h) != 0)
+		return NULL_NODE_IDX;
 	newnodei = ++h->nel;
 	newnode = avtab_get_node(h, newnodei);
 	newnode->key = *key;
@@ -80,7 +84,7 @@ avtab_insert_node(struct avtab *h, u32 hvalue,
 		xperms = kmem_cache_zalloc(avtab_xperms_cachep, GFP_KERNEL);
 		if (xperms == NULL) {
 			--h->nel;
-			return NULL;
+			return NULL_NODE_IDX;
 		}
 		*xperms = *(datum->u.xperms);
 		newnode->datum.u.xperms = xperms;
@@ -96,14 +100,14 @@ avtab_insert_node(struct avtab *h, u32 hvalue,
 		h->htable[hvalue] = newnodei;
 	}
 
-	return newnode;
+	return newnodei;
 }
 
 static int avtab_insert(struct avtab *h, const struct avtab_key *key,
 			const struct avtab_datum *datum)
 {
-	u32 hvalue;
-	struct avtab_node *prev, *cur, *newnode;
+	u32 hvalue, newnodei;
+	struct avtab_node *prev, *cur;
 	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
 	if (!h || !h->nslot || h->nel == U32_MAX)
@@ -133,8 +137,8 @@ static int avtab_insert(struct avtab *h, const struct avtab_key *key,
 			break;
 	}
 
-	newnode = avtab_insert_node(h, hvalue, prev, key, datum);
-	if (!newnode)
+	newnodei = avtab_insert_node(h, hvalue, prev, key, datum);
+	if (newnodei == NULL_NODE_IDX)
 		return -ENOMEM;
 
 	return 0;
@@ -142,18 +146,18 @@ static int avtab_insert(struct avtab *h, const struct avtab_key *key,
 
 /* Unlike avtab_insert(), this function allow multiple insertions of the same
  * key/specified mask into the table, as needed by the conditional avtab.
- * It also returns a pointer to the node inserted.
+ * It returns the index of the node inserted.
  */
-struct avtab_node *avtab_insert_nonunique(struct avtab *h,
-					  const struct avtab_key *key,
-					  const struct avtab_datum *datum)
+u32 avtab_insert_nonunique(struct avtab *h,
+			   const struct avtab_key *key,
+			   const struct avtab_datum *datum)
 {
 	u32 hvalue;
 	struct avtab_node *prev, *cur;
 	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
 	if (!h || !h->nslot || h->nel == U32_MAX)
-		return NULL;
+		return NULL_NODE_IDX;
 	hvalue = avtab_hash(key, h->mask);
 	for (prev = NULL, cur = avtab_get_chain(h, hvalue);
 	     cur;
@@ -261,6 +265,7 @@ void avtab_destroy(struct avtab *h)
 	kvfree(h->nodes);
 	h->htable = NULL;
 	h->nodes = NULL;
+	h->nnodes = 0;
 	h->nel = 0;
 	h->nslot = 0;
 	h->mask = 0;
@@ -270,6 +275,7 @@ void avtab_init(struct avtab *h)
 {
 	h->htable = NULL;
 	h->nodes = NULL;
+	h->nnodes = 0;
 	h->nel = 0;
 	h->nslot = 0;
 	h->mask = 0;
@@ -289,6 +295,7 @@ static int avtab_alloc_common(struct avtab *h, u32 nslot, u32 nrules)
 		h->htable = NULL;
 		return -ENOMEM;
 	}
+	h->nnodes = nrules;
 	h->nslot = nslot;
 	h->mask = nslot - 1;
 	return 0;
@@ -324,6 +331,36 @@ int avtab_alloc_dup(struct avtab *new, const struct avtab *orig)
 	return avtab_alloc_common(new, orig->nslot, orig->nel);
 }
 
+static int avtab_change_nodes_size(struct avtab *h, u32 nnodes)
+{
+	struct avtab_node *new_nodes;
+
+	if (!h->nodes)
+		return -EINVAL;
+
+	new_nodes = kvcalloc(nnodes, sizeof(*h->nodes), GFP_KERNEL);
+	if (!new_nodes)
+		return -ENOMEM;
+
+	if (h->nel)
+		memcpy(new_nodes, h->nodes, sizeof(*h->nodes) * h->nel);
+
+	kvfree(h->nodes);
+	h->nodes = new_nodes;
+	h->nnodes = nnodes;
+	return 0;
+}
+
+static int avtab_grow_nodes(struct avtab *h)
+{
+	return avtab_change_nodes_size(h, h->nnodes + 1024);
+}
+
+int avtab_shrink_nodes(struct avtab *h)
+{
+	return avtab_change_nodes_size(h, h->nel);
+}
+
 #ifdef CONFIG_SECURITY_SELINUX_DEBUG
 void avtab_hash_eval(struct avtab *h, const char *tag)
 {
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index 72708aed5fff..009734c14d05 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -83,6 +83,7 @@ struct avtab_node {
 struct avtab {
 	u32 *htable;
 	struct avtab_node *nodes;
+	u32 nnodes;	/* number of nodes */
 	u32 nel;	/* number of elements */
 	u32 nslot;      /* number of hash slots */
 	u32 mask;       /* mask to compute hash func */
@@ -112,6 +113,7 @@ static inline struct avtab_node *avtab_get_node(struct avtab *h, u32 idx)
 void avtab_init(struct avtab *h);
 int avtab_alloc(struct avtab *, u32);
 int avtab_alloc_dup(struct avtab *new, const struct avtab *orig);
+int avtab_shrink_nodes(struct avtab *h);
 void avtab_destroy(struct avtab *h);
 
 #ifdef CONFIG_SECURITY_SELINUX_DEBUG
@@ -132,9 +134,9 @@ int avtab_read(struct avtab *a, void *fp, struct policydb *pol);
 int avtab_write_item(struct policydb *p, const struct avtab_node *cur, void *fp);
 int avtab_write(struct policydb *p, struct avtab *a, void *fp);
 
-struct avtab_node *avtab_insert_nonunique(struct avtab *h,
-					  const struct avtab_key *key,
-					  const struct avtab_datum *datum);
+u32 avtab_insert_nonunique(struct avtab *h,
+			   const struct avtab_key *key,
+			   const struct avtab_datum *datum);
 
 struct avtab_node *avtab_search_node(struct avtab *h,
 				     const struct avtab_key *key);
diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 448bdacb1769..b7da47d00158 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -91,10 +91,12 @@ static int cond_evaluate_expr(struct policydb *p, struct cond_expr *expr)
  */
 static void evaluate_cond_node(struct policydb *p, struct cond_node *node)
 {
+	struct avtab *cond_avtab;
 	struct avtab_node *avnode;
 	int new_state;
 	u32 i;
 
+	cond_avtab = &p->te_cond_avtab;
 	new_state = cond_evaluate_expr(p, &node->expr);
 	if (new_state != node->cur_state) {
 		node->cur_state = new_state;
@@ -102,7 +104,7 @@ static void evaluate_cond_node(struct policydb *p, struct cond_node *node)
 			pr_err("SELinux: expression result was undefined - disabling all rules.\n");
 		/* turn the rules on or off */
 		for (i = 0; i < node->true_list.len; i++) {
-			avnode = node->true_list.nodes[i];
+			avnode = avtab_get_node(cond_avtab, node->true_list.nodes[i]);
 			if (new_state <= 0)
 				avnode->key.specified &= ~AVTAB_ENABLED;
 			else
@@ -110,7 +112,7 @@ static void evaluate_cond_node(struct policydb *p, struct cond_node *node)
 		}
 
 		for (i = 0; i < node->false_list.len; i++) {
-			avnode = node->false_list.nodes[i];
+			avnode = avtab_get_node(cond_avtab, node->false_list.nodes[i]);
 			/* -1 or 1 */
 			if (new_state)
 				avnode->key.specified &= ~AVTAB_ENABLED;
@@ -140,7 +142,7 @@ void cond_policydb_init(struct policydb *p)
 static void cond_node_destroy(struct cond_node *node)
 {
 	kfree(node->expr.nodes);
-	/* the avtab_ptr_t nodes are destroyed by the avtab */
+	/* the actual nodes were destroyed by avtab_destroy() */
 	kfree(node->true_list.nodes);
 	kfree(node->false_list.nodes);
 }
@@ -252,7 +254,7 @@ int cond_read_bool(struct policydb *p, struct symtab *s, void *fp)
 
 struct cond_insertf_data {
 	struct policydb *p;
-	struct avtab_node **dst;
+	u32 *dst;
 	struct cond_av_list *other;
 };
 
@@ -263,8 +265,8 @@ static int cond_insertf(struct avtab *a, const struct avtab_key *k,
 	struct policydb *p = data->p;
 	struct cond_av_list *other = data->other;
 	struct avtab *cond_avtab = &p->te_cond_avtab;
-	struct avtab_node *node_ptr;
-	u32 i;
+	struct avtab_node *node_ptr, *other_node_ptr;
+	u32 i, node_idx;
 	bool found;
 
 	/*
@@ -294,7 +296,9 @@ static int cond_insertf(struct avtab *a, const struct avtab_key *k,
 				}
 				found = false;
 				for (i = 0; i < other->len; i++) {
-					if (other->nodes[i] == node_ptr) {
+					other_node_ptr = avtab_get_node(cond_avtab,
+									other->nodes[i]);
+					if (other_node_ptr == node_ptr) {
 						found = true;
 						break;
 					}
@@ -312,13 +316,13 @@ static int cond_insertf(struct avtab *a, const struct avtab_key *k,
 		}
 	}
 
-	node_ptr = avtab_insert_nonunique(cond_avtab, k, d);
-	if (!node_ptr) {
+	node_idx = avtab_insert_nonunique(cond_avtab, k, d);
+	if (node_idx == NULL_NODE_IDX) {
 		pr_err("SELinux: could not insert rule.\n");
 		return -ENOMEM;
 	}
 
-	*data->dst = node_ptr;
+	*data->dst = node_idx;
 	return 0;
 }
 
@@ -441,6 +445,9 @@ int cond_read_list(struct policydb *p, void *fp)
 		if (rc)
 			goto err;
 	}
+	rc = avtab_shrink_nodes(&p->te_cond_avtab);
+	if (rc)
+		goto err;
 	return 0;
 err:
 	cond_list_destroy(p);
@@ -483,6 +490,7 @@ static int cond_write_av_list(struct policydb *p,
 			      struct cond_av_list *list, struct policy_file *fp)
 {
 	__le32 buf[1];
+	struct avtab_node *node;
 	u32 i;
 	int rc;
 
@@ -492,7 +500,8 @@ static int cond_write_av_list(struct policydb *p,
 		return rc;
 
 	for (i = 0; i < list->len; i++) {
-		rc = avtab_write_item(p, list->nodes[i], fp);
+		node = avtab_get_node(&p->te_cond_avtab, list->nodes[i]);
+		rc = avtab_write_item(p, node, fp);
 		if (rc)
 			return rc;
 	}
@@ -604,8 +613,10 @@ void cond_compute_av(struct avtab *ctab, struct avtab_key *key,
 
 static int cond_dup_av_list(struct cond_av_list *new,
 			struct cond_av_list *orig,
-			struct avtab *avtab)
+			struct avtab *new_avtab,
+			struct avtab *orig_avtab)
 {
+	struct avtab_node *orig_node;
 	u32 i;
 
 	memset(new, 0, sizeof(*new));
@@ -615,9 +626,10 @@ static int cond_dup_av_list(struct cond_av_list *new,
 		return -ENOMEM;
 
 	for (i = 0; i < orig->len; i++) {
-		new->nodes[i] = avtab_insert_nonunique(avtab,
-						       &orig->nodes[i]->key,
-						       &orig->nodes[i]->datum);
+		orig_node = avtab_get_node(orig_avtab, orig->nodes[i]);
+		new->nodes[i] = avtab_insert_nonunique(new_avtab,
+						       &orig_node->key,
+						       &orig_node->datum);
 		if (!new->nodes[i])
 			return -ENOMEM;
 		new->len++;
@@ -659,12 +671,12 @@ static int duplicate_policydb_cond_list(struct policydb *newp,
 		newn->expr.len = orign->expr.len;
 
 		rc = cond_dup_av_list(&newn->true_list, &orign->true_list,
-				&newp->te_cond_avtab);
+				&newp->te_cond_avtab, &origp->te_cond_avtab);
 		if (rc)
 			goto error;
 
 		rc = cond_dup_av_list(&newn->false_list, &orign->false_list,
-				&newp->te_cond_avtab);
+				&newp->te_cond_avtab, &origp->te_cond_avtab);
 		if (rc)
 			goto error;
 	}
diff --git a/security/selinux/ss/conditional.h b/security/selinux/ss/conditional.h
index 5a7b51278dc6..0f78970493c3 100644
--- a/security/selinux/ss/conditional.h
+++ b/security/selinux/ss/conditional.h
@@ -43,7 +43,7 @@ struct cond_expr {
  * struct is for that list.
  */
 struct cond_av_list {
-	struct avtab_node **nodes;
+	u32 *nodes;
 	u32 len;
 };
 
-- 
2.41.0

