Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC991D2F4B;
	Fri, 15 Nov 2024 13:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677847; cv=none; b=OrLxa74XiOLSuF15u35f0EifwmYxJ6cwwRr4VB/AgXA9renM7kh+Fp7C40z/ggA93k90ri+5SPQ4fhQkhsEt9m9PS8djUXv+aEFvc3VxRS0iAhUiB7Z2YwDEhWa5Aqyc4q18a0DJQ4oV6N52idfNUwLf93TSGWCJw0CD/qXxflw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677847; c=relaxed/simple;
	bh=VZCagkRWAOvF3LiBUAC4UEYM3FyI5AJvn1/kz6t9uJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ioeYrxLDXQa+Bwe6upVbqoY4inNGpXzFAvSC25mxBIfTk5cfI7yoI0fhSbpmPejqQdlcfyezpq35HLfbAuP6fuxB11CZ+xyQNlRDl67rC+UwBQxmTT9dvEegf6gt7MsiNGWw6ixQS20Fj5pXljfE6JDxA8+FiVE2OfYnY8TvFEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=XXNXgGuw; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="XXNXgGuw"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731677843;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GfhRYgt4szAsRZGle5zJI/EtxlCRpiLMsv6HnqDWSro=;
	b=XXNXgGuweBo4swDAJFqljvrnliqwMYxO8rf4/d5ttSOl/HRDBjPoOeYu3dRaTBwXuSpJbF
	+atRfgvOsmw8dI8fC8VWqgMh7JXRSz4bKeVO01OGoOjnVSaYERAWiHXe4fXps38CncUzJ6
	M7BIZ1Dv543py8jp4/0PfEwYGcrX6vNneqDmwjFuo7LL7vP5eVrYi6e4mB3tRURSdOl3f6
	5Z5NXFjoDXuEzfGhzhFd7+LHoIfxFFpkeqx6yTL0yoiJZUR+xIiBdrgqeknJK7gBKorNzm
	yCyvS95dcXhz0nzG9NZUXQZdJLF+XkzqGcCtB8kUIZvy7lKyxxbTXtA8phDMcQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 22/22] selinux: restrict policy strings
Date: Fri, 15 Nov 2024 14:35:41 +0100
Message-ID: <20241115133619.114393-22-cgoettsche@seltendoof.de>
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

Validate the characters and the lengths of strings parsed from binary
policies.

  * Disallow control characters
  * Limit characters of identifiers to alphanumeric, underscore, dash,
    and dot
  * Limit identifiers in length to 128, expect types to 1024 and
    categories to 32, characters (excluding NUL-terminator)

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/conditional.c |  2 +-
 security/selinux/ss/policydb.c    | 60 ++++++++++++++++++++-----------
 security/selinux/ss/policydb.h    |  5 ++-
 3 files changed, 44 insertions(+), 23 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index d37b4bdf6ba9..346102417cbf 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -280,7 +280,7 @@ int cond_read_bool(struct policydb *p, struct symtab *s, struct policy_file *fp)
 
 	len = le32_to_cpu(buf[2]);
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read(&key, GFP_KERNEL, fp, len, STR_IDENTIFIER, 128);
 	if (rc)
 		goto err;
 
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 917b468c5144..d98dfa6c3f30 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1221,8 +1221,9 @@ static int context_read_and_validate(struct context *c, struct policydb *p,
  * binary representation file.
  */
 
-int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
+int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len, int kind, u32 max_len)
 {
+	u32 i;
 	int rc;
 	char *str;
 
@@ -1232,19 +1233,35 @@ int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
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
@@ -1269,7 +1286,7 @@ static int perm_read(struct policydb *p, struct symtab *s, struct policy_file *f
 	if (perdatum->value < 1 || perdatum->value > 32)
 		goto bad;
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read(&key, GFP_KERNEL, fp, len, STR_IDENTIFIER, 128);
 	if (rc)
 		goto bad;
 
@@ -1315,7 +1332,7 @@ static int common_read(struct policydb *p, struct symtab *s, struct policy_file
 		goto bad;
 	comdatum->permissions.nprim = le32_to_cpu(buf[2]);
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read(&key, GFP_KERNEL, fp, len, STR_IDENTIFIER, 128);
 	if (rc)
 		goto bad;
 
@@ -1552,12 +1569,12 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 
 	ncons = le32_to_cpu(buf[5]);
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read(&key, GFP_KERNEL, fp, len, STR_IDENTIFIER, 128);
 	if (rc)
 		goto bad;
 
 	if (len2) {
-		rc = str_read(&cladatum->comkey, GFP_KERNEL, fp, len2);
+		rc = str_read(&cladatum->comkey, GFP_KERNEL, fp, len2, STR_IDENTIFIER, 128);
 		if (rc)
 			goto bad;
 
@@ -1691,7 +1708,7 @@ static int role_read(struct policydb *p, struct symtab *s, struct policy_file *f
 	if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
 		role->bounds = le32_to_cpu(buf[2]);
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read(&key, GFP_KERNEL, fp, len, STR_IDENTIFIER, 128);
 	if (rc)
 		goto bad;
 
@@ -1758,7 +1775,7 @@ static int type_read(struct policydb *p, struct symtab *s, struct policy_file *f
 		typdatum->primary = le32_to_cpu(buf[2]);
 	}
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read(&key, GFP_KERNEL, fp, len, STR_IDENTIFIER, 1024);
 	if (rc)
 		goto bad;
 
@@ -1822,7 +1839,7 @@ static int user_read(struct policydb *p, struct symtab *s, struct policy_file *f
 	if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
 		usrdatum->bounds = le32_to_cpu(buf[2]);
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read(&key, GFP_KERNEL, fp, len, STR_IDENTIFIER, 128);
 	if (rc)
 		goto bad;
 
@@ -1871,7 +1888,7 @@ static int sens_read(struct policydb *p, struct symtab *s, struct policy_file *f
 		goto bad;
 	levdatum->isalias = val;
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read(&key, GFP_KERNEL, fp, len, STR_IDENTIFIER, 128);
 	if (rc)
 		goto bad;
 
@@ -1914,7 +1931,7 @@ static int cat_read(struct policydb *p, struct symtab *s, struct policy_file *fp
 		goto bad;
 	catdatum->isalias = val;
 
-	rc = str_read(&key, GFP_KERNEL, fp, len);
+	rc = str_read(&key, GFP_KERNEL, fp, len, STR_IDENTIFIER, 32);
 	if (rc)
 		goto bad;
 
@@ -2220,7 +2237,7 @@ static int filename_trans_read_helper_compat(struct policydb *p, struct policy_f
 	len = le32_to_cpu(buf[0]);
 
 	/* path component string */
-	rc = str_read(&name, GFP_KERNEL, fp, len);
+	rc = str_read(&name, GFP_KERNEL, fp, len, STR_UNCONSTRAINT, 0);
 	if (rc)
 		return rc;
 
@@ -2319,7 +2336,7 @@ static int filename_trans_read_helper(struct policydb *p, struct policy_file *fp
 	len = le32_to_cpu(buf[0]);
 
 	/* path component string */
-	rc = str_read(&name, GFP_KERNEL, fp, len);
+	rc = str_read(&name, GFP_KERNEL, fp, len, STR_UNCONSTRAINT, 0);
 	if (rc)
 		return rc;
 
@@ -2473,7 +2490,7 @@ static int genfs_read(struct policydb *p, struct policy_file *fp)
 		if (!newgenfs)
 			goto out;
 
-		rc = str_read(&newgenfs->fstype, GFP_KERNEL, fp, len);
+		rc = str_read(&newgenfs->fstype, GFP_KERNEL, fp, len, STR_IDENTIFIER, 128);
 		if (rc)
 			goto out;
 
@@ -2512,7 +2529,7 @@ static int genfs_read(struct policydb *p, struct policy_file *fp)
 			if (!newc)
 				goto out;
 
-			rc = str_read(&newc->u.name, GFP_KERNEL, fp, len);
+			rc = str_read(&newc->u.name, GFP_KERNEL, fp, len, STR_UNCONSTRAINT, 0);
 			if (rc)
 				goto out;
 
@@ -2615,7 +2632,7 @@ static int ocontext_read(struct policydb *p,
 					goto out;
 				len = le32_to_cpu(buf[0]);
 
-				rc = str_read(&c->u.name, GFP_KERNEL, fp, len);
+				rc = str_read(&c->u.name, GFP_KERNEL, fp, len, STR_IDENTIFIER, 128);
 				if (rc)
 					goto out;
 
@@ -2683,7 +2700,7 @@ static int ocontext_read(struct policydb *p,
 					goto out;
 
 				len = le32_to_cpu(buf[1]);
-				rc = str_read(&c->u.name, GFP_KERNEL, fp, len);
+				rc = str_read(&c->u.name, GFP_KERNEL, fp, len, STR_IDENTIFIER, 128);
 				if (rc)
 					goto out;
 
@@ -2749,7 +2766,7 @@ static int ocontext_read(struct policydb *p,
 				len = le32_to_cpu(buf[0]);
 
 				rc = str_read(&c->u.ibendport.dev_name,
-					      GFP_KERNEL, fp, len);
+					      GFP_KERNEL, fp, len, STR_IDENTIFIER, 128);
 				if (rc)
 					goto out;
 
@@ -2817,7 +2834,8 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
 		goto bad;
 	}
 
-	rc = str_read(&policydb_str, GFP_KERNEL, fp, len);
+	rc = str_read(&policydb_str, GFP_KERNEL, fp, len,
+		      STR_UNCONSTRAINT, strlen(POLICYDB_STRING));
 	if (rc) {
 		if (rc == -ENOMEM) {
 			pr_err("SELinux:  unable to allocate memory for policydb string of length %d\n",
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 73a0b793354e..fb05174b1b16 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -403,7 +403,10 @@ static inline const char *sym_name(const struct policydb *p, unsigned int sym_nu
 	return p->sym_val_to_name[sym_num][element_nr];
 }
 
-extern int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len);
+#define STR_UNCONSTRAINT 0
+#define STR_IDENTIFIER 1
+extern int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len,
+		    int kind, u32 max_len);
 
 extern u16 string_to_security_class(struct policydb *p, const char *name);
 extern u32 string_to_av_perm(struct policydb *p, u16 tclass, const char *name);
-- 
2.45.2

