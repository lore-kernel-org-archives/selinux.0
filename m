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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C076AC2B9F4
	for <selinux@archiver.kernel.org>; Mon, 14 Jun 2021 15:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D66061350
	for <selinux@archiver.kernel.org>; Mon, 14 Jun 2021 15:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbhFNPH5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Jun 2021 11:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbhFNPH4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Jun 2021 11:07:56 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D249BC061574
        for <selinux@vger.kernel.org>; Mon, 14 Jun 2021 08:05:53 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id d196so33521991qkg.12
        for <selinux@vger.kernel.org>; Mon, 14 Jun 2021 08:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rK3o1rHoBsNAXJOHw4ZVkW3DyM2rRzcWhvuypNdhVdc=;
        b=gBTCG2rj4Fc/N2B/r8SwIg7WO2vtaOgx/Q/mDrb2+S52SC+79QIv9pcpOGzKh7q0Fz
         93OOQ3TZps3EOxm/TFe/Z8Sx2g9hW7e2Mm+Pv4Nl/eyNo0HJdRCTLxZPPoQnd0PyrVa7
         BpUDXpIGGyA/PPGOyf+N48wtsVe1K8SBDN7HkORcB7TS5fyCWFLyydYmx3CUx9i2uJLr
         gjiIPvU3NpBq6YIxp+f3yx6U0dxn5YJ2leldeIwZLFy8Czb8mOcEf5BlBRWOOrpSG04L
         JOXos4LFXX4bPdPF3rnX7zQo9pgiNm/aJYcbI4YFShnL+QWzT0nKMhaHikXvfXYcCQ82
         wwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rK3o1rHoBsNAXJOHw4ZVkW3DyM2rRzcWhvuypNdhVdc=;
        b=ZySqF0g4H8j6ZG/RWrq8YMhHq8cyyQVtMjV1ehl0ZfJQEpZAcSdRk+xoJClEKt2fOj
         lcNrNyyKRSXpIpMjN9Xk5+h/lwo1vRrBqhc67m5x1/zXYgVYPJHlgQZ0PsZKPs4bNMs8
         yRUvmxVjT3nRIX6GIFKT1V4TeSxtPqvSyHFESg2dg7IlzkpZO3S/T+4+XQDY6p0tbjYH
         MBRRiwHmYNTYLj5hdzog0aTr+WTUPR/52eB223umymDClUptubPeUdp7pYC9fmgylQPQ
         gvpMatdrZGbvh7ZzYVx3f+uYZPRaWHDjcbJY5df7Q3xNz3TiO0iQ4cj/PXpSA+N3yjBO
         vpwA==
X-Gm-Message-State: AOAM531YqQ8GB4jzZ54wvDC+TqDfvt+T4SKZ0BDPsG7KDHaDy2MqPlwp
        SEZXd+1G3D51M1JYgn+bCX+FL0nt78fWNQ==
X-Google-Smtp-Source: ABdhPJyd1ZcXzOK0rwUgc/HHDqTc4g5U9pw81N351y5k/U+ezh56pC8YH9jm08fqRLKrfDlBgOIT5A==
X-Received: by 2002:a37:618f:: with SMTP id v137mr16865075qkb.282.1623683152956;
        Mon, 14 Jun 2021 08:05:52 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id 75sm8221014qkm.57.2021.06.14.08.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 08:05:52 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/5] libsepol/cil: Check for empty list when marking neverallow attributes
Date:   Mon, 14 Jun 2021 11:05:44 -0400
Message-Id: <20210614150546.512001-4-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210614150546.512001-1-jwcart2@gmail.com>
References: <20210614150546.512001-1-jwcart2@gmail.com>
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

