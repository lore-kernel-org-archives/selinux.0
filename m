Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3D2C07E96
	for <selinux@archiver.kernel.org>; Thu,  8 Jul 2021 12:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67E766191D
	for <selinux@archiver.kernel.org>; Thu,  8 Jul 2021 12:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbhGHMYk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Jul 2021 08:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhGHMYk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Jul 2021 08:24:40 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB32C061574
        for <selinux@vger.kernel.org>; Thu,  8 Jul 2021 05:21:58 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id i125so5376270qke.12
        for <selinux@vger.kernel.org>; Thu, 08 Jul 2021 05:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lTZUYpjEkGQF0U2uj1RCWvbDO/H5bLYZcYT5Gcz+uyY=;
        b=HWQga8lmHKpgJ/va6+YJKy97PpmvQuGaUmghXYFQa7WTRlisL/IaK1wSfyCfMGoKEM
         4jMNSrG/OZE2ovNkI7buHrHnHCf7hHCvUxisqrmzMUYiT6JuzLqt4xs3I3TEfsj5Jb4f
         FPrGN5drX3XrXHS2fpcUfXmufFvsWSLYtndmG9genKnU3WcZ0+IpNlSeSgRBogn706eJ
         jApB2RcM+ZCM5V9NEKARbPcMWIvtM1fFYmMUWKGDUUKX0Fx/D3WKrTMUAam4Bv8qH5nn
         86skonBCC9CS+QuRQlgIBR2AeBO5nXH9vMv0Dt/ztzkLtJsWaJR2N/URzHPzyu/QwTpM
         3dIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lTZUYpjEkGQF0U2uj1RCWvbDO/H5bLYZcYT5Gcz+uyY=;
        b=nncGmzAhiyQaVNIYaHl+kRKjRSRCqMwr1q5UYKv65CIwJzzGNcoTTcOWL1lxyFZaCj
         9nMTjdarwEmbxxv9FwAOxrnNvBoNp8Mv/4RFuqizkt3nWLQK/CDIU6RRODfiZzNHUgRg
         lmW9xrNUorbxOymL1CS9EFGZLlmtLWhxOvU7+IoWr3LdHNhjCefx/zUECj3wMOc12oW9
         YP0XbJ0EbPPEn84knhLKR/FYL4q87QDSDJeDshuhghA8kbWE8YWhV/DdovgcAii60xY7
         guEvHRY8CE1dAjVOOPwTKswof1h0FAaC6W3HPgFiMWTVlmVGWv9T/zOdhXGBZz21YwEa
         0HbA==
X-Gm-Message-State: AOAM533yP5+IB6MAGGsT1QwOhfrfq7muS/Zbqxvirnzf8LmPYWUZlOIH
        pC5lyoP5CGau/LkMUZN1efK46RlW5vzHrw==
X-Google-Smtp-Source: ABdhPJx/tWRqH0pesL61O6Stt8Hlk079YIOymSArCP0Iz9AadS5ZJaqpvHaFqRbDsESSSbrbIJUFHg==
X-Received: by 2002:a37:a890:: with SMTP id r138mr7101092qke.479.1625746917569;
        Thu, 08 Jul 2021 05:21:57 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id v8sm862292qtx.44.2021.07.08.05.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 05:21:57 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Only expand anonymous category sets in an expression
Date:   Thu,  8 Jul 2021 08:21:52 -0400
Message-Id: <20210708122152.11837-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

commit 982ec302b67f3c7f8df667dadb67352b1e4a6d18 (libsepol/cil:
Account for anonymous category sets in an expression) attempted to
properly handle anonymous category sets when resolving category
expressions. Unfortunately, it did not check whether a category set
was actually an anonymous category set and expanded all category
sets in an expression. If a category set refers to itself in the
expression, then everything from the name of the category set to the
end of the expression is ignored.

So, for example, the rule "(categoryset cs (c0 cs c1 c2))", would be
equivalent to the rule "(categoryset cs (c0))" as everything from
"cs" to the end would be dropped. The secilc-fuzzer found that the
rule "(categoryset cat (not cat))" would cause a segfault since
"(not)" is not a valid expression and it is assumed to be valid
during later evaluation because syntax checking has already been
done.

Instead, check whether or not the category set is anonymous before
expanding it when resolving an expression.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_resolve_ast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 145d4e74..933caf9b 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -3261,7 +3261,7 @@ int cil_resolve_expr(enum cil_flavor expr_type, struct cil_list *str_expr, struc
 			if (rc != SEPOL_OK) {
 				goto exit;
 			}
-			if (sym_index == CIL_SYM_CATS && NODE(res_datum)->flavor == CIL_CATSET) {
+			if (sym_index == CIL_SYM_CATS && !res_datum->name && NODE(res_datum)->flavor == CIL_CATSET) {
 				struct cil_catset *catset = (struct cil_catset *)res_datum;
 				if (!catset->cats->datum_expr) {
 					rc = cil_resolve_expr(expr_type, catset->cats->str_expr, &catset->cats->datum_expr, parent, extra_args);
-- 
2.31.1

