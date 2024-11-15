Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4731D278B;
	Fri, 15 Nov 2024 13:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677843; cv=none; b=r1a9gar+n7PP2I6cPS8Vnoq4fnnZKhiAwviWYaZbkXxQGAlgnCe2ajOE594FgkSl3j6Mx3QD75XPTxZCznAeuE89XdLDEe94ZlssJhxo0nBorgRDX9wCowT8z40kMMos1zdC4JeszQK0ThJB+jGzLgdzvOIMXBg6RVl3Ih/UFW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677843; c=relaxed/simple;
	bh=2Hk8803LH4Q5Gy0vEHT3gfNfSJ3hsIrQtV40YZr+HhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UcAHqdvkVpUO3RxhsZDOA4zVUW190ES8WtHr1VUDtFsnAcrAqgF4yppBNcaVDxSLfmv8xMoWL6FuL6IS/Mg7OWaEPD+Vgmke4Mo4MaNA9sJ6kgDP0qSq3v3bUgL5n5/aENBIYSMGoag2Z0I5XmH76RPVZuznFLMJIlR1Pewhq94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=t7RHyobI; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="t7RHyobI"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731677840;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cydXLiHCWIdz5reo8YxJB+IM/XqdcZtE4Jltvq1rBmY=;
	b=t7RHyobIYbAZ/fCS1lI/5Myz40NnkN9Ibd/Gzh0T1cnl//CecfSzQXIauLJE5QghI0mtaG
	HZlbd0uqPqKAresMARAAnqwIQWvwpGvURHbarVJOP3hi/Ao1IK6yCshSAEQU2vBrN3hOSk
	i8QQYqDQsTMaKfST6Z+2bPMfv+0Ak/J9G+4ffkeb3NPT7ldvdJpYhnQ47miNt0uj8UzHbo
	pvzXd0Dz4OdjmjAEQhv28Gi7wWIvcrf5Ji6ejifi695AaaMkQ4xgYJOsiGscJTnUDFmMrM
	JhDL2qxBZtXVM4SQKSHuhWXleFl15cx7/I/+TKYDMYKqwjwoZmcAnh1Q7fmhKw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
	GUO Zihua <guozihua@huawei.com>,
	Canfeng Guo <guocanfeng@uniontech.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 20/22] selinux: more strict bounds check
Date: Fri, 15 Nov 2024 14:35:39 +0100
Message-ID: <20241115133619.114393-20-cgoettsche@seltendoof.de>
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

Validate the types used in bounds checks.
Replace the usage of BUG(), to avoid halting the system on malformed
polices.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/policydb.c | 29 +++++++++++++++++++++++++++--
 security/selinux/ss/policydb.h |  1 +
 security/selinux/ss/services.c |  3 +++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 691c2c5caeb3..17fbd145ba1b 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1015,6 +1015,15 @@ bool policydb_class_isvalid(const struct policydb *p, u16 class)
 	return true;
 }
 
+bool policydb_user_isvalid(const struct policydb *p, u32 user)
+{
+	if (!user || user > p->p_roles.nprim)
+		return false;
+	if (!p->sym_val_to_name[SYM_USERS][user - 1])
+		return false;
+	return true;
+}
+
 bool policydb_role_isvalid(const struct policydb *p, u32 role)
 {
 	if (!role || role > p->p_roles.nprim)
@@ -1935,6 +1944,12 @@ static int user_bounds_sanity_check(void *key, void *datum, void *datap)
 			return -EINVAL;
 		}
 
+		if (!policydb_user_isvalid(p, upper->bounds)) {
+			pr_err("SELinux: user %s: invalid boundary id %d\n",
+			       (char *) key, upper->bounds);
+			return -EINVAL;
+		}
+
 		upper = p->user_val_to_struct[upper->bounds - 1];
 		ebitmap_for_each_positive_bit(&user->roles, node, bit)
 		{
@@ -1972,6 +1987,12 @@ static int role_bounds_sanity_check(void *key, void *datum, void *datap)
 			return -EINVAL;
 		}
 
+		if (!policydb_role_isvalid(p, upper->bounds)) {
+			pr_err("SELinux: role %s: invalid boundary id %d\n",
+			       (char *) key, upper->bounds);
+			return -EINVAL;
+		}
+
 		upper = p->role_val_to_struct[upper->bounds - 1];
 		ebitmap_for_each_positive_bit(&role->types, node, bit)
 		{
@@ -2006,9 +2027,13 @@ static int type_bounds_sanity_check(void *key, void *datum, void *datap)
 			return -EINVAL;
 		}
 
-		upper = p->type_val_to_struct[upper->bounds - 1];
-		BUG_ON(!upper);
+		if (!policydb_type_isvalid(p, upper->bounds)) {
+			pr_err("SELinux: type %s: invalid boundary id %d\n",
+			       (char *) key, upper->bounds);
+			return -EINVAL;
+		}
 
+		upper = p->type_val_to_struct[upper->bounds - 1];
 		if (upper->attribute) {
 			pr_err("SELinux: type %s: "
 			       "bounded by attribute %s\n",
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 2126f2b39628..28dd91a7427f 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -318,6 +318,7 @@ extern bool policydb_context_isvalid(const struct policydb *p, const struct cont
 extern bool policydb_class_isvalid(const struct policydb *p, u16 class);
 extern bool policydb_type_isvalid(const struct policydb *p, u32 type);
 extern bool policydb_role_isvalid(const struct policydb *p, u32 role);
+extern bool policydb_user_isvalid(const struct policydb *p, u32 user);
 extern bool policydb_boolean_isvalid(const struct policydb *p, u32 boolean);
 
 struct policy_file {
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 07d194357601..49805e81d6ce 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -711,6 +711,9 @@ static void context_struct_compute_av(struct policydb *policydb,
 	 * If the given source and target types have boundary
 	 * constraint, lazy checks have to mask any violated
 	 * permission and notice it to userspace via audit.
+	 *
+	 * Infinite recursion is avoided via a depth pre-check in
+	 * type_bounds_sanity_check().
 	 */
 	type_attribute_bounds_av(policydb, scontext, tcontext,
 				 tclass, avd);
-- 
2.45.2

