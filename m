Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6371B1D271D;
	Fri, 15 Nov 2024 13:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677844; cv=none; b=qksTtShDoXSpgE62lozEiarU3xxP5QD8wMNOUwcfPFFuJQD/Mdt1FCWt5MbaQOGyLB9h0SB9EVSgSXUQNCO3Nf7lVhB9oFuKnFlDe5r9ufYsEE43xLAWS0fPivIUQEb0PXdp/MHY4laSvX70X2R1w9ekwrBlJmFTbaaXBSY7voU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677844; c=relaxed/simple;
	bh=508cHbMNozhyce8/ZUZdkqyMoZvcBv7VmgRdiPCE9H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iiaODRwR74qsCGINMpgNd0osh6WEXklw9P2v+p80dkslrMLgaKe9vVEl5LeqWT0kVK00VKRMF51ycKDq2ebT7aUb6RfB5sX74ewxRg8ioyrLDU0x0733ZHw/BUy4Fby5aZ8o/wxyIYJdSzjIj28Pvjshf2aD6/i21mMcvOhtuqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=hGVYKnzE; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="hGVYKnzE"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731677841;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u/TMOvkqZ/FnYyOxqrC4adz+lT/oE0yqtlVAGkTsckw=;
	b=hGVYKnzEpaLHCzjDh6fed55ak9XEfTOIf09JjTsPBdk3xDUGYXEsoWbWSFWgN/VK10QKYr
	tJaKrOG999JT07y9FVGfBvU4wPEUHrBAofUeJ18gbFL7FbP40BgYno4StjOSgSay+D6iIn
	ANTKVVMOJFjBCScYYVlRZSa3gFtkYo6lcsTwyETCrnjMrrfl59ARqS6MUCUtqXeIsvM/wk
	1kN3NWGDI9klRhONKXZm2HZ4PdDCU/SsJdHspCOTPRJxnEjOoEhi1Ow6nOZx3MGTKxvs8T
	ovYu3czZde3evXwfJZlLR+ZTYU6MlDowJy25cgZ1+KRGkMWTH3jkADhc+bMGIw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Eric Suen <ericsu@linux.microsoft.com>,
	Jacob Satterfield <jsatterfield.linux@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 21/22] selinux: check for simple types
Date: Fri, 15 Nov 2024 14:35:40 +0100
Message-ID: <20241115133619.114393-21-cgoettsche@seltendoof.de>
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

Validate that the target of AVTAB_TYPE rules and file transitions are
simple types and not attributes.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/avtab.c    |  9 ++++++++-
 security/selinux/ss/policydb.c | 23 +++++++++++++++++++++--
 security/selinux/ss/policydb.h |  1 +
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 002853dd3443..2aa16aa75aac 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -424,6 +424,13 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
 				}
 				key.specified = spec_order[i] | enabled;
 				datum.u.data = le32_to_cpu(buf32[items++]);
+
+				if ((key.specified & AVTAB_TYPE) &&
+				    !policydb_simpletype_isvalid(pol, datum.u.data)) {
+					pr_err("SELinux: avtab: invalid type\n");
+					return -EINVAL;
+				}
+
 				rc = insertf(a, &key, &datum, p);
 				if (rc)
 					return rc;
@@ -519,7 +526,7 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
 		datum.u.data = le32_to_cpu(*buf32);
 	}
 	if ((key.specified & AVTAB_TYPE) &&
-	    !policydb_type_isvalid(pol, datum.u.data)) {
+	    !policydb_simpletype_isvalid(pol, datum.u.data)) {
 		pr_err("SELinux: avtab: invalid type\n");
 		return -EINVAL;
 	}
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 17fbd145ba1b..917b468c5144 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -681,7 +681,7 @@ static int role_validate(void *key, void *datum, void *datap)
 	}
 
 	ebitmap_for_each_positive_bit(&role->types, node, i) {
-		if (!policydb_type_isvalid(p, i + 1))
+		if (!policydb_simpletype_isvalid(p, i + 1))
 			goto bad;
 	}
 
@@ -1042,6 +1042,23 @@ bool policydb_type_isvalid(const struct policydb *p, u32 type)
 	return true;
 }
 
+bool policydb_simpletype_isvalid(const struct policydb *p, u32 type)
+{
+	const struct type_datum *datum;
+
+	if (!type || type > p->p_types.nprim)
+		return false;
+
+	datum = p->type_val_to_struct[type - 1];
+	if (!datum)
+		return false;
+
+	if (datum->attribute)
+		return false;
+
+	return true;
+}
+
 bool policydb_boolean_isvalid(const struct policydb *p, u32 boolean)
 {
 	if (!boolean || boolean > p->p_bools.nprim)
@@ -2225,6 +2242,8 @@ static int filename_trans_read_helper_compat(struct policydb *p, struct policy_f
 	key.name = name;
 
 	otype = le32_to_cpu(buf[3]);
+	if (!policydb_simpletype_isvalid(p, otype))
+		goto out;
 
 	last = NULL;
 	datum = policydb_filenametr_search(p, &key);
@@ -2347,7 +2366,7 @@ static int filename_trans_read_helper(struct policydb *p, struct policy_file *fp
 		datum->otype = le32_to_cpu(buf[0]);
 
 		rc = -EINVAL;
-		if (!policydb_type_isvalid(p, datum->otype))
+		if (!policydb_simpletype_isvalid(p, datum->otype))
 			goto out;
 
 		dst = &datum->next;
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 28dd91a7427f..73a0b793354e 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -317,6 +317,7 @@ extern int policydb_load_isids(struct policydb *p, struct sidtab *s);
 extern bool policydb_context_isvalid(const struct policydb *p, const struct context *c);
 extern bool policydb_class_isvalid(const struct policydb *p, u16 class);
 extern bool policydb_type_isvalid(const struct policydb *p, u32 type);
+extern bool policydb_simpletype_isvalid(const struct policydb *p, u32 type);
 extern bool policydb_role_isvalid(const struct policydb *p, u32 role);
 extern bool policydb_user_isvalid(const struct policydb *p, u32 user);
 extern bool policydb_boolean_isvalid(const struct policydb *p, u32 boolean);
-- 
2.45.2

