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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4975FC43460
	for <selinux@archiver.kernel.org>; Tue, 13 Apr 2021 12:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E6B461242
	for <selinux@archiver.kernel.org>; Tue, 13 Apr 2021 12:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhDMMZl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Apr 2021 08:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbhDMMZk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Apr 2021 08:25:40 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED177C061756
        for <selinux@vger.kernel.org>; Tue, 13 Apr 2021 05:25:15 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id h10so19117349edt.13
        for <selinux@vger.kernel.org>; Tue, 13 Apr 2021 05:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=eL/YxJXhDKDrYHe/GwLdSLHSmFKoNyomwJRgSbON5p0=;
        b=CTkKcbwmsarhUzOWOmaYXb9LFhUk02+Bf/8hMXQuTh1DKn37O2Tx8bDDAX9S9s9Tnt
         s8/sSQHT0Snnly76Ywss+aC6PpEoYqjLanzRn9HCKnSqBlmGexle4FIDjE37Pt9W3Vou
         bnGyuKPtn87bV0wyuTf23QWCe7dp9XLxcmfpujA1gIz4cGiMbyf8tw5k+50ThlBqO9XD
         jIdzAa7z1WFmD5tSDUcFkTb24mCd7RkZMvaoSDhF9v3rQztA6LtLaC7WETuRGBd/MEQo
         w5mIN1BX3/n+yZlSzb06B8HTddjmklts6E1Nfg2BEaPs+npsjCP+xRH4VKiifslm/9Gp
         rTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eL/YxJXhDKDrYHe/GwLdSLHSmFKoNyomwJRgSbON5p0=;
        b=NpQJryaZxT8KsxbuGYLft4Y346TE11lHg6YCuSNjOH6p/2RNUG6ld5PqcPhrPFycLc
         o303mxXdjEOlw51p/3WaGW4GryXUXz/4/Bwku5zdrF/8ctKeuYsRtbNx9aneqICdvccE
         LxTKa/ElEz+3rvEoCBHCz4fpdryTAhO21muTs4vyqR9cSW8QlF4mDLEjcREQ4qI5i9zv
         IVNuY7X1oOemTHjO9SQjmnmhoqglxpLWq/fVhI0ALrP3QDDUpCE2WKstsilA+5LQgPlt
         vSbmbBuXg7OqQTZRbk7j0K+nneouUf27a41Zqtlh/HmoeV89S5BzyJ6gCM/yUGuM18lX
         gW6A==
X-Gm-Message-State: AOAM531x2+XZT5yV3chGblpBWK05h6qPwLxyJddLFSTjaPLBUYCCE97C
        JYm4OXF87NYqm3bFwOB/fiFBDdIe+xs=
X-Google-Smtp-Source: ABdhPJwUtavXcV7PvB16ty06ks8qVfZAoAuWF2rnJRjksgyGMjzU51enqWNFNF5nkGOD/GETvBS38g==
X-Received: by 2002:a05:6402:5205:: with SMTP id s5mr31598135edd.65.1618316714527;
        Tue, 13 Apr 2021 05:25:14 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-170-158.77.1.pool.telefonica.de. [77.1.170.158])
        by smtp.gmail.com with ESMTPSA id mp36sm7594438ejc.48.2021.04.13.05.25.14
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 05:25:14 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC SHADOW PATCH 1/7] struct commonio_db[selinux]: do not use deprecated type security_context_t
Date:   Tue, 13 Apr 2021 14:25:02 +0200
Message-Id: <20210413122508.24745-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210413122508.24745-1-cgzones@googlemail.com>
References: <20210413122508.24745-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The typedef security_context_t is deprecated, see
https://github.com/SELinuxProject/selinux/commit/9eb9c9327563014ad6a807814e7975424642d5b9
---
 lib/commonio.h | 6 +-----
 src/useradd.c  | 3 +++
 src/userdel.c  | 3 +++
 src/usermod.c  | 3 +++
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/lib/commonio.h b/lib/commonio.h
index 64e83073..2bad47a5 100644
--- a/lib/commonio.h
+++ b/lib/commonio.h
@@ -34,10 +34,6 @@
 #ifndef COMMONIO_H
 #define COMMONIO_H
 
-#ifdef WITH_SELINUX
-#include <selinux/selinux.h>
-#endif
-
 #include "defines.h" /* bool */
 
 /*
@@ -121,7 +117,7 @@ struct commonio_db {
 	/*@dependent@*/ /*@null@*/FILE *fp;
 
 #ifdef WITH_SELINUX
-	/*@null@*/security_context_t scontext;
+	/*@null@*/char *scontext;
 #endif
 	/*
 	 * Default permissions and owner for newly created data file.
diff --git a/src/useradd.c b/src/useradd.c
index a0369cd8..dcda3196 100644
--- a/src/useradd.c
+++ b/src/useradd.c
@@ -69,6 +69,9 @@
 #include "sgroupio.h"
 #endif
 #include "shadowio.h"
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>
+#endif				/* WITH_SELINUX */
 #ifdef ENABLE_SUBIDS
 #include "subordinateio.h"
 #endif				/* ENABLE_SUBIDS */
diff --git a/src/userdel.c b/src/userdel.c
index 4248ab80..92bca499 100644
--- a/src/userdel.c
+++ b/src/userdel.c
@@ -59,6 +59,9 @@
 #ifdef	SHADOWGRP
 #include "sgroupio.h"
 #endif				/* SHADOWGRP */
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>
+#endif				/* WITH_SELINUX */
 #ifdef WITH_TCB
 #include <tcb.h>
 #include "tcbfuncs.h"
diff --git a/src/usermod.c b/src/usermod.c
index 3ba011c2..15c70b5c 100644
--- a/src/usermod.c
+++ b/src/usermod.c
@@ -68,6 +68,9 @@
 #ifdef ENABLE_SUBIDS
 #include "subordinateio.h"
 #endif				/* ENABLE_SUBIDS */
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>
+#endif				/* WITH_SELINUX */
 #ifdef WITH_TCB
 #include "tcbfuncs.h"
 #endif
-- 
2.31.0

