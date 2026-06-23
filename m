Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B2437BE6E
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222156; cv=none; b=PjUQmi/MH28TH7JQHMObKdi0TyE8QOKzxRfOK1wtgo6ia18j3aCWq/sHONIS3GIfn9KfHZsnq1YO8ha2JVpviNKAtoByDALECuydd+N8CEF1NXMBvEOZYvMdas++o9SB/NWINqnizph/mgM03Os5Oj6FeYSghFQRnsNi3ylqkiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222156; c=relaxed/simple;
	bh=qVKg3eeUL0qesGqC9UnL8MONGUokXW0j+qLyaJQk7fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f1GTCLvO8owNE/TqBEAmpriktQpXB+b/Kivt4//bZiyoTBX9Htp3VS5UEHu7oWxncweVx0cQ0JN/fxdmqTfBpYHlCGcRm7TkoEJWB452DbQiTmYwyK/maY7PNs0sbH938YrxoiO+QHANj+z14nrauFUPdGiRqKLZXfi8/zhLNxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=TP3fBa9x; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="TP3fBa9x"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1782222152;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N/TCrPWZJVTIrbquN+AEmViYXL17liMK6uPqjT/ePYE=;
	b=TP3fBa9x70Y7f9tERlDExRL9nkg5mMwl0ssjYqffXp+xkRapA89GCRTCWCHQmdFdaqnSuW
	HEdN/ahT8x7vdSiDMO3KjDsgGEuFWS/iyuV0RBlFaW74iQs8gBDUNikh/Gju+DbeaDJ8ed
	dfyZv00GNtrsM2kRjb8SM7uHcSeAr4i9X7Oa1TIvbWA3JcRRd65Gtk4/hsc3sQMi5JdLts
	z0DhaFXj2iQM4MsdsKE/EiLSxj3bACuk0UGVbiDpmwBRDfrsLf9pyDeGtP+ZNWcdmXklpt
	gPfVOwy76JuN6xQpABj4tq9+2y/xKTPqZN6qM7ejfE+BfBr6sEYc1OqfCEWMmQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 13/24] libselinux: avoid integer overflow in security_compute_user_raw()
Date: Tue, 23 Jun 2026 15:42:02 +0200
Message-ID: <20260623134215.98273-12-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-1-cgoettsche@seltendoof.de>
References: <20260623134215.98273-1-cgoettsche@seltendoof.de>
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

nel comes straight from the kernel reply; (nel + 1) * sizeof(char *)
can wrap to a tiny allocation that the subsequent loop overruns. Use
calloc(), which rejects the multiplication overflow, and bound the
per-string walk to the data actually read into buf.

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/compute_user.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/compute_user.c b/libselinux/src/compute_user.c
index 6f058324..d81afced 100644
--- a/libselinux/src/compute_user.c
+++ b/libselinux/src/compute_user.c
@@ -61,7 +61,9 @@ int security_compute_user_raw(const char *scon, const char *user, char ***con)
 		goto out;
 	}
 
-	ary = malloc((nel + 1) * sizeof(char *));
+	/* calloc() rejects the (nel + 1) * sizeof(char *) multiplication
+	 * overflow that a bogus, very large nel would otherwise wrap to 0. */
+	ary = calloc((size_t)nel + 1, sizeof(char *));
 	if (!ary) {
 		ret = -1;
 		goto out;
@@ -69,6 +71,14 @@ int security_compute_user_raw(const char *scon, const char *user, char ***con)
 
 	ptr = buf + strlen(buf) + 1;
 	for (i = 0; i < nel; i++) {
+		/* Bound the walk to the data actually read into buf, in case
+		 * nel claims more entries than the reply contains. */
+		if (ptr >= buf + size) {
+			freeconary(ary);
+			errno = EINVAL;
+			ret = -1;
+			goto out;
+		}
 		ary[i] = strdup(ptr);
 		if (!ary[i]) {
 			freeconary(ary);
-- 
2.53.0

