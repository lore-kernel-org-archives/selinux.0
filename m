Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9107207DF2;
	Mon, 16 Dec 2024 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367309; cv=none; b=QGmHjLdlXwfRZ6qwVzfcuzQ8fO2ylOGLhHcN5qTacxTbIcxNn+/WRV0xbLqRcySQzgGn27q3r0zqLTdoSt4Yh4ZfsUO0C73DwiDkCGVl27Q1h3rELG8OyiFGvayPWFactTaq16MBHKS5AcedwCGAvMJII/XdIarhNXcxZ6wrTyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367309; c=relaxed/simple;
	bh=NIRUjF0BRQDsH8NsLDoSYwaN+cWgWlDFxRlnILHhTxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dXCjgOgEgg2WOK9go7ct4NKcsKf1lGGkIKKf/1868TL8CrNkKbTpPPhytEp+EitVwzhJY/RAlXSH9c8w+u8FZoFNcFcUjqUmut/hmJZ15ZrEIH2+pqwYjXBpTF7TVB5SldBGQ/kiDR3nBeuA+NnQxC1r/tU9bwSWn0f+nKSuodU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=KL/21jM1; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="KL/21jM1"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1734367305;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p/3ldZnZ2LjOafyX7/DtDX8k1xnhVFEOy2UJw5iqciU=;
	b=KL/21jM1Z614JEG0oCA3nsJTlPp4uFqdj3maclaV9fXBoQvW8Y2Ub3fak9UxwhSPnDUwqM
	a3eGY9WiD0C0anL1fEfN0QpiB3rDw3ZakL9K3dGtUVl81D8orh3Y1G5CzScGH+eYSdGghz
	0UWtH3TFhF3tfYth4/njuBEWIUIUwB3edoI9R+wgtWOULY6voDjJ16hzItO2GrakvMEFeF
	Y5t/3kiCG41T3UAHBsNXktOWy0gZAWJ1SjQpcYEsOjfYBns3DK1UrdReVNEOnzGza81Dkf
	y2pSsVnz9G92szT6KHYpXWaqAYIT+18H2ZQh7HIC6TDDtuS8cqDRvBj9bAlO1A==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
	=?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Eric Suen <ericsu@linux.microsoft.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Canfeng Guo <guocanfeng@uniontech.com>,
	GUO Zihua <guozihua@huawei.com>
Subject: [RFC PATCH v2 11/22] selinux: more strict policy parsing
Date: Mon, 16 Dec 2024 17:40:09 +0100
Message-ID: <20241216164055.96267-11-cgoettsche@seltendoof.de>
In-Reply-To: <20241216164055.96267-1-cgoettsche@seltendoof.de>
References: <20241216164055.96267-1-cgoettsche@seltendoof.de>
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
v2:
  accept unknown xperm specifiers to support backwards compatibility for
  future ones, suggested by Thiébaud
---
 security/selinux/ss/avtab.c       |  37 +++++--
 security/selinux/ss/conditional.c |  18 ++--
 security/selinux/ss/constraint.h  |   2 +-
 security/selinux/ss/policydb.c    | 157 ++++++++++++++++++++++++------
 security/selinux/ss/policydb.h    |  19 +++-
 security/selinux/ss/services.c    |   2 -
 6 files changed, 182 insertions(+), 53 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index c2c31521cace..3bd949a200ef 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -349,7 +349,7 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
 	struct avtab_extended_perms xperms;
 	__le32 buf32[ARRAY_SIZE(xperms.perms.p)];
 	int rc;
-	unsigned int set, vers = pol->policyvers;
+	unsigned int vers = pol->policyvers;
 
 	memset(&key, 0, sizeof(struct avtab_key));
 	memset(&datum, 0, sizeof(struct avtab_datum));
@@ -361,8 +361,8 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
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
@@ -391,6 +391,13 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
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
 
@@ -409,6 +416,11 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
 
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
@@ -444,9 +456,13 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
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
 
@@ -471,6 +487,15 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
 			pr_err("SELinux: avtab: truncated entry\n");
 			return rc;
 		}
+		switch (xperms.specified) {
+		case AVTAB_XPERMS_IOCTLFUNCTION:
+		case AVTAB_XPERMS_IOCTLDRIVER:
+		case AVTAB_XPERMS_NLMSG:
+			break;
+		default:
+			pr_warn_once_policyload(pol, "SELinux: avtab: unsupported xperm specifier %#x\n",
+						xperms.specified);
+		}
 		rc = next_entry(&xperms.driver, fp, sizeof(u8));
 		if (rc) {
 			pr_err("SELinux: avtab: truncated entry\n");
diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 1bebfcb9c6a1..35442f4ceedf 100644
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
index eeca470cc90c..1275fd7d9148 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -634,13 +634,11 @@ static int sens_index(void *key, void *datum, void *datap)
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
@@ -653,12 +651,11 @@ static int cat_index(void *key, void *datum, void *datap)
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
@@ -1136,6 +1133,9 @@ static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *f
 
 	len = le32_to_cpu(buf[0]);
 	perdatum->value = le32_to_cpu(buf[1]);
+	rc = -EINVAL;
+	if (perdatum->value < 1 || perdatum->value > 32)
+		goto bad;
 
 	rc = str_read(&key, GFP_KERNEL, fp, len);
 	if (rc)
@@ -1170,6 +1170,9 @@ static int common_read(struct policydb *p, struct symtab *s, struct policy_file
 	len = le32_to_cpu(buf[0]);
 	comdatum->value = le32_to_cpu(buf[1]);
 	nel = le32_to_cpu(buf[3]);
+	rc = -EINVAL;
+	if (nel > 32)
+		goto bad;
 
 	rc = symtab_init(&comdatum->permissions, nel);
 	if (rc)
@@ -1335,6 +1338,9 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 	len = le32_to_cpu(buf[0]);
 	len2 = le32_to_cpu(buf[1]);
 	nel = le32_to_cpu(buf[4]);
+	rc = -EINVAL;
+	if (nel > 32)
+		goto bad;
 
 	val = le32_to_cpu(buf[2]);
 	rc = -EINVAL;
@@ -1396,16 +1402,59 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
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
@@ -1415,6 +1464,8 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 	return 0;
 bad:
 	cls_destroy(key, cladatum, NULL);
+	if (rc)
+		pr_err("SELinux:  invalid class\n");
 	return rc;
 }
 
@@ -1527,7 +1578,7 @@ static int type_read(struct policydb *p, struct symtab *s, struct policy_file *f
  * Read a MLS level structure from a policydb binary
  * representation file.
  */
-static int mls_read_level(struct mls_level *lp, struct policy_file *fp)
+static int mls_read_level(const struct policydb *p, struct mls_level *lp, struct policy_file *fp)
 {
 	__le32 buf[1];
 	int rc;
@@ -1586,7 +1637,7 @@ static int user_read(struct policydb *p, struct symtab *s, struct policy_file *f
 		rc = mls_read_range_helper(&usrdatum->range, fp);
 		if (rc)
 			goto bad;
-		rc = mls_read_level(&usrdatum->dfltlevel, fp);
+		rc = mls_read_level(p, &usrdatum->dfltlevel, fp);
 		if (rc)
 			goto bad;
 	}
@@ -1606,7 +1657,7 @@ static int sens_read(struct policydb *p, struct symtab *s, struct policy_file *f
 	struct level_datum *levdatum;
 	int rc;
 	__le32 buf[2];
-	u32 len;
+	u32 len, val;
 
 	levdatum = kzalloc(sizeof(*levdatum), GFP_KERNEL);
 	if (!levdatum)
@@ -1617,13 +1668,17 @@ static int sens_read(struct policydb *p, struct symtab *s, struct policy_file *f
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
 
@@ -1633,6 +1688,8 @@ static int sens_read(struct policydb *p, struct symtab *s, struct policy_file *f
 	return 0;
 bad:
 	sens_destroy(key, levdatum, NULL);
+	if (rc)
+		pr_err("SELinux:  invalid sensitivity\n");
 	return rc;
 }
 
@@ -1642,7 +1699,7 @@ static int cat_read(struct policydb *p, struct symtab *s, struct policy_file *fp
 	struct cat_datum *catdatum;
 	int rc;
 	__le32 buf[3];
-	u32 len;
+	u32 len, val;
 
 	catdatum = kzalloc(sizeof(*catdatum), GFP_KERNEL);
 	if (!catdatum)
@@ -1654,7 +1711,11 @@ static int cat_read(struct policydb *p, struct symtab *s, struct policy_file *fp
 
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
@@ -1666,6 +1727,8 @@ static int cat_read(struct policydb *p, struct symtab *s, struct policy_file *fp
 	return 0;
 bad:
 	cat_destroy(key, catdatum, NULL);
+	if (rc)
+		pr_err("SELinux:  invalid category\n");
 	return rc;
 }
 
@@ -1919,6 +1982,8 @@ static int range_read(struct policydb *p, struct policy_file *fp)
 out:
 	kfree(rt);
 	kfree(r);
+	if (rc)
+		pr_err("SELinux:  invalid range\n");
 	return rc;
 }
 
@@ -1946,10 +2011,14 @@ static int filename_trans_read_helper_compat(struct policydb *p, struct policy_f
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
@@ -2008,6 +2077,9 @@ static int filename_trans_read_helper_compat(struct policydb *p, struct policy_f
 	kfree(ft);
 	kfree(name);
 	kfree(datum);
+
+	if (rc)
+		pr_err("SELinux:  invalid compat filename transition\n");
 	return rc;
 }
 
@@ -2036,7 +2108,10 @@ static int filename_trans_read_helper(struct policydb *p, struct policy_file *fp
 	if (rc)
 		goto out;
 
+	rc = -EINVAL;
 	ttype = le32_to_cpu(buf[0]);
+	if (!policydb_type_isvalid(p, ttype))
+		goto out;
 	val = le32_to_cpu(buf[1]);
 	rc = -EINVAL;
 	if (val > U16_MAX || !policydb_class_isvalid(p, val))
@@ -2071,6 +2146,10 @@ static int filename_trans_read_helper(struct policydb *p, struct policy_file *fp
 
 		datum->otype = le32_to_cpu(buf[0]);
 
+		rc = -EINVAL;
+		if (!policydb_type_isvalid(p, datum->otype))
+			goto out;
+
 		dst = &datum->next;
 	}
 
@@ -2102,6 +2181,9 @@ static int filename_trans_read_helper(struct policydb *p, struct policy_file *fp
 		ebitmap_destroy(&datum->stypes);
 		kfree(datum);
 	}
+
+	if (rc)
+		pr_err("SELinux:  invalid filename transition\n");
 	return rc;
 }
 
@@ -2221,7 +2303,7 @@ static int genfs_read(struct policydb *p, struct policy_file *fp)
 
 			rc = -EINVAL;
 			val = le32_to_cpu(buf[0]);
-			if (val >= U16_MAX)
+			if (val >= U16_MAX || (val != 0 && !policydb_class_isvalid(p, val)))
 				goto out;
 			newc->v.sclass = val;
 			rc = context_read_and_validate(&newc->context[0], p,
@@ -2260,6 +2342,9 @@ static int genfs_read(struct policydb *p, struct policy_file *fp)
 	}
 	ocontext_destroy(newc, OCON_FSUSE);
 
+	if (rc)
+		pr_err("SELinux:  invalid genfs\n");
+
 	return rc;
 }
 
@@ -2268,7 +2353,7 @@ static int ocontext_read(struct policydb *p,
 {
 	int rc;
 	unsigned int i;
-	u32 j, nel, len;
+	u32 j, nel, len, val;
 	__be64 prefixbuf[1];
 	__le32 buf[3];
 	struct ocontext *l, *c;
@@ -2332,11 +2417,25 @@ static int ocontext_read(struct policydb *p,
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
@@ -2454,6 +2553,8 @@ static int ocontext_read(struct policydb *p,
 	}
 	rc = 0;
 out:
+	if (rc)
+		pr_err("SELinux:  invalid ocon\n");
 	return rc;
 }
 
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 0c423ad77fd9..690dc4a00cf3 100644
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
@@ -391,4 +391,13 @@ extern int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len);
 extern u16 string_to_security_class(struct policydb *p, const char *name);
 extern u32 string_to_av_perm(struct policydb *p, u16 tclass, const char *name);
 
+#define pr_warn_once_policyload(policy, fmt, ...)                        \
+	do {                                                             \
+		static void *prev_policy__;                              \
+		if (policy != prev_policy__) {                           \
+			printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__); \
+			policy = prev_policy__;                          \
+		}                                                        \
+	} while (0)
+
 #endif /* _SS_POLICYDB_H_ */
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 28c0bdf9fc9d..d5725c768d59 100644
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

