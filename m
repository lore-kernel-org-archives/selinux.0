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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C4FC47082
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 15:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA039610A2
	for <selinux@archiver.kernel.org>; Tue,  8 Jun 2021 15:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbhFHQBf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Jun 2021 12:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbhFHQBe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Jun 2021 12:01:34 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C14C06178B
        for <selinux@vger.kernel.org>; Tue,  8 Jun 2021 08:59:29 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id he7so14013271ejc.13
        for <selinux@vger.kernel.org>; Tue, 08 Jun 2021 08:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZNL7eoQ/PjxieWjq9/S1rDUWVNOOXlM1562neStOc/k=;
        b=rL0f416Ku1zsM8BxZigeotBCbGwz4lAnSBGv6rWOhiE7HbrJgoy73Gmc4pnAFYSAck
         xyDcRGF0uOFiK7nOWnut0GYzPzabOKfEQLXCD7Urb11VWFAfAqIimWNQUdaEqbFakkWw
         K5k+cLa6zoXJVk/PfFo11EkkxLyzUgnvK679a2YapkpaHkIESW4FJ7XymlMvDvkHyaZs
         69KnEJu422MOyaEZ2rQRLrO9rsFeugNHFbPRkTt+MXdzVYLoQVbC4Te5ZFKrA54cryoM
         doyOOAl6ahDuIJktY7XNIH+ond9vG1jxrDgm8/fWDy5YICdL3WdzDe0H6JvC1eJQe2Ce
         fL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZNL7eoQ/PjxieWjq9/S1rDUWVNOOXlM1562neStOc/k=;
        b=XHMsYP6ocY7LNmBdfSpyGXZORRXFggEvt5hzsMasnfcgONEEbOp4GkqJH/oJCrX3QJ
         g3FDuq/QGLiUJ5cADAdr8/sH6FnEg1/w5dhu/Xj9qPZ866AAk6NN3F0gRmAJrqex9F6n
         OLprzKrVUpDKvRVzGL/gtE62wS+LnHSyTTZW1wKCW5ovrCS1KaxeFzcl4gpiGm8fil/p
         zpcBVnNq3L+H68yzRg6vnXzlJ6l8aGz3oCQgwxbg2l5XQvzrHQXtHbuk2Z04s4+G6Dh2
         JpwtB03Q0B/LwV120dvgOqRgAcrDcGFKce7BRzRl8JQvTEufgooR/qFvZVrA/gnjRW0Z
         /LZg==
X-Gm-Message-State: AOAM530LEipwxcvvUZdLpb3U2ICpTPHLbWqRAIfncASMuIV00gaBT+2/
        fHYDIZOFTvhgOo3/iCCDMqEFSn2AmHs=
X-Google-Smtp-Source: ABdhPJwl/77NeZMmnPkY1gzZEoVhyVbB5/c0YqyVVqdYHcLFw6JJ4Udz/CdWNdYgfEZxSZleK2uXJQ==
X-Received: by 2002:a17:906:8a55:: with SMTP id gx21mr24513108ejc.179.1623167967735;
        Tue, 08 Jun 2021 08:59:27 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-112-183-231.95.112.pool.telefonica.de. [95.112.183.231])
        by smtp.gmail.com with ESMTPSA id n13sm51134ejk.97.2021.06.08.08.59.27
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 08:59:27 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 15/23] libsepol/cil: silence cast warning
Date:   Tue,  8 Jun 2021 17:59:04 +0200
Message-Id: <20210608155912.32047-16-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608155912.32047-1-cgzones@googlemail.com>
References: <20210608155912.32047-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

../cil/src/cil_write_ast.c:86:32: error: cast to smaller integer type 'enum cil_flavor' from 'void *' [-Werror,-Wvoid-pointer-to-enum-cast]
                        enum cil_flavor op_flavor = (enum cil_flavor)curr->data;
                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
../cil/src/cil_write_ast.c:130:37: error: cast to smaller integer type 'enum cil_flavor' from 'void *' [-Werror,-Wvoid-pointer-to-enum-cast]
                        enum cil_flavor operand_flavor = (enum cil_flavor)curr->data;
                                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Silence this warning by casting the pointer to an integer the cast to
enum cil_flavor.

See 32f8ed3d6b0b ("libsepol/cil: introduce intermediate cast to silence -Wvoid-pointer-to-enum-cast")

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_write_ast.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/cil/src/cil_write_ast.c b/libsepol/cil/src/cil_write_ast.c
index 4871f704..186070c1 100644
--- a/libsepol/cil/src/cil_write_ast.c
+++ b/libsepol/cil/src/cil_write_ast.c
@@ -83,7 +83,7 @@ static void write_expr(FILE *out, struct cil_list *expr)
 			break;
 		case CIL_OP: {
 			const char *op_str;
-			enum cil_flavor op_flavor = (enum cil_flavor)curr->data;
+			enum cil_flavor op_flavor = (enum cil_flavor)(uintptr_t)curr->data;
 			switch (op_flavor) {
 			case CIL_AND:
 				op_str = CIL_KEY_AND;
@@ -127,7 +127,7 @@ static void write_expr(FILE *out, struct cil_list *expr)
 		}
 		case CIL_CONS_OPERAND: {
 			const char *operand_str;
-			enum cil_flavor operand_flavor = (enum cil_flavor)curr->data;
+			enum cil_flavor operand_flavor = (enum cil_flavor)(uintptr_t)curr->data;
 			switch (operand_flavor) {
 			case CIL_CONS_U1:
 				operand_str = CIL_KEY_CONS_U1;
-- 
2.32.0

