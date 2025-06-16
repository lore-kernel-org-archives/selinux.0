Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB0C20F09A
	for <selinux@vger.kernel.org>; Mon, 16 Jun 2025 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750087864; cv=none; b=alJmiJPOqWtudGzzpWwojWw+BD9EIo8C4gQDj+croJOQ7CZ4nQlDCnyEjI8EtrcuZDSM8rgdDw2zXpg//mwhAEqcUMVYHeMT9hH9B39NB/0uAQiinMy0Cq5B5AXDK6hGYCpcjoNPGXoOaKe2MevZszUNRv5kdE165IK1G4VAPTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750087864; c=relaxed/simple;
	bh=0odkK11T83/b2IEgQtchS+akMpDOFd5Dov+w8Ov1NYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FFQ4lGyUT+jXxhDh/pK2t5kcZ/6HeF6i6EHw4reCn9tED6DkhhRjuuYkP+kd7vcteLvWK3Xed3+LGIYw54vBAZotf8fmK5Ku65oes6wcQ2lPBEBgYhvEQzlUzmvEuzREwnJPHNtg0krLuN3uXuF9DaQ+T7vR4QdDkakfRUMU3wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=lGE6Q7/r; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="lGE6Q7/r"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1750087545;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q6+iyovX8+0oVklz0igQ1H4Y8mFqwkanGxPJx30gsbo=;
	b=lGE6Q7/r2djWHvLlXh6mO1GjF8F5hWbRdZ3RIJW2tC4ovGAErKJemXy4DML+dpBMwqU67M
	UNMzK+sr2pzG4SBHlRZ/TLVpAuf94y0afqjBTA85fxsb1AxQ6TFVfoUsY/pDQEv1vacnKe
	Jm3+nhtt38d8WhqpaMr43/EzzdtnHCLNDPFzBxaPBF8lpWK6Lt5fNBxkztNdBmRzyivs8x
	Teelq5Zz1wKqAsb55sQn3g8mFXhry/tU+T/xEOvUfRtHKYlts4xqC5SlvVH0Ma0Kl6BfGW
	SuOSGgQ0HtZ3FcCfNRBsHizwZK9n9vCdKyoi67TRY1OoSP5BJjNNvEfi5uu2vw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v3 1/5] libsepol: update sort order for netifcon definitions
Date: Mon, 16 Jun 2025 17:25:34 +0200
Message-ID: <20250616152534.26053-5-cgoettsche@seltendoof.de>
In-Reply-To: <20250616152534.26053-1-cgoettsche@seltendoof.de>
References: <20250616152534.26053-1-cgoettsche@seltendoof.de>
Reply-To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
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
2.49.0

