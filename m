Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEF4207A03;
	Mon, 16 Dec 2024 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367311; cv=none; b=Pf8ChJshyW4gIzOgbw8o5Tca7FZnSIN7oKqTihWiUbkK6raSTvLi8SfdvtBN16XL5vYO+wS7isGMeJLXO6MoM+D1G1aDMFRpB1pDj2PjlmvAaV+ezjpdwpx4KZ/KsWatKu1RpLAbXUyAozDZZ9eXUnItJ1+rt0SYGgtptkQ0RjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367311; c=relaxed/simple;
	bh=70PginsuKGSL/FdXFPSIGNYWplHsBHMwy1DanRhcU9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lkdd11QLb9lSDNt68pOlo8M7Qec8Cb2mknITJynx5FhVzDmVWZs1FYafOM7y30NAGtQDQ9rNmPWKNRPrHQEv5fnkJGLT3kwubRKSPKhxdkFKtX/vwuCBhk4jp+26Y3VT25ekutS/ZkFLKkhNLtFdm3qYPmcGN1WeEu6iigzL5pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=WCPayytc; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="WCPayytc"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1734367307;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LIJ0T2PhCkYGtHg73O5scBTrgxXRKBX1unmPsuL58fQ=;
	b=WCPayytcTCWJUBeIiY4eOLorGpKWCgSA0NGbbEKe1p1WoaKJyU2KIMCIo+mK8ujpaARPMN
	f72nmDBgzrSQFVDA/L2WRTw29TMfdS560xf3caUbH2YnhoqqXA0n3qEO2TO1SKuJ7xsSfm
	DU80Bmi9O5hcFsdilO8FWKB2aq7XjA59MtzzPD0Y7sI+ZAFVlOJu7F2OOG1HtFqjn9TJCq
	Hx3V5KX08+HsXmxSYOCPu+PMqXNABYq+9QlHOVxWSD/MYGaNKcBdT1/SI9xJ0Z+BqgvSXq
	8MU2wDSZZvORoHSF4W7F1SPssilgyHi/EF9QLnmq3UXEs9qFAQWR+GjcdUW5bg==
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
Subject: [RFC PATCH v2 12/22] selinux: check length fields in policies
Date: Mon, 16 Dec 2024 17:40:10 +0100
Message-ID: <20241216164055.96267-12-cgoettsche@seltendoof.de>
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

In multiple places the binary policy announces how many items of some
kind are to be expected next.  Before reading them the kernel already
allocates enough memory for that announced size.  Validate that the
remaining input size can actually fit the announced items, to avoid OOM
issues on malformed binary policies.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/avtab.c       |  4 ++++
 security/selinux/ss/conditional.c | 14 ++++++++++++++
 security/selinux/ss/policydb.c    | 23 +++++++++++++++++++++++
 security/selinux/ss/policydb.h    | 13 +++++++++++++
 4 files changed, 54 insertions(+)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 3bd949a200ef..a7bf0ceb45d4 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -550,6 +550,10 @@ int avtab_read(struct avtab *a, struct policy_file *fp, struct policydb *pol)
 		goto bad;
 	}
 
+	rc = oom_check(2 * sizeof(u32), nel, fp);
+	if (rc)
+		goto bad;
+
 	rc = avtab_alloc(a, nel);
 	if (rc)
 		goto bad;
diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 35442f4ceedf..de29948efb48 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -12,6 +12,7 @@
 
 #include "security.h"
 #include "conditional.h"
+#include "policydb.h"
 #include "services.h"
 
 /*
@@ -329,6 +330,10 @@ static int cond_read_av_list(struct policydb *p, struct policy_file *fp,
 	if (len == 0)
 		return 0;
 
+	rc = oom_check(2 * sizeof(u32), len, fp);
+	if (rc)
+		return rc;
+
 	list->nodes = kcalloc(len, sizeof(*list->nodes), GFP_KERNEL);
 	if (!list->nodes)
 		return -ENOMEM;
@@ -379,6 +384,11 @@ static int cond_read_node(struct policydb *p, struct cond_node *node, struct pol
 
 	/* expr */
 	len = le32_to_cpu(buf[1]);
+
+	rc = oom_check(2 * sizeof(u32), len, fp);
+	if (rc)
+		return rc;
+
 	node->expr.nodes = kcalloc(len, sizeof(*node->expr.nodes), GFP_KERNEL);
 	if (!node->expr.nodes)
 		return -ENOMEM;
@@ -417,6 +427,10 @@ int cond_read_list(struct policydb *p, struct policy_file *fp)
 
 	len = le32_to_cpu(buf[0]);
 
+	rc = oom_check(2 * sizeof(u32), len, fp);
+	if (rc)
+		goto err;
+
 	p->cond_list = kcalloc(len, sizeof(*p->cond_list), GFP_KERNEL);
 	if (!p->cond_list)
 		return -ENOMEM;
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 1275fd7d9148..4bc1e225f2fe 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1100,6 +1100,9 @@ int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
 	if ((len == 0) || (len == (u32)-1))
 		return -EINVAL;
 
+	if (oom_check(sizeof(char), len, fp))
+		return -EINVAL;
+
 	str = kmalloc(len + 1, flags | __GFP_NOWARN);
 	if (!str)
 		return -ENOMEM;
@@ -1174,6 +1177,10 @@ static int common_read(struct policydb *p, struct symtab *s, struct policy_file
 	if (nel > 32)
 		goto bad;
 
+	rc = oom_check(/*guaranteed read by perm_read()*/2 * sizeof(u32), nel, fp);
+	if (rc)
+		goto bad;
+
 	rc = symtab_init(&comdatum->permissions, nel);
 	if (rc)
 		goto bad;
@@ -1348,6 +1355,10 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 		goto bad;
 	cladatum->value = val;
 
+	rc = oom_check(/*guaranteed read by perm_read()*/2 * sizeof(u32), nel, fp);
+	if (rc)
+		goto bad;
+
 	rc = symtab_init(&cladatum->permissions, nel);
 	if (rc)
 		goto bad;
@@ -1921,6 +1932,10 @@ static int range_read(struct policydb *p, struct policy_file *fp)
 
 	nel = le32_to_cpu(buf[0]);
 
+	rc = oom_check(sizeof(u32) * 2, nel, fp);
+	if (rc)
+		return rc;
+
 	rc = hashtab_init(&p->range_tr, nel);
 	if (rc)
 		return rc;
@@ -2689,6 +2704,10 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
 		nprim = le32_to_cpu(buf[0]);
 		nel = le32_to_cpu(buf[1]);
 
+		rc = oom_check(/*guaranteed read by read_f()*/ 4 * sizeof(u32), nel, fp);
+		if (rc)
+			goto out;
+
 		rc = symtab_init(&p->symtab[i], nel);
 		if (rc)
 			goto out;
@@ -2730,6 +2749,10 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
 		goto bad;
 	nel = le32_to_cpu(buf[0]);
 
+	rc = oom_check(3 * sizeof(u32), nel, fp);
+	if (rc)
+		goto bad;
+
 	rc = hashtab_init(&p->role_tr, nel);
 	if (rc)
 		goto bad;
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 690dc4a00cf3..828fef98e340 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -352,6 +352,19 @@ struct policy_data {
 	struct policy_file *fp;
 };
 
+static inline int oom_check(size_t bytes, size_t num, const struct policy_file *fp)
+{
+	size_t len;
+
+	if (unlikely(check_mul_overflow(bytes, num, &len)))
+		return -EINVAL;
+
+	if (unlikely(len > fp->len))
+		return -EINVAL;
+
+	return 0;
+}
+
 static inline int next_entry(void *buf, struct policy_file *fp, size_t bytes)
 {
 	if (bytes > fp->len)
-- 
2.45.2

