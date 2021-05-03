Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C571C43603
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4F776121D
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhECRzD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 May 2021 13:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbhECRy5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 May 2021 13:54:57 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E2DC061348
        for <selinux@vger.kernel.org>; Mon,  3 May 2021 10:54:01 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id u13so4616194edd.3
        for <selinux@vger.kernel.org>; Mon, 03 May 2021 10:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jVYXLFnlnhsHhy8UnZrHesfEI+ARavA9rlkGZkAsv94=;
        b=YjyTceZaLHmMvibU8PMOeOuxJ3XG/CwLc5FxFF6Eo8UDYLPzN5dS2jTlu8B0G+2VPe
         YxRsvL2O6SFgYjwF4y0xyQVR4u2kBz2+iFP4cmiRAWZewEu9Gr3fa/m3rG7Bkxp342TN
         tbmPHA5plNfe/2AdPAKxCRURW0fsHMR1YhO4pU5vAwdFzgWZz28hNa13SuqzbuoWNHyi
         qITaY0lQCrs4cAYhTbFRCeHM/y9Xz1vKc/2JvzWWr3IPBBwyD+i4IkUbZgZY2YmIja/6
         W7wYlQ4qnDIr/cdwA0+AswD80ESkg3KL5lapyWgeOfwgR2EC+FL4vjZ1luoue7LB44X9
         G0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jVYXLFnlnhsHhy8UnZrHesfEI+ARavA9rlkGZkAsv94=;
        b=TkPMy22rxJU0c9KqPVJLcy4EZTN7l3bDWEce9X3ysXiULc9u9/Xnte1Dk6EgWKOaeD
         E821iKN5ykITmP+OfjXbAvaLPdr0gkAxp6Toj1oHKipQGd3Y39DPE2w2WfiZ7YEcbsR/
         NkeDSKZNxJuHpVDA0na5o3Vo/L7dSVG8+hf5YxJAK7lQORNdeOS1uoc4r7ztNAoaQV7A
         Wr+zaYkguYAXRsed1eIRX97Kvp3ylWJ94/rcFBgUrFS8UcMEUb+4B+Yy1i57esaY1V2M
         ngu7qecNZM7mGdUnGYWvZ7x21VBp6DHKQ/Gc0PLmqUMwopWbz5nYggYrod+9ncFwy9K0
         B1fA==
X-Gm-Message-State: AOAM533uPT4TJKZOKJX35Y92rKQwHsxkHHGV9D4Y2IgYA0IvjRB0ATvX
        27NdfGkECveeknfmWQyHLMyuV4ZaNggi+w==
X-Google-Smtp-Source: ABdhPJyN/AgIPSd1uXuss4pdvK4NCDnDCeewmsx0LCH3SOvY4yl+XpzjZCRmuce2ZwdR5jDDf047Rw==
X-Received: by 2002:a50:ee85:: with SMTP id f5mr21767656edr.8.1620064439644;
        Mon, 03 May 2021 10:53:59 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-172-037.77.0.pool.telefonica.de. [77.0.172.37])
        by smtp.gmail.com with ESMTPSA id b17sm1830165edr.80.2021.05.03.10.53.59
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 10:53:59 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 13/25] libselinux: label_media::init(): drop dead assignment
Date:   Mon,  3 May 2021 19:53:38 +0200
Message-Id: <20210503175350.55954-14-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503175350.55954-1-cgzones@googlemail.com>
References: <20210503175350.55954-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The variable `lineno` is only used in the preceding loop and it always
set prior that to 0.

Found by clang-analyzer.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/label_media.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
index d202e5d5..eb27deaf 100644
--- a/libselinux/src/label_media.c
+++ b/libselinux/src/label_media.c
@@ -119,7 +119,6 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 			if (process_line(path, line_buf, pass, ++lineno, rec))
 				goto finish;
 		}
-		lineno = 0;
 
 		if (pass == 0) {
 			if (data->nspec == 0) {
-- 
2.31.1

