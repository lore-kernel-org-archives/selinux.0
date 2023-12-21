Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07B078E72
	for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 22:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="R3D4/D2/"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4277ccd2728so7657971cf.0
        for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 14:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703197574; x=1703802374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3rIIJAO7tfe239M0dRHiAIkX6hPUd5tlluUmC4SbLe4=;
        b=R3D4/D2/WmZHhSUloKZZ/+Hgdijy6WsDYd4G5r9G+w4ekiG7u0N17Z8NyJDxn6tzeu
         rADCUm8oiS+hGXt6mJglDe9g9bM91G0/eBAkl/VHSqXW2v9hB36ItSlHLDg/nS4k59S0
         zhEftl1R//o5KpUwJ/04SpMLPYrS4QlJmkbDS1Lk7MjIy2DVC6lmT95RKjukxW5/JPs8
         TprUEgc25r43CjO90S/eBVTUtfw2mns2WKdIw+bzTXbL9xlPFAlD73Y8MgYOcW3UEzxI
         KtYeBrArmHMo2FJqKnsAJBInqr1ESC4alOLm7z0NkzYFdRg1xYV0wNcmf3pwqnhXXgl/
         4AFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703197574; x=1703802374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rIIJAO7tfe239M0dRHiAIkX6hPUd5tlluUmC4SbLe4=;
        b=a99QyO7pEuAsDP8rCzn42KKBUSU6aRQFNJKNf54fspBlJTwH8OHIF4fNXp5TZsjfNe
         3XhkWxe13ycrEahnMplr3TQcwqAqVaY4ewakBZ6cVseya1QNmoXxyzA8qh35l0ptzFrx
         S8oTEOkPp1+9npaCPcGev5NBl5ZAdLhh+Upl4NjNmwNmZLBdDckVU6YZvmxCdJQ+df8t
         x3ZorT3SqppKzGrus1vP8p1vKgyRKODeNpFrI82ZUyJhC5sNI5BBEZ5FEJGgLba380B5
         gUK51Vyu4EFhmVo+zltOAcFd7R2TMREP8XNR0bDv57JGJ8SLsCxLPIHJW0BeVTSXjZAO
         M8uA==
X-Gm-Message-State: AOJu0YwAqaTlDBEh1RGX/qtbDgar4C8uOHHC4utpbrqaiFzJ+cycgBMy
	lmH/ft2qhW2J0Zhb2VJtEJRsFaxNfjN3pHrWgBz4f33j1g==
X-Google-Smtp-Source: AGHT+IE2I9fxHS7eIt6EMUm0eiuqLBGQqFi+TEZtJffXduitKbSJrNJT6fznlot8n7BVu2Z2o+O1vQ==
X-Received: by 2002:a05:622a:3ce:b0:423:9d2a:bc51 with SMTP id k14-20020a05622a03ce00b004239d2abc51mr586206qtx.28.1703197573647;
        Thu, 21 Dec 2023 14:26:13 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id hf7-20020a05622a608700b004278e7f122esm1197658qtb.25.2023.12.21.14.26.13
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 14:26:13 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 14/15] selinux: fix style issues in security/selinux/include/xfrm.h
Date: Thu, 21 Dec 2023 17:18:57 -0500
Message-ID: <20231221222342.334026-31-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221222342.334026-17-paul@paul-moore.com>
References: <20231221222342.334026-17-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1407; i=paul@paul-moore.com; h=from:subject; bh=LAx/KMCiOwBf7fO1fY2yc9OgfV/1+bg6eUtPEtOfQUg=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlhLtlT24flmldT66A1ta910TGhsktskxW189Jm /YENJy1BeOJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZYS7ZQAKCRDqIPLalzeJ c0CKD/9D9aMWKdHaQaYaYNNW+tiOqGujz7Gf9m8yukQhaAgjxsovpRMhyuZ3eJFSUjKXEVTrdHE HlGJvaGw2ee2SwZpdDJL1uJAfzi01blQG7+nY4cxm67py2T/VUz8RnyuJGlDbsnpBo25UIUhOaz DoXLDVSAQ+9htlrs/m07IJgQv/N+KlaS0VZTHUP1aeXhz/JlRsd6Zy3iC63qRvSwv5EJRXATXML 80Ah6sZ9uyVguKCvGlYLn1r603YaMhNIOFIm8oSEX2XSkscEdImF2Nin3HA7LJq18N9Vh/gFQLJ v/E9zt4yp7Ys6y7hVni6KVuIDbHchjTJWgx9Ko59SoK4nXwTJ2uQIKMYypXWOKq8PR930N75Wef ZciH6UQqeoNtxRHRYJDjfszGkzwRog6bfmXt9DR6EyjTIkA2eXY/N1ID7/+jgpYLDX7Ph36+g7G 622PYEH7fLRbGwW37cx6BiJmtIYp1yZaJ0+kz4jRnGYNf+ln9qTo4He4ciSyVwpPcSez7U1/5iL USGVugToKybfXxWpUECLMPj3nFUZEhfmz7TDxIdb7B9X+Nvxd7ikGN5P9HXEWr+pczzfpLf3xIg TjmbQrvaa1E0rNmtcxKQbM91fgfW5aRG7Xklib7pW65mhJrkxF97cArlrnQkkCKukF9Bi9l/Jtk ytit/CtG4n0emiA==
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
 security/selinux/include/xfrm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/include/xfrm.h b/security/selinux/include/xfrm.h
index c75839860200..de485556ae29 100644
--- a/security/selinux/include/xfrm.h
+++ b/security/selinux/include/xfrm.h
@@ -5,6 +5,7 @@
  * Author : Trent Jaeger, <jaegert@us.ibm.com>
  * Updated : Venkat Yekkirala, <vyekkirala@TrustedCS.com>
  */
+
 #ifndef _SELINUX_XFRM_H_
 #define _SELINUX_XFRM_H_
 
@@ -13,8 +14,7 @@
 #include <net/xfrm.h>
 
 int selinux_xfrm_policy_alloc(struct xfrm_sec_ctx **ctxp,
-			      struct xfrm_user_sec_ctx *uctx,
-			      gfp_t gfp);
+			      struct xfrm_user_sec_ctx *uctx, gfp_t gfp);
 int selinux_xfrm_policy_clone(struct xfrm_sec_ctx *old_ctx,
 			      struct xfrm_sec_ctx **new_ctxp);
 void selinux_xfrm_policy_free(struct xfrm_sec_ctx *ctx);
-- 
2.43.0

