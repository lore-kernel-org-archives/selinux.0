Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3C225D8E2;
	Sun, 11 May 2025 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746984697; cv=none; b=j1BjgaCrEw++LtdW8BZH3ANYSOONdc7tCAWYTQuHmQVS3CcpivAYJCd0/cZpQUh+wfm6O3mqiTlKraCFStrszlfq+Qr4TB8dtsUH+68GDdQkzIdaput9Cg5iLBocyqDa1sOyXhwo8cbGYFlS7L7SiPUxMGCGoCf8Kvn9LnfhPBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746984697; c=relaxed/simple;
	bh=WakVhkKrPRuUUxOftf9oDYJgXBJ3e0ssB8nKcY13AgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=faEv0iZUcHtAGyqRf0MkvNgvHB5D2PXvlYfPWLJhR9lbnJCl6yqxFRkGTw74OAmq2GpLHG/bMx1cokXKgdpun0D4APGRshXjN1mhdc8mlEG4Z/fdH5DEG3iUfNj5YBnYdUBdIEqc8PbMb6Gmy63+w/qhZI1/SvZ8vwRPU8sWagY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=mav9+9hE; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="mav9+9hE"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1746984693;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2YWgwY39KVYkdN/YlhV93nULKZmCDX463BUR7HZDFT8=;
	b=mav9+9hEBYcBHZCHoPjaKSRpfiepKVQFo1p9HmfxJr7ANfSeF9nMH7xld4Kf68HmvO5an8
	N4I83mdr9G/Wuu9WtKCHm8uZoGNoX89LQUlVgMhc4DLrHv5g/Tz9wmsPEiPFollnt+kFxb
	MRKjlKuhJyeU9DNyBm4JUHxYMjSrtS38AxCrSp0sxvUtgqUuiXdHXA9N+blCq4ZAH4Dw0a
	dfw4YhqzeXBx9EHJfTg/nuEXkz/AwbYRh5SlWdaMEqSWKS5GKw1iFh4UVXL53hBn0YJK+V
	XZrpZcjXtNyNgIjpX2ZRzxKGEMtdqUOhC6iXRuKqQ6iR8qiYZJCa5p4y5M6iXQ==
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
Subject: [PATCH v3 14/14] selinux: harden MLS context string generation against overflows
Date: Sun, 11 May 2025 19:30:14 +0200
Message-ID: <20250511173055.406906-14-cgoettsche@seltendoof.de>
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

Check the length accumulator for the MLS component of security contexts
does not overflow in mls_compute_context_len() resulting in
out-of-buffer writes in mls_sid_to_context().

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3: add patch
---
 security/selinux/ss/mls.c      | 18 +++++++++-----
 security/selinux/ss/services.c | 43 +++++++++++++++++++++++++++++-----
 2 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index 3cd36e2015fa..aa25724f0b0f 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -42,7 +42,8 @@ int mls_compute_context_len(struct policydb *p, struct context *context)
 	len = 1; /* for the beginning ":" */
 	for (l = 0; l < 2; l++) {
 		u32 index_sens = context->range.level[l].sens;
-		len += strlen(sym_name(p, SYM_LEVELS, index_sens - 1));
+		if (check_add_overflow(len, strlen(sym_name(p, SYM_LEVELS, index_sens - 1)), &len))
+			return -EOVERFLOW;
 
 		/* categories */
 		head = -2;
@@ -54,24 +55,29 @@ int mls_compute_context_len(struct policydb *p, struct context *context)
 				/* one or more negative bits are skipped */
 				if (head != prev) {
 					nm = sym_name(p, SYM_CATS, prev);
-					len += strlen(nm) + 1;
+					if (check_add_overflow(len, strlen(nm) + 1, &len))
+						return -EOVERFLOW;
 				}
 				nm = sym_name(p, SYM_CATS, i);
-				len += strlen(nm) + 1;
+				if (check_add_overflow(len, strlen(nm) + 1, &len))
+					return -EOVERFLOW;
 				head = i;
 			}
 			prev = i;
 		}
 		if (prev != head) {
 			nm = sym_name(p, SYM_CATS, prev);
-			len += strlen(nm) + 1;
+			if (check_add_overflow(len, strlen(nm) + 1, &len))
+				return -EOVERFLOW;
 		}
 		if (l == 0) {
 			if (mls_level_eq(&context->range.level[0],
 					 &context->range.level[1]))
 				break;
-			else
-				len++;
+			else {
+				if (check_add_overflow(len, 1, &len))
+					return -EOVERFLOW;
+			}
 		}
 	}
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 464a4663c993..dc6dce2eb7d2 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1247,10 +1247,12 @@ static int context_struct_to_string(struct policydb *p,
 				    char **scontext, u32 *scontext_len)
 {
 	char *scontextp;
+	size_t len;
+	int mls_len;
 
 	if (scontext)
 		*scontext = NULL;
-	*scontext_len = 0;
+	len = 0;
 
 	if (context->len) {
 		*scontext_len = context->len;
@@ -1263,16 +1265,45 @@ static int context_struct_to_string(struct policydb *p,
 	}
 
 	/* Compute the size of the context. */
-	*scontext_len += strlen(sym_name(p, SYM_USERS, context->user - 1)) + 1;
-	*scontext_len += strlen(sym_name(p, SYM_ROLES, context->role - 1)) + 1;
-	*scontext_len += strlen(sym_name(p, SYM_TYPES, context->type - 1)) + 1;
-	*scontext_len += mls_compute_context_len(p, context);
+	len += strlen(sym_name(p, SYM_USERS, context->user - 1)) + 1;
+	len += strlen(sym_name(p, SYM_ROLES, context->role - 1)) + 1;
+	len += strlen(sym_name(p, SYM_TYPES, context->type - 1)) + 1;
+
+	mls_len = mls_compute_context_len(p, context);
+	if (unlikely(mls_len < 0)) {
+		pr_warn_ratelimited("SELinux: %s:  MLS security context component too large [%s:%s:%s[:[%s:%d]-[%s:%d]]]\n",
+				    __func__,
+				    sym_name(p, SYM_USERS, context->user - 1),
+				    sym_name(p, SYM_ROLES, context->role - 1),
+				    sym_name(p, SYM_TYPES, context->type - 1),
+				    sym_name(p, SYM_LEVELS, context->range.level[0].sens - 1),
+				    ebitmap_length(&context->range.level[0].cat),
+				    sym_name(p, SYM_LEVELS, context->range.level[1].sens - 1),
+				    ebitmap_length(&context->range.level[1].cat));
+		return -EOVERFLOW;
+	}
+
+	if (unlikely(check_add_overflow(len, mls_len, &len) || len > CONTEXT_MAXLENGTH)) {
+		pr_warn_ratelimited("SELinux: %s:  security context string of length %zu too large [%s:%s:%s[:[%s:%d]-[%s:%d]]]\n",
+				    __func__,
+				    len,
+				    sym_name(p, SYM_USERS, context->user - 1),
+				    sym_name(p, SYM_ROLES, context->role - 1),
+				    sym_name(p, SYM_TYPES, context->type - 1),
+				    sym_name(p, SYM_LEVELS, context->range.level[0].sens - 1),
+				    ebitmap_length(&context->range.level[0].cat),
+				    sym_name(p, SYM_LEVELS, context->range.level[1].sens - 1),
+				    ebitmap_length(&context->range.level[1].cat));
+		return -EOVERFLOW;
+	}
+
+	*scontext_len = len;
 
 	if (!scontext)
 		return 0;
 
 	/* Allocate space for the context; caller must free this space. */
-	scontextp = kmalloc(*scontext_len, GFP_ATOMIC);
+	scontextp = kmalloc(len, GFP_ATOMIC);
 	if (!scontextp)
 		return -ENOMEM;
 	*scontext = scontextp;
-- 
2.49.0

