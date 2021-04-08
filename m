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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D821C43460
	for <selinux@archiver.kernel.org>; Thu,  8 Apr 2021 19:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04F0F610F9
	for <selinux@archiver.kernel.org>; Thu,  8 Apr 2021 19:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhDHTQk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Apr 2021 15:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbhDHTQk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Apr 2021 15:16:40 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3606C061761
        for <selinux@vger.kernel.org>; Thu,  8 Apr 2021 12:16:26 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id g24so2317660qts.6
        for <selinux@vger.kernel.org>; Thu, 08 Apr 2021 12:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G08xcHAvZeOnKEFrI6/qJno7ukWbzL3vJBkY5jHXdkI=;
        b=QbR02fI8qUmALjNLGW2yTnAiWVh3gzitmU7m8ITHmvCTmR6I+8fFr2MC8H8FFT59sT
         l9trRrVvisPcQmjwfh5p4XxqYGbgOWnEN9sD5bE0caegdgLfbN5rj6FUb7GMXo+zaRo0
         55ezl04DN6st7jlWyIj0E1XBEtq7mn5plgie9lsSs97Q2Tgp9fimWu+QjszoS+8wFkbx
         0J1jniHuI6WbLO8/6sd7t6BMtkDW5FQKz9RemsYiKovlLHoQxBj5KaYd/LNkKa+hTuuS
         fMbGI2t0gbMO7sBcQUXr/beugW7n06upLw0r64QlA0Q/b065tEexstbR7uZZg+k8byhm
         kU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G08xcHAvZeOnKEFrI6/qJno7ukWbzL3vJBkY5jHXdkI=;
        b=CsOB30qUqAYI0anoffV3TGc3KLGdIVTSqtWtSC/4ghbpmVo41V4/0X/m5TtyuOqsrg
         qd5VXMOe8Qdf/UzNJj8Kotj0A4RMZ4A5hDKLmBhzhrNwRJTVgc6KwYB84mwSi5hc7Xhj
         la0cZsDRzwgj/CJL4lhfbmd1qcPS1ekF4pS16qXTonecW2nLck8AQvSlN0l5FuuEewvJ
         SH7lXrnLqHZjUOkJFQ8A6hsBCGVhnecSm3elmPj83NdhdQgSiEHC+rkS83t8ooBCyYEY
         lGv9tIyakpgMkH7hHqvFeKEPpJMPmJ2/2Rj6hhqPXA71YaqP9G3+nfZJzYJTAFTIlmad
         Z2dg==
X-Gm-Message-State: AOAM530iE542vvVBQ/niEAfZdVy4sEcIxjPybbqJpgM64aSgpB3dNX/P
        a+K3cRlPmStZlmILiTG65I9AUKjFAzIw3g==
X-Google-Smtp-Source: ABdhPJy0jYzbg4ILOVN4BlOcBT8ogKeRhLiFejdcoC4h429Weq/jaLYxNmTOXvDmki7giMa6jvCWcQ==
X-Received: by 2002:ac8:734c:: with SMTP id q12mr9265117qtp.160.1617909385776;
        Thu, 08 Apr 2021 12:16:25 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id v128sm147949qkc.127.2021.04.08.12.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 12:16:25 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 02/11] libsepol/cil: Destroy classperms list when resetting classpermission
Date:   Thu,  8 Apr 2021 15:16:05 -0400
Message-Id: <20210408191614.262173-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210408191614.262173-1-jwcart2@gmail.com>
References: <20210408191614.262173-1-jwcart2@gmail.com>
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

