Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6232DC47082
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 16:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BA8660FEA
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 16:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbhFHQCV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Jun 2021 12:02:21 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:40682 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhFHQCV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Jun 2021 12:02:21 -0400
Received: by mail-ed1-f41.google.com with SMTP id t3so25124655edc.7
        for <selinux@vger.kernel.org>; Tue, 08 Jun 2021 09:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=joqlWyuVuRzoK9LnXmpJPpMXmgmXxXY6SsPtXPQlpbg=;
        b=Si92Sj6LbaHvuOPoOFIpxZqfBbOUzPAhKhDWh/qIPSiI7m8WnreJRVnuk2DRpUl3yJ
         k+xJkT3N0gTbVEA++2Hf03G/ZPfoJ00yWOZSu1RhrQuax0SPIXL8+HmT7kGaZBeYH5J2
         r0Sh0Y173wZLfB8IJzivEXN486i/ohuBQeYa8XheGoLLBkg3hhWotu+JjZ1/+vEj14rQ
         ugTDduKT9yAZpEQDcHdUZ+Sr9XbCgdiYf9N91h1l+bpNVc+5up8p6U9Jucy/0/s4BwL0
         ehYS5AIiDjY+uJMH5kjHzbs1NU+K3vBDoVJegp15jCJI6kOKfSjZ+W359dT2n4XuiJwn
         msdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=joqlWyuVuRzoK9LnXmpJPpMXmgmXxXY6SsPtXPQlpbg=;
        b=OLgKd2p56n+olIpeIzBOCFJHodBFxM8L8MmesaIs1AA+aL+1GPPojq9W53cz4RAleQ
         XeNN5cGYdSXmh32/JZD0O1VwdsYxV9Q/u0/EPULWFIdxtC8sBfTipUPGfbhDb7O1uafN
         xwg5bgvkJcelAhAgpveRBG6X3DXm6dwTrqKcnOH9LWcRmkUPcwO8HqM5u3056UQQq+y3
         WVJzv65Z2OCLkLzEHM9YO1sEFJ0Xj2nM0jgbbFPiI35aLZeos9WC6TmC3xywol6q1UJN
         7fxrUVp62dQBBi5qKoMXK9KRxzUlRMuGAQWbaXjvC4R8HeBCsIaZNMIFQy1PreLU3PcI
         9IeQ==
X-Gm-Message-State: AOAM530UdzOYHjCnozl2fR4qLcKxhE/Uu0EM3IZu4gNnXBB0U6e7zlbM
        AwjgjYHSGHNYxYdZLEaDhR33iSCOXD4=
X-Google-Smtp-Source: ABdhPJxijEAqxphepmvhl2En8ExfCQOK5REODWfcomzJcg+0Z8e8MqNeJDysNlLNGfNDmeSoCc1GiA==
X-Received: by 2002:aa7:db94:: with SMTP id u20mr25955460edt.381.1623167967202;
        Tue, 08 Jun 2021 08:59:27 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-183-231.95.112.pool.telefonica.de. [95.112.183.231])
        by smtp.gmail.com with ESMTPSA id n13sm51134ejk.97.2021.06.08.08.59.26
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 08:59:26 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 14/23] libsepol: remove dead stores
Date:   Tue,  8 Jun 2021 17:59:03 +0200
Message-Id: <20210608155912.32047-15-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608155912.32047-1-cgzones@googlemail.com>
References: <20210608155912.32047-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Found by Infer

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/src/services.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index c34bb966..f7c31d80 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -175,7 +175,7 @@ static int expr_buf_len;
 static void cat_expr_buf(char *e_buf, const char *string)
 {
 	int len, new_buf_len;
-	char *p, *new_buf = e_buf;
+	char *p, *new_buf;
 
 	while (1) {
 		p = e_buf + expr_buf_used;
@@ -406,7 +406,7 @@ static int constraint_expr_eval_reason(context_struct_t *scontext,
 #define TARGET  2
 #define XTARGET 3
 
-	int s_t_x_num = SOURCE;
+	int s_t_x_num;
 
 	/* Set 0 = fail, u = CEXPR_USER, r = CEXPR_ROLE, t = CEXPR_TYPE */
 	int u_r_t = 0;
-- 
2.32.0

