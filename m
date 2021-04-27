Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7240DC433ED
	for <selinux@archiver.kernel.org>; Tue, 27 Apr 2021 20:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ACFC6112F
	for <selinux@archiver.kernel.org>; Tue, 27 Apr 2021 20:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236956AbhD0UoW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 27 Apr 2021 16:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235416AbhD0UoV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 27 Apr 2021 16:44:21 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A42EC061574
        for <selinux@vger.kernel.org>; Tue, 27 Apr 2021 13:43:38 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id o5so61441655qkb.0
        for <selinux@vger.kernel.org>; Tue, 27 Apr 2021 13:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4TciLYREUgY2Aw3CL4BtYRhUIJrciyQtgzOy+y0s9hk=;
        b=N5CE01LgVLZ+jPtKMgh99HPsM9o0b7Whmi4BarSL/XeuC8/diZU1OjoVP0to3oyZgI
         5kIZEU2/1QqI+1iyKmlmZQKYprRZ5xpfS/dESh4eS1XW1xwVRr9gdsWol/Y/wmrmnzja
         B64KRwtw4nxH4Ndud93qsxwuZKJda69YO0e3Q2BT8L1HjlIlRrcn7L56l7MzBfK+2NCO
         x2WMnXngAmSfzUuhZ2eRv9LNTMyhdbdOc31lAFS9xvpHYmwuUSNIQHFzV9Qn1YG+9haA
         l8shDtFv0rw4/MAV22oVhINkoMjT//XX0+8duoJ9hD2GdkZfR7r3FA6dDo7S2KQ+zMIm
         NFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4TciLYREUgY2Aw3CL4BtYRhUIJrciyQtgzOy+y0s9hk=;
        b=SnbYBkm+hVOh8HCHRD/PVbX0z7qZ/0/WqEYvNFhCpBiC0UccB+8pkT9ztSPgW5RiAS
         G1EdT6s/ZB3fI4BORoiTIIPABxwTQf635SYoCSD5RLjNQZ6T2d1BTKSJKObtTkeoGDqU
         HU/7Mvt8fqpuD9t/Yn6YoOp2yuvcoEh/jPuI+2gAqbgpSc3QF/D1b3Igu+q6NrvFPVdx
         xhbIfqvIAoyGL0uHhWbQl9xtO1HIpK0+qL/os5/TafZpfjJe9ib7TKpHAY8QxpjuovyE
         9xyljyRXFAHQF8aPCyWZfN3Xuz15PJfRFaMOTS6G1xS+Ei5W0al9skkGKEJUxYIynKj9
         +N/Q==
X-Gm-Message-State: AOAM530N3PpgrkJuxDslDUC6easVMowOy5XcR/K+ukQC54CsIFBu5sP1
        aKqkaJHRNP4yHTlcARdQ0CtiQSlb1fitQA==
X-Google-Smtp-Source: ABdhPJygeymXGXjzlpoROK4QrIhfR+5klt+BHZF1jIc8aASeH2HZquQbUg9FX/eTiwITr4FUOX4wcg==
X-Received: by 2002:a37:a406:: with SMTP id n6mr17982329qke.219.1619556217253;
        Tue, 27 Apr 2021 13:43:37 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id s20sm710289qtn.74.2021.04.27.13.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 13:43:36 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol/cil: Properly reset an anonymous classperm set
Date:   Tue, 27 Apr 2021 16:43:33 -0400
Message-Id: <20210427204333.208637-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In struct cil_classperms_set, the "set" field is a pointer to a
struct cil_classpermission. Normally the classpermission is created
in a classpermissionset rule with a name declared in a
classpermission rule and stored in a symbol table. Commit c49a8ea0
("libsepol/cil: cil_reset_classperms_set() should not reset
classpermission") fixed the resetting of classperms sets by setting
the "set" field to NULL rather than resetting the classpermission
that it pointed to.

But this fix mixed the special case where an anonymous classperm
set is passed as an argument to a call. In this case the
classpermission is not named and not stored in a symtab, it is
created just for the classperms set and its classperms list needs
to be reset.

Reset the classperms list if the classperms set is anonymous (which
is when the datum name is NULL).

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_reset_ast.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
index 76405aba..d24d4f81 100644
--- a/libsepol/cil/src/cil_reset_ast.c
+++ b/libsepol/cil/src/cil_reset_ast.c
@@ -60,10 +60,14 @@ static void cil_reset_classpermission(struct cil_classpermission *cp)
 
 static void cil_reset_classperms_set(struct cil_classperms_set *cp_set)
 {
-	if (cp_set == NULL) {
+	if (cp_set == NULL || cp_set->set == NULL) {
 		return;
 	}
 
+	if (cp_set->set->datum.name == NULL) {
+		cil_reset_classperms_list(cp_set->set->classperms);
+	}
+
 	cp_set->set = NULL;
 }
 
-- 
2.26.3

