Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AAC4F3EB6
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614396; cv=none; b=HyHj17CO/u2K65YUcw3pV1lrEIdl1ohnU7ZU/CNFSAD1pz6m9JNNjq+I1Oza6GYP3vfgmhRtncXPZoBbVG3rrHbYw4j5Vz8yPZms/TVytN0DtoCebvVmGhLEhQoo6CDao0gfdhIZrRwy7QDu0oPCeQ9KzQhLeZxfQPOwmF6brw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614396; c=relaxed/simple;
	bh=CtCvgeTSu+dAmozwEeMrHF7/npJIFhWgFrVtAlgw0O8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R/HRD5y2hu5+kHzHhabEV7HAcPHs1bpMX06g8+hiwl6FxpIcyP8M6E/bSzUIVYdApJNf1yqomumciBEairHwmJ4S8cyYwGStXhFup9LBdjXXwOqZi9rubbYmNP0Rjd5HgeaLmEX3+OdIo0z5IXOL5Nmjjwmzl2Aa7/Fm8Yebei4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Ulv7VBsq; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Ulv7VBsq"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790614392;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=igXv/HUVv2Ryj2XsbHZxpIMNWSy/XvxFw9bfqrQa3lA=;
	b=Ulv7VBsqL3BPuvPX/Nt2yys5FtJqs4ZFWzhmLQnasoOpnNllimN/rrAEchljxnEzJ1tr/B
	ED9hu3MrFhmEQ6aQkOqcuMmMpgSK4xpY9FJ0KQ+v5yjsN9GpUxpS8neyQmBP+Rl6FOFqm9
	OMUWog0KobwVj9uUYY8NIZzsIh2CwYI5f1CLJViU3AVyy+3eszugT/k5xVwdsu/8QQ1JzA
	FJEu/L8fUmifsH8R1Lo4d8ZePxDhLwOKHrqM5yrHW/NxQLtFU1D9GB8aa+ZfXK7LpBYGld
	1Re2UFaHzw78oDhrU61azTFUgtBoj8VSL6A4EgZbMxhUyzo5pGN6BsdClJW9Tw==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 1/3] selinux: bounds-check role and user membership bitmaps at load
Date: Mon, 28 Sep 2026 18:52:53 +0200
Message-ID: <20260928165253.2388012-3-cgoettsche@seltendoof.de>
In-Reply-To: <20260928165253.2388012-1-cgoettsche@seltendoof.de>
References: <20260928165253.2388012-1-cgoettsche@seltendoof.de>
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

role->dominates, role->types and user->roles are read as ebitmaps but
their set bits are never checked against the role and type symbol
tables. A bit naming an undefined value is silently accepted, and an
out-of-range one is used to index those tables later; in particular
role_bounds_sanity_check() passes such a bit straight to sym_name(),
reading p->sym_val_to_name[] out of bounds on a crafted bounded role.

Validate the three bitmaps in policydb_index() once every symbol table
is populated (roles are read before types, so this cannot be done in
role_read()).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: check each bit instead of just comparing the highest bit against
nprim
---
 security/selinux/ss/policydb.c | 52 ++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 13d88e47db3c..e0304297def4 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -707,6 +707,50 @@ static int sens_cat_index_check(void *key, void *datum, void *datap)
 	return 0;
 }
 
+static int role_index_check(void *key, void *datum, void *datap)
+{
+	const struct policydb *p = datap;
+	const struct role_datum *role = datum;
+	struct ebitmap_node *node;
+	u32 bit;
+
+	ebitmap_for_each_positive_bit(&role->dominates, node, bit) {
+		if (!policydb_role_isvalid(p, bit + 1)) {
+			pr_err("SELinux:  role %s declares dominance on undefined role %u\n",
+			       (const char *)key, bit + 1);
+			return -EINVAL;
+		}
+	}
+
+	ebitmap_for_each_positive_bit(&role->types, node, bit) {
+		if (!policydb_type_isvalid(p, bit + 1)) {
+			pr_err("SELinux:  role %s authorizes undefined type %u\n",
+			       (const char *)key, bit + 1);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int user_index_check(void *key, void *datum, void *datap)
+{
+	const struct policydb *p = datap;
+	const struct user_datum *usr = datum;
+	struct ebitmap_node *node;
+	u32 bit;
+
+	ebitmap_for_each_positive_bit(&usr->roles, node, bit) {
+		if (!policydb_role_isvalid(p, bit + 1)) {
+			pr_err("SELinux:  user %s authorizes undefined role %u\n",
+			       (const char *)key, bit + 1);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 /* clang-format off */
 static int (*const index_f[SYM_NUM])(void *key, void *datum, void *datap) = {
 	common_index,
@@ -836,6 +880,14 @@ static int policydb_index(struct policydb *p)
 			goto out;
 	}
 
+	rc = hashtab_map(&p->p_roles.table, role_index_check, p);
+	if (rc)
+		goto out;
+
+	rc = hashtab_map(&p->p_users.table, user_index_check, p);
+	if (rc)
+		goto out;
+
 	rc = 0;
 out:
 	return rc;
-- 
2.55.0

