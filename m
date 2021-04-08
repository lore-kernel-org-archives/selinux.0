Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43E6C43462
	for <selinux@archiver.kernel.org>; Thu,  8 Apr 2021 19:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E315610F9
	for <selinux@archiver.kernel.org>; Thu,  8 Apr 2021 19:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbhDHTQm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Apr 2021 15:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbhDHTQm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Apr 2021 15:16:42 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AEBC061760
        for <selinux@vger.kernel.org>; Thu,  8 Apr 2021 12:16:29 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id y12so2310854qtx.11
        for <selinux@vger.kernel.org>; Thu, 08 Apr 2021 12:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zv1JoDzTu6AkTMma31wcs0OtpJUwcmFUO1jIKrCGjUs=;
        b=M8PKHAIE13LmqSSMkbX/8EY9hQ/SggB0eEfsDPS9669or8jYqV54lVc09015TMN65C
         JXnAyms4DbkNbq3sBNxAxkl3ovr5Z3aOJNHwagj+G470dhOKE7CLwM7kUx9P349NAJOv
         OgOH5byVd4Kjrsm/jzfKri5a71HL4QfcAve2ymYhjezVoMIfptbDaQEBWqvS3HmU5138
         h1aeiarEolngf39kIx/190r9ciWc4YjyQF1jAoqrm8B4vtDShmlk7tbgD6W71sa9pD/n
         bK6dWjRFLkpEm0lgJHMy8rBGiFJst2chE+KwInQp2NTuhnMYcLLnkM/V1DHXEy2l5zbQ
         lwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zv1JoDzTu6AkTMma31wcs0OtpJUwcmFUO1jIKrCGjUs=;
        b=Rijf4BFvd7uCVQIDFUGqnFrb5jz+17z4xOQfFDrxJ5kfRb/7OYB4IN8EgGVfgJx/wn
         6EI7e7HX+Uh5r8XytKZqOKUya4I3w1aKheOudsd7X9SAX7UHkQnOCR5b0zUMvVTyDWQo
         m8tu58Joa7u7t4FMHPN3BEgpp1B3JpVvCpLcMQN9Q8YpR/2EW5b/x/o6qIV4dJ1Iy5kC
         T5jZnXvynTEl1231dKvhVlMyljH2hw2dU2Ql8riGcFc+NCZM/nSUpuSLeWiDHe4RJSne
         q6Q0u6pYUdcnQTBfq8wNos3w984i65nDkQDGA2moFXAhFDzhqruTLHJPmEYyDg4FAHfT
         Eh/g==
X-Gm-Message-State: AOAM532C6pf2Tf40luUca2nFcJHAJl9Nkh9MDELw1ZfKmRZrfavAD1kY
        aNgIvR87aooOitmtRwMHUI6jvWgP8wlOJw==
X-Google-Smtp-Source: ABdhPJzGnU/9Z7lXkfWahvmZ0h8qFDuyR/5K5/IS0MNOh5MpO3zr1SQ1Z0AmKyNryGi4iXAvUf3+kQ==
X-Received: by 2002:a05:622a:1c5:: with SMTP id t5mr8692517qtw.49.1617909388847;
        Thu, 08 Apr 2021 12:16:28 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id v128sm147949qkc.127.2021.04.08.12.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 12:16:28 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 04/11] libsepol/cil: cil_reset_classperms_set() should not reset classpermission
Date:   Thu,  8 Apr 2021 15:16:07 -0400
Message-Id: <20210408191614.262173-5-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210408191614.262173-1-jwcart2@gmail.com>
References: <20210408191614.262173-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In struct cil_classperms_set, the set field is a pointer to a
struct cil_classpermission which is looked up in the symbol table.
Since the cil_classperms_set does not create the cil_classpermission,
it should not reset it.

Set the set field to NULL instead of resetting the classpermission
that it points to.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_reset_ast.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
index 89f91e56..1d9ca704 100644
--- a/libsepol/cil/src/cil_reset_ast.c
+++ b/libsepol/cil/src/cil_reset_ast.c
@@ -59,7 +59,11 @@ static void cil_reset_classpermission(struct cil_classpermission *cp)
 
 static void cil_reset_classperms_set(struct cil_classperms_set *cp_set)
 {
-	cil_reset_classpermission(cp_set->set);
+	if (cp_set == NULL) {
+		return;
+	}
+
+	cp_set->set = NULL;
 }
 
 static inline void cil_reset_classperms_list(struct cil_list *cp_list)
-- 
2.26.3

