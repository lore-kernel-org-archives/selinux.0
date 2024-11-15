Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEAB1CDA09;
	Fri, 15 Nov 2024 13:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677833; cv=none; b=rhhOSQIP4g05A+bLY+glez0uHjsA/DU9obgFIRe+cN17TYZtLaPDpXNGpKyjB1K2BDVWOw5tnzzfkfb7q0piXzhaftsmipKu59Zt5Ye2qgFPQb70MmhHGg0JO2AFdWA9RkGcno22cbfZL1+PFEC0Tkaf6Le7lrxaD1ywKR5OoMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677833; c=relaxed/simple;
	bh=wbZeP+FqrGHfxL8k2FfPz/C2u93Wbv/O5/Sm2nOrQSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRadhXt1qrlC9v5eVw+FlOKhxTAR6Gft7TnkIxE2cXYsNhnOJUVzjZyYQUaaUUKRnup6+Ylp24TArkCjBMDMm/bsCAlocO0nAOBcK1Lb74h7yWROUw9IsY57NM5x8IfKevEj0LOzhfi0ZKPOsmYquY7n+Kq/AXdGYFyY9Vi63mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=CS9awf2R; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="CS9awf2R"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731677829;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NNe8CasdOqHvzGa8GCttK8HX6bCvp4pEw3d94J1Ra9E=;
	b=CS9awf2RoaagJnJBZq/a9g7JaemxTgRXpvsJdf9eu9TFwtvifeg6/SK8yRJRNozbQNPAau
	ASo2kG0r0vH5k6aJDflys5AbFl5y1RuidGJu3Y1FH5G1zUp2gpJiL72kLnqJqKE2SD2t4R
	SVPjamMfvn6VGO6TILl4SVTVYC6VHS42FmbIk9OJ6FTS4Bpzqr+/F9aWuPwqFtDLXyUW+g
	W83Y2i53YwllTiGypLzgZ5EganlQTsrc2DAyNfFB/Qnu9Mdeyj4BmjZhL9GVKDfjUOKsLT
	lAATwLpwM9XGBo66a2BuZ+e+yjADXE2pkZf3aJvvCgxvaszxdt1J//V6yzycCA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Canfeng Guo <guocanfeng@uniontech.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	GUO Zihua <guozihua@huawei.com>,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 13/22] selinux: validate constraints
Date: Fri, 15 Nov 2024 14:35:32 +0100
Message-ID: <20241115133619.114393-13-cgoettsche@seltendoof.de>
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

Validate constraint expressions during reading the policy.
Avoid the usage of BUG() on constraint evaluation, to mitigate malformed
policies halting the system.

Closes: https://github.com/SELinuxProject/selinux-testsuite/issues/76

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/policydb.c | 61 ++++++++++++++++++++++++++++++++--
 security/selinux/ss/services.c | 55 +++++++++++++++---------------
 2 files changed, 88 insertions(+), 28 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 5ba1e8d483fb..5d99e1498b55 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1251,6 +1251,8 @@ static int read_cons_helper(struct policydb *p, struct constraint_node **nodep,
 			return rc;
 		c->permissions = le32_to_cpu(buf[0]);
 		nexpr = le32_to_cpu(buf[1]);
+		if (nexpr == 0)
+			return -EINVAL;
 		le = NULL;
 		depth = -1;
 		for (j = 0; j < nexpr; j++) {
@@ -1282,15 +1284,70 @@ static int read_cons_helper(struct policydb *p, struct constraint_node **nodep,
 				depth--;
 				break;
 			case CEXPR_ATTR:
-				if (depth == (CEXPR_MAXDEPTH - 1))
+				if (depth >= (CEXPR_MAXDEPTH - 1))
 					return -EINVAL;
 				depth++;
 				break;
+
+				switch (e->op) {
+				case CEXPR_EQ:
+				case CEXPR_NEQ:
+					break;
+				case CEXPR_DOM:
+				case CEXPR_DOMBY:
+				case CEXPR_INCOMP:
+					if ((e->attr & CEXPR_USER) || (e->attr & CEXPR_TYPE))
+						return -EINVAL;
+					break;
+				default:
+					return -EINVAL;
+				}
+
+				switch (e->attr) {
+				case CEXPR_USER:
+				case CEXPR_ROLE:
+				case CEXPR_TYPE:
+				case CEXPR_L1L2:
+				case CEXPR_L1H2:
+				case CEXPR_H1L2:
+				case CEXPR_H1H2:
+				case CEXPR_L1H1:
+				case CEXPR_L2H2:
+					break;
+				default:
+					return -EINVAL;
+				}
+
+				break;
 			case CEXPR_NAMES:
 				if (!allowxtarget && (e->attr & CEXPR_XTARGET))
 					return -EINVAL;
-				if (depth == (CEXPR_MAXDEPTH - 1))
+				if (depth >= (CEXPR_MAXDEPTH - 1))
+					return -EINVAL;
+
+				switch (e->op) {
+				case CEXPR_EQ:
+				case CEXPR_NEQ:
+					break;
+				default:
+					return -EINVAL;
+				}
+
+				switch (e->attr) {
+				case CEXPR_USER:
+				case CEXPR_USER | CEXPR_TARGET:
+				case CEXPR_USER | CEXPR_XTARGET:
+				case CEXPR_ROLE:
+				case CEXPR_ROLE | CEXPR_TARGET:
+				case CEXPR_ROLE | CEXPR_XTARGET:
+				case CEXPR_TYPE:
+				case CEXPR_TYPE | CEXPR_TARGET:
+				case CEXPR_TYPE | CEXPR_XTARGET:
+					break;
+				default:
 					return -EINVAL;
+				}
+
 				depth++;
 				rc = ebitmap_read(&e->names, fp);
 				if (rc)
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index d8b5fb98adb9..b1b90f802328 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -278,22 +278,25 @@ static int constraint_expr_eval(struct policydb *policydb,
 	for (e = cexpr; e; e = e->next) {
 		switch (e->expr_type) {
 		case CEXPR_NOT:
-			BUG_ON(sp < 0);
+			if (unlikely(sp < 0))
+				goto invalid;
 			s[sp] = !s[sp];
 			break;
 		case CEXPR_AND:
-			BUG_ON(sp < 1);
+			if (unlikely(sp < 1))
+				goto invalid;
 			sp--;
 			s[sp] &= s[sp + 1];
 			break;
 		case CEXPR_OR:
-			BUG_ON(sp < 1);
+			if (unlikely(sp < 1))
+				goto invalid;
 			sp--;
 			s[sp] |= s[sp + 1];
 			break;
 		case CEXPR_ATTR:
-			if (sp == (CEXPR_MAXDEPTH - 1))
-				return 0;
+			if (unlikely(sp >= (CEXPR_MAXDEPTH - 1)))
+				goto invalid;
 			switch (e->attr) {
 			case CEXPR_USER:
 				val1 = scontext->user;
@@ -369,13 +372,11 @@ static int constraint_expr_eval(struct policydb *policydb,
 					s[++sp] = mls_level_incomp(l2, l1);
 					continue;
 				default:
-					BUG();
-					return 0;
+					goto invalid;
 				}
 				break;
 			default:
-				BUG();
-				return 0;
+				goto invalid;
 			}
 
 			switch (e->op) {
@@ -386,22 +387,19 @@ static int constraint_expr_eval(struct policydb *policydb,
 				s[++sp] = (val1 != val2);
 				break;
 			default:
-				BUG();
-				return 0;
+				goto invalid;
 			}
 			break;
 		case CEXPR_NAMES:
-			if (sp == (CEXPR_MAXDEPTH-1))
-				return 0;
+			if (unlikely(sp >= (CEXPR_MAXDEPTH-1)))
+				goto invalid;
 			c = scontext;
 			if (e->attr & CEXPR_TARGET)
 				c = tcontext;
 			else if (e->attr & CEXPR_XTARGET) {
 				c = xcontext;
-				if (!c) {
-					BUG();
-					return 0;
-				}
+				if (unlikely(!c))
+					goto invalid;
 			}
 			if (e->attr & CEXPR_USER)
 				val1 = c->user;
@@ -409,10 +407,8 @@ static int constraint_expr_eval(struct policydb *policydb,
 				val1 = c->role;
 			else if (e->attr & CEXPR_TYPE)
 				val1 = c->type;
-			else {
-				BUG();
-				return 0;
-			}
+			else
+				goto invalid;
 
 			switch (e->op) {
 			case CEXPR_EQ:
@@ -422,18 +418,25 @@ static int constraint_expr_eval(struct policydb *policydb,
 				s[++sp] = !ebitmap_get_bit(&e->names, val1 - 1);
 				break;
 			default:
-				BUG();
-				return 0;
+				goto invalid;
 			}
 			break;
 		default:
-			BUG();
-			return 0;
+			goto invalid;
 		}
 	}
 
-	BUG_ON(sp != 0);
+	if (unlikely(sp != 0))
+		goto invalid;
+
 	return s[0];
+
+invalid:
+	/* Should *never* be reached, cause malformed constraints should
+	 * have been filtered by read_cons_helper().
+	 */
+	WARN_ONCE(true, "SELinux: invalid constraint passed validation\n");
+	return 0;
 }
 
 /*
-- 
2.45.2

