Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4647C25B50
	for <selinux@archiver.kernel.org>; Sat, 21 Jan 2023 18:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjAUSEa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 21 Jan 2023 13:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjAUSE3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 21 Jan 2023 13:04:29 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DFB12F06
        for <selinux@vger.kernel.org>; Sat, 21 Jan 2023 10:04:28 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id c6so7991863pls.4
        for <selinux@vger.kernel.org>; Sat, 21 Jan 2023 10:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oewonBcB55mcnmpIw8vkHzPryvkib7qzSu7xfox/O60=;
        b=dWRxPeUueZswyqlZhKdlWgogCxxGFW1JmqMLJDXf1xQh6pWDVVMaORLzvHd1ZigxwX
         XjlxDIC+3+7i1sb1ilFT8aSYbRqwrLu0YBjD7ruAsAupfVAQwFLVVLn78foFA9XHBNIo
         8v+qlKdOirigsGkiSFkZAX6sy9Gx3DYsk4BYrX8ytHVarbeCuQmKZMCR7D52rA2fkd6Y
         dQoF5Mad20Zi/9fGQhE9DMRH4SV2DNLT4yLYsQi11JAdSZb6bK5Eb3fA5rCZnv0FVZcg
         Dt3DlrwaQyvpTN2xTzK4YnUWlJs+0/8t/KIXHJhWiPPT0pzu91Xvd49X/8LZKQjY8IlV
         q2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oewonBcB55mcnmpIw8vkHzPryvkib7qzSu7xfox/O60=;
        b=iPVQBqg0E+FHy+jBwZuGvbTUXW1w1zZ55fN2BIBD5zgIcVFzjRCthYp9lswNCYONXS
         LxBVsAnnDRGK5rMyVDn5X7wfChCOwync9VKQczQv5Gg7luEUYILeByDwWJUS0Pdu6g0Q
         1Lmz89UMdjCLd7+4gF1oMZLqYGTm89X6ZR1AHJPYLQKBeJRam1NDRCjsgZk6INp4m60U
         6LGzLeZIuwDhzqH9W++w7nPidqibqKya8GtHDFA/U9KwvfoAYBmAouRZsbO0Y4vpTD5S
         RVHVqr1d4QrGK4g7gu4jE0ujeohGOgIR19xH8RNnarV7WkPXy9kaXQj8e71STQfxTSqN
         Iq8g==
X-Gm-Message-State: AFqh2krAmbEp3/k3gr2H9F/40+nlvSWFCY4Uz94Lk8c+qzE8CKCjN66a
        3waW367/tJe/H/rWdFAe96ck+OFZ40Y=
X-Google-Smtp-Source: AMrXdXtT3BEiF6R6ulYMe4lP9LXYd1mt4ZxEAe8FZLouUwMBUQ58ghVIWjzFNxEievaRK+qJCJvDRA==
X-Received: by 2002:a17:90b:3445:b0:228:d1d5:5468 with SMTP id lj5-20020a17090b344500b00228d1d55468mr20344823pjb.25.1674324267242;
        Sat, 21 Jan 2023 10:04:27 -0800 (PST)
Received: from penguin.lxd (192-184-217-7.fiber.dynamic.sonic.net. [192.184.217.7])
        by smtp.gmail.com with ESMTPSA id nm1-20020a17090b19c100b0022717d8d835sm3730520pjb.16.2023.01.21.10.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 10:04:26 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     selinux@vger.kernel.org
Cc:     =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [RFC PATCH] libselinux: improve performance with pcre matches
Date:   Sat, 21 Jan 2023 10:03:18 -0800
Message-Id: <20230121180318.11853-1-carenas@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Since 30b3e9d2 (libselinux: Workaround for heap overhead of pcre,
2023-01-12), performance of PCRE2 matches has been affected due to
excesive recreation of the match_data in an attempt to reduce memory
utilization, but instead of a workaround, it would be better to
address the problem and maybe even improve performance in the process.

The issue is that currently the structure that holds PCRE state has
both a pcre2_code (which is per pattern) and a pcre2_match_data (which
is per match), forcing us to add a mutex to prevent multiple matches to
step on each other.

Lets remove the match_data and the mutex and instead allocate one once
in a thread independent way that could be used and reused, by extending
our pthread inteface to not only store TLS variables but also retrieve
them, and use one of those.

Since we are not interested on the capture groups (if any) lets only
allocate 1 pair which is all that will be needed and change the logic
so that a return of 0 (which means the pattern matched but there were
not enough fields) is also considered a match.

This will ensure that the memory use would be bound to the number of
concurrent matches instead of the number of patterns and therefore
reduce the impact that recent changes on the way the frames used for
matching are allocated might had brough since 10.41 was released.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
Sent as an RFC since it has been very lightly tested (I can't even
build the whole project), and because I couldn't figure out where to
destroy the key, so it is adding a once on a lifetime leak of a pointer.

It is also more verbose than it needs, because I am combining it with
the revert of the workaround, and that could be split away, but that
would hopefully help with testing as well.

 libselinux/src/regex.c            | 77 ++++++++++++-------------------
 libselinux/src/selinux_internal.h |  4 ++
 2 files changed, 34 insertions(+), 47 deletions(-)

diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index 16df6790..201a6695 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -30,6 +30,10 @@
 #endif
 
 #ifdef USE_PCRE2
+static pthread_key_t match_data_key;
+static int match_data_key_uninitialized = 1;
+static __thread char match_data_initialized;
+
 char const *regex_arch_string(void)
 {
 	static char arch_string_buffer[32];
@@ -60,14 +64,6 @@ char const *regex_arch_string(void)
 
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
@@ -86,13 +82,6 @@ int regex_prepare_data(struct regex_data **regex, char const *pattern_string,
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
@@ -142,13 +131,6 @@ int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data **regex,
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
 
@@ -204,18 +186,16 @@ out:
 	return rc;
 }
 
+static void match_data_thread_free(void *match_data)
+{
+	pcre2_match_data_free(match_data);
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
@@ -223,32 +203,30 @@ void regex_data_free(struct regex_data *regex)
 int regex_match(struct regex_data *regex, char const *subject, int partial)
 {
 	int rc;
+	bool slow;
 	pcre2_match_data *match_data;
-	__pthread_mutex_lock(&regex->match_mutex);
 
-#ifdef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
-	match_data = pcre2_match_data_create_from_pattern(
-	    regex->regex, NULL);
-	if (match_data == NULL) {
-		__pthread_mutex_unlock(&regex->match_mutex);
-		return REGEX_ERROR;
+	if (match_data_initialized == 0) {
+		match_data = pcre2_match_data_create(1, NULL);
+		match_data_initialized = 1;
+		__selinux_setspecific(match_data_key, match_data);
+	} else
+		match_data = __selinux_getspecific(match_data_key);
+
+	slow = (match_data == NULL);
+	if (slow) {
+		match_data = pcre2_match_data_create_from_pattern(regex->regex,
+									NULL);
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
@@ -290,7 +268,12 @@ struct regex_data *regex_data_create(void)
 	if (!regex_data)
 		return NULL;
 
-	__pthread_mutex_init(&regex_data->match_mutex, NULL);
+	if (match_data_key_uninitialized) {
+		match_data_key_uninitialized = __selinux_key_create(
+							&match_data_key,
+							match_data_thread_free);
+	}
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
2.30.2

