Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B644256C82;
	Sun, 11 May 2025 17:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746985155; cv=none; b=CQu9EkX2OeZKx3ccuEy6oyZuQtdfY19HQwA2OOWwd6iIycdlLqF3ZUUCs/uh9DSWGCutg3deo1+deG/E+xNUC40hiVVK+mQjArszuoXeDhiueX/OK+OavlZhNCC64BrLeH1d/jDtNmwVYMRrcpBlpLxL24X0UKegWs+yCemYgPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746985155; c=relaxed/simple;
	bh=ffpq4FEv408mzdfahVXoaBPc6DNRX7H5xYgQWtMyJ7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VsYE05wWqDODVDkQnWjbB81UYC6GRPG+gYY6nIAFEZ+E/W0Mt1jI+jhHYtIz/mx7FkF0oSkUyS1WRs59FB7tZRn2piNPXauTKUZHKAKYrOcSRj71Tx8CNYlPBdP1jMDpiH9mUqk27S/+M+6AYV6MkkK2fLzzTGYmyaK109tgo6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=GKO4aZWv; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="GKO4aZWv"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1746984664;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8yJtgts6ndS8IP5j4P/UG2vLnwasodXja8LOGKl1BJQ=;
	b=GKO4aZWv5wIdzOhE8jl55dhMaF7YnYNCQLhqm1JmBonnAP62xoMeYU13GQslN4xQLLTUk5
	fZeMwSui1LTmHWeSnCZqyWLnNrmNUV+roRHdqM+fyqtjNCIBZcpLYZ3xRJC2zhYLjoYBAY
	SuB4AyNY3vFZw7+HgKwPBpnZZgldzKtmG8KaV0+AxUvwGlXdQqVjqGLqNVup+fkLYKZjU5
	m7IcAUa9mrMkxxHJOTwous3/qn2s2KMzRPSCWpFT+vnHG7nqVVXLoPLVdQKHyKOuEQ4JrI
	IAV5oINrpl+t1ZNWbhbCq4+uIc+abrSBpbbYC43HHYwZvqxhgY5nNTrm7lp5VA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Canfeng Guo <guocanfeng@uniontech.com>,
	Takaya Saeki <takayas@chromium.org>
Subject: [PATCH v3 02/14] selinux: use u16 for security classes
Date: Sun, 11 May 2025 19:30:02 +0200
Message-ID: <20250511173055.406906-2-cgoettsche@seltendoof.de>
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

Security class identifiers are limited to 2^16, thus use the appropriate
type u16 consistently.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3: only change type, move the validation (> U16_MAX) to the subsequent
    patch
---
 security/selinux/ss/policydb.c |  5 +++--
 security/selinux/ss/policydb.h | 10 +++++-----
 security/selinux/ss/services.c |  2 +-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index dc701a7f8652..f490556ddb5c 100644
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
@@ -2003,7 +2003,8 @@ static int filename_trans_read_helper(struct policydb *p, struct policy_file *fp
 	struct filename_trans_key *ft = NULL;
 	struct filename_trans_datum **dst, *datum, *first = NULL;
 	char *name = NULL;
-	u32 len, ttype, tclass, ndatum, i;
+	u32 len, ttype, ndatum, i;
+	u16 tclass;
 	__le32 buf[3];
 	int rc;
 
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
index 7becf3808818..a2dd42e750fe 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3387,7 +3387,7 @@ static int get_classes_callback(void *k, void *d, void *args)
 {
 	struct class_datum *datum = d;
 	char *name = k, **classes = args;
-	u32 value = datum->value - 1;
+	u16 value = datum->value - 1;
 
 	classes[value] = kstrdup(name, GFP_ATOMIC);
 	if (!classes[value])
-- 
2.49.0

