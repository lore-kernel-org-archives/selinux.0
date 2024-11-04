Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C3F189909
	for <selinux@vger.kernel.org>; Mon,  4 Nov 2024 14:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730730307; cv=none; b=br5QQNu4Xvh8uKnBGe3luLxtoKA6s2mGh1A1QLsn1SpQCKfKuuR6tj7xGke3uOvVh9V0HiFAnh9X3JS0PS+KE4l8YT/y9y4NdLNRlq0KjoSHhf/EgEeq+E8qYf5jk/GGeYx8FTe6q+VIte/6Qde3fkLuAksfo6Pz3knHRhkYdsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730730307; c=relaxed/simple;
	bh=rOulzeykjR2Rd51pDXp58oXyIJnyywwvjYYKdzItass=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5jT4umzbbTvyurABS4FtTRd5I4blxwjBR4WfXeH1hbV1slU8v6Vj2e+KotPc4+CzTTIbbnTgGSGrl3oLNUQqjGXMUbfoFLKtBvD03bDm2cC0suvvPsyDeouiXx15omwqDcrWsihQHZfZtISV8Z0G+xkKg2D290UN4fCyVqjlAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiB1BaKi; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiB1BaKi"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b153047b29so282889585a.3
        for <selinux@vger.kernel.org>; Mon, 04 Nov 2024 06:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730730304; x=1731335104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QO3RZRQWu9YuXgK5XSF8AhYkxKNzw2Js3K3btSZezoA=;
        b=eiB1BaKiUdnU8aFqQbqxwohfDZb/E7uD740ckgN/CCzWT/YXam9DWP07r7eNsXgLaP
         tUmDLl6jyozsXs2U4CT8cbC5nOOhFlicVc0v0ShOKnpCZZncHNpHynIQ0rOM9ynidMRf
         Gq1QzZZsjGz6LZOhadA7w7EAEIS+MEYTI42abY4lGgKrIeR/XOL1NKVniJqgKsXaZqDE
         Wi/jOeYxcyMHoAcExmJisSs7m7007vX+oB0iuw9iujXuA/VliaeE/xJGRAJgkKDoixWd
         /SXup8gldB0LOQy7KXr4VKphC0+b9Rv9jHw6nA/eWJSGngVjbNo5kzUYDaMjTEPwUN3R
         A47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730730304; x=1731335104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QO3RZRQWu9YuXgK5XSF8AhYkxKNzw2Js3K3btSZezoA=;
        b=tbt9hnxDjTOxz8F52QiXqtIv+o7JrFzNJXAIEdBy2Ck8a0TPJUk6ieefqfjc2QLY3G
         VUbmU6qZOqHNyK1utFkyj3NwTQ3MYYJWSjkXM8OtEopIuUVEIhqtC06lTflkGR2uVTQf
         DPsAucsk1lXBicUCceZJi2MeaBq/pCMAKNR5mCIPpPdr3uKLL9HlhRz7H7Mlbr0tekqE
         B8jOlsKwAjdN4ms/HX0TemNjAyukgvj0E+YferiOaI7UsoE0absnnXOjXZf9Su5MCeOc
         TK+dVsSnN4RAfYIa2LQR83UB4wOYFaqEeXS9szNuGfy5sC+ymKeq7fh37YGTPNOlBkvp
         UrxA==
X-Gm-Message-State: AOJu0YxdpwOQ4eWV5EGmkjPBgXu4kXdBBwwafsbt4lvz2/J7brOGq+NX
	ah2Kj/uu/ZZGb04a6+kOhwHdlhqvaVkJsqr+OGZx73WDgspLWKPHHUAigQ==
X-Google-Smtp-Source: AGHT+IEPjBaUKsDboX0sMQSvo1YV41E7oPZbdMUKt5DXMfzj+Z8zEmxnfRiocQ+mHkIw4Cy9gCBLkg==
X-Received: by 2002:a05:6214:3186:b0:6cc:3a:a7f0 with SMTP id 6a1803df08f44-6d185857230mr506483796d6.44.1730730304256;
        Mon, 04 Nov 2024 06:25:04 -0800 (PST)
Received: from electric.. (c-69-140-100-37.hsd1.md.comcast.net. [69.140.100.37])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d35415a703sm48572386d6.85.2024.11.04.06.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 06:25:03 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: cgoettsche@seltendoof.de,
	pebenito@ieee.org,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/3] libsemanage: Optionally allow duplicate declarations
Date: Mon,  4 Nov 2024 09:24:59 -0500
Message-ID: <20241104142500.20055-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104142500.20055-1-jwcart2@gmail.com>
References: <20241104142500.20055-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a configuration option that when set to "true" allows duplicate
type, type attribute, and role declarations and duplicate context
rules.

The default is set to "true" to support the removal of the special
handling of certain roles when converting a policy module to CIL
without causing problems for existing policies.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsemanage/man/man5/semanage.conf.5 |  5 +++++
 libsemanage/src/conf-parse.y         | 15 ++++++++++++++-
 libsemanage/src/conf-scan.l          |  1 +
 libsemanage/src/direct_api.c         |  1 +
 libsemanage/src/semanage_conf.h      |  1 +
 5 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/libsemanage/man/man5/semanage.conf.5 b/libsemanage/man/man5/semanage.conf.5
index 380b58be..71712562 100644
--- a/libsemanage/man/man5/semanage.conf.5
+++ b/libsemanage/man/man5/semanage.conf.5
@@ -126,6 +126,11 @@ In order to compile the original HLL file into CIL, the same HLL file will need
 When set to "true", the kernel policy will be optimized upon rebuilds.
 It can be set to either "true" or "false" and by default it is set to "false".
 
+.TP
+.B multiple-decls
+When set to "true", duplicate type, type attribute, and role declarations will be allowed.
+It can be set to either "true" or "false" and by default it is set to "true".
+
 .SH "SEE ALSO"
 .TP
 semanage(8)
diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.y
index eac91344..beab85a2 100644
--- a/libsemanage/src/conf-parse.y
+++ b/libsemanage/src/conf-parse.y
@@ -59,7 +59,7 @@ static int parse_errors;
         char *s;
 }
 
-%token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE SAVE_PREVIOUS SAVE_LINKED TARGET_PLATFORM COMPILER_DIR IGNORE_MODULE_CACHE STORE_ROOT OPTIMIZE_POLICY
+%token MODULE_STORE VERSION EXPAND_CHECK FILE_MODE SAVE_PREVIOUS SAVE_LINKED TARGET_PLATFORM COMPILER_DIR IGNORE_MODULE_CACHE STORE_ROOT OPTIMIZE_POLICY MULTIPLE_DECLS
 %token LOAD_POLICY_START SETFILES_START SEFCONTEXT_COMPILE_START DISABLE_GENHOMEDIRCON HANDLE_UNKNOWN USEPASSWD IGNOREDIRS
 %token BZIP_BLOCKSIZE BZIP_SMALL REMOVE_HLL
 %token VERIFY_MOD_START VERIFY_LINKED_START VERIFY_KERNEL_START BLOCK_END
@@ -96,6 +96,7 @@ single_opt:     module_store
 	|	bzip_small
 	|	remove_hll
 	|	optimize_policy
+	|	multiple_decls
         ;
 
 module_store:   MODULE_STORE '=' ARG {
@@ -280,6 +281,17 @@ optimize_policy:  OPTIMIZE_POLICY '=' ARG {
 	free($3);
 }
 
+multiple_decls:  MULTIPLE_DECLS '=' ARG {
+	if (strcasecmp($3, "false") == 0) {
+		current_conf->multiple_decls = 0;
+	} else if (strcasecmp($3, "true") == 0) {
+		current_conf->multiple_decls = 1;
+	} else {
+		yyerror("multiple-decls can only be 'true' or 'false'");
+	}
+	free($3);
+}
+
 command_block: 
                 command_start external_opts BLOCK_END  {
                         if (new_external->path == NULL) {
@@ -365,6 +377,7 @@ static int semanage_conf_init(semanage_conf_t * conf)
 	conf->ignore_module_cache = 0;
 	conf->remove_hll = 0;
 	conf->optimize_policy = 0;
+	conf->multiple_decls = 1;
 
 	conf->save_previous = 0;
 	conf->save_linked = 0;
diff --git a/libsemanage/src/conf-scan.l b/libsemanage/src/conf-scan.l
index b06a896c..6438516b 100644
--- a/libsemanage/src/conf-scan.l
+++ b/libsemanage/src/conf-scan.l
@@ -55,6 +55,7 @@ bzip-blocksize	return BZIP_BLOCKSIZE;
 bzip-small	return BZIP_SMALL;
 remove-hll	return REMOVE_HLL;
 optimize-policy return OPTIMIZE_POLICY;
+multiple-decls return MULTIPLE_DECLS;
 "[load_policy]"   return LOAD_POLICY_START;
 "[setfiles]"      return SETFILES_START;
 "[sefcontext_compile]"      return SEFCONTEXT_COMPILE_START;
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 7631c7bf..43ab2f4c 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1346,6 +1346,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 		cil_set_preserve_tunables(cildb, preserve_tunables);
 		cil_set_target_platform(cildb, sh->conf->target_platform);
 		cil_set_policy_version(cildb, sh->conf->policyvers);
+		cil_set_multiple_decls(cildb, sh->conf->multiple_decls);
 
 		if (sh->conf->handle_unknown != -1) {
 			cil_set_handle_unknown(cildb, sh->conf->handle_unknown);
diff --git a/libsemanage/src/semanage_conf.h b/libsemanage/src/semanage_conf.h
index 23c4b8b4..5db08f0c 100644
--- a/libsemanage/src/semanage_conf.h
+++ b/libsemanage/src/semanage_conf.h
@@ -48,6 +48,7 @@ typedef struct semanage_conf {
 	int remove_hll;
 	int ignore_module_cache;
 	int optimize_policy;
+	int multiple_decls;
 	char *ignoredirs;	/* ";" separated of list for genhomedircon to ignore */
 	struct external_prog *load_policy;
 	struct external_prog *setfiles;
-- 
2.47.0

