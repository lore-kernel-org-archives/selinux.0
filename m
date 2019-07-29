Return-Path: <SRS0=UHz+=V2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A95C7618B
	for <selinux@archiver.kernel.org>; Mon, 29 Jul 2019 08:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3590B20578
	for <selinux@archiver.kernel.org>; Mon, 29 Jul 2019 08:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfG2Il0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Jul 2019 04:41:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46318 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfG2IlZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Jul 2019 04:41:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id z1so60818301wru.13
        for <selinux@vger.kernel.org>; Mon, 29 Jul 2019 01:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QN2DcMjcrDp8kc62F+uPY2zOTB8kcGF199VA9QJT6/w=;
        b=BWkYRzR5IJI4etnwx3c0Lv1MTpVFsp4xsbGqGuWv+fJUmxpuW7gsxKUKgpb4VUg2P/
         eApZAvu8nthm6EJZ82hrqnAeP/B1ggfqXt6e0uDwYEGmNK6u1LRdzCv00eohpk9/Yc/5
         p2Q/UkfmHR/fsDAC+Ehc+kKguk0dszAAbG5W3tUc9XcdpL9joeyg9DC7lmaUExatEkQf
         RAhcX5XgHs7IwTarFMFAmaBKJJn5liJS/arL+4tkay6Ls6AtW0L0Zf5D3R445yhD8HFR
         UufGgpnYi1nSOnc55cP7hrDPcENzdp/KlKgJtg9Xmo5YgNTbPxfE1RMde6fWJU7LUEbe
         mRmA==
X-Gm-Message-State: APjAAAUlOziHTZPG0MJm0vnxa3RVtKXDjmY0nLg+2gS38IIqvCZgYcoT
        mBSk2Gcf7n7xf+2icbAD3KSuRy0Yue797A==
X-Google-Smtp-Source: APXvYqy6D9RbDiZ36fpl7pa01xnQpSpI/ZbDj7Mjz8P7AeHK/qnHXr0Kym6ZKrrpHBAeb2w94eoiUA==
X-Received: by 2002:adf:fd08:: with SMTP id e8mr123126074wrr.147.1564389680814;
        Mon, 29 Jul 2019 01:41:20 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id v5sm70190544wre.50.2019.07.29.01.41.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 01:41:20 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot+fee3a14d4cdf92646287@syzkaller.appspotmail.com
Subject: [PATCH v2 1/3] selinux: policydb - fix memory leak in policydb_init()
Date:   Mon, 29 Jul 2019 10:41:15 +0200
Message-Id: <20190729084117.18677-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729084117.18677-1-omosnace@redhat.com>
References: <20190729084117.18677-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since roles_init() adds some entries to the role hash table, we need to
destroy also its keys/values on error, otherwise we get a memory leak in
the error path.

To avoid a forward declaration and maintain a sane layout, move all the
destroy stuff above policydb_init. No changes are made to the moved code
in this patch. Note that this triggers some pre-existing checkpatch.pl
warnings - these will be fixed in follow-up patches.

Reported-by: syzbot+fee3a14d4cdf92646287@syzkaller.appspotmail.com
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/policydb.c | 976 +++++++++++++++++----------------
 1 file changed, 489 insertions(+), 487 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index daecdfb15a9c..451f2bcd2d83 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -179,664 +179,666 @@ static struct policydb_compat_info *policydb_lookup_compat(int version)
 }
 
 /*
- * Initialize the role table.
+ * The following *_destroy functions are used to
+ * free any memory allocated for each kind of
+ * symbol data in the policy database.
  */
-static int roles_init(struct policydb *p)
+
+static int perm_destroy(void *key, void *datum, void *p)
 {
-	char *key = NULL;
-	int rc;
-	struct role_datum *role;
+	kfree(key);
+	kfree(datum);
+	return 0;
+}
 
-	role = kzalloc(sizeof(*role), GFP_KERNEL);
-	if (!role)
-		return -ENOMEM;
+static int common_destroy(void *key, void *datum, void *p)
+{
+	struct common_datum *comdatum;
 
-	rc = -EINVAL;
-	role->value = ++p->p_roles.nprim;
-	if (role->value != OBJECT_R_VAL)
-		goto out;
+	kfree(key);
+	if (datum) {
+		comdatum = datum;
+		hashtab_map(comdatum->permissions.table, perm_destroy, NULL);
+		hashtab_destroy(comdatum->permissions.table);
+	}
+	kfree(datum);
+	return 0;
+}
 
-	rc = -ENOMEM;
-	key = kstrdup(OBJECT_R, GFP_KERNEL);
-	if (!key)
-		goto out;
+static void constraint_expr_destroy(struct constraint_expr *expr)
+{
+	if (expr) {
+		ebitmap_destroy(&expr->names);
+		if (expr->type_names) {
+			ebitmap_destroy(&expr->type_names->types);
+			ebitmap_destroy(&expr->type_names->negset);
+			kfree(expr->type_names);
+		}
+		kfree(expr);
+	}
+}
 
-	rc = hashtab_insert(p->p_roles.table, key, role);
-	if (rc)
-		goto out;
+static int cls_destroy(void *key, void *datum, void *p)
+{
+	struct class_datum *cladatum;
+	struct constraint_node *constraint, *ctemp;
+	struct constraint_expr *e, *etmp;
 
-	return 0;
-out:
 	kfree(key);
-	kfree(role);
-	return rc;
+	if (datum) {
+		cladatum = datum;
+		hashtab_map(cladatum->permissions.table, perm_destroy, NULL);
+		hashtab_destroy(cladatum->permissions.table);
+		constraint = cladatum->constraints;
+		while (constraint) {
+			e = constraint->expr;
+			while (e) {
+				etmp = e;
+				e = e->next;
+				constraint_expr_destroy(etmp);
+			}
+			ctemp = constraint;
+			constraint = constraint->next;
+			kfree(ctemp);
+		}
+
+		constraint = cladatum->validatetrans;
+		while (constraint) {
+			e = constraint->expr;
+			while (e) {
+				etmp = e;
+				e = e->next;
+				constraint_expr_destroy(etmp);
+			}
+			ctemp = constraint;
+			constraint = constraint->next;
+			kfree(ctemp);
+		}
+		kfree(cladatum->comkey);
+	}
+	kfree(datum);
+	return 0;
 }
 
-static u32 filenametr_hash(struct hashtab *h, const void *k)
+static int role_destroy(void *key, void *datum, void *p)
 {
-	const struct filename_trans *ft = k;
-	unsigned long hash;
-	unsigned int byte_num;
-	unsigned char focus;
-
-	hash = ft->stype ^ ft->ttype ^ ft->tclass;
+	struct role_datum *role;
 
-	byte_num = 0;
-	while ((focus = ft->name[byte_num++]))
-		hash = partial_name_hash(focus, hash);
-	return hash & (h->size - 1);
+	kfree(key);
+	if (datum) {
+		role = datum;
+		ebitmap_destroy(&role->dominates);
+		ebitmap_destroy(&role->types);
+	}
+	kfree(datum);
+	return 0;
 }
 
-static int filenametr_cmp(struct hashtab *h, const void *k1, const void *k2)
+static int type_destroy(void *key, void *datum, void *p)
 {
-	const struct filename_trans *ft1 = k1;
-	const struct filename_trans *ft2 = k2;
-	int v;
-
-	v = ft1->stype - ft2->stype;
-	if (v)
-		return v;
+	kfree(key);
+	kfree(datum);
+	return 0;
+}
 
-	v = ft1->ttype - ft2->ttype;
-	if (v)
-		return v;
+static int user_destroy(void *key, void *datum, void *p)
+{
+	struct user_datum *usrdatum;
 
-	v = ft1->tclass - ft2->tclass;
-	if (v)
-		return v;
+	kfree(key);
+	if (datum) {
+		usrdatum = datum;
+		ebitmap_destroy(&usrdatum->roles);
+		ebitmap_destroy(&usrdatum->range.level[0].cat);
+		ebitmap_destroy(&usrdatum->range.level[1].cat);
+		ebitmap_destroy(&usrdatum->dfltlevel.cat);
+	}
+	kfree(datum);
+	return 0;
+}
 
-	return strcmp(ft1->name, ft2->name);
+static int sens_destroy(void *key, void *datum, void *p)
+{
+	struct level_datum *levdatum;
 
+	kfree(key);
+	if (datum) {
+		levdatum = datum;
+		if (levdatum->level)
+			ebitmap_destroy(&levdatum->level->cat);
+		kfree(levdatum->level);
+	}
+	kfree(datum);
+	return 0;
 }
 
-static u32 rangetr_hash(struct hashtab *h, const void *k)
+static int cat_destroy(void *key, void *datum, void *p)
 {
-	const struct range_trans *key = k;
-	return (key->source_type + (key->target_type << 3) +
-		(key->target_class << 5)) & (h->size - 1);
+	kfree(key);
+	kfree(datum);
+	return 0;
 }
 
-static int rangetr_cmp(struct hashtab *h, const void *k1, const void *k2)
+static int (*destroy_f[SYM_NUM]) (void *key, void *datum, void *datap) =
 {
-	const struct range_trans *key1 = k1, *key2 = k2;
-	int v;
+	common_destroy,
+	cls_destroy,
+	role_destroy,
+	type_destroy,
+	user_destroy,
+	cond_destroy_bool,
+	sens_destroy,
+	cat_destroy,
+};
 
-	v = key1->source_type - key2->source_type;
-	if (v)
-		return v;
+static int filenametr_destroy(void *key, void *datum, void *p)
+{
+	struct filename_trans *ft = key;
+	kfree(ft->name);
+	kfree(key);
+	kfree(datum);
+	cond_resched();
+	return 0;
+}
 
-	v = key1->target_type - key2->target_type;
-	if (v)
-		return v;
+static int range_tr_destroy(void *key, void *datum, void *p)
+{
+	struct mls_range *rt = datum;
+	kfree(key);
+	ebitmap_destroy(&rt->level[0].cat);
+	ebitmap_destroy(&rt->level[1].cat);
+	kfree(datum);
+	cond_resched();
+	return 0;
+}
 
-	v = key1->target_class - key2->target_class;
+static void ocontext_destroy(struct ocontext *c, int i)
+{
+	if (!c)
+		return;
 
-	return v;
+	context_destroy(&c->context[0]);
+	context_destroy(&c->context[1]);
+	if (i == OCON_ISID || i == OCON_FS ||
+	    i == OCON_NETIF || i == OCON_FSUSE)
+		kfree(c->u.name);
+	kfree(c);
 }
 
 /*
- * Initialize a policy database structure.
+ * Free any memory allocated by a policy database structure.
  */
-static int policydb_init(struct policydb *p)
+void policydb_destroy(struct policydb *p)
 {
-	int i, rc;
-
-	memset(p, 0, sizeof(*p));
+	struct ocontext *c, *ctmp;
+	struct genfs *g, *gtmp;
+	int i;
+	struct role_allow *ra, *lra = NULL;
+	struct role_trans *tr, *ltr = NULL;
 
 	for (i = 0; i < SYM_NUM; i++) {
-		rc = symtab_init(&p->symtab[i], symtab_sizes[i]);
-		if (rc)
-			goto out;
+		cond_resched();
+		hashtab_map(p->symtab[i].table, destroy_f[i], NULL);
+		hashtab_destroy(p->symtab[i].table);
 	}
 
-	rc = avtab_init(&p->te_avtab);
-	if (rc)
-		goto out;
+	for (i = 0; i < SYM_NUM; i++)
+		kvfree(p->sym_val_to_name[i]);
 
-	rc = roles_init(p);
-	if (rc)
-		goto out;
+	kfree(p->class_val_to_struct);
+	kfree(p->role_val_to_struct);
+	kfree(p->user_val_to_struct);
+	kvfree(p->type_val_to_struct_array);
 
-	rc = cond_policydb_init(p);
-	if (rc)
-		goto out;
+	avtab_destroy(&p->te_avtab);
 
-	p->filename_trans = hashtab_create(filenametr_hash, filenametr_cmp, (1 << 10));
-	if (!p->filename_trans) {
-		rc = -ENOMEM;
-		goto out;
+	for (i = 0; i < OCON_NUM; i++) {
+		cond_resched();
+		c = p->ocontexts[i];
+		while (c) {
+			ctmp = c;
+			c = c->next;
+			ocontext_destroy(ctmp, i);
+		}
+		p->ocontexts[i] = NULL;
 	}
 
-	p->range_tr = hashtab_create(rangetr_hash, rangetr_cmp, 256);
-	if (!p->range_tr) {
-		rc = -ENOMEM;
-		goto out;
+	g = p->genfs;
+	while (g) {
+		cond_resched();
+		kfree(g->fstype);
+		c = g->head;
+		while (c) {
+			ctmp = c;
+			c = c->next;
+			ocontext_destroy(ctmp, OCON_FSUSE);
+		}
+		gtmp = g;
+		g = g->next;
+		kfree(gtmp);
 	}
+	p->genfs = NULL;
 
-	ebitmap_init(&p->filename_trans_ttypes);
-	ebitmap_init(&p->policycaps);
-	ebitmap_init(&p->permissive_map);
-
-	return 0;
-out:
-	hashtab_destroy(p->filename_trans);
-	hashtab_destroy(p->range_tr);
-	for (i = 0; i < SYM_NUM; i++)
-		hashtab_destroy(p->symtab[i].table);
-	return rc;
-}
-
-/*
- * The following *_index functions are used to
- * define the val_to_name and val_to_struct arrays
- * in a policy database structure.  The val_to_name
- * arrays are used when converting security context
- * structures into string representations.  The
- * val_to_struct arrays are used when the attributes
- * of a class, role, or user are needed.
- */
-
-static int common_index(void *key, void *datum, void *datap)
-{
-	struct policydb *p;
-	struct common_datum *comdatum;
+	cond_policydb_destroy(p);
 
-	comdatum = datum;
-	p = datap;
-	if (!comdatum->value || comdatum->value > p->p_commons.nprim)
-		return -EINVAL;
+	for (tr = p->role_tr; tr; tr = tr->next) {
+		cond_resched();
+		kfree(ltr);
+		ltr = tr;
+	}
+	kfree(ltr);
 
-	p->sym_val_to_name[SYM_COMMONS][comdatum->value - 1] = key;
+	for (ra = p->role_allow; ra; ra = ra->next) {
+		cond_resched();
+		kfree(lra);
+		lra = ra;
+	}
+	kfree(lra);
 
-	return 0;
-}
+	hashtab_map(p->filename_trans, filenametr_destroy, NULL);
+	hashtab_destroy(p->filename_trans);
 
-static int class_index(void *key, void *datum, void *datap)
-{
-	struct policydb *p;
-	struct class_datum *cladatum;
+	hashtab_map(p->range_tr, range_tr_destroy, NULL);
+	hashtab_destroy(p->range_tr);
 
-	cladatum = datum;
-	p = datap;
-	if (!cladatum->value || cladatum->value > p->p_classes.nprim)
-		return -EINVAL;
+	if (p->type_attr_map_array) {
+		for (i = 0; i < p->p_types.nprim; i++)
+			ebitmap_destroy(&p->type_attr_map_array[i]);
+		kvfree(p->type_attr_map_array);
+	}
 
-	p->sym_val_to_name[SYM_CLASSES][cladatum->value - 1] = key;
-	p->class_val_to_struct[cladatum->value - 1] = cladatum;
-	return 0;
+	ebitmap_destroy(&p->filename_trans_ttypes);
+	ebitmap_destroy(&p->policycaps);
+	ebitmap_destroy(&p->permissive_map);
 }
 
-static int role_index(void *key, void *datum, void *datap)
+/*
+ * Initialize the role table.
+ */
+static int roles_init(struct policydb *p)
 {
-	struct policydb *p;
+	char *key = NULL;
+	int rc;
 	struct role_datum *role;
 
-	role = datum;
-	p = datap;
-	if (!role->value
-	    || role->value > p->p_roles.nprim
-	    || role->bounds > p->p_roles.nprim)
-		return -EINVAL;
-
-	p->sym_val_to_name[SYM_ROLES][role->value - 1] = key;
-	p->role_val_to_struct[role->value - 1] = role;
-	return 0;
-}
+	role = kzalloc(sizeof(*role), GFP_KERNEL);
+	if (!role)
+		return -ENOMEM;
 
-static int type_index(void *key, void *datum, void *datap)
-{
-	struct policydb *p;
-	struct type_datum *typdatum;
+	rc = -EINVAL;
+	role->value = ++p->p_roles.nprim;
+	if (role->value != OBJECT_R_VAL)
+		goto out;
 
-	typdatum = datum;
-	p = datap;
+	rc = -ENOMEM;
+	key = kstrdup(OBJECT_R, GFP_KERNEL);
+	if (!key)
+		goto out;
 
-	if (typdatum->primary) {
-		if (!typdatum->value
-		    || typdatum->value > p->p_types.nprim
-		    || typdatum->bounds > p->p_types.nprim)
-			return -EINVAL;
-		p->sym_val_to_name[SYM_TYPES][typdatum->value - 1] = key;
-		p->type_val_to_struct_array[typdatum->value - 1] = typdatum;
-	}
+	rc = hashtab_insert(p->p_roles.table, key, role);
+	if (rc)
+		goto out;
 
 	return 0;
+out:
+	kfree(key);
+	kfree(role);
+	return rc;
 }
 
-static int user_index(void *key, void *datum, void *datap)
+static u32 filenametr_hash(struct hashtab *h, const void *k)
 {
-	struct policydb *p;
-	struct user_datum *usrdatum;
+	const struct filename_trans *ft = k;
+	unsigned long hash;
+	unsigned int byte_num;
+	unsigned char focus;
 
-	usrdatum = datum;
-	p = datap;
-	if (!usrdatum->value
-	    || usrdatum->value > p->p_users.nprim
-	    || usrdatum->bounds > p->p_users.nprim)
-		return -EINVAL;
+	hash = ft->stype ^ ft->ttype ^ ft->tclass;
 
-	p->sym_val_to_name[SYM_USERS][usrdatum->value - 1] = key;
-	p->user_val_to_struct[usrdatum->value - 1] = usrdatum;
-	return 0;
+	byte_num = 0;
+	while ((focus = ft->name[byte_num++]))
+		hash = partial_name_hash(focus, hash);
+	return hash & (h->size - 1);
 }
 
-static int sens_index(void *key, void *datum, void *datap)
+static int filenametr_cmp(struct hashtab *h, const void *k1, const void *k2)
 {
-	struct policydb *p;
-	struct level_datum *levdatum;
-
-	levdatum = datum;
-	p = datap;
-
-	if (!levdatum->isalias) {
-		if (!levdatum->level->sens ||
-		    levdatum->level->sens > p->p_levels.nprim)
-			return -EINVAL;
-
-		p->sym_val_to_name[SYM_LEVELS][levdatum->level->sens - 1] = key;
-	}
-
-	return 0;
-}
+	const struct filename_trans *ft1 = k1;
+	const struct filename_trans *ft2 = k2;
+	int v;
 
-static int cat_index(void *key, void *datum, void *datap)
-{
-	struct policydb *p;
-	struct cat_datum *catdatum;
+	v = ft1->stype - ft2->stype;
+	if (v)
+		return v;
 
-	catdatum = datum;
-	p = datap;
+	v = ft1->ttype - ft2->ttype;
+	if (v)
+		return v;
 
-	if (!catdatum->isalias) {
-		if (!catdatum->value || catdatum->value > p->p_cats.nprim)
-			return -EINVAL;
+	v = ft1->tclass - ft2->tclass;
+	if (v)
+		return v;
 
-		p->sym_val_to_name[SYM_CATS][catdatum->value - 1] = key;
-	}
+	return strcmp(ft1->name, ft2->name);
 
-	return 0;
 }
 
-static int (*index_f[SYM_NUM]) (void *key, void *datum, void *datap) =
+static u32 rangetr_hash(struct hashtab *h, const void *k)
 {
-	common_index,
-	class_index,
-	role_index,
-	type_index,
-	user_index,
-	cond_index_bool,
-	sens_index,
-	cat_index,
-};
+	const struct range_trans *key = k;
+	return (key->source_type + (key->target_type << 3) +
+		(key->target_class << 5)) & (h->size - 1);
+}
 
-#ifdef DEBUG_HASHES
-static void hash_eval(struct hashtab *h, const char *hash_name)
+static int rangetr_cmp(struct hashtab *h, const void *k1, const void *k2)
 {
-	struct hashtab_info info;
+	const struct range_trans *key1 = k1, *key2 = k2;
+	int v;
 
-	hashtab_stat(h, &info);
-	pr_debug("SELinux: %s:  %d entries and %d/%d buckets used, "
-	       "longest chain length %d\n", hash_name, h->nel,
-	       info.slots_used, h->size, info.max_chain_len);
-}
+	v = key1->source_type - key2->source_type;
+	if (v)
+		return v;
 
-static void symtab_hash_eval(struct symtab *s)
-{
-	int i;
+	v = key1->target_type - key2->target_type;
+	if (v)
+		return v;
 
-	for (i = 0; i < SYM_NUM; i++)
-		hash_eval(s[i].table, symtab_name[i]);
-}
+	v = key1->target_class - key2->target_class;
 
-#else
-static inline void hash_eval(struct hashtab *h, char *hash_name)
-{
+	return v;
 }
-#endif
 
 /*
- * Define the other val_to_name and val_to_struct arrays
- * in a policy database structure.
- *
- * Caller must clean up on failure.
+ * Initialize a policy database structure.
  */
-static int policydb_index(struct policydb *p)
+static int policydb_init(struct policydb *p)
 {
 	int i, rc;
 
-	if (p->mls_enabled)
-		pr_debug("SELinux:  %d users, %d roles, %d types, %d bools, %d sens, %d cats\n",
-			 p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim,
-			 p->p_bools.nprim, p->p_levels.nprim, p->p_cats.nprim);
-	else
-		pr_debug("SELinux:  %d users, %d roles, %d types, %d bools\n",
-			 p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim,
-			 p->p_bools.nprim);
-
-	pr_debug("SELinux:  %d classes, %d rules\n",
-		 p->p_classes.nprim, p->te_avtab.nel);
-
-#ifdef DEBUG_HASHES
-	avtab_hash_eval(&p->te_avtab, "rules");
-	symtab_hash_eval(p->symtab);
-#endif
-
-	p->class_val_to_struct = kcalloc(p->p_classes.nprim,
-					 sizeof(*p->class_val_to_struct),
-					 GFP_KERNEL);
-	if (!p->class_val_to_struct)
-		return -ENOMEM;
+	memset(p, 0, sizeof(*p));
 
-	p->role_val_to_struct = kcalloc(p->p_roles.nprim,
-					sizeof(*p->role_val_to_struct),
-					GFP_KERNEL);
-	if (!p->role_val_to_struct)
-		return -ENOMEM;
+	for (i = 0; i < SYM_NUM; i++) {
+		rc = symtab_init(&p->symtab[i], symtab_sizes[i]);
+		if (rc)
+			goto out;
+	}
 
-	p->user_val_to_struct = kcalloc(p->p_users.nprim,
-					sizeof(*p->user_val_to_struct),
-					GFP_KERNEL);
-	if (!p->user_val_to_struct)
-		return -ENOMEM;
+	rc = avtab_init(&p->te_avtab);
+	if (rc)
+		goto out;
 
-	p->type_val_to_struct_array = kvcalloc(p->p_types.nprim,
-					       sizeof(*p->type_val_to_struct_array),
-					       GFP_KERNEL);
-	if (!p->type_val_to_struct_array)
-		return -ENOMEM;
+	rc = roles_init(p);
+	if (rc)
+		goto out;
 
-	rc = cond_init_bool_indexes(p);
+	rc = cond_policydb_init(p);
 	if (rc)
 		goto out;
 
-	for (i = 0; i < SYM_NUM; i++) {
-		p->sym_val_to_name[i] = kvcalloc(p->symtab[i].nprim,
-						 sizeof(char *),
-						 GFP_KERNEL);
-		if (!p->sym_val_to_name[i])
-			return -ENOMEM;
+	p->filename_trans = hashtab_create(filenametr_hash, filenametr_cmp, (1 << 10));
+	if (!p->filename_trans) {
+		rc = -ENOMEM;
+		goto out;
+	}
 
-		rc = hashtab_map(p->symtab[i].table, index_f[i], p);
-		if (rc)
-			goto out;
+	p->range_tr = hashtab_create(rangetr_hash, rangetr_cmp, 256);
+	if (!p->range_tr) {
+		rc = -ENOMEM;
+		goto out;
 	}
-	rc = 0;
+
+	ebitmap_init(&p->filename_trans_ttypes);
+	ebitmap_init(&p->policycaps);
+	ebitmap_init(&p->permissive_map);
+
+	return 0;
 out:
+	hashtab_destroy(p->filename_trans);
+	hashtab_destroy(p->range_tr);
+	for (i = 0; i < SYM_NUM; i++) {
+		hashtab_map(p->symtab[i].table, destroy_f[i], NULL);
+		hashtab_destroy(p->symtab[i].table);
+	}
 	return rc;
 }
 
 /*
- * The following *_destroy functions are used to
- * free any memory allocated for each kind of
- * symbol data in the policy database.
+ * The following *_index functions are used to
+ * define the val_to_name and val_to_struct arrays
+ * in a policy database structure.  The val_to_name
+ * arrays are used when converting security context
+ * structures into string representations.  The
+ * val_to_struct arrays are used when the attributes
+ * of a class, role, or user are needed.
  */
 
-static int perm_destroy(void *key, void *datum, void *p)
-{
-	kfree(key);
-	kfree(datum);
-	return 0;
-}
-
-static int common_destroy(void *key, void *datum, void *p)
+static int common_index(void *key, void *datum, void *datap)
 {
+	struct policydb *p;
 	struct common_datum *comdatum;
 
-	kfree(key);
-	if (datum) {
-		comdatum = datum;
-		hashtab_map(comdatum->permissions.table, perm_destroy, NULL);
-		hashtab_destroy(comdatum->permissions.table);
-	}
-	kfree(datum);
+	comdatum = datum;
+	p = datap;
+	if (!comdatum->value || comdatum->value > p->p_commons.nprim)
+		return -EINVAL;
+
+	p->sym_val_to_name[SYM_COMMONS][comdatum->value - 1] = key;
+
 	return 0;
 }
 
-static void constraint_expr_destroy(struct constraint_expr *expr)
+static int class_index(void *key, void *datum, void *datap)
 {
-	if (expr) {
-		ebitmap_destroy(&expr->names);
-		if (expr->type_names) {
-			ebitmap_destroy(&expr->type_names->types);
-			ebitmap_destroy(&expr->type_names->negset);
-			kfree(expr->type_names);
-		}
-		kfree(expr);
-	}
+	struct policydb *p;
+	struct class_datum *cladatum;
+
+	cladatum = datum;
+	p = datap;
+	if (!cladatum->value || cladatum->value > p->p_classes.nprim)
+		return -EINVAL;
+
+	p->sym_val_to_name[SYM_CLASSES][cladatum->value - 1] = key;
+	p->class_val_to_struct[cladatum->value - 1] = cladatum;
+	return 0;
 }
 
-static int cls_destroy(void *key, void *datum, void *p)
+static int role_index(void *key, void *datum, void *datap)
 {
-	struct class_datum *cladatum;
-	struct constraint_node *constraint, *ctemp;
-	struct constraint_expr *e, *etmp;
+	struct policydb *p;
+	struct role_datum *role;
 
-	kfree(key);
-	if (datum) {
-		cladatum = datum;
-		hashtab_map(cladatum->permissions.table, perm_destroy, NULL);
-		hashtab_destroy(cladatum->permissions.table);
-		constraint = cladatum->constraints;
-		while (constraint) {
-			e = constraint->expr;
-			while (e) {
-				etmp = e;
-				e = e->next;
-				constraint_expr_destroy(etmp);
-			}
-			ctemp = constraint;
-			constraint = constraint->next;
-			kfree(ctemp);
-		}
+	role = datum;
+	p = datap;
+	if (!role->value
+	    || role->value > p->p_roles.nprim
+	    || role->bounds > p->p_roles.nprim)
+		return -EINVAL;
 
-		constraint = cladatum->validatetrans;
-		while (constraint) {
-			e = constraint->expr;
-			while (e) {
-				etmp = e;
-				e = e->next;
-				constraint_expr_destroy(etmp);
-			}
-			ctemp = constraint;
-			constraint = constraint->next;
-			kfree(ctemp);
-		}
-		kfree(cladatum->comkey);
-	}
-	kfree(datum);
+	p->sym_val_to_name[SYM_ROLES][role->value - 1] = key;
+	p->role_val_to_struct[role->value - 1] = role;
 	return 0;
 }
 
-static int role_destroy(void *key, void *datum, void *p)
+static int type_index(void *key, void *datum, void *datap)
 {
-	struct role_datum *role;
+	struct policydb *p;
+	struct type_datum *typdatum;
 
-	kfree(key);
-	if (datum) {
-		role = datum;
-		ebitmap_destroy(&role->dominates);
-		ebitmap_destroy(&role->types);
+	typdatum = datum;
+	p = datap;
+
+	if (typdatum->primary) {
+		if (!typdatum->value
+		    || typdatum->value > p->p_types.nprim
+		    || typdatum->bounds > p->p_types.nprim)
+			return -EINVAL;
+		p->sym_val_to_name[SYM_TYPES][typdatum->value - 1] = key;
+		p->type_val_to_struct_array[typdatum->value - 1] = typdatum;
 	}
-	kfree(datum);
-	return 0;
-}
 
-static int type_destroy(void *key, void *datum, void *p)
-{
-	kfree(key);
-	kfree(datum);
 	return 0;
 }
 
-static int user_destroy(void *key, void *datum, void *p)
+static int user_index(void *key, void *datum, void *datap)
 {
+	struct policydb *p;
 	struct user_datum *usrdatum;
 
-	kfree(key);
-	if (datum) {
-		usrdatum = datum;
-		ebitmap_destroy(&usrdatum->roles);
-		ebitmap_destroy(&usrdatum->range.level[0].cat);
-		ebitmap_destroy(&usrdatum->range.level[1].cat);
-		ebitmap_destroy(&usrdatum->dfltlevel.cat);
-	}
-	kfree(datum);
+	usrdatum = datum;
+	p = datap;
+	if (!usrdatum->value
+	    || usrdatum->value > p->p_users.nprim
+	    || usrdatum->bounds > p->p_users.nprim)
+		return -EINVAL;
+
+	p->sym_val_to_name[SYM_USERS][usrdatum->value - 1] = key;
+	p->user_val_to_struct[usrdatum->value - 1] = usrdatum;
 	return 0;
 }
 
-static int sens_destroy(void *key, void *datum, void *p)
+static int sens_index(void *key, void *datum, void *datap)
 {
+	struct policydb *p;
 	struct level_datum *levdatum;
 
-	kfree(key);
-	if (datum) {
-		levdatum = datum;
-		if (levdatum->level)
-			ebitmap_destroy(&levdatum->level->cat);
-		kfree(levdatum->level);
+	levdatum = datum;
+	p = datap;
+
+	if (!levdatum->isalias) {
+		if (!levdatum->level->sens ||
+		    levdatum->level->sens > p->p_levels.nprim)
+			return -EINVAL;
+
+		p->sym_val_to_name[SYM_LEVELS][levdatum->level->sens - 1] = key;
 	}
-	kfree(datum);
+
 	return 0;
 }
 
-static int cat_destroy(void *key, void *datum, void *p)
+static int cat_index(void *key, void *datum, void *datap)
 {
-	kfree(key);
-	kfree(datum);
+	struct policydb *p;
+	struct cat_datum *catdatum;
+
+	catdatum = datum;
+	p = datap;
+
+	if (!catdatum->isalias) {
+		if (!catdatum->value || catdatum->value > p->p_cats.nprim)
+			return -EINVAL;
+
+		p->sym_val_to_name[SYM_CATS][catdatum->value - 1] = key;
+	}
+
 	return 0;
 }
 
-static int (*destroy_f[SYM_NUM]) (void *key, void *datum, void *datap) =
+static int (*index_f[SYM_NUM]) (void *key, void *datum, void *datap) =
 {
-	common_destroy,
-	cls_destroy,
-	role_destroy,
-	type_destroy,
-	user_destroy,
-	cond_destroy_bool,
-	sens_destroy,
-	cat_destroy,
+	common_index,
+	class_index,
+	role_index,
+	type_index,
+	user_index,
+	cond_index_bool,
+	sens_index,
+	cat_index,
 };
 
-static int filenametr_destroy(void *key, void *datum, void *p)
+#ifdef DEBUG_HASHES
+static void hash_eval(struct hashtab *h, const char *hash_name)
 {
-	struct filename_trans *ft = key;
-	kfree(ft->name);
-	kfree(key);
-	kfree(datum);
-	cond_resched();
-	return 0;
+	struct hashtab_info info;
+
+	hashtab_stat(h, &info);
+	pr_debug("SELinux: %s:  %d entries and %d/%d buckets used, "
+	       "longest chain length %d\n", hash_name, h->nel,
+	       info.slots_used, h->size, info.max_chain_len);
 }
 
-static int range_tr_destroy(void *key, void *datum, void *p)
+static void symtab_hash_eval(struct symtab *s)
 {
-	struct mls_range *rt = datum;
-	kfree(key);
-	ebitmap_destroy(&rt->level[0].cat);
-	ebitmap_destroy(&rt->level[1].cat);
-	kfree(datum);
-	cond_resched();
-	return 0;
+	int i;
+
+	for (i = 0; i < SYM_NUM; i++)
+		hash_eval(s[i].table, symtab_name[i]);
 }
 
-static void ocontext_destroy(struct ocontext *c, int i)
+#else
+static inline void hash_eval(struct hashtab *h, char *hash_name)
 {
-	if (!c)
-		return;
-
-	context_destroy(&c->context[0]);
-	context_destroy(&c->context[1]);
-	if (i == OCON_ISID || i == OCON_FS ||
-	    i == OCON_NETIF || i == OCON_FSUSE)
-		kfree(c->u.name);
-	kfree(c);
 }
+#endif
 
 /*
- * Free any memory allocated by a policy database structure.
+ * Define the other val_to_name and val_to_struct arrays
+ * in a policy database structure.
+ *
+ * Caller must clean up on failure.
  */
-void policydb_destroy(struct policydb *p)
+static int policydb_index(struct policydb *p)
 {
-	struct ocontext *c, *ctmp;
-	struct genfs *g, *gtmp;
-	int i;
-	struct role_allow *ra, *lra = NULL;
-	struct role_trans *tr, *ltr = NULL;
-
-	for (i = 0; i < SYM_NUM; i++) {
-		cond_resched();
-		hashtab_map(p->symtab[i].table, destroy_f[i], NULL);
-		hashtab_destroy(p->symtab[i].table);
-	}
-
-	for (i = 0; i < SYM_NUM; i++)
-		kvfree(p->sym_val_to_name[i]);
+	int i, rc;
 
-	kfree(p->class_val_to_struct);
-	kfree(p->role_val_to_struct);
-	kfree(p->user_val_to_struct);
-	kvfree(p->type_val_to_struct_array);
+	if (p->mls_enabled)
+		pr_debug("SELinux:  %d users, %d roles, %d types, %d bools, %d sens, %d cats\n",
+			 p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim,
+			 p->p_bools.nprim, p->p_levels.nprim, p->p_cats.nprim);
+	else
+		pr_debug("SELinux:  %d users, %d roles, %d types, %d bools\n",
+			 p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim,
+			 p->p_bools.nprim);
 
-	avtab_destroy(&p->te_avtab);
+	pr_debug("SELinux:  %d classes, %d rules\n",
+		 p->p_classes.nprim, p->te_avtab.nel);
 
-	for (i = 0; i < OCON_NUM; i++) {
-		cond_resched();
-		c = p->ocontexts[i];
-		while (c) {
-			ctmp = c;
-			c = c->next;
-			ocontext_destroy(ctmp, i);
-		}
-		p->ocontexts[i] = NULL;
-	}
+#ifdef DEBUG_HASHES
+	avtab_hash_eval(&p->te_avtab, "rules");
+	symtab_hash_eval(p->symtab);
+#endif
 
-	g = p->genfs;
-	while (g) {
-		cond_resched();
-		kfree(g->fstype);
-		c = g->head;
-		while (c) {
-			ctmp = c;
-			c = c->next;
-			ocontext_destroy(ctmp, OCON_FSUSE);
-		}
-		gtmp = g;
-		g = g->next;
-		kfree(gtmp);
-	}
-	p->genfs = NULL;
+	p->class_val_to_struct = kcalloc(p->p_classes.nprim,
+					 sizeof(*p->class_val_to_struct),
+					 GFP_KERNEL);
+	if (!p->class_val_to_struct)
+		return -ENOMEM;
 
-	cond_policydb_destroy(p);
+	p->role_val_to_struct = kcalloc(p->p_roles.nprim,
+					sizeof(*p->role_val_to_struct),
+					GFP_KERNEL);
+	if (!p->role_val_to_struct)
+		return -ENOMEM;
 
-	for (tr = p->role_tr; tr; tr = tr->next) {
-		cond_resched();
-		kfree(ltr);
-		ltr = tr;
-	}
-	kfree(ltr);
+	p->user_val_to_struct = kcalloc(p->p_users.nprim,
+					sizeof(*p->user_val_to_struct),
+					GFP_KERNEL);
+	if (!p->user_val_to_struct)
+		return -ENOMEM;
 
-	for (ra = p->role_allow; ra; ra = ra->next) {
-		cond_resched();
-		kfree(lra);
-		lra = ra;
-	}
-	kfree(lra);
+	p->type_val_to_struct_array = kvcalloc(p->p_types.nprim,
+					       sizeof(*p->type_val_to_struct_array),
+					       GFP_KERNEL);
+	if (!p->type_val_to_struct_array)
+		return -ENOMEM;
 
-	hashtab_map(p->filename_trans, filenametr_destroy, NULL);
-	hashtab_destroy(p->filename_trans);
+	rc = cond_init_bool_indexes(p);
+	if (rc)
+		goto out;
 
-	hashtab_map(p->range_tr, range_tr_destroy, NULL);
-	hashtab_destroy(p->range_tr);
+	for (i = 0; i < SYM_NUM; i++) {
+		p->sym_val_to_name[i] = kvcalloc(p->symtab[i].nprim,
+						 sizeof(char *),
+						 GFP_KERNEL);
+		if (!p->sym_val_to_name[i])
+			return -ENOMEM;
 
-	if (p->type_attr_map_array) {
-		for (i = 0; i < p->p_types.nprim; i++)
-			ebitmap_destroy(&p->type_attr_map_array[i]);
-		kvfree(p->type_attr_map_array);
+		rc = hashtab_map(p->symtab[i].table, index_f[i], p);
+		if (rc)
+			goto out;
 	}
-
-	ebitmap_destroy(&p->filename_trans_ttypes);
-	ebitmap_destroy(&p->policycaps);
-	ebitmap_destroy(&p->permissive_map);
+	rc = 0;
+out:
+	return rc;
 }
 
 /*
-- 
2.21.0

