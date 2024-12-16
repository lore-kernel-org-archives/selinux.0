Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C804620C03C;
	Mon, 16 Dec 2024 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367324; cv=none; b=tFKLY9UAadjiIuEUZmOxqWfY7gGh6WNpQZmf+R8XWLyx9+3kZLOMv94I95L3PhSAOPZaZDZed3eu089HhX7BKuE0/qxgFL7ly6CCXiItVNnVxFF2evIUrxcdtWxMnkQ6XB+I8iDh+v26xjNpxI+5LYIFKGmtMQnYN6ypprdIfZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367324; c=relaxed/simple;
	bh=FJzvDyWWCwqVpHIfMCa7UJrZGBneB+gtnGIL7XG+RtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCNwFqcu1YIj2/SQW8z63RQm/111lN+Lj+S0wAsU5T+oELH5sJUYyje4MEQPuNJ1dqSkmxrKtRJcK7nHAimlNYukw4gK83uyEPPXWhfqoB7tPTct+CrQDtIorjS+bXDRD24DQfZw6Kuw2HH0lxItNeLSjblEHEo6UaNvapzUlxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=ia0Ml4O0; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="ia0Ml4O0"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1734367321;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tBaRFnJhDQjwxVQI6LlYqr3HMdrJ+5zyzl8QyvbBav0=;
	b=ia0Ml4O00zsUQsYb3+rYVu+PUysdBcieWACyfnRBpp9jUUEd6HJ5o2gm5RblkGPXi0hXRs
	tCBVfJRx5RrMPaywu0p7g5tRnmuZqJGP1G0ER8zD97WyJ4GOvp15pk4qrr/BOVxId6b1Pe
	RcyLRmxJN6GcyroGfY4sOUx2WH4V7NBsAf3qSHCN+99JbNlT2diswb6e/w2uEUgqlypxz7
	gK/X44bDrAtq7KangjjdGvyhlk2dV5d9NdgCtviVttRRq13wA2uNHuMT6q43GYhUxIbGGh
	7pzX+RBcAIpLBda0aztpwg0qxEY+yh/KI/VPcmirqFrlhKc/XuiyRrjiwj04SQ==
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
	Canfeng Guo <guocanfeng@uniontech.com>,
	GUO Zihua <guozihua@huawei.com>
Subject: [RFC PATCH v2 20/22] selinux: more strict bounds check
Date: Mon, 16 Dec 2024 17:40:18 +0100
Message-ID: <20241216164055.96267-20-cgoettsche@seltendoof.de>
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
index e9e478650e74..57ab2a811a15 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1020,6 +1020,15 @@ bool policydb_class_isvalid(const struct policydb *p, u16 class)
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
@@ -1940,6 +1949,12 @@ static int user_bounds_sanity_check(void *key, void *datum, void *datap)
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
@@ -1977,6 +1992,12 @@ static int role_bounds_sanity_check(void *key, void *datum, void *datap)
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
@@ -2011,9 +2032,13 @@ static int type_bounds_sanity_check(void *key, void *datum, void *datap)
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
index aa3b21bd5286..512d2081733b 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -323,6 +323,7 @@ extern bool policydb_context_isvalid(const struct policydb *p, const struct cont
 extern bool policydb_class_isvalid(const struct policydb *p, u16 class);
 extern bool policydb_type_isvalid(const struct policydb *p, u32 type);
 extern bool policydb_role_isvalid(const struct policydb *p, u32 role);
+extern bool policydb_user_isvalid(const struct policydb *p, u32 user);
 extern bool policydb_boolean_isvalid(const struct policydb *p, u32 boolean);
 extern int policydb_read(struct policydb *p, struct policy_file *fp);
 extern int policydb_write(struct policydb *p, struct policy_file *fp);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 227fe7832c08..6dd281ddef7a 100644
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

