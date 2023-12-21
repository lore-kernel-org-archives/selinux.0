Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC40577F2D
	for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 22:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bmXqeznF"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-67f33cf014cso7440886d6.0
        for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 14:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703197571; x=1703802371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RBferxyWAPFLFCuQsMDcst6Z0YHwQ8ySXsZa5V//CkI=;
        b=bmXqeznFymCY4XZ/jZL7xv08gWE8rbf30OiGODS66UEEXyRYwY36gfq1sIT/iTlolJ
         zWXugGKfxHZVVB2J9O9DoJxt5iWboc8geYUhUSwZgDaoZry7eTxXiKydu9E2dBYLyCUB
         ECVaHcoXvKvnYmkX9YNLOUhNE2sF9rlKYWEGv4wk81MJ0uFIFAs6tulCbKmxR5ydDKjj
         HEM8D/Akt6d8x80w6wsee3CQs75qTD6R0yWAD08KxWkzHjsMT4BFLloGodsi0w4j1RVH
         yrpNM6qW/TgNog4P9i8KyB0W5se5r/qwNMPqcO/VkYkyGoBcbAlfNB9jbEhxzVdB6a7e
         nssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703197571; x=1703802371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RBferxyWAPFLFCuQsMDcst6Z0YHwQ8ySXsZa5V//CkI=;
        b=HWpy5VFc46pFhNE9ZquhO7q8e1HbltRAboGHbtcr6LontFTO0v2+vJ6aIee1GUc9MJ
         nEcYqNs8iiY2r/uinaluW3fF1pMJDQ3t8YZ+1aAXIXde5wnX5QE32KV4Y5bALY9vfd9G
         5H4AO2gOITBEWaGZal3a+lDbC2fDDbQ/hve4of6d8u7hNtBpk+LuErP3GLwjzG0+WVYD
         3HKxcW8o/6txfJvFvdpLoEDthQt1r0bT8Com18cX/YY0+7sBbfhcjOyCRhYuvolSExX8
         wer0Ux1yytybCTlUtnhrT3r0syfy3LSGCYmP73Q4D38aS8PFjty4KT/EUD/RQV9C25RJ
         WykQ==
X-Gm-Message-State: AOJu0Ywa3YjSthS528yeA5t0Q4uq/LmlMRJeTULgLFuQHUGdkgki/ELT
	/UUv2HGf+PfWUmb7lnXcAozHe67LVakzfqRKa5GOuPGKOw==
X-Google-Smtp-Source: AGHT+IE0IVMAQx266ZYtEhS2lqnKfVjRUQzPR8S89clgzjBc68Icy3S3DGErb2G46/kr4lHfCffsHg==
X-Received: by 2002:a05:6214:d47:b0:67a:b65e:9960 with SMTP id 7-20020a0562140d4700b0067ab65e9960mr537267qvr.4.1703197571379;
        Thu, 21 Dec 2023 14:26:11 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id p15-20020a0cfd8f000000b0067f76294d5esm916943qvr.118.2023.12.21.14.26.11
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 14:26:11 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 11/15] selinux: fix style issues in security/selinux/include/policycap.h
Date: Thu, 21 Dec 2023 17:18:54 -0500
Message-ID: <20231221222342.334026-28-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221222342.334026-17-paul@paul-moore.com>
References: <20231221222342.334026-17-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=956; i=paul@paul-moore.com; h=from:subject; bh=j/bJtLQsxZELUfNgZwBEUUdSRWgtsaHGR5oQYxXQa/4=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlhLtTilrQI6G+9ohyTm+qNrFD5HJb8vwBIkLpO tRuzQwrAjCJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZYS7UwAKCRDqIPLalzeJ c57YEADJCNGNPgCMIfi0rucx1WDDBuB7U62wL1KCdaVF2IlaeO6A4RPrNIw4nhTF8sPWXN/pAD8 LaykIvEe2v7MHYPTxzUshjo1uwJfXi/QTkmMgHI3vGF+px10DqR5o0+N5hNAjDpSGOcXVXN9K5c sRD9z4kJDgIfSqz2DFpYat139XSF0iUTNN7S186WjJ5VZR3m5AFBJcfx/PFMNSyx/+/0SARbWw6 qvS/40/FO4CUZ/J2Cxvpg6J5IUNNjWrKWE9t2EXtvnUh5GwU/OkjoUzPGuBk+C2p6S8QAtD6Bel /d6L+mbw/h+4rswqesAmkmDRlCEszn92wuKb+MIPORrfBH3XlMH90ZiCJ0MxRqmvgHoC2uqe6hM EmUUuAO5cVoCVYVxTkDQfVQq2PvEbwaGXvDQ+iJuhdIDlflD79YidR4YiwfZQUTF4t1DxSA+TGS b4pvnokqRq+IPIi3SILTsH2ZSCJVSkcvnS7clpVTXCMe+1czjepQR1PdZ4jbGCqFQCJftr7cRVh 8GWp4ziRYlJEokSMqbhQz6TXpXaeYcH26tYDkHBA/p2tZafexm53Y1UmTdKce8jL6ZissDmR7zp RT9Zgo43FXA+2C3qWXzU1QwYtHwn26RHkqhA7RhBDGxL+0aNNxSOgkZvf8Yhy+SfIz/bTGHlaUs PLvWXf9Lyi6i2oA==
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
 security/selinux/include/policycap.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/selinux/include/policycap.h b/security/selinux/include/policycap.h
index c7373e6effe5..dc3674eb29c1 100644
--- a/security/selinux/include/policycap.h
+++ b/security/selinux/include/policycap.h
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+
 #ifndef _SELINUX_POLICYCAP_H_
 #define _SELINUX_POLICYCAP_H_
 
-- 
2.43.0

