Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE965246775
	for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 23:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140249; cv=none; b=H8NxuEWAPp98ehm72q1Wv371wr6QAplY5INQRXuZjSSGyhBwVmErhEUFk/fuUeQ1XcWjLVLeTkjwF2BOlvWElAHLRm0/RHRb/th/EOLiTmlGxiN4MZ5SJqKHHd2cZf5bsH2of5UahQIG9xzAFm1aYXBg9GhzC11LkbV9fRJqm8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140249; c=relaxed/simple;
	bh=VkDqekEGooACbobTsF+ofijOUXBUL1lObHTgsHIPDUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjChJYABW+zG0eU1THwCHN0fEsH8u3HEGjMKN6xfxsfd/eUG9NfeXX8EBLLVYAu2a7nfDUfjzLuGhZL07x+EPQUOE+/pTVFFO1c5HO1W+RLCujEBEFNJP1j7+TWxkaXKlb2l/ZtXGnBQjeyAm5gkvtoBsJ5qK8zaGw972QwYNSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CkgifJh5; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CkgifJh5"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-700c7e4c048so78429716d6.3
        for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 16:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140247; x=1753745047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uy5IJRaBCCHH5fmqqMmAku9Mm3gK87SrjLXhFK18rJM=;
        b=CkgifJh5HGUyywy0ZakvW+M0Z11fhpnjyy15Ei69onb+IRZV2EIOGFh6ZyWmHpDzZL
         tlf3K0iQq1Q8/KE6otGgA35YBbl3AHxGTnOYapZPY3IWh5BjkYLdC23ymic6AAaFn8pU
         /j18OEFTjVXeCtNO7z1kKc9TP5PnMNU8dQI7tgNo+liU+V2ZtnVXi2jamt9lEJcUROr+
         /RJQp74kz+zPBoBQrpuYTorxjnR0WD7WJuHytclBX+6ClnbByBBsIF1929zT4gxOOyDV
         ko8y+K91E3OajKUGpVHQK3Y+lkr/M+6LtvnU2g9aa6I6YFiLJzAkIwd+/h41F0O4u1QB
         XWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140247; x=1753745047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uy5IJRaBCCHH5fmqqMmAku9Mm3gK87SrjLXhFK18rJM=;
        b=ED7O0/BLpDBTasH49eFQb6Y/UFlsWj7hBOTsRigXYytA+e8NMrFe4rKvWkJexhTJSZ
         /Ttuzf6aO+64Q5u071Lziip/6Uj7V6M16KshJLb5TL0SZHQO+KxQHeXWH9exNNHLXHfu
         fGCKYt37djCNiBUOH3wWj7Lt9UD6XOMo6RyHzK2pAHSC2c7xN6sl1uVtiLUVfaGgETH0
         uNvgUel9MnZyAtM1D4HvcEyVYt98rcTM6SHF4NFgscd25cL1RmGV7ttE5d5a9TuVgDPU
         KyUCpLd68Fzg1gZMEYyEMMn3ks47y0JAkDg6LFsxdM5w1BAKcI3HE4k5ToAuki8V3go6
         Xagw==
X-Forwarded-Encrypted: i=1; AJvYcCXFQHE6gGKs8AxK5vki5MXvPXhgZO4jL07ux0ZNhnDdQAIE8HVg+nOD32A8E5jywA8FFkO5TaPK@vger.kernel.org
X-Gm-Message-State: AOJu0YxfAo7tS8oY6ZRYajDKknd2FafiKzfC5vBSO7cVUUxxJ8r/Nk9K
	yRDQ8tKX/YVOKzApnlarh51TJbDCNfW6KLTdzH+nXLXXEfiPWu53GUOtxxEk8Wncsg==
X-Gm-Gg: ASbGncsT2Jf+4YZILp064tnboAd7BQtrfDeHW1bfKNs7eVGCBHsUibdKbtqZ8tis3Hr
	0UFQ2JsNOO+nsamKYrzVVPT5+XF8s0X2AHEyE/CRZySC1nbDLA+BYnGmd12CtTyu+I160N4bFw9
	1/9+IjvuLFvuR84T1fu268jFH4WYZMOFKpwTsK94FmNFW3ttIgZN1hjQs8eqgdhekAcMuFoqsHD
	epW5K8mTKHnfFWr78UdkJ1xLTEz62Iu3rynJ4F1CSaxa0uzoFTxvQmALL2iihXm+GhUwFbvUmnI
	XXv19eSzwHy59icuD4fkW/CUjgPiRSB7DkXIZJLPuHX9quG3J/3kYgMjJloWHD+kYEXu6boYN+V
	ZaoHMFlrOeuAuPPWtqKSp+rnrShqRMrrE4w0B4OsG3Q8Pwb9jWmnab2FDMHBlRs/J5qQ=
X-Google-Smtp-Source: AGHT+IEnICSUlfqJ3cELZ4P+O3voqpvhoWJ3CPj++sIhYNyBXHwTOyWdS/DJdQh1lgzBLivqZUv5lQ==
X-Received: by 2002:a05:6214:3bc2:b0:704:f952:1881 with SMTP id 6a1803df08f44-7051a1955femr214146526d6.46.1753140246830;
        Mon, 21 Jul 2025 16:24:06 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7051b9196e7sm45357886d6.48.2025.07.21.16.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:06 -0700 (PDT)
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
Subject: [RFC PATCH v2 07/34] lsm: rename ordered_lsm_init() to lsm_init_ordered()
Date: Mon, 21 Jul 2025 19:21:10 -0400
Message-ID: <20250721232142.77224-43-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1352; i=paul@paul-moore.com; h=from:subject; bh=VkDqekEGooACbobTsF+ofijOUXBUL1lObHTgsHIPDUQ=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsuizBpilSTgtAAg2jEdeFOazNsypDwk13CHZ YdeCuv4DUSJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7LogAKCRDqIPLalzeJ c1ROD/4xhNOREvykj2e3Vy4j6gClYsRDPmXq1eFmZ7Gs2VmiSVu9To6+Ynlneal5RwPaXkbibCH 1J4t9v6WtgLjXqIolWsdzyw4XNfTvKAUtfhebmLokZoZTfpRvLTOwfKH4LCzcjg0FoppAeCZFTZ r7o1QSPbwR7V8NFNG2fW+osxicyi/eRZkcsSLNLU7MgjEVap+SYZVrdhJVw2KvgWoPsk2qlUTDi 4pL8jaK1MIoyERvxaWWH5HyoEMBsZbOnL+637YjkTroMXVT3KkmFVjfAyANoZEOYZti/SiUrjgB Ly31I1bTb8S2lu+FPDKtEKQmFqmRZkB+gcZl35HAsYSJOT/D3vUgFJqnQbKV9N1w+rhwxszzm40 h8rPJUJUHQZjptwMluPJnB9cU0k5P4reRsiv3KvYC5Lb9xn1qTdqd1oi2tZ87Khl3RBuFEZSbkS qgznvHQCKHp92Avl2ZLmzIwS/9bg6s5jjC8ajF1wN2tjfdZuhKbsCSNBOEPthwQmygO1KFB6NWp tQV8H/yp0HSaQQrNlr6Y00ZggE8tT+uXHtEGXOzpSL6pQg+5s7KFJZT7JchIvLmlolf8ZrgSTxD ZbXaMjMLySO77HUtIM6b9BRbUiFsvjtHhDKIMDY5FlevaJC7Hoqn1l79JUvwF4LtyF2WEjAp1PB ZNWWRBB+bm5Q3sg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

The new name more closely fits the rest of the naming scheme in
security/lsm_init.c.  This patch also adds a trivial comment block to
the top of the function.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 7e736c20458a..c8af26a6ce14 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -288,7 +288,10 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	kfree(sep);
 }
 
-static void __init ordered_lsm_init(void)
+/**
+ * lsm_init_ordered - Initialize the ordered LSMs
+ */
+static void __init lsm_init_ordered(void)
 {
 	unsigned int first = 0;
 	struct lsm_info **lsm;
@@ -336,9 +339,6 @@ static void __init ordered_lsm_init(void)
 	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
 	init_debug("bdev blob size       = %d\n", blob_sizes.lbs_bdev);
 
-	/*
-	 * Create any kmem_caches needed for blobs
-	 */
 	if (blob_sizes.lbs_file)
 		lsm_file_cache = kmem_cache_create("lsm_file_cache",
 						   blob_sizes.lbs_file, 0,
@@ -492,7 +492,7 @@ int __init security_init(void)
 	}
 
 	/* Load LSMs in specified order. */
-	ordered_lsm_init();
+	lsm_init_ordered();
 
 	return 0;
 }
-- 
2.50.1

