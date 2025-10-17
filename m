Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82040354ACB
	for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 20:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732947; cv=none; b=M65RQdGfaxS/np1QMhqg2prLfi56qhwyh8RCA6EgpjpJiIkzosotqLZkM4V2DVCKwTBv3BGvEWo8gD7cEOnyjDT5iI+4VfdnNA1rZPuQOcjjoNlXZ0BjdkMvRiDu1mZPVp2noQ6202Ht4oTKPT4WQDvP5cfREMEKVJ58ToNqeuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732947; c=relaxed/simple;
	bh=83Vo5HvqAjc/lgvBhTja2wjt9bDFMSvsGhWzU63ltCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=skn0MnCGpS4UEhgOowM9LpkjlfmvXXjZqceWx0GxZvrxlAzOM0VkeBout0ng1/ZouHmnX7UD/8C6XiUoUmQg4k9FMuPgGsgDbR6rnyiEDZBb+6CaHLDJTY56/qqilY5Y4JGmOrq5AszF2ap0Y5aPPLfYNnVG8Zkf/jLF5B4gDq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EqKzJ5/Y; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EqKzJ5/Y"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7f04816589bso356461085a.3
        for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 13:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760732944; x=1761337744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sv10Yvg8poDHRXar8VHP+s5rj8Fg5CQ2bSFzXfA0WR0=;
        b=EqKzJ5/YBWO0QtrYrN3J+ndjsJS00kC2JOJRUDoVMf4z0l4hlYNNTpp68tyfCWTRvV
         Svpiq2VxeQxs1jhQtdGSFJvqQ5xFN/Sm2Jdf0AEU8S5T4oDq1UHfnETjZ1Yp/avNBVbU
         RWwSRiuVwVOwayoNKFdeHJ/Ih4+NFLT0yMxlGhNwWesn4aB43DvHr7X3FQRhEs8GSLqC
         9bdbfl4vz5fdb5gznhrvo9J+FrpjwfljvP4TyLOyw9spgLkf6G5D5PweaH+LPcINnQb+
         aitYDk2BSYdMnB07yLnzOy+y2m6Wil4g6JQMjx/opVLVIIBV/c7tiNDOFouxPhSif6tT
         ehAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732944; x=1761337744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sv10Yvg8poDHRXar8VHP+s5rj8Fg5CQ2bSFzXfA0WR0=;
        b=Ys862oBWro4m/3U/1U/RnAQ4ZZ9G8tV/Se6dVDCOSi6KQu2ZywzKm4aDUibB7m/934
         eZ3W4+LdAg4vgvgeO5l+f/8HFTXXkcEMNJgAUhu6sBq/0c038UgEZCeAbPp1TMc8YcRV
         dPp/p/u5uqmrQVrsJav90y32011Ih3q7ULVL71BDhtXgm7ijnwgHe+fKqFixeBJ5Z8GA
         68TxBDT7+x66WG7JNR47arm/xmw+4OhATR6LBfo7XNeTfSnQ2vFkBW7dZEu1R4ihuFah
         8G+f/4pAHnFT/JDF8gwh2cJWFF3UOkA0mqRHBhHjeisf829eRZT9XmIxHyx4lo/+UChU
         NemQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu3Qo6DGJ/S71FxZyoE1QMPyA8RiO5P62jw7+LxCF0xIN6yvQmdlDVd7fjIq54ahgGfi9v0ZqB@vger.kernel.org
X-Gm-Message-State: AOJu0YxgsxSn12iQLxOm/a0FDGqJDRX06AatJjLxs9Z3jPLGhzGxt3L/
	NlYeigE5Nfy9jtTm71AlxtViRJPPkYAYyXy7WkmE80i8rrcoMxDHb9EVj/9vZawcjA==
X-Gm-Gg: ASbGncuuCM0dDy564zzFv9OitLo4jeRJReUbl6tLLLsf0ZXWcdNJSvbAChhFy+zqI8T
	SAXwFhOxJPjC5EhZ/26+v1D4PQLcU02W+FoosEd5l0lprSDs7xofrQsTEjrSMQ0RN7vRHDV+m+D
	+3Ha1c+ngoxNwibElrBSER6kulu4qzwGK/RRYfI609oXekKH32mLNRSS4andsEnPZ9/IWogS2Nn
	4UFANyf1gV9F8CmGzJLfty61cIQUFs1EVDSrFijv+NGbVB9AQkI23EXi4TjmiGP9ocq6sXSTgUH
	s8+HBQY6TMbBlaZgR6rghxMNS1sTAaHhZ4VuxQNwc4Gi1lYh0IYXHhO8jICMHts/loHsQYShD+g
	J9dNMUk80iXzTfWasjvUCfhZcUfXGPJsmcVmwvXY4aCw+Lly9q8rhc3qD2qFA9NVcx5NtwB01zb
	GH8lJzwzHJ0i5myE6sweuVl+cXrBXT/2STowIcg+NvC1ihoERnO0qrjsyL
X-Google-Smtp-Source: AGHT+IEz2hWe0OAF1xfrMn5cxI9HIMPzaCkVI3uGSO08f+4fy9htghcYQ8g2PHAnMdYx9bbwSJlwFA==
X-Received: by 2002:ac8:578c:0:b0:4e8:a95f:9a61 with SMTP id d75a77b69052e-4e8a95f9d13mr28033391cf.84.1760732944408;
        Fri, 17 Oct 2025 13:29:04 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cf0af579sm39814485a.41.2025.10.17.13.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:29:02 -0700 (PDT)
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
Subject: [PATCH v5 10/34] lsm: rework lsm_active_cnt and lsm_idlist[]
Date: Fri, 17 Oct 2025 16:24:38 -0400
Message-ID: <20251017202456.484010-46-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017202456.484010-36-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3088; i=paul@paul-moore.com; h=from:subject; bh=83Vo5HvqAjc/lgvBhTja2wjt9bDFMSvsGhWzU63ltCM=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8qY1/lTSJU8Yui3usS7r9sApGSJrkTprrPuiM B+LEB451TyJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKmNQAKCRDqIPLalzeJ cw4fEACCBqZtYqcG1lXxZY9RDDrNaP+KlPvmHoMV7ccphZgrGCXTj/oalu+6IriVPPYjuoPRj7Z d0TtpyocNtukGkKi+row07zgObvf3iyR02w/m1Hfykr2GiRQDLEPYI0+yxso8WH6cS1zjaP4ufD 9l+Hpg2O7o8jZ+BESJNHQcmzGqul6B0Xw715HZk3BIQQS1EQ/5JaiwK7MjbxhoNr8MosTZNmp4x RyIB6eNvY0wgk/kRf8IgWaY0CwHNZ1MNU6lu2u01Qbnql8j7sjuE0NtQZ40vvMA/5nf4sRdH1CR 1uEZvPWZyTyzWqsELce0nNyZnOoQ2SKTZN+QDQ2+FH1mbY6En7agpL/aGYwIPRyC4FqTwkI2US8 +sAsRSoWb9tOrY1To4dooyxxI949WqvQgsysjzbHNZOb6cNbwHV9S7bsMGG3UvTGQhmY81/xPas F9cyayrPOMvkCBC6UFLH3/auQgDFiK6YjAuOYKDKOsUwmXPELQB34Foj9cVEohYFITS/5DCJFx/ vvWPZ74lFiRQyoejAgDf9QeyKFPZbz0VfdmVjmeGRW41xSINFBMytAT80AZflg7BtgHZcs14JnV jIoez5JtsCgH4k/Kzv9WPLe4evGUhrpBPFg7GW0ZVb70PRy1gNie0fbPtobVdVkXz3T2qAUqQCS MjoSX2yckZpCoWw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Move the LSM active count and lsm_id list declarations out of a header
that is visible across the kernel and into a header that is limited to
the LSM framework.  This not only helps keep the include/linux headers
smaller and cleaner, it helps prevent misuse of these variables.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/security.h | 2 --
 security/lsm.h           | 5 +++++
 security/lsm_init.c      | 6 ------
 security/lsm_syscalls.c  | 2 ++
 security/security.c      | 3 +++
 5 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 92ac3f27b973..556890ea2e83 100644
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
index a0785ca081c7..d40f31e79bd5 100644
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
index dc9734f0d45c..b4eec4f00730 100644
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
2.51.1.dirty

