Return-Path: <SRS0=yj3S=6M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBD0C8300A
	for <selinux@archiver.kernel.org>; Tue, 28 Apr 2020 12:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE7BE206D6
	for <selinux@archiver.kernel.org>; Tue, 28 Apr 2020 12:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QcJADULZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgD1Mzc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Apr 2020 08:55:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49621 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726829AbgD1Mzc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Apr 2020 08:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588078528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dSsLjr+MKMTOnd4t1HIx853Sv4MuTv2OWXqqJejoTMM=;
        b=QcJADULZjQyIouOYJRrYZCynCs4UTY4j/6mNF+9OjXuUKkWjIAdBYPMJnQiMgKiEKEvbnN
        WjhW+NsEp+ke6PovK30SUaQ8tqodhwVnaw4W2HEFf6UAUu2bJlBWZw9c3CjvX3VgmvHl87
        16w9vXVp+piMqkMm3yc88ONcw/8BET0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37--GR99UOJM7-2ZFYA5x4X5w-1; Tue, 28 Apr 2020 08:55:24 -0400
X-MC-Unique: -GR99UOJM7-2ZFYA5x4X5w-1
Received: by mail-wr1-f69.google.com with SMTP id v9so12190722wrt.7
        for <selinux@vger.kernel.org>; Tue, 28 Apr 2020 05:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dSsLjr+MKMTOnd4t1HIx853Sv4MuTv2OWXqqJejoTMM=;
        b=LzlQDFY3hJZiAsf6NKIsbLUDOa65G6T1lGpffy9hKkyVMo81PHPpvPECKL2U9wN6g6
         55+QV5MQIHsDB07sY9MfgJhU6YxJFBiBV82VEKuDO4BJn4UqF/nMKJ6Y/FhgbCq9jHy9
         DAMYdC63zyC8oDy3UVWP2RTU19gGMlAzKCZCmnTx0V8BW2ARNf4sry82Y1wLX+CTVF+T
         qxEU9nBapRezVPO2FCSFiz6qUoZhbHZtsMDFWbTX728hLTMF4M3Af7SnHIphIQKKVY7e
         k0P2XQKF53mGfb6Dhgq8DFIT+uj43tub0wcaP2kjoYM8/VkMnmvpu5t7hsghgDKRG/42
         AAQQ==
X-Gm-Message-State: AGi0PuYNW+vCOX0gbWx3kCA7bqwck+zdLPdO8hmuZNrYhJHt5s7XMi5M
        4jNn9FQ8itQiR8rEpsW4K0+mJYkXJwMt41SXX3AEXfwoijIcriBKFACwmnrLFo5ohjPVhEvTAqV
        ODfv0DN/7TlQcHgo3BQ==
X-Received: by 2002:a7b:c944:: with SMTP id i4mr4779783wml.144.1588078523037;
        Tue, 28 Apr 2020 05:55:23 -0700 (PDT)
X-Google-Smtp-Source: APiQypKlR7msCkF7vQF099NvAVv5zDOl7cHFEEoAQjqvI+TIQ8y3evytEkvXt9F5vbGsxq2cqoQvsA==
X-Received: by 2002:a7b:c944:: with SMTP id i4mr4779732wml.144.1588078522341;
        Tue, 28 Apr 2020 05:55:22 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id y63sm3082438wmg.21.2020.04.28.05.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 05:55:21 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 3/4] selinux: prepare for inlining of hashtab functions
Date:   Tue, 28 Apr 2020 14:55:13 +0200
Message-Id: <20200428125514.2780171-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200428125514.2780171-1-omosnace@redhat.com>
References: <20200428125514.2780171-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Refactor searching and inserting into hashtabs to pave way for
converting hashtab_search() and hashtab_insert() to inline functions in
the next patch. This will avoid indirect calls and allow the compiler to
better optimize individual callers, leading to a drastic performance
improvement.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/conditional.c |   4 +-
 security/selinux/ss/conditional.h |   2 +-
 security/selinux/ss/hashtab.c     |  44 +++++-----
 security/selinux/ss/hashtab.h     |  22 ++---
 security/selinux/ss/mls.c         |  23 +++---
 security/selinux/ss/policydb.c    | 128 +++++++++++++++++++-----------
 security/selinux/ss/policydb.h    |   9 +++
 security/selinux/ss/services.c    |  38 ++++-----
 security/selinux/ss/symtab.c      |  22 ++++-
 security/selinux/ss/symtab.h      |   3 +
 10 files changed, 178 insertions(+), 117 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 939a74fd8fb4..a07cf947376f 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -200,7 +200,7 @@ static int bool_isvalid(struct cond_bool_datum *b)
 	return 1;
 }
 
-int cond_read_bool(struct policydb *p, struct hashtab *h, void *fp)
+int cond_read_bool(struct policydb *p, struct symtab *s, void *fp)
 {
 	char *key = NULL;
 	struct cond_bool_datum *booldatum;
@@ -235,7 +235,7 @@ int cond_read_bool(struct policydb *p, struct hashtab *h, void *fp)
 	if (rc)
 		goto err;
 	key[len] = '\0';
-	rc = hashtab_insert(h, key, booldatum);
+	rc = symtab_insert(s, key, booldatum);
 	if (rc)
 		goto err;
 
diff --git a/security/selinux/ss/conditional.h b/security/selinux/ss/conditional.h
index 90c9c964f5f5..79e7e03db859 100644
--- a/security/selinux/ss/conditional.h
+++ b/security/selinux/ss/conditional.h
@@ -69,7 +69,7 @@ int cond_destroy_bool(void *key, void *datum, void *p);
 
 int cond_index_bool(void *key, void *datum, void *datap);
 
-int cond_read_bool(struct policydb *p, struct hashtab *h, void *fp);
+int cond_read_bool(struct policydb *p, struct symtab *s, void *fp);
 int cond_read_list(struct policydb *p, void *fp);
 int cond_write_bool(void *key, void *datum, void *ptr);
 int cond_write_list(struct policydb *p, void *fp);
diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index 5ee868116d70..8126b909a757 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -29,16 +29,10 @@ static u32 hashtab_compute_size(u32 nel)
 	return nel == 0 ? 0 : roundup_pow_of_two(nel);
 }
 
-int hashtab_init(struct hashtab *h,
-		 u32 (*hash_value)(struct hashtab *h, const void *key),
-		 int (*keycmp)(struct hashtab *h, const void *key1,
-			       const void *key2),
-		 u32 nel_hint)
+int hashtab_init(struct hashtab *h, u32 nel_hint)
 {
 	h->size = hashtab_compute_size(nel_hint);
 	h->nel = 0;
-	h->hash_value = hash_value;
-	h->keycmp = keycmp;
 	if (!h->size)
 		return 0;
 
@@ -46,7 +40,8 @@ int hashtab_init(struct hashtab *h,
 	return h->htable ? 0 : -ENOMEM;
 }
 
-int hashtab_insert(struct hashtab *h, void *key, void *datum)
+int hashtab_insert(struct hashtab *h, void *key, void *datum,
+		   struct hashtab_key_params key_params)
 {
 	u32 hvalue;
 	struct hashtab_node *prev, *cur, *newnode;
@@ -56,17 +51,20 @@ int hashtab_insert(struct hashtab *h, void *key, void *datum)
 	if (!h->size || h->nel == HASHTAB_MAX_NODES)
 		return -EINVAL;
 
-	hvalue = h->hash_value(h, key);
+	hvalue = key_params.hash(key) & (h->size - 1);
 	prev = NULL;
 	cur = h->htable[hvalue];
-	while (cur && h->keycmp(h, key, cur->key) > 0) {
+	while (cur) {
+		int cmp = key_params.cmp(key, cur->key);
+
+		if (cmp == 0)
+			return -EEXIST;
+		if (cmp < 0)
+			break;
 		prev = cur;
 		cur = cur->next;
 	}
 
-	if (cur && (h->keycmp(h, key, cur->key) == 0))
-		return -EEXIST;
-
 	newnode = kmem_cache_zalloc(hashtab_node_cachep, GFP_KERNEL);
 	if (!newnode)
 		return -ENOMEM;
@@ -84,7 +82,8 @@ int hashtab_insert(struct hashtab *h, void *key, void *datum)
 	return 0;
 }
 
-void *hashtab_search(struct hashtab *h, const void *key)
+void *hashtab_search(struct hashtab *h, const void *key,
+		     struct hashtab_key_params key_params)
 {
 	u32 hvalue;
 	struct hashtab_node *cur;
@@ -92,15 +91,18 @@ void *hashtab_search(struct hashtab *h, const void *key)
 	if (!h->size)
 		return NULL;
 
-	hvalue = h->hash_value(h, key);
+	hvalue = key_params.hash(key) & (h->size - 1);
 	cur = h->htable[hvalue];
-	while (cur && h->keycmp(h, key, cur->key) > 0)
-		cur = cur->next;
+	while (cur) {
+		int cmp = key_params.cmp(key, cur->key);
 
-	if (!cur || (h->keycmp(h, key, cur->key) != 0))
-		return NULL;
-
-	return cur->datum;
+		if (cmp == 0)
+			return cur->datum;
+		if (cmp < 0)
+			break;
+		cur = cur->next;
+	}
+	return NULL;
 }
 
 void hashtab_destroy(struct hashtab *h)
diff --git a/security/selinux/ss/hashtab.h b/security/selinux/ss/hashtab.h
index 31c11511fe10..4885234257d4 100644
--- a/security/selinux/ss/hashtab.h
+++ b/security/selinux/ss/hashtab.h
@@ -13,6 +13,12 @@
 
 #define HASHTAB_MAX_NODES	0xffffffff
 
+struct hashtab_key_params {
+	u32 (*hash)(const void *key);	/* hash function */
+	int (*cmp)(const void *key1, const void *key2);
+					/* key comparison function */
+};
+
 struct hashtab_node {
 	void *key;
 	void *datum;
@@ -23,10 +29,6 @@ struct hashtab {
 	struct hashtab_node **htable;	/* hash table */
 	u32 size;			/* number of slots in hash table */
 	u32 nel;			/* number of elements in hash table */
-	u32 (*hash_value)(struct hashtab *h, const void *key);
-					/* hash function */
-	int (*keycmp)(struct hashtab *h, const void *key1, const void *key2);
-					/* key comparison function */
 };
 
 struct hashtab_info {
@@ -39,11 +41,7 @@ struct hashtab_info {
  *
  * Returns -ENOMEM if insufficient space is available or 0 otherwise.
  */
-int hashtab_init(struct hashtab *h,
-		 u32 (*hash_value)(struct hashtab *h, const void *key),
-		 int (*keycmp)(struct hashtab *h, const void *key1,
-			       const void *key2),
-		 u32 nel_hint);
+int hashtab_init(struct hashtab *h, u32 nel_hint);
 
 /*
  * Inserts the specified (key, datum) pair into the specified hash table.
@@ -53,7 +51,8 @@ int hashtab_init(struct hashtab *h,
  * -EINVAL for general errors or
   0 otherwise.
  */
-int hashtab_insert(struct hashtab *h, void *k, void *d);
+int hashtab_insert(struct hashtab *h, void *k, void *d,
+		   struct hashtab_key_params key_params);
 
 /*
  * Searches for the entry with the specified key in the hash table.
@@ -61,7 +60,8 @@ int hashtab_insert(struct hashtab *h, void *k, void *d);
  * Returns NULL if no entry has the specified key or
  * the datum of the entry otherwise.
  */
-void *hashtab_search(struct hashtab *h, const void *k);
+void *hashtab_search(struct hashtab *h, const void *k,
+		     struct hashtab_key_params key_params);
 
 /*
  * Destroys the specified hash table.
diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index cd8734f25b39..408d306895f8 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -165,8 +165,8 @@ int mls_level_isvalid(struct policydb *p, struct mls_level *l)
 
 	if (!l->sens || l->sens > p->p_levels.nprim)
 		return 0;
-	levdatum = hashtab_search(&p->p_levels.table,
-				  sym_name(p, SYM_LEVELS, l->sens - 1));
+	levdatum = symtab_search(&p->p_levels,
+				 sym_name(p, SYM_LEVELS, l->sens - 1));
 	if (!levdatum)
 		return 0;
 
@@ -293,7 +293,7 @@ int mls_context_to_sid(struct policydb *pol,
 			*(next_cat++) = '\0';
 
 		/* Parse sensitivity. */
-		levdatum = hashtab_search(&pol->p_levels.table, sensitivity);
+		levdatum = symtab_search(&pol->p_levels, sensitivity);
 		if (!levdatum)
 			return -EINVAL;
 		context->range.level[l].sens = levdatum->level->sens;
@@ -312,7 +312,7 @@ int mls_context_to_sid(struct policydb *pol,
 				*rngptr++ = '\0';
 			}
 
-			catdatum = hashtab_search(&pol->p_cats.table, cur_cat);
+			catdatum = symtab_search(&pol->p_cats, cur_cat);
 			if (!catdatum)
 				return -EINVAL;
 
@@ -325,7 +325,7 @@ int mls_context_to_sid(struct policydb *pol,
 			if (rngptr == NULL)
 				continue;
 
-			rngdatum = hashtab_search(&pol->p_cats.table, rngptr);
+			rngdatum = symtab_search(&pol->p_cats, rngptr);
 			if (!rngdatum)
 				return -EINVAL;
 
@@ -458,9 +458,10 @@ int mls_convert_context(struct policydb *oldp,
 		return 0;
 
 	for (l = 0; l < 2; l++) {
-		levdatum = hashtab_search(&newp->p_levels.table,
-					  sym_name(oldp, SYM_LEVELS,
-						   oldc->range.level[l].sens - 1));
+		char *name = sym_name(oldp, SYM_LEVELS,
+				      oldc->range.level[l].sens - 1);
+
+		levdatum = symtab_search(&newp->p_levels, name);
 
 		if (!levdatum)
 			return -EINVAL;
@@ -470,8 +471,8 @@ int mls_convert_context(struct policydb *oldp,
 					      node, i) {
 			int rc;
 
-			catdatum = hashtab_search(&newp->p_cats.table,
-						  sym_name(oldp, SYM_CATS, i));
+			catdatum = symtab_search(&newp->p_cats,
+						 sym_name(oldp, SYM_CATS, i));
 			if (!catdatum)
 				return -EINVAL;
 			rc = ebitmap_set_bit(&newc->range.level[l].cat,
@@ -506,7 +507,7 @@ int mls_compute_sid(struct policydb *p,
 		rtr.source_type = scontext->type;
 		rtr.target_type = tcontext->type;
 		rtr.target_class = tclass;
-		r = hashtab_search(&p->range_tr, &rtr);
+		r = policydb_rangetr_search(p, &rtr);
 		if (r)
 			return mls_range_set(newcontext, r);
 
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 3c346d5d6faa..7aadfaf6513e 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -400,7 +400,7 @@ static int roles_init(struct policydb *p)
 	if (!key)
 		goto out;
 
-	rc = hashtab_insert(&p->p_roles.table, key, role);
+	rc = symtab_insert(&p->p_roles, key, role);
 	if (rc)
 		goto out;
 
@@ -411,7 +411,7 @@ out:
 	return rc;
 }
 
-static u32 filenametr_hash(struct hashtab *h, const void *k)
+static u32 filenametr_hash(const void *k)
 {
 	const struct filename_trans_key *ft = k;
 	unsigned long hash;
@@ -423,10 +423,10 @@ static u32 filenametr_hash(struct hashtab *h, const void *k)
 	byte_num = 0;
 	while ((focus = ft->name[byte_num++]))
 		hash = partial_name_hash(focus, hash);
-	return hash & (h->size - 1);
+	return hash;
 }
 
-static int filenametr_cmp(struct hashtab *h, const void *k1, const void *k2)
+static int filenametr_cmp(const void *k1, const void *k2)
 {
 	const struct filename_trans_key *ft1 = k1;
 	const struct filename_trans_key *ft2 = k2;
@@ -444,15 +444,26 @@ static int filenametr_cmp(struct hashtab *h, const void *k1, const void *k2)
 
 }
 
-static u32 rangetr_hash(struct hashtab *h, const void *k)
+static const struct hashtab_key_params filenametr_key_params = {
+	.hash = filenametr_hash,
+	.cmp = filenametr_cmp,
+};
+
+struct filename_trans_datum *policydb_filenametr_search(
+	struct policydb *p, struct filename_trans_key *key)
+{
+	return hashtab_search(&p->filename_trans, key, filenametr_key_params);
+}
+
+static u32 rangetr_hash(const void *k)
 {
 	const struct range_trans *key = k;
 
-	return (key->source_type + (key->target_type << 3) +
-		(key->target_class << 5)) & (h->size - 1);
+	return key->source_type + (key->target_type << 3) +
+		(key->target_class << 5);
 }
 
-static int rangetr_cmp(struct hashtab *h, const void *k1, const void *k2)
+static int rangetr_cmp(const void *k1, const void *k2)
 {
 	const struct range_trans *key1 = k1, *key2 = k2;
 	int v;
@@ -470,15 +481,25 @@ static int rangetr_cmp(struct hashtab *h, const void *k1, const void *k2)
 	return v;
 }
 
-static u32 role_trans_hash(struct hashtab *h, const void *k)
+static const struct hashtab_key_params rangetr_key_params = {
+	.hash = rangetr_hash,
+	.cmp = rangetr_cmp,
+};
+
+struct mls_range *policydb_rangetr_search(struct policydb *p,
+					  struct range_trans *key)
+{
+	return hashtab_search(&p->range_tr, key, rangetr_key_params);
+}
+
+static u32 role_trans_hash(const void *k)
 {
 	const struct role_trans_key *key = k;
 
-	return (key->role + (key->type << 3) + (key->tclass << 5)) &
-		(h->size - 1);
+	return key->role + (key->type << 3) + (key->tclass << 5);
 }
 
-static int role_trans_cmp(struct hashtab *h, const void *k1, const void *k2)
+static int role_trans_cmp(const void *k1, const void *k2)
 {
 	const struct role_trans_key *key1 = k1, *key2 = k2;
 	int v;
@@ -494,6 +515,17 @@ static int role_trans_cmp(struct hashtab *h, const void *k1, const void *k2)
 	return key1->tclass - key2->tclass;
 }
 
+static const struct hashtab_key_params roletr_key_params = {
+	.hash = role_trans_hash,
+	.cmp = role_trans_cmp,
+};
+
+struct role_trans_datum *policydb_roletr_search(struct policydb *p,
+						struct role_trans_key *key)
+{
+	return hashtab_search(&p->role_tr, key, roletr_key_params);
+}
+
 /*
  * Initialize a policy database structure.
  */
@@ -1065,7 +1097,7 @@ static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
 	return 0;
 }
 
-static int perm_read(struct policydb *p, struct hashtab *h, void *fp)
+static int perm_read(struct policydb *p, struct symtab *s, void *fp)
 {
 	char *key = NULL;
 	struct perm_datum *perdatum;
@@ -1088,7 +1120,7 @@ static int perm_read(struct policydb *p, struct hashtab *h, void *fp)
 	if (rc)
 		goto bad;
 
-	rc = hashtab_insert(h, key, perdatum);
+	rc = symtab_insert(s, key, perdatum);
 	if (rc)
 		goto bad;
 
@@ -1098,7 +1130,7 @@ bad:
 	return rc;
 }
 
-static int common_read(struct policydb *p, struct hashtab *h, void *fp)
+static int common_read(struct policydb *p, struct symtab *s, void *fp)
 {
 	char *key = NULL;
 	struct common_datum *comdatum;
@@ -1128,12 +1160,12 @@ static int common_read(struct policydb *p, struct hashtab *h, void *fp)
 		goto bad;
 
 	for (i = 0; i < nel; i++) {
-		rc = perm_read(p, &comdatum->permissions.table, fp);
+		rc = perm_read(p, &comdatum->permissions, fp);
 		if (rc)
 			goto bad;
 	}
 
-	rc = hashtab_insert(h, key, comdatum);
+	rc = symtab_insert(s, key, comdatum);
 	if (rc)
 		goto bad;
 	return 0;
@@ -1262,7 +1294,7 @@ static int read_cons_helper(struct policydb *p,
 	return 0;
 }
 
-static int class_read(struct policydb *p, struct hashtab *h, void *fp)
+static int class_read(struct policydb *p, struct symtab *s, void *fp)
 {
 	char *key = NULL;
 	struct class_datum *cladatum;
@@ -1300,8 +1332,8 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
 			goto bad;
 
 		rc = -EINVAL;
-		cladatum->comdatum = hashtab_search(&p->p_commons.table,
-						    cladatum->comkey);
+		cladatum->comdatum = symtab_search(&p->p_commons,
+						   cladatum->comkey);
 		if (!cladatum->comdatum) {
 			pr_err("SELinux:  unknown common %s\n",
 			       cladatum->comkey);
@@ -1309,7 +1341,7 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
 		}
 	}
 	for (i = 0; i < nel; i++) {
-		rc = perm_read(p, &cladatum->permissions.table, fp);
+		rc = perm_read(p, &cladatum->permissions, fp);
 		if (rc)
 			goto bad;
 	}
@@ -1347,7 +1379,7 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
 		cladatum->default_type = le32_to_cpu(buf[0]);
 	}
 
-	rc = hashtab_insert(h, key, cladatum);
+	rc = symtab_insert(s, key, cladatum);
 	if (rc)
 		goto bad;
 
@@ -1357,7 +1389,7 @@ bad:
 	return rc;
 }
 
-static int role_read(struct policydb *p, struct hashtab *h, void *fp)
+static int role_read(struct policydb *p, struct symtab *s, void *fp)
 {
 	char *key = NULL;
 	struct role_datum *role;
@@ -1404,7 +1436,7 @@ static int role_read(struct policydb *p, struct hashtab *h, void *fp)
 		goto bad;
 	}
 
-	rc = hashtab_insert(h, key, role);
+	rc = symtab_insert(s, key, role);
 	if (rc)
 		goto bad;
 	return 0;
@@ -1413,7 +1445,7 @@ bad:
 	return rc;
 }
 
-static int type_read(struct policydb *p, struct hashtab *h, void *fp)
+static int type_read(struct policydb *p, struct symtab *s, void *fp)
 {
 	char *key = NULL;
 	struct type_datum *typdatum;
@@ -1451,7 +1483,7 @@ static int type_read(struct policydb *p, struct hashtab *h, void *fp)
 	if (rc)
 		goto bad;
 
-	rc = hashtab_insert(h, key, typdatum);
+	rc = symtab_insert(s, key, typdatum);
 	if (rc)
 		goto bad;
 	return 0;
@@ -1487,7 +1519,7 @@ static int mls_read_level(struct mls_level *lp, void *fp)
 	return 0;
 }
 
-static int user_read(struct policydb *p, struct hashtab *h, void *fp)
+static int user_read(struct policydb *p, struct symtab *s, void *fp)
 {
 	char *key = NULL;
 	struct user_datum *usrdatum;
@@ -1528,7 +1560,7 @@ static int user_read(struct policydb *p, struct hashtab *h, void *fp)
 			goto bad;
 	}
 
-	rc = hashtab_insert(h, key, usrdatum);
+	rc = symtab_insert(s, key, usrdatum);
 	if (rc)
 		goto bad;
 	return 0;
@@ -1537,7 +1569,7 @@ bad:
 	return rc;
 }
 
-static int sens_read(struct policydb *p, struct hashtab *h, void *fp)
+static int sens_read(struct policydb *p, struct symtab *s, void *fp)
 {
 	char *key = NULL;
 	struct level_datum *levdatum;
@@ -1569,7 +1601,7 @@ static int sens_read(struct policydb *p, struct hashtab *h, void *fp)
 	if (rc)
 		goto bad;
 
-	rc = hashtab_insert(h, key, levdatum);
+	rc = symtab_insert(s, key, levdatum);
 	if (rc)
 		goto bad;
 	return 0;
@@ -1578,7 +1610,7 @@ bad:
 	return rc;
 }
 
-static int cat_read(struct policydb *p, struct hashtab *h, void *fp)
+static int cat_read(struct policydb *p, struct symtab *s, void *fp)
 {
 	char *key = NULL;
 	struct cat_datum *catdatum;
@@ -1602,7 +1634,7 @@ static int cat_read(struct policydb *p, struct hashtab *h, void *fp)
 	if (rc)
 		goto bad;
 
-	rc = hashtab_insert(h, key, catdatum);
+	rc = symtab_insert(s, key, catdatum);
 	if (rc)
 		goto bad;
 	return 0;
@@ -1611,7 +1643,7 @@ bad:
 	return rc;
 }
 
-static int (*read_f[SYM_NUM]) (struct policydb *p, struct hashtab *h, void *fp) =
+static int (*read_f[SYM_NUM]) (struct policydb *p, struct symtab *s, void *fp) =
 {
 	common_read,
 	class_read,
@@ -1751,7 +1783,7 @@ u16 string_to_security_class(struct policydb *p, const char *name)
 {
 	struct class_datum *cladatum;
 
-	cladatum = hashtab_search(&p->p_classes.table, name);
+	cladatum = symtab_search(&p->p_classes, name);
 	if (!cladatum)
 		return 0;
 
@@ -1770,9 +1802,9 @@ u32 string_to_av_perm(struct policydb *p, u16 tclass, const char *name)
 	cladatum = p->class_val_to_struct[tclass-1];
 	comdatum = cladatum->comdatum;
 	if (comdatum)
-		perdatum = hashtab_search(&comdatum->permissions.table, name);
+		perdatum = symtab_search(&comdatum->permissions, name);
 	if (!perdatum)
-		perdatum = hashtab_search(&cladatum->permissions.table, name);
+		perdatum = symtab_search(&cladatum->permissions, name);
 	if (!perdatum)
 		return 0;
 
@@ -1796,7 +1828,7 @@ static int range_read(struct policydb *p, void *fp)
 
 	nel = le32_to_cpu(buf[0]);
 
-	rc = hashtab_init(&p->range_tr, rangetr_hash, rangetr_cmp, nel);
+	rc = hashtab_init(&p->range_tr, nel);
 	if (rc)
 		return rc;
 
@@ -1841,7 +1873,7 @@ static int range_read(struct policydb *p, void *fp)
 			goto out;
 		}
 
-		rc = hashtab_insert(&p->range_tr, rt, r);
+		rc = hashtab_insert(&p->range_tr, rt, r, rangetr_key_params);
 		if (rc)
 			goto out;
 
@@ -1888,7 +1920,7 @@ static int filename_trans_read_helper_compat(struct policydb *p, void *fp)
 	otype = le32_to_cpu(buf[3]);
 
 	last = NULL;
-	datum = hashtab_search(&p->filename_trans, &key);
+	datum = hashtab_search(&p->filename_trans, &key, filenametr_key_params);
 	while (datum) {
 		if (unlikely(ebitmap_get_bit(&datum->stypes, stype - 1))) {
 			/* conflicting/duplicate rules are ignored */
@@ -1918,7 +1950,8 @@ static int filename_trans_read_helper_compat(struct policydb *p, void *fp)
 			if (!ft)
 				goto out;
 
-			rc = hashtab_insert(&p->filename_trans, ft, datum);
+			rc = hashtab_insert(&p->filename_trans, ft, datum,
+					    filenametr_key_params);
 			if (rc)
 				goto out;
 			name = NULL;
@@ -2006,7 +2039,8 @@ static int filename_trans_read_helper(struct policydb *p, void *fp)
 	ft->tclass = tclass;
 	ft->name = name;
 
-	rc = hashtab_insert(&p->filename_trans, ft, first);
+	rc = hashtab_insert(&p->filename_trans, ft, first,
+			    filenametr_key_params);
 	if (rc == -EEXIST)
 		pr_err("SELinux:  Duplicate filename transition key\n");
 	if (rc)
@@ -2044,8 +2078,7 @@ static int filename_trans_read(struct policydb *p, void *fp)
 	if (p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
 		p->compat_filename_trans_count = nel;
 
-		rc = hashtab_init(&p->filename_trans, filenametr_hash,
-				  filenametr_cmp, (1 << 11));
+		rc = hashtab_init(&p->filename_trans, (1 << 11));
 		if (rc)
 			return rc;
 
@@ -2055,8 +2088,7 @@ static int filename_trans_read(struct policydb *p, void *fp)
 				return rc;
 		}
 	} else {
-		rc = hashtab_init(&p->filename_trans, filenametr_hash,
-				  filenametr_cmp, nel);
+		rc = hashtab_init(&p->filename_trans, nel);
 		if (rc)
 			return rc;
 
@@ -2509,7 +2541,7 @@ int policydb_read(struct policydb *p, void *fp)
 		}
 
 		for (j = 0; j < nel; j++) {
-			rc = read_f[i](p, &p->symtab[i].table, fp);
+			rc = read_f[i](p, &p->symtab[i], fp);
 			if (rc)
 				goto bad;
 		}
@@ -2537,7 +2569,7 @@ int policydb_read(struct policydb *p, void *fp)
 		goto bad;
 	nel = le32_to_cpu(buf[0]);
 
-	rc = hashtab_init(&p->role_tr, role_trans_hash, role_trans_cmp, nel);
+	rc = hashtab_init(&p->role_tr, nel);
 	if (rc)
 		goto bad;
 	for (i = 0; i < nel; i++) {
@@ -2574,7 +2606,7 @@ int policydb_read(struct policydb *p, void *fp)
 		    !policydb_role_isvalid(p, rtd->new_role))
 			goto bad;
 
-		rc = hashtab_insert(&p->role_tr, rtk, rtd);
+		rc = hashtab_insert(&p->role_tr, rtk, rtd, roletr_key_params);
 		if (rc)
 			goto bad;
 
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 9591c9587cb6..c24d4e1063ea 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -324,6 +324,15 @@ extern int policydb_role_isvalid(struct policydb *p, unsigned int role);
 extern int policydb_read(struct policydb *p, void *fp);
 extern int policydb_write(struct policydb *p, void *fp);
 
+extern struct filename_trans_datum *policydb_filenametr_search(
+	struct policydb *p, struct filename_trans_key *key);
+
+extern struct mls_range *policydb_rangetr_search(
+	struct policydb *p, struct range_trans *key);
+
+extern struct role_trans_datum *policydb_roletr_search(
+	struct policydb *p, struct role_trans_key *key);
+
 #define POLICYDB_CONFIG_MLS    1
 
 /* the config flags related to unknown classes/perms are bits 2 and 3 */
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 313919bd42f8..9e76a80db6e1 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1441,7 +1441,7 @@ static int string_to_context_struct(struct policydb *pol,
 
 	*p++ = 0;
 
-	usrdatum = hashtab_search(&pol->p_users.table, scontextp);
+	usrdatum = symtab_search(&pol->p_users, scontextp);
 	if (!usrdatum)
 		goto out;
 
@@ -1457,7 +1457,7 @@ static int string_to_context_struct(struct policydb *pol,
 
 	*p++ = 0;
 
-	role = hashtab_search(&pol->p_roles.table, scontextp);
+	role = symtab_search(&pol->p_roles, scontextp);
 	if (!role)
 		goto out;
 	ctx->role = role->value;
@@ -1469,7 +1469,7 @@ static int string_to_context_struct(struct policydb *pol,
 	oldc = *p;
 	*p++ = 0;
 
-	typdatum = hashtab_search(&pol->p_types.table, scontextp);
+	typdatum = symtab_search(&pol->p_types, scontextp);
 	if (!typdatum || typdatum->attribute)
 		goto out;
 
@@ -1671,7 +1671,7 @@ static void filename_compute_type(struct policydb *policydb,
 	ft.tclass = tclass;
 	ft.name = objname;
 
-	datum = hashtab_search(&policydb->filename_trans, &ft);
+	datum = policydb_filenametr_search(policydb, &ft);
 	while (datum) {
 		if (ebitmap_get_bit(&datum->stypes, stype - 1)) {
 			newcontext->type = datum->otype;
@@ -1834,7 +1834,7 @@ static int security_compute_sid(struct selinux_state *state,
 			.tclass = tclass,
 		};
 
-		rtd = hashtab_search(&policydb->role_tr, &rtk);
+		rtd = policydb_roletr_search(policydb, &rtk);
 		if (rtd)
 			newcontext.role = rtd->new_role;
 	}
@@ -2024,26 +2024,26 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
 
 	/* Convert the user. */
 	rc = -EINVAL;
-	usrdatum = hashtab_search(&args->newp->p_users.table,
-				  sym_name(args->oldp,
-					   SYM_USERS, oldc->user - 1));
+	usrdatum = symtab_search(&args->newp->p_users,
+				 sym_name(args->oldp,
+					  SYM_USERS, oldc->user - 1));
 	if (!usrdatum)
 		goto bad;
 	newc->user = usrdatum->value;
 
 	/* Convert the role. */
 	rc = -EINVAL;
-	role = hashtab_search(&args->newp->p_roles.table,
-			      sym_name(args->oldp, SYM_ROLES, oldc->role - 1));
+	role = symtab_search(&args->newp->p_roles,
+			     sym_name(args->oldp, SYM_ROLES, oldc->role - 1));
 	if (!role)
 		goto bad;
 	newc->role = role->value;
 
 	/* Convert the type. */
 	rc = -EINVAL;
-	typdatum = hashtab_search(&args->newp->p_types.table,
-				  sym_name(args->oldp,
-					   SYM_TYPES, oldc->type - 1));
+	typdatum = symtab_search(&args->newp->p_types,
+				 sym_name(args->oldp,
+					  SYM_TYPES, oldc->type - 1));
 	if (!typdatum)
 		goto bad;
 	newc->type = typdatum->value;
@@ -2623,7 +2623,7 @@ int security_get_user_sids(struct selinux_state *state,
 		goto out_unlock;
 
 	rc = -EINVAL;
-	user = hashtab_search(&policydb->p_users.table, username);
+	user = symtab_search(&policydb->p_users, username);
 	if (!user)
 		goto out_unlock;
 
@@ -2975,7 +2975,7 @@ static int security_preserve_bools(struct selinux_state *state,
 	if (rc)
 		goto out;
 	for (i = 0; i < nbools; i++) {
-		booldatum = hashtab_search(&policydb->p_bools.table, bnames[i]);
+		booldatum = symtab_search(&policydb->p_bools, bnames[i]);
 		if (booldatum)
 			booldatum->state = bvalues[i];
 	}
@@ -3226,7 +3226,7 @@ int security_get_permissions(struct selinux_state *state,
 	read_lock(&state->ss->policy_rwlock);
 
 	rc = -EINVAL;
-	match = hashtab_search(&policydb->p_classes.table, class);
+	match = symtab_search(&policydb->p_classes, class);
 	if (!match) {
 		pr_err("SELinux: %s:  unrecognized class %s\n",
 			__func__, class);
@@ -3365,7 +3365,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 	case AUDIT_SUBJ_USER:
 	case AUDIT_OBJ_USER:
 		rc = -EINVAL;
-		userdatum = hashtab_search(&policydb->p_users.table, rulestr);
+		userdatum = symtab_search(&policydb->p_users, rulestr);
 		if (!userdatum)
 			goto out;
 		tmprule->au_ctxt.user = userdatum->value;
@@ -3373,7 +3373,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 	case AUDIT_SUBJ_ROLE:
 	case AUDIT_OBJ_ROLE:
 		rc = -EINVAL;
-		roledatum = hashtab_search(&policydb->p_roles.table, rulestr);
+		roledatum = symtab_search(&policydb->p_roles, rulestr);
 		if (!roledatum)
 			goto out;
 		tmprule->au_ctxt.role = roledatum->value;
@@ -3381,7 +3381,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 	case AUDIT_SUBJ_TYPE:
 	case AUDIT_OBJ_TYPE:
 		rc = -EINVAL;
-		typedatum = hashtab_search(&policydb->p_types.table, rulestr);
+		typedatum = symtab_search(&policydb->p_types, rulestr);
 		if (!typedatum)
 			goto out;
 		tmprule->au_ctxt.type = typedatum->value;
diff --git a/security/selinux/ss/symtab.c b/security/selinux/ss/symtab.c
index 92d7a948070e..baf22f3b4985 100644
--- a/security/selinux/ss/symtab.c
+++ b/security/selinux/ss/symtab.c
@@ -9,7 +9,7 @@
 #include <linux/errno.h>
 #include "symtab.h"
 
-static unsigned int symhash(struct hashtab *h, const void *key)
+static unsigned int symhash(const void *key)
 {
 	const char *p, *keyp;
 	unsigned int size;
@@ -20,10 +20,10 @@ static unsigned int symhash(struct hashtab *h, const void *key)
 	size = strlen(keyp);
 	for (p = keyp; (p - keyp) < size; p++)
 		val = (val << 4 | (val >> (8*sizeof(unsigned int)-4))) ^ (*p);
-	return val & (h->size - 1);
+	return val;
 }
 
-static int symcmp(struct hashtab *h, const void *key1, const void *key2)
+static int symcmp(const void *key1, const void *key2)
 {
 	const char *keyp1, *keyp2;
 
@@ -32,10 +32,24 @@ static int symcmp(struct hashtab *h, const void *key1, const void *key2)
 	return strcmp(keyp1, keyp2);
 }
 
+static const struct hashtab_key_params symtab_key_params = {
+	.hash = symhash,
+	.cmp = symcmp,
+};
 
 int symtab_init(struct symtab *s, unsigned int size)
 {
 	s->nprim = 0;
-	return hashtab_init(&s->table, symhash, symcmp, size);
+	return hashtab_init(&s->table, size);
+}
+
+int symtab_insert(struct symtab *s, void *k, void *d)
+{
+	return hashtab_insert(&s->table, k, d, symtab_key_params);
+}
+
+void *symtab_search(struct symtab *s, const char *name)
+{
+	return hashtab_search(&s->table, name, symtab_key_params);
 }
 
diff --git a/security/selinux/ss/symtab.h b/security/selinux/ss/symtab.h
index f145301b9d9f..b0e9132c7f05 100644
--- a/security/selinux/ss/symtab.h
+++ b/security/selinux/ss/symtab.h
@@ -19,6 +19,9 @@ struct symtab {
 
 int symtab_init(struct symtab *s, unsigned int size);
 
+int symtab_insert(struct symtab *s, void *k, void *d);
+void *symtab_search(struct symtab *s, const char *name);
+
 #endif	/* _SS_SYMTAB_H_ */
 
 
-- 
2.25.4

