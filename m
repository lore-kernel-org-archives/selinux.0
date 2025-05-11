Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FCE25DD1C;
	Sun, 11 May 2025 17:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746984686; cv=none; b=ULmMcKcR0pkIrlZZScX+wGtolcrSBbkwh/FfxUz+yj9Z8mNTOxoGsPkITMyhReCdozwjr7z9Kv+qkf0Qv0tiDizYuxjpWvzUHd/Y95HqYoAxJqIYT3VETyRl+gZfx2U9s7myEmun3WoB6joeSLMCqVJirr6WibUomSZMYMFf4ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746984686; c=relaxed/simple;
	bh=dD5GFaOfKhFzkCqMAmwdaYZs2g96GWHqlAdAsfZqJIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PmIin4cxYrT6vnmtYeTQ5OMW2CCrIFiOex/LgEgxS/tRpnihulRSMhKit1nuJpbslE1WhTjwWDEF++jTt8TfiJkvbwyXjNC4ZKWGvTsN+7dhg/TulT7Xl38C/FXq8Vdk8P+HL+TGITdzvX5Anjx5aEn5hVVoc9AaMh24XBmgQlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=WyA3Xot2; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="WyA3Xot2"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1746984682;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3EkAUMskWF/W8xBIY5MFby3ZkdrRQ59dR3sQdKBLQ4I=;
	b=WyA3Xot2L88RURXmJYRvKtkpo7ISpHBMVdXUb1MJxXlZxYprwGrEcBwNEmS9deKGmWtvxX
	4hN6zxfIW3euKplKr1f8D5O6LkZ4dGKkD3ui+TXq9Cx2VXaUlGSc15cF/PCxJ+oCzpaOH+
	M4xwGFZHO68G+I+iBCUh9/d/O8VxJ7JQrA0iI355q2zR7qNEp9b6mpustlAwrqpjVU3xtI
	JKcGq8VFysEDJLf9GJZkys0XpMeniPjIUHo6DjTj7LZTfXL5Dvi7H9pxw95KlK7ZTcWTNh
	88VBqhtjDE4pwLIFtZtsFIl4AMSi1QVSw2YUkpJK30xXH1ODcxk6Gw65Un4EEw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-kernel@vger.kernel.org,
	Casey Schaufler <casey@schaufler-ca.com>,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
	Canfeng Guo <guocanfeng@uniontech.com>,
	Takaya Saeki <takayas@chromium.org>
Subject: [PATCH v3 09/14] selinux: beef up isvalid checks
Date: Sun, 11 May 2025 19:30:09 +0200
Message-ID: <20250511173055.406906-9-cgoettsche@seltendoof.de>
In-Reply-To: <20250511173055.406906-1-cgoettsche@seltendoof.de>
References: <20250511173055.406906-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Check that an ID does not refer to a gap in the global array of
definitions.

Constify parameters of isvalid() function and change return type to
bool.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/hashtab.h  |  4 +--
 security/selinux/ss/mls.c      | 66 +++++++++++++++++++++-------------
 security/selinux/ss/mls.h      |  6 ++--
 security/selinux/ss/policydb.c | 56 ++++++++++++++++-------------
 security/selinux/ss/policydb.h | 12 +++----
 security/selinux/ss/services.c |  2 +-
 security/selinux/ss/symtab.c   |  2 +-
 security/selinux/ss/symtab.h   |  2 +-
 8 files changed, 88 insertions(+), 62 deletions(-)

diff --git a/security/selinux/ss/hashtab.h b/security/selinux/ss/hashtab.h
index deba82d78c3a..c641fb12916b 100644
--- a/security/selinux/ss/hashtab.h
+++ b/security/selinux/ss/hashtab.h
@@ -94,11 +94,11 @@ static inline int hashtab_insert(struct hashtab *h, void *key, void *datum,
  * Returns NULL if no entry has the specified key or
  * the datum of the entry otherwise.
  */
-static inline void *hashtab_search(struct hashtab *h, const void *key,
+static inline void *hashtab_search(const struct hashtab *h, const void *key,
 				   struct hashtab_key_params key_params)
 {
 	u32 hvalue;
-	struct hashtab_node *cur;
+	const struct hashtab_node *cur;
 
 	if (!h->size)
 		return NULL;
diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index a6e49269f535..3cd36e2015fa 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -32,7 +32,7 @@
 int mls_compute_context_len(struct policydb *p, struct context *context)
 {
 	int i, l, len, head, prev;
-	char *nm;
+	const char *nm;
 	struct ebitmap *e;
 	struct ebitmap_node *node;
 
@@ -86,7 +86,8 @@ int mls_compute_context_len(struct policydb *p, struct context *context)
 void mls_sid_to_context(struct policydb *p, struct context *context,
 			char **scontext)
 {
-	char *scontextp, *nm;
+	const char *nm;
+	char *scontextp;
 	int i, l, head, prev;
 	struct ebitmap *e;
 	struct ebitmap_node *node;
@@ -155,27 +156,44 @@ void mls_sid_to_context(struct policydb *p, struct context *context,
 	*scontext = scontextp;
 }
 
-int mls_level_isvalid(struct policydb *p, struct mls_level *l)
+bool mls_level_isvalid(const struct policydb *p, const struct mls_level *l)
 {
-	struct level_datum *levdatum;
+	const char *name;
+	const struct level_datum *levdatum;
+	struct ebitmap_node *node;
+	u32 bit;
+	int rc;
 
 	if (!l->sens || l->sens > p->p_levels.nprim)
-		return 0;
-	levdatum = symtab_search(&p->p_levels,
-				 sym_name(p, SYM_LEVELS, l->sens - 1));
+		return false;
+
+	name = sym_name(p, SYM_LEVELS, l->sens - 1);
+	if (!name)
+		return false;
+
+	levdatum = symtab_search(&p->p_levels, name);
 	if (!levdatum)
-		return 0;
+		return false;
 
 	/*
-	 * Return 1 iff all the bits set in l->cat are also be set in
+	 * Validate that all bits set in l->cat are also be set in
 	 * levdatum->level->cat and no bit in l->cat is larger than
 	 * p->p_cats.nprim.
 	 */
-	return ebitmap_contains(&levdatum->level.cat, &l->cat,
-				p->p_cats.nprim);
+	rc = ebitmap_contains(&levdatum->level.cat, &l->cat,
+			      p->p_cats.nprim);
+	if (!rc)
+		return false;
+
+	ebitmap_for_each_positive_bit(&levdatum->level.cat, node, bit) {
+		if (!sym_name(p, SYM_CATS, bit))
+			return false;
+	}
+
+	return true;
 }
 
-int mls_range_isvalid(struct policydb *p, struct mls_range *r)
+bool mls_range_isvalid(const struct policydb *p, const struct mls_range *r)
 {
 	return (mls_level_isvalid(p, &r->level[0]) &&
 		mls_level_isvalid(p, &r->level[1]) &&
@@ -183,32 +201,32 @@ int mls_range_isvalid(struct policydb *p, struct mls_range *r)
 }
 
 /*
- * Return 1 if the MLS fields in the security context
+ * Return true if the MLS fields in the security context
  * structure `c' are valid.  Return 0 otherwise.
  */
-int mls_context_isvalid(struct policydb *p, struct context *c)
+bool mls_context_isvalid(const struct policydb *p, const struct context *c)
 {
-	struct user_datum *usrdatum;
+	const struct user_datum *usrdatum;
 
 	if (!p->mls_enabled)
-		return 1;
+		return true;
 
 	if (!mls_range_isvalid(p, &c->range))
-		return 0;
+		return false;
 
 	if (c->role == OBJECT_R_VAL)
-		return 1;
+		return true;
 
 	/*
 	 * User must be authorized for the MLS range.
 	 */
 	if (!c->user || c->user > p->p_users.nprim)
-		return 0;
+		return false;
 	usrdatum = p->user_val_to_struct[c->user - 1];
-	if (!mls_range_contains(usrdatum->range, c->range))
-		return 0; /* user may not be associated with range */
+	if (!usrdatum || !mls_range_contains(usrdatum->range, c->range))
+		return false; /* user may not be associated with range */
 
-	return 1;
+	return true;
 }
 
 /*
@@ -449,8 +467,8 @@ int mls_convert_context(struct policydb *oldp, struct policydb *newp,
 		return 0;
 
 	for (l = 0; l < 2; l++) {
-		char *name = sym_name(oldp, SYM_LEVELS,
-				      oldc->range.level[l].sens - 1);
+		const char *name = sym_name(oldp, SYM_LEVELS,
+					    oldc->range.level[l].sens - 1);
 
 		levdatum = symtab_search(&newp->p_levels, name);
 
diff --git a/security/selinux/ss/mls.h b/security/selinux/ss/mls.h
index 07980636751f..93cde1b22992 100644
--- a/security/selinux/ss/mls.h
+++ b/security/selinux/ss/mls.h
@@ -27,9 +27,9 @@
 int mls_compute_context_len(struct policydb *p, struct context *context);
 void mls_sid_to_context(struct policydb *p, struct context *context,
 			char **scontext);
-int mls_context_isvalid(struct policydb *p, struct context *c);
-int mls_range_isvalid(struct policydb *p, struct mls_range *r);
-int mls_level_isvalid(struct policydb *p, struct mls_level *l);
+bool mls_context_isvalid(const struct policydb *p, const struct context *c);
+bool mls_range_isvalid(const struct policydb *p, const struct mls_range *r);
+bool mls_level_isvalid(const struct policydb *p, const struct mls_level *l);
 
 int mls_context_to_sid(struct policydb *p, char oldc, char *scontext,
 		       struct context *context, struct sidtab *s, u32 def_sid);
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 326d82f8db8c..f8d6e993ce89 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -923,51 +923,59 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
 	return 0;
 }
 
-int policydb_class_isvalid(struct policydb *p, u16 class)
+bool policydb_class_isvalid(const struct policydb *p, u16 class)
 {
 	if (!class || class > p->p_classes.nprim)
-		return 0;
-	return 1;
+		return false;
+	if (!p->sym_val_to_name[SYM_CLASSES][class - 1])
+		return false;
+	return true;
 }
 
-int policydb_role_isvalid(struct policydb *p, unsigned int role)
+bool policydb_role_isvalid(const struct policydb *p, u32 role)
 {
 	if (!role || role > p->p_roles.nprim)
-		return 0;
-	return 1;
+		return false;
+	if (!p->sym_val_to_name[SYM_ROLES][role - 1])
+		return false;
+	return true;
 }
 
-int policydb_type_isvalid(struct policydb *p, unsigned int type)
+bool policydb_type_isvalid(const struct policydb *p, u32 type)
 {
 	if (!type || type > p->p_types.nprim)
-		return 0;
-	return 1;
+		return false;
+	if (!p->sym_val_to_name[SYM_TYPES][type - 1])
+		return false;
+	return true;
 }
 
-int policydb_boolean_isvalid(const struct policydb *p, u32 boolean)
+bool policydb_boolean_isvalid(const struct policydb *p, u32 boolean)
 {
 	if (!boolean || boolean > p->p_bools.nprim)
-		return 0;
-	return 1;
+		return false;
+	if (!p->sym_val_to_name[SYM_BOOLS][boolean - 1])
+		return false;
+	return true;
 }
 
 /*
- * Return 1 if the fields in the security context
+ * Return true if the fields in the security context
  * structure `c' are valid.  Return 0 otherwise.
  */
-int policydb_context_isvalid(struct policydb *p, struct context *c)
+bool policydb_context_isvalid(const struct policydb *p, const struct context *c)
 {
-	struct role_datum *role;
-	struct user_datum *usrdatum;
+	const struct role_datum *role;
+	const struct user_datum *usrdatum;
 
 	if (!c->role || c->role > p->p_roles.nprim)
-		return 0;
+		return false;
 
 	if (!c->user || c->user > p->p_users.nprim)
-		return 0;
+		return false;
 
 	if (!c->type || c->type > p->p_types.nprim)
-		return 0;
+		return false;
 
 	if (c->role != OBJECT_R_VAL) {
 		/*
@@ -976,24 +984,24 @@ int policydb_context_isvalid(struct policydb *p, struct context *c)
 		role = p->role_val_to_struct[c->role - 1];
 		if (!role || !ebitmap_get_bit(&role->types, c->type - 1))
 			/* role may not be associated with type */
-			return 0;
+			return false;
 
 		/*
 		 * User must be authorized for the role.
 		 */
 		usrdatum = p->user_val_to_struct[c->user - 1];
 		if (!usrdatum)
-			return 0;
+			return false;
 
 		if (!ebitmap_get_bit(&usrdatum->roles, c->role - 1))
 			/* user may not be associated with role */
-			return 0;
+			return false;
 	}
 
 	if (!mls_context_isvalid(p, c))
-		return 0;
+		return false;
 
-	return 1;
+	return true;
 }
 
 /*
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 42117adb2ca0..1367387beaa7 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -320,11 +320,11 @@ struct policy_file {
 
 extern void policydb_destroy(struct policydb *p);
 extern int policydb_load_isids(struct policydb *p, struct sidtab *s);
-extern int policydb_context_isvalid(struct policydb *p, struct context *c);
-extern int policydb_class_isvalid(struct policydb *p, u16 class);
-extern int policydb_type_isvalid(struct policydb *p, unsigned int type);
-extern int policydb_role_isvalid(struct policydb *p, unsigned int role);
-extern int policydb_boolean_isvalid(const struct policydb *p, u32 boolean);
+extern bool policydb_context_isvalid(const struct policydb *p, const struct context *c);
+extern bool policydb_class_isvalid(const struct policydb *p, u16 class);
+extern bool policydb_type_isvalid(const struct policydb *p, u32 type);
+extern bool policydb_role_isvalid(const struct policydb *p, u32 role);
+extern bool policydb_boolean_isvalid(const struct policydb *p, u32 boolean);
 extern int policydb_read(struct policydb *p, struct policy_file *fp);
 extern int policydb_write(struct policydb *p, struct policy_file *fp);
 
@@ -395,7 +395,7 @@ static inline int put_entry(const void *buf, size_t bytes, size_t num,
 	return 0;
 }
 
-static inline char *sym_name(struct policydb *p, unsigned int sym_num,
+static inline const char *sym_name(const struct policydb *p, unsigned int sym_num,
 			     unsigned int element_nr)
 {
 	return p->sym_val_to_name[sym_num][element_nr];
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 3fb971fe4fd9..5b1d0e80d975 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -464,7 +464,7 @@ static void security_dump_masked_av(struct policydb *policydb,
 	struct common_datum *common_dat;
 	struct class_datum *tclass_dat;
 	struct audit_buffer *ab;
-	char *tclass_name;
+	const char *tclass_name;
 	char *scontext_name = NULL;
 	char *tcontext_name = NULL;
 	char *permission_names[SEL_VEC_MAX];
diff --git a/security/selinux/ss/symtab.c b/security/selinux/ss/symtab.c
index 832660fd84a9..a756554e7f1d 100644
--- a/security/selinux/ss/symtab.c
+++ b/security/selinux/ss/symtab.c
@@ -50,7 +50,7 @@ int symtab_insert(struct symtab *s, char *name, void *datum)
 	return hashtab_insert(&s->table, name, datum, symtab_key_params);
 }
 
-void *symtab_search(struct symtab *s, const char *name)
+void *symtab_search(const struct symtab *s, const char *name)
 {
 	return hashtab_search(&s->table, name, symtab_key_params);
 }
diff --git a/security/selinux/ss/symtab.h b/security/selinux/ss/symtab.h
index 8e667cdbf38f..7cfa3b44953a 100644
--- a/security/selinux/ss/symtab.h
+++ b/security/selinux/ss/symtab.h
@@ -21,6 +21,6 @@ struct symtab {
 int symtab_init(struct symtab *s, u32 size);
 
 int symtab_insert(struct symtab *s, char *name, void *datum);
-void *symtab_search(struct symtab *s, const char *name);
+void *symtab_search(const struct symtab *s, const char *name);
 
 #endif /* _SS_SYMTAB_H_ */
-- 
2.49.0

