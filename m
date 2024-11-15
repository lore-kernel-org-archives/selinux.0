Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20591D0E39;
	Fri, 15 Nov 2024 13:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677832; cv=none; b=utxOZC3/r2qpok1WshtYdwQqlos55CuJLDN/nSTJV8i548MmeMTDzjCxZCGIATB9y4BrODsXmGyNiFOcuaMyDDvttctU87nv5Lle7qOZL7CBpBSeIG3gAmwOc70Nhodfcr1p8nlOywfYoJgxnwxvmiy2OFDUSGq60GI8TlFTy08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677832; c=relaxed/simple;
	bh=qcfBvmfGWkIlrewQXYb1TAGPO1hvX71hpCIs/My5hhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FNPJ2eVaTBsaSHJWbuZsr7bzCtjIF0VJUX8vfax9HLMl5Bk08g3UrZuvBCsd5vBkV27n1r8vEcGBtPuS2rC6LTrk0FFHYVfrwHWjKjQXXqnRn/WVaz3A9lmk8qm2g9P+QC9x3Dsl9xIjd5woSvZP3h+cQUHYkNpfXqWCcVtzgoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=TopbRp8q; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="TopbRp8q"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731677828;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5GOfwNjweZQXFgxAZppiPVUYGdPQwCTMdHpI9UPXEbM=;
	b=TopbRp8qBbqX/8NRLk5Q6/q6PpSCzLH1MSsU0byiATXDMLFZnPASPyT5G1qy9gaRkTaUSw
	WgO2kD1PkkADKJFAqm5Sp4Lp8jD28iJPiJu3ppFaTP60y933npwrEY5xuDeIAVOLwo9Wr6
	ZMb0ZFeMtsOypv4s7RzzWyYlsXX080AhzV+APybJhUa/pNIV2ydihakwgR4MkgJguHb8BL
	LELXHw+PUF/TX/gAh/WcD/reOHrYHfnAjKHBOT4eGnKX5Y9NW5wn8GN2LqqO+V/quD5mp7
	qdnjc4dmxdniSDPolPCiYbgjD8D09iuY3Cl0LD03/aKPdDAd2Iph52aHkyhLJw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Eric Suen <ericsu@linux.microsoft.com>,
	Jacob Satterfield <jsatterfield.linux@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 12/22] selinux: check length fields in policies
Date: Fri, 15 Nov 2024 14:35:31 +0100
Message-ID: <20241115133619.114393-12-cgoettsche@seltendoof.de>
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
index 6122c1c7e951..002853dd3443 100644
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
index f85d22952d5a..07008ea081ba 100644
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
index 1157e66b4664..5ba1e8d483fb 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1095,6 +1095,9 @@ int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
 	if ((len == 0) || (len == (u32)-1))
 		return -EINVAL;
 
+	if (oom_check(sizeof(char), len, fp))
+		return -EINVAL;
+
 	str = kmalloc(len + 1, flags | __GFP_NOWARN);
 	if (!str)
 		return -ENOMEM;
@@ -1169,6 +1172,10 @@ static int common_read(struct policydb *p, struct symtab *s, struct policy_file
 	if (nel > 32)
 		goto bad;
 
+	rc = oom_check(/*guaranteed read by perm_read()*/2 * sizeof(u32), nel, fp);
+	if (rc)
+		goto bad;
+
 	rc = symtab_init(&comdatum->permissions, nel);
 	if (rc)
 		goto bad;
@@ -1343,6 +1350,10 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 		goto bad;
 	cladatum->value = val;
 
+	rc = oom_check(/*guaranteed read by perm_read()*/2 * sizeof(u32), nel, fp);
+	if (rc)
+		goto bad;
+
 	rc = symtab_init(&cladatum->permissions, nel);
 	if (rc)
 		goto bad;
@@ -1916,6 +1927,10 @@ static int range_read(struct policydb *p, struct policy_file *fp)
 
 	nel = le32_to_cpu(buf[0]);
 
+	rc = oom_check(sizeof(u32) * 2, nel, fp);
+	if (rc)
+		return rc;
+
 	rc = hashtab_init(&p->range_tr, nel);
 	if (rc)
 		return rc;
@@ -2684,6 +2699,10 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
 		nprim = le32_to_cpu(buf[0]);
 		nel = le32_to_cpu(buf[1]);
 
+		rc = oom_check(/*guaranteed read by read_f()*/ 4 * sizeof(u32), nel, fp);
+		if (rc)
+			goto out;
+
 		rc = symtab_init(&p->symtab[i], nel);
 		if (rc)
 			goto out;
@@ -2725,6 +2744,10 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
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
index 4d278583c172..fee9132b0d42 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -353,6 +353,19 @@ struct policy_data {
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

