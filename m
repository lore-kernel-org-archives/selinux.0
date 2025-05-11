Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791551F92E;
	Sun, 11 May 2025 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746984680; cv=none; b=iaTL51G97Hzmw4+LjsX0mqaCvv00uA1qvlLNv03Swn/16pt39vPLywyfO5ztAC4hp+j6XAzuPfUESJ6m63p7/1hTRP+3y8D9wmfMrLmnAG3ZGM2IuTybbk8rtVVzNg6oW0LJ6oqgN8i8tXZI59TVHGrC6Sk6i9iV7qw4kKeXkZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746984680; c=relaxed/simple;
	bh=tQQRR++DRNViOHhKPSka+P4DZxjKNs4M4WvWfpHAQ1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=izZ4u44kEuT8Vi5FUsi7jOQh4suIUpK+wHWVsbIRcoos/wEFBgvjQELvM8TVWmg0eqgBWH2hj4r0+ruA4P7gNoP7Ml31ii1ii56XPS4Tj9OZ0+3tufesuDdMGFkRU5unafNzFgx9h6hzk7E60tLa8t1zdapw6z6RBA5uhBg1J+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=gb/ZUPgX; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="gb/ZUPgX"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1746984674;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TLxx6WH3AKhIhiASLi1kTrHDQWS9jSBl/az8E9VZFh8=;
	b=gb/ZUPgX5EHLcjfqNzvi69TcCoIXb9yblwYu+VJ2rBOZBBtXmxxkGUYNpNSV+REDb56ou+
	fE4h34QOUXRHVuf1KTJjcfhSZmrAqZ/bntn/Dr/jvYFYD/e9cku3fqHhaAJ5tdcDBLKOOF
	WxwjkVhQFQuTJhhL+8Fe2nwR0vZSR4DuLaJNw61eBrrK/wdWq6owbIavPK3NFRTgm+K+EJ
	Xtm0dcUMLzG0MU2OypOnIFdgsFrEcAOUQTLLYJ00KNo4rp7A27yQBSj6MIZnCFIUiAFh4T
	cZI5TNGWVMDUYqw0fEbjvd345PQ1MpXi2GHkQ/9Ut4711VuG6vTHxZ2XEeVfdg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Canfeng Guo <guocanfeng@uniontech.com>,
	Takaya Saeki <takayas@chromium.org>
Subject: [PATCH v3 05/14] selinux: validate constraints
Date: Sun, 11 May 2025 19:30:05 +0200
Message-ID: <20250511173055.406906-5-cgoettsche@seltendoof.de>
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
index 46c010afd44f..a8397ed66109 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1257,6 +1257,8 @@ static int read_cons_helper(struct policydb *p, struct constraint_node **nodep,
 			return rc;
 		c->permissions = le32_to_cpu(buf[0]);
 		nexpr = le32_to_cpu(buf[1]);
+		if (nexpr == 0)
+			return -EINVAL;
 		le = NULL;
 		depth = -1;
 		for (j = 0; j < nexpr; j++) {
@@ -1288,15 +1290,70 @@ static int read_cons_helper(struct policydb *p, struct constraint_node **nodep,
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
index 0f67a030b49b..3fb971fe4fd9 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -279,22 +279,25 @@ static int constraint_expr_eval(struct policydb *policydb,
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
@@ -370,13 +373,11 @@ static int constraint_expr_eval(struct policydb *policydb,
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
@@ -387,22 +388,19 @@ static int constraint_expr_eval(struct policydb *policydb,
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
@@ -410,10 +408,8 @@ static int constraint_expr_eval(struct policydb *policydb,
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
@@ -423,18 +419,25 @@ static int constraint_expr_eval(struct policydb *policydb,
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
2.49.0

