Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4BBC4338F
	for <selinux@archiver.kernel.org>; Tue, 24 Aug 2021 02:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA23B61246
	for <selinux@archiver.kernel.org>; Tue, 24 Aug 2021 02:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbhHXCXk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 23 Aug 2021 22:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbhHXCXg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 23 Aug 2021 22:23:36 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD384C061575;
        Mon, 23 Aug 2021 19:22:52 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id j187so17004144pfg.4;
        Mon, 23 Aug 2021 19:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Buf9yDmqv76HtLamO3Pbrt8As98ijZEWdR2Z19Om0L8=;
        b=nmy2uJXJkuAuXMLrPpKLxa2/fZttM4IE5G0/V9m2ZsTA+VL46/Rg1VOR8KrLjUZCV5
         2Uo8tul4r9XfTLn/guv28Kk9divchUz/Dq68aKyrAj4m9UTYhMpInlqVgQRZlKJyYUX4
         s7axl6V3szcbLsmLKFKAZsDYSIYFH4a/ylaJeQSfn1BNsV7pY4wiKVwGjF7yQMInXfTE
         IfgEojx0oxs9nsYjHtsET+svSBZjPPK60wmNQGXH55WZJOC0KWvOEv2mcXcWVfzCc9Vt
         L+K7VUEjS6IccgrPHkE3tnP4Kmppm8ZhRjECQtovKdpQH/476HSfvCTjWPuDr3hP50Zz
         A33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Buf9yDmqv76HtLamO3Pbrt8As98ijZEWdR2Z19Om0L8=;
        b=fpxEogCMcnYnzab5e3EcI2nE/P55exL6f0VwBqoXxWYOHyBGKfgG7IyWJTM56sVCWX
         SwCTFlOPP2xMHXErUWVS2XxdjRDK9+ecQkZe4tZSg5PzcnjJwb/1zmPHpCWtuq6CEini
         gq9tj+nmQbrDExOeJQTiYf3yiFLxcgM/RisJurD7Cjhd6iwXFPWjtZRxbZ7yusEPKT/7
         NlfIrGl8UlUmgllM0juqc4LmGNq825G6fpTxsAzcv/0KOvhQxDkp8d1lD0DvTm732G+2
         wjeDCnpYSiU1gElD5ExtgT+c3sf7W9Oa3UU8zFH2OtxHliTwyyQieg7x2T5rct9Xn00t
         +xPw==
X-Gm-Message-State: AOAM533oK4M+JNCBncG+VH+kYd8aUK6+VoeBrefvYH/bFWcR3ozep01f
        Rc1MzDyBOUSgKAQAjZUJgSUxtSRByCOCNtv1
X-Google-Smtp-Source: ABdhPJw7LDsp84QQDwzBzXP4t08n45mv6kAZBeGKMn0jlEgxZdr9inngrm2B7/OuPD5BYdXPWQiO2g==
X-Received: by 2002:a63:65c5:: with SMTP id z188mr35229033pgb.35.1629771772418;
        Mon, 23 Aug 2021 19:22:52 -0700 (PDT)
Received: from raspberrypi ([210.183.35.240])
        by smtp.gmail.com with ESMTPSA id l10sm503260pjg.11.2021.08.23.19.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 19:22:52 -0700 (PDT)
Date:   Tue, 24 Aug 2021 03:22:47 +0100
From:   Austin Kim <austindh.kim@gmail.com>
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, austin.kim@lge.com
Subject: [PATCH] selinux: remove duplicated initialization of 'i' for clean-up
Message-ID: <20210824022247.GA22908@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Austin Kim <austin.kim@lge.com>

The local variable 'i' is used to be incremented inside while loop
within sidtab_convert_tree(). Before while loop, 'i' is set to 0 
inside if/else statement.

Since there is no 'goto' statement within sidtab_convert_tree(),
it had better initialize 'i' as 0 once before if/else statement.

Signed-off-by: Austin Kim <austin.kim@lge.com>
---
 security/selinux/ss/sidtab.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index 656d50b09f76..301620de63d3 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -374,7 +374,7 @@ static int sidtab_convert_tree(union sidtab_entry_inner *edst,
 			       struct sidtab_convert_params *convert)
 {
 	int rc;
-	u32 i;
+	u32 i = 0;
 
 	if (level != 0) {
 		if (!edst->ptr_inner) {
@@ -383,7 +383,6 @@ static int sidtab_convert_tree(union sidtab_entry_inner *edst,
 			if (!edst->ptr_inner)
 				return -ENOMEM;
 		}
-		i = 0;
 		while (i < SIDTAB_INNER_ENTRIES && *pos < count) {
 			rc = sidtab_convert_tree(&edst->ptr_inner->entries[i],
 						 &esrc->ptr_inner->entries[i],
@@ -400,7 +399,6 @@ static int sidtab_convert_tree(union sidtab_entry_inner *edst,
 			if (!edst->ptr_leaf)
 				return -ENOMEM;
 		}
-		i = 0;
 		while (i < SIDTAB_LEAF_ENTRIES && *pos < count) {
 			rc = convert->func(&esrc->ptr_leaf->entries[i].context,
 					   &edst->ptr_leaf->entries[i].context,
-- 
2.20.1

