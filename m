Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F42622A1ED
	for <selinux@vger.kernel.org>; Fri, 30 May 2025 11:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748606062; cv=none; b=g39o4Yt7sV1cspfHNhX0MFBSTQzPWG4TtHLhSrQ0tek1fW4jQMIBcnFVl4hLfMKu41WrNwRWDN5OXIHFhQUwXIxDxbs45bri0RAPFlgRVJiGbP/cWYPL7ud8gVq6IM13u92w0gVdzehtZKoV7X8BxpV6Z/8CZYqgNqfZhLl1LfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748606062; c=relaxed/simple;
	bh=0odkK11T83/b2IEgQtchS+akMpDOFd5Dov+w8Ov1NYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SqrMzhAI+xmCmOw+cmtDup9yJghdd7OylPyYz713ZtiDNVyv6BtuTbdrFg2HFM+Bj7gQa9RAW+8ewaE+lBfeuvtB+qYHfENxl9OFHeVXmewqgUnblp9qEEJaa2Nwls7jYNdwXuLqSRsqYc/QFL4fnUlSG49EtabuslNw3tpMpoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=WAtKWgoF; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="WAtKWgoF"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1748605726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q6+iyovX8+0oVklz0igQ1H4Y8mFqwkanGxPJx30gsbo=;
	b=WAtKWgoFWLpRK13ULPxme60yKhPF+tlPLeuyG8hxTA8g1AhPAQgD0G3cxsYS9UovXGVz8H
	JQh7d3eTmeLQ/ZQJVkD6VVq4oTQHNrhDhOZ0n8Gy08Rk/wkFXpy4m8mt00M0FO+zdix76g
	NBB+hSsSf/UH0s8dpHAGNXgMFoXqN8yPIvqrpv4QPV+DLV5d2eotCaQtC1JuvSFzjG32Xm
	erujThnT9AU9dGgfcWk0P7hP54k6ayQNKenU5SyBCKAEEyLL1S/AxA/fo6ahqLcL5xQse8
	O10c2HxtQKSo846Ev54O+QHPK/Z0fbq3sRsJPBkrCuxQ6oAThyJgMmUgn6DKVQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 1/4] libsepol: update sort order for netifcon definitions
Date: Fri, 30 May 2025 13:48:33 +0200
Message-ID: <20250530114836.30643-1-cgoettsche@seltendoof.de>
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

