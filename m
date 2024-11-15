Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0D71CDFC1;
	Fri, 15 Nov 2024 13:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677817; cv=none; b=PccLF5fAWTA03qnpk2axEblUzDy3tTQ/zCsDkUeU0xPB46SrNXhaCyFnW5NldU95vT/YiSTbLPxORCheNvT9GipojPik0tpCqsbbT0l9t8aWQemUvAT68LzRk5vfkANMmJIHZvs3X7OLAg5x5QY/Ww9P/M4402C3aabyo9UZJ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677817; c=relaxed/simple;
	bh=ouHDODVJurRyJEOkOhCj9pVvwAvdaE9uDibnZlcGZN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N281GkLV1LOVNeobR0xPZnTKNH0+cLn7168MJGPJQLZQrPnL7eZwzCFLFoHs27v5pH4F2vidJBXHAjxw3ZBf50mTnAnG2JIlD5lgBRGXdGgHE560gvDV8nUQwQm9RqydRMPJLIly0LyweKUtDpRlwasTalZGNFW4LMMoImrkVJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=mZ0E4jus; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="mZ0E4jus"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731677812;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R2g5Wk+CWFl28MX4lhzXMKz3Oz2ct6jAzT7+Bkx0DJg=;
	b=mZ0E4jus303HZmXIXmo5nMnPfRfDAYpDKy3jlgD+9mdaySPZqngn9u/9AppSwmLg+3wRuI
	aBpvcGL5bqDrgu3p7VHIjPz4TQrbITWCgWQY0WpuF390xZ4bPhoYk142VSJ+hb36EfIWKD
	Oo1ArTkrVdSH5TFv5lSW9AQoDrbg45+Z/4mrWs2emkO7r5E8HBKDm1v3vYU4LtS2FQyHbv
	c8M5QBaFcffmqG3oDyCj9abvMXckp5Kn8SnUboo8cEPZAHYeA00+BIthHl2K79ArTgxJq+
	L7pSAolgEfZmIFhoNxsnNIci20Gl86oFh1TyKSVGgb1nO2a+ru2PXUGYDHb/MA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 05/22] selinux: avoid nontransitive comparison
Date: Fri, 15 Nov 2024 14:35:24 +0100
Message-ID: <20241115133619.114393-5-cgoettsche@seltendoof.de>
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

Avoid using nontransitive comparison to prevent unexpected sorting
results due to (well-defined) overflows.
See https://www.qualys.com/2024/01/30/qsort.txt for a related issue in
glibc's qsort(3).

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/policydb.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 383f3ae82a73..d04d9ada3835 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -37,6 +37,8 @@
 #include "mls.h"
 #include "services.h"
 
+#define spaceship_cmp(a, b) (((a) > (b)) - ((a) < (b)))
+
 #ifdef CONFIG_SECURITY_SELINUX_DEBUG
 /* clang-format off */
 static const char *const symtab_name[SYM_NUM] = {
@@ -421,11 +423,11 @@ static int filenametr_cmp(const void *k1, const void *k2)
 	const struct filename_trans_key *ft2 = k2;
 	int v;
 
-	v = ft1->ttype - ft2->ttype;
+	v = spaceship_cmp(ft1->ttype, ft2->ttype);
 	if (v)
 		return v;
 
-	v = ft1->tclass - ft2->tclass;
+	v = spaceship_cmp(ft1->tclass, ft2->tclass);
 	if (v)
 		return v;
 
@@ -456,15 +458,15 @@ static int rangetr_cmp(const void *k1, const void *k2)
 	const struct range_trans *key1 = k1, *key2 = k2;
 	int v;
 
-	v = key1->source_type - key2->source_type;
+	v = spaceship_cmp(key1->source_type, key2->source_type);
 	if (v)
 		return v;
 
-	v = key1->target_type - key2->target_type;
+	v = spaceship_cmp(key1->target_type, key2->target_type);
 	if (v)
 		return v;
 
-	v = key1->target_class - key2->target_class;
+	v = spaceship_cmp(key1->target_class, key2->target_class);
 
 	return v;
 }
@@ -493,15 +495,15 @@ static int role_trans_cmp(const void *k1, const void *k2)
 	const struct role_trans_key *key1 = k1, *key2 = k2;
 	int v;
 
-	v = key1->role - key2->role;
+	v = spaceship_cmp(key1->role, key2->role);
 	if (v)
 		return v;
 
-	v = key1->type - key2->type;
+	v = spaceship_cmp(key1->type, key2->type);
 	if (v)
 		return v;
 
-	return key1->tclass - key2->tclass;
+	return spaceship_cmp(key1->tclass, key2->tclass);
 }
 
 static const struct hashtab_key_params roletr_key_params = {
-- 
2.45.2

