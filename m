Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC0E79FD;
	Sun, 11 May 2025 17:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746984681; cv=none; b=a64Q6W7IILITejRvKcxmcxaamgoGF4u5t+P5tuJkCws0fGEOmWb22ECBVrz7QbgtNFwLPE86m2twDcpzAslHf14Irt2t+uHahvVoOPWfXoAbB1G85ESkHYsscwU6G7KP416E0VR/AX1SioCvzfLVzZFQd6VfNKcLLTjBEMfkJko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746984681; c=relaxed/simple;
	bh=ybb3cwyQrMkkb9uvDpye659B1DkSV6KsyLCaHufgbCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZ8tp5vxz4WhTCijGBzHCW3sFALcHcZfuuDN3DQUSm1fJXI1cABMUYFqCD7VGi7yokbIaAJo9Y3Eq/F3SqtncdVor4zByMF7CWbDaN9ZD1kRtH7JxdzdET7K+BJ+ni6ou0gWPSC7wnqlCsrGlBkyEgqUBBOKtsRlPvjweJWd6hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=G23HONWF; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="G23HONWF"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1746984677;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qcJ8h2VGTfQfjIkzrxk84YgNTMQM7PPzVMmpFq0NF+U=;
	b=G23HONWFmmPeagf7jUKMkUnp8mlmdvQTDXj6aY+8s2bcDLeYDU8cRoU4mpvy+PpIYi1/Iy
	kCk4Oi7BkXlti/elz0fiHymcvvBk/FMB5+RQUGe+Q9VOHqPhbzLBQeMB/uVidKViy29lzk
	HC6tJt84+CZpVm4roNBqlgA0EvOOP7rN40JxV/A2tSsMK7GU5nOi7L8cWAG/fjcwCexUEP
	WfrB+HoDwxV0ugt93OdFWC7DNec/BuO18/TMXIZUrwJgSCsRHu2XaszErxUbiAV1CyjJ+m
	Z1BE64uBWYqb99o9KsBcyqVrcTZjhylOzfb8OLc32gultPy5/4knOQ5EXu9fQA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-kernel@vger.kernel.org,
	Eric Suen <ericsu@linux.microsoft.com>,
	Canfeng Guo <guocanfeng@uniontech.com>
Subject: [PATCH v3 07/14] selinux: check type attr map overflows
Date: Sun, 11 May 2025 19:30:07 +0200
Message-ID: <20250511173055.406906-7-cgoettsche@seltendoof.de>
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

Validate that no types with an invalid too high ID are present in the
attribute map.  Gaps are still not checked.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3: squash with previous patch ("selinux: introduce
    ebitmap_highest_set_bit()")
---
 security/selinux/ss/ebitmap.c  | 27 +++++++++++++++++++++++++++
 security/selinux/ss/ebitmap.h  |  1 +
 security/selinux/ss/policydb.c |  5 +++++
 3 files changed, 33 insertions(+)

diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index 43bc19e21960..5d6b5b72b3e5 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -257,6 +257,33 @@ int ebitmap_contains(const struct ebitmap *e1, const struct ebitmap *e2,
 	return 1;
 }
 
+u32 ebitmap_highest_set_bit(const struct ebitmap *e)
+{
+	const struct ebitmap_node *n;
+	unsigned long unit;
+	u32 pos = 0;
+
+	n = e->node;
+	if (!n)
+		return 0;
+
+	while (n->next)
+		n = n->next;
+
+	for (unsigned int i = EBITMAP_UNIT_NUMS; i > 0; i--) {
+		unit = n->maps[i - 1];
+		if (unit == 0)
+			continue;
+
+		pos = (i - 1) * EBITMAP_UNIT_SIZE;
+		while (unit >>= 1)
+			pos++;
+		break;
+	}
+
+	return n->startbit + pos;
+}
+
 int ebitmap_get_bit(const struct ebitmap *e, u32 bit)
 {
 	const struct ebitmap_node *n;
diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
index c9569998f287..12bb359e83ff 100644
--- a/security/selinux/ss/ebitmap.h
+++ b/security/selinux/ss/ebitmap.h
@@ -126,6 +126,7 @@ int ebitmap_and(struct ebitmap *dst, const struct ebitmap *e1,
 		const struct ebitmap *e2);
 int ebitmap_contains(const struct ebitmap *e1, const struct ebitmap *e2,
 		     u32 last_e2bit);
+u32 ebitmap_highest_set_bit(const struct ebitmap *e);
 int ebitmap_get_bit(const struct ebitmap *e, u32 bit);
 int ebitmap_set_bit(struct ebitmap *e, u32 bit, int value);
 void ebitmap_destroy(struct ebitmap *e);
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 8969f7c8637c..27f6809b562a 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -2955,6 +2955,11 @@ int policydb_read(struct policydb *p, struct policy_file *fp)
 			if (rc)
 				goto bad;
 		}
+
+		rc = -EINVAL;
+		if (ebitmap_highest_set_bit(e) >= p->p_types.nprim)
+			goto bad;
+
 		/* add the type itself as the degenerate case */
 		rc = ebitmap_set_bit(e, i, 1);
 		if (rc)
-- 
2.49.0

