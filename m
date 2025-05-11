Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2552325EF8E;
	Sun, 11 May 2025 17:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746984691; cv=none; b=KAG/bdzVx+le17gVRybIdkZPGUk1QqnUODMPHLV8sgdBKJH4YeQ+4eDuH6EaNl6H8hrMcnSJ6uhM9EB2u5875/SdZQSkN4td+8NoSSE6z6emMPMYJEKKojy/zZ35VtTCl15uinGoYYjLwuk1kDxEJUTj4sJedZ9Ll+SXFlkMTdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746984691; c=relaxed/simple;
	bh=HyB3gvgb/h0JQKUj9GiU9x13uSqTvYTFQk75IrUs0CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kwHxhE60SdvL2TXhx9Re0XkhHSy3w++xMRitRpAHp0BLx+528EBiZsH+fp8HQu6FiIne8j2aDEP6FGf89NVqUD/PCO4Hqu5ANOvrajX5rPcGbdC/m37v1LkyhsBcf3T8oYQ3cTRnb4Q0oLitvCzDxP8Nfjaob/PO33ne1s0tPpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=J+EKzBdh; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="J+EKzBdh"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1746984687;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ai09QT5phA4whwFRDzwcyznvZ9H2i0DJqd7XX39Ep5s=;
	b=J+EKzBdhuAeEv/U4iHP1fys1yBB5EEZbdJ0YqLf9D7Ic5WuLCFkod2F+IGttnos9hOD7iG
	yOD5vJLliwRjhLdlvfRsafsY+zrVjoh9Ue5tUo8fdLHwu7/KLnTALtx/EgPXjRTnjyx91R
	mpra55SzZM7qWPL/e/lNiwasTs9cVdFuJs37ox4ihV6vvsSvU0c2grHH9I1WHoo8tObs/p
	MKOb9Hu8GPmVK6JGH7EcM93Eo637n7OmaiTv+o4gBUWxhjAf8CGGwNeYsF/vY8ej3ngjSa
	qm/9cf5YTQToUpP1wGXTyrPXD1BjILKWPSaOqJQ1Zab0e6xlcXL/IDIDNCsXZQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-kernel@vger.kernel.org,
	Eric Suen <ericsu@linux.microsoft.com>
Subject: [PATCH v3 12/14] selinux: check for simple types
Date: Sun, 11 May 2025 19:30:12 +0200
Message-ID: <20250511173055.406906-12-cgoettsche@seltendoof.de>
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

Validate that the target of AVTAB_TYPE rules and file transitions are
simple types and not attributes.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/avtab.c    |  9 ++++++++-
 security/selinux/ss/policydb.c | 23 +++++++++++++++++++++--
 security/selinux/ss/policydb.h |  1 +
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 50df8b69de2b..5b45f37fdcbb 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -426,6 +426,13 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
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
@@ -517,7 +524,7 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
 		datum.u.data = le32_to_cpu(*buf32);
 	}
 	if ((key.specified & AVTAB_TYPE) &&
-	    !policydb_type_isvalid(pol, datum.u.data)) {
+	    !policydb_simpletype_isvalid(pol, datum.u.data)) {
 		pr_err("SELinux: avtab: invalid type\n");
 		return -EINVAL;
 	}
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 7774f6da2ebe..2b098d9abf17 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -686,7 +686,7 @@ static int role_validate(void *key, void *datum, void *datap)
 	}
 
 	ebitmap_for_each_positive_bit(&role->types, node, i) {
-		if (!policydb_type_isvalid(p, i + 1))
+		if (!policydb_simpletype_isvalid(p, i + 1))
 			goto bad;
 	}
 
@@ -1047,6 +1047,23 @@ bool policydb_type_isvalid(const struct policydb *p, u32 type)
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
@@ -2235,6 +2252,8 @@ static int filename_trans_read_helper_compat(struct policydb *p, struct policy_f
 	key.name = name;
 
 	otype = le32_to_cpu(buf[3]);
+	if (!policydb_simpletype_isvalid(p, otype))
+		goto out;
 
 	last = NULL;
 	datum = policydb_filenametr_search(p, &key);
@@ -2357,7 +2376,7 @@ static int filename_trans_read_helper(struct policydb *p, struct policy_file *fp
 		datum->otype = le32_to_cpu(buf[0]);
 
 		rc = -EINVAL;
-		if (!policydb_type_isvalid(p, datum->otype))
+		if (!policydb_simpletype_isvalid(p, datum->otype))
 			goto out;
 
 		dst = &datum->next;
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 04acf414fffa..b4f0c1a754cf 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -323,6 +323,7 @@ extern int policydb_load_isids(struct policydb *p, struct sidtab *s);
 extern bool policydb_context_isvalid(const struct policydb *p, const struct context *c);
 extern bool policydb_class_isvalid(const struct policydb *p, u16 class);
 extern bool policydb_type_isvalid(const struct policydb *p, u32 type);
+extern bool policydb_simpletype_isvalid(const struct policydb *p, u32 type);
 extern bool policydb_role_isvalid(const struct policydb *p, u32 role);
 extern bool policydb_user_isvalid(const struct policydb *p, u32 user);
 extern bool policydb_boolean_isvalid(const struct policydb *p, u32 boolean);
-- 
2.49.0

