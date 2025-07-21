Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD75253B5C
	for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 23:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140271; cv=none; b=mA0hhcHph9LcNfj+hrYf8i9OT+AZB+c5iJpbyKvwlga0GFxpqnXtWntimRi8O5QSPiBJg1tOjy0K78tfA3/U71Nuu6Cm8JaBPMSYY9kicg3zzN7X/GihIwwFttKE6lQHUDz2buxQZu/GhZOa+BRdMN9O4d19L0dgbv/I6G/Wit0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140271; c=relaxed/simple;
	bh=I6ppTevKSz4qSPY3lg/Lq3qMQ5mFXCHTmhEYBYpMo6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqexxjY/C/IAchWlKy3r3DWWDs3UBrjPMadfvK9BFkV08Vo4/ZjraNN+7vgOfyHDR6wp5SGjo1jEPPyGSmtjU7yjV/ezXpUTCqtLUE/TZtXajFgQ8XMvPP1lb9Lkxy/WeRW9jLc3bXgtKF20BE9XhtZ8fK0fJYcE2RYV7YWitck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TmmDNThK; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TmmDNThK"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e32c5a174cso468182585a.1
        for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 16:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140269; x=1753745069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlbKJNVrnIuy1LKQSyFS71oHYCZmuhjOpIeXDddHJuk=;
        b=TmmDNThKxLJb+DiJEXNcNTro5FBtvxXf6eUKmXEyVvaMKH5bK2lPxJSTG41m6zGp1U
         WVb+0AgNYxni37FaWOf38NBpTqZXjhVaH+XFEQNbOLXYw4jueDf639kyX1Fe/27n1rCd
         SAiUpw36XHpIbkgTcCHck7nFYe1Kbk9pdtAIpFVK2BOlLL5dHFdEvT5Vi82hQp7394//
         0tI59oQ15pYAXilIcVCMC5HSjTSB6y7wS8ZbiVSoS0cyAykgVMbTUVSzdcewDhqtEcbE
         M2dqUSkU02CTdrXRfkmdEQlkD0AcLCnjdXkIxN6DPMjVyjeByuElmW66h3HniMhr7SfO
         l2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140269; x=1753745069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlbKJNVrnIuy1LKQSyFS71oHYCZmuhjOpIeXDddHJuk=;
        b=iwrl3r7PMiV8ZB9eTwLH28CMn3ERidxDwYvUB9nfekQl5Sl1sz0/Sl1RG8W/xAGo75
         S7plWQs3KqxHcUzy/nGlk87+cPCLfg3WYVz8pCxIuA20T7wegr0zKemPXHGCwfpJUFCv
         4VneIwy+KkzqT4MhDAbo9r3IlHWljaPtxBYr67aZn2RT8+oO7h9UKx23T2DPndliYSZ5
         eQ7qJK7T3hZGNqN+v5pmGAkWR++lj0slvsRkr65ghWaWo+8D8ZOpW4CST6Q29tSD5Z0G
         KGS1tq7xv3pIvsXYpMdRxdg6WupRFtoHdAau2+otNLTbtcXeuyoT0Cs5m3Id6lrY1jsL
         DkFw==
X-Forwarded-Encrypted: i=1; AJvYcCUMI2yWKD70kro9qhBQRuo4Sub3h/NM2MSxHVDnz+voi7fyuhhW1t7mfdyaHehgfcmRjIcPcng9@vger.kernel.org
X-Gm-Message-State: AOJu0YzBAMBquOziIGQ0Lv+Zc9ciP0gFTokiE75PhoboGZIBOlLDdg74
	CKWPMErrPBcsZ9sVAKtgYfzxrkIgsbLw33T05dEECP80zJQQOTREffd9TnITpGheMA==
X-Gm-Gg: ASbGncvTwWl23JTKCrcV44j/FlhYCRKSE75A1NDmI8kN+KZydooes02up85Y6jB9jFa
	OTmLJy+T2FUGlS1H18eqt8E+WEDpNo8whANpMAaOpe8KpNt4tOoXS/hcfZrj8JYSLrOgzMHaU/X
	pF/gOh+t7T1ePnhdH7gsgM3B6bkZ8JJtliHvEKXteaVHyE8UuU+vGDRHBPOp7+D4HxiB7i3pzsp
	WBtYhJwJHT2ljFnB7Zyu/TFOiBnjdbNZ9G1NwN4iWB9esoCDeVJMINDx6iL9bveczT+8sAvOv00
	wMvwKJm76oq7owSTNBh5N6+OAC9RdCEFzPVti2cHjlJ++QkgLdZzbhw5/zH27eIRtzI7VTcmv3B
	oKICsuvzMsvuok/NyTQmsBbPUQjFAk+i+iEP3IwzTlSF/kgPysmaZ4+8hkJbUwDYGEUU=
X-Google-Smtp-Source: AGHT+IEaSOHzNkoV4TK0oT5nkZeI4V4uFr/pidvvZi/Rd7gG+KFDSaOSYj/4LxYUoFdky2FuqHBeOA==
X-Received: by 2002:a05:620a:640a:b0:7e1:90b9:6cd9 with SMTP id af79cd13be357-7e34d8f79e7mr2237083285a.16.1753140268880;
        Mon, 21 Jul 2025 16:24:28 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e356b27ae1sm473709385a.1.2025.07.21.16.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:28 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [RFC PATCH v2 27/34] tomoyo: move initcalls to the LSM framework
Date: Mon, 21 Jul 2025 19:21:30 -0400
Message-ID: <20250721232142.77224-63-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1769; i=paul@paul-moore.com; h=from:subject; bh=I6ppTevKSz4qSPY3lg/Lq3qMQ5mFXCHTmhEYBYpMo6U=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsvoZjREpIWCuSqwTbW2LA6XsI/tTkqOKa1zE fnJ5aHe0h6JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7L6AAKCRDqIPLalzeJ c8iPD/4mAh2paigqx5VS6lwRH9npSDmf+UYE45kX2ZeVTCKzJudhcZ/1SLafLdPB7Rs46LLcngs k9ZLnHHP+9+XxgRNtmqSjhlSHtgXgF0QPDrEE67f+bKyG83NNVouTyzlawvq/ZHfG9d5hnGKBbe O3F/yotrG/VogaVkPx39ZJjvFfGYxwU1QRwgkWGhl5vfOpBpLWemVK6Zd6nbLYWDy8p8n5FDcCU tDmx9y+/yGrErqPJAWDm7kSlPqUwKJ3bPgDiwZ+oyk1vffrHzMFRoLNAf8YP5GUtU8N7+Hakvw2 fAATFDwYnpW/Gh1C48+zTOizUF7om+QuHkZSmz9rn4RFW2lM/L2FT5/ztd3Lc0gh1tpz7NR+cwj CAOQu4e30ywYgE8n6RtMmIQ576nOVn53i5Q0PiWOhbxPivxsncEgoYXJcwJmWtH2P2MKvMcguo1 xAYEzWP0LK20pVRkDQ5NtXpmxz4jviUP70wyHdew4osn/5NAiYAzLkNlYcqPaBjPFFsaxiv3okh FXY2O938F4xfKVpm2MmRvRj+8lYEFMHJX7O9R0o2gtnfI8JEgkRJWAhnNPf1NCNPFq5iN6nNDuV W7qG87MMGlu/YqmWpLCUtdfao20+/Pdc/B5WB1zOM3dTQAptE4s9z+TLmL2BnSCC2akKF00HCrp hQqc+oIJVFr6VZg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/tomoyo/common.h        | 2 ++
 security/tomoyo/securityfs_if.c | 4 +---
 security/tomoyo/tomoyo.c        | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index 0e8e2e959aef..3b2a97d10a5d 100644
--- a/security/tomoyo/common.h
+++ b/security/tomoyo/common.h
@@ -924,6 +924,8 @@ struct tomoyo_task {
 
 /********** Function prototypes. **********/
 
+int tomoyo_interface_init(void);
+
 bool tomoyo_address_matches_group(const bool is_ipv6, const __be32 *address,
 				  const struct tomoyo_group *group);
 bool tomoyo_compare_number_union(const unsigned long value,
diff --git a/security/tomoyo/securityfs_if.c b/security/tomoyo/securityfs_if.c
index 7e69747b2f77..33933645f5b9 100644
--- a/security/tomoyo/securityfs_if.c
+++ b/security/tomoyo/securityfs_if.c
@@ -233,7 +233,7 @@ static void __init tomoyo_create_entry(const char *name, const umode_t mode,
  *
  * Returns 0.
  */
-static int __init tomoyo_interface_init(void)
+int __init tomoyo_interface_init(void)
 {
 	struct tomoyo_domain_info *domain;
 	struct dentry *tomoyo_dir;
@@ -269,5 +269,3 @@ static int __init tomoyo_interface_init(void)
 	tomoyo_load_builtin_policy();
 	return 0;
 }
-
-fs_initcall(tomoyo_interface_init);
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index ed0f7b052a85..a015cf0c4a00 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -617,4 +617,5 @@ DEFINE_LSM(tomoyo) = {
 	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.blobs = &tomoyo_blob_sizes,
 	.init = tomoyo_init,
+	.initcall_fs = tomoyo_interface_init,
 };
-- 
2.50.1

