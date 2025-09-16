Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684EB31FEE4
	for <selinux@vger.kernel.org>; Tue, 16 Sep 2025 22:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060883; cv=none; b=dsbzwwcIdg0m9vgqUtbJ9w5B1raer+U8YkM0yTW/ZYuu86ngG+ePdQl5T+n/h4JtKsCU/g9Naiw/kZFBVTvMLkWlOUuUd41hrpBr89nwjzBn5OLkUTve5Kkp5xT5kjwqQ+T6PLRGz7XRBVAfrjl7NWw+AE/DsARtAivqIM3JM6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060883; c=relaxed/simple;
	bh=0y4h5n+IXD8P8dnjxt869LYF6Svfv5Pqp8Njr0WLUEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYQu0+fHOb7S11sMyuTmGthgnxv0csfJvglbt3JF1IhdRkaWJepPdYsDBXXfrPpRdI6eLfToxu6JjBwWECs78rX3ancaUlai/2f4U1dhS9Dg/pA/fLQzKj+BKBM/b9xzij6u5tAAF7VU7Jm0rrCw6hh2pAwU6satGdqFThCyZKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=A7W7I2qc; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="A7W7I2qc"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-811ab6189cfso570795185a.2
        for <selinux@vger.kernel.org>; Tue, 16 Sep 2025 15:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060880; x=1758665680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtegchSCa5XU9sfnXrM28NVIbfPzM314cfpYIxWWTKY=;
        b=A7W7I2qcI9lL3KAwofx7iP2XkcNSVLEgbjYxvXwywXPPt7OniwF/9cNZSLTpY9qgXP
         6kv0asdL3awvb99jnQEG1e+SfLKxh64gDUrks+tY5AvSi/zgh3xS4XxxYodCtoA4hsG2
         KC8WrRZu6+sVxj2SOvS023dakk/fhrnJyyTT/neLunDpsmaj77K2M1QSAGKiXtD0bb47
         8LKWGJbuG+67MzaeK7h1bfbS6JaL8TKld4DdwS+rw/Mvla3BnRt8nOVKHs4lxd6LvQS0
         Gbe+XbDwDx402rqY7veJ/yzP9KR2MPDDL4gQW5/hrt6avVpJ+IBJtdjBb4mYhJZyMvXQ
         SFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060880; x=1758665680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HtegchSCa5XU9sfnXrM28NVIbfPzM314cfpYIxWWTKY=;
        b=WpsjIDdh0GmU7LzwrLsq7Mmrfg2NLx4w8hnpzrTKOyk6dUWLFS9o/dVrHSqRpzBZpq
         e3cXSqtzdNYUUABeF3bdi+XgQrQ2rEm0gdB7O+HGclqVNG8CSQE21LXCug1kWR6ilLSo
         s6dqzs0jAvULPb96OYorZrPb+y1SqhR+v6clWC7hmbvj+edYdHGkucpIT5JiID3WrLVS
         +vdcBAE/FTL+W0NnY1XP1f4QQtE4hf4jDg9e6pFVBaSh97bLOUbBiTOjLgyJONcYKyD2
         SORT+BCYUFLndGhSUsoYDLBbxv/bLb1sUEJZHW3MH47S/yN5V/TbJX2WUHI6sHs0qV9N
         5Z1w==
X-Forwarded-Encrypted: i=1; AJvYcCW7ynMnsT1Lo3EDJZCqCcIklw3Ump/T5YDAF8F+DHyHgmQe2LPOJF9EBbVuA+hJcMPOvkeAWBom@vger.kernel.org
X-Gm-Message-State: AOJu0YymciI9FVl9QibPEWYTAJtmxjoOsaUBM8mbOTtQSECHDmWjAjOC
	iM+OlZrpn7P7sYQWuw6WcjEF6aHV9p3asUGpQl5p5d2VPcnGoJ5C2zU7Zs8ZenPebK4018DQXZQ
	HNxE=
X-Gm-Gg: ASbGncvt31ltgGuC22TYymw3inXtkHHwoGiLlUmqeSXnXX1HCR2t8496TAADm6Ai/TC
	refM1dlmdczq41lHrOlx3jabKL9DojwP1dt283qI197/rvj5Zvq2ffX093rDDHheS+L6mL+4Hv0
	JT6VotCLSr2xDaGzvFFzxHkuRWKnhCudKwlNOdKI6cQgAtqwe/s054MRJITqmNfZHKAhfMpNkje
	xDrKYKI43GM+aE5/QRYQUClbmB5ftYozPWQdJH6WHWIxs40UPGsBqfSUhrHPb3M8Tn59Kud/GOp
	hTUFCo2PjE1DWR5d6O/+A2p2UC61wJ29Ye45T3ebydKMcL5I5LVDAniXSngWhGZZKlx0Y0Nsqmi
	oUJCW5L8hcmDopWgnFFa5Aee0zdvYtzMD5lZJuJSv3dabA72N1rSr3H7aiugvRKysToVd
X-Google-Smtp-Source: AGHT+IFBtJoFWsD0o2rGOm6j2VPEIcQiahP/vCa+JcOsqMi+fAhg74Q8MM/WTVraL4VOLSQGVZ/TDg==
X-Received: by 2002:a05:620a:1a12:b0:818:463c:bf63 with SMTP id af79cd13be357-823fbde8d90mr2110093485a.4.1758060880374;
        Tue, 16 Sep 2025 15:14:40 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b639cb584asm86892091cf.20.2025.09.16.15.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:14:39 -0700 (PDT)
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
Subject: [PATCH v4 33/34] lsm: consolidate all of the LSM framework initcalls
Date: Tue, 16 Sep 2025 18:04:00 -0400
Message-ID: <20250916220355.252592-69-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2910; i=paul@paul-moore.com; h=from:subject; bh=0y4h5n+IXD8P8dnjxt869LYF6Svfv5Pqp8Njr0WLUEY=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd81ZhVt7iE4Za3r+URKe/epHxYCGMGTDuGkp avlUSAzOGqJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMnfNQAKCRDqIPLalzeJ cw0tD/9BFUsIKvRX5fs73F0UWNfQKM3Yw+hkk1u4hvhqZt5/6ST62mBpj+TFZhsKwuKNJiaDsRs NZkQOsEqYpzJ+gxs6pd4vY93wsOafq+RJct85LegCq4EWPpNlfOtJdL+K79z9YXsHrnNxQPtHiz fkehJ2goI55e3HRMe5yKku3+Qs8rkuF9IsDOwNjlTtMKhzLkDqREAFnOGBj0KK41mXZyrcI6R0u 1pTM6arSnmrhrUHWXmDHBysY2MSEWeuUAfLGy5zfObEo1v1N90enx8zi1SK7T77hSkRng/ZL1ST /P1FnKPsFyAd20H5tICrkSrR7MwHma8Aun4AMsYk9z2Az85n7KULkz2GGmFQ2hlaYPyUZRSQLJF H5Y14IugRkHOBA6/WmbPIeSz5dUuZHUrI+lJwRuX7K1Yua+AcChVO4ShpKJEaQZrBJNQHbcKiFU EEwiINlAOk+RXCABfS5o/xAYc+F/NuZLNOQoo6p/nYLnmLwBTL0RQaehYgv7v5VHyBxM82G6IQh Mk7YS/ySUpFZLXOVUu1gjeoZ8w6hRkFobMbB5/7WQqk2UsDC/WYYv7+4n7JpkbSO6wivqGpBFab vRB+PVoWww+FcQNbSrcWNR/G1DR/I43ubhffOjCMdKTLqBKwaupJMvO83lqHimoOshdsvX/usgA g4t89VNedo7LzMw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

The LSM framework itself registers a small number of initcalls, this
patch converts these initcalls into the new initcall mechanism.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/inode.c    |  3 +--
 security/lsm.h      |  4 ++++
 security/lsm_init.c | 14 ++++++++++++--
 security/min_addr.c |  5 +++--
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/security/inode.c b/security/inode.c
index 6620c3e42af2..ab8d6a2acadb 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -368,7 +368,7 @@ static const struct file_operations lsm_ops = {
 };
 #endif
 
-static int __init securityfs_init(void)
+int __init securityfs_init(void)
 {
 	int retval;
 
@@ -387,4 +387,3 @@ static int __init securityfs_init(void)
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
index 697482a22a02..2bd705836df8 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -488,7 +488,12 @@ int __init security_init(void)
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
 
@@ -506,7 +511,12 @@ early_initcall(security_initcall_early);
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
index c55bb84b8632..0fde5ec9abc8 100644
--- a/security/min_addr.c
+++ b/security/min_addr.c
@@ -5,6 +5,8 @@
 #include <linux/sysctl.h>
 #include <linux/minmax.h>
 
+#include "lsm.h"
+
 /* amount of vm to protect from userspace access by both DAC and the LSM*/
 unsigned long mmap_min_addr;
 /* amount of vm to protect from userspace using CAP_SYS_RAWIO (DAC) */
@@ -52,11 +54,10 @@ static const struct ctl_table min_addr_sysctl_table[] = {
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
2.51.0

