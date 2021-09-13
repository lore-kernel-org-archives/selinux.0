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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82222C433F5
	for <selinux@archiver.kernel.org>; Mon, 13 Sep 2021 18:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DD89610E7
	for <selinux@archiver.kernel.org>; Mon, 13 Sep 2021 18:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239722AbhIMS1Z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Sep 2021 14:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239404AbhIMS1X (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Sep 2021 14:27:23 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BF0C061574
        for <selinux@vger.kernel.org>; Mon, 13 Sep 2021 11:26:06 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id s15so8921316qta.10
        for <selinux@vger.kernel.org>; Mon, 13 Sep 2021 11:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZFcWB53ZE0d43V4TwrCVGO9JHrbrram9WWvnzBY2zI4=;
        b=c2SB2gmtsDO/6n4fuA1mrhnHInqHtro0xVq9kQhoAEdY8dxxIclE4LgFsJHwwXmVr7
         5Jr1Zx3lBASyh1pxDyWJXCZdN9PgPcrFTAb/Nx5qnPiHF1aeiEagggyV5xuE3LZNe1mk
         9N1OPTtV7NXDohLhR/3LccT5SuW5pyStVIsmiuFaIyCkvwXRKMbLaV5jxna5bg9oePl7
         +Uicb6BXwZDxRajk+Ep2n5nrjdkRk4Q9UR4yhUD6N/wOI6LoKgn60NaD6LVL3JYEbXBX
         QfXv7nKu6vs9JLWLg8g+li1fMvbtFDdlRSP3qCLclNh6/lBW1qu3roRTMcVwjldd8VWm
         XCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZFcWB53ZE0d43V4TwrCVGO9JHrbrram9WWvnzBY2zI4=;
        b=n7Ia0RLd5aRH1TWCaMzulqUKNgoex6LWiq6HVYpowNvUNACGmCI4wjrhrMfPxZEAjL
         djs+++5U1QNXCBOdtl3YhZpRE6lPVXFMNSfRZuPTdbw6JVtBSQmOpGpT5YxVeYGK+xan
         BbHArkSpyp65v/wK0CPbIFNIgdbYdwdNEE/FQjNiJKIAXHCW98qjWLc4wtcL944Ww69I
         3HZ6l8Hm2HXieyieBIclKkhnLx5Y1pRd/HSfd08suFlH0ofnbOru2UEXI1Dyaqzgs1Sb
         wkLlO5QOANjxSrgif54QVy4G9H/Vh1HvU3YOgOdnM9a3uDAyBAc4atulfkN2GCw2i/do
         FOJQ==
X-Gm-Message-State: AOAM530vbqDDbn9ZgrDFmiuEeqWDInLaWtyp+CBMwmBKF3fpgCeMgRZu
        /0Fi8auL05pnL7/M8pUrDKT6MJrJx8U=
X-Google-Smtp-Source: ABdhPJxy2PezFnV6afjOkn27LSVhlGLE8C7oHlr9VxNoI+UsQ98s9oO4/rB5EjfqP2Ck7kde/+9cEQ==
X-Received: by 2002:ac8:4c9c:: with SMTP id j28mr874307qtv.224.1631557565921;
        Mon, 13 Sep 2021 11:26:05 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id e5sm4702196qts.0.2021.09.13.11.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 11:26:05 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Do not use original type and typeattribute datums
Date:   Mon, 13 Sep 2021 14:26:00 -0400
Message-Id: <20210913182600.1016101-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When compiling CIL policy using secilc's "-m" option (which allows
duplicate declarations for types and type attributes), a segfault
will occur if the type or type attribute being copied has already
been declared. This is because a search of the symbol table is made
during the copy and the original datum will be used if one is found.
The original datum will be considered a duplicate when an attempt is
made to add it to the symbol table. The original datum, which is still
in use, will then be destroyed and a segfault will follow soon after
that.

Instead, always create a new datum. When it is added the new datum
will be destroyed if it is a duplicate and duplicate declarations
are allowed.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_copy_ast.c | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
index 7c5ae9e1..2fad972c 100644
--- a/libsepol/cil/src/cil_copy_ast.c
+++ b/libsepol/cil/src/cil_copy_ast.c
@@ -590,20 +590,12 @@ int cil_copy_roleallow(__attribute__((unused)) struct cil_db *db, void *data, vo
 	return SEPOL_OK;
 }
 
-int cil_copy_type(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
+int cil_copy_type(__attribute__((unused)) struct cil_db *db, __attribute__((unused)) void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
 {
-	struct cil_type *orig = data;
-	char *key = orig->datum.name;
-	struct cil_symtab_datum *datum = NULL;
+	struct cil_type *new;
 
-	cil_symtab_get_datum(symtab, key, &datum);
-	if (datum == NULL) {
-		struct cil_type *new;
-		cil_type_init(&new);
-		*copy = new;
-	} else {
-		*copy = datum;
-	}
+	cil_type_init(&new);
+	*copy = new;
 
 	return SEPOL_OK;
 }
@@ -622,20 +614,12 @@ int cil_copy_typepermissive(__attribute__((unused)) struct cil_db *db, void *dat
 	return SEPOL_OK;
 }
 
-int cil_copy_typeattribute(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
+int cil_copy_typeattribute(__attribute__((unused)) struct cil_db *db, __attribute__((unused)) void *data, void **copy, __attribute__((unused)) symtab_t *symtab)
 {
-	struct cil_typeattribute *orig = data;
-	char *key = orig->datum.name;
-	struct cil_symtab_datum *datum = NULL;
+	struct cil_typeattribute *new;
 
-	cil_symtab_get_datum(symtab, key, &datum);
-	if (datum == NULL) {
-		struct cil_typeattribute *new;
-		cil_typeattribute_init(&new);
-		*copy = new;
-	} else {
-		*copy = datum;
-	}
+	cil_typeattribute_init(&new);
+	*copy = new;
 
 	return SEPOL_OK;
 }
-- 
2.31.1

