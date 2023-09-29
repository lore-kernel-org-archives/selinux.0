Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4DFE728E3
	for <selinux@archiver.kernel.org>; Fri, 29 Sep 2023 19:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbjI2T4r (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Sep 2023 15:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbjI2T4q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Sep 2023 15:56:46 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D562113
        for <selinux@vger.kernel.org>; Fri, 29 Sep 2023 12:56:44 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7740c8509c8so912391485a.3
        for <selinux@vger.kernel.org>; Fri, 29 Sep 2023 12:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696017403; x=1696622203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHCP+t63RHpOqaUrds4qKXl3q/8PkxR/0zjfBrnXpnY=;
        b=UgkNECe/LJgYs6uj8XExkwBENUQABPTDk7rnnuhcxroj2McCv8YF8/hqScGxP4BChu
         kxni669XTsHpmXndFFH9uH1UUU8+eP2LO52X3eJK/3BVM+ac7dolhD7c7lSCz8FCBytv
         FFM72GvcF/XKoiyodc/6sBpCT22BoCvULJb2+p6TYWhS2ufN81qum8suaTVhIvsftcc3
         ZStnJY2bDnmBH+WxfPgM0vICgCnc1uMDO3AyGCNUgQTx0g67A9ILtKUZIWGytftT/Dcf
         JzLPhKLVkfSNjd2D7QGGy3WhXHaikpiyyFSi2MlBQlcqM6Sbmvmz8dFgF4fBb6PScBug
         /+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696017403; x=1696622203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHCP+t63RHpOqaUrds4qKXl3q/8PkxR/0zjfBrnXpnY=;
        b=bC9sFOT0Sdz81Rth0LyXAOESbn9QDOOlKzhZ85NAuJEmUMUI4+DVP4Byu9BW1qTUE6
         JRG2dsxabpL5DE7xQHNeojNZqEdGqt/Jnygu1I7Eu2LAkhNvKV6scacXQAxBXtHLJpVQ
         qFajfpOxnQ1FFgjIQBC/LTrQvADoRgdmmNJO4sLuISuPtTRV9S/shFd88j4Vt0r4jfKX
         ZHLFlkpOOOrLZ2tFgHm4QZ9C76Vq9Nxk1/LKrJljfyFJZnR0sV0hGekmc2YsRGjMxkvq
         rkXe6B6LGXRS6ZZCuSCDNKAtAxYflNwF/4HKygAryp9hSHvOOD/6Y2JhUyT7ux9IYQig
         RUGQ==
X-Gm-Message-State: AOJu0YziDZGgBv0inw+C1cCxx7gxxEnTkuG86t7CubJB33nWD8CqGi7D
        or2eQRZZSlhWtyhLQaagerL3jI+sDO8=
X-Google-Smtp-Source: AGHT+IH4Jz5Hs7r3hk5w1Ib7NgnJCZmUD5zZbDrD682pQqZE6Upih70X8bozo7jUDjQK3d9lNpqoPg==
X-Received: by 2002:a05:620a:942:b0:773:a83f:4a66 with SMTP id w2-20020a05620a094200b00773a83f4a66mr4915787qkw.36.1696017402906;
        Fri, 29 Sep 2023 12:56:42 -0700 (PDT)
Received: from 5bc235456ce7.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id t6-20020a05620a034600b00767e98535b7sm5795291qkm.67.2023.09.29.12.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 12:56:42 -0700 (PDT)
From:   Jacob Satterfield <jsatterfield.linux@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Jacob Satterfield <jsatterfield.linux@gmail.com>,
        stephen.smalley.work@gmail.com, paul@paul-moore.com,
        omosnace@redhat.com
Subject: [PATCH 4/4] selinux: use arrays for avtab hashtable nodes
Date:   Fri, 29 Sep 2023 19:56:15 +0000
Message-ID: <20230929195617.65120-5-jsatterfield.linux@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230929195617.65120-1-jsatterfield.linux@gmail.com>
References: <20230929195617.65120-1-jsatterfield.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The current avtab hashtable employs a separate chaining collision
resolution strategy where each bucket/chain holds an ordered linked list
of pointers to kmem_cache allocated avtab_node elements.

On Fedora 38 (x86_64) using the default policy, avtab_node_cachep
uses 573 slabs each containing 170 objects totaling 2,337,840 bytes.
A call to kmem_cache_zalloc() is required for every single rule, which
in the default policy is currently 96,730 and continually rising.

When both sets of avtab_node (regular and cond.) are turned into arrays
with the hash table slot indexing into it rather than a pointer, then
this results in only 2 additional kvcalloc() calls and the complete
removal of the kmem_cache itself.

Due to how conditional rules are written in the binary policy, the
code responsible for loading does not know how many conditional rules
there are before creating the avtab structure. Instead, it was using the
number of elements in the non-conditional avtab as a hint and allocates
the hash table based on it. Therefore, a two-pass algorithm is now used
to calculate the rule count before allocating the avtab nodes array.
With the current refpolicy and default Fedora policy, this causes the
number of hash slots for the conditional array to become 4096 instead of
32768. This results in a savings of 224KB of heap memory.

The caching characteristics of iterating a single array are better due
to locality of reference. Running "perf stat -r 100 -d load_policy"
has shown a runtime reduction of at least 10% on a Fedora 38 x86_64 VM
with this single patch. Future patches focused on improving the hash
table's collision resolution strategy and array layout (struct-of-arrays
vs. array-of-structs) may elicit even more caching and therefore runtime
performance improvements.

Signed-off-by: Jacob Satterfield <jsatterfield.linux@gmail.com>
---
 security/selinux/ss/avtab.c       | 47 ++++++++++++++++++++-----------
 security/selinux/ss/avtab.h       |  4 ++-
 security/selinux/ss/conditional.c | 37 ++++++++++++++++--------
 security/selinux/ss/conditional.h |  2 +-
 4 files changed, 59 insertions(+), 31 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index e8046eda7140..67bf96d70923 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -24,7 +24,6 @@
 #include "avtab.h"
 #include "policydb.h"
 
-static struct kmem_cache *avtab_node_cachep __ro_after_init;
 static struct kmem_cache *avtab_xperms_cachep __ro_after_init;
 
 #define avtab_chain_for_each(pos, tab, slot) \
@@ -79,17 +78,15 @@ avtab_insert_node(struct avtab *h, struct avtab_node **dst,
 {
 	struct avtab_node *newnode;
 	struct avtab_extended_perms *xperms;
-	newnode = kmem_cache_zalloc(avtab_node_cachep, GFP_KERNEL);
-	if (newnode == NULL)
+	if (h->nel == h->nnodes)
 		return NULL;
+	newnode = &h->nodes[h->nel];
 	newnode->key = *key;
 
 	if (key->specified & AVTAB_XPERMS) {
 		xperms = kmem_cache_zalloc(avtab_xperms_cachep, GFP_KERNEL);
-		if (xperms == NULL) {
-			kmem_cache_free(avtab_node_cachep, newnode);
+		if (xperms == NULL)
 			return NULL;
-		}
 		*xperms = *(datum->u.xperms);
 		newnode->datum.u.xperms = xperms;
 	} else {
@@ -233,11 +230,13 @@ void avtab_destroy(struct avtab *h)
 			if (cur->key.specified & AVTAB_XPERMS)
 				kmem_cache_free(avtab_xperms_cachep,
 						cur->datum.u.xperms);
-			kmem_cache_free(avtab_node_cachep, cur);
 		}
 	}
 	kvfree(h->htable);
+	kvfree(h->nodes);
 	h->htable = NULL;
+	h->nodes = NULL;
+	h->nnodes = 0;
 	h->nel = 0;
 	h->nslot = 0;
 	h->mask = 0;
@@ -246,20 +245,28 @@ void avtab_destroy(struct avtab *h)
 void avtab_init(struct avtab *h)
 {
 	h->htable = NULL;
+	h->nodes = NULL;
+	h->nnodes = 0;
 	h->nel = 0;
 	h->nslot = 0;
 	h->mask = 0;
 }
 
-static int avtab_alloc_common(struct avtab *h, u32 nslot)
+static int avtab_alloc_common(struct avtab *h, u32 nslot, u32 nrules)
 {
 	if (!nslot)
 		return 0;
 
-	h->htable = kvcalloc(nslot, sizeof(void *), GFP_KERNEL);
+	h->htable = kvcalloc(nslot, sizeof(*h->htable), GFP_KERNEL);
 	if (!h->htable)
 		return -ENOMEM;
-
+	h->nodes = kvcalloc(nrules, sizeof(*h->nodes), GFP_KERNEL);
+	if (!h->nodes) {
+		kvfree(h->htable);
+		h->htable = NULL;
+		return -ENOMEM;
+	}
+	h->nnodes = nrules;
 	h->nslot = nslot;
 	h->mask = nslot - 1;
 	return 0;
@@ -275,7 +282,7 @@ int avtab_alloc(struct avtab *h, u32 nrules)
 		if (nslot > MAX_AVTAB_HASH_BUCKETS)
 			nslot = MAX_AVTAB_HASH_BUCKETS;
 
-		rc = avtab_alloc_common(h, nslot);
+		rc = avtab_alloc_common(h, nslot, nrules);
 		if (rc)
 			return rc;
 	}
@@ -286,7 +293,7 @@ int avtab_alloc(struct avtab *h, u32 nrules)
 
 int avtab_alloc_dup(struct avtab *new, const struct avtab *orig)
 {
-	return avtab_alloc_common(new, orig->nslot);
+	return avtab_alloc_common(new, orig->nslot, orig->nel);
 }
 
 #ifdef CONFIG_SECURITY_SELINUX_DEBUG
@@ -335,7 +342,7 @@ static const uint16_t spec_order[] = {
 int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 		    int (*insertf)(struct avtab *a, const struct avtab_key *k,
 				   const struct avtab_datum *d, void *p),
-		    void *p)
+		    void *p, u32 *nrules)
 {
 	__le16 buf16[4];
 	u16 enabled;
@@ -409,6 +416,10 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 			if (val & spec_order[i]) {
 				key.specified = spec_order[i] | enabled;
 				datum.u.data = le32_to_cpu(buf32[items++]);
+				if (nrules) {
+					(*nrules)++;
+					continue;
+				}
 				rc = insertf(a, &key, &datum, p);
 				if (rc)
 					return rc;
@@ -487,6 +498,11 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 		pr_err("SELinux: avtab: invalid type\n");
 		return -EINVAL;
 	}
+
+	if (nrules) {
+		(*nrules)++;
+		return 0;
+	}
 	return insertf(a, &key, &datum, p);
 }
 
@@ -520,7 +536,7 @@ int avtab_read(struct avtab *a, void *fp, struct policydb *pol)
 		goto bad;
 
 	for (i = 0; i < nel; i++) {
-		rc = avtab_read_item(a, fp, pol, avtab_insertf, NULL);
+		rc = avtab_read_item(a, fp, pol, avtab_insertf, NULL, NULL);
 		if (rc) {
 			if (rc == -ENOMEM)
 				pr_err("SELinux: avtab: out of memory\n");
@@ -600,9 +616,6 @@ int avtab_write(struct policydb *p, struct avtab *a, void *fp)
 
 void __init avtab_cache_init(void)
 {
-	avtab_node_cachep = kmem_cache_create("avtab_node",
-					      sizeof(struct avtab_node),
-					      0, SLAB_PANIC, NULL);
 	avtab_xperms_cachep = kmem_cache_create("avtab_extended_perms",
 						sizeof(struct avtab_extended_perms),
 						0, SLAB_PANIC, NULL);
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index 3c3904bf02b0..5e465be6f057 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -82,6 +82,8 @@ struct avtab_node {
 
 struct avtab {
 	struct avtab_node **htable;
+	struct avtab_node *nodes;
+	u32 nnodes;	/* number of nodes */
 	u32 nel;	/* number of elements */
 	u32 nslot;      /* number of hash slots */
 	u32 mask;       /* mask to compute hash func */
@@ -104,7 +106,7 @@ struct policydb;
 int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 		    int (*insert)(struct avtab *a, const struct avtab_key *k,
 				  const struct avtab_datum *d, void *p),
-		    void *p);
+		    void *p, u32 *nrules);
 
 int avtab_read(struct avtab *a, void *fp, struct policydb *pol);
 int avtab_write_item(struct policydb *p, const struct avtab_node *cur, void *fp);
diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 81ff676f209a..bbd35b35b79d 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -140,7 +140,7 @@ void cond_policydb_init(struct policydb *p)
 static void cond_node_destroy(struct cond_node *node)
 {
 	kfree(node->expr.nodes);
-	/* the avtab_ptr_t nodes are destroyed by the avtab */
+	/* the actual nodes were destroyed by avtab_destroy() */
 	kfree(node->true_list.nodes);
 	kfree(node->false_list.nodes);
 }
@@ -323,7 +323,8 @@ static int cond_insertf(struct avtab *a, const struct avtab_key *k,
 
 static int cond_read_av_list(struct policydb *p, void *fp,
 			     struct cond_av_list *list,
-			     struct cond_av_list *other)
+			     struct cond_av_list *other,
+			     u32 *nrules)
 {
 	int rc;
 	__le32 buf[1];
@@ -347,7 +348,7 @@ static int cond_read_av_list(struct policydb *p, void *fp,
 	for (i = 0; i < len; i++) {
 		data.dst = &list->nodes[i];
 		rc = avtab_read_item(&p->te_cond_avtab, fp, p, cond_insertf,
-				     &data);
+				     &data, nrules);
 		if (rc) {
 			kfree(list->nodes);
 			list->nodes = NULL;
@@ -373,7 +374,8 @@ static int expr_node_isvalid(struct policydb *p, struct cond_expr_node *expr)
 	return 1;
 }
 
-static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
+static int cond_read_node(struct policydb *p, struct cond_node *node,
+			  void *fp, u32 *nrules)
 {
 	__le32 buf[2];
 	u32 i, len;
@@ -407,16 +409,17 @@ static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
 			return -EINVAL;
 	}
 
-	rc = cond_read_av_list(p, fp, &node->true_list, NULL);
+	rc = cond_read_av_list(p, fp, &node->true_list, NULL, nrules);
 	if (rc)
 		return rc;
-	return cond_read_av_list(p, fp, &node->false_list, &node->true_list);
+	return cond_read_av_list(p, fp, &node->false_list, &node->true_list, nrules);
 }
 
-int cond_read_list(struct policydb *p, void *fp)
+int cond_read_list(struct policydb *p, struct policy_file *fp)
 {
 	__le32 buf[1];
-	u32 i, len;
+	struct policy_file tmp_fp;
+	u32 i, len, nrules;
 	int rc;
 
 	rc = next_entry(buf, fp, sizeof(buf));
@@ -428,15 +431,25 @@ int cond_read_list(struct policydb *p, void *fp)
 	p->cond_list = kcalloc(len, sizeof(*p->cond_list), GFP_KERNEL);
 	if (!p->cond_list)
 		return -ENOMEM;
+	p->cond_list_len = len;
+
+	/* first pass to only calculate the avrule count */
+	tmp_fp = *fp;
+	nrules = 0;
+	for (i = 0; i < len; i++) {
+		rc = cond_read_node(p, &p->cond_list[i], &tmp_fp, &nrules);
+		if (rc)
+			goto err;
+		cond_node_destroy(&p->cond_list[i]);
+	}
 
-	rc = avtab_alloc(&(p->te_cond_avtab), p->te_avtab.nel);
+	rc = avtab_alloc(&(p->te_cond_avtab), nrules);
 	if (rc)
 		goto err;
 
-	p->cond_list_len = len;
-
+	/* second pass to read in the conditional nodes */
 	for (i = 0; i < len; i++) {
-		rc = cond_read_node(p, &p->cond_list[i], fp);
+		rc = cond_read_node(p, &p->cond_list[i], fp, NULL);
 		if (rc)
 			goto err;
 	}
diff --git a/security/selinux/ss/conditional.h b/security/selinux/ss/conditional.h
index 5a7b51278dc6..62a12d00cac9 100644
--- a/security/selinux/ss/conditional.h
+++ b/security/selinux/ss/conditional.h
@@ -70,7 +70,7 @@ int cond_destroy_bool(void *key, void *datum, void *p);
 int cond_index_bool(void *key, void *datum, void *datap);
 
 int cond_read_bool(struct policydb *p, struct symtab *s, void *fp);
-int cond_read_list(struct policydb *p, void *fp);
+int cond_read_list(struct policydb *p, struct policy_file *fp);
 int cond_write_bool(void *key, void *datum, void *ptr);
 int cond_write_list(struct policydb *p, void *fp);
 
-- 
2.41.0

