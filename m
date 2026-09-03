Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4455247042C
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788435827; cv=none; b=a4rapMK/JrZzuM0HeYyKFiN1B9WmicNzE8AOvO8yojlzqRY/V9q7OKg7x/chwKnrdxyJoBvltBtiaGU0JzQexkeAz5xJq/bScx0B+Pn3zljS3H61wWWWLlX7I/6thfGPL0DEUWwkX5tdp4BOW8AvSaNJ0jvYpHtuYLn1976nYOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788435827; c=relaxed/simple;
	bh=8sj6VJvkxJixrXjUgCucmvdJa9UYmw4S2Z+y0MH6n2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y4FqKtzW9stcg7i8nUAiL3Ai1H+9LSqS66KGIs07VbTQdtifeT4YmKtpqibnXenkYIEqAdkI/weKh9Pog5+dGOkYT9hOzlpBdK51QBczqISQTGDpGH5u1SvL0iIOPfPYPdCue7BlQCRHEN50jSYlBYCshBJLorvEwSfty80GC58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=cFdqHMhI; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="cFdqHMhI"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1788435373;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AKO6B25vMbTdnbzZGsXe7bHFL3/ztHFhRGhJoUXUaPY=;
	b=cFdqHMhIbkLcI8gmhubDojr82bCUe+/wowL+hpiPrJwIdUtEkukK4lvejsJtX/z9fpLurm
	GSquMRPXFv8QiNWBzM7d+0fNkjnVh7DKcctQpLvVkbltuJZSdTltHr3THs9RsTYSJu+9Xh
	W5++2wU16R7593QAORBVE3EbdrSNH1JeQsCrDMXqgDXDgYBTonjs6yZOzPXjfXlrwMK0po
	Ww+25HqvwPGFu2sFeZWOVFCnJOOUXri2OvF9TFYqgHfbtIFcAKQLjis6iA6UPZtKvdV+SG
	kZOg9xyHvYoQBWizk4y5g8SN/UF6GR6x2XHlURXSl+dUzApbTvqmKKCzJ/1u4w==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 3/5] selinux: bounds-check role and user membership bitmaps at load
Date: Thu,  3 Sep 2026 13:35:35 +0200
Message-ID: <20260903113538.72942-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260903113538.72942-1-cgoettsche@seltendoof.de>
References: <20260903113538.72942-1-cgoettsche@seltendoof.de>
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
their set bits are never checked against the role and type symbol tables.
An out-of-range bit is used to index those tables later; in particular
role_bounds_sanity_check() passes such a bit straight to sym_name(),
reading p->sym_val_to_name[] out of bounds on a crafted bounded role.

Validate the three bitmaps in policydb_index() once every symbol table is
populated (roles are read before types, so this cannot be done in
role_read()).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/policydb.c | 42 ++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 1a60d0f4be55..3bef28434180 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -707,6 +707,40 @@ static int sens_cat_index_check(void *key, void *datum, void *datap)
 	return 0;
 }
 
+static int role_index_check(void *key, void *datum, void *datap)
+{
+	const struct policydb *p = datap;
+	const struct role_datum *role = datum;
+
+	if (ebitmap_get_highest_set_bit(&role->dominates) >= p->p_roles.nprim) {
+		pr_err("SELinux: role %s has an out-of-range dominance bit\n",
+		       (const char *)key);
+		return -EINVAL;
+	}
+
+	if (ebitmap_get_highest_set_bit(&role->types) >= p->p_types.nprim) {
+		pr_err("SELinux: role %s has an out-of-range type bit\n",
+		       (const char *)key);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int user_index_check(void *key, void *datum, void *datap)
+{
+	const struct policydb *p = datap;
+	const struct user_datum *usr = datum;
+
+	if (ebitmap_get_highest_set_bit(&usr->roles) >= p->p_roles.nprim) {
+		pr_err("SELinux: user %s authorizes an out-of-range role\n",
+		       (const char *)key);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /* clang-format off */
 static int (*const index_f[SYM_NUM])(void *key, void *datum, void *datap) = {
 	common_index,
@@ -836,6 +870,14 @@ static int policydb_index(struct policydb *p)
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

