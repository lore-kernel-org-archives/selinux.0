Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5263AC433DB
	for <selinux@archiver.kernel.org>; Mon,  1 Feb 2021 15:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 024D464EA3
	for <selinux@archiver.kernel.org>; Mon,  1 Feb 2021 15:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhBAO54 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Feb 2021 09:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhBAO5n (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Feb 2021 09:57:43 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C75DC061756
        for <selinux@vger.kernel.org>; Mon,  1 Feb 2021 06:57:45 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id q2so4452800edi.4
        for <selinux@vger.kernel.org>; Mon, 01 Feb 2021 06:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rbC0/zQ3OMi6IA9KYMo7RHeRsxJACpefgW5b0Rk2S9E=;
        b=PgLXzq5xMMP1RId5gisV9Qe5MepM/BRPBwgcDFuuS/1ouvYgWmnfeurQKuazSezWsa
         7u8lV1PDgy1iB9H4QwKQuXVlc4XsWxgK0jYC5r6DpICjabJdc0h61zR/O1A3nX4ZYirK
         SX0xDWQfiQzqXIMrrVTbiJ/TGiV8MsVfQWVHooikFS5YsUJsygWQl870+GhPuf1aJyGx
         loZ89peBLwifpGhfdVdQhRD64/1V5oDMW85PKsyQ/QjXqOvnPRC1+CY8GgdvgvG86YAt
         dRdqab1FlH/Vp9q9BeC9eHvgE/usGy8w/GeCYLqeQ9Qe1up5aoZwn7sva+NGc/V4D+YA
         XaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rbC0/zQ3OMi6IA9KYMo7RHeRsxJACpefgW5b0Rk2S9E=;
        b=QghoNToCcDl4H6I51VdCaLkhJ2MJuGppmjnwyCxIYLHR1wj+oo2i0hIMtTkSCn7MAz
         M2dYZjDqEkRVOj2lnZun3TLCOxdd1Bcwr9mFat5PL1bKA1WjVs8YJG+nsJtnH5jL9qem
         IX/FsZybZdhiqJ1ot/qfgLCaUnn8pdlnFtaNlVOfJm/vYFHER5q2w8z+SC0qLV4tGHcY
         d/gIWVKyXKOSL4H4wUMo1SzhNYbIetHrY45kYvGalc0L+Hx+FpVRDY+/NmjYE0zY9jlr
         6YkyzpGvejL4A3pAaZt1UHqpWcSE8EwpRjBdQl1j/z2bV0nI/J2w2YaKA67mbX6JBAFS
         ghtg==
X-Gm-Message-State: AOAM532U5c5ogih2HYrUBiHbQ1CvUXKuENA9xzXzQfWZML3wb3/L+EAv
        MBhfh2VrIRmV0kUy41+TuwjR8iWnNTM=
X-Google-Smtp-Source: ABdhPJymmMIcvXheU1oYeWDeEAz8yWr0XhJzZJ89YQL8RGLNiMGG/ik2A1Ix8RHaZaGnbM6v4dbsKA==
X-Received: by 2002:aa7:d489:: with SMTP id b9mr19409351edr.374.1612191464203;
        Mon, 01 Feb 2021 06:57:44 -0800 (PST)
Received: from dlaptop.localdomain (dynamic-077-001-081-113.77.1.pool.telefonica.de. [77.1.81.113])
        by smtp.gmail.com with ESMTPSA id q2sm8668989edv.93.2021.02.01.06.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:57:43 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] setfiles: drop now unused static variable
Date:   Mon,  1 Feb 2021 15:56:58 +0100
Message-Id: <20210201145658.14919-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

be7f54cb1f88d96592af8f0df0e62dda002907a5 made the variable nerr useless.
Remove it.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/setfiles/setfiles.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index 92616571..f018d161 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -19,7 +19,6 @@ static int warn_no_match;
 static int null_terminated;
 static int request_digest;
 static struct restore_opts r_opts;
-static int nerr;
 
 #define STAT_BLOCK_SIZE 1
 
@@ -161,7 +160,6 @@ int main(int argc, char **argv)
 	warn_no_match = 0;
 	request_digest = 0;
 	policyfile = NULL;
-	nerr = 0;
 
 	r_opts.abort_on_error = 0;
 	r_opts.progname = strdup(argv[0]);
@@ -427,9 +425,6 @@ int main(int argc, char **argv)
 	r_opts.selabel_opt_digest = (request_digest ? (char *)1 : NULL);
 	r_opts.selabel_opt_path = altpath;
 
-	if (nerr)
-		exit(-1);
-
 	restore_init(&r_opts);
 
 	if (use_input_file) {
-- 
2.30.0

