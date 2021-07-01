Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A440EC11F64
	for <selinux@archiver.kernel.org>; Thu,  1 Jul 2021 17:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B4AE61400
	for <selinux@archiver.kernel.org>; Thu,  1 Jul 2021 17:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhGARJT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Jul 2021 13:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbhGARJT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Jul 2021 13:09:19 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A117EC061762
        for <selinux@vger.kernel.org>; Thu,  1 Jul 2021 10:06:48 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j1so9120654wrn.9
        for <selinux@vger.kernel.org>; Thu, 01 Jul 2021 10:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4TdmV/L33lPNiejL11/yHgNnMQK1NSfFR3TOr9zZTps=;
        b=b2tlKwu9CGSQfY8H5fAM9fUEuX6GxqIXC59Zx5oiHwjjR3+lK75lDUxzeF+KkrNvmc
         yrVhBiwszOyBZpCcrRlbB04SeFAw9c9JWHPdszU/DBjGeFEAJvGiVh9MyESy9I9Oov5J
         QkExEAIHWByvGVBpesyWQ9JvQeoPSNK7Hup1roTfEt1pdFSlTKPqZsNbfurhXAoNYM+g
         AiYq26uMMMKv/GJ/3A4XkrvLlKErx2CEmtTCDIzK1RtrpWtKLssh3I31eUiL41pKRreA
         kuyjCdq8E73ejSqvhwayvqDV2x9ngZJn5DI8Ph7StJHblLBRvJ761+w7wDP00iUKEKcy
         cmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4TdmV/L33lPNiejL11/yHgNnMQK1NSfFR3TOr9zZTps=;
        b=lRrCifFICt98VuMeUSeJGL/hFvI2xE58fsbG18yhla4cLPEh1HmjYBqDn72xVoW2Y8
         kwh9wTBeJxbCODZ0TqSK9S2V1AMEhisfWS7fQhXha7fiuOSRTQeXUP/a4JfyW4JgGKaa
         qSMnk4JIq/uBYKpMsgVyDVIBJjmwE6f6K24H6okX6mA7/NaMlzdi+16SB+nRvt13/LR2
         8mEZRW04H/585BWiS9U1ZbeBtlx8bTwKgxLXz3GhgSSm23TtclsL5Oj2plQg1fJ2cRU7
         qx1MP2qGILm7tn2DUHogupDlBoIF+IYPEsrR+fZGZ2MURDIl5RAMvWaOLbxrfNcG0wGn
         wXTw==
X-Gm-Message-State: AOAM531rc68zfbbuGt4jaOSB6vCBoJHKYmV5Kkg2+9m+6uuoMrstY4M9
        gJDXGXQ1kiB1lLasO8CoqqA3R7BSHTaHSA==
X-Google-Smtp-Source: ABdhPJz9o41pVzB7e1JNfLzx3PCVb8eCaz3uR4yp6lQ9sX92gxBHxvD6hZEoYaJ2F0YVCI88H3Y+yQ==
X-Received: by 2002:a05:6000:1b0c:: with SMTP id f12mr848519wrz.126.1625159206948;
        Thu, 01 Jul 2021 10:06:46 -0700 (PDT)
Received: from kali.home (lfbn-ren-1-1383-171.w86-229.abo.wanadoo.fr. [86.229.230.171])
        by smtp.gmail.com with ESMTPSA id u1sm2231691wmn.23.2021.07.01.10.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 10:06:46 -0700 (PDT)
From:   Fabrice Fontaine <fontaine.fabrice@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: [PATCH] libselinux/utils/getseuser.c: fix build with gcc 4.8
Date:   Thu,  1 Jul 2021 19:06:19 +0200
Message-Id: <20210701170619.96954-1-fontaine.fabrice@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Fix the following build failure with gcc 4.8 which is raised since
version 3.2 and
https://github.com/SELinuxProject/selinux/commit/156dd0de5cad31e7d437c64e11a8aef027f0a691

getseuser.c:53:2: error: 'for' loop initial declarations are only allowed in C99 mode
  for (int i = 0; i < n; i++)
  ^

Fixes:
 - http://autobuild.buildroot.org/results/37eb0952a763256fbf6ef3c668f6c95fbdf2dd35

Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
---
 libselinux/utils/getseuser.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/utils/getseuser.c b/libselinux/utils/getseuser.c
index ce1b7b27..34f2e887 100644
--- a/libselinux/utils/getseuser.c
+++ b/libselinux/utils/getseuser.c
@@ -9,7 +9,7 @@ int main(int argc, char **argv)
 {
 	char *seuser = NULL, *level = NULL;
 	char **contextlist;
-	int rc, n;
+	int rc, n, i;
 
 	if (argc != 3) {
 		fprintf(stderr, "usage:  %s linuxuser fromcon\n", argv[0]);
@@ -50,7 +50,7 @@ int main(int argc, char **argv)
 	if (n == 0)
 		printf("no valid context found\n");
 
-	for (int i = 0; i < n; i++)
+	for (i = 0; i < n; i++)
 		printf("Context %d\t%s\n", i, contextlist[i]);
 
 	freeconary(contextlist);
-- 
2.30.2

