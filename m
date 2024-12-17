Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E651F63C8
	for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734443993; cv=none; b=OAppXoCxhGE0EwXuyEFl+LOp5beWlaM9nERLXY/R03Yq4usLdbY41UtDgv8qfbeT8bPaSTOPG7wjoN9TFiVmjd5MTHXBVUomJJyufRHdT9wNUkH5QBPOaJfHyl9AAgC9w2Zo5GF8UAaEtVTB5tGqlpBaI42hxD70mBZuLcbN5HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734443993; c=relaxed/simple;
	bh=+dmwgXcQvc0CgAPNBg2/vwMLHofWMsy86k11QaohlmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BW/wemT1Bor9e9JJEO99LbeQf5aj8kn5yLB3X9Zj320Ut+64/UjwAFljllj+Zsj1mTQbY4iO1xPb6+uV4rMW2PLWej/vnU4ppb8kt9rB3P2l+QQu8KAwWy3wVVPgBqwcJ1sX26/hnSMDrx/gDNC21XpxN9q/zRsPKMB9OLrW64g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=eeHjyD5m; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="eeHjyD5m"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1734443987;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SW6njnvX3XKcOhrWMxYYei52sfXpGhxha5b5S6HureI=;
	b=eeHjyD5mq3MVLfm6ZjBQ4xmJNWZUZpSxIwY5q5T3Jx5+Bl2ql23lhZOS4CzgrlDTCLRy5T
	/LcK1WEPtqdi4z3RipN7IxdTjOl/xjl+GBZZ6fkhufPvoHGP7ZSBmx5pTOlMb2ZFNn36Y7
	hPYuxLnQ9XgD43Uw0HCAq2RuWj5Olb8bwcYiAXO/yrQ3O/HnuOA8hRpf5tczIpaPUE4ta2
	zkmxJPlnKmaEatsJDJmLyZ8GEEzfgwn7JlutF/E2n8MY2l5w09tMwR+fOHjbW9JCqO/dQ2
	gE70K+s6XNwIdSPRHUPvc603xPfr7JRBR9DRATJDcp7EJbQLqFBTbQ7W6DLJ4w==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 1/3] libsepol: update sort order for netifcon definitions
Date: Tue, 17 Dec 2024 14:59:41 +0100
Message-ID: <20241217135941.536152-3-cgoettsche@seltendoof.de>
In-Reply-To: <20241217135941.536152-1-cgoettsche@seltendoof.de>
References: <20241217135941.536152-1-cgoettsche@seltendoof.de>
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

Order netifcon definitions with a wildcard interface name last in object
contexts, so the kernel tries to match literal names first.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_post.c     | 36 ++++++++++++++++++++++++++++++---
 libsepol/src/kernel_to_common.c | 36 ++++++++++++++++++++++++++++++---
 2 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index d63a5496..70e5b734 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -316,10 +316,40 @@ int cil_post_genfscon_compare(const void *a, const void *b)
 
 int cil_post_netifcon_compare(const void *a, const void *b)
 {
-	struct cil_netifcon *anetifcon = *(struct cil_netifcon**)a;
-	struct cil_netifcon *bnetifcon = *(struct cil_netifcon**)b;
+	/* keep in sync with kernel_to_common.c:netif_data_cmp() */
+	const struct cil_netifcon *anetifcon = *(struct cil_netifcon**)a;
+	const struct cil_netifcon *bnetifcon = *(struct cil_netifcon**)b;
+	const char *a_name = anetifcon->interface_str;
+	const char *b_name = bnetifcon->interface_str;
+	size_t a_stem = strcspn(a_name, "*?");
+	size_t b_stem = strcspn(b_name, "*?");
+	size_t a_len = strlen(a_name);
+	size_t b_len = strlen(b_name);
+	int a_iswildcard = a_stem != a_len;
+	int b_iswildcard = b_stem != b_len;
+	int rc;
+
+	/* order non-wildcards first */
+	rc = spaceship_cmp(a_iswildcard, b_iswildcard);
+	if (rc)
+		return rc;
+
+	/* order non-wildcards alphabetically */
+	if (!a_iswildcard)
+		return strcmp(a_name, b_name);
+
+	/* order by decreasing stem length */
+	rc = spaceship_cmp(a_stem, b_stem);
+	if (rc)
+		return -rc;
+
+	/* order '?' (0x3f) before '*' (0x2A) */
+	rc = spaceship_cmp(a_name[a_stem], b_name[b_stem]);
+	if (rc)
+		return -rc;
 
-	return  strcmp(anetifcon->interface_str, bnetifcon->interface_str);
+	/* order alphabetically */
+	return strcmp(a_name, b_name);
 }
 
 int cil_post_ibendportcon_compare(const void *a, const void *b)
diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_common.c
index 44f0be23..e4338ec6 100644
--- a/libsepol/src/kernel_to_common.c
+++ b/libsepol/src/kernel_to_common.c
@@ -441,10 +441,40 @@ static int portcon_data_cmp(const void *a, const void *b)
 
 static int netif_data_cmp(const void *a, const void *b)
 {
-	struct ocontext *const *aa = a;
-	struct ocontext *const *bb = b;
+	/* keep in sync with cil_post.c:cil_post_netifcon_compare() */
+	const struct ocontext *const *aa = a;
+	const struct ocontext *const *bb = b;
+	const char *a_name = (*aa)->u.name;
+	const char *b_name = (*bb)->u.name;
+	size_t a_stem = strcspn(a_name, "*?");
+	size_t b_stem = strcspn(b_name, "*?");
+	size_t a_len = strlen(a_name);
+	size_t b_len = strlen(b_name);
+	int a_iswildcard = a_stem != a_len;
+	int b_iswildcard = b_stem != b_len;
+	int rc;
 
-	return strcmp((*aa)->u.name, (*bb)->u.name);
+	/* order non-wildcards first */
+	rc = spaceship_cmp(a_iswildcard, b_iswildcard);
+	if (rc)
+		return rc;
+
+	/* order non-wildcards alphabetically */
+	if (!a_iswildcard)
+		return strcmp(a_name, b_name);
+
+	/* order by decreasing stem length */
+	rc = spaceship_cmp(a_stem, b_stem);
+	if (rc)
+		return -rc;
+
+	/* order '?' (0x3f) before '*' (0x2A) */
+	rc = spaceship_cmp(a_name[a_stem], b_name[b_stem]);
+	if (rc)
+		return -rc;
+
+	/* order alphabetically */
+	return strcmp(a_name, b_name);
 }
 
 static int node_data_cmp(const void *a, const void *b)
-- 
2.45.2

