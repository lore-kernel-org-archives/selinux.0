Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2681C2BD
	for <selinux@vger.kernel.org>; Sat,  8 Jun 2024 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717867172; cv=none; b=I80Tf5pGaEM9bSGMHcK42DoBX2WnbwTrg/KeSJRVkDzL6GWnYZ9XBV1dqqUUL9zAtNf3AZPehfTNxDshf7IX6SsHMHTr6o0RifW8mus4N5udack2QuxRJTApe1+ZD323zuFKiwB9iQ1uT1rlrEsCRPPT82D7qB09e2pwMcXDyv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717867172; c=relaxed/simple;
	bh=UR85b+vq/zcHARWzq8q9PzfJmo8WG0D8hkpDaKcW3yM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HbGdE96o3P5Dd15zGqP1lm8RKsEBn5NrvMK5VnxOuhCvqqE3IC2TN6stFDJrotSyj6unCbUXxVvGrWYv9vuKqrF1BayOuwubWskv6N5vx/Xm4ZVQNu5rLvs9oyORiOIr/fBzW1dsR23gQFAp+PIpBxmoFnM4O4PcJu6udwSA47U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=j1I60lHg; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="j1I60lHg"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1717867166;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=FyXoRTDdKpdbSzII3WCjxkYWxTPm/Zh/DUMV5mhZdec=;
	b=j1I60lHglqOPZFtuhM4EMc/HvbswGcgi0bxQihO7T/9nof7pcrjIGflUYkTAdeS6oixXky
	7PIjdihUSpflm4U0hBi7xWr161dfssH679VBdzb45uwOhLjs3PknMELDk7G5tMyyenjs8w
	9tZzyHmrqI6qVIr+JkRVMHTLnUgkhlkdk/2NBHIRDVSUZZtDrnnQRHoEUKvsPKCOguinV+
	ajBC3hzO+YA/vAd599T8EJ/pT4iKaIcnM9MmSJmWwSARQyFa8kXtvqqbEi43nKSiMQrqLf
	4uDxLpx81/k1Bc/Hm/Ra5kGdSWJXUkW2UX5qFuZDQLo7uzJRC+VMdUEPRl+Gqw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] libsepol: hashtab: save one comparison on hit
Date: Sat,  8 Jun 2024 19:19:23 +0200
Message-ID: <20240608171923.136765-1-cgoettsche@seltendoof.de>
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

When the comparison function returns 0, avoid a repeated call to it.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/hashtab.c | 53 +++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/libsepol/src/hashtab.c b/libsepol/src/hashtab.c
index 2af3a9bf..399582b1 100644
--- a/libsepol/src/hashtab.c
+++ b/libsepol/src/hashtab.c
@@ -112,15 +112,17 @@ int hashtab_insert(hashtab_t h, hashtab_key_t key, hashtab_datum_t datum)
 	hashtab_check_resize(h);
 
 	hvalue = h->hash_value(h, key);
-	prev = NULL;
-	cur = h->htable[hvalue];
-	while (cur && h->keycmp(h, key, cur->key) > 0) {
-		prev = cur;
-		cur = cur->next;
-	}
 
-	if (cur && (h->keycmp(h, key, cur->key) == 0))
-		return SEPOL_EEXIST;
+	for (prev = NULL, cur = h->htable[hvalue]; cur; prev = cur, cur = cur->next) {
+		int cmp;
+
+		cmp = h->keycmp(h, key, cur->key);
+		if (cmp > 0)
+			continue;
+		if (cmp == 0)
+			return SEPOL_EEXIST;
+		break;
+	}
 
 	newnode = (hashtab_ptr_t) malloc(sizeof(hashtab_node_t));
 	if (newnode == NULL)
@@ -151,14 +153,19 @@ int hashtab_remove(hashtab_t h, hashtab_key_t key,
 		return SEPOL_ENOENT;
 
 	hvalue = h->hash_value(h, key);
-	last = NULL;
-	cur = h->htable[hvalue];
-	while (cur != NULL && h->keycmp(h, key, cur->key) > 0) {
-		last = cur;
-		cur = cur->next;
+
+	for (last = NULL, cur = h->htable[hvalue]; cur; last = cur, cur = cur->next) {
+		int cmp;
+
+		cmp = h->keycmp(h, key, cur->key);
+		if (cmp > 0)
+			continue;
+		if (cmp == 0)
+			break;
+		return SEPOL_ENOENT;
 	}
 
-	if (cur == NULL || (h->keycmp(h, key, cur->key) != 0))
+	if (cur == NULL)
 		return SEPOL_ENOENT;
 
 	if (last == NULL)
@@ -183,14 +190,18 @@ hashtab_datum_t hashtab_search(hashtab_t h, const_hashtab_key_t key)
 		return NULL;
 
 	hvalue = h->hash_value(h, key);
-	cur = h->htable[hvalue];
-	while (cur != NULL && h->keycmp(h, key, cur->key) > 0)
-		cur = cur->next;
-
-	if (cur == NULL || (h->keycmp(h, key, cur->key) != 0))
-		return NULL;
+	for (cur = h->htable[hvalue]; cur; cur = cur->next) {
+		int cmp;
+
+		cmp = h->keycmp(h, key, cur->key);
+		if (cmp > 0)
+			continue;
+		if (cmp == 0)
+			return cur->datum;
+		break;
+	}
 
-	return cur->datum;
+	return NULL;
 }
 
 void hashtab_destroy(hashtab_t h)
-- 
2.45.1

