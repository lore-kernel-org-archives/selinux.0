Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9485C2566D2
	for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 23:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140278; cv=none; b=PuSi9Iajd3InlEjmZGDDs5LEAuxC7ic7jbxExZX1NqPUKqjZ95KCVLsH6FcoJVrSRQIF8kdOs2Xf7WYjsK2h/c0r6ltl3R7qV+bWgDYgX7hgm6dHta7vlD+jepKhn3mqiL/9x8J1VWuyrQgtqDDbaP7G6T9pFr9q7NHwpI+dGq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140278; c=relaxed/simple;
	bh=UixOHxs80Kf+tYLuKKt9LadkCYF6HHkhv5JXvD5s0uU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8GdGwD/xmS5eTY5pUBDVEBKRnzDus5/k5QpZRmbV9lY+gDaswmhUBRMFhE7ko2c9P4RY4a2qgP4K/Wz4KL1uQD0gvR6Xv61cXRbR+WEr55abB4o55omKcFBrISXdUC7grbeKRlYqBnAL1TBdirTkQarv7wkeuABlMIh3o119ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DjXjf0mF; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DjXjf0mF"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e1d89fcc31so495038685a.1
        for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 16:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140275; x=1753745075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+Ol4Bn1f1VUTnar0XIBvx4KlRPVW1PlfX21PI6M1xI=;
        b=DjXjf0mFAjGAz9EQIJAftkwiniFjVPKx1TJuJax3frgzS1Iy6aus9LEBtP/jfuL/En
         59w2pEu0mklt9h4PorbuHndLTzIG2RCSU88ME/mmuEQObOfkh4ex67F0hDfEusGxobVT
         ZfLj0v2NXBsLoDfSVcDUxCABzGK5N2a601GWln9tTuZn3cE0aWuWvxasDCaAzHYNKK5v
         ogpGZEcSfsPv18jG6BcExMvrWWrZoB4ay3TBA2LcQiJMQTMTlFBaSMFMhNJyy8uUyszp
         sxgbMhlR8IaLIQHDIGRvb172aSjBk/ig61GsQRRYdKisAawC/u6I9Cr2xpRrf/LyZFpi
         mDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140275; x=1753745075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+Ol4Bn1f1VUTnar0XIBvx4KlRPVW1PlfX21PI6M1xI=;
        b=ngcvShBb4JxSDZeu7mL1LLxAkNiADc1eEnQI/SpqvLAhpZ4ZIZJAnbgwoXUyO+4Ss1
         iqh0lvP9y9CveUxo/zt2YjEEgj/5dkO+BAb+P0IU8F5gpFYjoPBkEdJi3P/wbYmeGy8w
         eEmFJIcPZMZUhgv+nlk4wE/BQAKQxDDSOZdq0fmqLbaw8gwg75qOPRciRBAsW9kHARZB
         /G6fDbXfu5K3NohW3qsewTKLGQ8MdbmhRkqBheQPl+6bNHY9bwXGcvCqWs/hQZf77w6r
         U3hzYJiichMGQ4s/loCX3lETgH2xNoNVKfe+9LpmBEs8tepFNJe46TX0BEZhtnq6Nekn
         Ia3w==
X-Forwarded-Encrypted: i=1; AJvYcCX0CTT9qftip2/AV1uryZuBviQ3ShOhVQ0IMt7upI41SqdgcQmBDPl0XQy3UQ7EHJ1dBw/Qkjcc@vger.kernel.org
X-Gm-Message-State: AOJu0YzkvMIli19n9HIHvOehDYViYOCXLXuudbQIeuWT6xIt2ZfC0SIA
	QSPsl7KOqDmYtybD9qSyWSSM0srA0evEDNE0iora9naFGDG7iLDMsuPP1+WuO5ur3w==
X-Gm-Gg: ASbGncvXL32+8HZOqs/9qLvJzI9fklpXkj2Z+az+8AY/2eMFDGUlZbhIdoc2amt9Wf5
	2orL6zjNxu+otcuJr1dyZoL2zhthvk2ToZmcfGkGSpaQLAXFL8YWUXryPVUoYcCyUe6rvo6gHfI
	VULVz/8UiVrz8OQHIoA74gLZXbr6RDiBGPs7L+IrM6FL66Q+X+v61saLF3xyG31D+RJ0ar1LrQP
	tk0d747FdP18r1Tfss97sMvFi17EQ0SpRXYPrjZASiy5p3tMLzWxRfyB43IchH7xsOkrEqgIQ2U
	FIYY7PIWfK8Voh8yOsFvjRDL3baOgoHTrsSK4La4B/VVFT5HGWck6SBYVlz/8KQCq+k81bDpcC3
	Rpx7U04BIh6jK6imjQGQO8l+3X71AgPvQNexX+fTQVw/h//81EXYkxouZl98/S3YhqVQ=
X-Google-Smtp-Source: AGHT+IF2vMeo2ybbnhrEnWvRrNcCLGlzINCAN8UFu1xRPYQVTYkUpylnJpZeesCObRAHv4ym88xxtg==
X-Received: by 2002:a05:620a:4050:b0:7dc:63f9:4b27 with SMTP id af79cd13be357-7e362b56dd0mr1405741885a.32.1753140275556;
        Mon, 21 Jul 2025 16:24:35 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e356cbaf67sm463456785a.107.2025.07.21.16.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:35 -0700 (PDT)
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
Subject: [RFC PATCH v2 33/34] lsm: consolidate all of the LSM framework initcalls
Date: Mon, 21 Jul 2025 19:21:36 -0400
Message-ID: <20250721232142.77224-69-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2798; i=paul@paul-moore.com; h=from:subject; bh=UixOHxs80Kf+tYLuKKt9LadkCYF6HHkhv5JXvD5s0uU=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsv8m4dg85BXHVA4WDQFLKXqOQH23bvhbJJBc iEkcveCP9SJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7L/AAKCRDqIPLalzeJ c/1SEACj4iZ9Qu0t9VldeEpWVFB3EDHwJeRutkafQpbwChl7ba99JaTm7WaZKwlNdTFYwW4ZNxz VzsfAg6hXQwvGPrNQkuTEZVbqEgcFeXL3A7Zu1/hJBf2LCDuaGRpTf5/pq35yrts5iNRr+myppF k5TM9QcBqA3wEyl3ehI/Y3XNJLIwrtrljV/KpRP3b0MvWcvPLCd3trxYcd7eFuL0H/sB6QXtoyP /jP6yVzklx4q9am4eWP8moPEgdH1JlDSzF38O6c31xxAnYGX+GUeMGKhp3i+auF0e9nT3q18Nbe 6iCfGgCRIiaMIMcHIrQo1ty1nPbv8e9yQl1pCab0TAnbjffDuuh0m5iATHoyxvtEjaCqKntNGsd mhZD7VqT3ZfyQXeQisbmI7Rw4BsGRsFFQSLJMLxoFAjapJUumSDOi/OnzIWjZRijGJe+ecgQYvV a1s4+zlkh6MhkUQdXI+b/BEuilGsr3GKO/enF2pXrBDIyWaOhuy44owSv6KIEFNMWw+GQb7oIO3 ovvnt0SGv2HI26/Ng07s4Jdy33TZBOhimZpeADNrIt6X6xGHkbtVigKtkkcdC/BpcX1wa8u3FS7 F3sBPSJSrBrKN4U0pr4K4hgd8NiZLHQRBR9YxI8qApFKlnUzNXdn+F1lXaNbVGifrK50l2uwrLE k/mlFrhgJjuPZuQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

The LSM framework itself registers a small number of initcalls, this
patch converts these initcalls into the new initcall mechanism.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/inode.c    |  3 +--
 security/lsm.h      |  4 ++++
 security/lsm_init.c | 14 ++++++++++++--
 security/min_addr.c |  5 +++--
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/security/inode.c b/security/inode.c
index 68ee6c9de833..d15a0b0f4b14 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -408,7 +408,7 @@ static const struct file_operations lsm_ops = {
 };
 #endif
 
-static int __init securityfs_init(void)
+int __init securityfs_init(void)
 {
 	int retval;
 
@@ -427,4 +427,3 @@ static int __init securityfs_init(void)
 #endif
 	return 0;
 }
-core_initcall(securityfs_init);
diff --git a/security/lsm.h b/security/lsm.h
index 8dc267977ae0..436219260376 100644
--- a/security/lsm.h
+++ b/security/lsm.h
@@ -35,4 +35,8 @@ extern struct kmem_cache *lsm_inode_cache;
 int lsm_cred_alloc(struct cred *cred, gfp_t gfp);
 int lsm_task_alloc(struct task_struct *task);
 
+/* LSM framework initializers */
+int securityfs_init(void);
+int min_addr_init(void);
+
 #endif /* _LSM_H_ */
diff --git a/security/lsm_init.c b/security/lsm_init.c
index ab739f9c2244..f178a9a2f9d4 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -482,7 +482,12 @@ int __init security_init(void)
  */
 static int __init security_initcall_pure(void)
 {
-	return lsm_initcall(pure);
+	int rc_adr, rc_lsm;
+
+	rc_adr = min_addr_init();
+	rc_lsm = lsm_initcall(pure);
+
+	return (rc_adr ? rc_adr : rc_lsm);
 }
 pure_initcall(security_initcall_pure);
 
@@ -500,7 +505,12 @@ early_initcall(security_initcall_early);
  */
 static int __init security_initcall_core(void)
 {
-	return lsm_initcall(core);
+	int rc_sfs, rc_lsm;
+
+	rc_sfs = securityfs_init();
+	rc_lsm = lsm_initcall(core);
+
+	return (rc_sfs ? rc_sfs : rc_lsm);
 }
 core_initcall(security_initcall_core);
 
diff --git a/security/min_addr.c b/security/min_addr.c
index df1bc643d886..40714bdeefbe 100644
--- a/security/min_addr.c
+++ b/security/min_addr.c
@@ -4,6 +4,8 @@
 #include <linux/security.h>
 #include <linux/sysctl.h>
 
+#include "lsm.h"
+
 /* amount of vm to protect from userspace access by both DAC and the LSM*/
 unsigned long mmap_min_addr;
 /* amount of vm to protect from userspace using CAP_SYS_RAWIO (DAC) */
@@ -54,11 +56,10 @@ static const struct ctl_table min_addr_sysctl_table[] = {
 	},
 };
 
-static int __init init_mmap_min_addr(void)
+int __init min_addr_init(void)
 {
 	register_sysctl_init("vm", min_addr_sysctl_table);
 	update_mmap_min_addr();
 
 	return 0;
 }
-pure_initcall(init_mmap_min_addr);
-- 
2.50.1

