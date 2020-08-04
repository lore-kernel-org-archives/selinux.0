Return-Path: <SRS0=dV66=BO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6709CC433DF
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60F9120781
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 01:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="KelovBdm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgHDBd0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Aug 2020 21:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHDBdZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Aug 2020 21:33:25 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88834C06174A
        for <selinux@vger.kernel.org>; Mon,  3 Aug 2020 18:33:25 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id b25so29805281qto.2
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2020 18:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=G6d9CvhAN3e9a1NKxuyg1jZcMbvmsJ/QYg4zQTz7tcQ=;
        b=KelovBdm3Yc90lMETVBgNCSirD8FlOYTThhRUVz2k5HTLoKAqcekfrzKQqnoqnifqA
         QINFHEexVDIdBJXSYiWOGcMGLMRrE+aFSuS+xO92/CJ8SlZBW4R3Hoa5MWTPdtc0bJMM
         6seJ443VgOwU4kTIwehMGnS1tNplD+Wm4aTkpy4r0Ocal04WyLpnLFKasB2o1p2l+o7C
         UBqC3kwDrAglFoBGKT5BOXv7xKmvh6pfMbv7Yda6L35oBMRhvLejD04VkWnVBxOSXHRC
         NL8WAN1uJ0JuehrCwH2dBRjr0RDrWAlY1ROJ+wRbkAUQe3g5ASZyzHqphDEGYSdiG750
         nHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=G6d9CvhAN3e9a1NKxuyg1jZcMbvmsJ/QYg4zQTz7tcQ=;
        b=iQR77h2uR01UJ6QT7MbCE/P2eZ4Y96Cqozh4ZH9pdnOTqrQ7m4wRpWHLHxb94XFH2s
         FJvcsK5HuvtKTLKFLA+sx2bHNPiP0LQELtKXkWMBAkTO49hhjmPhMPiT/tixk14GM95Q
         EGtWTbX9NLzmTSCXKUm/XzXlJpwTQqVlRiWOFeH9eu0AJ7j4S79qkW1oR2vyJE4MX8rY
         TBstasXBbRcds830B1rLkVx/lF/XhiQaVexyHMX6N2gl2tu5GYEichjvBPROm2sFf6OG
         xf5pYcassrG33NDI8UsO49klM36U1M8IOxefHk3+xorlNqbCVTza0aC2gPv0ykraq6V7
         aUhg==
X-Gm-Message-State: AOAM5312zA/Coxal4bXEWtOPRQ6YiYNqFQsoqrqwLi3pA/H7sj5bECht
        j8wBS8FFPNzTOwWOATizDnEMsHYdV0m5
X-Google-Smtp-Source: ABdhPJx8CooGiFpY52t16MRzEIf6aMvI1i9IvYt7rDnG6dd9txTuYF3bZqLBFaZEuMjIv49tzrN5PQ==
X-Received: by 2002:aed:37a6:: with SMTP id j35mr19259324qtb.322.1596504804308;
        Mon, 03 Aug 2020 18:33:24 -0700 (PDT)
Received: from localhost (pool-96-230-24-152.bstnma.fios.verizon.net. [96.230.24.152])
        by smtp.gmail.com with ESMTPSA id z68sm21562766qke.113.2020.08.03.18.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 18:33:23 -0700 (PDT)
Subject: [RFC,selinux-notebook PATCH 01/18] build: explicitly enable pandoc
 pipe_tables
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Mon, 03 Aug 2020 21:33:23 -0400
Message-ID: <159650480312.8961.3858639968171830656.stgit@sifl>
In-Reply-To: <159650470076.8961.12721446818345626943.stgit@sifl>
References: <159650470076.8961.12721446818345626943.stgit@sifl>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

As of July 2020 GitHub Markdown supports pipe tables.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 Makefile |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 9bd0ffa..f41bb16 100644
--- a/Makefile
+++ b/Makefile
@@ -16,7 +16,8 @@ PDF_OUT = SELinux_Notebook.pdf
 
 SED = sed
 PANDOC = pandoc
-PANDOC_OPTS=-V mainfont='DejaVu Serif' -V monofont='DejaVu Sans Mono'
+PANDOC_OPTS  = --from markdown+pipe_tables
+PANDOC_OPTS += -V mainfont='DejaVu Serif' -V monofont='DejaVu Sans Mono'
 
 # the individual section files, in order
 FILE_LIST = $(shell cat src/section_list.txt)

