Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D113C4332E
	for <selinux@archiver.kernel.org>; Fri,  8 Jan 2021 16:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DB50239D1
	for <selinux@archiver.kernel.org>; Fri,  8 Jan 2021 16:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbhAHQCc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Jan 2021 11:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbhAHQCc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Jan 2021 11:02:32 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E824C0612A8
        for <selinux@vger.kernel.org>; Fri,  8 Jan 2021 08:00:57 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id g20so15236719ejb.1
        for <selinux@vger.kernel.org>; Fri, 08 Jan 2021 08:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GhtjiTKMLYG9AohrKdKbPaqRWKgqgeiBZr8pde87exo=;
        b=B428iN/WQaWTnqwaqpS1qE5QrLbmAO9OTDOaH2wTMA9XbtTJLFYTQdiHl3uXlTPt1n
         KHFo7Himsh3yLnxuhkk68Ki1xEpl47tR6LabGRNlw6K+PChpWDOF9sTUYQx4GoHGDK4X
         ffPPg3B+PEO1XNjlctbLIBKsKNhTc0ZEVh7YamGMcOMpWeeCvEivm7rtTS7NyUUe06Jz
         gQ9AlT1OMY6YunvZy9Jtq+mGS0l6Ogo1n+7yV36bCHUtu1pAwvzSU8d/s7donR+tYV1Y
         74DYZRoZOTAxMzv9dDPeQi980uzAu+G5gBk0ASLjbrgKi5jQbeVQ2o3vBdvbGvWQg3X4
         LKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GhtjiTKMLYG9AohrKdKbPaqRWKgqgeiBZr8pde87exo=;
        b=P7uTwNEB7kiDzvYRxY+xX+apD/4mTBNegxwlJVzkPPqNVtDbgLENpFbpSn8n/ZjHAF
         8a5wn66RmKGI+8cDfkBVKipgIne2iCnjgWKV08PtZcUV9Dma4wrh8CZ0r6ZuH+odhDwt
         /odDMTTcGHAuaFnU/7TQxcAiGTf2Gbm8TlITWi7Yepb9X3tJzZauZEWV9QmByRzzS6Rc
         3H2JYRvC7xPVLh/6bA+oDtwqUgjnDxRyYmWG/JTDnWRji42GGB92nnNaSFlG0enNoUz+
         k5WEiA+ksi5Xv3iKfteeRnXFXvR0vBm1WRGDkSZUpw7KR1a0Pt85+gmLaLFJLRdAKsH5
         zo2g==
X-Gm-Message-State: AOAM533F01mc3yELm+Ts+QveErGJ1DUbkTSktJMxRk6mXweA+TE++Tq6
        ikRRaHRzh/ujW/RQIiL9z9e51ydbcD0=
X-Google-Smtp-Source: ABdhPJwPYKr6vr+CJ8bCI9PnD/aD0ui4MmrL2Om8lpcsdDTssl+G8bSlfqM9W6Omd3aAfZ0rBUYSiQ==
X-Received: by 2002:a17:906:e84:: with SMTP id p4mr3143089ejf.141.1610121655817;
        Fri, 08 Jan 2021 08:00:55 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-000-252-188.77.0.pool.telefonica.de. [77.0.252.188])
        by smtp.gmail.com with ESMTPSA id rk12sm3650687ejb.75.2021.01.08.08.00.55
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 08:00:55 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/2] libselinux: update getseuser
Date:   Fri,  8 Jan 2021 17:00:48 +0100
Message-Id: <20210108160048.67386-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210108160048.67386-1-cgzones@googlemail.com>
References: <20210108160048.67386-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

- Bail out if not running on a SELinux enabled system
- Check whether the passed context is valid
- Do not report a get_ordered_context_list_with_level failure on zero
  found contexts

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/getseuser.c | 47 +++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/libselinux/utils/getseuser.c b/libselinux/utils/getseuser.c
index 9193fe0a..ce1b7b27 100644
--- a/libselinux/utils/getseuser.c
+++ b/libselinux/utils/getseuser.c
@@ -9,32 +9,51 @@ int main(int argc, char **argv)
 {
 	char *seuser = NULL, *level = NULL;
 	char **contextlist;
-	int rc, n, i;
+	int rc, n;
 
 	if (argc != 3) {
 		fprintf(stderr, "usage:  %s linuxuser fromcon\n", argv[0]);
-		exit(1);
+		return 1;
+	}
+
+	if (!is_selinux_enabled()) {
+		fprintf(stderr, "%s may be used only on a SELinux enabled kernel.\n", argv[0]);
+		return 4;
 	}
 
 	rc = getseuserbyname(argv[1], &seuser, &level);
 	if (rc) {
-		fprintf(stderr, "getseuserbyname failed:  %s\n",
-			strerror(errno));
-		exit(2);
+		fprintf(stderr, "getseuserbyname failed:  %s\n", strerror(errno));
+		return 2;
 	}
 	printf("seuser:  %s, level %s\n", seuser, level);
-	n = get_ordered_context_list_with_level(seuser, level, argv[2],
-						&contextlist);
-	if (n <= 0) {
-		fprintf(stderr,
-			"get_ordered_context_list_with_level failed:  %s\n",
-			strerror(errno));
-		exit(3);
+
+	rc = security_check_context(argv[2]);
+	if (rc) {
+		fprintf(stderr, "context '%s' is invalid\n", argv[2]);
+		free(seuser);
+		free(level);
+		return 5;
+	}
+
+	n = get_ordered_context_list_with_level(seuser, level, argv[2], &contextlist);
+	if (n < 0) {
+		fprintf(stderr, "get_ordered_context_list_with_level failed:  %s\n", strerror(errno));
+		free(seuser);
+		free(level);
+		return 3;
 	}
+
 	free(seuser);
 	free(level);
-	for (i = 0; i < n; i++)
+
+	if (n == 0)
+		printf("no valid context found\n");
+
+	for (int i = 0; i < n; i++)
 		printf("Context %d\t%s\n", i, contextlist[i]);
+
 	freeconary(contextlist);
-	exit(EXIT_SUCCESS);
+
+	return EXIT_SUCCESS;
 }
-- 
2.30.0

