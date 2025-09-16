Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7267A2BEFEB
	for <selinux@vger.kernel.org>; Tue, 16 Sep 2025 22:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060838; cv=none; b=f3GUxfA8NWzrpoEKg9CNJVd1I1Pnf/bQsEGZtJdNIcQlSUYcQp8a0OZxROlbWch5oTFvwqPg7HXho9dtS3oyg58Z7pMzqj8H8QiNdazOqY+nvvhs9jF/ennXGLe8GGi2HR31zUsR6v25V5pGP5PMRqqRELV5zmJGU+7x/yokDD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060838; c=relaxed/simple;
	bh=FkDE92QkjEwsaU1vRCzvnORuP6x6IKCSOBm1QF97B4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5hN7XQoTmASwsjro8BZxxqDeYq+tvr9t1hxKLLu4m/M9VCGRkEmrd+5w3DLcbVL6/Rle+3vDVjUJ7V5lH8rCAIg1JOAt+s1AoRvtqOaP4T83/tyqM4DWx1nYQBBmTRS4ZGZ2gTD9A723+Ce5kFCcXIZovb7kjaYKm/HB32Cn+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Sa2i7eva; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Sa2i7eva"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-78d73eef306so9903526d6.0
        for <selinux@vger.kernel.org>; Tue, 16 Sep 2025 15:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060835; x=1758665635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXX/STL9p1pFBmFA6E0oXZggEE1rtoD3UmaJihGS2+c=;
        b=Sa2i7evagk8kIskCQbw5rAG6DQ1BNJ5vVZF9P8EnuZNy+DGA1KyO2NDgtc2unYzMVH
         FSvor2nxjwYuXnTG13PoiXV9ob8aTAgWL14tSi5xrTkDQc4VjehhQhvh7+hQoSa3YixI
         yMCT3/CM4Ddfw1gtGyDo7bqjbfhvlWcyuVHax9SX6Q0Gh/rn+vJ/yS8TTcZQapBTWcNr
         YiBByOJVODYEuOQIEH+rqbF994JVzRJvE5iItPGssE/goOE/ukNlDvIWZQj7MjVy4EEC
         TuJcQ1l81x9Qz96K2OxxuUlmqL2lFDWRrI3uNMYQTFYP123GtPeQNC51I6YDagv9rDSN
         aN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060835; x=1758665635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXX/STL9p1pFBmFA6E0oXZggEE1rtoD3UmaJihGS2+c=;
        b=RuO+3D8T0zMxrDFZSfOzTNbu1G1Qwk601CgVGIFvlnmx5WU212irw2Z1XkyCcPUpQC
         qTLqqB4w3FcGPLVR7cfmldGqVmqvhOc1Xh7lInNs+4bOId1JxnUqYVDQLqvSnmoRs2Fn
         bNe2xVGF3wjAwRGzDZMPwHTiMbjbuDp/7Rcvyn+MjZvLf7y+6A7A0FmqSfa7qLtLB8Xz
         Mq4e8PurQ99xB7CVHUjU49XzfnUwobzhLOc+KG+rj3UDCG52VfHM+j/ACBmf9qEnXw83
         +IZ3YLKlWmoBXfDNPSNZ5wN7nlesTZodZdMaRDnKHcGcXhVlUrP1Y6RtNfzMpCUfSa8e
         xZ5g==
X-Forwarded-Encrypted: i=1; AJvYcCXmb4GzIQWHmrQIVScXQ9Mflafsts3DpG2zngE8MGxbaTTzkeobK9/hff/ouWYaa7G0PYPJor2i@vger.kernel.org
X-Gm-Message-State: AOJu0YwtMOgCFilnRDeaQhI+/Vdp2Fi98+1wFef4xvYd1vVIm42tvaVq
	N9CHCqYYQkCCZPfuEqwHMhvkjfK3H6ByZrU3LrQkR9kROhu8eFYJ9edUWzaXmJSfsw==
X-Gm-Gg: ASbGncumDt+9GFkl+4keGnAnKGJv9y30cY3wmIW7rcTGYH6Qb/vRMhUJLfD67WmebGl
	zOHyX0eE3cPf5C78PwvfLDa60YHrd4ivJ6C4Z3pfeqBUGvh8UR+J4IB10gJ0Beq0IWOwT9fISAY
	Dmg0m0LjI8jjsSfR84zmw+klqI9qPi3LmBzWChTRUwKYNJMLvPbh8+7V/2lFgv9ZDsbwypJ0C9n
	7RwJ730uUpH5AI2IyC0zSbRify2+aeRzaiPlGDPAUbR/6Amw7mH8CC+8netj1f1+5iPzBlr/GwA
	VKfFfYtvyHykRBPlvrhEDlCOJDB0hD1TKVoFat1wavAvkdHe7m8Mb/CichNjfTBHxN5T88FbdO6
	opVoxb+N7DCJ6e01po14VmsnrWPfMcN8t5bLSVPnfZyNhU4BQxBaQf5Y6F/9zy9vmmpm8
X-Google-Smtp-Source: AGHT+IEHYn/uGoFEnvm+oiawRJtmPY1VLin/2gx1TwACE7xXhpRVqzwBbeL0C677re4KgJXtZ8IrNA==
X-Received: by 2002:a05:6214:29e7:b0:784:bd2b:abbf with SMTP id 6a1803df08f44-784bd2bad02mr87379746d6.24.1758060835237;
        Tue, 16 Sep 2025 15:13:55 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-78b032f9600sm27873266d6.5.2025.09.16.15.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:13:53 -0700 (PDT)
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
Subject: [PATCH v4 11/34] lsm: get rid of the lsm_names list and do some cleanup
Date: Tue, 16 Sep 2025 18:03:38 -0400
Message-ID: <20250916220355.252592-47-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4778; i=paul@paul-moore.com; h=from:subject; bh=FkDE92QkjEwsaU1vRCzvnORuP6x6IKCSOBm1QF97B4M=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd7sXUmgtOL4KSqsVi9QW7k/9kyb68oGzLvIB sWP6MJFvCqJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMne7AAKCRDqIPLalzeJ cybEEACmVvZcsTCI4IE2VIG5VRRaDat7cXc3hDq/ZVZGksqsyHP3WyeSYm9v8X1tlIKK8lK9wIA CO2iThk+BRo6YyTV3ycS2Pi/2GT/UP/ghNEAHa8urHz3VK/pLmSGQRAG3l10MJyCONz7PxfeL9I 6cLAXPEE8ePGXgh8DZPpQCxa9YdPZDHhYmmskITpWJCC8Wc9YiJRQWaJNElMXMS2TSYK96b45ip fsZg4NeC594KUsUB8TcylMa+lxUlLpaSxjcjY/JmRG0UIYWvbLcCZrJ0gHeJlfXavofmz1jjY6V R83TkzddwDvgfV0oimJMnscdjIJ/1nbD3tJ23CYkcO0iuO0tT8MqEpq+RHXE6jxGHE4Q4s9cTu1 DEsKZZJxDslfa61b06eMrvaLSFfZ/u8Fpm0TeqH2tz+9/mGO0e7JCzgZfqqd4a0JHWE6X63U6lm /8VF7F6/pX+i3dUSRG3fYSkvmwc5ZLKtct//lHpN2CTm4oR9cT3dVZXqiGtTLHfnOdhOFS4R1TK KSuKw8b1HkMGeGTmtRi16dORZcJFAdPqkSkvSCVXBeAvaKTARHByAIfqA7moKYcFxVYLGRfyOPz DfIH27rH+Rzc3wsE+XAAnxNBLmNQlZPoTqpgiBqNtIax7MW5YspMWOkx7pzv/e5+CbUhL9waymZ M9VBkUCMLvzdPng==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

The LSM currently has a lot of code to maintain a list of the currently
active LSMs in a human readable string, with the only user being the
"/sys/kernel/security/lsm" code.  Let's drop all of that code and
generate the string on first use and then cache it for subsequent use.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/lsm_hooks.h |  1 -
 security/inode.c          | 43 ++++++++++++++++++++++++++++++++--
 security/lsm_init.c       | 49 ---------------------------------------
 3 files changed, 41 insertions(+), 52 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 7343dd60b1d5..65a8227bece7 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -172,7 +172,6 @@ struct lsm_info {
 
 
 /* DO NOT tamper with these variables outside of the LSM framework */
-extern char *lsm_names;
 extern struct lsm_static_calls_table static_calls_table __ro_after_init;
 
 /**
diff --git a/security/inode.c b/security/inode.c
index 43382ef8896e..6620c3e42af2 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -22,6 +22,8 @@
 #include <linux/lsm_hooks.h>
 #include <linux/magic.h>
 
+#include "lsm.h"
+
 static struct vfsmount *mount;
 static int mount_count;
 
@@ -315,12 +317,49 @@ void securityfs_remove(struct dentry *dentry)
 EXPORT_SYMBOL_GPL(securityfs_remove);
 
 #ifdef CONFIG_SECURITY
+#include <linux/spinlock.h>
+
 static struct dentry *lsm_dentry;
+
 static ssize_t lsm_read(struct file *filp, char __user *buf, size_t count,
 			loff_t *ppos)
 {
-	return simple_read_from_buffer(buf, count, ppos, lsm_names,
-		strlen(lsm_names));
+	int i;
+	static char *str;
+	static size_t len;
+	static DEFINE_SPINLOCK(lock);
+
+	/* NOTE: we never free or modify the string once it is set */
+
+	if (unlikely(!str || !len)) {
+		char *str_tmp;
+		size_t len_tmp = 0;
+
+		for (i = 0; i < lsm_active_cnt; i++)
+			/* the '+ 1' accounts for either a comma or a NUL */
+			len_tmp += strlen(lsm_idlist[i]->name) + 1;
+
+		str_tmp = kmalloc(len_tmp, GFP_KERNEL);
+		if (!str_tmp)
+			return -ENOMEM;
+		str_tmp[0] = '\0';
+
+		for (i = 0; i < lsm_active_cnt; i++) {
+			if (i > 0)
+				strcat(str_tmp, ",");
+			strcat(str_tmp, lsm_idlist[i]->name);
+		}
+
+		spin_lock(&lock);
+		if (!str) {
+			str = str_tmp;
+			len = len_tmp - 1;
+		} else
+			kfree(str_tmp);
+		spin_unlock(&lock);
+	}
+
+	return simple_read_from_buffer(buf, count, ppos, str, len);
 }
 
 static const struct file_operations lsm_ops = {
diff --git a/security/lsm_init.c b/security/lsm_init.c
index 9e495a36a332..87e2147016b3 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -10,8 +10,6 @@
 
 #include "lsm.h"
 
-char *lsm_names;
-
 /* Pointers to LSM sections defined in include/asm-generic/vmlinux.lds.h */
 extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
 extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
@@ -371,42 +369,6 @@ static void __init lsm_init_ordered(void)
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
@@ -443,15 +405,6 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
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
@@ -488,8 +441,6 @@ int __init security_init(void)
 	lsm_early_for_each_raw(lsm) {
 		init_debug("  early started: %s (%s)\n", lsm->id->name,
 			   is_enabled(lsm) ? "enabled" : "disabled");
-		if (lsm->enabled)
-			lsm_append(lsm->id->name, &lsm_names);
 	}
 
 	/* Load LSMs in specified order. */
-- 
2.51.0

