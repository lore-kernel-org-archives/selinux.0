Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF71BC43462
	for <selinux@archiver.kernel.org>; Thu, 13 May 2021 18:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E75261264
	for <selinux@archiver.kernel.org>; Thu, 13 May 2021 18:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhEMS4C (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 May 2021 14:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbhEMS4B (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 May 2021 14:56:01 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBA9C061574
        for <selinux@vger.kernel.org>; Thu, 13 May 2021 11:54:50 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id 76so26503442qkn.13
        for <selinux@vger.kernel.org>; Thu, 13 May 2021 11:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9QDqmv8L4sOqxVSxNiacjWf4sGNN9j1gTzfLGs/MOao=;
        b=Vj5m12cxhwcr5uJWuK4jNwGhMSo0odXEM3KBcuZ53MrKsSqh0h3E51MwWMQsd/rPiC
         zIvxQLId+LNJTnJSuYzVSCcqnjjdHB3pMDoJc1f3mQ9W+RVeZsB+fpWCRJysgndQK3gI
         JNJq4DONjIzTbNgiIBFQLmpyk3nmmgY7kSrxFopOlkCQr751nNQTbnk7Ms/10SxbFe3Z
         Sx51y22SEbhvtGSl0XV4L5wP98OX6S+UsaVURLxUISnegwM6N/JO9K+leXRq/npAVRAI
         8DcmYVCO2XQuX9gbTiaZu7L0STam4GytsvQOsOqhI3pyQHU3s/zXWN0XgV9M5rBpaQfm
         WFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9QDqmv8L4sOqxVSxNiacjWf4sGNN9j1gTzfLGs/MOao=;
        b=FoEilpnqOSXPo1yzPOAgnERs/tsrx2nVsXU+MYv+af2jwvCgR4XvsY4a1rSbjU1BSs
         jTCyNRtXZB26DaULtuGLJDWWHP4OxGJ+jzHevj2/yBekICOkDDlFrpds/0fIw5UyVve+
         rPIy7GgEpnulRmePnZMZtiSfRVWS2ik4PXoXSxa6qa1fXUuGDPdvRN1FNRwcNrr6VN8y
         gVEbs0GKWJhvBI4OqIiljuTf77kt34xGFgiEkqH1Gylq8IYCQb7f/inq5YZunyiZz/79
         xBAKyQq4F8dDvtmxYdyd+7AmHQ58v0SyPLsiYi0D7ZlEAuYj/El6lIpMw01xkMNyMDXL
         8OWg==
X-Gm-Message-State: AOAM533LErMn/NY/tdUsqYcfRfQ+Cl4skhz5e5XLdF1m8/hF4butwAK/
        HenS+gPAo4788cYluNjRlGKuyLuaTCezOg==
X-Google-Smtp-Source: ABdhPJzznRCDKPU+OJB/6Big+ZbLI5xyHzFRIVXBqSuhzZvXSdyB6BYeZZLoQVtdw+LKmVgWG4lIjA==
X-Received: by 2002:a05:620a:2a0f:: with SMTP id o15mr18633199qkp.295.1620932089687;
        Thu, 13 May 2021 11:54:49 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id h188sm1713767qkf.133.2021.05.13.11.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 11:54:49 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 5/6] libsepol/cil: Pointers to datums should be set to NULL when resetting
Date:   Thu, 13 May 2021 14:52:53 -0400
Message-Id: <20210513185254.559588-6-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210513185254.559588-1-jwcart2@gmail.com>
References: <20210513185254.559588-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Set the pointer to the sensitivity in levels, the pointers to the low
and high levels in levelranges, the pointer to the level in userlevels,
the pointer to the range in userranges, and the pointers to contexts
in ocontexts to NULL.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_reset_ast.c | 56 ++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
index d24d4f81..6d1d2da7 100644
--- a/libsepol/cil/src/cil_reset_ast.c
+++ b/libsepol/cil/src/cil_reset_ast.c
@@ -140,8 +140,11 @@ static void cil_reset_userattributeset(struct cil_userattributeset *uas)
 
 static void cil_reset_selinuxuser(struct cil_selinuxuser *selinuxuser)
 {
+	selinuxuser->user = NULL;
 	if (selinuxuser->range_str == NULL) {
 		cil_reset_levelrange(selinuxuser->range);
+	} else {
+		selinuxuser->range = NULL;
 	}
 }
 
@@ -214,6 +217,8 @@ static void cil_reset_rangetransition(struct cil_rangetransition *rangetrans)
 {
 	if (rangetrans->range_str == NULL) {
 		cil_reset_levelrange(rangetrans->range);
+	} else {
+		rangetrans->range = NULL;
 	}
 }
 
@@ -251,6 +256,7 @@ static void cil_reset_catset(struct cil_catset *catset)
 
 static inline void cil_reset_level(struct cil_level *level)
 {
+	level->sens = NULL;
 	cil_reset_cats(level->cats);
 }
 
@@ -258,10 +264,14 @@ static inline void cil_reset_levelrange(struct cil_levelrange *levelrange)
 {
 	if (levelrange->low_str == NULL) {
 		cil_reset_level(levelrange->low);
+	} else {
+		levelrange->low = NULL;
 	}
 
 	if (levelrange->high_str == NULL) {
 		cil_reset_level(levelrange->high);
+	} else {
+		levelrange->high = NULL;
 	}
 }
 
@@ -269,6 +279,8 @@ static inline void cil_reset_userlevel(struct cil_userlevel *userlevel)
 {
 	if (userlevel->level_str == NULL) {
 		cil_reset_level(userlevel->level);
+	} else {
+		userlevel->level = NULL;
 	}
 }
 
@@ -276,13 +288,20 @@ static inline void cil_reset_userrange(struct cil_userrange *userrange)
 {
 	if (userrange->range_str == NULL) {
 		cil_reset_levelrange(userrange->range);
+	} else {
+		userrange->range = NULL;
 	}
 }
 
 static inline void cil_reset_context(struct cil_context *context)
 {
+	if (!context) {
+		return;
+	}
 	if (context->range_str == NULL) {
 		cil_reset_levelrange(context->range);
+	} else {
+		context->range = NULL;
 	}
 }
 
@@ -290,26 +309,35 @@ static void cil_reset_sidcontext(struct cil_sidcontext *sidcontext)
 {
 	if (sidcontext->context_str == NULL) {
 		cil_reset_context(sidcontext->context);
+	} else {
+		sidcontext->context = NULL;
 	}
 }
 
 static void cil_reset_filecon(struct cil_filecon *filecon)
 {
-	if (filecon->context_str == NULL && filecon->context != NULL) {
+	if (filecon->context_str == NULL) {
 		cil_reset_context(filecon->context);
+	} else {
+		filecon->context = NULL;
 	}
 }
 
 static void cil_reset_ibpkeycon(struct cil_ibpkeycon *ibpkeycon)
 {
-	if (!ibpkeycon->context_str)
+	if (ibpkeycon->context_str == NULL) {
 		cil_reset_context(ibpkeycon->context);
+	} else {
+		ibpkeycon->context = NULL;
+	}
 }
 
 static void cil_reset_portcon(struct cil_portcon *portcon)
 {
 	if (portcon->context_str == NULL) {
 		cil_reset_context(portcon->context);
+	} else {
+		portcon->context = NULL;
 	}
 }
 
@@ -317,6 +345,8 @@ static void cil_reset_nodecon(struct cil_nodecon *nodecon)
 {
 	if (nodecon->context_str == NULL) {
 		cil_reset_context(nodecon->context);
+	} else {
+		nodecon->context = NULL;
 	}
 }
 
@@ -324,6 +354,8 @@ static void cil_reset_genfscon(struct cil_genfscon *genfscon)
 {
 	if (genfscon->context_str == NULL) {
 		cil_reset_context(genfscon->context);
+	} else {
+		genfscon->context = NULL;
 	}
 }
 
@@ -331,17 +363,23 @@ static void cil_reset_netifcon(struct cil_netifcon *netifcon)
 {
 	if (netifcon->if_context_str == NULL) {
 		cil_reset_context(netifcon->if_context);
+	} else {
+		netifcon->if_context = NULL;
 	}
 
 	if (netifcon->packet_context_str == NULL) {
 		cil_reset_context(netifcon->packet_context);
+	} else {
+		netifcon->packet_context = NULL;
 	}
 }
 
 static void cil_reset_ibendportcon(struct cil_ibendportcon *ibendportcon)
 {
-	if (!ibendportcon->context_str) {
+	if (ibendportcon->context_str == NULL) {
 		cil_reset_context(ibendportcon->context);
+	} else {
+		ibendportcon->context = NULL;
 	}
 }
 
@@ -349,6 +387,8 @@ static void cil_reset_pirqcon(struct cil_pirqcon *pirqcon)
 {
 	if (pirqcon->context_str == NULL) {
 		cil_reset_context(pirqcon->context);
+	} else {
+		pirqcon->context = NULL;
 	}
 }
 
@@ -356,6 +396,8 @@ static void cil_reset_iomemcon(struct cil_iomemcon *iomemcon)
 {
 	if (iomemcon->context_str == NULL) {
 		cil_reset_context(iomemcon->context);
+	} else {
+		iomemcon->context = NULL;
 	}
 }
 
@@ -363,6 +405,8 @@ static void cil_reset_ioportcon(struct cil_ioportcon *ioportcon)
 {
 	if (ioportcon->context_str == NULL) {
 		cil_reset_context(ioportcon->context);
+	} else {
+		ioportcon->context = NULL;
 	}
 }
 
@@ -370,6 +414,8 @@ static void cil_reset_pcidevicecon(struct cil_pcidevicecon *pcidevicecon)
 {
 	if (pcidevicecon->context_str == NULL) {
 		cil_reset_context(pcidevicecon->context);
+	} else {
+		pcidevicecon->context = NULL;
 	}
 }
 
@@ -377,6 +423,8 @@ static void cil_reset_devicetreecon(struct cil_devicetreecon *devicetreecon)
 {
 	if (devicetreecon->context_str == NULL) {
 		cil_reset_context(devicetreecon->context);
+	} else {
+		devicetreecon->context = NULL;
 	}
 }
 
@@ -384,6 +432,8 @@ static void cil_reset_fsuse(struct cil_fsuse *fsuse)
 {
 	if (fsuse->context_str == NULL) {
 		cil_reset_context(fsuse->context);
+	} else {
+		fsuse->context = NULL;
 	}
 }
 
-- 
2.26.3

