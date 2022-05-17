Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434A3C433FE
	for <selinux@archiver.kernel.org>; Tue, 17 May 2022 14:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241252AbiEQOH5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 May 2022 10:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243536AbiEQOH4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 May 2022 10:07:56 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300D74A3F5
        for <selinux@vger.kernel.org>; Tue, 17 May 2022 07:07:55 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id en5so8472592edb.1
        for <selinux@vger.kernel.org>; Tue, 17 May 2022 07:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/OzjVeh2XTsauGq9qGqNcoElbF1LYNjuLf2SGn3p55Y=;
        b=Cy+hPY8kyBXq/oMvkqByJMAWLbhx4ZVZ5DlGnmpzDwk/YVXr2xLEYLBeAhkddC7ZBT
         jqizb+1Ecr09EntFb7Mi17ZfsaW/hak6/NjqnBoZRF0RNS+JpqX+7Rd5qqGgx6VK8g90
         ZjzBWQPZBQkP078vHbj0Xl+GGEgA/TCxn4eR/45LT3sArKGywqWq5/MAQQMB4oOfmNaR
         gFDzZ28HdZ427FJVOZ/6PzeAZekcpMb/AV+72t/h7odmn63G4ccp//SAG+Irkk4zA4uM
         y1lNRjHbIDMzufpiboeCLhnRWJVhYu6TfTSfw3LDj2zhdvB9CjhRUKB90/+CozjRvenE
         cRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/OzjVeh2XTsauGq9qGqNcoElbF1LYNjuLf2SGn3p55Y=;
        b=iLNGIlkB9krQvYRZozkVMCpdrMmkJ0SVITOK/UFKYd54CI1mzIGUcZE/OmSgN+N2Ru
         hZjA/kARV3xrO7MeVqOKWdM/7Te2o6onOV/ogM5gsmVMhRi7v1aTtgTCi8MgGyEXML3j
         PLLRkF2yTepkp6KrXIvs5dy+y7v1LpSk5kzMF/WkC/5aHNNuOdTmv9a40+Y/O2palakm
         2dWdiO7XpAS2gRNJKXkeEjX90aQyV6Jnvjxe7Zu4tMzRnR5mhMdd7tIopAtDLXMGCdYM
         4VP4r7wHzX41UE6d4KYPUsAEOF4vzPdcWi7sMQNb7zfmRXNW1AU4cC6dHCMvZqE2vF1q
         wkjw==
X-Gm-Message-State: AOAM530HT2rz/jwuJsj2j7gAdmOoUBba64r06HRJUFO0yybdSNrPGDLA
        4a2NcA5uaV7J+rAa61kYLSo9Xozf0sE=
X-Google-Smtp-Source: ABdhPJzChhf0Q0xj7ayVm5DHiniw9dE8yhGU2So+ZTd8e0WUiZRXvXi9g32Tkk8JqvPUUWEcMQgyew==
X-Received: by 2002:aa7:d501:0:b0:42a:aa82:e4ef with SMTP id y1-20020aa7d501000000b0042aaa82e4efmr14140099edq.241.1652796473787;
        Tue, 17 May 2022 07:07:53 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-065-249.95.112.pool.telefonica.de. [95.112.65.249])
        by smtp.gmail.com with ESMTPSA id p19-20020a17090664d300b006f3ef214e1csm1089714ejn.130.2022.05.17.07.07.53
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 07:07:53 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 2/2] libselinux: restorecon: avoid printing NULL pointer
Date:   Tue, 17 May 2022 16:07:48 +0200
Message-Id: <20220517140748.24238-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220517140748.24238-1-cgzones@googlemail.com>
References: <20220517140748.24238-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The variable `curcon` is NULL in case the file has no current security
context.  Most C standard libraries handle it fine, avoid it nonetheless
for standard conformance.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
"(null)" might not be the best token to display, it was only taken to
not change current behavior
---
 libselinux/src/selinux_restorecon.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 1a185ced..1b21a605 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -771,7 +771,9 @@ static int restorecon_sb(const char *pathname, struct rest_flags *flags, bool fi
 			selinux_log(SELINUX_INFO,
 				    "%s %s from %s to %s\n",
 				    updated ? "Relabeled" : "Would relabel",
-				    pathname, curcon, newcon);
+				    pathname,
+				    curcon ? curcon : "(null)",
+				    newcon);
 
 		if (flags->syslog_changes && !flags->nochange) {
 			if (curcon)
-- 
2.36.1

