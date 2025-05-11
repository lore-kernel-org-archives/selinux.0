Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B13C5228;
	Sun, 11 May 2025 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746984683; cv=none; b=RHWV6Biyn3t7kwDxypRMyPuISz08L7NRraCgUM3l+3OtHAquL/Djf/6ik5d5uav5Wdf/03njBIZfFqjAmwzBielcG2sg6mPIthUyWslUKsG0xqT7irxJY8bvQSRO1tX6MNFYsDTrFML4uiU7/hZkuB1jdMX2xY5s93s1NokXfoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746984683; c=relaxed/simple;
	bh=UKposrAMTtE4XjyRApAZU09nVS28nI47H/19r21DUsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRkTflOoEB30zeeB9g21qfHn+j4nIT0+E6tqmKHBbeq355pZCxDG5VQqZfvR282xcCR8/ggWKjoElSz17wtxDxl0g4AZuhelWerMIviuhObQ1WO85CZOfzDEqV1JV9DAC9wda0U8i0fXHWHNa8VQ64iNZ+4WOAuvxqpuvF6m4rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=sNqg7DNU; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="sNqg7DNU"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1746984675;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vvTCsTEaBYzh3xU+kigiGqBGJYcLUwrNT5k++D1PaYc=;
	b=sNqg7DNUOJVxOFrJB0huBE03tLXP/JMK2YxbDJcwUVhelPaPg4cHcIoP6iw0uOClmqHdEM
	fwv+jM/MWx3j67MljXuSSqXEK8LuPpR5mc8ANEtS6C0i2JbhztL5zXr8CE59G9NkwSzwEf
	mYgR6knw9ku7YAmWlwqo5n7XuHINiQhVsyR9p2zOTKJkDdvOSpCOU5URMrbyYZuI9+QsM2
	7RUEnk00SV/907U814sUWPppiemp/Bl1RzRx+InAl5egxEwN1sI1pGQ0ROs6ff2E3HVNgh
	tO4cCg9wIXtieryP7XWEqlIjuZk+CNzfmZRXI8qjeKsbqsvb5C3ofPp+/SOQaQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/14] selinux: pre-validate conditional expressions
Date: Sun, 11 May 2025 19:30:06 +0200
Message-ID: <20250511173055.406906-6-cgoettsche@seltendoof.de>
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

Validate conditional expressions while reading the policy, to avoid
unexpected access decisions on malformed policies.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/conditional.c | 116 ++++++++++++++++++++----------
 security/selinux/ss/policydb.c    |   7 ++
 security/selinux/ss/policydb.h    |   1 +
 3 files changed, 88 insertions(+), 36 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 92ed4f23a217..ce0281cce739 100644
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
@@ -356,21 +410,6 @@ static int cond_read_av_list(struct policydb *p, struct policy_file *fp,
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
@@ -385,6 +424,8 @@ static int cond_read_node(struct policydb *p, struct cond_node *node, struct pol
 
 	/* expr */
 	len = le32_to_cpu(buf[1]);
+	if (len == 0)
+		return -EINVAL;
 
 	/* we will read 64 bytes per node */
 	rc = size_check(2 * sizeof(u32), len, fp);
@@ -406,9 +447,12 @@ static int cond_read_node(struct policydb *p, struct cond_node *node, struct pol
 
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
index a8397ed66109..8969f7c8637c 100644
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
index bb96a6cb6101..42117adb2ca0 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -324,6 +324,7 @@ extern int policydb_context_isvalid(struct policydb *p, struct context *c);
 extern int policydb_class_isvalid(struct policydb *p, u16 class);
 extern int policydb_type_isvalid(struct policydb *p, unsigned int type);
 extern int policydb_role_isvalid(struct policydb *p, unsigned int role);
+extern int policydb_boolean_isvalid(const struct policydb *p, u32 boolean);
 extern int policydb_read(struct policydb *p, struct policy_file *fp);
 extern int policydb_write(struct policydb *p, struct policy_file *fp);
 
-- 
2.49.0

