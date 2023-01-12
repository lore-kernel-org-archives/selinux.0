Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B67C54EBC
	for <selinux@archiver.kernel.org>; Thu, 12 Jan 2023 09:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240057AbjALJ0Z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Jan 2023 04:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239840AbjALJZy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Jan 2023 04:25:54 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F0A5C1C0
        for <selinux@vger.kernel.org>; Thu, 12 Jan 2023 01:14:40 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id f8-20020a170902ce8800b00190c6518e21so12314747plg.1
        for <selinux@vger.kernel.org>; Thu, 12 Jan 2023 01:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YZzCgv8P7E9YDE821tMqqCdUUmpwmqwOFJY8Q2QDzNc=;
        b=s1SMl2OGqt1fVMpXXDkiIVMkVv2ew9QH4UqPIahqAsMYkfCGpdo6Q3CgaFrWQp3Kky
         t1MwL82BbmQ/PpeWGL8KAIU5//645PrrU0PnfGeeIyIqDoUIg1StcvYVQz8tSSyISJcw
         HQQrE+79q/+LulfVBcrJE8Kie3M0UJuuJsmk3q4+X6Ugk5g6s363D421vbp7+b0KubRs
         ElDp/3Dby2t23mTwpzSYZdQHaGLQkE3cd1IoXBWQkbjFHKfx4sti3ED9qFh9UrZCV4Y1
         Evkdb9JW4cbPRdBeXRDxUB5dTfv8N7KruEHLjZzZk74108xdCUTdsWKcQNHVhF7FhX5B
         dbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YZzCgv8P7E9YDE821tMqqCdUUmpwmqwOFJY8Q2QDzNc=;
        b=F8tZAWU1mjYyzVopxBqE+67u3KHevV1bHlbl7Dfx6byDZ63HwSTP7Fi0FRr9nUHmfg
         73+QE7QL2RtS/C8hthhs/qO927m74A4/4pY88ttzTbMPdE0yvUr80/TBWgWRA+31owPg
         Ib0QIrGWAY/XjkQ2VQg5kx78g17E7A+1DpbL83H/sMWwWu/p1v/eSrZBV5Tm/XWtkMHd
         LkCFG2E6dHmwDjrMRf8BXWbFyi0LGLSJuTU7qUtp5SiDVU/f+NJGJv5ir8mHWXPNWAQF
         56SKXyx9G3hxIDhAEDyHMCEKhwtVg6ecVETNdaT3SH3jAEAS84g3gmD6kBMUTbpofmDM
         Smzg==
X-Gm-Message-State: AFqh2krN6nM53n7i+wrz2HCMykNrmaRS6edCYDZQ1T1pZEraZhKM0V6w
        k8TULFuL0II18HDpXyR+ZDQr+RKROsSgpmc+n8Gh+T+AkOOzauhtde/rHlJI2N+ssSzY8pi6l9x
        VusxloxkLcyNmVsl9464hXZLVi+znGFEnfpx5rwaGt/v7zt8HpMivk6c+3KzvuKs=
X-Google-Smtp-Source: AMrXdXue3w1q1tUou/l4D4Y6+C9A9t2J9FVERRwm1GbHdgEXvwTvjdGB1qcajahtP4Q5RV3jfrGjtIy3KhY=
X-Received: from inseob.seo.corp.google.com ([2401:fa00:d:11:a59a:d3b4:f3d3:283d])
 (user=inseob job=sendgmr) by 2002:a17:90a:206:b0:226:9980:67f3 with SMTP id
 c6-20020a17090a020600b00226998067f3mr99801pjc.1.1673514879128; Thu, 12 Jan
 2023 01:14:39 -0800 (PST)
Date:   Thu, 12 Jan 2023 18:14:09 +0900
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230112091408.2880781-1-inseob@google.com>
Subject: [PATCH v2 RESEND] libselinux: Workaround for heap overhead of pcre
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

