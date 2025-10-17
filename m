Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D35354AE1
	for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 20:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732938; cv=none; b=XEZXinIdhOMckJlvtDDi0RQxLEtYjfHWbiFpaSqxsEsv99HmV/VlK1pFyGdlpc8xiS3AGEAaqi9q6Zzq42AdgeRZB2hmqn9y3BJL7xes6fdpWeXE1L1IQotzWaM2mUN0mZ8HT+yVJHjFpD3kCi8QpN23X0XfH/iuPIEy2C30d7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732938; c=relaxed/simple;
	bh=qdUnMpBaVn9BGNCw1u96yzFWHDjooLF/olbdGuAgc44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3NI7OzqXRjTr2MkYwnn3WVHC88lpjVcMyLHuqG/XHucpWSHMr1+qNr8fsLgYrpy43SBvnEqqpy9prJ/bx0TeQTFrlkdbpJ4Sl0KDgTeIE6IE/7prD+kCzWjxI/+XsAuNU3qwgS5Pg2Y+knHKhIM/ELXSCF4a5OiiNT/fMhiF30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YsmF28rt; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YsmF28rt"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-88ed6837e2eso495840985a.1
        for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 13:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760732936; x=1761337736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gnyH9cbKjBW9gdzFmBf71O1ujrCNxqhuDpvD2UTHCA=;
        b=YsmF28rtD/Loadb1Ibn1BWaS9s2Lo1BPts6rJMB55WRrKYGOS2mlqlc1kEjLjUzZX8
         ksIagJcPr2d1DJxLhaqMzbSZUaGArWbvt+7e3kyYLOho8RsWByWaVoU2kzQZ4t56QcEe
         Fcna7xZsOxEfwF3L6W6inHy5enLUAPZ80dTL930nrhqRnML3/Z+JEil48KALjd7y4SA4
         8mVD3hObLCBZsDXVu7jBHA9n8S0e40YROt7czGPC1DtpP7zev/R058i5sFI5v5cKGf27
         DUwZMHrmZXhwnl3Ld+RuxZGqXdbf3GpNrKtRFUgDj1sqkf1+h6xLPfPb7PPHPvsc/bZD
         Gv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732936; x=1761337736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gnyH9cbKjBW9gdzFmBf71O1ujrCNxqhuDpvD2UTHCA=;
        b=KRyVg7yxvxYGVNZXemvuTzp3QeW96gF1j6PQfkc9FI6E9OrydqEEh1aDyZdyVaD66o
         5fYKooU4rDpXHZLcqU12JWitPY5juilT8PRR533pWD95Em78eXJAqI+J/tlBkGGugL5X
         JzO2NKXj+m1gLZuDtJDDE03W0Y0oV80Mu0aV4epE3WPu+14diSz3if5SmD9VEwTdB+59
         KJAbUpUiLIHcJ381I2LgdDnFsthEw0A8vAdg6/pFQB0vIzYR4GPtToZcuZwOW6kBVkSD
         7gpAiJZmvXeq3OfTvX+95TyCS+dYcGZPs7HIXksFWJZSM4uityk26iqiifuU4OEcLIF9
         0yEg==
X-Forwarded-Encrypted: i=1; AJvYcCWHAW+O1dV5R1GERgagpZKRzgFhiklwEWoV7nIrAxxf70M5EnsAV4KbuSxBRTfQCsPPeMiEIZUC@vger.kernel.org
X-Gm-Message-State: AOJu0YxJSGrTcJBCrWYrf1HW+LXo8ssOxhMrd0h4gJWFsisu63ORym/k
	WkSIVQR7x2yiX7RnvVwEuBCrnaQsJXlZhOLgCo3PxWVGHykqNgkaDPOOQUzM4cBDoA==
X-Gm-Gg: ASbGnctW5oX/HRhayd+dqUSMDOd7wFpxU7aYqBToF4A1MTqXO0aexPgV/c9yfH3hzqK
	RjvdblxnYctADOb5XZJ5pdmn1lr0DiDT3W1Y8wkCHYmC0BeTnfoXPslYXYu3ytsTaQxx3R3Ca5J
	/1jnruzaU2d6byFQz85uBb7A2hsP7lk+VVgtNuACQYYcBxdBimCkASvjA6TXfC3Rbg6RGsGtQ/Q
	yXNNWIHHPq0FY7+X3P2blQzjEQH747gblZIF1jpj0g5OFOeZHorXIykmR/Z4OiRs+1kpU0nRPb+
	uAtCFp5ZFhl+mdHinuz0Tt9gl/+mlBut84C6HPkLOmfa85K4OoiN091jcuwC+6mn21rVECZN0vS
	KR9edpvGkr3NQ/pRGYXwyvaI1GI7uruGYvWdqvYTlppnFy2KNTFOl9fZjg+c+aX/44SkgKhQufc
	BOOJ/NFEMmJZxl3RdYLUvZnI8OVOKsde2LB10RGi/Tpoye6t2nU+ElARP6
X-Google-Smtp-Source: AGHT+IHQIBfcE+nIWOaxuE8TLpwMaeLiAUUd6n8/4MfK+EyLxPxrOWP5Phio26ynqjU/WCoGKSrodA==
X-Received: by 2002:a05:620a:701c:b0:88f:561:d95b with SMTP id af79cd13be357-8906e2d0126mr717378085a.7.1760732935665;
        Fri, 17 Oct 2025 13:28:55 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cefba740sm39301785a.29.2025.10.17.13.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:28:54 -0700 (PDT)
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
Subject: [PATCH v5 06/34] lsm: integrate lsm_early_cred() and lsm_early_task() into caller
Date: Fri, 17 Oct 2025 16:24:34 -0400
Message-ID: <20251017202456.484010-42-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017202456.484010-36-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2054; i=paul@paul-moore.com; h=from:subject; bh=qdUnMpBaVn9BGNCw1u96yzFWHDjooLF/olbdGuAgc44=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8qYoWn5623fTKZwAy24y+L8F9fHQE+JKWV8eX vDWwYgACKSJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKmKAAKCRDqIPLalzeJ c4lrD/9KkEaJZF4fWCcnp/FqSd1LGB3hjfs9oF/aj9gL6UMe78OILLDZYYLj1AaNi5ddVIehpuk 2QwBovxW8dPJUOAuujnj9kyx5pvAFb4mU6p5zXI5udSzngtIn2qbz9hSPoxQkj//JCazECkewVa uqVhRulE6PAC11DdyTPc1gwm92hqNldFEZimS6V6mB1C8OUnrLx/RmNJCoyskQQk8IdfzzKt+JX dPpvwireTCAwi3bD8o88Na8DqDrZrSoNp9Ai2UP3hBkS+goSSwkhoSa1VZ5+BaGFEo3WGjmBLPC doWkLCVX8xcI1y+VXx8y01jaIozJkjne1/ZdqiZFZ4oP127UCr7Yeftc/xDCDDU4SHWZIZnF83j b6nNhe8DixfGSIAOW6sUidXVxuWlmaGw5kJmP680JkNDs2sRBkWz6m2kjI6NV46ZXfFL8fH2rfk JsORpgVal5/YGiaL1dsaxKv/PIJGxQgjuj6xzfatoOu40gZPWJBbf315bVL18XquxhJohRnjjh3 euY8Rt7ovrUv7RQ5zI0afCwF8AwcBF7YLhgugns8Fw6xggfABFNu4U06YTPe750nE8JZca3UJZF rLnE036lEcSXsPjbCQpxGq0vA7MVMFHvbzFZ4PAHo9afwXeuhGc0Pwlnh1iV/dyT1Nl08dksWHG FWUeOhlI3ILIomA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

With only one caller of lsm_early_cred() and lsm_early_task(), insert
the functions' code directly into the caller and ger rid of the two
functions.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 35 +++++------------------------------
 1 file changed, 5 insertions(+), 30 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 09afa7ad719e..8bb473aca113 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -291,34 +291,6 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	kfree(sep);
 }
 
-/**
- * lsm_early_cred - during initialization allocate a composite cred blob
- * @cred: the cred that needs a blob
- *
- * Allocate the cred blob for all the modules
- */
-static void __init lsm_early_cred(struct cred *cred)
-{
-	int rc = lsm_cred_alloc(cred, GFP_KERNEL);
-
-	if (rc)
-		panic("%s: Early cred alloc failed.\n", __func__);
-}
-
-/**
- * lsm_early_task - during initialization allocate a composite task blob
- * @task: the task that needs a blob
- *
- * Allocate the task blob for all the modules
- */
-static void __init lsm_early_task(struct task_struct *task)
-{
-	int rc = lsm_task_alloc(task);
-
-	if (rc)
-		panic("%s: Early task alloc failed.\n", __func__);
-}
-
 static void __init ordered_lsm_init(void)
 {
 	unsigned int first = 0;
@@ -382,8 +354,11 @@ static void __init ordered_lsm_init(void)
 						    blob_sizes.lbs_inode, 0,
 						    SLAB_PANIC, NULL);
 
-	lsm_early_cred((struct cred *) current->cred);
-	lsm_early_task(current);
+	if (lsm_cred_alloc((struct cred __rcu *)current->cred, GFP_KERNEL))
+		panic("%s: early cred alloc failed.\n", __func__);
+	if (lsm_task_alloc(current))
+		panic("%s: early task alloc failed.\n", __func__);
+
 	lsm_order_for_each(lsm) {
 		initialize_lsm(*lsm);
 	}
-- 
2.51.1.dirty

