Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C2B27BF6C
	for <selinux@vger.kernel.org>; Wed,  9 Apr 2025 18:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224818; cv=none; b=utRQvRnfPgg2y8mF7k3E9NunjEgkPBxtz3vC+mH4eWwOj+or4hltkn6D3lez3UsrK6AKNKFILqA4fI7rg0QNkbitXH8uJJHDc+FqZkzG605i02l5yaPNGE6Ybl1BeeRlEOZMGbqZn1B1WqlJPvRK1skGXrqSQofYCCv3OXAyZVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224818; c=relaxed/simple;
	bh=cAQQMk+Vt6sewNd7r5cJabqUDfdUGGXs+2Q9EYdMTl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJRcXZNETPYImrAaLyYUNFPDQURdAqTD0DUPu5w8rytGUSksBmGpb1OYRdMwDIg5jiM5TtA/93zZfJ4w1y/+HnKnqG7D114qbFCn8b24NF9hWopw+j/gcKRImhq1OZ8AHU881muLZNyEV5AgnnYXGydWU8W0Okoq+4nhMQV3bNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ef/fPv60; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ef/fPv60"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6f0c30a1ca3so43735826d6.1
        for <selinux@vger.kernel.org>; Wed, 09 Apr 2025 11:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224815; x=1744829615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8UNEGBnDjctViFzAeNZ98+Qj49ntmuE/5Qqsa0alp4=;
        b=ef/fPv60/r3G2z7jcwyi4COMxJukePbCiGXQF1Gu/fewnHhliNz8mZF90txW9DcqW3
         gQjK76s5fnpMWa9PoPITjhqAUIhSPjUzBe2TGt7gCbCE5nUil7FelwGYktw2A9a3pYJA
         CLgC4K7PRz2uQK6q2JDxw9VPDWNaepV7hVqjl44034OJL3+9ZG3Q90ty9KKFD/3IlKF7
         FUXpx/Rw6poKylkfNOAcJz31Ncb4yoP0293yjJeu7E1WNIPZe7THGdei6Zt0SCURvsw4
         B/WS00Htmm6FIjNvjcmt5o2j0upV5YkOkzpvw3KAzP/hyFByZnNdI6/CaGz+A5hfAIn+
         Y5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224815; x=1744829615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8UNEGBnDjctViFzAeNZ98+Qj49ntmuE/5Qqsa0alp4=;
        b=TeCx0L9eBrwlYNn8GQCmbpnRbVrGElBDzd0lxpztFo/BCsdsEqm1G6UIWpRT3OYl2n
         Evv//qTNgS9eixXbwQJSqWoL4beWROF5RhuuH8RzjKzBo/sibxHnMDPm94yqTRkqwybZ
         S79B5NFtdg+EzE0DtwOrIdclcVs/8mVxwprgn33sNYVya0i6fgJXrXfn0Qgk3WVv5YAm
         vtHIM59Gb62z2cqqylUw10NKOdtM3IZai89PYUb2Ue8tVM7UaRjcllMAyN9FBE7UF1IQ
         enNipfrzephzMubUAM5Ly055QeVmRUs9U76xZaQNiA2vQYHXa0W/XOkqbZJEkVZn1uUO
         LuhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyRe1DuyXcODA+c/e8q6Qn6JWsz8WwpnAR0rJMA/u75g8fjdjO/UI6xj7NYJnNozbEevGqFU6T@vger.kernel.org
X-Gm-Message-State: AOJu0YziviGl0zjyMHL52R+3jrVTnNu2ERZKSO77jy9siAM8WRXnpOg8
	Po8+CI0MxATSqzeNbee0d5na6anZBxKCUIBeBQGatekbF9jU5hcwkL+F+zXydg==
X-Gm-Gg: ASbGncuX8Jiie/w7Vtdxgo0bv33KSg7fwv5HubteTj3qXXa+QrvXsq/46cWjH9SBVDv
	uIzHuFMIXwPundKOdqG3KgRIP8zpzY9gFyoPH7qo+7saSDUShmZLrO9xgwj5kfxV/4M6OdF1RvG
	ZCr61SJxwgzijnSVH5ecelJZXO2vEVJoZSBVJYxzRD+zC9+Cn8TewWoCTHXgh34x4fsa/y6uUEy
	gceGaqeQPZ1Hpet3if9puwJIdwVBVHfVrRwxjE5FoqGXIozQc2iJ6BOCP5S0mHQMUQQvscQDkT8
	rvcBjSE2tB6Pav7EoGKnu0PSK/FHQW4MeFezGd5w/KujW+GCucqQa06dty3yqntNNAhcjl9W4SE
	8A/2LoS4KRQ==
X-Google-Smtp-Source: AGHT+IF1EIeERMEIEyvo2n9JxK+aeVmwH9S+aVkJod3eUny8dqJAKr6fct43BFRjaJ12VpzocVn5Iw==
X-Received: by 2002:a05:6214:27e5:b0:6d8:ada3:26c9 with SMTP id 6a1803df08f44-6f0e5a26063mr689146d6.10.1744224815418;
        Wed, 09 Apr 2025 11:53:35 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0dea111b5sm10426366d6.117.2025.04.09.11.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:34 -0700 (PDT)
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
Subject: [RFC PATCH 06/29] lsm: cleanup and normalize the LSM order symbols naming
Date: Wed,  9 Apr 2025 14:49:51 -0400
Message-ID: <20250409185019.238841-37-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7191; i=paul@paul-moore.com; h=from:subject; bh=cAQQMk+Vt6sewNd7r5cJabqUDfdUGGXs+2Q9EYdMTl0=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sGNvvFy3me8wmdAt1I5fboN8swUGDytRzhXL p20NwzmOSuJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bBjQAKCRDqIPLalzeJ c+i/D/9YxUh19UB8H9azsjHcItUSrWOZOxh89ujZKXQitrtrb6UVAU4hPyN2gBu3QASwgm6dq63 PBxLStkn03/FKeefydiLQYDWr2FBWcPfDGeNRzfwO8y/q39NkahsVEEQo+O6+QChw3ulZYtqrBa PWhuKWSbXOZlzw1Nt/FZ4S17sv18ti/GsrUbitEusu+FpVd4N9HSwNT0nEgDuAI0hhHAwd2dQmS vOBirouHdlG5ekl1NRE/1XENlORh/oqGLlm6J7TAfx5umEhrxMvP8EnJN0V9I6PrHO/Z0ry+F8+ RqnN9AHIc8QKzYoeNMbDq7mabLbWV5qrCQnCmvrjQVKlp7k7aljrjAnHUbxAK5vUI4SwJJClu6p y+Z9hpT/oMXEI74WqVoKDD3+heAsbET5fIzVCDGB8+Lx8H+enx0Y/O6lPY2+Ia5feWBU3BDTBv6 VFo4fyZ9pvE2zPEU7TodqkfG0flF+fB1wvsBU6z9YpEVQFxmyJB/IYDsUbcNrzD+XNvMTnpilFb 6IxEaPP7jSdj8RyW7dvUyrl6aNywV4cnywSfYN3KTja6n6UgVp45rOV5EaYFSUMkRjJBb9Gu7zl R8rMNCVvIB2jD6dGW9x99gj2bs0UQYHZ16IchJhtX7+h6n3EZlca84LMHkDEMq9FDL50A9XcIpf TTPM1seuwDuihWg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

One part of a larger effort to cleanup the LSM framework initialization
code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 88 +++++++++++++++++++++++++--------------------
 1 file changed, 49 insertions(+), 39 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index d458a365b0d5..edf2f4140eaa 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -16,14 +16,14 @@ char *lsm_names;
 extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
 extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
 
-/* Boot-time LSM user choice */
-static __initconst const char *const builtin_lsm_order = CONFIG_LSM;
-static __initdata const char *chosen_lsm_order;
-static __initdata const char *chosen_major_lsm;
+/* Build and boot-time LSM ordering. */
+static __initconst const char *const lsm_order_builtin = CONFIG_LSM;
+static __initdata const char *lsm_order_cmdline;
+static __initdata const char *lsm_order_legacy;
 
 /* Ordered list of LSMs to initialize. */
-static __initdata struct lsm_info *ordered_lsms[MAX_LSM_COUNT + 1];
-static __initdata struct lsm_info *exclusive;
+static __initdata struct lsm_info *lsm_order[MAX_LSM_COUNT + 1];
+static __initdata struct lsm_info *lsm_exclusive;
 
 static __initdata bool debug;
 #define init_debug(...)							\
@@ -33,36 +33,46 @@ static __initdata bool debug;
 	} while (0)
 
 #define lsm_order_for_each(iter)					\
-	for ((iter) = ordered_lsms; *(iter); (iter)++)
+	for ((iter) = lsm_order; *(iter); (iter)++)
 #define lsm_early_for_each_raw(iter)					\
 	for ((iter) = __start_early_lsm_info;				\
 	     (iter) < __end_early_lsm_info; (iter)++)
 
-static int lsm_append(const char *new, char **result);
-
-/* Save user chosen LSM */
-static int __init choose_major_lsm(char *str)
+/**
+ * lsm_choose_security - Legacy "major" LSM selection
+ * @str: kernel command line parameter
+ */
+static int __init lsm_choose_security(char *str)
 {
-	chosen_major_lsm = str;
+	lsm_order_legacy = str;
 	return 1;
 }
-__setup("security=", choose_major_lsm);
+__setup("security=", lsm_choose_security);
 
-/* Explicitly choose LSM initialization order. */
-static int __init choose_lsm_order(char *str)
+/**
+ * lsm_choose_lsm - Modern LSM selection
+ * @str: kernel command line parameter
+ */
+static int __init lsm_choose_lsm(char *str)
 {
-	chosen_lsm_order = str;
+	lsm_order_cmdline = str;
 	return 1;
 }
-__setup("lsm=", choose_lsm_order);
+__setup("lsm=", lsm_choose_lsm);
 
-/* Enable LSM order debugging. */
-static int __init enable_debug(char *str)
+/**
+ * lsm_debug_enable - Enable LSM framework debugging
+ * @str: kernel command line parameter
+ *
+ * Currently we only provide debug info during LSM initialization, but we may
+ * want to expand this in the future.
+ */
+static int __init lsm_debug_enable(char *str)
 {
 	debug = true;
 	return 1;
 }
-__setup("lsm.debug", enable_debug);
+__setup("lsm.debug", lsm_debug_enable);
 
 /* Mark an LSM's enabled flag. */
 static int lsm_enabled_true __initdata = 1;
@@ -124,7 +134,7 @@ static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
 	/* Enable this LSM, if it is not already set. */
 	if (!lsm->enabled)
 		lsm->enabled = &lsm_enabled_true;
-	ordered_lsms[last_lsm] = lsm;
+	lsm_order[last_lsm] = lsm;
 	lsm_idlist[last_lsm++] = lsm->id;
 
 	init_debug("%s ordered: %s (%s)\n", from, lsm->id->name,
@@ -154,7 +164,7 @@ static void __init lsm_prep_single(struct lsm_info *lsm)
 	if (!is_enabled(lsm)) {
 		set_enabled(lsm, false);
 		return;
-	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
+	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && lsm_exclusive) {
 		init_debug("exclusive disabled: %s\n", lsm->id->name);
 		set_enabled(lsm, false);
 		return;
@@ -162,9 +172,9 @@ static void __init lsm_prep_single(struct lsm_info *lsm)
 
 	/* Mark the LSM as enabled. */
 	set_enabled(lsm, true);
-	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
+	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !lsm_exclusive) {
 		init_debug("exclusive chosen:   %s\n", lsm->id->name);
-		exclusive = lsm;
+		lsm_exclusive = lsm;
 	}
 
 	/* Register the LSM blob sizes. */
@@ -220,7 +230,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	}
 
 	/* Process "security=", if given. */
-	if (chosen_major_lsm) {
+	if (lsm_order_legacy) {
 		struct lsm_info *major;
 
 		/*
@@ -232,10 +242,10 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		for (major = __start_lsm_info; major < __end_lsm_info;
 		     major++) {
 			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
-			    strcmp(major->id->name, chosen_major_lsm) != 0) {
+			    strcmp(major->id->name, lsm_order_legacy) != 0) {
 				set_enabled(major, false);
 				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
-					   chosen_major_lsm, major->id->name);
+					   lsm_order_legacy, major->id->name);
 			}
 		}
 	}
@@ -260,11 +270,11 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	}
 
 	/* Process "security=", if given. */
-	if (chosen_major_lsm) {
+	if (lsm_order_legacy) {
 		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
 			if (exists_ordered_lsm(lsm))
 				continue;
-			if (strcmp(lsm->id->name, chosen_major_lsm) == 0)
+			if (strcmp(lsm->id->name, lsm_order_legacy) == 0)
 				append_ordered_lsm(lsm, "security=");
 		}
 	}
@@ -295,15 +305,15 @@ static void __init lsm_init_ordered(void)
 	struct lsm_info **lsm;
 	struct lsm_info *early;
 
-	if (chosen_lsm_order) {
-		if (chosen_major_lsm) {
+	if (lsm_order_cmdline) {
+		if (lsm_order_legacy) {
 			pr_warn("security=%s is ignored because it is superseded by lsm=%s\n",
-				chosen_major_lsm, chosen_lsm_order);
-			chosen_major_lsm = NULL;
+				lsm_order_legacy, lsm_order_cmdline);
+			lsm_order_legacy = NULL;
 		}
-		ordered_lsm_parse(chosen_lsm_order, "cmdline");
+		ordered_lsm_parse(lsm_order_cmdline, "cmdline");
 	} else
-		ordered_lsm_parse(builtin_lsm_order, "builtin");
+		ordered_lsm_parse(lsm_order_builtin, "builtin");
 
 	lsm_order_for_each(lsm) {
 		lsm_prep_single(*lsm);
@@ -319,7 +329,7 @@ static void __init lsm_init_ordered(void)
 	lsm_order_for_each(lsm) {
 		if (is_enabled(*lsm))
 			pr_cont("%s%s",
-				lsm == ordered_lsms ? "" : ",", (*lsm)->id->name);
+				lsm == lsm_order ? "" : ",", (*lsm)->id->name);
 	}
 	pr_cont("\n");
 
@@ -465,9 +475,9 @@ int __init security_init(void)
 {
 	struct lsm_info *lsm;
 
-	init_debug("legacy security=%s\n", chosen_major_lsm ? : " *unspecified*");
-	init_debug("  CONFIG_LSM=%s\n", builtin_lsm_order);
-	init_debug("boot arg lsm=%s\n", chosen_lsm_order ? : " *unspecified*");
+	init_debug("legacy security=%s\n", lsm_order_legacy ? : " *unspecified*");
+	init_debug("  CONFIG_LSM=%s\n", lsm_order_builtin);
+	init_debug("boot arg lsm=%s\n", lsm_order_cmdline ? : " *unspecified*");
 
 	/*
 	 * Append the names of the early LSM modules now that kmalloc() is
-- 
2.49.0

