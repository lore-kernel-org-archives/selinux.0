Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06015140364
	for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 23:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646389; cv=none; b=nsFSQe/fvC1Gdjuiq3u6DPk0QaTpUydpY1FHK9BZuMLccWXzbMlsGE66sfH3PnGbkF1V6M4eaLa497lQ8i3bQLT2mAMUn5gOGFiiGZpTYo60PxKYnbvMykvRIRJFUMK7UyOD/Zth/HU8fT0UNapLrE6MppJes8TWznmwBkE29o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646389; c=relaxed/simple;
	bh=WcWMOGj6EzXlnXxjWOjbIXFHZT51YtOWAmDHFnbMrw4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqIYhSH7KnTDF5IdlNI2AR4865j6/6tF90hIhoFd9SP+GwIZ4M3RxNG7SO8eDnTe8AFnjhnQvsPEihdz0HqwGPR+U3VGlCMhxvSni3N4iWJD+P5tw/hogsrfmIG6rAO+GuZwiRBImHy4PePgJyFfD3I1lIPyVj4wsa/xyi8XAp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=E/lTGZIv; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="E/lTGZIv"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-68f51ba7043so2484946d6.3
        for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 15:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708646387; x=1709251187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbjtEbXipWVl4XZCnmkxFTAmBVbWul7Lt80nOFerUuM=;
        b=E/lTGZIvNpV+moGaXzqChLsiyBHvcHV/1sobmSmQEb1D7As3QnXK9DZZrQJSr3UL5p
         GSZ+dIWBhKbYu1VQRJeYGuJ7BPEvJ+VZsBsqzBkdC3DnrbWd7K8VxtSmY/6CKNQHXFhG
         ie9IodNzInMXKxbJfIGp8Q0tgQqizFbqtbdZkjDip9OOAa5vcUL4K0VndQfS60BX2rYr
         Q9U6l13ow6en8uSxvLGy5s/Ww2RbtxY5Y7O+oYhe7gTw/qRMcx9yNGVEg+pQRjUp2L7v
         uVvz6MUL1TQjwm1qJhytD2XJ/JDI0c1K6Ccl0GHh+OgbmVyc5ostJCCgDqhKqPO+LX2g
         mcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708646387; x=1709251187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbjtEbXipWVl4XZCnmkxFTAmBVbWul7Lt80nOFerUuM=;
        b=uPks1ZOiczHlg1LImeGulW389mAD7+r0HRPYYOjYyz/tUiGSi9AlGsU93DQEA7d8zU
         epEw+w9hTqAks8ZUl0JHgx9wySvvQipgKPQ4zui2kQ01JVkHg6D7cJ0scqpdoBMbs2si
         fe2VgRCD53jsJxixl9PpEIcls5bPUIGGXwpz07Bqd2hRMrHCnRkAL40bfqIEipN3OKVj
         yZVdUPbGf1dnsv7Xgnp5AXjoXww4gOuGMFLDrZnQ5YWtP89PJdY84OqVc5nttRVAx0MM
         ctNX6AdAtsFUYxS1VuiUXXOAD7cSnLY8JKVNFUyiIx0JrSWik0Vw/2I7WJbC8hfKTKQw
         V9GQ==
X-Gm-Message-State: AOJu0YzQXJnVPKQS0pdPLy2Tzsi/LX9uMHmHD8ld4aJ9ScAHsoJ96KCt
	86ZFaUoJY3exrDklRurgsR6zSxPuQQ46xpZ1JYP6pvE9HNrTQdoBavjVEo1wehLq2rFmjTWJnjI
	=
X-Google-Smtp-Source: AGHT+IFA5+2mvc6EugLdBJwo7w7PJpjIHmXMsCyzehIsrOlrbmqqa/hj4E7MOD6C+5KkozNstjapSA==
X-Received: by 2002:ad4:5743:0:b0:68f:22b1:8e24 with SMTP id q3-20020ad45743000000b0068f22b18e24mr886760qvx.28.1708646386601;
        Thu, 22 Feb 2024 15:59:46 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id ld11-20020a056214418b00b00686ac3c9db4sm7478899qvb.98.2024.02.22.15.59.46
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 15:59:46 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 14/21] selinux: fix style issues in security/selinux/ss/mls_types.h
Date: Thu, 22 Feb 2024 18:52:32 -0500
Message-ID: <20240222235708.386652-37-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222235708.386652-23-paul@paul-moore.com>
References: <20240222235708.386652-23-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2962; i=paul@paul-moore.com; h=from:subject; bh=WcWMOGj6EzXlnXxjWOjbIXFHZT51YtOWAmDHFnbMrw4=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBl19+puZGruday0MFQyUHWsQQzxbxkr+voStNIC ZBZEDvHbjiJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZdffqQAKCRDqIPLalzeJ c+AuD/wNSHz3IOM6OtC/7mopxtcJsVglfzcP0tOP0f197N4/bloHWNpNxCDOPp0yrQ+rGhQy8xe A/K3T9zXhUMzeQhdO+pMKp+Q3+FY3pdacBfB6auKEUZuOzhMirylie1NuOs95DfFmgxPmng+nqO MKdGQoCRb8L3DF0fjrG2kL9SSi0Uo4/kmu5Esek+dFlBc1kh6aCkywgICxmCN/IU12QtqZngCcF urECBl0GbqUK7cg7P/OX1qCPb00ZSum+3PsxRdeOYxAnbzqf+PPwDydL59jpqLGTj6eGk/Gitr1 Bi56ttNnJ6/+LQ6ZbPL/KW7JzbZA8QzHSpWm2y87l4j9UoAClORuaa3RvD0wL/qg4S3183Lpa/O jdguuzbnt5ZDQebCg1JvsqLjzaKfHdRpR4TeIv5KyXLuUa4bBHsvL/kxrD/oiGbbS3uACfKoTv6 Wy9GecJp23RQuNWK0t5kdHwjVf7zRUiZldZAV2By6m0CKm/eLPmpfb+ge4AOuPWwgFVXyfDxV2Y mOjEGFPqx5H69Lp/tbjFwhwmddLZVrVArsIobXwUbFa44mAwTYO4wGVUZOmK9dJsOL/B3ZC7Ivf Ijd8l7MrQBfXuidkAMRha/fwlYPuOs2X9EvBWFwXx6rtZmY3l/M8gBsdyW79mIARdqRBTie+COE mBrjM25cG2ioFNQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

As part of on ongoing effort to perform more automated testing and
provide more tools for individual developers to validate their
patches before submitting, we are trying to make our code
"clang-format clean".  My hope is that once we have fixed all of our
style "quirks", developers will be able to run clang-format on their
patches to help avoid silly formatting problems and ensure their
changes fit in well with the rest of the SELinux kernel code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/ss/mls_types.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/security/selinux/ss/mls_types.h b/security/selinux/ss/mls_types.h
index f492cf148891..7ef6e8cb0cf4 100644
--- a/security/selinux/ss/mls_types.h
+++ b/security/selinux/ss/mls_types.h
@@ -4,12 +4,11 @@
  *
  * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
  */
+
 /*
  * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
- *
- *	Support for enhanced MLS infrastructure.
- *
- * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
+ *          Support for enhanced MLS infrastructure.
+ *          Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
  */
 
 #ifndef _SS_MLS_TYPES_H_
@@ -19,34 +18,35 @@
 #include "ebitmap.h"
 
 struct mls_level {
-	u32 sens;		/* sensitivity */
-	struct ebitmap cat;	/* category set */
+	u32 sens; /* sensitivity */
+	struct ebitmap cat; /* category set */
 };
 
 struct mls_range {
 	struct mls_level level[2]; /* low == level[0], high == level[1] */
 };
 
-static inline int mls_level_eq(const struct mls_level *l1, const struct mls_level *l2)
+static inline int mls_level_eq(const struct mls_level *l1,
+			       const struct mls_level *l2)
 {
-	return ((l1->sens == l2->sens) &&
-		ebitmap_cmp(&l1->cat, &l2->cat));
+	return ((l1->sens == l2->sens) && ebitmap_cmp(&l1->cat, &l2->cat));
 }
 
-static inline int mls_level_dom(const struct mls_level *l1, const struct mls_level *l2)
+static inline int mls_level_dom(const struct mls_level *l1,
+				const struct mls_level *l2)
 {
 	return ((l1->sens >= l2->sens) &&
 		ebitmap_contains(&l1->cat, &l2->cat, 0));
 }
 
 #define mls_level_incomp(l1, l2) \
-(!mls_level_dom((l1), (l2)) && !mls_level_dom((l2), (l1)))
+	(!mls_level_dom((l1), (l2)) && !mls_level_dom((l2), (l1)))
 
 #define mls_level_between(l1, l2, l3) \
-(mls_level_dom((l1), (l2)) && mls_level_dom((l3), (l1)))
+	(mls_level_dom((l1), (l2)) && mls_level_dom((l3), (l1)))
 
-#define mls_range_contains(r1, r2) \
-(mls_level_dom(&(r2).level[0], &(r1).level[0]) && \
- mls_level_dom(&(r1).level[1], &(r2).level[1]))
+#define mls_range_contains(r1, r2)                        \
+	(mls_level_dom(&(r2).level[0], &(r1).level[0]) && \
+	 mls_level_dom(&(r1).level[1], &(r2).level[1]))
 
-#endif	/* _SS_MLS_TYPES_H_ */
+#endif /* _SS_MLS_TYPES_H_ */
-- 
2.43.2

