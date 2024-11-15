Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E161D12E7;
	Fri, 15 Nov 2024 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677835; cv=none; b=l16Yf1kEPC09nXssPc2VJLSap2ViGFR6frWpoNiVcDoxRuV+PgCsrVv+cP0X6CfghNHAUDPjCBYLB4NW5bZBqmjYGyvK8QMXkF7tPSGb06TYWt4eS5L2IizgCOKS14uufuL5naJXbp2dvsmzd4/5Wgkm0fO8iFqVXM87l76pVPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677835; c=relaxed/simple;
	bh=YCmxocFjVW/QPScnM+jx3LAcf7uLd3n4k6yk2XY8Bpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PuMPbICmiMzTwgFoxfIaOlk1lKAhkOQZYxnGH41nOhOGfDFqLuNvPi5pfamGC0UozAF5Tizj8LPyIW24ZiNqsBueXGSfleRLjKkGtvXeMIAsz0d0plZF8+VbkzGGfxBMY023UjDHYJpugGKPa0OBapKfCSP5glJ7CqBdXdP5+gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=tYyxzTSj; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="tYyxzTSj"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731677831;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SHcvjlb6cyEnD4k6C25pa+KjATBvNG4Z+HzMzBZN1WM=;
	b=tYyxzTSjmhlCeVXjj6sIhynePGIr3F/ww0E7hDl2pL2mXq2exiG+TT8XT6Q9zde5ywoKH0
	MomU0xHw2yYb+uplLy8jR+8hfqBgBMGlJD/OQK8EllzqK/VoWRGhFI8NtMsWGKquUxo0SL
	qYn8zFZbSFtBaKQSy0o8AGM0hFcav++N2NTQyVEbou31k782uXdIw+Fc4DbKEqRF++LOsD
	/zxMv0b6O0SBYpoaM0CsklGQa8KB7csOi6c3bHDiHIOyRsr7P/wuZvrYXcpHziqdj3HMBh
	Q/0aEp2ZMeB+M00KnidbxKuELlZH0nJpWqePzs0sbDkjmPs6dsnEjXTZN2KmnQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 14/22] selinux: pre-validate conditional expressions
Date: Fri, 15 Nov 2024 14:35:33 +0100
Message-ID: <20241115133619.114393-14-cgoettsche@seltendoof.de>
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

Validate conditional expressions while reading the policy, to avoid
unexpected access decisions on malformed policies.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/conditional.c | 116 ++++++++++++++++++++----------
 security/selinux/ss/policydb.c    |   7 ++
 security/selinux/ss/policydb.h    |   1 +
 3 files changed, 88 insertions(+), 36 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 07008ea081ba..d37b4bdf6ba9 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -21,65 +21,119 @@
  * or undefined (-1). Undefined occurs when the expression
  * exceeds the stack depth of COND_EXPR_MAXDEPTH.
  */
-static int cond_evaluate_expr(struct policydb *p, struct cond_expr *expr)
+static int cond_evaluate_expr(const struct policydb *p, const struct cond_expr *expr)
 {
 	u32 i;
 	int s[COND_EXPR_MAXDEPTH];
 	int sp = -1;
 
-	if (expr->len == 0)
-		return -1;
+	if (unlikely(expr->len == 0))
+		goto invalid;
 
 	for (i = 0; i < expr->len; i++) {
-		struct cond_expr_node *node = &expr->nodes[i];
+		const struct cond_expr_node *node = &expr->nodes[i];
 
 		switch (node->expr_type) {
 		case COND_BOOL:
-			if (sp == (COND_EXPR_MAXDEPTH - 1))
-				return -1;
+			if (unlikely(sp >= (COND_EXPR_MAXDEPTH - 1)))
+				goto invalid;
 			sp++;
 			s[sp] = p->bool_val_to_struct[node->boolean - 1]->state;
 			break;
 		case COND_NOT:
-			if (sp < 0)
-				return -1;
+			if (unlikely(sp < 0))
+				goto invalid;
 			s[sp] = !s[sp];
 			break;
 		case COND_OR:
-			if (sp < 1)
-				return -1;
+			if (unlikely(sp < 1))
+				goto invalid;
 			sp--;
 			s[sp] |= s[sp + 1];
 			break;
 		case COND_AND:
-			if (sp < 1)
-				return -1;
+			if (unlikely(sp < 1))
+				goto invalid;
 			sp--;
 			s[sp] &= s[sp + 1];
 			break;
 		case COND_XOR:
-			if (sp < 1)
-				return -1;
+			if (unlikely(sp < 1))
+				goto invalid;
 			sp--;
 			s[sp] ^= s[sp + 1];
 			break;
 		case COND_EQ:
-			if (sp < 1)
-				return -1;
+			if (unlikely(sp < 1))
+				goto invalid;
 			sp--;
 			s[sp] = (s[sp] == s[sp + 1]);
 			break;
 		case COND_NEQ:
-			if (sp < 1)
-				return -1;
+			if (unlikely(sp < 1))
+				goto invalid;
 			sp--;
 			s[sp] = (s[sp] != s[sp + 1]);
 			break;
 		default:
-			return -1;
+			goto invalid;
 		}
 	}
+
+	if (unlikely(sp != 0))
+		goto invalid;
+
 	return s[0];
+
+invalid:
+	/* Should *never* be reached, cause malformed expressions should
+	 * have been filtered by cond_validate_expr().
+	 */
+	WARN_ONCE(true, "SELinux: invalid conditional expression passed validation\n");
+	return -1;
+}
+
+static int cond_validate_expr(const struct policydb *p, const struct cond_expr *expr)
+{
+	u32 i;
+	int depth = -1;
+
+	if (expr->len == 0)
+		return -EINVAL;
+
+	for (i = 0; i < expr->len; i++) {
+		const struct cond_expr_node *node = &expr->nodes[i];
+
+		switch (node->expr_type) {
+		case COND_BOOL:
+			if (depth >= (COND_EXPR_MAXDEPTH - 1))
+				return -EINVAL;
+			depth++;
+			if (!policydb_boolean_isvalid(p, node->boolean))
+				return -EINVAL;
+			break;
+		case COND_NOT:
+			if (depth < 0)
+				return -EINVAL;
+			break;
+		case COND_OR:
+		case COND_AND:
+		case COND_XOR:
+		case COND_EQ:
+		case COND_NEQ:
+			if (depth < 1)
+				return -EINVAL;
+			depth--;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	if (depth != 0)
+		return -EINVAL;
+
+	return 0;
 }
 
 /*
@@ -355,21 +409,6 @@ static int cond_read_av_list(struct policydb *p, struct policy_file *fp,
 	return 0;
 }
 
-static int expr_node_isvalid(struct policydb *p, struct cond_expr_node *expr)
-{
-	if (expr->expr_type <= 0 || expr->expr_type > COND_LAST) {
-		pr_err("SELinux: conditional expressions uses unknown operator.\n");
-		return 0;
-	}
-
-	if (expr->expr_type == COND_BOOL &&
-	    (expr->boolean == 0 || expr->boolean > p->p_bools.nprim)) {
-		pr_err("SELinux: conditional expressions uses unknown bool.\n");
-		return 0;
-	}
-	return 1;
-}
-
 static int cond_read_node(struct policydb *p, struct cond_node *node, struct policy_file *fp)
 {
 	__le32 buf[2];
@@ -384,6 +423,8 @@ static int cond_read_node(struct policydb *p, struct cond_node *node, struct pol
 
 	/* expr */
 	len = le32_to_cpu(buf[1]);
+	if (len == 0)
+		return -EINVAL;
 
 	rc = oom_check(2 * sizeof(u32), len, fp);
 	if (rc)
@@ -404,9 +445,12 @@ static int cond_read_node(struct policydb *p, struct cond_node *node, struct pol
 
 		expr->expr_type = le32_to_cpu(buf[0]);
 		expr->boolean = le32_to_cpu(buf[1]);
+	}
 
-		if (!expr_node_isvalid(p, expr))
-			return -EINVAL;
+	rc = cond_validate_expr(p, &node->expr);
+	if (rc) {
+		pr_err("SELinux: invalid conditional expression\n");
+		return rc;
 	}
 
 	rc = cond_read_av_list(p, fp, &node->true_list, NULL);
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 5d99e1498b55..1768ac4ecc2c 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -940,6 +940,13 @@ int policydb_type_isvalid(struct policydb *p, unsigned int type)
 	return 1;
 }
 
+int policydb_boolean_isvalid(const struct policydb *p, u32 boolean)
+{
+	if (!boolean || boolean > p->p_bools.nprim)
+		return 0;
+	return 1;
+}
+
 /*
  * Return 1 if the fields in the security context
  * structure `c' are valid.  Return 0 otherwise.
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index fee9132b0d42..c94253a1ddbc 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -318,6 +318,7 @@ extern int policydb_context_isvalid(struct policydb *p, struct context *c);
 extern int policydb_class_isvalid(struct policydb *p, u16 class);
 extern int policydb_type_isvalid(struct policydb *p, unsigned int type);
 extern int policydb_role_isvalid(struct policydb *p, unsigned int role);
+extern int policydb_boolean_isvalid(const struct policydb *p, u32 boolean);
 
 struct policy_file {
 	char *data;
-- 
2.45.2

