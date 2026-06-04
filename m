Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1E347D94B
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 12:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577786; cv=none; b=tjhtUrfxk9PtRxpcEuMj1lUp3jN3cKJDszFuU9QDCxusdLktR+3lNqirXxBX7z10o2NLD8QLQR6kM8XhIAJ0DJvUeIW3/AUUvZgNek5P6LeWvLR5VZhb+EMWXCZhIsWROFcjAKI49pM4ak5DrwskZtf9aj3L/zAMuw2U+2mIiF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577786; c=relaxed/simple;
	bh=duUTerIGsSrf0RoVJgjr8BwIWbUfVwJHDyfF28ui8KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=it+I+Na6RLThsHw9X53tWstcluysFrb4aGTnEymKonk18e1WVQNNFamAhgC93tCFCu/05jp1AVxsE3YCajREAb9OBhX0mqQXqtZHTpw0QCiMHLYx3Mc+YfsDGrrX4iS+TE1s94v/IhSb4MiAs7bTeYhfyVSSoCwxtCtyEsVzT9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UU2LbmCU; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UU2LbmCU"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-9158c621ebbso85620385a.2
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 05:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780577783; x=1781182583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ds9b9vzaGUGi02UkZnjU1H4GXXALUle0kLcsTuOotG0=;
        b=UU2LbmCUPjgZwjGplQLCgqdTkkZJe1u1RPumroji0s+77jXZ/NWH8YNWUyyxH6Ng63
         fDt0E8CnwWclx72Tcsq9XABAw6lZ4yQc3oODbwAfH+N4hBQ+kuCNY4/b7bKN3mXfnHfr
         amRbuP3ntoJfGKBEp389xWha2sHWiow/EGFrVGFi8eo4zD1ZjsHiwqrzgzLmG1WiInzo
         sD517OijmCJ0XFS+7pnmA2/tziaZCp/oMzSiQKtMRBln1CZtJxNkSePPcwSreg3fHFRI
         hR0F9CJ/nVfjp8J47jUyWeCvbbWgS4IyQI3KSwRfpv0H29rCbYCF/e+Kt0xxXHncBDAw
         CQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780577783; x=1781182583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ds9b9vzaGUGi02UkZnjU1H4GXXALUle0kLcsTuOotG0=;
        b=bFJGVjWBPd51MwIgFywhYbho5kZRm36F9UyvW5+PMrOpuETtgWKXX7932H7Mb4jMHO
         KV0/YYtKP8UG2V/OPT0Yi73Uicq43DN92TJNdVrHM2zFBYELwa6VzFF0AIUWO8Ori57R
         9ohJtpObADVa4tf6McpHSAEHNq9o+7k4BQi4e4v1yqbtnXYyZ8atQEbsqhtDiDJOH3rb
         FMaz3+WIVtFNJlHjcTbyDLLd3oLKDfmQoQIXP5yhYAB12O/QYFYlI7Q9T7iyFN4SG9eh
         YuqtxOHNLUvIVoAdy+rvi7ckWoSVF9i9edDzeXuzBtHOMBliqnf1ZgOs1yN3x7iMF347
         L3CQ==
X-Gm-Message-State: AOJu0YySGK7H3E1YtsKjEVU9n9Dy/s98//8y8AlmCa9bcGknGd9aqzdy
	HML0vaiiDsdvOkywy2361vtMzmLcSDXaytF2g+7ttC1+v2pZpwYN4A0XoaQGCw==
X-Gm-Gg: Acq92OGI5Fj+/fvQ9BObuasuFB8HI0INpnbVcrzjA7/KxeHm5NQROvu1euDOQ9r8MYe
	qvkPdm3OSa5OfzFF5+kH5AIFFtSwvcnyghASykWOuNHsQz1x8blxup+ruGj47c85Egr2N7x3AdH
	JWIh77jtT8x2BYqvbrgK4gGyEeP4xLIwXW7W2YjcGLfkT5cDZdmU6TvXArU9jDHwjAo5ELBYvr8
	W1XLQkYuXgWWuaMcxEp00oOwMq/PJ2PGdP+IG8B5M7VkR5ICdrklBbPbEMStlQ8oepWQcW5OVJq
	cVcGHqOTlJjXMUJxJ2OwzMT4ZKbFTWbkutKYxQugdBwl/yOXZpJ3232EFsm74r0SdvqbzYJv9F0
	UM/jDW4GXfnvpmiHPv05n+tCwI+fItHbIrzDnN/UenPRHxsBYH2acGuBseuYnPSKD8Q8CTYtOiy
	tFT3H3AEf1zJ9sa6J8FbFs4yEd2yVRJGPTUIyJZTyPcwxkvTFEaMManBqFRT4cYC+38CPy9ySxy
	opMafXTrxU0u7lujUwauvcQYZpTaMqcIUlhDg==
X-Received: by 2002:a05:620a:4614:b0:915:9ffb:1f67 with SMTP id af79cd13be357-9159ffb2215mr264467285a.30.1780577782817;
        Thu, 04 Jun 2026 05:56:22 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a243041sm598297785a.18.2026.06.04.05.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 05:56:21 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 6/6] mcstrans: cap the per-domain translation cache
Date: Thu,  4 Jun 2026 08:55:57 -0400
Message-ID: <20260604125557.255554-6-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604125557.255554-1-stephen.smalley.work@gmail.com>
References: <20260604125557.255554-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cap the size of the per-domain translation cache to prevent
clients from triggering arbitrary allocations. If we hit the
cap, the translation is still computed and returned; we just
do not cache it for future lookups.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 mcstrans/src/mcstrans.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
index a983e53e..15c2d76b 100644
--- a/mcstrans/src/mcstrans.c
+++ b/mcstrans/src/mcstrans.c
@@ -37,6 +37,7 @@
 #include "mcstrans.h"
 
 #define N_BUCKETS 1453
+#define CACHE_MAX_ENTRIES 65536
 
 #define log_error(fmt, ...) fprintf(stderr, fmt, __VA_ARGS__)
 
@@ -108,6 +109,7 @@ typedef struct base_classification {
 typedef struct domain {
 	char *name;
 
+	unsigned int cache_entries;
 	context_map_node_t *raw_to_trans[N_BUCKETS];
 	context_map_node_t *trans_to_raw[N_BUCKETS];
 
@@ -661,7 +663,12 @@ static int add_base_classification(domain_t *domain, char *raw, char *trans)
 
 static int add_cache(domain_t *domain, char *raw, char *trans)
 {
-	context_map_t *map = calloc(1, sizeof(context_map_t));
+	context_map_t *map;
+
+	if (domain->cache_entries >= CACHE_MAX_ENTRIES)
+		return 0;
+
+	map = calloc(1, sizeof(context_map_t));
 	if (!map)
 		goto err;
 
@@ -688,6 +695,7 @@ static int add_cache(domain_t *domain, char *raw, char *trans)
 	if (add_to_hashtable(domain->trans_to_raw, map->trans, map) < 0)
 		goto err;
 
+	domain->cache_entries++;
 	return 0;
 err:
 	log_error("%s: allocation error", "add_cache");
-- 
2.54.0

