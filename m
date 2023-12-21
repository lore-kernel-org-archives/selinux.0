Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6868177F34
	for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 22:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FU4WHzZI"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78102c516a7so85728685a.2
        for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 14:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703197572; x=1703802372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yWV9+Lulcfjl3KReqkcC0U4jekZ8oSg9IHMqPCEELZk=;
        b=FU4WHzZI3+JI9KNkkAwoQt619FHxB7IiV/O0Sqt3+rtVqoGAuSv4cXvJUbfUMxpaok
         IJMkXwhzvwaFw3pOF39c5Y5MR247iY229hI5SkJ3NEZOafEO1X9pR/kqPFQiV6weyfVX
         PA72lcEOJ1CnvKZmgI2Nif2DlgCBqYViRTZLdzRfjZ1Uj/haWrf5XEkWVyNilP29WmeH
         fNYM8NzFfxhsKYftKyNNDOX1mJbjqnYFrl+R0fUWiLvxt4QGU+ZFLyaB6gm6ygCt60xi
         4OkngDfMGgBBCW+S3e5iepxbKKCOQVZ7llUP96fLHwUBInIT2M0KN2kAexbr9RgpXJQY
         OPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703197572; x=1703802372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yWV9+Lulcfjl3KReqkcC0U4jekZ8oSg9IHMqPCEELZk=;
        b=T0ac099Oh5a12zTIpUiaVBd8mM6/2OdcxPFY6VBDcnQR+jxjZ6oON/k45Ljkm6tP6W
         IvalTz9ZwPJ5XvBVwLVz4bVxRKtTGTabuTQfKzT3tdfnGp+g0KlHjBYIlqY6+VrwEQyM
         s0QsVqzNqyAjmfssu7CKmma3nl7qvI5HnPuupuln8UrKpOSpIvpyERui+SmQz4G8GvwO
         RHwDY1adK+N9oEDPW91YrMYC3SeKbTjqqreGZARjsw3ZVLi9rERzJzt3N+I1GScJ7Bxn
         pZUn6VxHnhxESR6wqK4W/KwJbeTnQmemt0Ah4gvIaELccVBLgaMpkxfL9Ru+xAM2Yf87
         GDug==
X-Gm-Message-State: AOJu0YywZRl3rA1jximoGXSf96yHZST+RRrhZEzAaBZDgr5hsAsS2twB
	HjXQo4syCnaxzv7B9Wm6ImTtkj5zmiANNNY1PLDpFLAz1A==
X-Google-Smtp-Source: AGHT+IEvMZeUr6gjAHCW+a2Cll0VO+T3z7MWZTKxVEcEkGWEh5hxuERNy+KFOhRYIIk5D4ZutD8TTw==
X-Received: by 2002:ad4:5c82:0:b0:67a:b622:60b8 with SMTP id o2-20020ad45c82000000b0067ab62260b8mr629783qvh.61.1703197572106;
        Thu, 21 Dec 2023 14:26:12 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id o8-20020a0cecc8000000b0067f37d9196esm917456qvq.93.2023.12.21.14.26.11
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 14:26:11 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 12/15] selinux: fix style issues with security/selinux/include/policycap_names.h
Date: Thu, 21 Dec 2023 17:18:55 -0500
Message-ID: <20231221222342.334026-29-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221222342.334026-17-paul@paul-moore.com>
References: <20231221222342.334026-17-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1400; i=paul@paul-moore.com; h=from:subject; bh=bWuYEJpvR3lM0aYKwQZXbEyrexL3Xdhng7IWeW5NnE4=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlhLtZ7rsEmNNl88IQaj7uZo2ylHdwTJOsMfPZ/ rVTENNZareJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZYS7WQAKCRDqIPLalzeJ cweSD/4wnYkMEPNv2ndvOTTIdsP/MApb5V4O3FesiI9pLPiSUsL43c93JDqxzo90Y7Iln/ipxnD UzSakNe7bQFgOtRET6pirLWVGf2CMPj71AMC4GxqLyxcIARDrjBrkxyZJ2xwy4bw8GMnUvqP+Bs oUmho64OQ7+nhnKC6rgvpXctG3afU+q1QNutXy3ii3Eh0xoqrZ/wDa/IpNcvj/KcmK6zb6vbPLM ZjVgZi45QIN6To6ic6VHRcXxZw6oGLWKtR7xwSP+tQ8cv7rGp85pnEnCeZsXqemtLnBcb1ojIvd mChUblDk+4KY1vD1Y7plfG5tpFNgFM33K/A+4ERVplnKr56cs75/idv4Bqpf+4RkeRzrMdgtwHY AHc8lIuCMYN4pvs2vxEQw7tXFQMQzFu6QdH87UM9XkEUbzgwkintXxDsO1LthltBE74NJPxn3a0 iFKTPW9ale0P+xJz/wklFPM1PgRzHyL/9cGrPfgzOu0rkP3ZqanO+dgxrfWw3t5WaT5pQ3Y0LHd qTGerikc1AfEjMbb+YmIY7tq6jZ8FjQ76s0anBr5bNtimwfa2WOAOUkreUGA1WTBp/NshxBWi8i OEYVYnpavLLBdqlknpjra5PpFAhQTxsjUH0Xwx7tuwsd8Ui3HgqNErdt/AcN9d2GdulBX2aR8jx y/PpqOcVGrgc6Tw==
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
 security/selinux/include/policycap_names.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/selinux/include/policycap_names.h b/security/selinux/include/policycap_names.h
index 28e4c9ee2399..2cffcc1ce851 100644
--- a/security/selinux/include/policycap_names.h
+++ b/security/selinux/include/policycap_names.h
@@ -1,9 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+
 #ifndef _SELINUX_POLICYCAP_NAMES_H_
 #define _SELINUX_POLICYCAP_NAMES_H_
 
 #include "policycap.h"
 
+/* clang-format off */
 /* Policy capability names */
 const char *const selinux_policycap_names[__POLICYDB_CAP_MAX] = {
 	"network_peer_controls",
@@ -16,5 +18,6 @@ const char *const selinux_policycap_names[__POLICYDB_CAP_MAX] = {
 	"ioctl_skip_cloexec",
 	"userspace_initial_context",
 };
+/* clang-format on */
 
 #endif /* _SELINUX_POLICYCAP_NAMES_H_ */
-- 
2.43.0

