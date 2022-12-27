Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD7DC10F1B
	for <selinux@archiver.kernel.org>; Tue, 27 Dec 2022 05:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiL0FuG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 27 Dec 2022 00:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiL0FuE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 27 Dec 2022 00:50:04 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C484CFC2
        for <selinux@vger.kernel.org>; Mon, 26 Dec 2022 21:50:02 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g9-20020a25bdc9000000b0073727a20239so13450192ybk.4
        for <selinux@vger.kernel.org>; Mon, 26 Dec 2022 21:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YZzCgv8P7E9YDE821tMqqCdUUmpwmqwOFJY8Q2QDzNc=;
        b=bnDkg7hfb2HSjqPubXs7kLrdCnPFdAqYQYk5v4kwvxUPCDaeZfDyTcHAmvKf/ESQy3
         i9hQv6PZcEKn6HvgnHcLsoP90MkAIN//qyPU5OZzvnTlPS3QpOht3ssvEwkCte4nPKXi
         r7xzcjDqllWUOEyzYXvrBq8NkfcXqxKtZgUcrVvawF/9SAkKm4AdYE1r/VpJqNH238DU
         XAsbSn9RLRnki4R9yxdZFfGMiTy+UMMyraBrm3gMAgeZQ2RDfss5+eldqFjHvB41oL9S
         wduV+4yhK9ENmQmzWKw3znvk0s4SzItetzBePLV6t15ramUk8XD7ImkYXrez9/E44ZQl
         HlEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YZzCgv8P7E9YDE821tMqqCdUUmpwmqwOFJY8Q2QDzNc=;
        b=DBAf4/uNMcrHeqVh17fwGnkOAE4cGtWoqrSFg6WTXBb+KS58RK1Jdf8wMrwpb6Yfft
         5xfyVODqZVWbaaqvujyVDT+SA0O1Yb3htGqnUSLdOU38BRLlxPnSzXVrjTmq/tZO/wZk
         nSOiMUUfZxvU7kiv5Eml45l46IbiW/JrlDhSGjOvYdWaCZEd/QlcdrLnIHA0qADKidH9
         Chfp78J0XmF2TTwiYFrGqVax/NWRZpo1dXAUfBtKT0e2o7FMXobIFOCZkTuiu69KjH+h
         lBObRSiM32bfrE/MLZ/5U9ULRUtoemuufwYHrWmpR3O6qtTWQvzhQ9oaPwYFsPk2MS/x
         vTfw==
X-Gm-Message-State: AFqh2koJtZg8StPLBuxn57LPCHnrvlO7riQByBE4wtLujEe7eyshYrJQ
        joSLE3s4SvyV9Njimk/w5AVRHDd2yyKnBB91aQ4obw1D7an0e2IvdurvLMR+GsPzdFDCSGT2K+t
        0U5/u614xCJBDA1XB914Q7+6et2cizun8WNedtVsUj0ZGSzY07QibcEWfXgUeHUM=
X-Google-Smtp-Source: AMrXdXtyAKW9T2QiJOyp9LkWwj2ndp1DLROZqD9hLL1l+oE2C6dWe7wpi/J2Ejqy4OmlPJEv0jRoz04SMIs=
X-Received: from inseob.seo.corp.google.com ([2401:fa00:d:11:477c:24:182e:a851])
 (user=inseob job=sendgmr) by 2002:a05:690c:885:b0:475:9f2c:899 with SMTP id
 cd5-20020a05690c088500b004759f2c0899mr1049177ywb.290.1672120202039; Mon, 26
 Dec 2022 21:50:02 -0800 (PST)
Date:   Tue, 27 Dec 2022 14:49:40 +0900
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221227054939.1053698-1-inseob@google.com>
Subject: [PATCH v2] libselinux: Workaround for heap overhead of pcre
From:   Inseob Kim <inseob@google.com>
To:     selinux@vger.kernel.org
Cc:     Inseob Kim <inseob@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

pcre's behavior is changed so that pcre2_match always allocates heap for
match_data, rather than stack, regardless of size. The heap isn't freed
until explicitly calling pcre2_match_data_free. This new behavior may
result in heap overhead, which may increase the peak memory usage about
a few megabytes. It's because regex_match is first called for regex_data
objects, and then regex_data objects are freed at once.

To workaround it, free match_data as soon as we call regex_match. It's
fine because libselinux currently doesn't use match_data, but use only
the return value.

Signed-off-by: Inseob Kim <inseob@google.com>

---
v2:
  - add AGGRESSIVE_FREE_AFTER_REGEX_MATCH macro
  - remove match_data from struct regex_data
---
 libselinux/src/regex.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index 149a7973..4b4b9f08 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -60,11 +60,13 @@ char const *regex_arch_string(void)
 
 struct regex_data {
 	pcre2_code *regex; /* compiled regular expression */
+#ifndef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
 	/*
 	 * match data block required for the compiled
 	 * pattern in pcre2
 	 */
 	pcre2_match_data *match_data;
+#endif
 	pthread_mutex_t match_mutex;
 };
 
@@ -84,11 +86,13 @@ int regex_prepare_data(struct regex_data **regex, char const *pattern_string,
 		goto err;
 	}
 
+#ifndef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
 	(*regex)->match_data =
 	    pcre2_match_data_create_from_pattern((*regex)->regex, NULL);
 	if (!(*regex)->match_data) {
 		goto err;
 	}
+#endif
 	return 0;
 
 err:
@@ -138,10 +142,12 @@ int regex_load_mmap(struct mmap_area *mmap_area, struct regex_data **regex,
 		if (rc != 1)
 			goto err;
 
+#ifndef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
 		(*regex)->match_data =
 		    pcre2_match_data_create_from_pattern((*regex)->regex, NULL);
 		if (!(*regex)->match_data)
 			goto err;
+#endif
 
 		*regex_compiled = true;
 	}
@@ -203,8 +209,12 @@ void regex_data_free(struct regex_data *regex)
 	if (regex) {
 		if (regex->regex)
 			pcre2_code_free(regex->regex);
+
+#ifndef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
 		if (regex->match_data)
 			pcre2_match_data_free(regex->match_data);
+#endif
+
 		__pthread_mutex_destroy(&regex->match_mutex);
 		free(regex);
 	}
@@ -213,10 +223,30 @@ void regex_data_free(struct regex_data *regex)
 int regex_match(struct regex_data *regex, char const *subject, int partial)
 {
 	int rc;
+	pcre2_match_data *match_data;
 	__pthread_mutex_lock(&regex->match_mutex);
+
+#ifdef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
+	match_data = pcre2_match_data_create_from_pattern(
+	    regex->regex, NULL);
+	if (match_data == NULL) {
+		__pthread_mutex_unlock(&regex->match_mutex);
+		return REGEX_ERROR;
+	}
+#else
+	match_data = regex->match_data;
+#endif
+
 	rc = pcre2_match(
 	    regex->regex, (PCRE2_SPTR)subject, PCRE2_ZERO_TERMINATED, 0,
-	    partial ? PCRE2_PARTIAL_SOFT : 0, regex->match_data, NULL);
+	    partial ? PCRE2_PARTIAL_SOFT : 0, match_data, NULL);
+
+#ifdef AGGRESSIVE_FREE_AFTER_REGEX_MATCH
+	// pcre2_match allocates heap and it won't be freed until
+	// pcre2_match_data_free, resulting in heap overhead.
+	pcre2_match_data_free(match_data);
+#endif
+
 	__pthread_mutex_unlock(&regex->match_mutex);
 	if (rc > 0)
 		return REGEX_MATCH;
-- 
2.39.0.314.g84b9a713c41-goog

