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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90A4C433E9
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 13:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47FE764F2B
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 13:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhCRNu2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Mar 2021 09:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbhCRNuP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Mar 2021 09:50:15 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8ACBC06174A
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 06:50:15 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id l4so2029246qkl.0
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 06:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RF+/gLtA+rlNzOlPSYk4avv1zWotvJjkf4sKjCBSOFk=;
        b=iBwbagKwp8jKvQl5ciclYFU5OtdTOgZAXZj4zwEP32GXbw54+eyllI86wPBbOalpMn
         bOqrPapDTz1dfp8ZvQyrQ6RlDoPks8wOxlJErO7bOW+WADOPuxut+rugxGEHK0gWn/jH
         xpnm1at7UHzY42pZQfH4DiHRKuzNvdGuWIXSo2OJ6hWvhfFXpWTtTUbhtd4xcPUhzniJ
         kuDscRgCSgkivmmZQ8rKT0eD6Xm244L0a9wW0ZAm1t88/UwLqWqCJvXpRoY5DU+OcjXw
         keQee+MtaB7DfQdBz4/b3ny3e7I0z2UzNlbiVLdicqSFF8YYjG3aP4RjZPi6U9rqYPXu
         lyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RF+/gLtA+rlNzOlPSYk4avv1zWotvJjkf4sKjCBSOFk=;
        b=pbRu9z9zHIS4EwFQbJGGEWIF0dE7xIG6aZC6ItoAZOfG40v4riePkTztrK5WTrmTIC
         VNeofHKejFK+QpRHETnC+GIqajSVxSM1J/jT98vD8/nAfcdFsitzxsGKgmrDaQnrOdaQ
         0F+zyMAS7X6wFCxH+sdhJoHrD9KHe4HZlxNQ2C7UVm2+v8W3GqmnApijx6QYqzNclhLc
         3a/v5koBzZ2cJ94CJbqJVc9R7tqzqH3mRs13Qswz7MKNkkZHw8pnCKP9cWlK9H2upTEg
         Yk5Rjz86l1Ce9gA2F5ZfJQiSY/xtibbCF4bc/iSVIRqX7QtORn26h5SPGsDDkq3YpyYz
         Y7RA==
X-Gm-Message-State: AOAM532RwSKR0ZTWFcA4hs2YWVFlB2EFxWWRpusdq3/xL5EE6xOaXuM/
        A3UqOjWVIyHooLmDTZC6SMNmDAB7MYLWNw==
X-Google-Smtp-Source: ABdhPJwe869cZoDedTxVEgDe4uPuc3utYffdtuggm+oPoQhpM3ZOxJZtz+kk0WmucJIYOrXWQqPcEA==
X-Received: by 2002:a05:620a:12d1:: with SMTP id e17mr4364308qkl.203.1616075414792;
        Thu, 18 Mar 2021 06:50:14 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id b10sm1795737qkg.50.2021.03.18.06.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 06:50:14 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Set class field to NULL when resetting struct cil_classperms
Date:   Thu, 18 Mar 2021 09:50:12 -0400
Message-Id: <20210318135012.128244-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The class field of a struct cil_classperms points to the class looked
up in the symbol table, so that field should be set to NULL when
the cil_classperms is reset.

Set the class field to NULL when resetting the struct cil_classperms.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_reset_ast.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
index 0c74deeb..b76d5059 100644
--- a/libsepol/cil/src/cil_reset_ast.c
+++ b/libsepol/cil/src/cil_reset_ast.c
@@ -45,6 +45,7 @@ static inline void cil_reset_classperms(struct cil_classperms *cp)
 		return;
 	}
 
+	cp->class = NULL;
 	cil_list_destroy(&cp->perms, CIL_FALSE);
 }
 
-- 
2.26.2

