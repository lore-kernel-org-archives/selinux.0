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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E55FC433E0
	for <selinux@archiver.kernel.org>; Thu, 11 Mar 2021 16:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5934064ECB
	for <selinux@archiver.kernel.org>; Thu, 11 Mar 2021 16:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhCKQ5T (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Mar 2021 11:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhCKQ4s (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Mar 2021 11:56:48 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED7FC061574
        for <selinux@vger.kernel.org>; Thu, 11 Mar 2021 08:56:48 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id g14so2859377qvn.3
        for <selinux@vger.kernel.org>; Thu, 11 Mar 2021 08:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nGCl7BHz1ub1UhKk0qfj/XDYpAze4fXBRDY2EVaQwrA=;
        b=lO7vr74kTGWuUCzJbzs6KRxu71/zb/a7T6hunnOa/2uRkFz74n7RDqvp7L/ATs+2wN
         cCS4HCKmqExPq+YgaFbEwDNT+vlk5LEGR70wCDdW2reGNwtHS9QUDH01Msh+9JglC2If
         UhW198LRlwhnyTAiMAJcVu8OXpYKfPk36TzeDGBFYC3yduOLPhxM+iMTbzeZJVbMImsE
         wjxE/DdGDWOkWMbLlTN/t2aWXSC/982XbRQsHBr+bd+i3sCAwaINLkTsSOn9YGp1flS4
         vcjWOh55yUteUApUtV1ajN+J6yGxw9L+/OfHxsaQ9mgJOb9mOqYwcoOei+jrw1JslhxV
         PSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nGCl7BHz1ub1UhKk0qfj/XDYpAze4fXBRDY2EVaQwrA=;
        b=cEHU2PHctvgxkDGd6Fa06knl31eqUk18hwfG4h0K1EWeXHSvCc5vnmG0Tz9JKFmunX
         W66f29Xu0FUwavBC0cL54YPjg7Bpz/vVeXb2tpVM5dusXxFNu1wObKkEmumktvH81Rn3
         h+h2SU4O60HgX4nmGeLfSD2JTIGv4mn6vvIotHeF1BI3mOCh767y19qDobVglS18MuI7
         a8ybHLNiHJVTv3jjlPgA0c7htGg3/hh6c5ggXstNNGOWoaWboIKSIOjRsoD505KD0VhE
         3kOfvTyvXsgABXR3c2aQgviWN/u4S0G8jJI70qGH+1hMgy0H4I9yOZUEjP2NyvCaKgRn
         tquw==
X-Gm-Message-State: AOAM531Lwa2HervKdDs7ctEtIChOTqJ4ucvAy9n53pvFrMor+oS9ZcOX
        rFlOw0AdhCW5m9lnz/nDzLEEVAQ1BaI=
X-Google-Smtp-Source: ABdhPJzre2r+OnhuRKns4BmU/9rdAx+9nGhM51uu4Xv//z48uUlmiPaEU/mqK9Ca1A+NvGtd2arN/A==
X-Received: by 2002:a0c:aee4:: with SMTP id n36mr8363026qvd.6.1615481807424;
        Thu, 11 Mar 2021 08:56:47 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id b17sm801519qtp.73.2021.03.11.08.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 08:56:47 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Remove unnecessary copying of declarations from link.c
Date:   Thu, 11 Mar 2021 11:56:44 -0500
Message-Id: <20210311165644.221142-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

At one point link_modules() might have needed this initial copying,
but now it serves no purpose, so remove it.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/link.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index 83bbc8a5..bdc1fcbf 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -2573,36 +2573,6 @@ int link_modules(sepol_handle_t * handle,
 		goto cleanup;
 	}
 
-	/* copy all types, declared and required */
-	for (i = 0; i < len; i++) {
-		state.cur = modules[i];
-		state.cur_mod_name = modules[i]->policy->name;
-		ret =
-		    hashtab_map(modules[i]->policy->p_types.table,
-				type_copy_callback, &state);
-		if (ret) {
-			retval = ret;
-			goto cleanup;
-		}
-	}
-
-	/* then copy everything else, including aliases, and fixup attributes */
-	for (i = 0; i < len; i++) {
-		state.cur = modules[i];
-		state.cur_mod_name = modules[i]->policy->name;
-		ret =
-		    copy_identifiers(&state, modules[i]->policy->symtab, NULL);
-		if (ret) {
-			retval = ret;
-			goto cleanup;
-		}
-	}
-
-	if (policydb_index_others(state.handle, state.base, 0)) {
-		ERR(state.handle, "Error while indexing others");
-		goto cleanup;
-	}
-
 	/* copy and remap the module's data over to base */
 	for (i = 0; i < len; i++) {
 		state.cur = modules[i];
-- 
2.26.2

