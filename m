Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4C6256C82;
	Sun, 11 May 2025 17:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746984689; cv=none; b=ezvw+dVIzU87p9XMY4HYYayGnSckKwiJAAHNyWa0lBgY2U/711+dmVr/2S5OwiByuhEA3x8HznbA/5cJoazbpHyqw181PG6TrfGJb1/Z9J8WA3A6oF2gB6AO44TEjeMRmZI+/htiHXg64XgzEjJ3N2uMNNEE/eabWfO0hvcrur0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746984689; c=relaxed/simple;
	bh=2+JP0e7RvGlP7ZPlAq11tX9XTR7qS8u8E6Ftfo391xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q+6G9MFMU+i+P+PturQP1xhDj4+M/pbSmV5VT7lNIbMY3f0TTuqt/lkIn2EDpY6WLRSZLHL/MwykqjCGKLMAT0+CuByYxFmyFryAHR7ei4fMe/ePA8C4W7RZrbuNBnD20b/SwZJ26aoU/7R+TmmSYzbrECdK6whmEiPffpI4RJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=r8Mkkq9c; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="r8Mkkq9c"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1746984685;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UePFzPC1fzOvFqJh2FW08JC6bk/brYvXYF0z7r1mWog=;
	b=r8Mkkq9c1LW9TAtxKmszUZMDbrXuxyDWBSGGtVn8l7UfKnHN/8uZxRIa46RsQwf3mGH9V5
	c/AdzGWqn2i9PcqqvJgm6JVyoTXU8ibl9FO0Ws0cZrasYpjk4yVSDf2y8cdy5NrKWl+mKQ
	P7o3tQQKHlopqBqmB2fTbGE/dtETsgTpTv7E68KabVwnkZ664nbT7PG9PO7qv1lQjiCvl/
	dtkPM+NzRB7ldZB7Xfn0z266D10Eq1lrusNKKw3Phe1g2JZtYoU40pJSSp8oV/cwy1JK6x
	eboTWBZ7V7RugmeTsKWjNo1akVFP16dFhah+EbhJh6Q+LRwoVC6Il8zbCNHOtA==
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
Subject: [PATCH v3 11/14] selinux: more strict bounds check
Date: Sun, 11 May 2025 19:30:11 +0200
Message-ID: <20250511173055.406906-11-cgoettsche@seltendoof.de>
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
index 4559c8918134..7774f6da2ebe 100644
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
@@ -1942,6 +1951,12 @@ static int user_bounds_sanity_check(void *key, void *datum, void *datap)
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
@@ -1979,6 +1994,12 @@ static int role_bounds_sanity_check(void *key, void *datum, void *datap)
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
@@ -2013,9 +2034,13 @@ static int type_bounds_sanity_check(void *key, void *datum, void *datap)
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
index 1367387beaa7..04acf414fffa 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -324,6 +324,7 @@ extern bool policydb_context_isvalid(const struct policydb *p, const struct cont
 extern bool policydb_class_isvalid(const struct policydb *p, u16 class);
 extern bool policydb_type_isvalid(const struct policydb *p, u32 type);
 extern bool policydb_role_isvalid(const struct policydb *p, u32 role);
+extern bool policydb_user_isvalid(const struct policydb *p, u32 user);
 extern bool policydb_boolean_isvalid(const struct policydb *p, u32 boolean);
 extern int policydb_read(struct policydb *p, struct policy_file *fp);
 extern int policydb_write(struct policydb *p, struct policy_file *fp);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 5b1d0e80d975..464a4663c993 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -718,6 +718,9 @@ static void context_struct_compute_av(struct policydb *policydb,
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
2.49.0

