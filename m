Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E959FC433E3
	for <selinux@archiver.kernel.org>; Tue, 23 Mar 2021 17:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAC1E619C1
	for <selinux@archiver.kernel.org>; Tue, 23 Mar 2021 17:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhCWRIq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Mar 2021 13:08:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31196 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230012AbhCWRIj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Mar 2021 13:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616519318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rjzJasRBxw34UbMKn+ObE744UMZilgb5zYojamytsI8=;
        b=GNoJ9pnjTRhg7N+BbZ3IjCcEme3imHNADmjGeZBvbUZ6XVCtRWzw2I6pWq6hUkk1+FxWaV
        9WuJsLVpAo9fN6NAyCa3asekKwjT/6V+nNf512Oofl4OeAHtKQGPQZ7ZlqqDzoYDs6hUWX
        GYkGTsiDfl9jaRushAiF75pvvLzDw9I=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-LUy7l5UIMDiOd2KsTVuCcQ-1; Tue, 23 Mar 2021 13:08:37 -0400
X-MC-Unique: LUy7l5UIMDiOd2KsTVuCcQ-1
Received: by mail-ed1-f70.google.com with SMTP id h2so1264296edw.10
        for <selinux@vger.kernel.org>; Tue, 23 Mar 2021 10:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rjzJasRBxw34UbMKn+ObE744UMZilgb5zYojamytsI8=;
        b=AJs7eV3UnutOJxNfsk3iNU8GZb9A9Fz+99U+QYdUitlcScLESjAKuyV8UIsB44tMjI
         V/OayecN4RflQAxu30a19w5c5Ws+ReTpfoc5JeaVuBi2p7DPhe/5axf8LTdQ8hUw6quV
         AiMzVMGoB9jyVpEh5b93UmnsrxXbRaOPRByu9QFK4J53RVVP3YuXvLnN2JdPesLBC+K8
         lmEyW5JVvkwMcQw5h5pM/URJf8aU4Ue3LVZSQLgVqfKU+E56tDa95Wcfy04kHEHzDXwH
         0zFXQ602yr3cwSXfcX2mX2bnkgHXEomrKo9pxJEozJQd7z7PHLesAgfSTZ536SdovAQk
         JIrQ==
X-Gm-Message-State: AOAM531tqAFyWipbNTVgtc7pEJvLLdg5xmXglNB+bT+HBI6KXtKy/2CS
        PKi9Bpu7TMk8ujlP6a9R/+UtruczCIsYgYvP4tN5tIISWkee9IK3IYQM641qQOQARaOew9Kir7H
        y48OrGAdW5WxGr/8kCyh72/PuO6YVxichBw1jIO2mj09jBX1PO6DksnR5i+9P/6/G9j60ug==
X-Received: by 2002:a05:6402:26c9:: with SMTP id x9mr5456950edd.322.1616519315602;
        Tue, 23 Mar 2021 10:08:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVdsePbng62/IVqwDwk27v+GpHwfAVpTiDtxP2rvISUUejiBtM9J2YWnrfEtyX2VVE+XkU5g==
X-Received: by 2002:a05:6402:26c9:: with SMTP id x9mr5456933edd.322.1616519315409;
        Tue, 23 Mar 2021 10:08:35 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id k9sm13337948edn.68.2021.03.23.10.08.34
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 10:08:34 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH userspace 3/6] selinux_restorecon: introduce selinux_log_sync()
Date:   Tue, 23 Mar 2021 18:08:27 +0100
Message-Id: <20210323170830.182553-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210323170830.182553-1-omosnace@redhat.com>
References: <20210323170830.182553-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a thread-safe version of selinux_log() and initially use it in
filespec_add(). Together with the previous patch this makes
filespec_add() thread-safe, which will be utilized in subsequent
patches.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libselinux/src/selinux_restorecon.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index f4a973eb..0ebe56b1 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -46,6 +46,15 @@ static bool selabel_no_digest;
 static char *rootpath = NULL;
 static int rootpathlen;
 
+/* Thread-safe log function for parallel restorecon */
+static pthread_mutex_t log_mutex = PTHREAD_MUTEX_INITIALIZER;
+
+#define selinux_log_sync(type, ...) do { \
+	__pthread_mutex_lock(&log_mutex); \
+	selinux_log(type, __VA_ARGS__); \
+	__pthread_mutex_unlock(&log_mutex); \
+} while(0)
+
 /* Information on excluded fs and directories. */
 struct edir {
 	char *directory;
@@ -455,7 +464,7 @@ static int filespec_add(ino_t ino, const char *con, const char *file,
 			if (strcmp(fl->con, con) == 0)
 				goto unlock_1;
 
-			selinux_log(SELINUX_ERROR,
+			selinux_log_sync(SELINUX_ERROR,
 				"conflicting specifications for %s and %s, using %s.\n",
 				file, fl->file, fl->con);
 			free(fl->file);
@@ -466,7 +475,7 @@ static int filespec_add(ino_t ino, const char *con, const char *file,
 			__pthread_mutex_unlock(&fl_mutex);
 
 			if (flags->conflicterror) {
-				selinux_log(SELINUX_ERROR,
+				selinux_log_sync(SELINUX_ERROR,
 				"treating conflicting specifications as an error.\n");
 				return -1;
 			}
@@ -497,7 +506,7 @@ oom_freefl:
 	free(fl);
 oom:
 	__pthread_mutex_unlock(&fl_mutex);
-	selinux_log(SELINUX_ERROR, "%s:  Out of memory\n", __func__);
+	selinux_log_sync(SELINUX_ERROR, "%s:  Out of memory\n", __func__);
 	return -1;
 unlock_1:
 	__pthread_mutex_unlock(&fl_mutex);
-- 
2.30.2

