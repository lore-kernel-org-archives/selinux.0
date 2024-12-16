Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CFF20C02C;
	Mon, 16 Dec 2024 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367322; cv=none; b=YG0jyUoatvVLn/OR2XjWCvfhfWlvmCtEmwq5PX8NNlLCExDEy0k6hvBORgFFzxIRObLXpamK2+aUUrqFkCq+q/Rr8cMQgtks801Jzkrs6xV+8UWg/Dd6JI3YH1Vr5lGPfKp3ezRARLsNTB7lOp0VhvkmlzUbBsBdOU+XlOfraxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367322; c=relaxed/simple;
	bh=fIcZ5Xj8C8Oj8FZcRN5Gbr/C/m51uRS8ByQPpn58ThA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJsA1UVykidluGugDmpryrt/QC1uRqml0pkku3D36XJv8je8NIW3rJgM6K5Rm60ZaLVoUEJcrDtcDnYRFuagPt4PcgrBwGyy+5L33nNcJ3ymGBSS1od8i7j1BZ9TIDz/hmjIwexNG5xJzEQDykhKeYBJwQWAE1HVI9u621GsoRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Qs8KU2bG; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Qs8KU2bG"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1734367319;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LV+sbTjEWQAFpQ5C0FTAsDA0F0DIiqPLpESDx1eDNSc=;
	b=Qs8KU2bGKrvcIM3NlOSN4Rc8r1uSyjAiPaGkW74T2FJ2Ko18KQfD57LZl5/yetOLCWgngm
	DKyiF4l1NC/D6K5y1ZMZXAFtb+gyCMNoJsjBATP4v68JdMm1wvUas3yz6Y4XkDj0QFK8G0
	6ignqlq3rGpYDwFk0T6A1GmZxa6sBaZ4aYDFhSY/bx/Xu/roq/Yq+I38X4suPFZB78Fn8W
	cGG8nEMd6UJ+NdX7j3VOC2aBnOFRrOH0O0VL/R5lh9UdP22hGYGNP77am4S1fDKAvjzEQ6
	hGwgEs5n5haGjkXr78t2Ksc1QRA68jV2lDVcHEibCBJNONKZ9wG6TCIY/zCEjQ==
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
	llvm@lists.linux.dev
Subject: [RFC PATCH v2 19/22] selinux: validate symbols
Date: Mon, 16 Dec 2024 17:40:17 +0100
Message-ID: <20241216164055.96267-19-cgoettsche@seltendoof.de>
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

Some symbol tables need to be validated after indexing, since during
indexing their referenced entries might not yet have been indexed.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/policydb.c | 94 ++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index a4c9377b8060..e9e478650e74 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -673,6 +673,84 @@ static int (*const index_f[SYM_NUM])(void *key, void *datum, void *datap) = {
 };
 /* clang-format on */
 
+static int role_validate(void *key, void *datum, void *datap)
+{
+	const struct policydb *p = datap;
+	const struct role_datum *role = datum;
+	struct ebitmap_node *node;
+	u32 i;
+
+	ebitmap_for_each_positive_bit(&role->dominates, node, i) {
+		if (!policydb_role_isvalid(p, i))
+			goto bad;
+	}
+
+	ebitmap_for_each_positive_bit(&role->types, node, i) {
+		if (!policydb_type_isvalid(p, i + 1))
+			goto bad;
+	}
+
+	return 0;
+
+bad:
+	pr_err("SELinux:  invalid role %s\n", sym_name(p, SYM_ROLES, role->value - 1));
+	return -EINVAL;
+}
+
+static int user_validate(void *key, void *datum, void *datap)
+{
+	const struct policydb *p = datap;
+	const struct user_datum *usrdatum = datum;
+	struct ebitmap_node *node;
+	u32 i;
+
+	ebitmap_for_each_positive_bit(&usrdatum->roles, node, i) {
+		if (!policydb_role_isvalid(p, i))
+			goto bad;
+	}
+
+	if (!mls_range_isvalid(p, &usrdatum->range))
+		goto bad;
+
+	if (!mls_level_isvalid(p, &usrdatum->dfltlevel))
+		goto bad;
+
+	return 0;
+
+bad:
+	pr_err("SELinux:  invalid user %s\n", sym_name(p, SYM_USERS, usrdatum->value - 1));
+	return -EINVAL;
+}
+
+static int sens_validate(void *key, void *datum, void *datap)
+{
+	const struct policydb *p = datap;
+	const struct level_datum *levdatum = datum;
+
+	if (!mls_level_isvalid(p, &levdatum->level))
+		goto bad;
+
+	return 0;
+
+bad:
+	pr_err("SELinux:  invalid sensitivity\n");
+	return -EINVAL;
+}
+
+
+/* clang-format off */
+static int (*const validate_f[SYM_NUM])(void *key, void *datum, void *datap) = {
+	NULL, /* Everything validated in common_read() and common_index() */
+	NULL, /* Everything validated in class_read() and class_index() */
+	role_validate,
+	NULL, /* Everything validated in type_read(), type_index() and type_bounds_sanity_check() */
+	user_validate,
+	NULL, /* Everything validated in cond_read_bool() and cond_index_bool() */
+	sens_validate,
+	NULL, /* Everything validated in cat_read() and cat_index() */
+};
+/* clang-format on */
+
 #ifdef CONFIG_SECURITY_SELINUX_DEBUG
 static void hash_eval(struct hashtab *h, const char *hash_name,
 		      const char *hash_details)
@@ -765,6 +843,16 @@ static int policydb_index(struct policydb *p)
 		if (rc)
 			goto out;
 	}
+
+	for (i = 0; i < SYM_NUM; i++) {
+		if (!validate_f[i])
+			continue;
+
+		rc = hashtab_map(&p->symtab[i].table, validate_f[i], p);
+		if (rc)
+			goto out;
+	}
+
 	rc = 0;
 out:
 	return rc;
@@ -1087,6 +1175,12 @@ static int context_read_and_validate(struct context *c, struct policydb *p,
 			pr_err("SELinux: error reading MLS range of context\n");
 			goto out;
 		}
+
+		rc = -EINVAL;
+		if (!mls_range_isvalid(p, &c->range)) {
+			pr_warn("SELinux: invalid range in security context\n");
+			goto out;
+		}
 	}
 
 	rc = -EINVAL;
-- 
2.45.2

