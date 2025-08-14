Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8A5284B26
	for <selinux@vger.kernel.org>; Thu, 14 Aug 2025 22:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212076; cv=none; b=Ua0scnrct6tVs+e5hF3/+fJOMXB5TtlPmvkin0j7493ZtTcL8+jaLCN5R4HS7TUAO3nJ/CD8rR0zlDwuJ5WNUufMSxssUoWGjyZW4wRcqZexQtTYQVYoR6gHGzWuIEdA//KqTtEVdFDOefHjQKtzA/e7Wq4ZXMOwKxb/Ty8afKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212076; c=relaxed/simple;
	bh=h51LbKQLGJsvrBa+Iz7VS4VBwJzMIF760iWjfgByrfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FnuztP20Yllp5Bw7TWvm8z1R+lsG+5O9ns40ZHbARK9LXppDj+BSj/1EemmIPMbSdyejxPw4UGnGQjnYXNR5kG7u/1VbVihU2inigPIHuZkYaaMaUpryvaDJpkLs34oo7R0IOxPq1imHStPBgEyyZuK2uXq+7oIVEW8PCgcQIes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ff0kb/zD; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ff0kb/zD"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b109ac4223so13516411cf.1
        for <selinux@vger.kernel.org>; Thu, 14 Aug 2025 15:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212074; x=1755816874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9rLns9pvbH4k1aNMCORhersCm3SEdLh6L2UdwCc1Xo=;
        b=ff0kb/zDqC+c5Y6AhB3tbIxjkx4TcqEm/3ld4ZKlOFL2QBd3p0nAsQHqlqsg8xZkSY
         bZpbVlym6rCaYdLSEuXL5jqL1hfdvs88wFupcaV/qd1hSnba6IGH9J2HqVnnkrtAmfYJ
         I5r2ofwq2hwtGBbdeJX1AMiFCRWPRpCAyI/dEfh3YlGeyuOhqlI6uNUDMAWBK2x6OAYi
         3NIZZvb/wBIE7ANZ2YwaMoim4uoEaHzOITTnLHzA2cSrMU9QTHBMotK2okDhWShD+Ybv
         gx0vlNnAZw2vMv5Gxke/1mCC/KJ4iBtcOCtsi9Bg7twCSw9RlDZut91+AgDrZKwUQ8E6
         spHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212074; x=1755816874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9rLns9pvbH4k1aNMCORhersCm3SEdLh6L2UdwCc1Xo=;
        b=rUqTdlUJFTPGFamttBfXk0LhEAMJx1nR+Xb7E/1LZfz1IIgTBJBDSkm3LJ+6ZeTt/k
         T+WrYeI1bgVhRUb/x4XxdOqbD7CEFnXSN1f4PsaMC3/WDWtBWvWzhtz+LAJLJtpbmo8k
         yCXk0GtOZO+unfGbmKn+uf0QhPa77xXJJAv3ipAqVvERm8nXE6Wkci+78i6vBmRdQgkv
         CoK2tIyzeEyoDVwIPsl/SuxwDj8B1NgSn0pNNdHHr2NaSuHuhmkpvIu8xOIlzTUdQmk3
         NxJKRDRdNJE7cj0oxMPxWx6TGyFHMRDLRlAFpC5F/0AQsgzIWRjiUQEaMNnODb9vy3W7
         V08g==
X-Forwarded-Encrypted: i=1; AJvYcCVXfHFVf7RzdWOZfEIjxHel5zGt26rd6D8vs7JftWAcpTrEnF4+fo9zg4mq3qhioLlO2plkhabx@vger.kernel.org
X-Gm-Message-State: AOJu0YzJobb9nNVWcQhNIJDe0nZyPqT4QnV2vNjb8r0Lo1+bvk9dE6YE
	2/rG+o1epn78KTsZZTPrEHgfJQTjqipXuikZA5DdGbHR+3pMZHWpqzohjI2P67QMsQ==
X-Gm-Gg: ASbGncs9Xl9dvaYHde9wGvnXOj5lr56o7trojTwTrGXSs/0iKXwFlHM6cdYet33Vcjw
	+IRVjnzx2AYeDOZi+8H49iM22KDTVC2xLO3gv1mMje1MGA2SPoWTAELDFuZgp823KWvsjUcT3dh
	/bucCwtKM6tfH257zzq1NCq+pmR7mVVXg+KiWdXhNRZxTRo/+kYK3LGTsXkn1y6fhaO54RmOgA0
	koEFrdc7ETvBf398f2eP9cSwtLrxZWiI/xpYYWakai7t8ZjzNuyPwhqIjggBEuqLJ4yw+1KPZ1d
	dfo80i3xOfy5YT0WJhlL913Du9NpbOmhnSOq/tNvQTpTv5KwI03KWsGJ3+Sfa870VopD4P9pAse
	Xuxp6yaXm8VMiiZ1SHdpPyj/roCERQplI4GP5ya/kP8WzwGQwY+2rdwkeKqXhrpSgZ4c=
X-Google-Smtp-Source: AGHT+IFGnGOdhkUGZHZNVoB+XsVpS4HhDC4LYk3N/pFrd2MC5p2rST+3mAbp6m1wzkl/NSILvVd1FA==
X-Received: by 2002:a05:622a:488a:b0:4ab:751e:9d97 with SMTP id d75a77b69052e-4b10ac26544mr66130541cf.49.1755212074243;
        Thu, 14 Aug 2025 15:54:34 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87b4f33b8sm42053285a.69.2025.08.14.15.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:33 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [PATCH v3 17/34] lsm: cleanup initialize_lsm() and rename to lsm_init_single()
Date: Thu, 14 Aug 2025 18:50:26 -0400
Message-ID: <20250814225159.275901-53-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2151; i=paul@paul-moore.com; h=from:subject; bh=h51LbKQLGJsvrBa+Iz7VS4VBwJzMIF760iWjfgByrfA=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmjDdPC2yjKunq4kvgZdiFZ+UTpy8dq4tSBIf gY5TDGVeXmJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5owwAKCRDqIPLalzeJ cz2TD/9S8D3ZZBCr+/j0HGmXnhSc6sWkQTE1Hk8c4Y1j+lZvqfCgisbLEr+8CKaGfQyDJrPhoPJ pNwBN7mYnCMyV08Bfb6HsdovENufY0bOl4nbpLGjCi9U0qBe76r8stGD7ScvasRo4Fe6Eexf6oZ Ykls9G1eE9F5OltJlJ+toi2Xv5jwHJlf76qoREi+7N1qKZrcklHhQdNQwc/pPy7O4jhv5HYn5e5 7SLZneeJe7+bYJn2z/rIaIugDK15qU4x1sWH08beEjBe2sJxke3mC0lMMj5q83zzrTkoFbPF7om N/xWrywq9v2a4qnXsIywhw1eq/iXfxHIrZK49pf63VO3YjoxIthdXcsF2MgTbIgL6H/I4jdBmsW AxgKs9NkNsZEjHiP5wrIR4GIR7YhLd81kJbXswi8woT9glyqRftUcB0CvLBtZ5DR+5TmUKKRVMk XOGVDkok7sv7k8GiqipkEzdkIvggCu402PtjuCNGx9H3x6Tq5wJ+OjGGvIIlyHoUBM48qbwYsw+ Ap8kzKRNkX6QXGa+kDP4iCzjTT/wppZLOrz1AJRDH3xr0WeoPgDKnz/M02UCgd8aoXusQzlt9KX xWHVjANjAuv2X4LIng+iZbAr/3/CkSAG6nltXXGR+FSPnKqKjfyurLC/YPXsVLZWMjP1+whDc11 NpjeDQPRYtZGUdA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Rename initialize_lsm() to be more consistent with the rest of the LSM
initialization changes and rework the function itself to better fit
with the "exit on fail" coding pattern.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 5249aa044d9d..1f64222925c1 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -169,6 +169,7 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
 		   lsm_is_enabled(lsm) ? "enabled" : "disabled");
 }
 
+
 /**
  * lsm_blob_size_update - Update the LSM blob size and offset information
  * @sz_req: the requested additional blob size
@@ -225,16 +226,20 @@ static void __init lsm_prepare(struct lsm_info *lsm)
 	lsm_blob_size_update(&blobs->lbs_bpf_token, &blob_sizes.lbs_bpf_token);
 }
 
-/* Initialize a given LSM, if it is enabled. */
-static void __init initialize_lsm(struct lsm_info *lsm)
+/**
+ * lsm_init_single - Initialize a given LSM
+ * @lsm: LSM definition
+ */
+static void __init lsm_init_single(struct lsm_info *lsm)
 {
-	if (lsm_is_enabled(lsm)) {
-		int ret;
+	int ret;
 
-		init_debug("initializing %s\n", lsm->id->name);
-		ret = lsm->init();
-		WARN(ret, "%s failed to initialize: %d\n", lsm->id->name, ret);
-	}
+	if (!lsm_is_enabled(lsm))
+		return;
+
+	init_debug("initializing %s\n", lsm->id->name);
+	ret = lsm->init();
+	WARN(ret, "%s failed to initialize: %d\n", lsm->id->name, ret);
 }
 
 /**
@@ -379,7 +384,7 @@ static void __init lsm_init_ordered(void)
 		panic("%s: early task alloc failed.\n", __func__);
 
 	lsm_order_for_each(lsm) {
-		initialize_lsm(*lsm);
+		lsm_init_single(*lsm);
 	}
 }
 
@@ -429,7 +434,7 @@ int __init early_security_init(void)
 		lsm_enabled_set(lsm, true);
 		lsm_order_append(lsm, "early");
 		lsm_prepare(lsm);
-		initialize_lsm(lsm);
+		lsm_init_single(lsm);
 	}
 
 	return 0;
-- 
2.50.1

