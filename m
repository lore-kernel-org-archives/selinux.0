Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FA877F12
	for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 22:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OSGVZefg"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7810917125bso75757085a.2
        for <selinux@vger.kernel.org>; Thu, 21 Dec 2023 14:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703197565; x=1703802365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oM5WZluCw+P9smQaQ//I4zjj1PdHfJHBjPGdjcPDOnw=;
        b=OSGVZefgLtOZBQw7081m/ixQDqR6oOn4AtEEg6tiWghlE5EjWzH0cw2e0bzyeK9PZR
         rdLJEPCdq244Ceap3O6VRX58054v2+ZVOUhHvkB9tXySD6Eh67ZeYzx1p7ERCHBO8qnp
         La2xHNvCD32GNZQtzoOgD+pBDwmzE585X0nbCb9xYvKcBSsPs+kviAm+6wIPQMGZa9a4
         mPkCHDlQLcAOEVPbbDt1h+T6bL7Ui9l57Nu3XW+SyKMiw45gZm/+Gw3rCLfX2tulUtZD
         gK500+gntSGE0b2Wxn0p5xiR5k+uwKHUVx8WXKgpXXbChTZGxMYDnxJdLViTazsMpLPc
         ctqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703197565; x=1703802365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oM5WZluCw+P9smQaQ//I4zjj1PdHfJHBjPGdjcPDOnw=;
        b=UhsEh++l6EPgTNitXybs7oz7FHigBo8bjxwJmj0ChRyxGls1z1gposIjnWF94nWHON
         l0t1fnV9e6Jm1adPcNEMmpezYopZu2kg9EA+HuuPyneA3HVjLcISvNPSkarA/6EtI1DF
         gCzrfKCvyMFnQS8NpzPojyBUt/cjanEOTkqElAOGn9rXifs8ZUTQUQsr0W2NplZs68r9
         dZlbG2aKiFljptB0VSD3CRpXlQnXEMjhBO3L5yk7e9u9Bk2cPNjgYnvjRQoAlitEG/Fp
         hkb3QHmEiWUga4CXM2p8g0GisFZ9BDqEUsU/st8wofQwd+r2GigZAYDEDpzuu4evBWe4
         iitw==
X-Gm-Message-State: AOJu0YwftT7JTgoLOr3okIbXZ1rnBz259vVUp1KkD5B81OnvKw/xyUXK
	fIfs0C71WdbO3wk8/HodB5e0Aq1xILluzGKm/IKjpAXTEQ==
X-Google-Smtp-Source: AGHT+IGN3vIPz9LFnWmot11alP0Qvvp/EnnieHmM1X006MGQHSiB29e1iPsnEdtW6vvh4y4FI42DIQ==
X-Received: by 2002:a05:620a:cd7:b0:781:2bb2:b280 with SMTP id b23-20020a05620a0cd700b007812bb2b280mr135275qkj.119.1703197565371;
        Thu, 21 Dec 2023 14:26:05 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d7-20020a05620a158700b0077d72f820adsm952278qkk.115.2023.12.21.14.26.04
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 14:26:04 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH 04/15] selinux: fix style issues in security/selinux/include/avc_ss.h
Date: Thu, 21 Dec 2023 17:18:47 -0500
Message-ID: <20231221222342.334026-21-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221222342.334026-17-paul@paul-moore.com>
References: <20231221222342.334026-17-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1137; i=paul@paul-moore.com; h=from:subject; bh=3oG7qSIJwzpHDQezv9+WmXW+1hSs/u5HnmebuHE/VTE=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBlhLsB9orFDtzUiwOCxDI03HxvDb9KuJzdT88Rb UIH5ogiRmKJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZYS7AQAKCRDqIPLalzeJ c/1SD/9bUxzXxzHqYK+mM4lefOSk+FYNO6mp1aaQrY/7hcaaiZ3c9brBxO3tr5XI3rQ1eyEZK8N IwmRlzZMyMjB9ZIedaL8hMG4yndZVuCNPNI9uShz1921rPCrhLUBwCTKn9765GZHMQAhzHYX6jt fZVGF8211WSw8L4nKEQK9LOVfMDigPLgwyiPcF2FBkhH4T1UjY6ktjpNOtBF8Jg1b8p/f6TItny Y/tu44tPHHotn9MYApTjkHFYltg4MhnsQI21rzwC71yON3cKwz9IVosB3+UadzNpAowi/LuzNWJ NRbPmzJHDNvLezb2k0MXBnCJQRNGalijISkV8WEvld9aMBdFLI46m6XcYDaNHuUPkzjMuMxQ27/ Iw3y7j9pmP3UGAFlQ3uiAkcF9KggITkAGeGaxRegCN2M/Nc7sIXDFkZpdjVZm8ECqxA+V3MznV3 iE1GnqyouBzwNgUKH1qKcRJHc0mW4kXlj1AQ9/fx1xlXBgxHjJ3/F6i7pY+3fjcj8BQbE28HUQv bw0NIIxHB08ZjXzPgnkP4OyGJSRdXC8FD5L0DMONlre/bny3GMMS9/IpspqEdneVyiDwbyw80cM Be+PdzZNG9T5NUpo/atlLD3+lBY6Tukl4atmHTU7ZqNhX7G9VFPtAItS2qvv38SUSOpHoWu+CpY 5XXnRVRBzGm46hw==
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
 security/selinux/include/avc_ss.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/include/avc_ss.h b/security/selinux/include/avc_ss.h
index 88b139e086c4..48ad64d54032 100644
--- a/security/selinux/include/avc_ss.h
+++ b/security/selinux/include/avc_ss.h
@@ -4,6 +4,7 @@
  *
  * Author : Stephen Smalley, <stephen.smalley.work@gmail.com>
  */
+
 #ifndef _SELINUX_AVC_SS_H_
 #define _SELINUX_AVC_SS_H_
 
@@ -20,4 +21,3 @@ struct security_class_mapping {
 extern const struct security_class_mapping secclass_map[];
 
 #endif /* _SELINUX_AVC_SS_H_ */
-
-- 
2.43.0

