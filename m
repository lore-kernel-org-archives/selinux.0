Return-Path: <SRS0=yj3S=6M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762FCC83000
	for <selinux@archiver.kernel.org>; Tue, 28 Apr 2020 12:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 499B5206D9
	for <selinux@archiver.kernel.org>; Tue, 28 Apr 2020 12:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pp2QPJqx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgD1Mzb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Apr 2020 08:55:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58064 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726827AbgD1Mza (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Apr 2020 08:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588078527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7azsmp36MW/4DinrlTklX0QbrOx8NszgzFIrJa4XrNg=;
        b=Pp2QPJqxl0qbb9W8L8IgWVddXRtp3BUfhIQrndg152ryBzpQ1xFZMCALVE9q64YQLvEbkz
        vRI7F/JkYHGmoBwNDgLPf6dZZ4LinMM5OASpzkW1juZq1BSqUcXomueOzMHSFMYZW/EA1D
        vFmgY8qmIkOe/c8r3NP1xPlHlPvVSog=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-7xmcpsTONXaqQQ4XAkp7Cw-1; Tue, 28 Apr 2020 08:55:24 -0400
X-MC-Unique: 7xmcpsTONXaqQQ4XAkp7Cw-1
Received: by mail-wm1-f72.google.com with SMTP id u11so791943wmc.7
        for <selinux@vger.kernel.org>; Tue, 28 Apr 2020 05:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7azsmp36MW/4DinrlTklX0QbrOx8NszgzFIrJa4XrNg=;
        b=VPe3wkPDaUusFShg0Qrx8hxiAZncI+LUQyu9I4gZaIK/ZKfyja1lFV8LofGXze5BYh
         Qb6Br2OqwJdpaGH2WtQZeOZW2mXhrzeO5MEgZeaMy46qNk3bMRFiifCawzlVbTeHKk8W
         V9K2TemFnADeXOUbVIa6vTeOfeICPYIMDr5B8Lvrz0e9g+YfX83aWXk4Bh2qvWrIr5ab
         +6olzRGTrTB56NYcWBgknCcWCVrxB5VlVzMc0KC7QMMqbRjKI8x94o2YnIG2b0/WdltS
         Gb+EpUg5XbGPeDY37fTkx0f3vPopfQA9DDyURNtSX+t3WVnOghDFVjqJOf7lmR0lrumn
         wxRg==
X-Gm-Message-State: AGi0PuachsqoK+KQtLIkY2UcUoG5BfSGhOBBqbU1DCDFKxIYQCl2iRxh
        xRpi8+bLM5pAyu3SOdJBe9cseHD8vxglnG32NF92lObzHprjy6oXHNBFPquylUiqx4u2eoICiZY
        hZ8epKEEZvu4ZchzS2w==
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr4399985wmh.120.1588078521951;
        Tue, 28 Apr 2020 05:55:21 -0700 (PDT)
X-Google-Smtp-Source: APiQypILFrJqueay0P+E7xRq+Mfs+ybb3S44MB1vXjdVFRAXCxY5okuZO3mVgMlE+BL4k/wo4ArLKQ==
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr4399933wmh.120.1588078521243;
        Tue, 28 Apr 2020 05:55:21 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id y63sm3082438wmg.21.2020.04.28.05.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 05:55:20 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 2/4] selinux: do not allocate hashtabs dynamically
Date:   Tue, 28 Apr 2020 14:55:12 +0200
Message-Id: <20200428125514.2780171-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200428125514.2780171-1-omosnace@redhat.com>
References: <20200428125514.2780171-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It is simpler to allocate them statically in the corresponding
structure, avoiding unnecessary kmalloc() calls and pointer
dereferencing.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/hashtab.c  |  51 ++++---------
 security/selinux/ss/hashtab.h  |  13 ++--
 security/selinux/ss/mls.c      |  14 ++--
 security/selinux/ss/policydb.c | 126 ++++++++++++++++-----------------
 security/selinux/ss/policydb.h |   6 +-
 security/selinux/ss/services.c |  44 ++++++------
 security/selinux/ss/symtab.c   |   5 +-
 security/selinux/ss/symtab.h   |   2 +-
 8 files changed, 116 insertions(+), 145 deletions(-)

diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index 883f19d32c28..5ee868116d70 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -29,34 +29,21 @@ static u32 hashtab_compute_size(u32 nel)
 	return nel == 0 ? 0 : roundup_pow_of_two(nel);
 }
 
-struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, const void *key),
-			       int (*keycmp)(struct hashtab *h, const void *key1, const void *key2),
-			       u32 nel_hint)
+int hashtab_init(struct hashtab *h,
+		 u32 (*hash_value)(struct hashtab *h, const void *key),
+		 int (*keycmp)(struct hashtab *h, const void *key1,
+			       const void *key2),
+		 u32 nel_hint)
 {
-	struct hashtab *p;
-	u32 i, size = hashtab_compute_size(nel_hint);
-
-	p = kzalloc(sizeof(*p), GFP_KERNEL);
-	if (!p)
-		return p;
-
-	p->size = size;
-	p->nel = 0;
-	p->hash_value = hash_value;
-	p->keycmp = keycmp;
-	if (!size)
-		return p;
-
-	p->htable = kmalloc_array(size, sizeof(*p->htable), GFP_KERNEL);
-	if (!p->htable) {
-		kfree(p);
-		return NULL;
-	}
-
-	for (i = 0; i < size; i++)
-		p->htable[i] = NULL;
+	h->size = hashtab_compute_size(nel_hint);
+	h->nel = 0;
+	h->hash_value = hash_value;
+	h->keycmp = keycmp;
+	if (!h->size)
+		return 0;
 
-	return p;
+	h->htable = kcalloc(h->size, sizeof(*h->htable), GFP_KERNEL);
+	return h->htable ? 0 : -ENOMEM;
 }
 
 int hashtab_insert(struct hashtab *h, void *key, void *datum)
@@ -66,7 +53,7 @@ int hashtab_insert(struct hashtab *h, void *key, void *datum)
 
 	cond_resched();
 
-	if (!h || !h->size || h->nel == HASHTAB_MAX_NODES)
+	if (!h->size || h->nel == HASHTAB_MAX_NODES)
 		return -EINVAL;
 
 	hvalue = h->hash_value(h, key);
@@ -102,7 +89,7 @@ void *hashtab_search(struct hashtab *h, const void *key)
 	u32 hvalue;
 	struct hashtab_node *cur;
 
-	if (!h || !h->size)
+	if (!h->size)
 		return NULL;
 
 	hvalue = h->hash_value(h, key);
@@ -121,9 +108,6 @@ void hashtab_destroy(struct hashtab *h)
 	u32 i;
 	struct hashtab_node *cur, *temp;
 
-	if (!h)
-		return;
-
 	for (i = 0; i < h->size; i++) {
 		cur = h->htable[i];
 		while (cur) {
@@ -136,8 +120,6 @@ void hashtab_destroy(struct hashtab *h)
 
 	kfree(h->htable);
 	h->htable = NULL;
-
-	kfree(h);
 }
 
 int hashtab_map(struct hashtab *h,
@@ -148,9 +130,6 @@ int hashtab_map(struct hashtab *h,
 	int ret;
 	struct hashtab_node *cur;
 
-	if (!h)
-		return 0;
-
 	for (i = 0; i < h->size; i++) {
 		cur = h->htable[i];
 		while (cur) {
diff --git a/security/selinux/ss/hashtab.h b/security/selinux/ss/hashtab.h
index dde54d9ff01c..31c11511fe10 100644
--- a/security/selinux/ss/hashtab.h
+++ b/security/selinux/ss/hashtab.h
@@ -35,14 +35,15 @@ struct hashtab_info {
 };
 
 /*
- * Creates a new hash table with the specified characteristics.
+ * Initializes a new hash table with the specified characteristics.
  *
- * Returns NULL if insufficent space is available or
- * the new hash table otherwise.
+ * Returns -ENOMEM if insufficient space is available or 0 otherwise.
  */
-struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, const void *key),
-			       int (*keycmp)(struct hashtab *h, const void *key1, const void *key2),
-			       u32 nel_hint);
+int hashtab_init(struct hashtab *h,
+		 u32 (*hash_value)(struct hashtab *h, const void *key),
+		 int (*keycmp)(struct hashtab *h, const void *key1,
+			       const void *key2),
+		 u32 nel_hint);
 
 /*
  * Inserts the specified (key, datum) pair into the specified hash table.
diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index 6a5d7d08933d..cd8734f25b39 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -165,7 +165,7 @@ int mls_level_isvalid(struct policydb *p, struct mls_level *l)
 
 	if (!l->sens || l->sens > p->p_levels.nprim)
 		return 0;
-	levdatum = hashtab_search(p->p_levels.table,
+	levdatum = hashtab_search(&p->p_levels.table,
 				  sym_name(p, SYM_LEVELS, l->sens - 1));
 	if (!levdatum)
 		return 0;
@@ -293,7 +293,7 @@ int mls_context_to_sid(struct policydb *pol,
 			*(next_cat++) = '\0';
 
 		/* Parse sensitivity. */
-		levdatum = hashtab_search(pol->p_levels.table, sensitivity);
+		levdatum = hashtab_search(&pol->p_levels.table, sensitivity);
 		if (!levdatum)
 			return -EINVAL;
 		context->range.level[l].sens = levdatum->level->sens;
@@ -312,7 +312,7 @@ int mls_context_to_sid(struct policydb *pol,
 				*rngptr++ = '\0';
 			}
 
-			catdatum = hashtab_search(pol->p_cats.table, cur_cat);
+			catdatum = hashtab_search(&pol->p_cats.table, cur_cat);
 			if (!catdatum)
 				return -EINVAL;
 
@@ -325,7 +325,7 @@ int mls_context_to_sid(struct policydb *pol,
 			if (rngptr == NULL)
 				continue;
 
-			rngdatum = hashtab_search(pol->p_cats.table, rngptr);
+			rngdatum = hashtab_search(&pol->p_cats.table, rngptr);
 			if (!rngdatum)
 				return -EINVAL;
 
@@ -458,7 +458,7 @@ int mls_convert_context(struct policydb *oldp,
 		return 0;
 
 	for (l = 0; l < 2; l++) {
-		levdatum = hashtab_search(newp->p_levels.table,
+		levdatum = hashtab_search(&newp->p_levels.table,
 					  sym_name(oldp, SYM_LEVELS,
 						   oldc->range.level[l].sens - 1));
 
@@ -470,7 +470,7 @@ int mls_convert_context(struct policydb *oldp,
 					      node, i) {
 			int rc;
 
-			catdatum = hashtab_search(newp->p_cats.table,
+			catdatum = hashtab_search(&newp->p_cats.table,
 						  sym_name(oldp, SYM_CATS, i));
 			if (!catdatum)
 				return -EINVAL;
@@ -506,7 +506,7 @@ int mls_compute_sid(struct policydb *p,
 		rtr.source_type = scontext->type;
 		rtr.target_type = tcontext->type;
 		rtr.target_class = tclass;
-		r = hashtab_search(p->range_tr, &rtr);
+		r = hashtab_search(&p->range_tr, &rtr);
 		if (r)
 			return mls_range_set(newcontext, r);
 
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 39cfe9df360c..3c346d5d6faa 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -195,8 +195,8 @@ static int common_destroy(void *key, void *datum, void *p)
 	kfree(key);
 	if (datum) {
 		comdatum = datum;
-		hashtab_map(comdatum->permissions.table, perm_destroy, NULL);
-		hashtab_destroy(comdatum->permissions.table);
+		hashtab_map(&comdatum->permissions.table, perm_destroy, NULL);
+		hashtab_destroy(&comdatum->permissions.table);
 	}
 	kfree(datum);
 	return 0;
@@ -224,8 +224,8 @@ static int cls_destroy(void *key, void *datum, void *p)
 	kfree(key);
 	if (datum) {
 		cladatum = datum;
-		hashtab_map(cladatum->permissions.table, perm_destroy, NULL);
-		hashtab_destroy(cladatum->permissions.table);
+		hashtab_map(&cladatum->permissions.table, perm_destroy, NULL);
+		hashtab_destroy(&cladatum->permissions.table);
 		constraint = cladatum->constraints;
 		while (constraint) {
 			e = constraint->expr;
@@ -400,7 +400,7 @@ static int roles_init(struct policydb *p)
 	if (!key)
 		goto out;
 
-	rc = hashtab_insert(p->p_roles.table, key, role);
+	rc = hashtab_insert(&p->p_roles.table, key, role);
 	if (rc)
 		goto out;
 
@@ -668,7 +668,7 @@ static void symtab_hash_eval(struct symtab *s)
 	int i;
 
 	for (i = 0; i < SYM_NUM; i++)
-		hash_eval(s[i].table, symtab_name[i]);
+		hash_eval(&s[i].table, symtab_name[i]);
 }
 
 #else
@@ -739,7 +739,7 @@ static int policydb_index(struct policydb *p)
 		if (!p->sym_val_to_name[i])
 			return -ENOMEM;
 
-		rc = hashtab_map(p->symtab[i].table, index_f[i], p);
+		rc = hashtab_map(&p->symtab[i].table, index_f[i], p);
 		if (rc)
 			goto out;
 	}
@@ -760,8 +760,8 @@ void policydb_destroy(struct policydb *p)
 
 	for (i = 0; i < SYM_NUM; i++) {
 		cond_resched();
-		hashtab_map(p->symtab[i].table, destroy_f[i], NULL);
-		hashtab_destroy(p->symtab[i].table);
+		hashtab_map(&p->symtab[i].table, destroy_f[i], NULL);
+		hashtab_destroy(&p->symtab[i].table);
 	}
 
 	for (i = 0; i < SYM_NUM; i++)
@@ -803,8 +803,8 @@ void policydb_destroy(struct policydb *p)
 
 	cond_policydb_destroy(p);
 
-	hashtab_map(p->role_tr, role_tr_destroy, NULL);
-	hashtab_destroy(p->role_tr);
+	hashtab_map(&p->role_tr, role_tr_destroy, NULL);
+	hashtab_destroy(&p->role_tr);
 
 	for (ra = p->role_allow; ra; ra = ra->next) {
 		cond_resched();
@@ -813,11 +813,11 @@ void policydb_destroy(struct policydb *p)
 	}
 	kfree(lra);
 
-	hashtab_map(p->filename_trans, filenametr_destroy, NULL);
-	hashtab_destroy(p->filename_trans);
+	hashtab_map(&p->filename_trans, filenametr_destroy, NULL);
+	hashtab_destroy(&p->filename_trans);
 
-	hashtab_map(p->range_tr, range_tr_destroy, NULL);
-	hashtab_destroy(p->range_tr);
+	hashtab_map(&p->range_tr, range_tr_destroy, NULL);
+	hashtab_destroy(&p->range_tr);
 
 	if (p->type_attr_map_array) {
 		for (i = 0; i < p->p_types.nprim; i++)
@@ -1128,7 +1128,7 @@ static int common_read(struct policydb *p, struct hashtab *h, void *fp)
 		goto bad;
 
 	for (i = 0; i < nel; i++) {
-		rc = perm_read(p, comdatum->permissions.table, fp);
+		rc = perm_read(p, &comdatum->permissions.table, fp);
 		if (rc)
 			goto bad;
 	}
@@ -1300,7 +1300,8 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
 			goto bad;
 
 		rc = -EINVAL;
-		cladatum->comdatum = hashtab_search(p->p_commons.table, cladatum->comkey);
+		cladatum->comdatum = hashtab_search(&p->p_commons.table,
+						    cladatum->comkey);
 		if (!cladatum->comdatum) {
 			pr_err("SELinux:  unknown common %s\n",
 			       cladatum->comkey);
@@ -1308,7 +1309,7 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
 		}
 	}
 	for (i = 0; i < nel; i++) {
-		rc = perm_read(p, cladatum->permissions.table, fp);
+		rc = perm_read(p, &cladatum->permissions.table, fp);
 		if (rc)
 			goto bad;
 	}
@@ -1731,18 +1732,15 @@ static int policydb_bounds_sanity_check(struct policydb *p)
 	if (p->policyvers < POLICYDB_VERSION_BOUNDARY)
 		return 0;
 
-	rc = hashtab_map(p->p_users.table,
-			 user_bounds_sanity_check, p);
+	rc = hashtab_map(&p->p_users.table, user_bounds_sanity_check, p);
 	if (rc)
 		return rc;
 
-	rc = hashtab_map(p->p_roles.table,
-			 role_bounds_sanity_check, p);
+	rc = hashtab_map(&p->p_roles.table, role_bounds_sanity_check, p);
 	if (rc)
 		return rc;
 
-	rc = hashtab_map(p->p_types.table,
-			 type_bounds_sanity_check, p);
+	rc = hashtab_map(&p->p_types.table, type_bounds_sanity_check, p);
 	if (rc)
 		return rc;
 
@@ -1753,7 +1751,7 @@ u16 string_to_security_class(struct policydb *p, const char *name)
 {
 	struct class_datum *cladatum;
 
-	cladatum = hashtab_search(p->p_classes.table, name);
+	cladatum = hashtab_search(&p->p_classes.table, name);
 	if (!cladatum)
 		return 0;
 
@@ -1772,11 +1770,9 @@ u32 string_to_av_perm(struct policydb *p, u16 tclass, const char *name)
 	cladatum = p->class_val_to_struct[tclass-1];
 	comdatum = cladatum->comdatum;
 	if (comdatum)
-		perdatum = hashtab_search(comdatum->permissions.table,
-					  name);
+		perdatum = hashtab_search(&comdatum->permissions.table, name);
 	if (!perdatum)
-		perdatum = hashtab_search(cladatum->permissions.table,
-					  name);
+		perdatum = hashtab_search(&cladatum->permissions.table, name);
 	if (!perdatum)
 		return 0;
 
@@ -1800,9 +1796,9 @@ static int range_read(struct policydb *p, void *fp)
 
 	nel = le32_to_cpu(buf[0]);
 
-	p->range_tr = hashtab_create(rangetr_hash, rangetr_cmp, nel);
-	if (!p->range_tr)
-		return -ENOMEM;
+	rc = hashtab_init(&p->range_tr, rangetr_hash, rangetr_cmp, nel);
+	if (rc)
+		return rc;
 
 	for (i = 0; i < nel; i++) {
 		rc = -ENOMEM;
@@ -1845,14 +1841,14 @@ static int range_read(struct policydb *p, void *fp)
 			goto out;
 		}
 
-		rc = hashtab_insert(p->range_tr, rt, r);
+		rc = hashtab_insert(&p->range_tr, rt, r);
 		if (rc)
 			goto out;
 
 		rt = NULL;
 		r = NULL;
 	}
-	hash_eval(p->range_tr, "rangetr");
+	hash_eval(&p->range_tr, "rangetr");
 	rc = 0;
 out:
 	kfree(rt);
@@ -1892,7 +1888,7 @@ static int filename_trans_read_helper_compat(struct policydb *p, void *fp)
 	otype = le32_to_cpu(buf[3]);
 
 	last = NULL;
-	datum = hashtab_search(p->filename_trans, &key);
+	datum = hashtab_search(&p->filename_trans, &key);
 	while (datum) {
 		if (unlikely(ebitmap_get_bit(&datum->stypes, stype - 1))) {
 			/* conflicting/duplicate rules are ignored */
@@ -1922,7 +1918,7 @@ static int filename_trans_read_helper_compat(struct policydb *p, void *fp)
 			if (!ft)
 				goto out;
 
-			rc = hashtab_insert(p->filename_trans, ft, datum);
+			rc = hashtab_insert(&p->filename_trans, ft, datum);
 			if (rc)
 				goto out;
 			name = NULL;
@@ -2010,7 +2006,7 @@ static int filename_trans_read_helper(struct policydb *p, void *fp)
 	ft->tclass = tclass;
 	ft->name = name;
 
-	rc = hashtab_insert(p->filename_trans, ft, first);
+	rc = hashtab_insert(&p->filename_trans, ft, first);
 	if (rc == -EEXIST)
 		pr_err("SELinux:  Duplicate filename transition key\n");
 	if (rc)
@@ -2047,10 +2043,11 @@ static int filename_trans_read(struct policydb *p, void *fp)
 
 	if (p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
 		p->compat_filename_trans_count = nel;
-		p->filename_trans = hashtab_create(filenametr_hash,
-						   filenametr_cmp, (1 << 11));
-		if (!p->filename_trans)
-			return -ENOMEM;
+
+		rc = hashtab_init(&p->filename_trans, filenametr_hash,
+				  filenametr_cmp, (1 << 11));
+		if (rc)
+			return rc;
 
 		for (i = 0; i < nel; i++) {
 			rc = filename_trans_read_helper_compat(p, fp);
@@ -2058,10 +2055,10 @@ static int filename_trans_read(struct policydb *p, void *fp)
 				return rc;
 		}
 	} else {
-		p->filename_trans = hashtab_create(filenametr_hash,
-						   filenametr_cmp, nel);
-		if (!p->filename_trans)
-			return -ENOMEM;
+		rc = hashtab_init(&p->filename_trans, filenametr_hash,
+				  filenametr_cmp, nel);
+		if (rc)
+			return rc;
 
 		for (i = 0; i < nel; i++) {
 			rc = filename_trans_read_helper(p, fp);
@@ -2069,7 +2066,7 @@ static int filename_trans_read(struct policydb *p, void *fp)
 				return rc;
 		}
 	}
-	hash_eval(p->filename_trans, "filenametr");
+	hash_eval(&p->filename_trans, "filenametr");
 	return 0;
 }
 
@@ -2512,7 +2509,7 @@ int policydb_read(struct policydb *p, void *fp)
 		}
 
 		for (j = 0; j < nel; j++) {
-			rc = read_f[i](p, p->symtab[i].table, fp);
+			rc = read_f[i](p, &p->symtab[i].table, fp);
 			if (rc)
 				goto bad;
 		}
@@ -2540,8 +2537,8 @@ int policydb_read(struct policydb *p, void *fp)
 		goto bad;
 	nel = le32_to_cpu(buf[0]);
 
-	p->role_tr = hashtab_create(role_trans_hash, role_trans_cmp, nel);
-	if (!p->role_tr)
+	rc = hashtab_init(&p->role_tr, role_trans_hash, role_trans_cmp, nel);
+	if (rc)
 		goto bad;
 	for (i = 0; i < nel; i++) {
 		rc = -ENOMEM;
@@ -2577,7 +2574,7 @@ int policydb_read(struct policydb *p, void *fp)
 		    !policydb_role_isvalid(p, rtd->new_role))
 			goto bad;
 
-		rc = hashtab_insert(p->role_tr, rtk, rtd);
+		rc = hashtab_insert(&p->role_tr, rtk, rtd);
 		if (rc)
 			goto bad;
 
@@ -2820,12 +2817,12 @@ static int role_trans_write(struct policydb *p, void *fp)
 	__le32 buf[1];
 	int rc;
 
-	buf[0] = cpu_to_le32(p->role_tr->nel);
+	buf[0] = cpu_to_le32(p->role_tr.nel);
 	rc = put_entry(buf, sizeof(u32), 1, fp);
 	if (rc)
 		return rc;
 
-	return hashtab_map(p->role_tr, role_trans_write_one, &pd);
+	return hashtab_map(&p->role_tr, role_trans_write_one, &pd);
 }
 
 static int role_allow_write(struct role_allow *r, void *fp)
@@ -2919,7 +2916,7 @@ static int common_write(void *vkey, void *datum, void *ptr)
 	buf[0] = cpu_to_le32(len);
 	buf[1] = cpu_to_le32(comdatum->value);
 	buf[2] = cpu_to_le32(comdatum->permissions.nprim);
-	buf[3] = cpu_to_le32(comdatum->permissions.table->nel);
+	buf[3] = cpu_to_le32(comdatum->permissions.table.nel);
 	rc = put_entry(buf, sizeof(u32), 4, fp);
 	if (rc)
 		return rc;
@@ -2928,7 +2925,7 @@ static int common_write(void *vkey, void *datum, void *ptr)
 	if (rc)
 		return rc;
 
-	rc = hashtab_map(comdatum->permissions.table, perm_write, fp);
+	rc = hashtab_map(&comdatum->permissions.table, perm_write, fp);
 	if (rc)
 		return rc;
 
@@ -3027,10 +3024,7 @@ static int class_write(void *vkey, void *datum, void *ptr)
 	buf[1] = cpu_to_le32(len2);
 	buf[2] = cpu_to_le32(cladatum->value);
 	buf[3] = cpu_to_le32(cladatum->permissions.nprim);
-	if (cladatum->permissions.table)
-		buf[4] = cpu_to_le32(cladatum->permissions.table->nel);
-	else
-		buf[4] = 0;
+	buf[4] = cpu_to_le32(cladatum->permissions.table.nel);
 	buf[5] = cpu_to_le32(ncons);
 	rc = put_entry(buf, sizeof(u32), 6, fp);
 	if (rc)
@@ -3046,7 +3040,7 @@ static int class_write(void *vkey, void *datum, void *ptr)
 			return rc;
 	}
 
-	rc = hashtab_map(cladatum->permissions.table, perm_write, fp);
+	rc = hashtab_map(&cladatum->permissions.table, perm_write, fp);
 	if (rc)
 		return rc;
 
@@ -3441,13 +3435,13 @@ static int range_write(struct policydb *p, void *fp)
 	pd.p = p;
 	pd.fp = fp;
 
-	buf[0] = cpu_to_le32(p->range_tr->nel);
+	buf[0] = cpu_to_le32(p->range_tr.nel);
 	rc = put_entry(buf, sizeof(u32), 1, fp);
 	if (rc)
 		return rc;
 
 	/* actually write all of the entries */
-	rc = hashtab_map(p->range_tr, range_write_helper, &pd);
+	rc = hashtab_map(&p->range_tr, range_write_helper, &pd);
 	if (rc)
 		return rc;
 
@@ -3554,15 +3548,15 @@ static int filename_trans_write(struct policydb *p, void *fp)
 		if (rc)
 			return rc;
 
-		rc = hashtab_map(p->filename_trans,
+		rc = hashtab_map(&p->filename_trans,
 				 filename_write_helper_compat, fp);
 	} else {
-		buf[0] = cpu_to_le32(p->filename_trans->nel);
+		buf[0] = cpu_to_le32(p->filename_trans.nel);
 		rc = put_entry(buf, sizeof(u32), 1, fp);
 		if (rc)
 			return rc;
 
-		rc = hashtab_map(p->filename_trans, filename_write_helper, fp);
+		rc = hashtab_map(&p->filename_trans, filename_write_helper, fp);
 	}
 	return rc;
 }
@@ -3651,12 +3645,12 @@ int policydb_write(struct policydb *p, void *fp)
 		pd.p = p;
 
 		buf[0] = cpu_to_le32(p->symtab[i].nprim);
-		buf[1] = cpu_to_le32(p->symtab[i].table->nel);
+		buf[1] = cpu_to_le32(p->symtab[i].table.nel);
 
 		rc = put_entry(buf, sizeof(u32), 2, fp);
 		if (rc)
 			return rc;
-		rc = hashtab_map(p->symtab[i].table, write_f[i], &pd);
+		rc = hashtab_map(&p->symtab[i].table, write_f[i], &pd);
 		if (rc)
 			return rc;
 	}
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 35dc6aa7904d..9591c9587cb6 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -263,13 +263,13 @@ struct policydb {
 	struct avtab te_avtab;
 
 	/* role transitions */
-	struct hashtab *role_tr;
+	struct hashtab role_tr;
 
 	/* file transitions with the last path component */
 	/* quickly exclude lookups when parent ttype has no rules */
 	struct ebitmap filename_trans_ttypes;
 	/* actual set of filename_trans rules */
-	struct hashtab *filename_trans;
+	struct hashtab filename_trans;
 	/* only used if policyvers < POLICYDB_VERSION_COMP_FTRANS */
 	u32 compat_filename_trans_count;
 
@@ -294,7 +294,7 @@ struct policydb {
 	struct genfs *genfs;
 
 	/* range transitions table (range_trans_key -> mls_range) */
-	struct hashtab *range_tr;
+	struct hashtab range_tr;
 
 	/* type -> attribute reverse mapping */
 	struct ebitmap *type_attr_map_array;
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index b49a336b1e6e..313919bd42f8 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -482,11 +482,11 @@ static void security_dump_masked_av(struct policydb *policydb,
 
 	/* init permission_names */
 	if (common_dat &&
-	    hashtab_map(common_dat->permissions.table,
+	    hashtab_map(&common_dat->permissions.table,
 			dump_masked_av_helper, permission_names) < 0)
 		goto out;
 
-	if (hashtab_map(tclass_dat->permissions.table,
+	if (hashtab_map(&tclass_dat->permissions.table,
 			dump_masked_av_helper, permission_names) < 0)
 		goto out;
 
@@ -1441,7 +1441,7 @@ static int string_to_context_struct(struct policydb *pol,
 
 	*p++ = 0;
 
-	usrdatum = hashtab_search(pol->p_users.table, scontextp);
+	usrdatum = hashtab_search(&pol->p_users.table, scontextp);
 	if (!usrdatum)
 		goto out;
 
@@ -1457,7 +1457,7 @@ static int string_to_context_struct(struct policydb *pol,
 
 	*p++ = 0;
 
-	role = hashtab_search(pol->p_roles.table, scontextp);
+	role = hashtab_search(&pol->p_roles.table, scontextp);
 	if (!role)
 		goto out;
 	ctx->role = role->value;
@@ -1469,7 +1469,7 @@ static int string_to_context_struct(struct policydb *pol,
 	oldc = *p;
 	*p++ = 0;
 
-	typdatum = hashtab_search(pol->p_types.table, scontextp);
+	typdatum = hashtab_search(&pol->p_types.table, scontextp);
 	if (!typdatum || typdatum->attribute)
 		goto out;
 
@@ -1671,7 +1671,7 @@ static void filename_compute_type(struct policydb *policydb,
 	ft.tclass = tclass;
 	ft.name = objname;
 
-	datum = hashtab_search(policydb->filename_trans, &ft);
+	datum = hashtab_search(&policydb->filename_trans, &ft);
 	while (datum) {
 		if (ebitmap_get_bit(&datum->stypes, stype - 1)) {
 			newcontext->type = datum->otype;
@@ -1834,7 +1834,7 @@ static int security_compute_sid(struct selinux_state *state,
 			.tclass = tclass,
 		};
 
-		rtd = hashtab_search(policydb->role_tr, &rtk);
+		rtd = hashtab_search(&policydb->role_tr, &rtk);
 		if (rtd)
 			newcontext.role = rtd->new_role;
 	}
@@ -2024,7 +2024,7 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
 
 	/* Convert the user. */
 	rc = -EINVAL;
-	usrdatum = hashtab_search(args->newp->p_users.table,
+	usrdatum = hashtab_search(&args->newp->p_users.table,
 				  sym_name(args->oldp,
 					   SYM_USERS, oldc->user - 1));
 	if (!usrdatum)
@@ -2033,7 +2033,7 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
 
 	/* Convert the role. */
 	rc = -EINVAL;
-	role = hashtab_search(args->newp->p_roles.table,
+	role = hashtab_search(&args->newp->p_roles.table,
 			      sym_name(args->oldp, SYM_ROLES, oldc->role - 1));
 	if (!role)
 		goto bad;
@@ -2041,7 +2041,7 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
 
 	/* Convert the type. */
 	rc = -EINVAL;
-	typdatum = hashtab_search(args->newp->p_types.table,
+	typdatum = hashtab_search(&args->newp->p_types.table,
 				  sym_name(args->oldp,
 					   SYM_TYPES, oldc->type - 1));
 	if (!typdatum)
@@ -2623,7 +2623,7 @@ int security_get_user_sids(struct selinux_state *state,
 		goto out_unlock;
 
 	rc = -EINVAL;
-	user = hashtab_search(policydb->p_users.table, username);
+	user = hashtab_search(&policydb->p_users.table, username);
 	if (!user)
 		goto out_unlock;
 
@@ -2975,7 +2975,7 @@ static int security_preserve_bools(struct selinux_state *state,
 	if (rc)
 		goto out;
 	for (i = 0; i < nbools; i++) {
-		booldatum = hashtab_search(policydb->p_bools.table, bnames[i]);
+		booldatum = hashtab_search(&policydb->p_bools.table, bnames[i]);
 		if (booldatum)
 			booldatum->state = bvalues[i];
 	}
@@ -3189,8 +3189,8 @@ int security_get_classes(struct selinux_state *state,
 	if (!*classes)
 		goto out;
 
-	rc = hashtab_map(policydb->p_classes.table, get_classes_callback,
-			*classes);
+	rc = hashtab_map(&policydb->p_classes.table, get_classes_callback,
+			 *classes);
 	if (rc) {
 		int i;
 		for (i = 0; i < *nclasses; i++)
@@ -3226,7 +3226,7 @@ int security_get_permissions(struct selinux_state *state,
 	read_lock(&state->ss->policy_rwlock);
 
 	rc = -EINVAL;
-	match = hashtab_search(policydb->p_classes.table, class);
+	match = hashtab_search(&policydb->p_classes.table, class);
 	if (!match) {
 		pr_err("SELinux: %s:  unrecognized class %s\n",
 			__func__, class);
@@ -3240,14 +3240,14 @@ int security_get_permissions(struct selinux_state *state,
 		goto out;
 
 	if (match->comdatum) {
-		rc = hashtab_map(match->comdatum->permissions.table,
-				get_permissions_callback, *perms);
+		rc = hashtab_map(&match->comdatum->permissions.table,
+				 get_permissions_callback, *perms);
 		if (rc)
 			goto err;
 	}
 
-	rc = hashtab_map(match->permissions.table, get_permissions_callback,
-			*perms);
+	rc = hashtab_map(&match->permissions.table, get_permissions_callback,
+			 *perms);
 	if (rc)
 		goto err;
 
@@ -3365,7 +3365,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 	case AUDIT_SUBJ_USER:
 	case AUDIT_OBJ_USER:
 		rc = -EINVAL;
-		userdatum = hashtab_search(policydb->p_users.table, rulestr);
+		userdatum = hashtab_search(&policydb->p_users.table, rulestr);
 		if (!userdatum)
 			goto out;
 		tmprule->au_ctxt.user = userdatum->value;
@@ -3373,7 +3373,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 	case AUDIT_SUBJ_ROLE:
 	case AUDIT_OBJ_ROLE:
 		rc = -EINVAL;
-		roledatum = hashtab_search(policydb->p_roles.table, rulestr);
+		roledatum = hashtab_search(&policydb->p_roles.table, rulestr);
 		if (!roledatum)
 			goto out;
 		tmprule->au_ctxt.role = roledatum->value;
@@ -3381,7 +3381,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 	case AUDIT_SUBJ_TYPE:
 	case AUDIT_OBJ_TYPE:
 		rc = -EINVAL;
-		typedatum = hashtab_search(policydb->p_types.table, rulestr);
+		typedatum = hashtab_search(&policydb->p_types.table, rulestr);
 		if (!typedatum)
 			goto out;
 		tmprule->au_ctxt.type = typedatum->value;
diff --git a/security/selinux/ss/symtab.c b/security/selinux/ss/symtab.c
index dc2ce94165d3..92d7a948070e 100644
--- a/security/selinux/ss/symtab.c
+++ b/security/selinux/ss/symtab.c
@@ -35,10 +35,7 @@ static int symcmp(struct hashtab *h, const void *key1, const void *key2)
 
 int symtab_init(struct symtab *s, unsigned int size)
 {
-	s->table = hashtab_create(symhash, symcmp, size);
-	if (!s->table)
-		return -ENOMEM;
 	s->nprim = 0;
-	return 0;
+	return hashtab_init(&s->table, symhash, symcmp, size);
 }
 
diff --git a/security/selinux/ss/symtab.h b/security/selinux/ss/symtab.h
index d75fcafe7281..f145301b9d9f 100644
--- a/security/selinux/ss/symtab.h
+++ b/security/selinux/ss/symtab.h
@@ -13,7 +13,7 @@
 #include "hashtab.h"
 
 struct symtab {
-	struct hashtab *table;	/* hash table (keyed on a string) */
+	struct hashtab table;	/* hash table (keyed on a string) */
 	u32 nprim;		/* number of primary names in table */
 };
 
-- 
2.25.4

