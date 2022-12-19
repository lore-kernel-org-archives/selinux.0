Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0E4C4332F
	for <selinux@archiver.kernel.org>; Mon, 19 Dec 2022 08:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiLSIx6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Dec 2022 03:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiLSIx5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Dec 2022 03:53:57 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BEC1FA
        for <selinux@vger.kernel.org>; Mon, 19 Dec 2022 00:53:55 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3d0465d32deso103254037b3.20
        for <selinux@vger.kernel.org>; Mon, 19 Dec 2022 00:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/ox30e9hM+wQN6R718LHcO/VeywQzoZpiXJDzalGLqY=;
        b=V1JviPwZT0fVD2uuo2HrcKcZEFd09wpjHI5SjZ7e9y2zY3Dz/uYa7AnBKlyltQg7fK
         GI0ex6FPHi1WINhy0I0nIzw+P8zoYt80rAvP+hx4zpEpHnKR+kZ4sLerzd/QaQGrrPwq
         dGEwPypYxeXXImV0q/+GuBKdl/hY3JhexKwArvczpEOrKiwFe4vztPS1pA3oUN8vTjQd
         VHbgc5iJu7QVgax4v2/KbgRGStOtTBYQSdkGxSZO4m63/BGe9wDobZNhV54i5ngcLTnH
         K6H6EdFJcPC85XFsoDCk/DN1TykHYcET4GypZZeVmQuskRVnAtZrvXqaw2JVxuCDtcHP
         AgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ox30e9hM+wQN6R718LHcO/VeywQzoZpiXJDzalGLqY=;
        b=Sta9612uWdhoxfdZsw1yDeGdBjT+lFdSuzv9t4eBqx6pZLAC5E9A1b8qLlLAMo/BFv
         0AigDmJGbURuD6wMakL6R45x7EX6XiEYLkIIVaIIY7XY3aFMFwWUpneRMgKDHm0QkEdE
         +oV4FAl6ugde9MPj2/DEseM502MVy9fN42YYo0wQrG/s/hUrGQJd/KFIfr82ooRHZu+v
         YnTsCpupqYtkYIkcPMemq+hN78CeZFP2hZ1N1SeWWPS2fo6UQDweC9igTVDOEKfkyfzZ
         IHh63uWspPKTq+ZrpFtc1kPHXtWD/FyIokyiXpaxHulcJiKh+fR2Zze/DF3C2SXszxBj
         nHHw==
X-Gm-Message-State: AFqh2koL7t1hnh5hzZR6Az6ca4TZYjq729HCFSLDVLbq1msCcYhVAOr5
        2EmfNUs1eL6cKg/x2HxG9H0wusfldHS2VfyWhQwHVHZ4/VpyJ6yy63eau2AZ2unj9uYEx9+NuPx
        jjhYTlofMBnbzWY+6nm4JGWmibCLIiEEjt6lL5uoMdjSY1o9Au9g5RZrPtkvL0Qw=
X-Google-Smtp-Source: AMrXdXtVXQtnd1280FBzpDrNp7vumSePHaCqluwNtbw5PLBtMxddGRrT7XFfKoHp3CNL9UL66gPSSc9iL+Y=
X-Received: from inseob.seo.corp.google.com ([2401:fa00:d:11:4ce9:723d:fe99:a915])
 (user=inseob job=sendgmr) by 2002:a25:33c5:0:b0:734:c137:5a91 with SMTP id
 z188-20020a2533c5000000b00734c1375a91mr2119103ybz.487.1671440035169; Mon, 19
 Dec 2022 00:53:55 -0800 (PST)
Date:   Mon, 19 Dec 2022 17:53:36 +0900
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221219085336.391225-1-inseob@google.com>
Subject: [PATCH] libselinux: Workaround for heap overhead of pcre
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

To workaround it, free and reallocate match_data whenever we call
regex_match. It's fine because libselinux currently doesn't use
match_data, but use only the return value.

Signed-off-by: Inseob Kim <inseob@google.com>
---
 libselinux/src/regex.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index 149a7973..2df282f1 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -213,10 +213,20 @@ void regex_data_free(struct regex_data *regex)
 int regex_match(struct regex_data *regex, char const *subject, int partial)
 {
 	int rc;
+	pcre2_match_data *new_match_data;
 	__pthread_mutex_lock(&regex->match_mutex);
+	new_match_data = pcre2_match_data_create_from_pattern(
+	    regex->regex, NULL);
 	rc = pcre2_match(
 	    regex->regex, (PCRE2_SPTR)subject, PCRE2_ZERO_TERMINATED, 0,
 	    partial ? PCRE2_PARTIAL_SOFT : 0, regex->match_data, NULL);
+	// pcre2_match allocates heap and it won't be freed until
+	// pcre2_match_data_free, resulting in heap overhead.
+	// Reallocate match_data to prevent such overhead, whenever possible.
+	if (new_match_data) {
+		pcre2_match_data_free(regex->match_data);
+		regex->match_data = new_match_data;
+	}
 	__pthread_mutex_unlock(&regex->match_mutex);
 	if (rc > 0)
 		return REGEX_MATCH;
-- 
2.39.0.314.g84b9a713c41-goog

