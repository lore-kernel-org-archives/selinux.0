Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E25281504
	for <selinux@vger.kernel.org>; Thu, 14 Aug 2025 22:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212063; cv=none; b=dLHXkDIHofYCKb32Eo4V7nPAt2qMA2QQr+1iJrRjMiEWXKYEZuCWCpho8ClTIXo6tdryhR4GTojGxcdJyUiv4d4PksVgMS5bKXybNk7jQw1+CvJ2Z3EQU2IPgu3kcYllu57CimPuPSkX4KaAVKMmRK9/IahGn9DyDvwSyoN677I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212063; c=relaxed/simple;
	bh=cdAwmsME9tatdXpsgja+VB8jLtwd5GZCpIxtIFGJoMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MC1IitPOnzrilQcSvSvG83BWi63WdAN0tdMDnRmcRNho6HbQ4nX39PHiTATcPRHKZTWstaK8R10lPTjiCl6NOitIAhGVthyd0L55mctVzuSy3f5RlqHpNmt7wfhtXnmymX/scP7mUqXsbAIxQ/Oacjj4JHS1L5m2pl/TVvQaBko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KnSEIxd2; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KnSEIxd2"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e87061d120so149413585a.2
        for <selinux@vger.kernel.org>; Thu, 14 Aug 2025 15:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212060; x=1755816860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGtiskV7h6cWaVKpfVHbgiTxFirt7b88QrVlPitnDAY=;
        b=KnSEIxd2eq0bbPk4XriJpSrSQf6gpE0t13gHKf1/04+0jGREeiS+nFMUv8Aym3D/OO
         LxI5oVoOlCQK9pzNkR5Z0zrZzmX2YWf2/MfkKEoEMbbNNsz1qPg5yFBUolkpM6O//m77
         ZgtFMBp2VVOUlj2vUsbX/1FwUUhUaQdsYk5AlcWR9LC88hJvLj6QO0hdgqgAE58Wx6Cn
         rwDcc/bOoCNg+EhtaENkXmgNQ/8Lfpu+OwA5UOQZ38gB3qEEsmHA8hL+jNmUDNRPDhO+
         936yr5DUmlsJtt4SwDnCRNORvEvCqHxEw4bAPhci3x/zOm0uGmasXA1oA+lCh08VikYN
         Ix+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212060; x=1755816860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGtiskV7h6cWaVKpfVHbgiTxFirt7b88QrVlPitnDAY=;
        b=O5arCrrMmeqOh9ac3HzULJkLeRhrBOX8KxkcpudQ0TljOVakjBrlc+FsWXFeO9MkYQ
         tcv4N9QgECRDLnrLjxtEwJ2U3fvx063B8gfAMTWwYUL8mXCaw8G0Ui1P7AUa7742snQr
         Dy1oFQPyqc4aTUghINJ0Qo/MwNfUFlKvAZg8nvp49SpUh1+sMihrWDIgnyvNNKXwEJAT
         Pn12rxy9rZZ8kCQV3yvYTOSo+BL93Hpn670QBWUp+qi0PeMZezPpJZxyw/pJt3RH8Z5O
         EHo5vgqCfTOBYouJj6J4AMTO4KhcPBhbr/nROgaeqL2XoF6z2OS6gOAttMZEswxgPuLh
         daMA==
X-Forwarded-Encrypted: i=1; AJvYcCXoocZOu8SUj96lV4nXhPsVDrDFui2yvPcZnX/AkRrDTavvmRG8nR+2ktIuDH8GmxgZ3SOyy7Am@vger.kernel.org
X-Gm-Message-State: AOJu0YxsHjyGUMBdIjLSpM3Ku2uuwz1Do5f5hDT1hh3v5ERibdesigFg
	ZdQUEZgnV+1h4Vbi97gw+K5s0Czxv5AQ0S+RgTap/0aeOkd7xABl3E7pqJBt8YzXE34Yrbekyqf
	YFGQ=
X-Gm-Gg: ASbGncsDSDolZAuBnv9UQlfZa5Nflty6+Nw3kCjnutXV9993c+ZK0/YNPFKj5H5wdoU
	tzyTWTADu7pD1EXVVExhmVedHxxwnglfbcC9CZeG6hEyR/eerUBT2NeqP3t+4K8jUjTFAqBy2/E
	7leEGiSeRmEEU8Ty7uTwyAf8f77AoU17bTwxNzBUkkewup4kv1HrgrrTg88NE6Ij8SQQraemiln
	PYI4MCRFSuVbVf9DmZEsnIRsP2KEgh7nBWYOqkJxTc7ThT2mtbuUhk6hZQMAWVYdMvb/OvN3Xa8
	oe93v70ySDLhhPGm+F+nIUex2kB8cfanaOyzpE3szoojBNNV7pwPxE21Ki9FWQBMdtnTthHUHBe
	pan26zo7Gi9qNGttGpLKPAK+xJtWTWnCER+QoMUUnmeUIwJPktkM4jyM+UNJCDvfMk+A=
X-Google-Smtp-Source: AGHT+IH7NbcVc92geV3ZhwEV5dlNyEKC/QQTFMrd9ZNQ9Si7QKjw8D4DZOjmsQbWkE6FjaJ6YHHw5A==
X-Received: by 2002:a05:620a:f11:b0:7e8:3b6e:4b29 with SMTP id af79cd13be357-7e870594fdfmr779694385a.40.1755212060364;
        Thu, 14 Aug 2025 15:54:20 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87b4bece4sm42261685a.40.2025.08.14.15.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:19 -0700 (PDT)
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
Subject: [PATCH v3 10/34] lsm: rework lsm_active_cnt and lsm_idlist[]
Date: Thu, 14 Aug 2025 18:50:19 -0400
Message-ID: <20250814225159.275901-46-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2976; i=paul@paul-moore.com; h=from:subject; bh=cdAwmsME9tatdXpsgja+VB8jLtwd5GZCpIxtIFGJoMk=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmis9pSFjFKKKXMCZlXCiBDWEY61fjEz7dMtz NJdqSngyCqJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5orAAKCRDqIPLalzeJ c3ekEACXG+qihwOuchIFgfkL+uckyfqYZHbwmbbGENkTQvikDsc+pIR+PgrN9hnz1nXTZArKRcd fI74Lj5gnR6j/yc7YDf8Fzs9PcB7hSlzJx8uJtwof8r6A4TsRVKNHaf0YPpxx+GXzgO+vfwwnza 4YQKNWCUokf1o0cJRw2O/T60hb1RVp5dZRXs3VE3/wYdbYHRfmA+BgfDoCv8I/CMGxLfT7/CUv2 ds37YmkTsd4NpwJ//G0nj/mrC5t0xzh+wItJgxVVTldrbKvD6sCra3o/WVWHMBBi1EeonLC4TkW mNhQqpJUpUELz6LzNwW7zH+pOUKrst+wEYqz/K3aBKMpCsdmAucGsWg7wlsoVeOfa4YQxfnJy8b xE7qR58IT/iMMni6GGEGfuu/LjW0ZJr/nwkMn6e+mDPpUIBlF58kvU6aYK1Gq2/uvWS49f3nzT6 WJMPAsEnQamf0YQv/vidrfAUmTeRABiKu9vpCAnRj8/Urze7jKp8xWxJSwLCIzTQM4Wf64DPqGj UaM/QZqljzmvokwHQ7X028wYYaBFrtiSDN6/GCVUjUlTTqVMl7DwCjQT9gBOczGYTjIc5lerB+C gGVZNiMf9T36fF+kLdtXYUkbVJdYvcZt7QvgvPMa8hcd+usqt1SPJgCtwAGSe7eQAJpqzFDm3uw Enc9DNvEvf3PwmA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Move the LSM active count and lsm_id list declarations out of a header
that is visible across the kernel and into a header that is limited to
the LSM framework.  This not only helps keep the include/linux headers
smaller and cleaner, it helps prevent misuse of these variables.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/security.h | 2 --
 security/lsm.h           | 5 +++++
 security/lsm_init.c      | 6 ------
 security/lsm_syscalls.c  | 2 ++
 security/security.c      | 3 +++
 5 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 521bcb5b9717..8560c50edd2e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -167,8 +167,6 @@ struct lsm_prop {
 };
 
 extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
-extern u32 lsm_active_cnt;
-extern const struct lsm_id *lsm_idlist[];
 
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
diff --git a/security/lsm.h b/security/lsm.h
index 0e1731bad4a7..dbe755c45e57 100644
--- a/security/lsm.h
+++ b/security/lsm.h
@@ -7,6 +7,11 @@
 #define _LSM_H_
 
 #include <linux/lsm_hooks.h>
+#include <linux/lsm_count.h>
+
+/* List of configured LSMs */
+extern unsigned int lsm_active_cnt;
+extern const struct lsm_id *lsm_idlist[];
 
 /* LSM blob configuration */
 extern struct lsm_blob_sizes blob_sizes;
diff --git a/security/lsm_init.c b/security/lsm_init.c
index 2e76cefb1585..9e495a36a332 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -217,12 +217,6 @@ static void __init initialize_lsm(struct lsm_info *lsm)
 	}
 }
 
-/*
- * Current index to use while initializing the lsm id list.
- */
-u32 lsm_active_cnt __ro_after_init;
-const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
-
 /* Populate ordered LSMs list from comma-separated LSM name list. */
 static void __init ordered_lsm_parse(const char *order, const char *origin)
 {
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index 8440948a690c..5648b1f0ce9c 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -17,6 +17,8 @@
 #include <linux/lsm_hooks.h>
 #include <uapi/linux/lsm.h>
 
+#include "lsm.h"
+
 /**
  * lsm_name_to_attr - map an LSM attribute name to its ID
  * @name: name of the attribute
diff --git a/security/security.c b/security/security.c
index ff6da6735e2a..add46073af0c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -73,6 +73,9 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
+unsigned int lsm_active_cnt __ro_after_init;
+const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
+
 struct lsm_blob_sizes blob_sizes;
 
 struct kmem_cache *lsm_file_cache;
-- 
2.50.1

