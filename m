Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C3E19E7F9
	for <selinux@vger.kernel.org>; Fri, 26 Sep 2025 06:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758867822; cv=none; b=QlJclAht/xOWcU7TmjDjabukhDY/sdKWDrwPrtKWx0RsD0wpBKFfv6pOW82+XsY+yfKj4cUn2De/8msMCYYFeRauRE7nBoJXu4K4WrkuKzq1AX0kHF/2AdyDVl5XA6dV1cJmjLmm/Up+xVLL4tPNChNo90R4Y6b9JxxEfXthkzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758867822; c=relaxed/simple;
	bh=u6Sq2YURwtuu5QNEEMlKl7xX/uAJZnHBmjr5auxbeg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CimH2VxC7bHdeuTbvK8FYcOgEmsjKX8r2WQmGHDxTu/ypAKhZkKPB1MzaU0me9LQ/tnzw0lJ7Fa8/DA1KNDDuVfns4dVGfz0LVLWsEDP2FewLXHxKhjvDCZw9abnzAyvt1reV719Zp5i2KUFFB43Ha1u9QEiMCMgdpFaztohPkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAqJU7u/; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAqJU7u/"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-27ee41e074dso11435005ad.1
        for <selinux@vger.kernel.org>; Thu, 25 Sep 2025 23:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758867820; x=1759472620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+IWmkPAlMQiBvEu/U0MvJdvKLaUfjFQa+8mon/ZBiY=;
        b=OAqJU7u/21pfPzvaNE3Epov7BHffzNaL6Uoe3nRutQsaq6BL1pFFv70v3Ac3xZlGUO
         L37/zEPR9sMrjEyk0jQ/lX/iNvaMdyZUDoxZ40UqDb1uVDp2KTq3J4TTxwf9Ti3RB/q9
         j9Prubd0l76GWkjdW6WPfoPEwTqCB3ImGwtcKy2uAOVamHPnis+/boeCYrZ1oXrDSsh6
         eqZFAZJ8u9MzO7b2RHxuUW4Qxz+FQxUwj++X8YI8nZAM10O049JryjX6g+Qd07Bs4hk/
         la5O/0VXEUySt13VhbAeligm7sP+EkLWubEGvIjnUX1MWZsd73yrkHlOoW4noYiXjRmg
         vR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758867820; x=1759472620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+IWmkPAlMQiBvEu/U0MvJdvKLaUfjFQa+8mon/ZBiY=;
        b=vd7Ajt0HbWU/5Bsc9sS7/c8STlhH1WOTfnZ+0gUBq4Cl2kxrGYB4Ce7MeHOiQk3nMG
         pwu51ne0YlwxK54lgc/Ujkd5riZ3SdBsPGKml9ul9S7Pnp3pt0/PRQ76dy0NqTPV2DTY
         rWhG4TvPMtiD6aGK4qqPfdrugbaTHDT34PMgrtmLtWBzwEs8rJH6Amez340hsBkbZHpn
         pOKpHYlrTtZ8DZZLGkBUKXzsPzIva4DhjtQ1x5cYHlr1gX0DADm5+MFhaMkRkcaSZR/I
         feAYjHMixZGSU1GEFaHTs8y85BolxUK8wgs8AUeZk+XrI+vDg6WG3DfmN1pEgJlvjIPF
         9c7g==
X-Forwarded-Encrypted: i=1; AJvYcCVkHCFU05FatnB6PHaqpqqAZnytDW7EH/hp+Wn+cUPz4X8bepgHcL2pPQpXaeF4C2heIrKno/9D@vger.kernel.org
X-Gm-Message-State: AOJu0YwuSOiS09s8nhXKzFwrWCYS7FUmC4DsLPK19xH8PbVowrInxQQX
	4UQ+uNjTjfAAQQCo+wRWyctJpjrhgotSuLJETF8vnRgokZeLvhSpXp+v
X-Gm-Gg: ASbGncuZD1tWKAzTwxKLYoeHLPztyw0zOuVgYmt5R0xC/k/pUFAIM1VDWUIjAZhFqNd
	oFGS1yvJaE0qdMIBzr+anHDsN5/gkD6XDSDnMpCSzxmQfmtEUxXbipUPXx6TbgEYAzXe1jmRWMp
	lZcDHln98tSyUtJi645YGejj1SKZ3WPmXiFjKMQqh5RHT5fIGoVznM13/qwiebJ6v+WzYTKYaqb
	q+TVE6/2lWjc0LnFcqxqzGVPbhYPmr2manjGQqz7cV1ZZd7WSTnPuLvdMjlnHHwrlxjcvqCXIEx
	3yZDT5oICe7vfDuv4NcvBFSiQPc3GJ36FCFefJaNT7m3SzaSwe4ksOdtH7lGjvIREVFHEHllkpm
	epMkfjPyr/L2AzqWfyKLhh4hXaltE3DssY/zZa3hSGDtj6IQY41I=
X-Google-Smtp-Source: AGHT+IGMdkjfopWJVTl5U8eSEKamt5UYh2lxs0dBr+wzV2Rf8C6wXp6A4BGv3sEN+utd4O11ehuJeA==
X-Received: by 2002:a17:903:37cf:b0:27d:69de:edca with SMTP id d9443c01a7336-27ed4a16b89mr67720485ad.13.1758867820429;
        Thu, 25 Sep 2025 23:23:40 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69ab0aesm42856845ad.113.2025.09.25.23.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 23:23:40 -0700 (PDT)
From: Hongru Zhang <zhanghongru06@gmail.com>
X-Google-Original-From: Hongru Zhang <zhanghongru@xiaomi.com>
To: stephen.smalley.work@gmail.com,
	paul@paul-moore.com,
	omosnace@redhat.com
Cc: linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org,
	zhanghongru@xiaomi.com
Subject: [PATCH v3 2/2] selinux: improve bucket distribution uniformity of avc_hash()
Date: Fri, 26 Sep 2025 14:23:33 +0800
Message-ID: <000bce8f11d06684f70a29705dfd417747475b1a.1758859391.git.zhanghongru@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758859391.git.zhanghongru@xiaomi.com>
References: <cover.1758859391.git.zhanghongru@xiaomi.com>
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

1. Bucket utilization rate and length of longest chain
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

2. avc_search_node latency (total latency of hash operation and table
lookup)
+--------------------------+-----------------------------------------+
|                          |   latency of function avc_search_node   |
|                          +--------------------+--------------------+
|                          |      no-patch      |     with-patch     |
+--------------------------+--------------------+--------------------+
|  512 nodes,  512 buckets |        87ns        |        79ns        |
+--------------------------+--------------------+--------------------+
| 1024 nodes,  512 buckets |        97ns        |        91ns        |
+--------------------------+--------------------+--------------------+
| 2048 nodes,  512 buckets |       118ns        |       110ns        |
+--------------------------+--------------------+--------------------+
| 8192 nodes, 8192 buckets |       106ns        |        94ns        |
+--------------------------+--------------------+--------------------+

Although the multiplication in the new hash algorithm has higher overhead
than the bitwise operations in the original algorithm, the data shows
that the new algorithm achieves better distribution, reducing average
lookup time. Consequently, the total latency of hashing and table lookup
is lower than before.

Signed-off-by: Hongru Zhang <zhanghongru@xiaomi.com>
---
 security/selinux/avc.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 7a7f88012865..fc631d1097bc 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -146,9 +146,24 @@ static struct kmem_cache *avc_xperms_data_cachep __ro_after_init;
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
+#define C1 0x9E3779B9	/* 2^32 multiplied by Golden Ratio, classic constant
+			 * for Knuth's multiplicative hashing
+			 */
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

