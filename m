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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB13C433F5
	for <selinux@archiver.kernel.org>; Tue,  7 Sep 2021 19:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BACF661132
	for <selinux@archiver.kernel.org>; Tue,  7 Sep 2021 19:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346125AbhIGT76 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Sep 2021 15:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346120AbhIGT75 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Sep 2021 15:59:57 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DB7C061575
        for <selinux@vger.kernel.org>; Tue,  7 Sep 2021 12:58:51 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id u4so454293qta.2
        for <selinux@vger.kernel.org>; Tue, 07 Sep 2021 12:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f/8TFe6tAHzDHnDetSM2X0UNNumWSsyLm0/Xi77Z/zs=;
        b=lsR4kpWSWbSyzfvCOK+dt32Bxm7f5qNF6N16QpUbrrEdN/XgSxc5zVqlveWhnhgRbz
         zqbKt0yTc+apM0h8rfAk16wMUn8dFldxbtSbFCEaqQZUiNNtvOhTsmJvCs4NfRcPkk1a
         HnK24CZCIaRpUnidlfQmAQje93LvB5JLMgw9RQNMpPeLiqM3hqQ0MpxwOl6uFpdh7idc
         H7/bRbjVdeeYYzWQjaU0nwAwkB/I65WyLxuHCR5UkueanxTXuG1V+PbJa3zuz6DNMyrM
         al1ifJtE/+aYJrD8kcm6gxyycWlYllZTU3WMxjAtFKStwSFCNDrKFwne08+W3pMDqvyd
         Vs9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f/8TFe6tAHzDHnDetSM2X0UNNumWSsyLm0/Xi77Z/zs=;
        b=bpTS1nxJisoq8VsGNbETrKPb7uaNiD2uG52CxnryALKsqlSvmMBn2UHGd3Im6pHUXo
         jScGFqlV7inLS7/ATW9m0sU6In5AN4YONVd3WYZw6m5p30D5cdMUHJM3xRVrZJwO1s+R
         RoUscVmMZZZiT/QxIXEtudEuIWsX5EvgC0OWTTZKKtNCiXkyBIZU/fVCOYVvNehLWHfx
         qg24oum8LeNGeyhSZ1TGbnVYs/wflIh9zgYgctJFtWYTfvc+k2i6GuWHoTX2l8eAK5Nw
         LgjrnZWrpT2K98w0vOfv9gnNArBTLRLngJsAQyQj7U4WKZFREMCn9EoLfVzAbcuxJWwl
         IcjA==
X-Gm-Message-State: AOAM530GBxsficaKD/P1DKcf5WA1IIGXs0KQ6U9++Yi4gEDqkMOmM3ml
        gflBvU9hg9cg8f6ih8ZPVTOA/Ynyueg=
X-Google-Smtp-Source: ABdhPJxRTmj0HxKluaFFr2oga4WFL0VSrMEALLcQ5Ja2qm32lGG9gQ9ksq4XhdL6C/aAri++FODxCw==
X-Received: by 2002:ac8:7194:: with SMTP id w20mr117854qto.217.1631044730227;
        Tue, 07 Sep 2021 12:58:50 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id s187sm38181qkf.34.2021.09.07.12.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 12:58:49 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/2] libsepol/cil: Add function to get number of items in a stack
Date:   Tue,  7 Sep 2021 15:58:44 -0400
Message-Id: <20210907195845.809083-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add the function, cil_stack_number_of_items(), to return the number
of items in the stack.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_stack.c | 5 +++++
 libsepol/cil/src/cil_stack.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/libsepol/cil/src/cil_stack.c b/libsepol/cil/src/cil_stack.c
index bbfb961a..70a77bc1 100644
--- a/libsepol/cil/src/cil_stack.c
+++ b/libsepol/cil/src/cil_stack.c
@@ -67,6 +67,11 @@ int cil_stack_is_empty(struct cil_stack *stack)
 	return (stack->pos == -1);
 }
 
+int cil_stack_number_of_items(struct cil_stack *stack)
+{
+	return stack->pos + 1;
+}
+
 void cil_stack_push(struct cil_stack *stack, enum cil_flavor flavor, void *data)
 {
 	stack->pos++;
diff --git a/libsepol/cil/src/cil_stack.h b/libsepol/cil/src/cil_stack.h
index b78535ac..0e3eff66 100644
--- a/libsepol/cil/src/cil_stack.h
+++ b/libsepol/cil/src/cil_stack.h
@@ -52,6 +52,7 @@ void cil_stack_destroy(struct cil_stack **stack);
 
 void cil_stack_empty(struct cil_stack *stack);
 int cil_stack_is_empty(struct cil_stack *stack);
+int cil_stack_number_of_items(struct cil_stack *stack);
 
 void cil_stack_push(struct cil_stack *stack, enum cil_flavor flavor, void *data);
 struct cil_stack_item *cil_stack_pop(struct cil_stack *stack);
-- 
2.31.1

