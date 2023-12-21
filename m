Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581D677F12
	for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 22:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eMq/Ea5Z"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-67f85fe5632so6806286d6.0
        for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 14:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703197567; x=1703802367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h5I1R7aFuBUt16U8hNi5Lnlz4fqXr3N2WdtIuYK+kQ8=;
        b=eMq/Ea5Zc/OpzdoLPwgzmZwm5h9gl6PdR5XhBlJeQi2n+UXIi9O0grYVIDi+T90Qgu
         tncOxw4IrPNwGze4gkISOfCoTqIFI2iQDyN+4c/y+t4YQ872bYRxM1i76FWDJl8vkjfZ
         ZextZGPXhH6odGp/J2gyG/i26kvGqlB4kDRenCnDnl6TOznZu8srVkCS+916OoR/moLi
         w4hAwRtLMM9CpGpiTj40I6oK6LQNAG1WtPpzyHJkNM5t+kgyDe5P9Wrz3/XZdUESipRq
         ghwMaNwKDBjr2NygATQf/cJUwO1X0+NrLL1C+9hRR/0LdyBH7L0BwcHyXI1bIRs9cPuZ
         4q5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703197567; x=1703802367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5I1R7aFuBUt16U8hNi5Lnlz4fqXr3N2WdtIuYK+kQ8=;
        b=IyB3qwWrwe+Jw0PnYoFT5+E5UjzfNfh6/H6HGDJ6Ah2u0M4XIQ66YdZRu3vy7pkA21
         GfsJiBrNrcXfyqzFTKcXNwcugjMC2DHgVJhkyh5aR1hN1vw95v530eyUih3B9M47VwiD
         yMG13alG1VxfMLzYywFTtYXtH8y22hI2Q9fhXhwv9OMXr4bp1JwqoULGezy2uw55pNFc
         esd5w8kejvwGL7IxBQdD97K+C70Vmlwf+ccxDQjeDtVyyWciz+bJEVPZ4PiLfPaGjeKU
         nvLcJzhgwevzsr0B+pw4M5ipDMp/FTbNlyWhUUw4gKKRxryx29FmYAF3VNljONF+wiim
         tkFg==
X-Gm-Message-State: AOJu0YzsKGvcR24uHW+3tKmJWuA4jy9Jk6wDKOhYHdDEzbZIhDV2xJKV
	yhvLhxHinbqEUglRgQu26ld1sdkPu/oR6y1y1gE2/JemoA==
X-Google-Smtp-Source: AGHT+IGRjZ1SI9Ob8pUJKIduq+5twL8Z2AnO3CqkIlDFSn7Eepv+ynBNjGpN0JJxTNz1aJRnz2HZLQ==
X-Received: by 2002:a05:6214:240a:b0:67f:3d7f:ffaa with SMTP id fv10-20020a056214240a00b0067f3d7fffaamr2520434qvb.21.1703197567214;
        Thu, 21 Dec 2023 14:26:07 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id k5-20020ad44205000000b0067f759f0424sm919711qvp.86.2023.12.21.14.26.06
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 14:26:06 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 06/15] selinux: fix style issues in security/selinux/include/conditional.h
Date: Thu, 21 Dec 2023 17:18:49 -0500
Message-ID: <20231221222342.334026-23-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221222342.334026-17-paul@paul-moore.com>
References: <20231221222342.334026-17-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1175; i=paul@paul-moore.com; h=from:subject; bh=2jR+CLwH4/WVZVix/Cau2YYPstPqBuDDApmEp8J8qd0=; b=kA0DAAgB6iDy2pc3iXMByyZiAGWEuzSiCFlrHD9XA0P0GaTQ+IeVgibfWGVzi/hCDMA+mRPE3 IkCMwQAAQgAHRYhBEtCqM8H8pnVVJd+7+og8tqXN4lzBQJlhLs0AAoJEOog8tqXN4lztN8QANHy dl4efIxFIfRD03IVWdM9hIfuiwn1hrx6LcAbtVG8Jsiq2S8Lx4yfvZz4Mp/u4sKt4RMVNLAnfFN 0ovwoWyjmLkOEHo93VJ7pmwzhHXVMmq0r44O+cfbVG5hPDnw1IusAvgqzzUCriuNvXu9SfNOCz5 G/Xv73pZxvZVO3xZtXjVYMCc4OiescHLiZoKe/zywzXyzsNd8DuRriwzGuMRUIZYm57hFXBv9E1 Lt6glR9ZfgWO6Bu0QgbuoCiAwEFo+FM/EdrzpKdMdI1O1Oroy2JDQPWE3NK4xxKlHenYqP85qtk OCP82x0xTSqcrurNIMeU+XyrJIOZQsrlcx7EUPmOfnGTgK7gNgO3iESMKT2Pi8K+URU0lIqzJ4h XULlO6PzzcS1mMl5m0O88ZD7jJsTNSSEHSUaZJpyCvGbQo4ZJgDDT7WWMUawkdYSd3jNZIqfmoM Ud0o21PUq8HGEeW+EzHvZN4uVtzgj4bOgLBL4qlLDqgQk9DcZg13/JR+BGb3uP9/tB62yX+oR6g Hz+m8wOQ2qQYS0e7SXbIsKLtZjDS/mFtohPrUlzz+OAf41pDyULjxIgrOTzQoR5SJyavS8gp9ux hiyC4+XMcuT8tEMKR/jRgAQ90Tu/X38ZF+OonDdDqnAmcYMQ7565dh66UAe5K5X5bTCYAAqLcLA NYe/V
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
 security/selinux/include/conditional.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/include/conditional.h b/security/selinux/include/conditional.h
index 693a654714eb..5910bb7c2eca 100644
--- a/security/selinux/include/conditional.h
+++ b/security/selinux/include/conditional.h
@@ -13,8 +13,8 @@
 
 #include "security.h"
 
-int security_get_bools(struct selinux_policy *policy,
-		       u32 *len, char ***names, int **values);
+int security_get_bools(struct selinux_policy *policy, u32 *len, char ***names,
+		       int **values);
 
 int security_set_bools(u32 len, int *values);
 
-- 
2.43.0

