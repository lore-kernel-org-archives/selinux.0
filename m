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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631F6C433F5
	for <selinux@archiver.kernel.org>; Tue,  7 Sep 2021 19:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 442AD6113E
	for <selinux@archiver.kernel.org>; Tue,  7 Sep 2021 19:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346120AbhIGT76 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Sep 2021 15:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346121AbhIGT76 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Sep 2021 15:59:58 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E26C061575
        for <selinux@vger.kernel.org>; Tue,  7 Sep 2021 12:58:51 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id r21so406037qtw.11
        for <selinux@vger.kernel.org>; Tue, 07 Sep 2021 12:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kikxJsiZECX+/20A5hB+AJMdToQzH555QISBkOb8U48=;
        b=IZCBKD/RecLHGyXYEOOOdJZ4+VxaiOCeNCHMMHdzhsj7f0XoLA2B9WedRlCzkT2Cur
         QGBUJ1DTxOAu5zQN2vRXIiwd2XrOZuqH37OsrJg5llN8ePNTx5/TJJ2LpRMjul5zxTqv
         WE/xbEnOWAbp6coM2OxXUGpNwrAcUU4romOvuUedUuvKX9ijYc/gNe2ypzUYByKX84dW
         Z1jJ10M8Uc9j4mP7p1srl6aakwrMUw90QSyl07GBZ3o+qxeJxdF93x5/GhRV9ZTdH0rV
         O8Kw4I794JyVuhPKpeQ/IxdFmbQfYZpWs2uRPK85wfHhUS3k5oAERB9tr4FfEtFOR5u2
         3plw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kikxJsiZECX+/20A5hB+AJMdToQzH555QISBkOb8U48=;
        b=MmlE6lZ/emuYEQrduKPnvLNkXYHSkSGf8FmEwHUlId6R5cYpAcIEo6vaSgB/fvAP4I
         VzTO5S6cFXGHy/HgYDpqoC/x2lm7zOM0lsGkfL8rS5+5ZbBgERyN9VjEgyLIlSD/y+IG
         cYvYTWpDUrHaXdT8kKeOj88kLEid1LPaT+DEqlBYzEId9RJixLgcQUakVheY+++epBZJ
         rRIyZ9frA3o5LxffaevuK1Av3ajVK7Q7S4rxPlLU/VEkPJzSHj4j757/f/+T70yxX396
         AfZuAvPwvE6n2isatmqUxza/b3MjUlEraeOvk/eN94roFjujjNWCosInoaAj7igBKpJ8
         Gl/Q==
X-Gm-Message-State: AOAM533EKfYZOMsLDTdBc5VlC6O/P3sw7qzvrucqF+ZvcECGYWqUfufr
        DznGxkoiVkCBOPKVVqaDGAlQQw79A0w=
X-Google-Smtp-Source: ABdhPJyZszkyWGqv9Iq1l0bLToj7nxkb1wKhC1tCZiDdQUwwULRpLKRUQS3WOV3/H+fCtBoF76HbiA==
X-Received: by 2002:a05:622a:2c3:: with SMTP id a3mr129046qtx.41.1631044730758;
        Tue, 07 Sep 2021 12:58:50 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id s187sm38181qkf.34.2021.09.07.12.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 12:58:50 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 2/2] libsepol/cil: Limit the number of active line marks
Date:   Tue,  7 Sep 2021 15:58:45 -0400
Message-Id: <20210907195845.809083-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210907195845.809083-1-jwcart2@gmail.com>
References: <20210907195845.809083-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A line mark functions like an open parenthesis, so the number of
active line marks should be limited like the number of open
parenthesis.

This issue was found by the secilc-fuzzer.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_parser.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libsepol/cil/src/cil_parser.c b/libsepol/cil/src/cil_parser.c
index a967b9ed..5375d49a 100644
--- a/libsepol/cil/src/cil_parser.c
+++ b/libsepol/cil/src/cil_parser.c
@@ -131,6 +131,10 @@ static int add_hll_linemark(struct cil_tree_node **current, uint32_t *hll_offset
 		*current = (*current)->parent;
 	} else {
 		push_hll_info(stack, *hll_offset, *hll_expand);
+		if (cil_stack_number_of_items(stack) > CIL_PARSER_MAX_EXPR_DEPTH) {
+			cil_log(CIL_ERR, "Number of active line marks exceeds limit of %d\n", CIL_PARSER_MAX_EXPR_DEPTH);
+			goto exit;
+		}
 
 		create_node(&node, *current, tok.line, *hll_offset, NULL);
 		insert_node(node, *current);
-- 
2.31.1

