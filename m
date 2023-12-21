Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D9277F3C
	for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 22:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CJh31XcM"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7810917125bso75758485a.2
        for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 14:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703197568; x=1703802368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nCOwvJTEjqrAYfc/gUcAcneiDyuMZGsHObm2YPCA4Ns=;
        b=CJh31XcMDQq0379kgE4YFSNqXvWosbG+JrNLoVuS/jNt2J0ZGZw3pIPlIA7B0kmXk2
         cqoBgXgJKNie/ZyiQV7yjqQ5XILT9IKHDWv5zSqeLp2Sz2d6H32Y05TE635dFPXMqQxm
         /kEvWyYg5UstUhJ4SL8HOsPRnzt5Mq2M/7z+rVS2iQ7ZPkrPwjwKoyA/RwitpKKPHTHK
         Fc7wC67Ms8H4xvEZPhU9OI4vDLBdouDKwAwTtGXhfnxFANOqzOT+icIGYOUSvjzHBczG
         jvmzxnpI/60PFL1h361Fstxkxjr/ccJQyEHLBgftM5o1PqKY6MgL2X8JD8ywzCC26oSs
         uBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703197568; x=1703802368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCOwvJTEjqrAYfc/gUcAcneiDyuMZGsHObm2YPCA4Ns=;
        b=G9EXZ7JStVJ7S3Uj6OhUOxIGozFdSh9maQtEznUvh/i2FGjUWtKeijZ18jFbHfijBM
         mWkEj2F5qKa9rp/k4pURvccVtTCKMwZf3n+Sp6gyuggpFY/+JAAT/q3EOqg4zDfGGKvl
         DE4+cVTLPBLiDm4t50fSl6kGs0azewR+jawMduxCP5oyA21W7qHkBE/M9mlRhB36JPPb
         WWXU+wAGxwNxilODG44Sv6AQMrmchfGiymTwPrLXw2eDXc6Pio6T8cnF3LeWyUMUMt/P
         1xws2EPa9s3IHxwsKISrPx6eJP6FNly2oHuiVwoC30nDh7SVVp+lhtbW0T+/LFmm7y08
         Tumw==
X-Gm-Message-State: AOJu0Yy83C+elsskfHosHpbMPyVNYZdu9nQ3Uscl/yg7gwAlvFoLQh5p
	DRHts72zT48/8eErFYJOsG9keDnltsIWXxkd9XETj0TzGw==
X-Google-Smtp-Source: AGHT+IF2Lc9tH9O23XQOvIQ3B224o8CSerlp0waDkOMDLtKxpQcRHERpeUi17dkxU/jnrj/U3AUzcw==
X-Received: by 2002:a05:620a:4794:b0:77f:38ed:e47 with SMTP id dt20-20020a05620a479400b0077f38ed0e47mr574683qkb.116.1703197568211;
        Thu, 21 Dec 2023 14:26:08 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id j5-20020a05620a000500b0077d74f884d9sm955098qki.117.2023.12.21.14.26.07
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 14:26:07 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 07/15] selinux: fix style issues in security/selinux/include/ima.h
Date: Thu, 21 Dec 2023 17:18:50 -0500
Message-ID: <20231221222342.334026-24-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221222342.334026-17-paul@paul-moore.com>
References: <20231221222342.334026-17-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=969; i=paul@paul-moore.com; h=from:subject; bh=Me8G17KX86DSouFgN4Kyvo9oOv5fLKA7eNew/tKgKCY=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlhLs6qMFhNB7Kypi5j3x02pgTBCPKElIPb+DKu f/nH+CyIrmJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZYS7OgAKCRDqIPLalzeJ czBmEADFh+D5No0CHP5mXnoUGMmZkYaybaB1b/WcAYQodZTw4q7FDn2dDElqSJ2opDbe7YpI0z/ q0kq1E/74/y/HaXbwCcTiw6V0W2TbIVPC9tepvOXQFf7gcpsy2QTEUKUpUTjBJYtMoarD1s0fRe 2C8eRdBTg+0ZJUE2iQaOY9ye59daCF8l7mtOfLJWtHbPtU0yU1ObeqN0jG868zkubyiSMDmaNNi wNCm/KwGLJxwd9j7xlynQ/+B258/bE42SbvaheGjBX7B1Tid2B2EInjc8V1fmcZJ769ifc0oLDk kMrEwIO8wBSsuM1b3O0i9YtPKpsqy3Yohzl6DbXB8ixPXe9lcRlkjN1/RHZQrG68eLTb39skrYw adBF+gW2tL9SLroDpBLxeoXkegstk00odzDF0yD9C3vyH9NlCZtVR781enZMSu+G0R2lW+TU6mg n71Pz59CRzuLc9ueB9j0ZAnXn5Mk0CW3ABqn9C/cvFhEOR5si8e2X33ntCZuK65vC9Iwvk6oJU5 4KDkYlUYomEI9qOFqbDouPX6Bjix2IYOG3hrcUjFufj/eM43W/JQwZwZz/cKsE1mw3umcafdPG0 HjSjCN9mYxxFkz9WL38i0dPjVAy9/lVpy2KAx9XHTqwvW4anqpAT/CoBkUMLH7pHgr1rI0saAaA ZO+Z4Opdt9Ro4bw==
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
 security/selinux/include/ima.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/include/ima.h b/security/selinux/include/ima.h
index 93c05e97eb7f..38ab302f5946 100644
--- a/security/selinux/include/ima.h
+++ b/security/selinux/include/ima.h
@@ -25,4 +25,4 @@ static inline void selinux_ima_measure_state_locked(void)
 }
 #endif
 
-#endif	/* _SELINUX_IMA_H_ */
+#endif /* _SELINUX_IMA_H_ */
-- 
2.43.0

