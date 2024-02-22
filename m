Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C173A13BAF0
	for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 23:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646392; cv=none; b=Py3aYDHuj29MacP1pJSdsbynExuH0HoI5kkd26l3ybh1n0Y6teK+JAqHhw5M5XMUh1kRYH5aH/U5B2tppCWsFQD0Pna1eCEU6RbvhrV9hN/HFr0s+k/0bofsCiyvJC6h1vA3PW1hEsWwBeENetRyRKrh2kPRBnvGu3InySMMNQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646392; c=relaxed/simple;
	bh=iGDU1Ht0FP5uWWSc+uR7Qcw4WJO6mgRY36FZ/dsthvY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HtOrRBwtGr5mjetEFzigmjKL5GxxYLcCAMi911lwO7eYd9SX/xZqlHT9qYkOyAMevy+okrHyp0YH5VeYChjtmxLwCoCv6JwSyOyfOQix7Lq+aGdwrZ0EsrWeXFynBGfaPzLt35aiK/anbWs6/h6nrvFAsA6wNq2goLcB+LHvymA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JCZEy+5w; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JCZEy+5w"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7872bc61fcbso18415585a.2
        for <selinux@vger.kernel.org>; Thu, 22 Feb 2024 15:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708646389; x=1709251189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nN6Ex+YZH7SGWlFNwFSFqyDKLnJSvb0fy2hR0kNoheA=;
        b=JCZEy+5wqmoFNd6pvlEtbZcI8Fa1Apj4U7zfWSqHjhsdz9hA1NkqwPSlGg7NaO0dkB
         iC7KeyT6YCo3GXG4DJ6qz/UM+mUJlsx6ZImY3FO+MDj46qNqUxnBLYog00l2kR5ISloh
         bYxq22sT5rjJuwTkc98aVM/fauEcuAOjnAzFrGx14/mh2BpYv6f1bMYZbZBE+Ter2U+K
         fxePvqflIQWWnZZIz6Va7vHuWR5Qgs26QHzKBEIaWih6mE/fgCa0o9bupyx7lrdgd/Ja
         UXygRfH5QOXUVyigxM2p/oPDsg/jh7lPqkbUeGhd51wYgIgVwDPGqGJZUqowz9O6ZM5f
         J1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708646389; x=1709251189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nN6Ex+YZH7SGWlFNwFSFqyDKLnJSvb0fy2hR0kNoheA=;
        b=BXhqhc57VU0qP5yb+6Ml9loH0u+NbVpC1q13JJCal4/W0JIA9MWAfj2a4xMM1/rcjQ
         9LFK0bESo9mM85R93yfNsijb4GwiYuwWhOyI7KwFPQqFzUQGzFNnH6Xxd7ZC4X03XABV
         jEnxCkO1Mv7JWM0zhg16D/w04YpS6yF+AZ+H1DDrPevylAN6yRKdzUktl6qWgW0vhxa3
         BusXGAvDZIvpMusgAFplJkPuU37QZOVOLMGvar8a3YGjIKRE4vKWiMqZQgnGQfdWDnhr
         DPAQ6lOdP2BTJDCl1psttGBDqJIWzkmq+7/n/cVLY0x3qnOc2dE8wpjgzzdy8OVqLRDi
         0DyQ==
X-Gm-Message-State: AOJu0YzFqpLqk+9Jqfsi7DosgEitQZAiR6Gu/cDqrAVbXROk1loy0+IT
	ML13ZMePG7BrNVObfbAu2ebBZ1FF+wUvzVbfXGKE/KSW4ogauSnhrW9YeC2paZovh5kKetRZLMc
	=
X-Google-Smtp-Source: AGHT+IHua7vVlwzD6M1494xNpvfCwFfaxJM9Zn4c5BuRpxdofd1+RWX0QF4rDWpM30/vcZYtFxTpKw==
X-Received: by 2002:a05:620a:b1a:b0:783:1683:548 with SMTP id t26-20020a05620a0b1a00b0078316830548mr599289qkg.64.1708646389461;
        Thu, 22 Feb 2024 15:59:49 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id os22-20020a05620a811600b007871bac855fsm5812575qkn.47.2024.02.22.15.59.48
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 15:59:49 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 17/21] selinux: fix style issues in security/selinux/ss/services.h
Date: Thu, 22 Feb 2024 18:52:35 -0500
Message-ID: <20240222235708.386652-40-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222235708.386652-23-paul@paul-moore.com>
References: <20240222235708.386652-23-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1196; i=paul@paul-moore.com; h=from:subject; bh=iGDU1Ht0FP5uWWSc+uR7Qcw4WJO6mgRY36FZ/dsthvY=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBl19+8ZavHIPWBQQfBLQoYb/EV4oR5cLD6dz8a8 xmNcOv9LjKJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZdffvAAKCRDqIPLalzeJ c9ROD/4vDFej0+/mg8k3T5GCq28QnpAV2V0OliPfEwkOtxe4ref2rqTxkKJRQu8ieGra4H1bUTG /6ggMzxywPufHtQSWEOhnCcjI1KyAAtl4pUQ2lrmELixzyitoBX2cQ4oe/RtgYM3yJacF5luyTP pMVMIVeJJ1kLPvjtjpsIJnrXq2qPOAGruLL14W+4i4FFWeZmtFC+O2embueDOYH1vIpDbLqMdxc SFMBf3VnzHadqGZ+vNc1yx+TFTgtigzAnq3hLjr0IuQ/TcO9XhONzs+S6/gW1N3DZ/wgeD9XH/E ChtFUa9JYMs8or0ORvIAGRp3+JkEfDRXet9RbtohrwsuJf1s6G0u5lel40WGZzfTUzSpG5/2/MG Y7PjTe3woo5Zg9OkjgS6luwJdHaBLjFvtmwcUpZD5RbFnGxP2Uj5MLwO98UI4Ra65XkMod8d2/0 I+g583Fcpp0vxUDheMO8iLuAOmR5p47fgKKgX1qFCLyNsVSkno0fKux5cS+jzkCs/RJQ/qU7sCA inVB0B61SubjUafFmNIFXvWL+Gt8rJT0z400t4vEgnbovseCrQyjyl1+ONWDi865RJvWPWWnINd Io8NtIq9qPWsgQaVEKLUs5yMnIVsEbjE9OzndLThLMrLnQI3hsdebveLd3k5/WoLS8gWjZ0UELr ok+8ZPmuniBLORg==
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
 security/selinux/ss/services.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/ss/services.h b/security/selinux/ss/services.h
index d24b0a3d198e..93358e7a649c 100644
--- a/security/selinux/ss/services.h
+++ b/security/selinux/ss/services.h
@@ -4,6 +4,7 @@
  *
  * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
  */
+
 #ifndef _SS_SERVICES_H_
 #define _SS_SERVICES_H_
 
@@ -43,4 +44,4 @@ int services_convert_context(struct convert_context_args *args,
 			     struct context *oldc, struct context *newc,
 			     gfp_t gfp_flags);
 
-#endif	/* _SS_SERVICES_H_ */
+#endif /* _SS_SERVICES_H_ */
-- 
2.43.2

