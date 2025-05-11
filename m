Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA91F1FC3;
	Sun, 11 May 2025 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746984679; cv=none; b=gReYyhpggf1BIt8ziovOtOY6hitAIjHtoxFDJbuqPKB6eyQZDF50oZmP2FfUPXxMcjO4pA+eSK/UT+xiBK/lGJMoCQaY9HwYEvVd170YiVFhrb4AdlLYElhyuH71+lpESOA7FT9RjV2UPPgydwBCgteIuy7enZUsC1PLfXyYXEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746984679; c=relaxed/simple;
	bh=Ebko4lUn1X4XnO2jLm4yUAUj0afvAzRfzlTsrGcxWSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jTxC5yzPtUU1HP8jKY/1AcM0uer+A1Kc3fHZuv4uNgWkON8vw03JdeGbeUayqCMOZOb2dohksOxgYgWAoP8lTz62nik3Ne+qGLAAJ64b4SlaDhDiRbNWP+cXcxXOon1hE8owtAJpX+JC9IcI9mAr/xY+N5Ziq/l58qioNeFqvwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=CNko3Qyv; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="CNko3Qyv"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1746984672;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GsBcaq3JdFc1mzUcdZeS0p8QtzqKL0+oK7CcRUdGdns=;
	b=CNko3Qyv8X1aGrwz2L5Qc851kouLo6IwMDn9dWy+kWQOuu2Srg61z1ayDAEf7hJOXKd3vZ
	cKCxzLXleBhmnoWobNNM1EsEebFRYI6VMiSLTG7tJ+VzOk2zg4WZTn/j3Eu8Kq9GW8o92x
	lQ3k5jXIeqbPh1S65/XZdg/dDpF3+KHYSoXU1xbW7q1l7uSecafy4b+ViGJzatnByI2zZX
	1BkZFDXcofpV77AXCTOPSKjZm5DiIGWIP/3Z2iDtgv/Ht0P22rlHoPfw+xGIdWfGQS+a1E
	VJjMaxCv6CVtox/EzDrGepMslKEmnY+SQrKYvrSQwH/xRDPiZiNsvOGok+Fdjg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-kernel@vger.kernel.org,
	Eric Suen <ericsu@linux.microsoft.com>
Subject: [PATCH v3 04/14] selinux: check length fields in policies
Date: Sun, 11 May 2025 19:30:04 +0200
Message-ID: <20250511173055.406906-4-cgoettsche@seltendoof.de>
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

In multiple places the binary policy announces how many items of some
kind are to be expected next.  Before reading them the kernel already
allocates enough memory for that announced size.  Validate that the
remaining input size can actually fit the announced items, to avoid OOM
issues on malformed binary policies.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3:
  - fix error branch by returning directly instead of jumping to goto
    label, see
      https://lore.kernel.org/all/202412241405.LK8YTZqp-lkp@intel.com/
  - rename to size_check()
  - add comments for magic values
---
 security/selinux/ss/avtab.c       |  5 +++++
 security/selinux/ss/conditional.c | 17 ++++++++++++++++
 security/selinux/ss/policydb.c    | 32 +++++++++++++++++++++++++++++++
 security/selinux/ss/policydb.h    | 13 +++++++++++++
 4 files changed, 67 insertions(+)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 33556922f15e..50df8b69de2b 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -548,6 +548,11 @@ int avtab_read(struct avtab *a, struct policy_file *fp, struct policydb *pol)
 		goto bad;
 	}
 
+	/* avtab_read_item() reads at least 96 bytes for any valid entry */
+	rc = size_check(3 * sizeof(u32), nel, fp);
+	if (rc)
+		goto bad;
+
 	rc = avtab_alloc(a, nel);
 	if (rc)
 		goto bad;
diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index db30462ed6a3..92ed4f23a217 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -12,6 +12,7 @@
 
 #include "security.h"
 #include "conditional.h"
+#include "policydb.h"
 #include "services.h"
 
 /*
@@ -329,6 +330,11 @@ static int cond_read_av_list(struct policydb *p, struct policy_file *fp,
 	if (len == 0)
 		return 0;
 
+	/* avtab_read_item() reads at least 96 bytes for any valid entry */
+	rc = size_check(3 * sizeof(u32), len, fp);
+	if (rc)
+		return rc;
+
 	list->nodes = kcalloc(len, sizeof(*list->nodes), GFP_KERNEL);
 	if (!list->nodes)
 		return -ENOMEM;
@@ -379,6 +385,12 @@ static int cond_read_node(struct policydb *p, struct cond_node *node, struct pol
 
 	/* expr */
 	len = le32_to_cpu(buf[1]);
+
+	/* we will read 64 bytes per node */
+	rc = size_check(2 * sizeof(u32), len, fp);
+	if (rc)
+		return rc;
+
 	node->expr.nodes = kcalloc(len, sizeof(*node->expr.nodes), GFP_KERNEL);
 	if (!node->expr.nodes)
 		return -ENOMEM;
@@ -417,6 +429,11 @@ int cond_read_list(struct policydb *p, struct policy_file *fp)
 
 	len = le32_to_cpu(buf[0]);
 
+	/* cond_read_node() reads at least 128 bytes for any valid node */
+	rc = size_check(4 * sizeof(u32), len, fp);
+	if (rc)
+		return rc;
+
 	p->cond_list = kcalloc(len, sizeof(*p->cond_list), GFP_KERNEL);
 	if (!p->cond_list)
 		return -ENOMEM;
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 3e4a28a2928b..46c010afd44f 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1100,6 +1100,9 @@ int str_read(char **strp, gfp_t flags, struct policy_file *fp, u32 len)
 	if ((len == 0) || (len == (u32)-1))
 		return -EINVAL;
 
+	if (size_check(sizeof(char), len, fp))
+		return -EINVAL;
+
 	str = kmalloc(len + 1, flags | __GFP_NOWARN);
 	if (!str)
 		return -ENOMEM;
@@ -1174,6 +1177,11 @@ static int common_read(struct policydb *p, struct symtab *s, struct policy_file
 	if (nel > SEL_VEC_MAX)
 		goto bad;
 
+	/* perm_read() reads at least 64 bytes for any valid permission */
+	rc = size_check(2 * sizeof(u32), nel, fp);
+	if (rc)
+		goto bad;
+
 	rc = symtab_init(&comdatum->permissions, nel);
 	if (rc)
 		goto bad;
@@ -1348,6 +1356,11 @@ static int class_read(struct policydb *p, struct symtab *s, struct policy_file *
 		goto bad;
 	cladatum->value = val;
 
+	/* perm_read() reads at least 64 bytes for any valid permission */
+	rc = size_check(2 * sizeof(u32), nel, fp);
+	if (rc)
+		goto bad;
+
 	rc = symtab_init(&cladatum->permissions, nel);
 	if (rc)
 		goto bad;
@@ -1921,6 +1934,13 @@ static int range_read(struct policydb *p, struct policy_file *fp)
 
 	nel = le32_to_cpu(buf[0]);
 
+	/* we read at least 64 bytes and mls_read_range_helper() 32 bytes
+	 * for any valid range-transition
+	 */
+	rc = size_check(3 * sizeof(u32), nel, fp);
+	if (rc)
+		return rc;
+
 	rc = hashtab_init(&p->range_tr, nel);
 	if (rc)
 		return rc;
@@ -2689,6 +2709,13 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
 		nprim = le32_to_cpu(buf[0]);
 		nel = le32_to_cpu(buf[1]);
 
+		/* every read_f() implementation reads at least 128 bytes
+		 * for any valid entry
+		 */
+		rc = size_check(4 * sizeof(u32), nel, fp);
+		if (rc)
+			goto out;
+
 		rc = symtab_init(&p->symtab[i], nel);
 		if (rc)
 			goto out;
@@ -2730,6 +2757,11 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
 		goto bad;
 	nel = le32_to_cpu(buf[0]);
 
+	/* we read at least 96 bytes for any valid role-transition */
+	rc = size_check(3 * sizeof(u32), nel, fp);
+	if (rc)
+		goto bad;
+
 	rc = hashtab_init(&p->role_tr, nel);
 	if (rc)
 		goto bad;
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 9b3cc393a979..bb96a6cb6101 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -353,6 +353,19 @@ struct policy_data {
 	struct policy_file *fp;
 };
 
+static inline int size_check(size_t bytes, size_t num, const struct policy_file *fp)
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
2.49.0

