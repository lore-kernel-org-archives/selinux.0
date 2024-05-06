Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E87157461
	for <selinux@vger.kernel.org>; Mon,  6 May 2024 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715016686; cv=none; b=FUy1FUKj0sKfCrY3ohMH4x5lMHbYsWi66/7gaRzbXfdtq0pRCDb6WKKaF0XcQhDnrl4RdE0iqbcdbxzqCuyNMMWrtB7yVkfSqDb0GE1sS3pbAmXkyAdwHEyP+9jbOsozkIFJbrmQHBVi6nK/FHybAfVDNyqh2RHeruy4ap9kvqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715016686; c=relaxed/simple;
	bh=tLHTTHlGYt/fYagdKk4nQfjoj+kHe4j04dMJzROC5Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q30eZvAIOU+tT1FzzZJ9CMVWlPK/c/ZBReUZK3o2S8mxMMpyw51rwxug5Fb2cTtzliR62Xpx39PUWvkD1jjSfsZBj2pQcTUL1Ox3AWy/flJhbkZ5OdVhE2IxWT1f1w9doJJjHA+jaxKd4CzMoPD/USi4DjGIKrR1fbwwjtPK7ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=FpCgmlYR; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="FpCgmlYR"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1715016675;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cgKlFWBUNTuRT8UNnBvufxMflDwtbQ8n7t4JMgj9Euw=;
	b=FpCgmlYRcoPiB0pMKAyYYMU6uGUrkiBqZjxHtzcjR8n54cyDYmV5jWS6UH19o2R1XD/U2V
	YST3yoFS1ZQIGUtTWL5ZTZsKCsW7k+tV7sf0eBMbYEwnkcBm6wbFTrKLQK4Vk+zZdmCfK7
	I7+ad9qUMt8zikZG6Hw3Zqx3IJRcXv0CHJjAObxM3f4dPs+aT+1jDgCgUIaUar2J1UdyGv
	8KdbPmhjxsxJXdQtg/TO7fbi1HVOlpAwAC600nEKjaTHxP9VaNxQJ+Vc+ViT7pJG5dwRM5
	881YY0BxWIvlZRsdeJHyetU4Y+jxq4+wLPVZ8O4AptV9k8clhJySU5rlXeEZ+w==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 3/4] libsepol: validate type-attribute-map for old policies
Date: Mon,  6 May 2024 19:31:09 +0200
Message-ID: <20240506173110.220702-3-cgoettsche@seltendoof.de>
In-Reply-To: <20240506173110.220702-1-cgoettsche@seltendoof.de>
References: <20240506173110.220702-1-cgoettsche@seltendoof.de>
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

Validate the type-to-associated-attributes maps also for policies prior
to version 20.
To ensure only valid entries in these maps, skip the degenerate case for
gaps during construction.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/policydb.c          | 2 +-
 libsepol/src/policydb_validate.c | 6 ++----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 49f9e8af..e90ccca1 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -4450,7 +4450,7 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 				}
 			}
 			/* add the type itself as the degenerate case */
-			if (ebitmap_set_bit(&p->type_attr_map[i], i, 1))
+			if (p->type_val_to_struct[i] && ebitmap_set_bit(&p->type_attr_map[i], i, 1))
 				goto bad;
 			if (p->type_val_to_struct[i] && p->type_val_to_struct[i]->flavor != TYPE_ATTRIB) {
 				if (ebitmap_set_bit(&p->attr_type_map[i], i, 1))
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 04135d84..84c1071c 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1787,10 +1787,8 @@ int policydb_validate(sepol_handle_t *handle, const policydb_t *p)
 	if (validate_range_transitions(handle, p, flavors))
 		goto bad;
 
-	if (p->policyvers >= POLICYDB_VERSION_AVTAB) {
-		if (validate_typeattr_map(handle, p, flavors))
-			goto bad;
-	}
+	if (validate_typeattr_map(handle, p, flavors))
+		goto bad;
 
 	validate_array_destroy(flavors);
 
-- 
2.43.0

