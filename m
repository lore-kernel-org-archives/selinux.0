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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400A0C48BC2
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 19:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C3A061040
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 19:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhFUTVA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Jun 2021 15:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbhFUTVA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Jun 2021 15:21:00 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7633C06175F
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 12:18:44 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id r20so14331303qtp.3
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 12:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/IgRyB42VS88SbqUKS+oTD/XtOocKdBJMFO6W6uIP+g=;
        b=CcPJUFzCg+bCZJBcYSDQX6H1PEhbJvRRVCmEE7w7OzIJXnFXNU9eKbrNJSYOK0YCR4
         m9hLSQ4S73Te9Qe2iHlEWWq3hkFzRqtAXBoun7xoYBeM+W27G3HLVoJbbrgFokMXZs6I
         ASRfbulsoQZeFMBeul2aKppYfPRFFr7V96a7UpqL4/pGNuiqtAaao/GcxDrgYxE+INWH
         sNsrq/qJCgJ3YQGxTlIjCbfi2p0vLS8IiwFIWoRGfDiCCS0m5+ybwmwLDvg+Dvm58fx4
         qZWTUltcX80ZNig7ztKG82kV10v/3gmWNDMMcrgGKmRQQxiNMhGV1qh0uEmRSj3lep6u
         iI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/IgRyB42VS88SbqUKS+oTD/XtOocKdBJMFO6W6uIP+g=;
        b=hXtdnX0X83MGFd7iNsbCCEMlGaNPsQl6pAR7hFYU+Ub9xg7neCBi0AeZ8W8b2QrtEl
         vg98YNk7r5yOGKVnpzoN+U8dV8+y5Ck0jb486row276QveaBxnFykiJYSxPzGOJ/B5+S
         XlHitRA1RYu1Y0aN+5jRQiyO9zWUDPd0tU179nOjuFQ7QRtsPm1CbJ+ytpAFZhoZN+Gw
         tNQOuG5DVrK3T+Kq9k6OfbauDOq4hHstuL7lH+fXUPp1g/LiGnOBfAWlWATX/GqFjNJy
         ZSnCfGfMvyDJruifZT+c7OuTNPtLL8IWjiw/ZGuAbOVp1t6bFr8vJq86K1/nX+hD/4e+
         78rA==
X-Gm-Message-State: AOAM531OtT5vKUi/QTTIvDX4C9elNWLzw5efL2JNK2QhBcX1wqeypRvS
        DZ6G6XqrVBB2VbScftVtZcXI9kKsmxbpaw==
X-Google-Smtp-Source: ABdhPJyjY4y+ljnTYwQFmOC+mj+angP6d5bMKBH0nZvq2CcofCwTFySGORgyKALylvVGK9NCmWj9hQ==
X-Received: by 2002:a05:622a:486:: with SMTP id p6mr79049qtx.163.1624303124090;
        Mon, 21 Jun 2021 12:18:44 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id o5sm10449124qkl.25.2021.06.21.12.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 12:18:43 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/5 v2] libsepol/cil: Check for empty list when marking neverallow attributes
Date:   Mon, 21 Jun 2021 15:18:31 -0400
Message-Id: <20210621191833.282874-4-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210621191833.282874-1-jwcart2@gmail.com>
References: <20210621191833.282874-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When marking a type attribute as used in a neverallow (to help determine
whether or not it should be expanded), check if the attribute's expression
list is empty (no attributes are associated with it) before iterating
over the list.

Signed-off-by: James Carter <jwcart2@gmail.com>
Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_post.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index 05842b64..38544aef 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -1494,6 +1494,10 @@ static void __mark_neverallow_attrs(struct cil_list *expr_list)
 {
 	struct cil_list_item *curr;
 
+	if (!expr_list) {
+		return;
+	}
+
 	cil_list_for_each(curr, expr_list) {
 		if (curr->flavor == CIL_DATUM) {
 			if (FLAVOR(curr->data) == CIL_TYPEATTRIBUTE) {
-- 
2.26.3

