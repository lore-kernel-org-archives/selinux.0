Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D340207E00;
	Mon, 16 Dec 2024 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367307; cv=none; b=bdxaIYPtvs3qaY66aezw5R5i6J7HejhqEAo6Rx6ENUNUMOFNzqlGaAKxg+uD4yaO60Ka1FJM/P07XzPlL3qug9+V+ipSOZgNj95YBGaOiVWi5d5Tg6RE4lIlLMTlgO6aV/pXKmyz3qMd7D5K/Yo4yT67spKncDqfNgk6rU7sOX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367307; c=relaxed/simple;
	bh=TksUT6mCLt+OJIv5t2a+6d1YYkcgourY21PvyHL6Zxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CzsTVwTKTtVNRx87Zzc4uS4P+S17JJEAzTmHI2EH8j1yIJlOqfI2F++Jz4NQiGPDWii4wymJ3UewWsyE/J9MnMywIMFlYGF5WBjSGbxdFQEa7WnV95l5s/v8WmwX0B88dfW9A406vLyQulz3r9TWd0yUT8wSJh0YBfc26/B1Sy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=pnaKq+yT; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="pnaKq+yT"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1734367302;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3A6Ee/FPECyHLndCHt8CtZKGd5Dc2bWDDCiBxya4aWU=;
	b=pnaKq+yTxr9fnEh54vQ6c6epHoAx4haxD1MWgT9tFSTNc50guM0q82utvDgf7wxunWJ4MZ
	0OHFo+8ma9cYwb+c66ZnS6N0sUSVvJ0fo+y0QnOAc5uFQPm8Y/42P6un46Tm/kCs3BMY/y
	03Z7hmS3p/hO8mqdit5q7xEnaBYdUJLwaepU1NP419AuVO/XX9GM9iDRMnuLGdofQDXFgS
	izyBbxA464tdwwzfPXk51zbbWE4kaPcv+UaRSoYmDcknVH17IihYnoK3tTr8eb+bU1TQNX
	19AbZx10HmWMSOyV4HEAi3VFlIscaPE2TPKYk5iSfIzDU05VRAWyTZjKqG2bqw==
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
	Casey Schaufler <casey@schaufler-ca.com>,
	John Johansen <john.johansen@canonical.com>,
	GUO Zihua <guozihua@huawei.com>,
	Canfeng Guo <guocanfeng@uniontech.com>
Subject: [RFC PATCH v2 10/22] selinux: use u16 for security classes
Date: Mon, 16 Dec 2024 17:40:08 +0100
Message-ID: <20241216164055.96267-10-cgoettsche@seltendoof.de>
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

Security class identifiers are limited to 2^16, thus use the appropriate
type u16 consistently.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/policydb.c | 52 +++++++++++++++++++++++++---------
 security/selinux/ss/policydb.h | 10 +++----
 security/selinux/ss/services.c |  2 +-
 3 files changed, 45 insertions(+), 19 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 2408c3e8ae39..eeca470cc90c 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -927,7 +927,7 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
 	return 0;
 }
 
-int policydb_class_isvalid(struct policydb *p, unsigned int class)
+int policydb_class_isvalid(struct policydb *p, u16 class)
 {
 	if (!class || class > p->p_classes.nprim)
 		return 0;
@@ -1321,7 +1321,7 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 	char *key = NULL;
 	struct class_datum *cladatum;
 	__le32 buf[6];
-	u32 i, len, len2, ncons, nel;
+	u32 i, len, len2, ncons, nel, val;
 	int rc;
 
 	cladatum = kzalloc(sizeof(*cladatum), GFP_KERNEL);
@@ -1334,9 +1334,14 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 
 	len = le32_to_cpu(buf[0]);
 	len2 = le32_to_cpu(buf[1]);
-	cladatum->value = le32_to_cpu(buf[2]);
 	nel = le32_to_cpu(buf[4]);
 
+	val = le32_to_cpu(buf[2]);
+	rc = -EINVAL;
+	if (val >= U16_MAX)
+		goto bad;
+	cladatum->value = val;
+
 	rc = symtab_init(&cladatum->permissions, nel);
 	if (rc)
 		goto bad;
@@ -1842,7 +1847,7 @@ static int range_read(struct policydb *p, struct policy_file *fp)
 	struct mls_range *r = NULL;
 	int rc;
 	__le32 buf[2];
-	u32 i, nel;
+	u32 i, nel, val;
 
 	if (p->policyvers < POLICYDB_VERSION_MLS)
 		return 0;
@@ -1873,7 +1878,11 @@ static int range_read(struct policydb *p, struct policy_file *fp)
 			rc = next_entry(buf, fp, sizeof(u32));
 			if (rc)
 				goto out;
-			rt->target_class = le32_to_cpu(buf[0]);
+			rc = -EINVAL;
+			val = le32_to_cpu(buf[0]);
+			if (val >= U16_MAX)
+				goto out;
+			rt->target_class = val;
 		} else
 			rt->target_class = p->process_class;
 
@@ -1918,7 +1927,7 @@ static int filename_trans_read_helper_compat(struct policydb *p, struct policy_f
 	struct filename_trans_key key, *ft = NULL;
 	struct filename_trans_datum *last, *datum = NULL;
 	char *name = NULL;
-	u32 len, stype, otype;
+	u32 len, stype, otype, val;
 	__le32 buf[4];
 	int rc;
 
@@ -1939,7 +1948,11 @@ static int filename_trans_read_helper_compat(struct policydb *p, struct policy_f
 
 	stype = le32_to_cpu(buf[0]);
 	key.ttype = le32_to_cpu(buf[1]);
-	key.tclass = le32_to_cpu(buf[2]);
+	val = le32_to_cpu(buf[2]);
+	rc = -EINVAL;
+	if (val > U16_MAX || !policydb_class_isvalid(p, val))
+		goto out;
+	key.tclass = val;
 	key.name = name;
 
 	otype = le32_to_cpu(buf[3]);
@@ -2003,7 +2016,8 @@ static int filename_trans_read_helper(struct policydb *p, struct policy_file *fp
 	struct filename_trans_key *ft = NULL;
 	struct filename_trans_datum **dst, *datum, *first = NULL;
 	char *name = NULL;
-	u32 len, ttype, tclass, ndatum, i;
+	u32 len, ttype, ndatum, i, val;
+	u16 tclass;
 	__le32 buf[3];
 	int rc;
 
@@ -2023,7 +2037,11 @@ static int filename_trans_read_helper(struct policydb *p, struct policy_file *fp
 		goto out;
 
 	ttype = le32_to_cpu(buf[0]);
-	tclass = le32_to_cpu(buf[1]);
+	val = le32_to_cpu(buf[1]);
+	rc = -EINVAL;
+	if (val > U16_MAX || !policydb_class_isvalid(p, val))
+		goto out;
+	tclass = val;
 
 	ndatum = le32_to_cpu(buf[2]);
 	if (ndatum == 0) {
@@ -2131,7 +2149,7 @@ static int filename_trans_read(struct policydb *p, struct policy_file *fp)
 static int genfs_read(struct policydb *p, struct policy_file *fp)
 {
 	int rc;
-	u32 i, j, nel, nel2, len, len2;
+	u32 i, j, nel, nel2, len, len2, val;
 	__le32 buf[1];
 	struct ocontext *l, *c;
 	struct ocontext *newc = NULL;
@@ -2201,7 +2219,11 @@ static int genfs_read(struct policydb *p, struct policy_file *fp)
 			if (rc)
 				goto out;
 
-			newc->v.sclass = le32_to_cpu(buf[0]);
+			rc = -EINVAL;
+			val = le32_to_cpu(buf[0]);
+			if (val >= U16_MAX)
+				goto out;
+			newc->v.sclass = val;
 			rc = context_read_and_validate(&newc->context[0], p,
 						       fp);
 			if (rc)
@@ -2446,7 +2468,7 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
 	struct role_trans_datum *rtd = NULL;
 	int rc;
 	__le32 buf[4];
-	u32 i, j, len, nprim, nel, perm;
+	u32 i, j, len, nprim, nel, perm, val;
 
 	char *policydb_str;
 	const struct policydb_compat_info *info;
@@ -2632,7 +2654,11 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
 			rc = next_entry(buf, fp, sizeof(u32));
 			if (rc)
 				goto bad;
-			rtk->tclass = le32_to_cpu(buf[0]);
+			rc = -EINVAL;
+			val = le32_to_cpu(buf[0]);
+			if (val >= U16_MAX)
+				goto bad;
+			rtk->tclass = val;
 		} else
 			rtk->tclass = p->process_class;
 
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 25650224b6e7..0c423ad77fd9 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -48,7 +48,7 @@ struct common_datum {
 
 /* Class attributes */
 struct class_datum {
-	u32 value; /* class value */
+	u16 value; /* class value */
 	char *comkey; /* common name */
 	struct common_datum *comdatum; /* common datum */
 	struct symtab permissions; /* class-specific permission symbol table */
@@ -82,7 +82,7 @@ struct role_datum {
 struct role_trans_key {
 	u32 role; /* current role */
 	u32 type; /* program executable type, or new object type */
-	u32 tclass; /* process class, or new object class */
+	u16 tclass; /* process class, or new object class */
 };
 
 struct role_trans_datum {
@@ -139,7 +139,7 @@ struct cat_datum {
 struct range_trans {
 	u32 source_type;
 	u32 target_type;
-	u32 target_class;
+	u16 target_class;
 };
 
 /* Boolean data type */
@@ -195,7 +195,7 @@ struct ocontext {
 		} ibendport;
 	} u;
 	union {
-		u32 sclass; /* security class for genfs */
+		u16 sclass; /* security class for genfs */
 		u32 behavior; /* labeling behavior for fs_use */
 	} v;
 	struct context context[2]; /* security context(s) */
@@ -320,7 +320,7 @@ struct policy_file {
 extern void policydb_destroy(struct policydb *p);
 extern int policydb_load_isids(struct policydb *p, struct sidtab *s);
 extern int policydb_context_isvalid(struct policydb *p, struct context *c);
-extern int policydb_class_isvalid(struct policydb *p, unsigned int class);
+extern int policydb_class_isvalid(struct policydb *p, u16 class);
 extern int policydb_type_isvalid(struct policydb *p, unsigned int type);
 extern int policydb_role_isvalid(struct policydb *p, unsigned int role);
 extern int policydb_read(struct policydb *p, struct policy_file *fp);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index e5c9b62e59c1..28c0bdf9fc9d 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3350,7 +3350,7 @@ static int get_classes_callback(void *k, void *d, void *args)
 {
 	struct class_datum *datum = d;
 	char *name = k, **classes = args;
-	u32 value = datum->value - 1;
+	u16 value = datum->value - 1;
 
 	classes[value] = kstrdup(name, GFP_ATOMIC);
 	if (!classes[value])
-- 
2.45.2

