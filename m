Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610913E7148
	for <selinux@vger.kernel.org>; Thu, 28 May 2026 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779971443; cv=none; b=gSR6CSbr6dq3pOIH8oci5zBVkXkhus1I8L2mZTBCAllsX9TI8RZE0+XqMj3cdbB5+NBQfb2+Bq/rEZTanRgtuNOY0j2vbxZUEss+/+l7WtrhM8jIpToaa6aj8JXsMf+SJGdfp0NG3n8nqUJ3du5rzieqGBCRTgBf80ClMRpUpl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779971443; c=relaxed/simple;
	bh=un33yzuHCdqhtgI+YQmti2seFIsFUs435pejm6HZuRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6Ehr1fS9mmUETMnCVe2x6kWbsYm/+9i76Qn5GpQvzosShsXqh9jccN/yEyhVqrlFQhZzllxQA0B5hkGPZMk37DH2LudPH8g+xMlFvT2KwGboKrp6vlo0SdcrmBqajfAqRi3+QSr4jkSiVzhIzw9/X7dQ3VW1BbHvfuytscwNf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQhgBv4y; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQhgBv4y"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-90ca6f20872so1555736285a.0
        for <selinux@vger.kernel.org>; Thu, 28 May 2026 05:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779971441; x=1780576241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLEATbgRBz51szTbSLbz6UyvbecdpTetgU8a0+DO7QQ=;
        b=TQhgBv4yS3bs4BkFGvXZxnvj7S3pWWVT2X1s1HaJ6WehdUB46s9zu67d5bQZuTi3fw
         WiRBhiq0GU+r8XKnBEFj+wtgRpNUTvK5VRPN2uyCN8M0ebbThdvoO1JzOV5XuFXHYSsS
         5yoyO1VBNQDEUluEW6VgEHia//mb88xTc6UUvBlU5ecZbUt2EjBYRDhzPCjWMO211YFa
         jAaaSDbDK1PxtdlopjAiC5K8GO9591aEAB633wOzQXL5Reehe/qksF+Zsc+ImySmohWO
         C3iuvLi7jd2KgnZPt304b+6U6UXLCOu3oYZmj25odA2lNlerMWHQV1Q1K7Qz77mGsNvr
         ZDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779971441; x=1780576241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VLEATbgRBz51szTbSLbz6UyvbecdpTetgU8a0+DO7QQ=;
        b=qweG/wR6r9FShfYMvYpQxBadPcCkphrDl3v0EI5pSgOKce2CDIW7guVmOafrTZwJUW
         A1NunXpemJFk2z90qs1BHdDatVyNLae6UzKdKqGmtzOsBvZIeRIrgwpuwYY4My5FcnC9
         cu67gDz4UV2c/dmepR4azRwfzzN43ViY7eAkNG6QsgTibsktKaqVsMKETe2OQ4md4Sx0
         JlRkVN27vBdkbjb/FUHK4CiRkE+qqMWHs6jrcrNXFbRPmwkz8JBLEC3h/U0qznOTkVvy
         m8g23AbYBfKVilaNtvSO/9k1Gn1waQstwx2LXKqRvx9lrRcdxatkhfhlsHC7nEKFktq3
         BzbA==
X-Gm-Message-State: AOJu0Yyld31hrFVB0Lve6IRW10pDrS/JTDBaCnYAkSWnQG0N4XcNJj9A
	pwS2UWMhVsol/nFxz0XEroakB664xvfWrQ0tzplE3DZoFvKVQU76BuywJPWOLA==
X-Gm-Gg: Acq92OG8WSgDzMLXPiqRTBanT00BoGfuQ9wO8FQjxbjoKlCmwaVJGCPYGDlfC5OvZH3
	7KxpOjwT9MWP/CFBo+TdMKUvoJEM/Gq7zcQSnu9t4UmLAys00RF/r3k9/wsL0U5kY8Gw7CBWNhK
	cQs6O37Z9cNuIy0R5LlYP4K7odj5uPrWjNOpxAqWKDsgZAIluqTWKlV8GsjtNKtU3+QOab9ko+9
	UNfP2bdKVVXBl0EmCLJ/SaufhqfYVUm0A47lj7hXwPR7LUV2STPil0YDbo7yi4keRQiIpGtTfbR
	ZSLOCvLpI5kB1x4XOQqRty6N7EotXT/lJ2dVL9d54/S3zGtohtV2o1BlCNluMz3u+0GFUefo/1u
	tmb9Rtwb6vbLAVxmkssXzCnd3DIgMxMXHkKNQeHZbhguOo6IQFdzbR9pwmgG9pfN3TI9lZHZ26Z
	/3Qeht5W5f20yczjMS0xCVB28qNNcdULkTzMjPNsMsyz08xKRYTNF8NyGLPp5GGc45poH/z96s0
	fgjpgkKOS5wKgpt+qDGSLlKKjW2ON4DG/SAVt2JPSn0OwXD
X-Received: by 2002:a05:620a:1a0a:b0:8ee:b817:9a03 with SMTP id af79cd13be357-91521698cd4mr118653385a.9.1779971440901;
        Thu, 28 May 2026 05:30:40 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f880c1b1sm783298085a.40.2026.05.28.05.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 05:30:40 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/2] mcstrans: cap the cache size
Date: Thu, 28 May 2026 08:30:20 -0400
Message-ID: <20260528123020.35148-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528123020.35148-1-stephen.smalley.work@gmail.com>
References: <20260528123020.35148-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cap the cache size and do not fail with an error if we are
unable to cache a given translation.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 mcstrans/src/mcstrans.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
index ff33621c..9e49ab7f 100644
--- a/mcstrans/src/mcstrans.c
+++ b/mcstrans/src/mcstrans.c
@@ -38,6 +38,8 @@
 #include "mcstrans.h"
 
 #define N_BUCKETS 1453
+#define MAX_CACHE_ENTRIES 65536
+static unsigned int cache_entries;
 
 #define log_error(fmt, ...) fprintf(stderr, fmt, __VA_ARGS__)
 
@@ -648,7 +650,15 @@ add_base_classification(domain_t *domain, char *raw, char *trans) {
 
 static int
 add_cache(domain_t *domain, char *raw, char *trans) {
-	context_map_t *map = calloc(1, sizeof(context_map_t));
+	context_map_t *map;
+
+	if (cache_entries > MAX_CACHE_ENTRIES) {
+		log_debug(" add_cache: cache full, not caching (%s, %s)\n",
+			raw, trans);
+		return 0;
+	}
+
+	map = calloc(1, sizeof(context_map_t));
 	if (!map) goto err;
 
 	map->raw = strdup(raw);
-- 
2.54.0

