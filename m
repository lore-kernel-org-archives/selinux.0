Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A8B30E843
	for <selinux@vger.kernel.org>; Thu, 23 Oct 2025 11:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219004; cv=none; b=KLvVvsDhMaEOUMNlMPhN5FM4kOpbn5NxA9NXjSAtxu/hnHoSXBAa0afkLqqZ50TJHv141EyQYzg/Poh/HNAxz/T+e6Rw5zfEV/NpsGC8n0GqRtnzTDWeTiTxxG0rc4H82yKiioQAfPTaoe3bdUKp7U89cwp4tLDNoRofS5jfI1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219004; c=relaxed/simple;
	bh=3cmcw6O1JT0q/DZK1ZW/J4/7wvV5/ihiGwU0wWyX6Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWsNs8zUXdFCHgqrlu81uTes1W7Dq3of77H66WcEXj8POlmAdOtqJe7XMtsuDl6I1wxPEcP1FkRXmJzS3kU6giKmMv5fxXU5lnrb0T0dRhTM0hP06ojzPTTElb70RPmjuLYzsM0PgPsQYqW5jp1uHHHnsO4JtMGoDTrQpXA1H8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2bUaFvL; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2bUaFvL"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-292fd52d527so7465215ad.2
        for <selinux@vger.kernel.org>; Thu, 23 Oct 2025 04:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761219002; x=1761823802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSSwZBbOhzicOHkC0jzyAmVpir4bL5Qo+D6Q4ZcG14k=;
        b=R2bUaFvLpFNhPZwz42gjuqlGRXbFYIhh/po0QtjkHUSvtjaUOiTz1YCh/2OK2LSDKT
         CnnO6PVPnVG1RYVQJDHn7quJx0m3uAlxjPJC4tbDI3RnyCqPwn7G9P8bV0pCOnLwSCyt
         PdIsPogjtou4RytBBqPdKEUhDHnRdo6U/AGcmJQXs14I3xycS0vZUyZruWwWv1fYWACf
         vAKFOSa6HVaHIt55vpx47F2To06igH5XE/kbBzyAWpCPnbcpln127SXd2NW8sEVrJUQ0
         geK90wKxCBRxV6CA6J9D6Mv2WvnB+JpwhOBl14RiQTlh9zkr2SuCh/RXRX5JdYjVmm7U
         PcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761219002; x=1761823802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSSwZBbOhzicOHkC0jzyAmVpir4bL5Qo+D6Q4ZcG14k=;
        b=PYioHHKzcaUCayKMqK/J5GZ1Xqpni1SV/q1i95XTzSJbs8oGtpzqw2kw3lQ8rerSev
         H2Z+0BLCm/T7SOHps/ybUeDN0tw12+/qSnv6qJpIAkLcuT4iTiZa6xgmnMIocHmgzZwg
         vIDinIe4dL6M4/wGB4SbPIk04N7/ThQ8m3SJWEzC8y2XoHpCyCpE5FhRId9CfuOjyts7
         qMC3x7HMWwuuNoY126PFcTrV12UYMte1CzcghqO9DVt0GqjMdysZZN17FxnbCL3Ob3bj
         0nTKmZIQaVkNUoxRzXHQmKnd8cVztxg1nqjXHoTTk7miOJVICA0aoWoOH422Hy1vCNMJ
         b0Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXJuBpgvbgBnSHxK55hUsVDDh3tg/CVpCuiK1p6ephrx3gF7GPMecUtUelZjJ38NvUYqx5v3XDW@vger.kernel.org
X-Gm-Message-State: AOJu0YwJbI7Dt0KEXTbwbEaRxY53Fd3zSEl92F69QkuZmbOcsYDIpAh+
	mJyvCVyzT6LipOsv9yQOZ0Qsy/1LlcJM5zcHeVRyndoV0b9F1fskKiwd
X-Gm-Gg: ASbGncuzToLZb4RGZfodrN0VJjs8mRX8FgTt9zuAYcU++v30iKsz5ROYYr65yGb0bag
	wPoXfYm43+cb1clPzrVsNd6zjjsoVONMajwH1me0JBLhhup81StqmZHj6uTHJceVXnn2bTrhUU5
	ZwGlrjfQ9Nq8jQJwDHxkjcxDb6LHheQg5oQWTYbyuRbsEAibW936bACAcItn/71VXa7cJniNDQY
	P5lNJK1GrjIb9eluJYKVyN0U2HvuLzhPMlEIYRHJC3y06BJXqkX4Rj5E3ewBDxcOLKuxDqGg1wd
	Zn1gRiZ+5rcu0D3BM2mX9KsaPw0bZUDBHtgJP5Hdq1szfMCrFY5EApejFT4HpgCxVKC1RltiUeJ
	imvLMD60Vobs9IfBYayyEGdgohGgA2U0fS30mjgfXVuaIR6niHsJ9dweZJhy99jR5P3VQn69B5M
	keDb0Jm/tSrqOAzxoWzCxPpVVO/tL+lz4ObFQgvT8=
X-Google-Smtp-Source: AGHT+IHq/+kXGc2/fBqgPUCYCUQAWCMlK3uONwZTn9qBtZxs7snqnVTZyF//ylvAIdgH0uG3mnHE3w==
X-Received: by 2002:a17:902:e743:b0:290:ad79:c613 with SMTP id d9443c01a7336-290cb27c76cmr298740505ad.47.1761219001668;
        Thu, 23 Oct 2025 04:30:01 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dded613sm20473685ad.37.2025.10.23.04.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:30:00 -0700 (PDT)
From: Hongru Zhang <zhanghongru06@gmail.com>
X-Google-Original-From: Hongru Zhang <zhanghongru@xiaomi.com>
To: paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com
Cc: linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org,
	zhanghongru@xiaomi.com
Subject: [PATCH v4 2/3] selinux: Move avtab_hash() to a shared location for future reuse
Date: Thu, 23 Oct 2025 19:29:54 +0800
Message-ID: <a878f27f8148bb4cc662755f6e69400632183477.1761217900.git.zhanghongru@xiaomi.com>
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

This is a preparation patch, no functional change.

Signed-off-by: Hongru Zhang <zhanghongru@xiaomi.com>
---
 security/selinux/include/hash.h | 46 +++++++++++++++++++++++++++++++++
 security/selinux/ss/avtab.c     | 41 +----------------------------
 2 files changed, 47 insertions(+), 40 deletions(-)
 create mode 100644 security/selinux/include/hash.h

diff --git a/security/selinux/include/hash.h b/security/selinux/include/hash.h
new file mode 100644
index 000000000000..5b429a873eb6
--- /dev/null
+++ b/security/selinux/include/hash.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _SELINUX_HASH_H_
+#define _SELINUX_HASH_H_
+
+/* Based on MurmurHash3, written by Austin Appleby and placed in the
+ * public domain.
+ */
+static inline u32 avtab_hash(const struct avtab_key *keyp, u32 mask)
+{
+	static const u32 c1 = 0xcc9e2d51;
+	static const u32 c2 = 0x1b873593;
+	static const u32 r1 = 15;
+	static const u32 r2 = 13;
+	static const u32 m = 5;
+	static const u32 n = 0xe6546b64;
+
+	u32 hash = 0;
+
+#define mix(input)                                         \
+	do {                                               \
+		u32 v = input;                             \
+		v *= c1;                                   \
+		v = (v << r1) | (v >> (32 - r1));          \
+		v *= c2;                                   \
+		hash ^= v;                                 \
+		hash = (hash << r2) | (hash >> (32 - r2)); \
+		hash = hash * m + n;                       \
+	} while (0)
+
+	mix(keyp->target_class);
+	mix(keyp->target_type);
+	mix(keyp->source_type);
+
+#undef mix
+
+	hash ^= hash >> 16;
+	hash *= 0x85ebca6b;
+	hash ^= hash >> 13;
+	hash *= 0xc2b2ae35;
+	hash ^= hash >> 16;
+
+	return hash & mask;
+}
+
+#endif /* _SELINUX_HASH_H_ */
diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index c2c31521cace..15e89d9b5d72 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -20,50 +20,11 @@
 #include <linux/errno.h>
 #include "avtab.h"
 #include "policydb.h"
+#include "hash.h"
 
 static struct kmem_cache *avtab_node_cachep __ro_after_init;
 static struct kmem_cache *avtab_xperms_cachep __ro_after_init;
 
-/* Based on MurmurHash3, written by Austin Appleby and placed in the
- * public domain.
- */
-static inline u32 avtab_hash(const struct avtab_key *keyp, u32 mask)
-{
-	static const u32 c1 = 0xcc9e2d51;
-	static const u32 c2 = 0x1b873593;
-	static const u32 r1 = 15;
-	static const u32 r2 = 13;
-	static const u32 m = 5;
-	static const u32 n = 0xe6546b64;
-
-	u32 hash = 0;
-
-#define mix(input)                                         \
-	do {                                               \
-		u32 v = input;                             \
-		v *= c1;                                   \
-		v = (v << r1) | (v >> (32 - r1));          \
-		v *= c2;                                   \
-		hash ^= v;                                 \
-		hash = (hash << r2) | (hash >> (32 - r2)); \
-		hash = hash * m + n;                       \
-	} while (0)
-
-	mix(keyp->target_class);
-	mix(keyp->target_type);
-	mix(keyp->source_type);
-
-#undef mix
-
-	hash ^= hash >> 16;
-	hash *= 0x85ebca6b;
-	hash ^= hash >> 13;
-	hash *= 0xc2b2ae35;
-	hash ^= hash >> 16;
-
-	return hash & mask;
-}
-
 static struct avtab_node *avtab_insert_node(struct avtab *h,
 					    struct avtab_node **dst,
 					    const struct avtab_key *key,
-- 
2.43.0

