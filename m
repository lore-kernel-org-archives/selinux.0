Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B9FC3527B
	for <selinux@archiver.kernel.org>; Tue,  5 Apr 2022 21:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345616AbiDEVlo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389255AbiDEPVM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Apr 2022 11:21:12 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF959CF49A
        for <selinux@vger.kernel.org>; Tue,  5 Apr 2022 06:35:55 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l26so10437357ejx.1
        for <selinux@vger.kernel.org>; Tue, 05 Apr 2022 06:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WQOPOuPkhVBGmToDYqZgLtsuD/b3lfwf9bcY7XQFo34=;
        b=MhCJ2e6D2TeyB0XFxrYDKRZqTrfgSmo7TKiqN5fzduNcYtS2850KNuDpDdUdJ/wQ2d
         feT7aaRtzVjuvqXeFIE+9yg1T4uBjr+hPnvjLwah3hvgunxP9sveH4OXWDAgbwtXIBLG
         RDN0S6dFWHjWb+pwqogkUW8pBph6/gMQZHDCKoK7ZByB4tqge9XTwlnwCFLyooix36HM
         k6LKsjDZJurPJIvEsSv2OSlTbOsTt2IcKU1DvqbgN80BcI/dVL2c5sqXi5C20ZRWEb/9
         WNRIgh2uOJCWh5MIhA3ew089rck4IbIpNIAiViLgopBRij7HN2xkBqQn3/HMLiVmN73Z
         HGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WQOPOuPkhVBGmToDYqZgLtsuD/b3lfwf9bcY7XQFo34=;
        b=6MK88ooC7RXDhckwK3qitn8jwHeuK0mouIazSaQvgVmwIgQYe8FrrPq969VCryiaTh
         D4xpVRzd5L4CBzOLHdJdT2c5WwLslnQPg42xH0F1cMIHPoP4MsV6y4plcNfec7k5UfMt
         JymcvdHJK8vBONCz4NoVE4wQRqS0TRWqhIWUG9vL8oNvh7AP+GxBcIn5TMKR0FTjjFBx
         GVSu737W1KRAkdc7w9UlzravR6mGPPN93HTyBm1KvVWuqK1sMtCZ3eXzRBevaN6/X+nv
         grzgrXTjBzu8ubGLTYXP/Bz+YDDMSIWgkZ+FTU3ybhDLxb+c+vz3YH6q3HTzJc0eruN0
         kQxw==
X-Gm-Message-State: AOAM532kxKai9FaISHX72UxVSDYPM6s87PqL0faTQCEmtLZK2gXbl+ZA
        /KT9NuLn7LExnYvf+a4AHt3JDZz1FgI=
X-Google-Smtp-Source: ABdhPJwegvDpk1GlOme0jnr0qEV+kDlztq2D+U3OuFftF7rXhvozUWoVF357TXQo58VBXvexECeHMw==
X-Received: by 2002:a17:906:1e94:b0:6cc:4382:f12e with SMTP id e20-20020a1709061e9400b006cc4382f12emr3574732ejj.482.1649165754250;
        Tue, 05 Apr 2022 06:35:54 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-134-094.77.8.pool.telefonica.de. [77.8.134.94])
        by smtp.gmail.com with ESMTPSA id l25-20020a1709060e1900b006e7fe06664esm1620627eji.106.2022.04.05.06.35.53
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 06:35:53 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 2/6] libsepol/cil: drop unused function cil_tree_error
Date:   Tue,  5 Apr 2022 15:35:44 +0200
Message-Id: <20220405133548.51598-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405133548.51598-1-cgzones@googlemail.com>
References: <20220331144752.31495-1-cgzones@googlemail.com>
 <20220405133548.51598-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It seems to be unused since its initial addition in 76ba6eaa
("Squashed 'libsepol/cil/' changes from 08520e9..28ad56e").

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_tree.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
index 525b60d4..6376c208 100644
--- a/libsepol/cil/src/cil_tree.c
+++ b/libsepol/cil/src/cil_tree.c
@@ -41,15 +41,6 @@
 #include "cil_parser.h"
 #include "cil_strpool.h"
 
-__attribute__((noreturn)) __attribute__((format (printf, 1, 2))) void cil_tree_error(const char* msg, ...)
-{
-	va_list ap;
-	va_start(ap, msg);
-	cil_vlog(CIL_ERR, msg, ap);
-	va_end(ap);
-	exit(1);
-}
-
 struct cil_tree_node *cil_tree_get_next_path(struct cil_tree_node *node, char **info_kind, uint32_t *hll_line, char **path)
 {
 	int rc;
-- 
2.35.1

