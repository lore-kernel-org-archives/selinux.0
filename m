Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F88FC54EB4
	for <selinux@archiver.kernel.org>; Mon, 23 Jan 2023 01:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjAWBmj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 22 Jan 2023 20:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjAWBmj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 22 Jan 2023 20:42:39 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC16193DC
        for <selinux@vger.kernel.org>; Sun, 22 Jan 2023 17:42:37 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id jl3so10012929plb.8
        for <selinux@vger.kernel.org>; Sun, 22 Jan 2023 17:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ny4BkR9C6ykaTDhKTSWWXmo1vzpk5E0kcIlnIs1QqKQ=;
        b=W5UYM8Zbi7R1x2kTQavoVY7BiEjhmzkhgc4wU4ubZfzujGVkwknk6on2oUz2S9KShN
         d8PIsdUxuj0hjCQDwXUbgKZKGvRu+Ds86XD+9RDkpurSFx9pU9YB4uCO/JiQHy+4/TpE
         JGgGBRmJvrdYlMbEeGo20AJOW34VzTkzq9T1hPT1CsQQYxETmacpyk3g8bNB8RYEE1SV
         XGcLaxlwf34z9jLVF+vN7DiJ4vfCtntj7cH0wjYcRNSsmARcLPog9KYrKBdr1pnw17qZ
         YjBGvHXeV1WNmiqWqYmli5Lj38AjRdhRLNge+/oQ6U1yNlolpA1WbqZVzDh9AfUsrv3t
         YORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ny4BkR9C6ykaTDhKTSWWXmo1vzpk5E0kcIlnIs1QqKQ=;
        b=UWYrBcI+Z0Qaxm6TewgvzZmxtzO1nFcGQ5UEWbBbAFijJkbwTXTE0zWtlcBGdDpx35
         CtM7fXCIIrTXrug3bD16x4K34lzUKZaaLyEirei/ou7Kjr77a0ZwIh6Wy7pPb/SLUM6S
         mNs7XULAkc3mRIr/RKdPRLiINBFlN4KNt6sFpLEvvlce1SVa+Fkm9ZTkcAqyr1gez57f
         PxNgZKb1k5UJqybJaFYTmsnQzsZ/lUzZStvnMNBF5H1pVWy/9olHn9BNWgjEZsXH0xPR
         iS4xAOWSI0aojqrHl8h4no9zps1KxIyYKXehMM31jPhl3qEQgwiyXsWi2nD360FIhR37
         AReA==
X-Gm-Message-State: AFqh2kq7HUt1e6lB1mdERDFbLoyBediOv/pvNCqZsdwl8GyYk3K7j4ou
        QgZdZx5MLtEEmQYiLHiu5ghvNdrjNd4=
X-Google-Smtp-Source: AMrXdXubNoGvmxq/jajKy1J4CWicmANxpQpmy4L1RU6HMsjFvtFl+EY+KUaI5TgoIqDLR/UY8O2sgw==
X-Received: by 2002:a05:6a21:9993:b0:b6:1425:55df with SMTP id ve19-20020a056a21999300b000b6142555dfmr30848395pzb.59.1674438157029;
        Sun, 22 Jan 2023 17:42:37 -0800 (PST)
Received: from localhost.. (192-184-217-7.fiber.dynamic.sonic.net. [192.184.217.7])
        by smtp.gmail.com with ESMTPSA id z18-20020a63c052000000b0049f2c7e59f5sm25857491pgi.27.2023.01.22.17.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 17:42:36 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     selinux@vger.kernel.org
Cc:     =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 2/3] libselinux: improve performance with pcre matches
Date:   Mon, 23 Jan 2023 01:40:46 +0000
Message-Id: <20230123014047.84911-3-carenas@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230123014047.84911-1-carenas@gmail.com>
References: <20230121180318.11853-1-carenas@gmail.com>
 <20230123014047.84911-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since 30b3e9d2 (libselinux: Workaround for heap overhead of pcre,
2023-01-12), performance of PCRE2 matches has been affected due to
excesive recreation of the match_data in an attempt to reduce memory
utilization; instead of a workaround, it would be better to address
the problem and maybe even improve performance in the process.

The issue is that currently the structure that holds PCRE state has
both a pcre2_code (which is per pattern) and a pcre2_match_data (which
is per match), forcing us to add a mutex to prevent multiple matches to
step on each other.

Lets remove the match_data and the mutex and instead allocate one once
in a thread independent way that could be used and reused, by extending
our pthread interface to not only store TLS variables but also retrieve
them, and then use one of those.

Since we are not interested on the capture groups (if any) lets only
allocate 1 pair which is all that will be needed and change the logic
so that a return of 0 (which means the pattern matched but there were
not enough capture spots) is also considered a match.

This will ensure that the memory use would be bound to the number of
concurrent matches instead of the number of patterns and therefore
reduce the impact that recent changes on the way that the frames used
for matching are allocated might had brough since 10.41 was released.

For cases where threads are not available, just keep it working in slow
mode as done before the workaround was reverted.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 libselinux/src/regex.c            | 108 +++++++++++++++++-------------
 libselinux/src/selinux_internal.h |   4 ++
 2 files changed, 64 insertions(+), 48 deletions(-)

diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index 16df6790..54f24026 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -30,6 +30,11 @@
 #endif
 
 #ifdef USE_PCRE2
+static pthread_key_t match_data_key;
+static int match_data_key_initialized = -1;
+static pthread_mutex_t key_mutex = PTHREAD_MUTEX_INITIALIZER;
+static __thread char match_data_initialized;
+
 char const *regex_arch_string(void)
 {
 	static char arch_string_buffer[32];
@@ -60,14 +65,6 @@ char const *regex_arch_string(void)
 
 struct regex_data {
 	pcre2_code *regex; /* compiled regular expression */
-#ifndef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
-	/*
-	 * match data block required for the compiled
-	 * pattern in pcre2
-	 */
-	pcre2_match_data *match_data;
-#endif
-	pthread_mutex_t match_mutex;
 };
 
 int regex_prepare_data(struct regex_data **regex, char const *pattern_string,
@@ -86,13 +83,6 @@ int regex_prepare_data(struct regex_data **regex, char const *pattern_string,
 		goto err;
 	}
 
-#ifndef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
-	(*regex)->match_data =
-	    pcre2_match_data_create_from_pattern((*regex)->regex, NULL);
-	if (!(*regex)->match_data) {
-		goto err;
-	}
-#endif
 	return 0;
 
 err:
@@ -142,13 +132,6 @@ int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data **regex,
 		if (rc != 1)
 			goto err;
 
-#ifndef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
-		(*regex)->match_data =
-		    pcre2_match_data_create_from_pattern((*regex)->regex, NULL);
-		if (!(*regex)->match_data)
-			goto err;
-#endif
-
 		*regex_compiled = true;
 	}
 
@@ -204,18 +187,32 @@ out:
 	return rc;
 }
 
+static void __attribute__((destructor)) match_data_thread_free(void *key)
+{
+	void *value;
+	pcre2_match_data *match_data;
+
+	if (match_data_key_initialized <= 0 || !match_data_initialized)
+		return;
+
+	value = __selinux_getspecific(match_data_key);
+	match_data = value ? value : key;
+
+	pcre2_match_data_free(match_data);
+
+	__pthread_mutex_lock(&key_mutex);
+	if (--match_data_key_initialized == 1) {
+		__selinux_key_delete(match_data_key);
+		match_data_key_initialized = -1;
+	}
+	__pthread_mutex_unlock(&key_mutex);
+}
+
 void regex_data_free(struct regex_data *regex)
 {
 	if (regex) {
 		if (regex->regex)
 			pcre2_code_free(regex->regex);
-
-#ifndef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
-		if (regex->match_data)
-			pcre2_match_data_free(regex->match_data);
-#endif
-
-		__pthread_mutex_destroy(&regex->match_mutex);
 		free(regex);
 	}
 }
@@ -223,32 +220,40 @@ void regex_data_free(struct regex_data *regex)
 int regex_match(struct regex_data *regex, char const *subject, int partial)
 {
 	int rc;
-	pcre2_match_data *match_data;
-	__pthread_mutex_lock(&regex->match_mutex);
+	bool slow;
+	pcre2_match_data *match_data = NULL;
+
+	if (match_data_key_initialized > 0) {
+		if (match_data_initialized == 0) {
+			match_data = pcre2_match_data_create(1, NULL);
+			if (match_data) {
+				match_data_initialized = 1;
+				__selinux_setspecific(match_data_key,
+							match_data);
+				__pthread_mutex_lock(&key_mutex);
+				match_data_key_initialized++;
+				__pthread_mutex_unlock(&key_mutex);
+			}
+		} else
+			match_data = __selinux_getspecific(match_data_key);
+	}
 
-#ifdef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
-	match_data = pcre2_match_data_create_from_pattern(
-	    regex->regex, NULL);
-	if (match_data == NULL) {
-		__pthread_mutex_unlock(&regex->match_mutex);
-		return REGEX_ERROR;
+	slow = (match_data_key_initialized <= 0 || match_data == NULL);
+	if (slow) {
+		match_data = pcre2_match_data_create_from_pattern(regex->regex,
+									NULL);
+		if (!match_data)
+			return REGEX_ERROR;
 	}
-#else
-	match_data = regex->match_data;
-#endif
 
 	rc = pcre2_match(
 	    regex->regex, (PCRE2_SPTR)subject, PCRE2_ZERO_TERMINATED, 0,
 	    partial ? PCRE2_PARTIAL_SOFT : 0, match_data, NULL);
 
-#ifdef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
-	// pcre2_match allocates heap and it won't be freed until
-	// pcre2_match_data_free, resulting in heap overhead.
-	pcre2_match_data_free(match_data);
-#endif
+	if (slow)
+		pcre2_match_data_free(match_data);
 
-	__pthread_mutex_unlock(&regex->match_mutex);
-	if (rc > 0)
+	if (rc >= 0)
 		return REGEX_MATCH;
 	switch (rc) {
 	case PCRE2_ERROR_PARTIAL:
@@ -290,7 +295,14 @@ struct regex_data *regex_data_create(void)
 	if (!regex_data)
 		return NULL;
 
-	__pthread_mutex_init(&regex_data->match_mutex, NULL);
+	__pthread_mutex_lock(&key_mutex);
+	if (match_data_key_initialized < 0) {
+		match_data_key_initialized = !__selinux_key_create(
+							&match_data_key,
+							match_data_thread_free);
+	}
+	__pthread_mutex_unlock(&key_mutex);
+
 	return regex_data;
 }
 
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 06f2c038..d1e6c50f 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -13,6 +13,7 @@ extern int selinux_page_size ;
 #pragma weak pthread_key_create
 #pragma weak pthread_key_delete
 #pragma weak pthread_setspecific
+#pragma weak pthread_getspecific
 
 /* Call handler iff the first call.  */
 #define __selinux_once(ONCE_CONTROL, INIT_FUNCTION)	\
@@ -41,6 +42,9 @@ extern int selinux_page_size ;
 			pthread_setspecific(KEY, VALUE);	\
 	} while (0)
 
+#define __selinux_getspecific(KEY)				\
+	(pthread_getspecific != NULL ? pthread_getspecific(KEY) : NULL)
+
 /* selabel_lookup() is only thread safe if we're compiled with pthreads */
 
 #pragma weak pthread_mutex_init
-- 
2.39.0

