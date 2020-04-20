Return-Path: <SRS0=faga=6E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C5FC54FCB
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32A31206DD
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNLk87hW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgDTPq0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729426AbgDTPqZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Apr 2020 11:46:25 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A5EC061A0C
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:46:25 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a7so21515pju.2
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=STKcgyAYLyPwimzGvxdtUzzEbb8zdagndp28hkuz3NM=;
        b=CNLk87hWaP+5y2NXSYgGuu2EB8GvzL4yj56klO+DOsE28rYeaDwgJZ9Yv8f99Awy+Z
         aWeUrRCVoUegLUnnU3xgNk3TPUYMDcJtlUVrX6sHTePw2DJ2sIIrAzYqkTBmCFi6JKlr
         c2+7DIWkdwozck919K921BxUO48BWjkUZVeXIWXkqtPtjIDGMIaDQJSLIg45vo5Y/ZUW
         N0f0PnMZPo57tp9IbJPePLIJET8FO88Kf94SMzDtJUSON24695tUEeRlkxAIFcdOQdvC
         Qv7PsgXmIzb4YEFfpwYrVV7Z7Joq0I0CLzbNmU7CMKCdherzVSN5ydYibxI5CpAA10g5
         7n8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=STKcgyAYLyPwimzGvxdtUzzEbb8zdagndp28hkuz3NM=;
        b=WrsVCnDu5Og+voQitc7gf8BGexez4cALS5v6sz4e/wPWfXsbH0KUiHvNOrKXiEjOis
         dQMrBhFNNHHrPUXXZQdjaQrO2Ra8WT5dRXuz87QeMHIr/aB/F7SrQ9TLVq3HvjRUBPDI
         DBFQcRoti+TROiu8Iqs37H1FDTTeAKWtW9Oy57uiehofOLeWxYt0Vej11T1yGJGJBa7R
         lDk9CGHwUP8J9eZTLLT9/N1V6kv9QyacYBz0Ja7oER2nHAc3WbAnhxEt8AKakv0RyQfk
         1ZXdPgTbul7ew2w9Suzfa1ZSz0L9ivsCW6bEtuxN+eg+Te2jOPwGidmkCvIYocRnxXuF
         Q1JA==
X-Gm-Message-State: AGi0PubXx2t2JwQj8QkyEHVH4TOVjpWWHmLykdnP/SVCVu8T2krfMdy7
        zSRyU6VLU24CKg36d1CP4Kg=
X-Google-Smtp-Source: APiQypL+Aw36wr9YuWYUMEWZzdLmlmCq1eW4aw6K5APekphN/vEDbzsIBN107TKEW8eRI8FUl+VnVA==
X-Received: by 2002:a17:902:7c09:: with SMTP id x9mr8358964pll.54.1587397584970;
        Mon, 20 Apr 2020 08:46:24 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id i15sm1367507pfo.195.2020.04.20.08.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 08:46:24 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     nicolas.iooss@m4x.org
Cc:     bill.c.roberts@gmail.com, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v3 19/19] Makefile: swig build allow deprecated functions
Date:   Mon, 20 Apr 2020 10:45:37 -0500
Message-Id: <20200420154537.30879-20-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420154537.30879-1-william.c.roberts@intel.com>
References: <CAJfZ7==Ote6uQWMjDfNMA=qj79u2ByrnrH==++gDOhPeYD-W5g@mail.gmail.com>
 <20200420154537.30879-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

The SWIG C build should allow deprecated functions and not warn on them
because it is exposing the full interface including deprecated routines.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 9992221f5fc5..73303c3666c9 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -105,7 +105,8 @@ FTS_LDLIBS ?=
 override CFLAGS += -I../include -D_GNU_SOURCE $(DISABLE_FLAGS) $(PCRE_CFLAGS)
 
 SWIG_CFLAGS += -Wno-error -Wno-unused-variable -Wno-unused-but-set-variable -Wno-unused-parameter \
-		-Wno-shadow -Wno-uninitialized -Wno-missing-prototypes -Wno-missing-declarations
+		-Wno-shadow -Wno-uninitialized -Wno-missing-prototypes -Wno-missing-declarations \
+		-Wno-deprecated-declarations
 
 RANLIB ?= ranlib
 
-- 
2.17.1

