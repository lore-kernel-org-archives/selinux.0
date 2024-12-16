Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F3820CCD1;
	Mon, 16 Dec 2024 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367328; cv=none; b=mktjhVmS24Vfao50xMBLzp7BPWXYJ/5g7bZL7lf/TI3yB+GfL7a34YOmxYcLZs0yIavBDpS/+Mo03uTuQ6Qh0ze7tV6iHDYLwuh5oYiqi0Z0WHqx1pplNI0FDuVNaylsOw0Pjbrvc8gKfIAhNILLiVMEf5RD0I4Fg6N6EXRD8aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367328; c=relaxed/simple;
	bh=1SYwA0g32ypqQl32kOrrhYLQiQim+7qzgylRh/XwY2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CnfJBIcFGDrXeNpaUwC5oGR+KrcfPS+qMceOHJ0WYh/2ewFE0SUMNIykYBPhHyKf15Cq0Dj3SiNR2bwTJ3JzrUXky7OjmJdbZP5Pqeth+KxgEdaXAaGn4RVNyMK9QfJo+sa9pI7vf/1yFz8+A5TapXMYYE3EjQCIhNKKmbPVLzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=uS99ynv/; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="uS99ynv/"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1734367324;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SRvMvhawFK6Afxyl7ZQbG1LPkt6CtGJJ2wjMjUWxum0=;
	b=uS99ynv/TyvFVt09ZHaCJ9xD5wxINHMDFghV7UUGOrSTE8NriQ/mur+3ILoFnHwUQbk0vk
	D+wuQvLQZmgMihjb87D3K8WTnH0Lbn/UsTYA0tKjx7dMZYpqUsCJmMbDEGPo8Aq0OSkLK1
	JqnXZtrAs1UIS7faW4YgAg5FbJp/NckFueXq9Bj6c6OFhx4gbnUccKsKUUqFArKzoIIM7d
	JKKOeBV8i2rjytf21d2F1nejDl8W4lVPFiOMSfa9jVF2/ZIFVfEZUXfxzgrWBxAkltDtQo
	4eRaGKXn8Szy2TOsuPhIR1YSBPoQbU/VySTJfsdj+eHUwXpydzW8ZjDI1ui2sw==
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
	llvm@lists.linux.dev
Subject: [RFC PATCH v2 22/22] selinux: restrict policy strings
Date: Mon, 16 Dec 2024 17:40:20 +0100
Message-ID: <20241216164055.96267-22-cgoettsche@seltendoof.de>
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

Validate the characters and the lengths of strings parsed from binary
policies.

  * Disallow control characters
  * Limit characters of identifiers to alphanumeric, underscore, dash,
    and dot
  * Limit identifiers in length to 128, expect types to 1024 and
    categories to 32, characters (excluding NUL-terminator)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
  - add wrappers for str_read() to minimize the usage of magic numbers
  - limit sensitivities to a length of 32, to match categories,
    suggested by Daniel
---
 security/selinux/ss/conditional.c |  2 +-
 security/selinux/ss/policydb.c    | 60 ++++++++++++++++++++-----------
 security/selinux/ss/policydb.h    | 45 ++++++++++++++++++++++-
 3 files changed, 84 insertions(+), 23 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 481aa17a6f26..7688615a3934 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -280,7 +280,7 @@ int cond_read_bool(struct policydb *p, struct symtab *s, struct policy_file *fp)
 
 	len = le32_to_cpu(buf[2]);
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read_bool(&key, GFP_KERNEL, fp, len);
 	if (rc)
 		goto err;
 
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 34db40753654..c72182b91f49 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1226,8 +1226,9 @@ static int context_read_and_validate(struct context *c, struct policydb *p,
  * binary representation file.
  */
 
-int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
+int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len, int kind, u32 max_len)
 {
+	u32 i;
 	int rc;
 	char *str;
 
@@ -1237,19 +1238,35 @@ int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
 	if (oom_check(sizeof(char), len, fp))
 		return -EINVAL;
 
+	if (max_len != 0 && len > max_len)
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
@@ -1274,7 +1291,7 @@ static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *f
 	if (perdatum->value < 1 || perdatum->value > 32)
 		goto bad;
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read_perm(&key, GFP_KERNEL, fp, len);
 	if (rc)
 		goto bad;
 
@@ -1320,7 +1337,7 @@ static int common_read(struct policydb *p, struct symtab *s, struct policy_file
 		goto bad;
 	comdatum->permissions.nprim = le32_to_cpu(buf[2]);
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read_class(&key, GFP_KERNEL, fp, len);
 	if (rc)
 		goto bad;
 
@@ -1557,12 +1574,12 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 
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
 
@@ -1696,7 +1713,7 @@ static int role_read(struct policydb *p, struct symtab *s, struct policy_file *f
 	if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
 		role->bounds = le32_to_cpu(buf[2]);
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read_role(&key, GFP_KERNEL, fp, len);
 	if (rc)
 		goto bad;
 
@@ -1763,7 +1780,7 @@ static int type_read(struct policydb *p, struct symtab *s, struct policy_file *f
 		typdatum->primary = le32_to_cpu(buf[2]);
 	}
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read_type(&key, GFP_KERNEL, fp, len);
 	if (rc)
 		goto bad;
 
@@ -1827,7 +1844,7 @@ static int user_read(struct policydb *p, struct symtab *s, struct policy_file *f
 	if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
 		usrdatum->bounds = le32_to_cpu(buf[2]);
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read_user(&key, GFP_KERNEL, fp, len);
 	if (rc)
 		goto bad;
 
@@ -1876,7 +1893,7 @@ static int sens_read(struct policydb *p, struct symtab *s, struct policy_file *f
 		goto bad;
 	levdatum->isalias = val;
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read_sens(&key, GFP_KERNEL, fp, len);
 	if (rc)
 		goto bad;
 
@@ -1919,7 +1936,7 @@ static int cat_read(struct policydb *p, struct symtab *s, struct policy_file *fp
 		goto bad;
 	catdatum->isalias = val;
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read_cat(&key, GFP_KERNEL, fp, len);
 	if (rc)
 		goto bad;
 
@@ -2225,7 +2242,7 @@ static int filename_trans_read_helper_compat(struct policydb *p, struct policy_f
 	len = le32_to_cpu(buf[0]);
 
 	/* path component string */
-	rc = str_read(&name, GFP_KERNEL, fp, len);
+	rc = str_read(&name, GFP_KERNEL, fp, len, STR_UNCONSTRAINT, 0);
 	if (rc)
 		return rc;
 
@@ -2324,7 +2341,7 @@ static int filename_trans_read_helper(struct policydb *p, struct policy_file *fp
 	len = le32_to_cpu(buf[0]);
 
 	/* path component string */
-	rc = str_read(&name, GFP_KERNEL, fp, len);
+	rc = str_read(&name, GFP_KERNEL, fp, len, STR_UNCONSTRAINT, 0);
 	if (rc)
 		return rc;
 
@@ -2478,7 +2495,7 @@ static int genfs_read(struct policydb *p, struct policy_file *fp)
 		if (!newgenfs)
 			goto out;
 
-		rc = str_read(&newgenfs->fstype, GFP_KERNEL, fp, len);
+		rc = str_read(&newgenfs->fstype, GFP_KERNEL, fp, len, STR_IDENTIFIER, 128);
 		if (rc)
 			goto out;
 
@@ -2517,7 +2534,7 @@ static int genfs_read(struct policydb *p, struct policy_file *fp)
 			if (!newc)
 				goto out;
 
-			rc = str_read(&newc->u.name, GFP_KERNEL, fp, len);
+			rc = str_read(&newc->u.name, GFP_KERNEL, fp, len, STR_UNCONSTRAINT, 0);
 			if (rc)
 				goto out;
 
@@ -2620,7 +2637,7 @@ static int ocontext_read(struct policydb *p,
 					goto out;
 				len = le32_to_cpu(buf[0]);
 
-				rc = str_read(&c->u.name, GFP_KERNEL, fp, len);
+				rc = str_read(&c->u.name, GFP_KERNEL, fp, len, STR_IDENTIFIER, 128);
 				if (rc)
 					goto out;
 
@@ -2688,7 +2705,7 @@ static int ocontext_read(struct policydb *p,
 					goto out;
 
 				len = le32_to_cpu(buf[1]);
-				rc = str_read(&c->u.name, GFP_KERNEL, fp, len);
+				rc = str_read(&c->u.name, GFP_KERNEL, fp, len, STR_IDENTIFIER, 128);
 				if (rc)
 					goto out;
 
@@ -2754,7 +2771,7 @@ static int ocontext_read(struct policydb *p,
 				len = le32_to_cpu(buf[0]);
 
 				rc = str_read(&c->u.ibendport.dev_name,
-					      GFP_KERNEL, fp, len);
+					      GFP_KERNEL, fp, len, STR_IDENTIFIER, 128);
 				if (rc)
 					goto out;
 
@@ -2822,7 +2839,8 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
 		goto bad;
 	}
 
-	rc = str_read(&policydb_str, GFP_KERNEL, fp, len);
+	rc = str_read(&policydb_str, GFP_KERNEL, fp, len,
+		      STR_UNCONSTRAINT, strlen(POLICYDB_STRING));
 	if (rc) {
 		if (rc == -ENOMEM) {
 			pr_err("SELinux:  unable to allocate memory for policydb string of length %d\n",
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index d979965ef939..22e5e5adf73c 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -402,7 +402,50 @@ static inline const char *sym_name(const struct policydb *p, unsigned int sym_nu
 	return p->sym_val_to_name[sym_num][element_nr];
 }
 
-extern int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len);
+#define STR_UNCONSTRAINT 0
+#define STR_IDENTIFIER 1
+extern int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len,
+		    int kind, u32 max_len);
+
+static inline int str_read_bool(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
+{
+	return str_read(strp, flags, fp, len, STR_IDENTIFIER, 128);
+}
+
+static inline int str_read_cat(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
+{
+	return str_read(strp, flags, fp, len, STR_IDENTIFIER, 32);
+}
+
+static inline int str_read_class(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
+{
+	return str_read(strp, flags, fp, len, STR_IDENTIFIER, 128);
+}
+
+static inline int str_read_perm(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
+{
+	return str_read(strp, flags, fp, len, STR_IDENTIFIER, 128);
+}
+
+static inline int str_read_role(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
+{
+	return str_read(strp, flags, fp, len, STR_IDENTIFIER, 128);
+}
+
+static inline int str_read_sens(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
+{
+	return str_read(strp, flags, fp, len, STR_IDENTIFIER, 32);
+}
+
+static inline int str_read_type(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
+{
+	return str_read(strp, flags, fp, len, STR_IDENTIFIER, 1024);
+}
+
+static inline int str_read_user(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
+{
+	return str_read(strp, flags, fp, len, STR_IDENTIFIER, 128);
+}
 
 extern u16 string_to_security_class(struct policydb *p, const char *name);
 extern u32 string_to_av_perm(struct policydb *p, u16 tclass, const char *name);
-- 
2.45.2

