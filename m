Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798C619DF45;
	Wed, 23 Oct 2024 15:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697249; cv=none; b=WfUdysFytP8PyLP2D2MSzyJlch/z4SkLDcyKfxB6VhsE90gUiQ1ZQ7ucjgc5jcIvDFuawwqgpv6QwbOi4fZHMnyOhwsJw8iGU/Y/foESFp+VacoYfFwlcDM8j+GtcTuG47e8fyn3QcHb/rs1HYlJ0+TTQi73Qh2wJJfnVR57kXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697249; c=relaxed/simple;
	bh=oik+V/RNJwWo+SeFZOEQL78KxqbRBVcEF9pGR/uapd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VVyULNsxFI75rV2q7VA9NzqIDxwbR+iKJaYygXQ5DAbvmzE87r2SVjwruIE45iJxtC6WI/bmtKzzAa/yQfvi1tULVar+/snfrPb7RaZmcfAbv36jG8LesoP5vJXJX0O/ffYTQoTTgYK6Urq+fzptQNRiok2MXDZRBTy2T1oRB28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=UrrcmPwg; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="UrrcmPwg"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1729697243;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xMk5VRfzH74Sdi7bz4nUNRyR99yVu65+lDcpBo3YmLM=;
	b=UrrcmPwgR9Olu8Gq/devFDpg9lqeq2FAqh/MIdXYGMz9A9KlVUlVAGxYHmuExxpt7KFiHG
	vmvyV9m1yKbZEy1I04orNFG+4SVt71+CyRr/D0CUARz6cFZgoXxrw6gBId4XD0h2TEcS3m
	ZzT37Ts0id+AJtO4XVbhTt5tiYHGpqucl/LW25dcUdqfgDv/UTK7r0Pw2ZnyXIxSpx+ZGo
	6av703RFdKrAaHK6qczoNjqcRFQhVmnOxifOJgR8de8MmRofaNYJZOn5Jilehxg8vMjoR1
	sGdRLQyH1hRF74hYdRpOYGzPAu6rXp/LVqrVAEk3PV6/jztBbgtibKmx3fWdYw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
	=?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>,
	Jacob Satterfield <jsatterfield.linux@gmail.com>,
	Eric Suen <ericsu@linux.microsoft.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	John Johansen <john.johansen@canonical.com>,
	Canfeng Guo <guocanfeng@uniontech.com>,
	GUO Zihua <guozihua@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] selinux: add support for xperms in conditional policies
Date: Wed, 23 Oct 2024 17:27:10 +0200
Message-ID: <20241023152719.24118-1-cgoettsche@seltendoof.de>
In-Reply-To: <20240405161042.260113-1-cgoettsche@seltendoof.de>
References: <20240405161042.260113-1-cgoettsche@seltendoof.de>
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

Add support for extended permission rules in conditional policies.
Currently the kernel accepts such rules already, but evaluating a
security decision will hit a BUG() in
services_compute_xperms_decision().  Thus reject extended permission
rules in conditional policies for current policy versions.

Add a new policy version for this feature.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
  rebased onto the netlink xperm patch
---
 security/selinux/include/security.h |  3 ++-
 security/selinux/ss/avtab.c         | 11 +++++++++--
 security/selinux/ss/avtab.h         |  2 +-
 security/selinux/ss/conditional.c   |  2 +-
 security/selinux/ss/policydb.c      |  5 +++++
 security/selinux/ss/services.c      | 12 ++++++++----
 6 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index c7f2731abd03..10949df22fa4 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -46,10 +46,11 @@
 #define POLICYDB_VERSION_INFINIBAND	     31
 #define POLICYDB_VERSION_GLBLUB		     32
 #define POLICYDB_VERSION_COMP_FTRANS	     33 /* compressed filename transitions */
+#define POLICYDB_VERSION_COND_XPERMS	     34 /* extended permissions in conditional policies */
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX POLICYDB_VERSION_COMP_FTRANS
+#define POLICYDB_VERSION_MAX POLICYDB_VERSION_COND_XPERMS
 
 /* Mask for just the mount related flags */
 #define SE_MNTMASK 0x0f
diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 8e400dd736b7..83add633f92a 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -339,7 +339,7 @@ static const uint16_t spec_order[] = {
 int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 		    int (*insertf)(struct avtab *a, const struct avtab_key *k,
 				   const struct avtab_datum *d, void *p),
-		    void *p)
+		    void *p, bool conditional)
 {
 	__le16 buf16[4];
 	u16 enabled;
@@ -457,6 +457,13 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 		       "was specified\n",
 		       vers);
 		return -EINVAL;
+	} else if ((vers < POLICYDB_VERSION_COND_XPERMS) &&
+		   (key.specified & AVTAB_XPERMS) && conditional) {
+		pr_err("SELinux:  avtab:  policy version %u does not "
+		       "support extended permissions rules in conditional "
+		       "policies and one was specified\n",
+		       vers);
+		return -EINVAL;
 	} else if (key.specified & AVTAB_XPERMS) {
 		memset(&xperms, 0, sizeof(struct avtab_extended_perms));
 		rc = next_entry(&xperms.specified, fp, sizeof(u8));
@@ -523,7 +530,7 @@ int avtab_read(struct avtab *a, void *fp, struct policydb *pol)
 		goto bad;
 
 	for (i = 0; i < nel; i++) {
-		rc = avtab_read_item(a, fp, pol, avtab_insertf, NULL);
+		rc = avtab_read_item(a, fp, pol, avtab_insertf, NULL, false);
 		if (rc) {
 			if (rc == -ENOMEM)
 				pr_err("SELinux: avtab: out of memory\n");
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index f4407185401c..a7cbb80a11eb 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -108,7 +108,7 @@ struct policydb;
 int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 		    int (*insert)(struct avtab *a, const struct avtab_key *k,
 				  const struct avtab_datum *d, void *p),
-		    void *p);
+		    void *p, bool conditional);
 
 int avtab_read(struct avtab *a, void *fp, struct policydb *pol);
 int avtab_write_item(struct policydb *p, const struct avtab_node *cur,
diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 64ba95e40a6f..c9a3060f08a4 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -349,7 +349,7 @@ static int cond_read_av_list(struct policydb *p, void *fp,
 	for (i = 0; i < len; i++) {
 		data.dst = &list->nodes[i];
 		rc = avtab_read_item(&p->te_cond_avtab, fp, p, cond_insertf,
-				     &data);
+				     &data, true);
 		if (rc) {
 			kfree(list->nodes);
 			list->nodes = NULL;
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 383f3ae82a73..3ba5506a3fff 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -155,6 +155,11 @@ static const struct policydb_compat_info policydb_compat[] = {
 		.sym_num = SYM_NUM,
 		.ocon_num = OCON_NUM,
 	},
+	{
+		.version = POLICYDB_VERSION_COND_XPERMS,
+		.sym_num = SYM_NUM,
+		.ocon_num = OCON_NUM,
+	},
 };
 
 static const struct policydb_compat_info *
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 9652aec400cb..66d2472d3874 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -946,7 +946,7 @@ static void avd_init(struct selinux_policy *policy, struct av_decision *avd)
 }
 
 static void update_xperms_extended_data(u8 specified,
-					struct extended_perms_data *from,
+					const struct extended_perms_data *from,
 					struct extended_perms_data *xp_data)
 {
 	unsigned int i;
@@ -967,6 +967,8 @@ static void update_xperms_extended_data(u8 specified,
 void services_compute_xperms_decision(struct extended_perms_decision *xpermd,
 					struct avtab_node *node)
 {
+	u16 specified;
+
 	switch (node->datum.u.xperms->specified) {
 	case AVTAB_XPERMS_IOCTLFUNCTION:
 	case AVTAB_XPERMS_NLMSG:
@@ -982,17 +984,19 @@ void services_compute_xperms_decision(struct extended_perms_decision *xpermd,
 		BUG();
 	}
 
-	if (node->key.specified == AVTAB_XPERMS_ALLOWED) {
+	specified = node->key.specified & ~(AVTAB_ENABLED | AVTAB_ENABLED_OLD);
+
+	if (specified == AVTAB_XPERMS_ALLOWED) {
 		xpermd->used |= XPERMS_ALLOWED;
 		update_xperms_extended_data(node->datum.u.xperms->specified,
 					    &node->datum.u.xperms->perms,
 					    xpermd->allowed);
-	} else if (node->key.specified == AVTAB_XPERMS_AUDITALLOW) {
+	} else if (specified == AVTAB_XPERMS_AUDITALLOW) {
 		xpermd->used |= XPERMS_AUDITALLOW;
 		update_xperms_extended_data(node->datum.u.xperms->specified,
 					    &node->datum.u.xperms->perms,
 					    xpermd->auditallow);
-	} else if (node->key.specified == AVTAB_XPERMS_DONTAUDIT) {
+	} else if (specified == AVTAB_XPERMS_DONTAUDIT) {
 		xpermd->used |= XPERMS_DONTAUDIT;
 		update_xperms_extended_data(node->datum.u.xperms->specified,
 					    &node->datum.u.xperms->perms,
-- 
2.45.2

