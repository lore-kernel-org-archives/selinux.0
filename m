Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A41209691;
	Mon, 16 Dec 2024 16:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367314; cv=none; b=Q5MRLNmdYhP/L+h6rwQIn0+o108UUiCCFYmnGxHZyB1U4bZw5tAb+XaxE4bxT/D5laD6ErV2VPToU9UfdRWpK3Zu+Sa9VU2DzafgDbI8rjitOnGaWlZLGEP4dXQaEnPrSgPVn6bfGJxoz4sjIMkR+RIAfSz1esgdbywS11TcFf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367314; c=relaxed/simple;
	bh=b2/bAUa3uU4xGRpTkqAPQmGZckpsomMdp5ki8nrz83c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oCeqO2h5+CAsbdTU+PHEOo4/qV3BbGlBd/yneV1NYb4dQOU0aJUcPWH3GwicJQ3FT4yPwALVB0/e/JgR6IOdO8V3Zfiu3NkPefff2YD2wrV6gHbcgyBVKO9mku+WJ3hmGCCawh9lwAA5ch/eAMytr3ZNJXWGWIKkd8o2LLpsYX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Xhb0dSYH; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Xhb0dSYH"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1734367310;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5g+YzU3UkkvK//tDI64BBAmVRSQ2FrzfFCafu029vNA=;
	b=Xhb0dSYHN53Gl9M08Ety6BDy1XU/+2lejf8V2qFEODWD88b4iBI96mK7YXUw5hzCbLwt1m
	6IpTHls8S1jtVqrD2/YYzH3PBq4TP12+DnZQ/eElew8RQCrjnJ1wePbQda3yCpHgeQr15F
	a0jVIHdWbo3CQ5dNEZwqOrTfgrosQ+un26x9ISeeF1T5a7MamllPcMfUtxYVmMybHIi5ZR
	PJZnSdwepzCtGTdGXTsd14hzy/jfvG/LqNc9PpxCjuorCZKZrVpDD5dI7c6Wjyo/W0Z/HN
	XX4F+yfbl4zVncOY7OMFcHY1gTgtsDd+g4iCXtTKLlIb1PP1FELLLnwMLh4MWQ==
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
Subject: [RFC PATCH v2 14/22] selinux: pre-validate conditional expressions
Date: Mon, 16 Dec 2024 17:40:12 +0100
Message-ID: <20241216164055.96267-14-cgoettsche@seltendoof.de>
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

Validate conditional expressions while reading the policy, to avoid
unexpected access decisions on malformed policies.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/conditional.c | 116 ++++++++++++++++++++----------
 security/selinux/ss/policydb.c    |   7 ++
 security/selinux/ss/policydb.h    |   1 +
 3 files changed, 88 insertions(+), 36 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index de29948efb48..481aa17a6f26 100644
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
index 2c2bd0df8645..3f85bb63cb5e 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -945,6 +945,13 @@ int policydb_type_isvalid(struct policydb *p, unsigned int type)
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
index 828fef98e340..615fdd5ef3c3 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -323,6 +323,7 @@ extern int policydb_context_isvalid(struct policydb *p, struct context *c);
 extern int policydb_class_isvalid(struct policydb *p, u16 class);
 extern int policydb_type_isvalid(struct policydb *p, unsigned int type);
 extern int policydb_role_isvalid(struct policydb *p, unsigned int role);
+extern int policydb_boolean_isvalid(const struct policydb *p, u32 boolean);
 extern int policydb_read(struct policydb *p, struct policy_file *fp);
 extern int policydb_write(struct policydb *p, struct policy_file *fp);
 
-- 
2.45.2

