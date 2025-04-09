Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7697427935E
	for <selinux@vger.kernel.org>; Wed,  9 Apr 2025 18:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224820; cv=none; b=gOevf912RR2W8L8Rv6JrfQwnftesjdrIsUIFrHJeGCEEuRJpuIfAxt4IXglJDBdqh8iBwLJtB4SAANB0K5e6BK2YPXGoM1lMrcxA8NThRmxcRBAQdJ2vd4bHugZMXQzVC9/PD/Jb/dbwQZ45WX5/BCh733BY+nmAV9kweNDyndM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224820; c=relaxed/simple;
	bh=1NUIa+5KjxYrVyC8+UdcbY2PiKn4glw3Vh9B27xCfbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJkkiuBfYYJzVwiE6L63+YT1TLwz1JwQEFWBJT/QHS3G2Rpqc4AvLqJ4kOcB82ryKDc2yLkT/AwABK1AXhmPXbdNj9C41gyrk1ot9pZc9L+UIXD9nw47L9TCfYo2HOssTYgthUhDu5KEoo/BXT9OYqy609uinp2Utc8TglIJIw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OCKCOOuL; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OCKCOOuL"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-477296dce76so61339141cf.3
        for <selinux@vger.kernel.org>; Wed, 09 Apr 2025 11:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224817; x=1744829617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myeGk1VKg+RuG9Vt8oAIZ4CZoF5fEne+HCtdGHf+1u0=;
        b=OCKCOOuLINTjd0MXneCu9wYcOhGrgIutXcJGMtSgwW8nlesaiaE8dgHt4/2vjxcrIE
         FhRyzcoHKCxQfpHN5GqsZQ/LzhCZwvYZnX2kIOM2jrOMRj0tt+4R+rN9SKqn+Lrq8Ufh
         29UV/w5fPzQ0fVGn3WakmLpfdokGvnbfHikgdaFtpE8nT7oOWi8yVymss5MJ3Z8Z3ik9
         NQQotstDcfw0helm3M12tqeguorG0nLyixdpR1sKcW8k2wnFKYcfTU5pkDfPJVB/W7Pp
         nNgTGdtRIq69qi070Wn+Psux2BrdQLtKC2Jf4akMXBU7tcKJtiRXtSrwJhXlxd4krR4u
         hfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224817; x=1744829617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=myeGk1VKg+RuG9Vt8oAIZ4CZoF5fEne+HCtdGHf+1u0=;
        b=bTgNz7U4PnbCGpU4CCJOcdkQLJPydWKRz1QEt9rEJVSfST2Jjiqd58M+Q9gtjYMxXI
         3SL7CNQ4+n/TAMXXE1VFcrw2tCyqx0gLI6k6JkPGRsuBxCXyC8BlQcr68tAu7rTFbTLD
         Gk6KS4GVyqtoaztmf+E1pB05PdAxHcrEIzM3txOLgrhjbh0S1fTdG+xI0NOuNHDFkWYd
         YDc5FBdu3FuBMLhsTg6yu/FtsDWVMps+MACjn70uSckdf91XW5Bx4fjjOaYOPXRpJ4e3
         MccKUg7DC154Oh+qTDnkuSIrXqzoA7/9Lgb7Az8iNbLCEdheP7yP+se8C43+mShlO7VW
         tiPw==
X-Forwarded-Encrypted: i=1; AJvYcCU1AQKLN2W6XC9e4lXkuVFzA5GNu6Yi+4Y5dzm9gsTFVty1ydjgvtsnc6az6VK2fJI9qvyzWlw1@vger.kernel.org
X-Gm-Message-State: AOJu0YwfSE7/vU7Ed3O7z8Wr93oausk5gHN3oIwWkuw9Rq55AearXm+3
	lifjuuWRRfkx6GcfYO/UfbjRcVPeAtIahtS8ow1/0YoNE0E96MgK5j7ABEIUgA==
X-Gm-Gg: ASbGncvsSEUojr0UBN8OzeaAkTmEgt4Phb6jDKIcYcGv71HKu0LUQ+DdBHK/zmCUC5A
	CDHG/p+rJKnHZPs8QeBnICIGDRvNhK1TzSo9fSyz2//ULMhEegM3hq6o8VHVAxAyJA82ut/kJqy
	ZZ+xIg3b5DCPtD4Y2i3mKLTeC74MVfu70WLAwW4XsnlsrVnApZUwjN2AoLiEZz0sQceLC1H8CBy
	ELbdj+TN9DPV6kcmyBYjUOSZSNczoAsuWudYgPS4FVhss3Ifcu8sGBAg/ZbpGmuEq10ZHYZ+cZu
	vrZza1mdqEgaBjdjTd3s9fXyjPXKcKnTZ+3GE5X18FCKQ6kOp6dlOSajR2MlK2ro6Ltp+Y72YmI
	tEbTGu2u/og==
X-Google-Smtp-Source: AGHT+IF869mOZKjkkllrrLrKf36gaby9+NevM7t7gjgk6kSd4DDLB+ScY5iVQTnMjkAgz0yr5T6k4w==
X-Received: by 2002:a05:622a:1355:b0:477:6e8d:6081 with SMTP id d75a77b69052e-4795f2b15f7mr47540421cf.3.1744224817218;
        Wed, 09 Apr 2025 11:53:37 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47964d71c25sm10459981cf.15.2025.04.09.11.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:36 -0700 (PDT)
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
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 08/29] lsm: get rid of the lsm_names list and do some cleanup
Date: Wed,  9 Apr 2025 14:49:53 -0400
Message-ID: <20250409185019.238841-39-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4306; i=paul@paul-moore.com; h=from:subject; bh=1NUIa+5KjxYrVyC8+UdcbY2PiKn4glw3Vh9B27xCfbU=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sGZ8Qx+Hz4VG7LIyRoRI0huhIRkKmkeTJHHt VrxtDvlCrWJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bBmQAKCRDqIPLalzeJ c9G5D/9S6JPn8naTO8uu0nZdxUikFgCM8ZUNqwDAt9gGeM8mYoq5/7ogzA11hkvaDWBpQMUaExQ jAjDLTa6ONNqfsKvb/w52zmbdNQuCQn6aYjVjVX51D68Uhb7iCaqCzzOlOACDPY2JCO3GCn6UH9 HGNulCCy5JKEcZkkTD6slyvUHClYchdqCkUuNWQuLW/w8RKraeQyhukRMTKhaEImCnm4lLQSt3t t/sdUnm1eo5pJexzBtWws0XhMG1JXLGdcFL8B0YdRlb/63nQaP9UkWJrrJ2t2nSeZ76N1J+qRsp Tmny5x5ZBlZbCvCTSYEu4XprlTROb1R3knFTFhuZeS4EXtYpB9CwVJO0q/Bq94p6C1GfMqvP5kP RCbf9EBhNZ9W8zn0Yox733fIkkA7lEcTkEwoYGRZUJC2JsWFcuPu8llGyG/UUrvJzo7mS9huuIv Vcy/76P1P5k0BaHeOR4aWVcwp+SqZ7eK29/n2IdA9I5V438Nw5PRMZANKw4cVEZv9Gp3rRcnGCh Wa4bK46+m9bqH8/Bg/A+9OBDBtNPDQPvY2m20+RWX3BJ8LWEdl3IU+QjhqvLURuBSlHkNsxvg6P AHl1CEvULin8DaQXs4+88U6kGD9jzUkNAK67x1lfBDD2JMurfXjQmqPQEcMk2EUSIT82NiO+oZy RBaBfUuTCPcbg/w==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

The LSM currently has a lot of code to maintain a list of the
currently active LSMs in a human readable string, with the only
user being the "/sys/kernel/security/lsm" code.  Let's drop all
of that code and generate the string on an as-needed basis when
userspace reads "/sys/kernel/security/lsm".

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/lsm_hooks.h |  1 -
 security/inode.c          | 27 +++++++++++++++++++--
 security/lsm_init.c       | 49 ---------------------------------------
 3 files changed, 25 insertions(+), 52 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 4cd17c9a229f..bc477fb20d02 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -169,7 +169,6 @@ struct lsm_info {
 
 
 /* DO NOT tamper with these variables outside of the LSM framework */
-extern char *lsm_names;
 extern struct lsm_static_calls_table static_calls_table __ro_after_init;
 
 /**
diff --git a/security/inode.c b/security/inode.c
index da3ab44c8e57..49bc3578bd23 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -22,6 +22,8 @@
 #include <linux/lsm_hooks.h>
 #include <linux/magic.h>
 
+#include "lsm.h"
+
 static struct vfsmount *mount;
 static int mount_count;
 
@@ -343,8 +345,29 @@ static struct dentry *lsm_dentry;
 static ssize_t lsm_read(struct file *filp, char __user *buf, size_t count,
 			loff_t *ppos)
 {
-	return simple_read_from_buffer(buf, count, ppos, lsm_names,
-		strlen(lsm_names));
+	int i;
+	char *str;
+	ssize_t rc, len = 0;
+
+	for (i = 0; i < lsm_count; i++)
+		/* the '+ 1' accounts for either a comma or a NUL terminator */
+		len += strlen(lsm_order[i]->id->name) + 1;
+
+	str = kmalloc(len, GFP_KERNEL);
+	if (!str)
+		return -ENOMEM;
+	str[0] = '\0';
+
+	i = 0;
+	while (i < lsm_count) {
+		strcat(str, lsm_order[i]->id->name);
+		if (++i < lsm_count)
+			strcat(str, ",");
+	}
+
+	rc = simple_read_from_buffer(buf, count, ppos, str, len);
+	kfree(str);
+	return rc;
 }
 
 static const struct file_operations lsm_ops = {
diff --git a/security/lsm_init.c b/security/lsm_init.c
index 981ddb20f48e..978bb81b58fa 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -10,8 +10,6 @@
 
 #include "lsm.h"
 
-char *lsm_names;
-
 /* Pointers to LSM sections defined in include/asm-generic/vmlinux.lds.h */
 extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
 extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
@@ -363,42 +361,6 @@ static void __init lsm_init_ordered(void)
 	}
 }
 
-static bool match_last_lsm(const char *list, const char *lsm)
-{
-	const char *last;
-
-	if (WARN_ON(!list || !lsm))
-		return false;
-	last = strrchr(list, ',');
-	if (last)
-		/* Pass the comma, strcmp() will check for '\0' */
-		last++;
-	else
-		last = list;
-	return !strcmp(last, lsm);
-}
-
-static int lsm_append(const char *new, char **result)
-{
-	char *cp;
-
-	if (*result == NULL) {
-		*result = kstrdup(new, GFP_KERNEL);
-		if (*result == NULL)
-			return -ENOMEM;
-	} else {
-		/* Check if it is the last registered name */
-		if (match_last_lsm(*result, new))
-			return 0;
-		cp = kasprintf(GFP_KERNEL, "%s,%s", *result, new);
-		if (cp == NULL)
-			return -ENOMEM;
-		kfree(*result);
-		*result = cp;
-	}
-	return 0;
-}
-
 static void __init lsm_static_call_init(struct security_hook_list *hl)
 {
 	struct lsm_static_call *scall = hl->scalls;
@@ -435,15 +397,6 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 		hooks[i].lsmid = lsmid;
 		lsm_static_call_init(&hooks[i]);
 	}
-
-	/*
-	 * Don't try to append during early_security_init(), we'll come back
-	 * and fix this up afterwards.
-	 */
-	if (slab_is_available()) {
-		if (lsm_append(lsmid->name, &lsm_names) < 0)
-			panic("%s - Cannot get early memory.\n", __func__);
-	}
 }
 
 int __init early_security_init(void)
@@ -480,8 +433,6 @@ int __init security_init(void)
 	lsm_early_for_each_raw(lsm) {
 		init_debug("  early started: %s (%s)\n", lsm->id->name,
 			   is_enabled(lsm) ? "enabled" : "disabled");
-		if (lsm->enabled)
-			lsm_append(lsm->id->name, &lsm_names);
 	}
 
 	/* Load LSMs in specified order. */
-- 
2.49.0

