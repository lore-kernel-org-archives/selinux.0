Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069A51D0E10;
	Fri, 15 Nov 2024 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677830; cv=none; b=UnmvmUqzT2bJHOVr8xHNKpqUStv1WEycOHNN99kAwpWaPfirbqfUMYJ3jVituiasUbR/6L9q5InDWFo0r4dcxgdmTkFkNopPJMGOuEzpwSaDPToYspvxOYJerohW6IRHQ0I/aGqCQ5uqweIl7OllioN8RXob4fU25H/3OIiDSxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677830; c=relaxed/simple;
	bh=xjRx839reEfauoAsGpx0+erDuUYI8vEOxNnuAimQeEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oTVB+g+H1j9F+ReuzJirTf2RXaKKpbKEA6VKlc4PARnHeQPWcPxZofIw3AUwoh76yjlwR11UfgmxaLMTPn82HAjZP+KUm8qCnpnkxzj58WhFVNxXgswWPd3ld/k4BQ4ssJHZZ8A0vsZoZPZGfYpZ/RpqAS9lRdu5CWjp4iooQRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=ov3eRLHp; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="ov3eRLHp"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731677826;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D29c1jBHFJhoKU/6fiWpWbOk2hITALZ8Z0lXtIVwcbY=;
	b=ov3eRLHpIBZrRoWS7PRykPz4JieIjq5YZNXQpcMnkMlAMB/nqm1cOnOYv1KEREQsfqc05I
	PAb7ehqIg6fJvD8zds7gumgIc3oRM6zpIqeeRTA3ckjCvoYv6e3Xk6yANAtsnpBaDRz0Rw
	KViEO++aVepeyJXHF4m48Djxuk7HY3QgKv+LbkAVmpidA7Gu9Y/t25UFbDfJfcw9wvqY2U
	x8mhOuKSA+GNEcX+iND7pO/+xVCjYNrFgA/ExBie3KI7u8/eQ8jDTgqMoRhUpr2kRn/+S4
	YfllUgtvSF0dMWHM8ibdBShvMI94TT+HX7PgEE6YJ9+y4NKqCdQNTvvBroe/tg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Jacob Satterfield <jsatterfield.linux@gmail.com>,
	Eric Suen <ericsu@linux.microsoft.com>,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
	=?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>,
	Canfeng Guo <guocanfeng@uniontech.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	GUO Zihua <guozihua@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 11/22] selinux: more strict policy parsing
Date: Fri, 15 Nov 2024 14:35:30 +0100
Message-ID: <20241115133619.114393-11-cgoettsche@seltendoof.de>
In-Reply-To: <20241115133619.114393-1-cgoettsche@seltendoof.de>
References: <20241115133619.114393-1-cgoettsche@seltendoof.de>
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

Be more strict during parsing of policies and reject invalid values.

Add some error messages in the case of policy parse failures, to
enhance debugging, either on a malformed policy or a too strict check.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/avtab.c       |  46 +++++++--
 security/selinux/ss/avtab.h       |   1 +
 security/selinux/ss/conditional.c |  22 ++---
 security/selinux/ss/constraint.h  |   2 +-
 security/selinux/ss/policydb.c    | 157 ++++++++++++++++++++++++------
 security/selinux/ss/policydb.h    |  10 +-
 security/selinux/ss/services.c    |   2 -
 7 files changed, 184 insertions(+), 56 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 23210faaa046..6122c1c7e951 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -337,6 +337,7 @@ static const uint16_t spec_order[] = {
 /* clang-format on */
 
 int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *pol,
+		    bool conditional,
 		    int (*insertf)(struct avtab *a, const struct avtab_key *k,
 				   const struct avtab_datum *d, void *p),
 		    void *p)
@@ -349,7 +350,7 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
 	struct avtab_extended_perms xperms;
 	__le32 buf32[ARRAY_SIZE(xperms.perms.p)];
 	int rc;
-	unsigned int set, vers = pol->policyvers;
+	unsigned int vers = pol->policyvers;
 
 	memset(&key, 0, sizeof(struct avtab_key));
 	memset(&datum, 0, sizeof(struct avtab_datum));
@@ -361,8 +362,8 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
 			return rc;
 		}
 		items2 = le32_to_cpu(buf32[0]);
-		if (items2 > ARRAY_SIZE(buf32)) {
-			pr_err("SELinux: avtab: entry overflow\n");
+		if (items2 < 5 || items2 > ARRAY_SIZE(buf32)) {
+			pr_err("SELinux: avtab: invalid item count\n");
 			return -EINVAL;
 		}
 		rc = next_entry(buf32, fp, sizeof(u32) * items2);
@@ -391,6 +392,13 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
 			return -EINVAL;
 		}
 
+		if (!policydb_type_isvalid(pol, key.source_type) ||
+		    !policydb_type_isvalid(pol, key.target_type) ||
+		    !policydb_class_isvalid(pol, key.target_class)) {
+			pr_err("SELinux: avtab: invalid type or class\n");
+			return -EINVAL;
+		}
+
 		val = le32_to_cpu(buf32[items++]);
 		enabled = (val & AVTAB_ENABLED_OLD) ? AVTAB_ENABLED : 0;
 
@@ -409,6 +417,11 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
 
 		for (i = 0; i < ARRAY_SIZE(spec_order); i++) {
 			if (val & spec_order[i]) {
+				if (items >= items2) {
+					pr_err("SELinux: avtab: entry has too many items (%d/%d)\n",
+					       items + 1, items2);
+					return -EINVAL;
+				}
 				key.specified = spec_order[i] | enabled;
 				datum.u.data = le32_to_cpu(buf32[items++]);
 				rc = insertf(a, &key, &datum, p);
@@ -444,9 +457,13 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
 		return -EINVAL;
 	}
 
-	set = hweight16(key.specified & (AVTAB_XPERMS | AVTAB_TYPE | AVTAB_AV));
-	if (!set || set > 1) {
-		pr_err("SELinux:  avtab:  more than one specifier\n");
+	if (hweight16(key.specified & ~AVTAB_ENABLED) != 1) {
+		pr_err("SELinux:  avtab:  not exactly one specifier\n");
+		return -EINVAL;
+	}
+
+	if (key.specified & ~(AVTAB_AV | AVTAB_TYPE | AVTAB_XPERMS | AVTAB_ENABLED)) {
+		pr_err("SELinux:  avtab:  invalid specifier\n");
 		return -EINVAL;
 	}
 
@@ -457,6 +474,12 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
 		       "was specified\n",
 		       vers);
 		return -EINVAL;
+	} else if ((key.specified & AVTAB_XPERMS) && conditional) {
+		pr_err("SELinux:  avtab:  policy version %u does not "
+		       "support extended permissions rules in conditional "
+		       "policies and one was specified\n",
+		       vers);
+		return -EINVAL;
 	} else if (key.specified & AVTAB_XPERMS) {
 		memset(&xperms, 0, sizeof(struct avtab_extended_perms));
 		rc = next_entry(&xperms.specified, fp, sizeof(u8));
@@ -464,6 +487,15 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
 			pr_err("SELinux: avtab: truncated entry\n");
 			return rc;
 		}
+		switch (xperms.specified) {
+		case AVTAB_XPERMS_IOCTLFUNCTION:
+		case AVTAB_XPERMS_IOCTLDRIVER:
+		case AVTAB_XPERMS_NLMSG:
+			break;
+		default:
+			pr_err("SELinux: avtab: invalid xperm specifier %#x\n", xperms.specified);
+			return -EINVAL;
+		}
 		rc = next_entry(&xperms.driver, fp, sizeof(u8));
 		if (rc) {
 			pr_err("SELinux: avtab: truncated entry\n");
@@ -523,7 +555,7 @@ int avtab_read(struct avtab *a, struct policy_file *fp, struct policydb *pol)
 		goto bad;
 
 	for (i = 0; i < nel; i++) {
-		rc = avtab_read_item(a, fp, pol, avtab_insertf, NULL);
+		rc = avtab_read_item(a, fp, pol, false, avtab_insertf, NULL);
 		if (rc) {
 			if (rc == -ENOMEM)
 				pr_err("SELinux: avtab: out of memory\n");
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index c671b6e909d4..b5ce072d0f1c 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -107,6 +107,7 @@ static inline void avtab_hash_eval(struct avtab *h, const char *tag)
 struct policydb;
 struct policy_file;
 int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *pol,
+		    bool conditional,
 		    int (*insert)(struct avtab *a, const struct avtab_key *k,
 				  const struct avtab_datum *d, void *p),
 		    void *p);
diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index f8a21d10ff92..f85d22952d5a 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -199,19 +199,12 @@ int cond_index_bool(void *key, void *datum, void *datap)
 	return 0;
 }
 
-static int bool_isvalid(struct cond_bool_datum *b)
-{
-	if (!(b->state == 0 || b->state == 1))
-		return 0;
-	return 1;
-}
-
 int cond_read_bool(struct policydb *p, struct symtab *s, struct policy_file *fp)
 {
 	char *key = NULL;
 	struct cond_bool_datum *booldatum;
 	__le32 buf[3];
-	u32 len;
+	u32 len, val;
 	int rc;
 
 	booldatum = kzalloc(sizeof(*booldatum), GFP_KERNEL);
@@ -223,11 +216,12 @@ int cond_read_bool(struct policydb *p, struct symtab *s, struct policy_file *fp)
 		goto err;
 
 	booldatum->value = le32_to_cpu(buf[0]);
-	booldatum->state = le32_to_cpu(buf[1]);
+	val = le32_to_cpu(buf[1]);
 
 	rc = -EINVAL;
-	if (!bool_isvalid(booldatum))
+	if (val != 0 && val != 1)
 		goto err;
+	booldatum->state = (int)val;
 
 	len = le32_to_cpu(buf[2]);
 
@@ -241,6 +235,7 @@ int cond_read_bool(struct policydb *p, struct symtab *s, struct policy_file *fp)
 
 	return 0;
 err:
+	pr_err("SELinux: conditional: failed to read boolean\n");
 	cond_destroy_bool(key, booldatum, NULL);
 	return rc;
 }
@@ -342,8 +337,8 @@ static int cond_read_av_list(struct policydb *p, struct policy_file *fp,
 	data.other = other;
 	for (i = 0; i < len; i++) {
 		data.dst = &list->nodes[i];
-		rc = avtab_read_item(&p->te_cond_avtab, fp, p, cond_insertf,
-				     &data);
+		rc = avtab_read_item(&p->te_cond_avtab, fp, p, true,
+				     cond_insertf, &data);
 		if (rc) {
 			kfree(list->nodes);
 			list->nodes = NULL;
@@ -362,7 +357,8 @@ static int expr_node_isvalid(struct policydb *p, struct cond_expr_node *expr)
 		return 0;
 	}
 
-	if (expr->boolean > p->p_bools.nprim) {
+	if (expr->expr_type == COND_BOOL &&
+	    (expr->boolean == 0 || expr->boolean > p->p_bools.nprim)) {
 		pr_err("SELinux: conditional expressions uses unknown bool.\n");
 		return 0;
 	}
diff --git a/security/selinux/ss/constraint.h b/security/selinux/ss/constraint.h
index 203033cfad67..26ffdb8c1c29 100644
--- a/security/selinux/ss/constraint.h
+++ b/security/selinux/ss/constraint.h
@@ -50,7 +50,7 @@ struct constraint_expr {
 	u32 op; /* operator */
 
 	struct ebitmap names; /* names */
-	struct type_set *type_names;
+	struct type_set *type_names; /* (unused) */
 
 	struct constraint_expr *next; /* next expression */
 };
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 493969c4e4fd..1157e66b4664 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -629,13 +629,11 @@ static int sens_index(void *key, void *datum, void *datap)
 	levdatum = datum;
 	p = datap;
 
-	if (!levdatum->isalias) {
-		if (!levdatum->level.sens ||
-		    levdatum->level.sens > p->p_levels.nprim)
-			return -EINVAL;
+	if (!levdatum->level.sens || levdatum->level.sens > p->p_levels.nprim)
+		return -EINVAL;
 
+	if (!levdatum->isalias)
 		p->sym_val_to_name[SYM_LEVELS][levdatum->level.sens - 1] = key;
-	}
 
 	return 0;
 }
@@ -648,12 +646,11 @@ static int cat_index(void *key, void *datum, void *datap)
 	catdatum = datum;
 	p = datap;
 
-	if (!catdatum->isalias) {
-		if (!catdatum->value || catdatum->value > p->p_cats.nprim)
-			return -EINVAL;
+	if (!catdatum->value || catdatum->value > p->p_cats.nprim)
+		return -EINVAL;
 
+	if (!catdatum->isalias)
 		p->sym_val_to_name[SYM_CATS][catdatum->value - 1] = key;
-	}
 
 	return 0;
 }
@@ -1131,6 +1128,9 @@ static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *f
 
 	len = le32_to_cpu(buf[0]);
 	perdatum->value = le32_to_cpu(buf[1]);
+	rc = -EINVAL;
+	if (perdatum->value < 1 || perdatum->value > 32)
+		goto bad;
 
 	rc = str_read(&key, GFP_KERNEL, fp, len);
 	if (rc)
@@ -1165,6 +1165,9 @@ static int common_read(struct policydb *p, struct symtab *s, struct policy_file
 	len = le32_to_cpu(buf[0]);
 	comdatum->value = le32_to_cpu(buf[1]);
 	nel = le32_to_cpu(buf[3]);
+	rc = -EINVAL;
+	if (nel > 32)
+		goto bad;
 
 	rc = symtab_init(&comdatum->permissions, nel);
 	if (rc)
@@ -1330,6 +1333,9 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 	len = le32_to_cpu(buf[0]);
 	len2 = le32_to_cpu(buf[1]);
 	nel = le32_to_cpu(buf[4]);
+	rc = -EINVAL;
+	if (nel > 32)
+		goto bad;
 
 	val = le32_to_cpu(buf[2]);
 	rc = -EINVAL;
@@ -1391,16 +1397,59 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 		if (rc)
 			goto bad;
 
-		cladatum->default_user = le32_to_cpu(buf[0]);
-		cladatum->default_role = le32_to_cpu(buf[1]);
-		cladatum->default_range = le32_to_cpu(buf[2]);
+		rc = -EINVAL;
+		val = le32_to_cpu(buf[0]);
+		switch (val) {
+		case 0:
+		case DEFAULT_SOURCE:
+		case DEFAULT_TARGET:
+			cladatum->default_user = val;
+			break;
+		default:
+			goto bad;
+		}
+		val = le32_to_cpu(buf[1]);
+		switch (val) {
+		case 0:
+		case DEFAULT_SOURCE:
+		case DEFAULT_TARGET:
+			cladatum->default_role = val;
+			break;
+		default:
+			goto bad;
+		}
+		val = le32_to_cpu(buf[2]);
+		switch (val) {
+		case 0:
+		case DEFAULT_SOURCE_LOW:
+		case DEFAULT_SOURCE_HIGH:
+		case DEFAULT_SOURCE_LOW_HIGH:
+		case DEFAULT_TARGET_LOW:
+		case DEFAULT_TARGET_HIGH:
+		case DEFAULT_TARGET_LOW_HIGH:
+		case DEFAULT_GLBLUB:
+			cladatum->default_range = val;
+			break;
+		default:
+			goto bad;
+		}
 	}
 
 	if (p->policyvers >= POLICYDB_VERSION_DEFAULT_TYPE) {
 		rc = next_entry(buf, fp, sizeof(u32) * 1);
 		if (rc)
 			goto bad;
-		cladatum->default_type = le32_to_cpu(buf[0]);
+		rc = -EINVAL;
+		val = le32_to_cpu(buf[0]);
+		switch (val) {
+		case 0:
+		case DEFAULT_TARGET:
+		case DEFAULT_SOURCE:
+			cladatum->default_type = val;
+			break;
+		default:
+			goto bad;
+		}
 	}
 
 	rc = symtab_insert(s, key, cladatum);
@@ -1410,6 +1459,8 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 	return 0;
 bad:
 	cls_destroy(key, cladatum, NULL);
+	if (rc)
+		pr_err("SELinux:  invalid class\n");
 	return rc;
 }
 
@@ -1522,7 +1573,7 @@ static int type_read(struct policydb *p, struct symtab *s, struct policy_file *f
  * Read a MLS level structure from a policydb binary
  * representation file.
  */
-static int mls_read_level(struct mls_level *lp, struct policy_file *fp)
+static int mls_read_level(const struct policydb *p, struct mls_level *lp, struct policy_file *fp)
 {
 	__le32 buf[1];
 	int rc;
@@ -1581,7 +1632,7 @@ static int user_read(struct policydb *p, struct symtab *s, struct policy_file *f
 		rc = mls_read_range_helper(&usrdatum->range, fp);
 		if (rc)
 			goto bad;
-		rc = mls_read_level(&usrdatum->dfltlevel, fp);
+		rc = mls_read_level(p, &usrdatum->dfltlevel, fp);
 		if (rc)
 			goto bad;
 	}
@@ -1601,7 +1652,7 @@ static int sens_read(struct policydb *p, struct symtab *s, struct policy_file *f
 	struct level_datum *levdatum;
 	int rc;
 	__le32 buf[2];
-	u32 len;
+	u32 len, val;
 
 	levdatum = kzalloc(sizeof(*levdatum), GFP_KERNEL);
 	if (!levdatum)
@@ -1612,13 +1663,17 @@ static int sens_read(struct policydb *p, struct symtab *s, struct policy_file *f
 		goto bad;
 
 	len = le32_to_cpu(buf[0]);
-	levdatum->isalias = le32_to_cpu(buf[1]);
+	val = le32_to_cpu(buf[1]);
+	rc = -EINVAL;
+	if (val != 0 && val != 1)
+		goto bad;
+	levdatum->isalias = val;
 
 	rc = str_read(&key, GFP_KERNEL, fp, len);
 	if (rc)
 		goto bad;
 
-	rc = mls_read_level(&levdatum->level, fp);
+	rc = mls_read_level(p, &levdatum->level, fp);
 	if (rc)
 		goto bad;
 
@@ -1628,6 +1683,8 @@ static int sens_read(struct policydb *p, struct symtab *s, struct policy_file *f
 	return 0;
 bad:
 	sens_destroy(key, levdatum, NULL);
+	if (rc)
+		pr_err("SELinux:  invalid sensitivity\n");
 	return rc;
 }
 
@@ -1637,7 +1694,7 @@ static int cat_read(struct policydb *p, struct symtab *s, struct policy_file *fp
 	struct cat_datum *catdatum;
 	int rc;
 	__le32 buf[3];
-	u32 len;
+	u32 len, val;
 
 	catdatum = kzalloc(sizeof(*catdatum), GFP_KERNEL);
 	if (!catdatum)
@@ -1649,7 +1706,11 @@ static int cat_read(struct policydb *p, struct symtab *s, struct policy_file *fp
 
 	len = le32_to_cpu(buf[0]);
 	catdatum->value = le32_to_cpu(buf[1]);
-	catdatum->isalias = le32_to_cpu(buf[2]);
+	val = le32_to_cpu(buf[2]);
+	rc = -EINVAL;
+	if (val != 0 && val != 1)
+		goto bad;
+	catdatum->isalias = val;
 
 	rc = str_read(&key, GFP_KERNEL, fp, len);
 	if (rc)
@@ -1661,6 +1722,8 @@ static int cat_read(struct policydb *p, struct symtab *s, struct policy_file *fp
 	return 0;
 bad:
 	cat_destroy(key, catdatum, NULL);
+	if (rc)
+		pr_err("SELinux:  invalid category\n");
 	return rc;
 }
 
@@ -1914,6 +1977,8 @@ static int range_read(struct policydb *p, struct policy_file *fp)
 out:
 	kfree(rt);
 	kfree(r);
+	if (rc)
+		pr_err("SELinux:  invalid range\n");
 	return rc;
 }
 
@@ -1941,10 +2006,14 @@ static int filename_trans_read_helper_compat(struct policydb *p, struct policy_f
 	if (rc)
 		goto out;
 
+	rc = -EINVAL;
 	stype = le32_to_cpu(buf[0]);
+	if (!policydb_type_isvalid(p, stype))
+		goto out;
 	key.ttype = le32_to_cpu(buf[1]);
+	if (!policydb_type_isvalid(p, key.ttype))
+		goto out;
 	val = le32_to_cpu(buf[2]);
-	rc = -EINVAL;
 	if (val > U16_MAX || !policydb_class_isvalid(p, val))
 		goto out;
 	key.tclass = val;
@@ -2003,6 +2072,9 @@ static int filename_trans_read_helper_compat(struct policydb *p, struct policy_f
 	kfree(ft);
 	kfree(name);
 	kfree(datum);
+
+	if (rc)
+		pr_err("SELinux:  invalid compat filename transition\n");
 	return rc;
 }
 
@@ -2031,7 +2103,10 @@ static int filename_trans_read_helper(struct policydb *p, struct policy_file *fp
 	if (rc)
 		goto out;
 
+	rc = -EINVAL;
 	ttype = le32_to_cpu(buf[0]);
+	if (!policydb_type_isvalid(p, ttype))
+		goto out;
 	val = le32_to_cpu(buf[1]);
 	rc = -EINVAL;
 	if (val > U16_MAX || !policydb_class_isvalid(p, val))
@@ -2066,6 +2141,10 @@ static int filename_trans_read_helper(struct policydb *p, struct policy_file *fp
 
 		datum->otype = le32_to_cpu(buf[0]);
 
+		rc = -EINVAL;
+		if (!policydb_type_isvalid(p, datum->otype))
+			goto out;
+
 		dst = &datum->next;
 	}
 
@@ -2097,6 +2176,9 @@ static int filename_trans_read_helper(struct policydb *p, struct policy_file *fp
 		ebitmap_destroy(&datum->stypes);
 		kfree(datum);
 	}
+
+	if (rc)
+		pr_err("SELinux:  invalid filename transition\n");
 	return rc;
 }
 
@@ -2216,7 +2298,7 @@ static int genfs_read(struct policydb *p, struct policy_file *fp)
 
 			rc = -EINVAL;
 			val = le32_to_cpu(buf[0]);
-			if (val >= U16_MAX)
+			if (val >= U16_MAX || (val != 0 && !policydb_class_isvalid(p, val)))
 				goto out;
 			newc->v.sclass = val;
 			rc = context_read_and_validate(&newc->context[0], p,
@@ -2255,6 +2337,9 @@ static int genfs_read(struct policydb *p, struct policy_file *fp)
 	}
 	ocontext_destroy(newc, OCON_FSUSE);
 
+	if (rc)
+		pr_err("SELinux:  invalid genfs\n");
+
 	return rc;
 }
 
@@ -2263,7 +2348,7 @@ static int ocontext_read(struct policydb *p,
 {
 	int rc;
 	unsigned int i;
-	u32 j, nel, len;
+	u32 j, nel, len, val;
 	__be64 prefixbuf[1];
 	__le32 buf[3];
 	struct ocontext *l, *c;
@@ -2327,11 +2412,25 @@ static int ocontext_read(struct policydb *p,
 				rc = next_entry(buf, fp, sizeof(u32) * 3);
 				if (rc)
 					goto out;
-				c->u.port.protocol = le32_to_cpu(buf[0]);
-				c->u.port.low_port = le32_to_cpu(buf[1]);
-				c->u.port.high_port = le32_to_cpu(buf[2]);
-				rc = context_read_and_validate(&c->context[0],
-							       p, fp);
+
+				rc = -EINVAL;
+				val = le32_to_cpu(buf[0]);
+				if (val > U8_MAX)
+					goto out;
+				c->u.port.protocol = val;
+				val = le32_to_cpu(buf[1]);
+				if (val > U16_MAX)
+					goto out;
+				c->u.port.low_port = val;
+				val = le32_to_cpu(buf[2]);
+				if (val > U16_MAX)
+					goto out;
+				c->u.port.high_port = val;
+				if (c->u.port.low_port == 0 ||
+				    c->u.port.low_port > c->u.port.high_port)
+					goto out;
+
+				rc = context_read_and_validate(&c->context[0], p, fp);
 				if (rc)
 					goto out;
 				break;
@@ -2449,6 +2548,8 @@ static int ocontext_read(struct policydb *p,
 	}
 	rc = 0;
 out:
+	if (rc)
+		pr_err("SELinux:  invalid ocon\n");
 	return rc;
 }
 
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 6d685a3fc080..4d278583c172 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -74,7 +74,7 @@ struct class_datum {
 /* Role attributes */
 struct role_datum {
 	u32 value; /* internal role value */
-	u32 bounds; /* boundary of role */
+	u32 bounds; /* boundary of role, 0 for none */
 	struct ebitmap dominates; /* set of roles dominated by this role */
 	struct ebitmap types; /* set of authorized types for role */
 };
@@ -110,15 +110,15 @@ struct role_allow {
 /* Type attributes */
 struct type_datum {
 	u32 value; /* internal type value */
-	u32 bounds; /* boundary of type */
-	unsigned char primary; /* primary name? */
+	u32 bounds; /* boundary of type, 0 for none */
+	unsigned char primary; /* primary name? (unused) */
 	unsigned char attribute; /* attribute ?*/
 };
 
 /* User attributes */
 struct user_datum {
 	u32 value; /* internal user value */
-	u32 bounds; /* bounds of user */
+	u32 bounds; /* bounds of user, 0 for none */
 	struct ebitmap roles; /* set of authorized roles for user */
 	struct mls_range range; /* MLS range (min - max) for user */
 	struct mls_level dfltlevel; /* default login MLS level for user */
@@ -195,7 +195,7 @@ struct ocontext {
 		} ibendport;
 	} u;
 	union {
-		u16 sclass; /* security class for genfs */
+		u16 sclass; /* security class for genfs (can be 0 for wildcard) */
 		u32 behavior; /* labeling behavior for fs_use */
 	} v;
 	struct context context[2]; /* security context(s) */
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 835b2ac49562..d8b5fb98adb9 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -445,8 +445,6 @@ static int dump_masked_av_helper(void *k, void *d, void *args)
 	struct perm_datum *pdatum = d;
 	char **permission_names = args;
 
-	BUG_ON(pdatum->value < 1 || pdatum->value > 32);
-
 	permission_names[pdatum->value - 1] = (char *)k;
 
 	return 0;
-- 
2.45.2

