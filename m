Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850A820C47D;
	Mon, 16 Dec 2024 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367326; cv=none; b=sojUgUJicjQJzuee7E0iyYzIkf+Lsq3mu2smcFU5mVHAQywpVlBEp1fo82rhsDd9GPhpAp3wLibI7L5eqrlklg6DwALjMbKHoeYssyVm/lC8QIT5MyjyKB9dg/kY/r7XNZIHueDqpG+dimo98j/BrRghW28VMqImHsbMi9xM9nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367326; c=relaxed/simple;
	bh=lG7kCzNYxAE8JcpY/rhz9UzbLODdEmezVnyk86k79K4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZYqf3qmDP3VlCHdGyYGqVy/bumV4kR+PBtZj5vsGLzQ+LY16nETL5qS49FOC/xUhWnf9I14EWZC54n+ffrl7iq+/IiNF906z/AolqmjwqSsM6GJPimnzeL09pFndgslk/+CcKZyLgip/ddgKLcWz4T4CBc0BNoqQbEXTkpMF0Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=chRq2tOk; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="chRq2tOk"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1734367322;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9rBUfCncS2FApmBXST8Fna9TuF415rRP2IdKs02OjYo=;
	b=chRq2tOknsX4RTAqvyQfKhFX9ghIncmlq7XiRtYL1fh3/MyIvIpagG4kK8QRAQnAPMEyAM
	z5ARkPKCw9egUB9VhoJSOkg7DznibORkX+5dnsB90wAUWdsjqCX+ADtI/XJOor1EDKpuv4
	zUk7PsYXKbhgF/ur/Jmah7E25e5recDyisGEoQ/4X4zRDy3OLc+SciyXrkej9AQaVDWhag
	1eOVZJAynNsLbAQf1/yZLUUd4OhbWW55Yi49GPPUVxOy19xB+wzOJqem0wibVBhSmETtfu
	vkwFU23NvPY+/rtyUyXpaSLyUO0adZKycoiYm6MrPIXzjqMNWbMjHl70pc+wUg==
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
	Eric Suen <ericsu@linux.microsoft.com>
Subject: [RFC PATCH v2 21/22] selinux: check for simple types
Date: Mon, 16 Dec 2024 17:40:19 +0100
Message-ID: <20241216164055.96267-21-cgoettsche@seltendoof.de>
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

Validate that the target of AVTAB_TYPE rules and file transitions are
simple types and not attributes.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/avtab.c    |  9 ++++++++-
 security/selinux/ss/policydb.c | 23 +++++++++++++++++++++--
 security/selinux/ss/policydb.h |  1 +
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index a7bf0ceb45d4..6b6e1540cf7e 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -423,6 +423,13 @@ int avtab_read_item(struct avtab *a, struct policy_file *fp, struct policydb *po
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
index 57ab2a811a15..34db40753654 100644
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
@@ -2230,6 +2247,8 @@ static int filename_trans_read_helper_compat(struct policydb *p, struct policy_f
 	key.name = name;
 
 	otype = le32_to_cpu(buf[3]);
+	if (!policydb_simpletype_isvalid(p, otype))
+		goto out;
 
 	last = NULL;
 	datum = policydb_filenametr_search(p, &key);
@@ -2352,7 +2371,7 @@ static int filename_trans_read_helper(struct policydb *p, struct policy_file *fp
 		datum->otype = le32_to_cpu(buf[0]);
 
 		rc = -EINVAL;
-		if (!policydb_type_isvalid(p, datum->otype))
+		if (!policydb_simpletype_isvalid(p, datum->otype))
 			goto out;
 
 		dst = &datum->next;
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 512d2081733b..d979965ef939 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -322,6 +322,7 @@ extern int policydb_load_isids(struct policydb *p, struct sidtab *s);
 extern bool policydb_context_isvalid(const struct policydb *p, const struct context *c);
 extern bool policydb_class_isvalid(const struct policydb *p, u16 class);
 extern bool policydb_type_isvalid(const struct policydb *p, u32 type);
+extern bool policydb_simpletype_isvalid(const struct policydb *p, u32 type);
 extern bool policydb_role_isvalid(const struct policydb *p, u32 role);
 extern bool policydb_user_isvalid(const struct policydb *p, u32 user);
 extern bool policydb_boolean_isvalid(const struct policydb *p, u32 boolean);
-- 
2.45.2

