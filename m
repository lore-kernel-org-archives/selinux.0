Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF22AC433B4
	for <selinux@archiver.kernel.org>; Tue, 13 Apr 2021 12:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB6C861278
	for <selinux@archiver.kernel.org>; Tue, 13 Apr 2021 12:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbhDMMZk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Apr 2021 08:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbhDMMZi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Apr 2021 08:25:38 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37167C06175F
        for <selinux@vger.kernel.org>; Tue, 13 Apr 2021 05:25:16 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g17so18421239edm.6
        for <selinux@vger.kernel.org>; Tue, 13 Apr 2021 05:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9EoXsaZ+K3InNmMobop8iR07Kw1IFo2pzu1N+2sqvTQ=;
        b=XjbypLNK53a3JIctNV4HIPDP9DXn+CqNx47g5dXSok3+dIGMYUI/chlQ2QKMRiaufv
         hFQ1mwgzJPj4BX6OgpEjq4DtgJK8C1L/n1YsvBWvP6QxSg/P0c4XduvU2ZPYhm6yk0TV
         nd97WWFR6BSJj9bluc4Mu7NGN/h6odN0Yilldzynzwc5lSNr7cvwI5dnyQ1UrVf6ZFix
         Nq3jgK4sLSyXXOLEIJiQ1hQ7YMqyg9cgjuetSpeU0u6LlYX9WqsVwBCQo2PwRdV8YGOr
         Q+6TswAfCMykptTGbrzUxCZXBgGrPuJUrE/T4qY/NCuVhfh3CVtC1JZ1RCEw3owJOTDg
         mmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9EoXsaZ+K3InNmMobop8iR07Kw1IFo2pzu1N+2sqvTQ=;
        b=BKR6pZoCmRlG65JiQqd4CusYw9JoONCCEDECN2KN6BhPeILwT10wfZTbGdABviL9qw
         y1lcPBZMT2vNCxrTZdW05w0Kddqy0PkUHTZiepfMr9uZRBQQpSgpd5kp0582nSOgfGTy
         57XLXs+0nx3tMTgQntl8EhyX9Y1UtYGBeVvm1WKjktiHiiqVQZEIti5gCQ77aIa1wSLO
         n8RyUeyVqs3eCULMW2Zd19Cxa/Kbr0UUaCFyJwVyA4fie/kvjUSq3pG6eloZngNo0b9V
         81T82mx+CPIum2XI7npe2y8yrJZl+hwDYzxDuH3z85Mk41+DtMEnOLWJ0ofT6FsIx/Yp
         LJNA==
X-Gm-Message-State: AOAM532SaoIWS2ex81ZJWNAXEd5P/dPi676NmcQTcX/5/tJp/pHQViwY
        tFgbSpUgm5R8RCX1Y72XRca7doVi2p0=
X-Google-Smtp-Source: ABdhPJzeMcN69O/nDGItSICEal8nfx0jpt2FVTLjHLU0Cnsh+kwLMbQ4da9Pve7gCLusZ7bidy3VRw==
X-Received: by 2002:a05:6402:1c04:: with SMTP id ck4mr34303681edb.74.1618316714863;
        Tue, 13 Apr 2021 05:25:14 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-170-158.77.1.pool.telefonica.de. [77.1.170.158])
        by smtp.gmail.com with ESMTPSA id mp36sm7594438ejc.48.2021.04.13.05.25.14
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 05:25:14 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC SHADOW PATCH 2/7] vipw[selinux]: do not use deprecated typedef and skip context translation
Date:   Tue, 13 Apr 2021 14:25:03 +0200
Message-Id: <20210413122508.24745-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210413122508.24745-1-cgzones@googlemail.com>
References: <20210413122508.24745-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This retrieved context is just passed to libselinux functions and not
printed or otherwise made available to the outside, so a context
translation to human readable MCS/MLS labels is not needed.
(see man:setrans.conf(5))

The typedef security_context_t is deprecated, see
https://github.com/SELinuxProject/selinux/commit/9eb9c9327563014ad6a807814e7975424642d5b9
---
 src/vipw.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/vipw.c b/src/vipw.c
index 04f0b233..465698d1 100644
--- a/src/vipw.c
+++ b/src/vipw.c
@@ -243,13 +243,13 @@ vipwedit (const char *file, int (*file_lock) (void), int (*file_unlock) (void))
 	/* if SE Linux is enabled then set the context of all new files
 	   to be the context of the file we are editing */
 	if (is_selinux_enabled () != 0) {
-		security_context_t passwd_context=NULL;
+		char *passwd_context_raw = NULL;
 		int ret = 0;
-		if (getfilecon (file, &passwd_context) < 0) {
+		if (getfilecon_raw (file, &passwd_context_raw) < 0) {
 			vipwexit (_("Couldn't get file context"), errno, 1);
 		}
-		ret = setfscreatecon (passwd_context);
-		freecon (passwd_context);
+		ret = setfscreatecon_raw (passwd_context_raw);
+		freecon (passwd_context_raw);
 		if (0 != ret) {
 			vipwexit (_("setfscreatecon () failed"), errno, 1);
 		}
@@ -401,7 +401,7 @@ vipwedit (const char *file, int (*file_lock) (void), int (*file_unlock) (void))
 #ifdef WITH_SELINUX
 	/* unset the fscreatecon */
 	if (is_selinux_enabled () != 0) {
-		if (setfscreatecon (NULL) != 0) {
+		if (setfscreatecon_raw (NULL) != 0) {
 			vipwexit (_("setfscreatecon () failed"), errno, 1);
 		}
 	}
-- 
2.31.0

