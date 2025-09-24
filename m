Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE9D221290
	for <selinux@vger.kernel.org>; Wed, 24 Sep 2025 02:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758682563; cv=none; b=KySmdZYCw20bFnekxFcYU7PK7P13wULpD70V/FOLsnxwMUbkQtzzZlCLvbdB6uoxZZW8/FLHrwDSq8bSFF2oW/hEcNzwLZeuHcjiv2mZ4vHXR4MwWY+ebuM+AT5qVa4fiVKrB4z5QQJNKJp5kgaB7KtwXRMRF6isPOdbxyvZnI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758682563; c=relaxed/simple;
	bh=LP1aZBun3+jkx15ojdj7Rjv65YT07JMoONCYxkI1Gow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4hqxsffgJL4hH7b94JXZTdVTh/Gc/jJ0hb6MEwBWaXeCYSVGd1Uo2h+TciALmeQZoVJM7zJd7yTJ1W0m7kgTd/W/210Uf0SefHGu3RPRkUpd7A4Ke/inWXlMzj0H7Cb0loj4AXJJ/pFHg7dFsegGLI/uqBL2m2GuRcW7yf37rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmylvc5F; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmylvc5F"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-77f68fae1a8so417397b3a.1
        for <selinux@vger.kernel.org>; Tue, 23 Sep 2025 19:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758682561; x=1759287361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMRETXGFwNVU6M9wzPozyz3115l+hikl117Pr5fgesY=;
        b=nmylvc5FW7xoGzJxyEwoyPrwZH7RtfR9YNnob3HIx8ud1izMxnCTVa+ZAqqOUOy5xa
         Qxj+MQ3kIecTrlVbdNxWN+lX85hcdrR+07yamutM9tlbGl6tIt6lEQuhHD7e92812FVU
         AK8Vxxl8/9GsCnV21dpYgpUIR2lON58ZgwyrpSlElU3ocYcbOcn7dJkmQoQJHbNfAvIA
         2pGzOBwvwcrlGElbs1vbJ03G7IEeLuM49JJAdZHFYYkuP7mwdJySKlPiqsCHiRmhN5Ib
         qCdvzRJOrNDW3pWnMxHA8+PB0Wa/9fAKfNaRJ8ADHK2ANAElLJkqQaPLLOL96XC09hmB
         UhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758682561; x=1759287361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMRETXGFwNVU6M9wzPozyz3115l+hikl117Pr5fgesY=;
        b=DWASZQ/QHjNEDf1L4yIkN2+HaqKwixxRW386Hw+KqaNrMsgcF8PmQo8r6DQDGw/82a
         F0brO6ELgGWuLfzZbDvXwQahiug/IMZucE36sp8acUUhhUf8JWM7IOs4ZG43EqFKxNzm
         X7BLVHdyPzxKNb0IyUq7qIYreKOulDbx06TO50R+h4uyD4+k7b0xBp+LQ93/EefcGnxs
         0/qq/lBLFyJGoBnpGAHnh1i6P25EdiYMBOa8hIr4ANjO4Ce7vzRGnH74JRvkfGo/HyKC
         rlkVfmqr5uAIBlv/j6V90A88a+uv0r8TOLmBT7UCYC+2MXNYplLZaPoWb0oBRGDByc3a
         WQVg==
X-Forwarded-Encrypted: i=1; AJvYcCVifuRsmAdglkOT+H/hERRqQpGaX4mi4i3t0DPpUxmEoYSQ0H162E7zYrtzLykJaAVjkefqkfZL@vger.kernel.org
X-Gm-Message-State: AOJu0YyXuS3USFK1do6nHPUBYfCf6UwyTtXEuBsWYVlxOD8DmeLwT6Ao
	0x6H9yIAxW3kgOhfhEYw45MKNT8iV8jF5x9o94IXoUorT1q3G58Z+v43VIlga0K+
X-Gm-Gg: ASbGncux2ZNT9cQc84gAkAXm5c9RnxQS3K1ZvftEgj9FpncOu49xSxACzxN++hcgf0k
	r7/H5NkipLiB8/Y0GuPqWI0A/hhzD7Xkyx5VkPorB7QcsepafSGwtIRL3gsrermsiGgI3/cQbMd
	j25F0ubXWrsaeMNPgWzD4gKXuHjmby/4i1Y/8TjpyZUOI6J49f93+5zk6zgVQ5Xtiv/ITxDPicI
	vV6HL3zflWVmd0Nnv0m5CzO3NRo+qU5W0g422mzt+N87mI6kjc7Q59Dq4sukxKmHYt6t2obcoCH
	kd3sujNJ0YBLsjeKmT/wE9X88HoKehaQCB2rnyBnWJQ1WN61QSAxHkOBt0j0rU46aUCdeinn3OO
	cfvKZxKk4NSNbysAAkinxOQoszfGcH6IVqMV0VYPLm/OOp42L25c=
X-Google-Smtp-Source: AGHT+IGLsfif3M4Ae4fPfWq/9xMybr4m101+Ydzhkc+JwMmsr4jfwrdsMRN2wX6BznHZWqUGI72+hA==
X-Received: by 2002:a05:6a00:228b:b0:772:5513:ba3b with SMTP id d2e1a72fcca58-77f5388d637mr5388097b3a.5.1758682561472;
        Tue, 23 Sep 2025 19:56:01 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f613dbc5csm1619042b3a.59.2025.09.23.19.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 19:56:01 -0700 (PDT)
From: Hongru Zhang <zhanghongru06@gmail.com>
X-Google-Original-From: Hongru Zhang <zhanghongru@xiaomi.com>
To: paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com
Cc: linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org,
	zhanghongru@xiaomi.com
Subject: [PATCH v2 2/2] selinux: improve bucket distribution uniformity of avc_hash()
Date: Wed, 24 Sep 2025 10:55:53 +0800
Message-ID: <5188e81963654bbe9d1e70fe6370a38fdf4ae677.1758633723.git.zhanghongru@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758633723.git.zhanghongru@xiaomi.com>
References: <cover.1758633723.git.zhanghongru@xiaomi.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongru Zhang <zhanghongru@xiaomi.com>

Under heavy stress testing (on an 8-core system sustaining over 50,000
authentication events per second), sample once per second and take the
mean of 1800 samples:
+--------------------------+-----------------------------------------+
|                          | bucket utilization rate / longest chain |
|                          +--------------------+--------------------+
|                          |      no-patch      |     with-patch     |
+--------------------------+--------------------+--------------------+
|  512 nodes,  512 buckets |      52.5%/7.5     |     58.2%/6.2      |
+--------------------------+--------------------+--------------------+
| 1024 nodes,  512 buckets |      68.9%/12.1    |     82.4%/8.9      |
+--------------------------+--------------------+--------------------+
| 2048 nodes,  512 buckets |      83.7%/19.4    |     94.8%/15.2     |
+--------------------------+--------------------+--------------------+
| 8192 nodes, 8192 buckets |      49.5%/11.4    |     61.9%/6.6      |
+--------------------------+--------------------+--------------------+

Signed-off-by: Hongru Zhang <zhanghongru@xiaomi.com>
---
 security/selinux/avc.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 7a7f88012865..d08f30d57bac 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -146,9 +146,23 @@ static struct kmem_cache *avc_xperms_data_cachep __ro_after_init;
 static struct kmem_cache *avc_xperms_decision_cachep __ro_after_init;
 static struct kmem_cache *avc_xperms_cachep __ro_after_init;
 
+/*
+ * Advantages of this hash design:
+ *     - Minimized collisions: Different inputs won't produce similar
+ *       contributions
+ *     - Bit diffusion: Each constant effectively scrambles input bits
+ *     - Mathematical guarantee: These constants are theoretically analyzed
+ *       and empirically validated
+ *     - Complementarity: Three constants complement each other at the
+ *       binary level
+ */
+#define C1 0x9E3779B9	/* 2^32 * Golden Ratio, classic constant for Knuth's
+			   multiplicative hashing */
+#define C2 0x85EBCA77	/* Large prime-like properties */
+#define C3 0xC2B2AE35	/* Large prime-like properties, MurmurHash3 constant */
 static inline u32 avc_hash(u32 ssid, u32 tsid, u16 tclass)
 {
-	return (ssid ^ (tsid<<2) ^ (tclass<<4)) & (avc_cache_slots - 1);
+	return (ssid * C1 + tsid * C2 + tclass * C3) & (avc_cache_slots - 1);
 }
 
 /**
-- 
2.43.0

