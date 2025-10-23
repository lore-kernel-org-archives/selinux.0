Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8106C30C62E
	for <selinux@vger.kernel.org>; Thu, 23 Oct 2025 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219029; cv=none; b=S0Z3qTavO/Sivpsc4PpO0Lhgysi99TGXpO+opWEb8yBkIf0tjo3AeSVIME2sD58GwCHqB+AyAd9MmeSqPqDo8Ad0g4A4MANkwnISVVjmhb4NCLXFTFL41Tno1qn4LEyQbN15/bP4C0avLteaNC5rgduQmso8QOJ/K0ma2zQnGQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219029; c=relaxed/simple;
	bh=g1DU7d94xMAyLBEjLrv5eEgZmKZsihsLzGHxYVkc4e4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjFmlN8qiLMi1LbB4okTOX4Xm0jD6LrRjBK6QllfiA6mijgrv9fiw1jG8ZGEFnL/tpotflvLAJaZ15zR8rtFUM0kZNctv1sb47pR2C812hTG97gQsTJ03H4hKCMgSf3M+K36z/QNAd+1a3uuJC0QvdEc0o+XXOKPPpvTHMwjepw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZCJ0Wo3; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZCJ0Wo3"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7a27ab05a2dso347119b3a.2
        for <selinux@vger.kernel.org>; Thu, 23 Oct 2025 04:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761219026; x=1761823826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLppwfFWUo1tq7Snl3tWff6m26kvcM/wx2BRdiKXXcI=;
        b=NZCJ0Wo3XD3NZYME7JarAHy4BMt82k0z1eTVAia4CSl6v+/S6h8DQvSOn1yvgU6o3i
         6pUDP6vNTi6+ALik5WlQ+owfhSdIjqmvHePAyH0Y96x78Y2nMdalySQgzQAnfuZnnQeB
         tWeJD8Us5vix9ztiyEswKI6qWlA72XJ8pveluDxqFkIJ6oTXJgD1xY9r+R0RoV73moR7
         qJKQtB/4IqRc4EPxBpd1bFP9rFrJFNu3Dhne3Wz6D4BIV4Z2N7bUyQUzWgn5oJG/hT/N
         DejBD/eDoPb5k3Fo4PU9qgVRlI1aDX8WbNrNxvCz4aWzbu7Lnl6/aHs46EHSn5OuriZO
         TcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761219026; x=1761823826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLppwfFWUo1tq7Snl3tWff6m26kvcM/wx2BRdiKXXcI=;
        b=fgsCMYGajHSLAJYkMDOEpqOb+/0yNWOzGmi4vRMsLyw9o2CEuXVPqMdnuEWCFaw0fA
         tIOQgkWndehspU3AESxEcrom5lWdxKNvNeFwud9BO4WZ/3tbemNwdh+OMx8k3ARwK/DA
         d4vKxTinFk+X5dh/OXmZYOprZWusf73gY7CZsXrc0JS0MKRGF/NC+o2nvmCxYfW7umRi
         Fo7VDjbyFhmnNgFE4taxWj7VLChzY+KltMAxz2BS7/mLr94CkAq9tztqFw5rzhYcx8Pl
         j0LMXyprKnnTaqRHkHhcdXGDwkbBgyemdrnZEkG2fESIp2ZAd1lwvRQh+f/IFcWIuplP
         RhyA==
X-Forwarded-Encrypted: i=1; AJvYcCUTIu87EXb737efcm2iloU9mCLTMObq1pUGb7DG63FvyGQSUTPcF7NFowBJgD77T4HZWNKaOUv3@vger.kernel.org
X-Gm-Message-State: AOJu0YyzvG320qn0Tk+3xbeKemfcGzXpLWzaHU/RmKWD2mUjUBN659+r
	B5R4pzgSlDVLLDeC6NKQpCZsB95fuhosltkmNiGFDc2AUZOTXItrKjBB
X-Gm-Gg: ASbGncu4Jc0HiUKt2kWN4b1KJ0YnEMYjRBYphJeKdCWd+QBsXeeNoqo/yGQLiGtdBRe
	w87VT6Ngnj7l0ZOcN1VXgoBQccW+gNUB06sESXaRNM8S5S6gV0hEumHUt4ssB6OW0i0UAF/hT26
	KS/w5cZlb6GxO9FFewAH8dudv0xqy3PYgh96iRYkOGxErsTBJcbM4Xrdb5RrfLAP60aU0xxsiP4
	jDeuhC39a8P6DjQY6C0gLZwNY1mim4H5BPp7dzyHyzxvp8aNAqNagmYWWjyuReiCL6rmtqAVjse
	euYS9onXwTnQ9kR4kpl2Zmuk588imJ5b1GiLbEvpgZPDngcE5LQcT4TiaiuE4cR6S+6dmRZgko8
	jHcI+fQq2mx5KmX+kVAVTXRj2T0Nntsy7rjQW8N1coCsdrue826AUUNc6euLhMIcW7iB6j1sMkV
	mdQ+wL7aboA9c0RuX799l60czSDzTQ4ru5seQnuhc=
X-Google-Smtp-Source: AGHT+IGVxKcixynlh26jYNQh04/DlYMvYZG4vx+TykiwHkcLG3w5tzvnhnluh27LHDoEaKYdepQqUw==
X-Received: by 2002:a05:6a21:3289:b0:2f3:b278:eaa5 with SMTP id adf61e73a8af0-334a862dffcmr29150670637.60.1761219026204;
        Thu, 23 Oct 2025 04:30:26 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4e0a42fsm1834429a12.25.2025.10.23.04.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:30:25 -0700 (PDT)
From: Hongru Zhang <zhanghongru06@gmail.com>
X-Google-Original-From: Hongru Zhang <zhanghongru@xiaomi.com>
To: paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com
Cc: linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org,
	zhanghongru@xiaomi.com
Subject: [PATCH v4 3/3] selinux: improve bucket distribution uniformity of avc_hash()
Date: Thu, 23 Oct 2025 19:30:18 +0800
Message-ID: <4bf4246da1ad44670093e006bffd3c9e07f089ea.1761217900.git.zhanghongru@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1761217900.git.zhanghongru@xiaomi.com>
References: <cover.1761217900.git.zhanghongru@xiaomi.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongru Zhang <zhanghongru@xiaomi.com>

Reuse the already implemented MurmurHash3 algorithm. Under heavy stress
testing (on an 8-core system sustaining over 50,000 authentication events
per second), sample once per second and take the mean of 1800 samples:

1. Bucket utilization rate and length of longest chain
+--------------------------+-----------------------------------------+
|                          | bucket utilization rate / longest chain |
|                          +--------------------+--------------------+
|                          |      no-patch      |     with-patch     |
+--------------------------+--------------------+--------------------+
|  512 nodes,  512 buckets |      52.5%/7.5     |     60.2%/5.7      |
+--------------------------+--------------------+--------------------+
| 1024 nodes,  512 buckets |      68.9%/12.1    |     80.2%/9.7      |
+--------------------------+--------------------+--------------------+
| 2048 nodes,  512 buckets |      83.7%/19.4    |     93.4%/16.3     |
+--------------------------+--------------------+--------------------+
| 8192 nodes, 8192 buckets |      49.5%/11.4    |     60.3%/7.4      |
+--------------------------+--------------------+--------------------+

2. avc_search_node latency (total latency of hash operation and table
lookup)
+--------------------------+-----------------------------------------+
|                          |   latency of function avc_search_node   |
|                          +--------------------+--------------------+
|                          |      no-patch      |     with-patch     |
+--------------------------+--------------------+--------------------+
|  512 nodes,  512 buckets |        87ns        |        84ns        |
+--------------------------+--------------------+--------------------+
| 1024 nodes,  512 buckets |        97ns        |        96ns        |
+--------------------------+--------------------+--------------------+
| 2048 nodes,  512 buckets |       118ns        |       113ns        |
+--------------------------+--------------------+--------------------+
| 8192 nodes, 8192 buckets |       106ns        |        99ns        |
+--------------------------+--------------------+--------------------+

Although MurmurHash3 has higher overhead than the bitwise operations in
the original algorithm, the data shows that the MurmurHash3 achieves
better distribution, reducing average lookup time. Consequently, the
total latency of hashing and table lookup is lower than before.

Signed-off-by: Hongru Zhang <zhanghongru@xiaomi.com>
---
 security/selinux/avc.c          |  3 ++-
 security/selinux/include/hash.h | 11 ++++++-----
 security/selinux/ss/avtab.c     |  6 ++++++
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index c12d45e46db6..8f77b9a732e1 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -30,6 +30,7 @@
 #include "avc.h"
 #include "avc_ss.h"
 #include "classmap.h"
+#include "hash.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/avc.h>
@@ -124,7 +125,7 @@ static struct kmem_cache *avc_xperms_cachep __ro_after_init;
 
 static inline u32 avc_hash(u32 ssid, u32 tsid, u16 tclass)
 {
-	return (ssid ^ (tsid<<2) ^ (tclass<<4)) & (AVC_CACHE_SLOTS - 1);
+	return av_hash(ssid, tsid, (u32)tclass, (u32)(AVC_CACHE_SLOTS - 1));
 }
 
 /**
diff --git a/security/selinux/include/hash.h b/security/selinux/include/hash.h
index 5b429a873eb6..18956dbef8ff 100644
--- a/security/selinux/include/hash.h
+++ b/security/selinux/include/hash.h
@@ -3,10 +3,11 @@
 #ifndef _SELINUX_HASH_H_
 #define _SELINUX_HASH_H_
 
-/* Based on MurmurHash3, written by Austin Appleby and placed in the
+/*
+ * Based on MurmurHash3, written by Austin Appleby and placed in the
  * public domain.
  */
-static inline u32 avtab_hash(const struct avtab_key *keyp, u32 mask)
+static inline u32 av_hash(u32 key1, u32 key2, u32 key3, u32 mask)
 {
 	static const u32 c1 = 0xcc9e2d51;
 	static const u32 c2 = 0x1b873593;
@@ -28,9 +29,9 @@ static inline u32 avtab_hash(const struct avtab_key *keyp, u32 mask)
 		hash = hash * m + n;                       \
 	} while (0)
 
-	mix(keyp->target_class);
-	mix(keyp->target_type);
-	mix(keyp->source_type);
+	mix(key1);
+	mix(key2);
+	mix(key3);
 
 #undef mix
 
diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 15e89d9b5d72..7d44b546ab45 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -25,6 +25,12 @@
 static struct kmem_cache *avtab_node_cachep __ro_after_init;
 static struct kmem_cache *avtab_xperms_cachep __ro_after_init;
 
+static inline u32 avtab_hash(const struct avtab_key *keyp, u32 mask)
+{
+	return av_hash((u32)keyp->target_class, (u32)keyp->target_type,
+			(u32)keyp->source_type, mask);
+}
+
 static struct avtab_node *avtab_insert_node(struct avtab *h,
 					    struct avtab_node **dst,
 					    const struct avtab_key *key,
-- 
2.43.0

