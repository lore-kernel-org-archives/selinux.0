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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB7DC43214
	for <selinux@archiver.kernel.org>; Fri, 27 Aug 2021 14:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3156060FDA
	for <selinux@archiver.kernel.org>; Fri, 27 Aug 2021 14:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbhH0OUx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Aug 2021 10:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbhH0OUw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Aug 2021 10:20:52 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB03C061757
        for <selinux@vger.kernel.org>; Fri, 27 Aug 2021 07:20:03 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id y144so7309960qkb.6
        for <selinux@vger.kernel.org>; Fri, 27 Aug 2021 07:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+VrztBh94lm6Mkk1yWNlZAeYfLYq5UG9Gk8WKSkeYU8=;
        b=UnRtQRohmWBwEbhtkZ9lXkGrfmaZ1zsLOl8rBux8gXoBdpafFh6RAJlsvRXJO+CaWp
         fnLX1bWeO3i8MUgBihbkBCUeaY4e1zpogHeTqQfaIcPK/DmtLCC7EiLt9tkU4fRtBWKb
         anX1lDdJWLV4mRWq/RjVSWXnx9InxWchyLTlXpIO8f7sa7sChS++tukd9mXOWyLcJosI
         mk9f6X9k2ycwdQWyftitb4cAdaNR/Bg88NQR8/eQmTPU0bChF+WACzsb698DYdjZo5rl
         TSshKmgmsqwkmNsJypCnOWFg9ItFIM9ZgZtXYCrfPF7yPyv1SrT3yUffE5HyH/oCLoVw
         jTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+VrztBh94lm6Mkk1yWNlZAeYfLYq5UG9Gk8WKSkeYU8=;
        b=QfFMbtlp8KomZsZt2WGfnRrw1iJMUoxSwaKmzL7lP8xp5R5UcyTxcGUocpboDTXNwN
         8XpbUvbFlIvuf6Yj1rdEsKvXLCTS/tjOJnxTnF+qmo7yjebXizucDT348VZHA4jPhJJW
         naiFfXkOoxaseIHr9+/zDNc3uyL/m3Y/P4ZwlsAJG16yeCEvcDnRv4IEabziSJ2S+CFB
         uML1iv512nzjwsn0OGtnpwg1Ox2M1oUm8Dz++KltaVv6+sZlYWjXZ9sBpnaLoL2K9oDF
         hVjwnuqtHbhhqNI3ulx6waEs67GDzXUo/Qxw8QWwVKwBq/IRn76KCbUVT+oZnrZycN6s
         hyMQ==
X-Gm-Message-State: AOAM531dwm3MwDYE/FXnMvm/qOcYyheYQ5n4GCTOKHw7ZqX2cRGn2rX6
        eLgGZqyy37Ewzm7YckQrJ7+2IcNlu8k=
X-Google-Smtp-Source: ABdhPJz6VWm8haX7FW03ko8T67UWBXG1wP2204ANlg5ufdW7W6hcvg0F85BGIsaghsa0MekQdVKLCA==
X-Received: by 2002:a05:620a:4cf:: with SMTP id 15mr9359727qks.316.1630074002657;
        Fri, 27 Aug 2021 07:20:02 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id s10sm4891010qko.134.2021.08.27.07.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 07:20:02 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/3] libsepol/cil: Properly check for parameter when inserting name
Date:   Fri, 27 Aug 2021 10:19:55 -0400
Message-Id: <20210827141955.370777-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210827141955.370777-1-jwcart2@gmail.com>
References: <20210827141955.370777-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

File names for typetransition rules are stored in their own datums.
This allows them to be passed as a parameter, but there needs to be
a check in __cil_insert_name() so that parameter names are not
mistaken for file name strings. This check did not verify that a
matching parameter name had the flavor of CIL_NAME.

Check that the parameter flavor is CIL_NAME and that the paramter
name matches the file name to be stored in the datum.

This bug was found by the secilc-fuzzer.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_resolve_ast.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 18007324..a4de1c75 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -87,7 +87,8 @@ static struct cil_name * __cil_insert_name(struct cil_db *db, hashtab_key_t key,
 	if (macro != NULL && macro->params != NULL) {
 		struct cil_list_item *item;
 		cil_list_for_each(item, macro->params) {
-			if (((struct cil_param*)item->data)->str == key) {
+			struct cil_param *param = item->data;
+			if (param->flavor == CIL_NAME && param->str == key) {
 				return NULL;
 			}
 		}
-- 
2.31.1

