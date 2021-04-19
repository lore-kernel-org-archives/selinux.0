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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA130C433B4
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 15:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC8A16113C
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 15:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239396AbhDSPQp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Apr 2021 11:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240771AbhDSPQn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Apr 2021 11:16:43 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CFDC061763
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 08:16:12 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id x11so36041965qkp.11
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 08:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G08xcHAvZeOnKEFrI6/qJno7ukWbzL3vJBkY5jHXdkI=;
        b=VBEn9dXapdZYT9aE2ky7KthveY1PgSWTnVqKK6PMJnQbL1GzBRfPfzCMHrRFTzV7g2
         iWDH12x3DR4BwlHEYyO2fhIv74m43GZd7w1R8m/WLnd7AcBCHwZvuIbG4pyWK31lNfQl
         wJHHiTy6CalXEinAUUacpng8rFDDMzY2zIKouUxftg9TN/P98F0KdLvbxz4MRnTw0yUv
         /BEvJVHwF0x9A2bAK29LF8nCc9VH/9p/0jdP6+zWQ0QywZUZsYRx4jAUk2KdTL4pXilo
         Zi91Gpykg+7is/VJfxfTcOTHqPK0QNPgHyt73nRQj8o5onDxGAnxDNTWXmAwgJYIha03
         cKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G08xcHAvZeOnKEFrI6/qJno7ukWbzL3vJBkY5jHXdkI=;
        b=YUqqGXXL+cGbqTcK8DeNSQ8mGXBy2efF5C/1ZtOMGjA7EefeziNgtOHahWUXwKe8xV
         KDtNPVDGhChdwSHF88dUuJcHr9PkQ3Fbnzat1a0pBMorDx0ctal3hMf7zWeLyYfjvhRB
         RqKC44Pe2pwKrdgAnY80GARTDx/4rIeXmojjEuWHDEm2rn8E4Es1j2AgcC46qtZQ3UC7
         um4GEwswzv8GG2SGaDQjzDOKmrhUlltg7vOmDJ1fagWBzUNrMCaFnUVeX436T1kYb+5Y
         RHaAXikXNMJPgUvEX6hu+BBr2u5LBI0B9mmFe1mNbLZsdhde3HTxFXungBMMUz2+2zAU
         oyzg==
X-Gm-Message-State: AOAM530V+yNg36NkKp+xSxMaLuXSrKKbHbwD5YYdtSPuEgzA/9uc2Y18
        Sp9YFvn0dJl7ZjtXbgYIayapyZIJ0RvqAQ==
X-Google-Smtp-Source: ABdhPJyyOkzZiTND29BD5L1RFn2o0VCGBhb0waW1exGN5b49NsQ737Mr5BP7VvQhMjosyk5dQKa/1w==
X-Received: by 2002:a37:4091:: with SMTP id n139mr12302061qka.360.1618845372078;
        Mon, 19 Apr 2021 08:16:12 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id d68sm9840584qkf.93.2021.04.19.08.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 08:16:11 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 02/11 v2] libsepol/cil: Destroy classperms list when resetting classpermission
Date:   Mon, 19 Apr 2021 11:15:48 -0400
Message-Id: <20210419151557.87561-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210419151557.87561-1-jwcart2@gmail.com>
References: <20210419151557.87561-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss reports:
  A few months ago, OSS-Fuzz found a crash in the CIL compiler, which
  got reported as
  https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28648 (the title
  is misleading, or is caused by another issue that conflicts with the
  one I report in this message). Here is a minimized CIL policy which
  reproduces the issue:

  (class CLASS (PERM))
  (classorder (CLASS))
  (sid SID)
  (sidorder (SID))
  (user USER)
  (role ROLE)
  (type TYPE)
  (category CAT)
  (categoryorder (CAT))
  (sensitivity SENS)
  (sensitivityorder (SENS))
  (sensitivitycategory SENS (CAT))
  (allow TYPE self (CLASS (PERM)))
  (roletype ROLE TYPE)
  (userrole USER ROLE)
  (userlevel USER (SENS))
  (userrange USER ((SENS)(SENS (CAT))))
  (sidcontext SID (USER ROLE TYPE ((SENS)(SENS))))

  (classpermission CLAPERM)

  (optional OPT
      (roletype nonexistingrole nonexistingtype)
      (classpermissionset CLAPERM (CLASS (PERM)))
  )

  The CIL policy fuzzer (which mimics secilc built with clang Address
  Sanitizer) reports:

  ==36541==ERROR: AddressSanitizer: heap-use-after-free on address
  0x603000004f98 at pc 0x56445134c842 bp 0x7ffe2a256590 sp
  0x7ffe2a256588
  READ of size 8 at 0x603000004f98 thread T0
      #0 0x56445134c841 in __cil_verify_classperms
  /selinux/libsepol/src/../cil/src/cil_verify.c:1620:8
      #1 0x56445134a43e in __cil_verify_classpermission
  /selinux/libsepol/src/../cil/src/cil_verify.c:1650:9
      #2 0x56445134a43e in __cil_pre_verify_helper
  /selinux/libsepol/src/../cil/src/cil_verify.c:1715:8
      #3 0x5644513225ac in cil_tree_walk_core
  /selinux/libsepol/src/../cil/src/cil_tree.c:272:9
      #4 0x564451322ab1 in cil_tree_walk
  /selinux/libsepol/src/../cil/src/cil_tree.c:316:7
      #5 0x5644513226af in cil_tree_walk_core
  /selinux/libsepol/src/../cil/src/cil_tree.c:284:9
      #6 0x564451322ab1 in cil_tree_walk
  /selinux/libsepol/src/../cil/src/cil_tree.c:316:7
      #7 0x5644512b88fd in cil_pre_verify
  /selinux/libsepol/src/../cil/src/cil_post.c:2510:7
      #8 0x5644512b88fd in cil_post_process
  /selinux/libsepol/src/../cil/src/cil_post.c:2524:7
      #9 0x5644511856ff in cil_compile
  /selinux/libsepol/src/../cil/src/cil.c:564:7

The classperms list of a classpermission rule is created and filled
in when classpermissionset rules are processed, so it doesn't own any
part of the list and shouldn't retain any of it when it is reset.

Destroy the classperms list (without destroying the data in it)  when
resetting a classpermission rule.

Reported-by: Nicolas Iooss <nicolas.iooss@m4x.org>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_reset_ast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
index 3da1b9a6..db70a535 100644
--- a/libsepol/cil/src/cil_reset_ast.c
+++ b/libsepol/cil/src/cil_reset_ast.c
@@ -54,7 +54,7 @@ static void cil_reset_classpermission(struct cil_classpermission *cp)
 		return;
 	}
 
-	cil_reset_classperms_list(cp->classperms);
+	cil_list_destroy(&cp->classperms, CIL_FALSE);
 }
 
 static void cil_reset_classperms_set(struct cil_classperms_set *cp_set)
-- 
2.26.3

