Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762DAC433ED
	for <selinux@archiver.kernel.org>; Fri, 23 Apr 2021 16:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 450A8611BF
	for <selinux@archiver.kernel.org>; Fri, 23 Apr 2021 16:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhDWQnC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 23 Apr 2021 12:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240603AbhDWQnC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 23 Apr 2021 12:43:02 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60BBC061574
        for <selinux@vger.kernel.org>; Fri, 23 Apr 2021 09:42:24 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id r17-20020a1709069591b029037cf6a4a56dso8732454ejx.12
        for <selinux@vger.kernel.org>; Fri, 23 Apr 2021 09:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LA1ebuQf9hFwry+zA69pTprrWV0oo/1tYoiYWpUG0ps=;
        b=PxRibj6XF71/27cU8jQOOOZ97zU/+KUsOK3Wrnbq1axM1sh7mtGpzM3T+pEkEKi2bu
         epHP3FoGLG87ALKIZOw2jzcJHP5JPfTcOyu8Xs+p54iLaVoAOQXiItH3lxu6u1NOJAZD
         0fJXImOVtbEYqMNi5ICDdEthMiHE+wKOWHolvCJhUHfhkv+k+5d+CvxrSopFxZtoCMgR
         drDLmLONptYzpo1kXQ+LFbgbsX2sQmhkGRi+qFMr47Bh5oSnPe05qhX6nf92SKhwtjVg
         gLilbQhd93uLMEaAQxGEaz54p3Vb9dukLn/9tfr+e/W1scnPY81gul59KzxIVGqDRqdq
         LrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LA1ebuQf9hFwry+zA69pTprrWV0oo/1tYoiYWpUG0ps=;
        b=BJvFMcpE3eE3IXKzNT22OBceZ075vyUk3xBvfH4GntfnsvSDAta1S1T2aHsWonq6vk
         tgJEhpd0QFizHnkIU3pOHwbucFjClZXyIutX/GzPeNLB0kira+XKZd3nKess7t7ei8Jk
         ZJxYwo8MnuIXPg4U0XAv/gwFpG/DteDmoF0uKwenp9kbhwk7Wg+pYUUhJsDqT3u9S3MD
         mCaymWDfkfI7W0FDtFfLDOi6547WbJjf+Xs2wVkbflttetokW5IlyCmbKiMIUcnFKUDZ
         tXd2LpWMIA6p0Mxm5nFIdWnCtjLkxNIKmrob5wuIAWjWd7xzMr17IWoIxOH/4uGgdZNJ
         gsDQ==
X-Gm-Message-State: AOAM531g/2IsrJM4etR2Ps0v0fWL36NEn4hCpF/rffxMS3yy37Tj7vlH
        1neR6uy/Ro8Lahz9L1MXND1vk0aKATeih2UaCMj5M89efUW1Zc8mJfAabXCH30Ob8Xw/epMNj9S
        PcERisIAxTRhowLLQonoPEFnyGEMC2WvK7v5GSCmXnjJKNsFd9f7nA+GakCDH
X-Google-Smtp-Source: ABdhPJxL3vUVMypMqjDWR0KM9/Zc/T1kIt7zMZvaOYza8omV6CsASG3vm2gEp9IhkJby1wjOuUKy/1hmQA==
X-Received: from jeffv-p920.zrh.corp.google.com ([2a00:79e0:61:301:394f:5171:314d:2a3])
 (user=jeffv job=sendgmr) by 2002:a05:6402:2215:: with SMTP id
 cq21mr5577991edb.177.1619196143462; Fri, 23 Apr 2021 09:42:23 -0700 (PDT)
Date:   Fri, 23 Apr 2021 18:42:09 +0200
Message-Id: <20210423164209.482593-1-jeffv@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH] libselinux android: Add keystore2_key label module.
From:   Jeff Vander Stoep <jeffv@google.com>
To:     selinux@vger.kernel.org
Cc:     Jeff Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch adds a new Android specific module for keystore2 key
namespace lookup. It assumes the presence of keystore_contexts files
mapping numeric namespace identifiers to SELinux labels. Keystore 2.0
uses this module to exert more granular access control and allow system
and vendor components to share explicit key namespaces.

Note that this patch was originally accepted July 30, 2020 into AOSP.
https://android-review.googlesource.com/c/platform/external/selinux/+/1329357

Original author: Kunal Shindea <shindek@google.com>
Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
---
 libselinux/include/selinux/label.h      | 2 ++
 libselinux/src/label.c                  | 3 ++-
 libselinux/src/label_backends_android.c | 6 +++---
 libselinux/src/label_internal.h         | 2 +-
 libselinux/utils/selabel_lookup.c       | 2 ++
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
index e8983606..95e9a9b0 100644
--- a/libselinux/include/selinux/label.h
+++ b/libselinux/include/selinux/label.h
@@ -37,6 +37,8 @@ struct selabel_handle;
 #define SELABEL_CTX_ANDROID_PROP 4
 /* Android service contexts */
 #define SELABEL_CTX_ANDROID_SERVICE 5
+/* Android keystore key contexts */
+#define SELABEL_CTX_ANDROID_KEYSTORE2_KEY 6
 
 /*
  * Available options
diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index a03192e5..dfc4e0bf 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -51,7 +51,8 @@ static selabel_initfunc initfuncs[] = {
 	CONFIG_X_BACKEND(selabel_x_init),
 	CONFIG_DB_BACKEND(selabel_db_init),
 	CONFIG_ANDROID_BACKEND(selabel_property_init),
-	CONFIG_ANDROID_BACKEND(selabel_service_init),
+	CONFIG_ANDROID_BACKEND(selabel_exact_match_init),//service init
+	CONFIG_ANDROID_BACKEND(selabel_exact_match_init),//keyStore key init
 };
 
 static inline struct selabel_digest *selabel_is_digest_set
diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/label_backends_android.c
index cb8aae26..1cb83008 100644
--- a/libselinux/src/label_backends_android.c
+++ b/libselinux/src/label_backends_android.c
@@ -278,7 +278,7 @@ finish:
 	return ret;
 }
 
-static struct selabel_lookup_rec *service_lookup(struct selabel_handle *rec,
+static struct selabel_lookup_rec *lookup_exact_match(struct selabel_handle *rec,
 		const char *key, int __attribute__((unused)) type)
 {
 	struct saved_data *data = (struct saved_data *)rec->data;
@@ -333,7 +333,7 @@ int selabel_property_init(struct selabel_handle *rec,
 	return init(rec, opts, nopts);
 }
 
-int selabel_service_init(struct selabel_handle *rec,
+int selabel_exact_match_init(struct selabel_handle *rec,
 		const struct selinux_opt *opts, unsigned nopts)
 {
 	struct saved_data *data;
@@ -345,7 +345,7 @@ int selabel_service_init(struct selabel_handle *rec,
 	rec->data = data;
 	rec->func_close = &closef;
 	rec->func_stats = &stats;
-	rec->func_lookup = &service_lookup;
+	rec->func_lookup = &lookup_exact_match;
 
 	return init(rec, opts, nopts);
 }
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index 361b443c..fde55484 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -38,7 +38,7 @@ int selabel_db_init(struct selabel_handle *rec,
 int selabel_property_init(struct selabel_handle *rec,
 			    const struct selinux_opt *opts,
 			    unsigned nopts) ;
-int selabel_service_init(struct selabel_handle *rec,
+int selabel_exact_match_init(struct selabel_handle *rec,
 			    const struct selinux_opt *opts,
 			    unsigned nopts) ;
 
diff --git a/libselinux/utils/selabel_lookup.c b/libselinux/utils/selabel_lookup.c
index 1aef64de..b18e5fc6 100644
--- a/libselinux/utils/selabel_lookup.c
+++ b/libselinux/utils/selabel_lookup.c
@@ -59,6 +59,8 @@ int main(int argc, char **argv)
 				backend = SELABEL_CTX_ANDROID_PROP;
 			} else if (!strcmp(optarg, "service")) {
 				backend = SELABEL_CTX_ANDROID_SERVICE;
+			} else if (!strcmp(optarg, "keystore2_key")) {
+				backend = SELABEL_CTX_ANDROID_KEYSTORE2_KEY;
 			} else {
 				fprintf(stderr, "Unknown backend: %s\n",
 								    optarg);
-- 
2.31.1.498.g6c1eba8ee3d-goog

