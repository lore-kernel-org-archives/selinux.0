Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7E9C433DB
	for <selinux@archiver.kernel.org>; Tue, 30 Mar 2021 17:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68C5C61864
	for <selinux@archiver.kernel.org>; Tue, 30 Mar 2021 17:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhC3Rke (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Mar 2021 13:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbhC3RkM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Mar 2021 13:40:12 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE569C061574
        for <selinux@vger.kernel.org>; Tue, 30 Mar 2021 10:40:11 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id q9so8558944qvm.6
        for <selinux@vger.kernel.org>; Tue, 30 Mar 2021 10:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ugPn4ymvJO2IysGlmVjkRSV2aKXzmMn1/mf02gyGb4=;
        b=EEFgvwJlYY16CXUBRMQm83tOi0Sma0bI5DYtmGNC+x3y+VEKwd50O5Wij3E0ruNAT0
         2kG2RYNsgSwkHUHafjkHrux59HKAOhMCyGbsuZdHK8lq4uw+86qAR0s/Tj2qo2ftcvfm
         GqCxBl/QMycYBN79Rs/CoRoQP5MuJjFrsfPi3nQjowpMINR2RoaDZNN3FqtF86p+KidL
         XuBIDYaMiAaBMrFXU4EpZ5rt62gCoG3bROgeVsCJjm8T5H55NDqZFwJF8mhJ2mZb3wVU
         SIscPzjPfCukRtmQqz2kd60Xi7POVlBeM6A9AddPoX0tU5yIEH+XIGcUgai23werKe8D
         1hWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ugPn4ymvJO2IysGlmVjkRSV2aKXzmMn1/mf02gyGb4=;
        b=TiiOw5XzrBlUWUfd+ZjNecT9vIeOSu0fkJ6Twwzst1sSFDGTakOkBYKnyrcdZvHy3h
         E1fpCnquxIZYUMpKkI/mrfdNyT696OTOL3RNO+ajgTFKH1Xu3LlVAKzWyyUzNISwdulR
         q6FHud1Aji647rgcLUIyN80HkKI5mHQIRa7NyjCCPLKUu6DILSGiX+5bxaC4PeSqIr8p
         uvCrZ1t7Qdwb8vur0aJpCvdTxVD2FAxxPIgo7sBQdmFmbIfQwebqoHTDvoAogglBBc+G
         Zybvf9JnyIxAK+vt+5+9ibhMnVTzcc1yQilZTUE6y3fEjcRenrPtpIAA8Czfzto/EyIR
         h+Bg==
X-Gm-Message-State: AOAM533k07crA4U/F4S+jaxYALEzvU4+3deJGSNaanfrkodEw2qvyP84
        LzNVaeMY8yyKOQnn1xzWb4/L7Y94Zq9lLw==
X-Google-Smtp-Source: ABdhPJyYXTT7L/JNvtjdMFVEI7kQOhi1jUGOLv9iMU+szP+GFrID0zQzuOwCKwnrIJoij7iXTGPgxA==
X-Received: by 2002:a05:6214:154a:: with SMTP id t10mr31666868qvw.7.1617126010931;
        Tue, 30 Mar 2021 10:40:10 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id z11sm16295118qkg.52.2021.03.30.10.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 10:40:10 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH 11/12] libsepol/cil: Use CIL_ERR for error messages in cil_compile()
Date:   Tue, 30 Mar 2021 13:40:02 -0400
Message-Id: <20210330174003.281613-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210330174003.281613-1-jwcart2@gmail.com>
References: <20210330174003.281613-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In cil_compile(), CIL_INFO is being used as the priority for
error messages. This can make it difficult to tell when the error
occurred.

Instead, use CIL_ERR as the priority for the error messages in
cil_compile().

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
index 99c8e288..b971922c 100644
--- a/libsepol/cil/src/cil.c
+++ b/libsepol/cil/src/cil.c
@@ -539,7 +539,7 @@ int cil_compile(struct cil_db *db)
 	cil_log(CIL_INFO, "Building AST from Parse Tree\n");
 	rc = cil_build_ast(db, db->parse->root, db->ast->root);
 	if (rc != SEPOL_OK) {
-		cil_log(CIL_INFO, "Failed to build ast\n");
+		cil_log(CIL_ERR, "Failed to build AST\n");
 		goto exit;
 	}
 
@@ -549,21 +549,21 @@ int cil_compile(struct cil_db *db)
 	cil_log(CIL_INFO, "Resolving AST\n");
 	rc = cil_resolve_ast(db, db->ast->root);
 	if (rc != SEPOL_OK) {
-		cil_log(CIL_INFO, "Failed to resolve ast\n");
+		cil_log(CIL_ERR, "Failed to resolve AST\n");
 		goto exit;
 	}
 
 	cil_log(CIL_INFO, "Qualifying Names\n");
 	rc = cil_fqn_qualify(db->ast->root);
 	if (rc != SEPOL_OK) {
-		cil_log(CIL_INFO, "Failed to qualify names\n");
+		cil_log(CIL_ERR, "Failed to qualify names\n");
 		goto exit;
 	}
 
 	cil_log(CIL_INFO, "Compile post process\n");
 	rc = cil_post_process(db);
 	if (rc != SEPOL_OK ) {
-		cil_log(CIL_INFO, "Post process failed\n");
+		cil_log(CIL_ERR, "Post process failed\n");
 		goto exit;
 	}
 
-- 
2.26.3

