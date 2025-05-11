Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEED22609EF;
	Sun, 11 May 2025 17:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746984696; cv=none; b=n1lLzqh96V5gg1h3jDMIhji4M0MPKmNzrFYbgNwAAFRpi4u8r+8+XD9SGHbuvht7oMTIwPmO3/GvyfD5HqiAcIZSGPj7c5lHoHCY/2PA86E/JRyN0VrtfwKVRmeV2BXPw+dWzEqdO3/ZrNqaSAEPaUK8MYz2qtqyxA60ISwUW8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746984696; c=relaxed/simple;
	bh=rxZEfUZ5W3iHtqgfF5czMXk3lQgQjYnfyKoOiPfHocA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihnbw7X8w5nvWirpw9sFG3BkL+QBkoQfj+wi1qj8tuXYz++B4UlQwv+GXuum3AgvZrxC60a84Lzw6mvxeLDWnQbTiJo19NaNyLiZL3k0tEqBLJcWD6OnXgTUaL/s0dgDx8tsf+oJt8nJWbrO8XgH3ztXXRbmZ+LUG+ezJfWVFOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=P9qTHkGa; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="P9qTHkGa"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1746984692;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gm7iOVqgBDlzJpKq2ZWdm3OwTlZEEx36JtdddVyhurg=;
	b=P9qTHkGam0WS0zXCjZRasczIDOM0ACfW9AGXI8k4S75CpRgFwtXr7lYwIvf9LbwkjolWaW
	Xj65MJSAR+56ChJ1enEmGI64HchjNKo9GDjp3tVShPIBZOXwK6abq3OzxggJfkBTnfrvb7
	uIgJ3fPs1i06pnpB33I1OL1mS/+TFySpZYrDq7G9KE33eCUO1T8cGxeiMz9z5YFDiVMwzb
	x1eAKbsVwpSd0XDTxygLp3GkDH13IkpowCpKTHwZ/hRemOtw3C5yVcwvBugOQ/QCC5G0e+
	rXGIYXHoPaV4KQlActo+CD0QM2lmN5orSiSTPm0AIFUOo7POM3s1PmPR/v7+4A==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/14] selinux: restrict policy strings
Date: Sun, 11 May 2025 19:30:13 +0200
Message-ID: <20250511173055.406906-13-cgoettsche@seltendoof.de>
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

Validate the characters and the lengths of strings parsed from binary
policies.

  * Disallow control characters
  * Limit characters of identifiers to alphanumeric, underscore, dash,
    and dot
  * Limit identifiers in length to 64, expect types to 1024,
    sensitivities to 32 and categories to 16, characters
    (excluding NUL-terminator)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3:
  - introduce a central limits.h header
  - add limits for all kinds of string: filesystem names, filetrans
    keys, genfs paths, infiniband device names
v2:
  - add wrappers for str_read() to minimize the usage of magic numbers
  - limit sensitivities to a length of 32, to match categories,
    suggested by Daniel
---
 security/selinux/include/limits.h | 90 +++++++++++++++++++++++++++++++
 security/selinux/ss/conditional.c |  5 +-
 security/selinux/ss/conditional.h |  2 -
 security/selinux/ss/constraint.h  |  2 -
 security/selinux/ss/policydb.c    | 78 ++++++++++++++++++---------
 security/selinux/ss/policydb.h    | 51 +++++++++++++++++-
 6 files changed, 196 insertions(+), 32 deletions(-)
 create mode 100644 security/selinux/include/limits.h

diff --git a/security/selinux/include/limits.h b/security/selinux/include/limits.h
new file mode 100644
index 000000000000..d267c0c64f49
--- /dev/null
+++ b/security/selinux/include/limits.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Limits for various policy database elements.
+ */
+
+/*
+ * Maximum supported depth of conditional expressions.
+ */
+#define COND_EXPR_MAXDEPTH 10
+
+/*
+ * Maximum supported depth for constraint expressions.
+ */
+#define CEXPR_MAXDEPTH 5
+
+/*
+ * Maximum supported identifier value.
+ *
+ * Reasoning: The most used symbols are types and they need to fit into
+ *            an u16 for the avtab entries. Keep U16_MAX as special value
+ *            and U16_MAX-1 to avoid accidental overflows into U16_MAX.
+ */
+#define IDENTIFIER_MAXVALUE (U16_MAX - 2)
+
+/*
+ * Maximum supported length of security context strings.
+ *
+ * Reasoning: The string must fir into a PAGE_SIZE.
+ */
+#define CONTEXT_MAXLENGTH 4000
+
+/*
+ * Maximum supported boolean name length.
+ */
+#define BOOLEAN_NAME_MAXLENGTH 64
+
+/*
+ * Maximum supported security class and common class name length.
+ */
+#define CLASS_NAME_MAXLENGTH 64
+
+/*
+ * Maximum supported permission name length.
+ */
+#define PERMISSION_NAME_MAXLENGTH 64
+
+/*
+ * Maximum supported user name length.
+ */
+#define USER_NAME_MAXLENGTH 64
+
+/*
+ * Maximum supported role name length.
+ */
+#define ROLE_NAME_MAXLENGTH 64
+
+/*
+ * Maximum supported type name length.
+ */
+#define TYPE_NAME_MAXLENGTH 1024
+
+/*
+ * Maximum supported sensitivity name length.
+ */
+#define SENSITIVITY_NAME_MAXLENGTH 32
+
+/*
+ * Maximum supported category name length.
+ */
+#define CATEGORY_NAME_MAXLENGTH 16
+
+/*
+ * Maximum supported path name length for keys in filename transitions.
+ */
+#define FILETRANSKEY_NAME_MAXLENGTH 1024
+
+/*
+ * Maximum supported filesystem name length.
+ */
+#define FILESYSTEM_NAME_MAXLENGTH 128
+
+/*
+ * Maximum supported path prefix length for genfs statements.
+ */
+#define GENFS_PATH_MAXLENGTH 1024
+
+/*
+ * Maximum supported Infiniband device name length.
+ */
+#define INFINIBAND_DEVNAME_MAXLENGTH 256
diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index ce0281cce739..c0a2814dafdb 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -245,7 +245,8 @@ int cond_index_bool(void *key, void *datum, void *datap)
 	booldatum = datum;
 	p = datap;
 
-	if (!booldatum->value || booldatum->value > p->p_bools.nprim)
+	if (!booldatum->value || booldatum->value > p->p_bools.nprim ||
+	    booldatum->value > IDENTIFIER_MAXVALUE)
 		return -EINVAL;
 
 	p->sym_val_to_name[SYM_BOOLS][booldatum->value - 1] = key;
@@ -280,7 +281,7 @@ int cond_read_bool(struct policydb *p, struct symtab *s, struct policy_file *fp)
 
 	len = le32_to_cpu(buf[2]);
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read_bool(&key, GFP_KERNEL, fp, len);
 	if (rc)
 		goto err;
 
diff --git a/security/selinux/ss/conditional.h b/security/selinux/ss/conditional.h
index 468e98ad3ea1..d5aefcbaa1eb 100644
--- a/security/selinux/ss/conditional.h
+++ b/security/selinux/ss/conditional.h
@@ -12,8 +12,6 @@
 #include "policydb.h"
 #include "../include/conditional.h"
 
-#define COND_EXPR_MAXDEPTH 10
-
 /*
  * A conditional expression is a list of operators and operands
  * in reverse polish notation.
diff --git a/security/selinux/ss/constraint.h b/security/selinux/ss/constraint.h
index 1d75a8a044df..f986156de856 100644
--- a/security/selinux/ss/constraint.h
+++ b/security/selinux/ss/constraint.h
@@ -19,8 +19,6 @@
 
 #include "ebitmap.h"
 
-#define CEXPR_MAXDEPTH 5
-
 struct constraint_expr {
 #define CEXPR_NOT   1 /* not expr */
 #define CEXPR_AND   2 /* expr and expr */
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 2b098d9abf17..e64254985762 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -552,7 +552,8 @@ static int common_index(void *key, void *datum, void *datap)
 
 	comdatum = datum;
 	p = datap;
-	if (!comdatum->value || comdatum->value > p->p_commons.nprim)
+	if (!comdatum->value || comdatum->value > p->p_commons.nprim ||
+	    comdatum->value > IDENTIFIER_MAXVALUE)
 		return -EINVAL;
 
 	p->sym_val_to_name[SYM_COMMONS][comdatum->value - 1] = key;
@@ -567,7 +568,8 @@ static int class_index(void *key, void *datum, void *datap)
 
 	cladatum = datum;
 	p = datap;
-	if (!cladatum->value || cladatum->value > p->p_classes.nprim)
+	if (!cladatum->value || cladatum->value > p->p_classes.nprim ||
+	    cladatum->value > IDENTIFIER_MAXVALUE)
 		return -EINVAL;
 
 	p->sym_val_to_name[SYM_CLASSES][cladatum->value - 1] = key;
@@ -583,6 +585,7 @@ static int role_index(void *key, void *datum, void *datap)
 	role = datum;
 	p = datap;
 	if (!role->value || role->value > p->p_roles.nprim ||
+	    role->value > IDENTIFIER_MAXVALUE ||
 	    role->bounds > p->p_roles.nprim)
 		return -EINVAL;
 
@@ -601,6 +604,7 @@ static int type_index(void *key, void *datum, void *datap)
 
 	if (typdatum->primary) {
 		if (!typdatum->value || typdatum->value > p->p_types.nprim ||
+		    typdatum->value > IDENTIFIER_MAXVALUE ||
 		    typdatum->bounds > p->p_types.nprim)
 			return -EINVAL;
 		p->sym_val_to_name[SYM_TYPES][typdatum->value - 1] = key;
@@ -618,6 +622,7 @@ static int user_index(void *key, void *datum, void *datap)
 	usrdatum = datum;
 	p = datap;
 	if (!usrdatum->value || usrdatum->value > p->p_users.nprim ||
+	    usrdatum->value > IDENTIFIER_MAXVALUE ||
 	    usrdatum->bounds > p->p_users.nprim)
 		return -EINVAL;
 
@@ -634,7 +639,8 @@ static int sens_index(void *key, void *datum, void *datap)
 	levdatum = datum;
 	p = datap;
 
-	if (!levdatum->level.sens || levdatum->level.sens > p->p_levels.nprim)
+	if (!levdatum->level.sens || levdatum->level.sens > p->p_levels.nprim ||
+	    levdatum->level.sens > IDENTIFIER_MAXVALUE)
 		return -EINVAL;
 
 	if (!levdatum->isalias)
@@ -651,7 +657,8 @@ static int cat_index(void *key, void *datum, void *datap)
 	catdatum = datum;
 	p = datap;
 
-	if (!catdatum->value || catdatum->value > p->p_cats.nprim)
+	if (!catdatum->value || catdatum->value > p->p_cats.nprim ||
+	    catdatum->value > IDENTIFIER_MAXVALUE)
 		return -EINVAL;
 
 	if (!catdatum->isalias)
@@ -1226,8 +1233,9 @@ static int context_read_and_validate(struct context *c, struct policydb *p,
  * binary representation file.
  */
 
-int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
+int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len, int kind, u32 max_len)
 {
+	u32 i;
 	int rc;
 	char *str;
 
@@ -1237,19 +1245,35 @@ int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
 	if (size_check(sizeof(char), len, fp))
 		return -EINVAL;
 
+	if (len > max_len)
+		return -EINVAL;
+
 	str = kmalloc(len + 1, flags | __GFP_NOWARN);
 	if (!str)
 		return -ENOMEM;
 
 	rc = next_entry(str, fp, len);
-	if (rc) {
-		kfree(str);
-		return rc;
+	if (rc)
+		goto bad_str;
+
+	rc = -EINVAL;
+	for (i = 0; i < len; i++) {
+		if (iscntrl(str[i]))
+			goto bad_str;
+
+		if (kind == STR_IDENTIFIER &&
+		    !(isalnum(str[i]) || str[i] == '_' || str[i] == '-' || str[i] == '.'))
+			goto bad_str;
+
 	}
 
 	str[len] = '\0';
 	*strp = str;
 	return 0;
+
+bad_str:
+	kfree(str);
+	return rc;
 }
 
 static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *fp)
@@ -1274,7 +1298,7 @@ static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *f
 	if (perdatum->value < 1 || perdatum->value > SEL_VEC_MAX)
 		goto bad;
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read_perm(&key, GFP_KERNEL, fp, len);
 	if (rc)
 		goto bad;
 
@@ -1321,7 +1345,7 @@ static int common_read(struct policydb *p, struct symtab *s, struct policy_file
 		goto bad;
 	comdatum->permissions.nprim = le32_to_cpu(buf[2]);
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read_class(&key, GFP_KERNEL, fp, len);
 	if (rc)
 		goto bad;
 
@@ -1559,12 +1583,12 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 
 	ncons = le32_to_cpu(buf[5]);
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read_class(&key, GFP_KERNEL, fp, len);
 	if (rc)
 		goto bad;
 
 	if (len2) {
-		rc = str_read(&cladatum->comkey, GFP_KERNEL, fp, len2);
+		rc = str_read_class(&cladatum->comkey, GFP_KERNEL, fp, len2);
 		if (rc)
 			goto bad;
 
@@ -1698,7 +1722,7 @@ static int role_read(struct policydb *p, struct symtab *s, struct policy_file *f
 	if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
 		role->bounds = le32_to_cpu(buf[2]);
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read_role(&key, GFP_KERNEL, fp, len);
 	if (rc)
 		goto bad;
 
@@ -1765,7 +1789,7 @@ static int type_read(struct policydb *p, struct symtab *s, struct policy_file *f
 		typdatum->primary = le32_to_cpu(buf[2]);
 	}
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read_type(&key, GFP_KERNEL, fp, len);
 	if (rc)
 		goto bad;
 
@@ -1829,7 +1853,7 @@ static int user_read(struct policydb *p, struct symtab *s, struct policy_file *f
 	if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
 		usrdatum->bounds = le32_to_cpu(buf[2]);
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read_user(&key, GFP_KERNEL, fp, len);
 	if (rc)
 		goto bad;
 
@@ -1878,7 +1902,7 @@ static int sens_read(struct policydb *p, struct symtab *s, struct policy_file *f
 		goto bad;
 	levdatum->isalias = val;
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read_sens(&key, GFP_KERNEL, fp, len);
 	if (rc)
 		goto bad;
 
@@ -1921,7 +1945,7 @@ static int cat_read(struct policydb *p, struct symtab *s, struct policy_file *fp
 		goto bad;
 	catdatum->isalias = val;
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read_cat(&key, GFP_KERNEL, fp, len);
 	if (rc)
 		goto bad;
 
@@ -2230,7 +2254,7 @@ static int filename_trans_read_helper_compat(struct policydb *p, struct policy_f
 	len = le32_to_cpu(buf[0]);
 
 	/* path component string */
-	rc = str_read(&name, GFP_KERNEL, fp, len);
+	rc = str_read(&name, GFP_KERNEL, fp, len, STR_UNCONSTRAINT, FILETRANSKEY_NAME_MAXLENGTH);
 	if (rc)
 		return rc;
 
@@ -2329,7 +2353,7 @@ static int filename_trans_read_helper(struct policydb *p, struct policy_file *fp
 	len = le32_to_cpu(buf[0]);
 
 	/* path component string */
-	rc = str_read(&name, GFP_KERNEL, fp, len);
+	rc = str_read(&name, GFP_KERNEL, fp, len, STR_UNCONSTRAINT, FILETRANSKEY_NAME_MAXLENGTH);
 	if (rc)
 		return rc;
 
@@ -2483,7 +2507,7 @@ static int genfs_read(struct policydb *p, struct policy_file *fp)
 		if (!newgenfs)
 			goto out;
 
-		rc = str_read(&newgenfs->fstype, GFP_KERNEL, fp, len);
+		rc = str_read_fsname(&newgenfs->fstype, GFP_KERNEL, fp, len);
 		if (rc)
 			goto out;
 
@@ -2522,7 +2546,8 @@ static int genfs_read(struct policydb *p, struct policy_file *fp)
 			if (!newc)
 				goto out;
 
-			rc = str_read(&newc->u.name, GFP_KERNEL, fp, len);
+			rc = str_read(&newc->u.name, GFP_KERNEL, fp, len,
+				      STR_UNCONSTRAINT, GENFS_PATH_MAXLENGTH);
 			if (rc)
 				goto out;
 
@@ -2625,7 +2650,7 @@ static int ocontext_read(struct policydb *p,
 					goto out;
 				len = le32_to_cpu(buf[0]);
 
-				rc = str_read(&c->u.name, GFP_KERNEL, fp, len);
+				rc = str_read_fsname(&c->u.name, GFP_KERNEL, fp, len);
 				if (rc)
 					goto out;
 
@@ -2693,7 +2718,7 @@ static int ocontext_read(struct policydb *p,
 					goto out;
 
 				len = le32_to_cpu(buf[1]);
-				rc = str_read(&c->u.name, GFP_KERNEL, fp, len);
+				rc = str_read_fsname(&c->u.name, GFP_KERNEL, fp, len);
 				if (rc)
 					goto out;
 
@@ -2759,7 +2784,9 @@ static int ocontext_read(struct policydb *p,
 				len = le32_to_cpu(buf[0]);
 
 				rc = str_read(&c->u.ibendport.dev_name,
-					      GFP_KERNEL, fp, len);
+					      GFP_KERNEL, fp, len,
+					      STR_UNCONSTRAINT,
+					      INFINIBAND_DEVNAME_MAXLENGTH);
 				if (rc)
 					goto out;
 
@@ -2827,7 +2854,8 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
 		goto bad;
 	}
 
-	rc = str_read(&policydb_str, GFP_KERNEL, fp, len);
+	rc = str_read(&policydb_str, GFP_KERNEL, fp, len,
+		      STR_UNCONSTRAINT, strlen(POLICYDB_STRING));
 	if (rc) {
 		if (rc == -ENOMEM) {
 			pr_err("SELinux:  unable to allocate memory for policydb string of length %d\n",
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index b4f0c1a754cf..e901ec648cbf 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -27,6 +27,7 @@
 #include "mls_types.h"
 #include "context.h"
 #include "constraint.h"
+#include "limits.h"
 
 /*
  * A datum type is defined for each kind of symbol
@@ -408,7 +409,55 @@ static inline bool val_is_boolean(u32 value)
 	return value == 0 || value == 1;
 }
 
-extern int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len);
+#define STR_UNCONSTRAINT 0
+#define STR_IDENTIFIER 1
+extern int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len,
+		    int kind, u32 max_len);
+
+static inline int str_read_bool(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
+{
+	return str_read(strp, flags, fp, len, STR_IDENTIFIER, BOOLEAN_NAME_MAXLENGTH);
+}
+
+static inline int str_read_cat(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
+{
+	return str_read(strp, flags, fp, len, STR_IDENTIFIER, CATEGORY_NAME_MAXLENGTH);
+}
+
+static inline int str_read_class(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
+{
+	return str_read(strp, flags, fp, len, STR_IDENTIFIER, CLASS_NAME_MAXLENGTH);
+}
+
+static inline int str_read_perm(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
+{
+	return str_read(strp, flags, fp, len, STR_IDENTIFIER, PERMISSION_NAME_MAXLENGTH);
+}
+
+static inline int str_read_role(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
+{
+	return str_read(strp, flags, fp, len, STR_IDENTIFIER, ROLE_NAME_MAXLENGTH);
+}
+
+static inline int str_read_sens(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
+{
+	return str_read(strp, flags, fp, len, STR_IDENTIFIER, SENSITIVITY_NAME_MAXLENGTH);
+}
+
+static inline int str_read_type(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
+{
+	return str_read(strp, flags, fp, len, STR_IDENTIFIER, TYPE_NAME_MAXLENGTH);
+}
+
+static inline int str_read_user(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
+{
+	return str_read(strp, flags, fp, len, STR_IDENTIFIER, USER_NAME_MAXLENGTH);
+}
+
+static inline int str_read_fsname(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
+{
+	return str_read(strp, flags, fp, len, STR_IDENTIFIER, FILESYSTEM_NAME_MAXLENGTH);
+}
 
 extern u16 string_to_security_class(struct policydb *p, const char *name);
 extern u32 string_to_av_perm(struct policydb *p, u16 tclass, const char *name);
-- 
2.49.0

