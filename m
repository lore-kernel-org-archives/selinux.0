Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA6CC433EF
	for <selinux@archiver.kernel.org>; Wed,  9 Mar 2022 23:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235891AbiCIXSg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Mar 2022 18:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiCIXSe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Mar 2022 18:18:34 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1452A220EF
        for <selinux@vger.kernel.org>; Wed,  9 Mar 2022 15:17:33 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id v15so3092347qkg.8
        for <selinux@vger.kernel.org>; Wed, 09 Mar 2022 15:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gmv9l9EBpF/fBg8hCOuu1dV7fjjkQ9Uk7gbFLBUMaH8=;
        b=UDRpCWj8aylNCZ8gW1wh5IGy93DTxN7Q75xAEHmSiI87lHPp0cSOJh2zMzmfwmRs5d
         xalQrJ79f/uTi0oyUVAVYaNNY6BkeUCJ9NEqXHY5n+sAeWrCACPsiSS7GnUHWCsMTFU4
         PqLexd1gegGjWCdV/oTuyikYuxbbYtW8McV1aF643EBJx8tPUR4qaJZQav9cehdahYum
         /LkNSpatFgxH+jntzd5W4cACVnU1HVxWWkR7qNcJDiSVooNnG5NZzQ3/I702ex64bfdr
         0RDaQX+nxTyDx3EG5U+EIEmp0Wop9i4I/d5+EAOElh0zzhLMUmUgOBtiP6/vXykoipjU
         u0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gmv9l9EBpF/fBg8hCOuu1dV7fjjkQ9Uk7gbFLBUMaH8=;
        b=Pe7hIsFbgvgdBKGVmnEsMqwQztNlVhqGe/iPhhLokG87hWjdU72rnpQrUu6pnV0ccK
         pLaPmbb6vxoz2LuHq7roCkl1HUc/YXLL3Wh+n410K54wpHz6XFGAimyEx3M8AD07GyeN
         awWAMhCRd3UzWJEsW9DOqQhwJ4SkH+zvO4wx/Y0r9ypD4fHJskwjT8BzUl/2a/8UhSu+
         2xrOKNR073Wd2ldAd0MJ96mb/gthYeucvlz5Y9h+/qqc6ieDNthTsruzH/7c7dIn8S7Y
         9zX1Wae522+Tv6x5+ZLygxLFAJG3h18HuXrd+L1mcTsHgUFeKDUg1cKeln4zvisozUyI
         tS/A==
X-Gm-Message-State: AOAM533kIbQ2P+TfxkfZthICtCrDc8+PEY1lrR7t5tYihssDBkxkJPlc
        l4sf8Jl44nkfJ4OFbQ2cTLaIlVjZLrM=
X-Google-Smtp-Source: ABdhPJxLGLeOLGGKRAPuV/4uCSxJNJQvJni/HYP6JOsfjTxics8UdzNdT93hx4fylcjzNBDCNXKA2Q==
X-Received: by 2002:a37:8644:0:b0:47e:b90:bf6c with SMTP id i65-20020a378644000000b0047e0b90bf6cmr1395538qkd.538.1646867852073;
        Wed, 09 Mar 2022 15:17:32 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id s15-20020a05622a178f00b002e1a51020d9sm1282484qtk.97.2022.03.09.15.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 15:17:31 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     j2468h@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Write a message when a log message is truncated
Date:   Wed,  9 Mar 2022 18:17:21 -0500
Message-Id: <20220309231721.742464-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The MAX_LOG_SIZE is 512. It is possible that a log message could
exceed the max size (such as for neverallowx rules). If so, then
write out "<LOG MESSAGE TRUNCATED>", so that it is obvious that
the log message has been truncated.

Reported-by: Jonathan Hettwer <j2468h@googlemail.com>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_log.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/libsepol/cil/src/cil_log.c b/libsepol/cil/src/cil_log.c
index a296929b..e78c0aeb 100644
--- a/libsepol/cil/src/cil_log.c
+++ b/libsepol/cil/src/cil_log.c
@@ -53,8 +53,13 @@ __attribute__ ((format (printf, 2, 0))) void cil_vlog(enum cil_log_level lvl, co
 {
 	if (cil_log_level >= lvl) {
 		char buff[MAX_LOG_SIZE];
-		vsnprintf(buff, MAX_LOG_SIZE, msg, args);
-		(*cil_log_handler)(cil_log_level, buff);
+		int n = vsnprintf(buff, MAX_LOG_SIZE, msg, args);
+		if (n > 0) {
+			(*cil_log_handler)(cil_log_level, buff);
+			if (n >= MAX_LOG_SIZE) {
+				(*cil_log_handler)(cil_log_level, " <LOG MESSAGE TRUNCATED>");
+			}
+		}
 	}
 }
 
-- 
2.34.1

