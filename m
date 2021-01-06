Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B3EC433E0
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 18:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5507423124
	for <selinux@archiver.kernel.org>; Wed,  6 Jan 2021 18:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbhAFSoQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Jan 2021 13:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbhAFSoP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Jan 2021 13:44:15 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E20C06134C
        for <selinux@vger.kernel.org>; Wed,  6 Jan 2021 10:43:35 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id z20so2716512qtq.3
        for <selinux@vger.kernel.org>; Wed, 06 Jan 2021 10:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QUPI4ReM+o1trybz4nZP++kwgdkPc9RP0m5KTGl6a9E=;
        b=ol34VkI0q7KfvaFBtjVtXPn7X/DpL1FmsDzb/a/t3kRGEGgHkGIN8h09QrHxVvO8Wc
         nOrvRVsEwrQB54ia/29qmaECnsyDjqehFNWWykf0CkNaYX6GpHrM/G3jy1EteMqeFOVQ
         pWtOUjOo5xvhIu5A6w5hpL7Jo26DCjmNA6s8/X8Ok7wEqP1nTBhZDZk4G2t2cNyVjNT3
         a9PCOTZT82SzRlANIg/Eue+hGpJfglzmNP3nclZ7biOT3WUtNxIoLgb/8nhswmBkhm32
         0PZokV//TVVXIzSK7EKUaRbgqjHIjp310TP0Pnt7lTZD7alpmqlI4mXduPqk1bj1nGZ1
         Bszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QUPI4ReM+o1trybz4nZP++kwgdkPc9RP0m5KTGl6a9E=;
        b=Mj++X5Q9Q6xyauC5RwBl2o2qrA/iNle3GccvHzyQfs3U/gw1Fjco2KOrKYaCdhfMEl
         39/8oCp8W9gWVuur9o47ZpY6ojc8qEkb8hqgxbxWFD7wdNFMDnvdTh5yRhSBY+9jnqNV
         CoQLq4cBjb7BbpiRxy1P+9oPVt2wsTTDMBb6elOKaYx0ix4enwp6xuL+9Q2Q2eGkiDUJ
         2gqhV4J1uagwEkB3BXewTO12gC0yFnBsLgGQ/k8OBu/kTmdCdcx6C7DbEFfVaMyrT7GE
         0LW47NyOgZqUmwjV78ff/eilNrBci7S0JJOmTIlLq6odieCoTvZyvf4lF1VLMEHFI1Hz
         rLQg==
X-Gm-Message-State: AOAM533m1N7Jod8XtoGFFfi9uUNiCmQ6qGUjOh+IEn89sctBeZz1fOMq
        H1S3EgeVyt+CZ1sww9XE6595UoCWvK4=
X-Google-Smtp-Source: ABdhPJzJwW03Etsv6xNvpSaANv8f0ttRj+L4YyQBO25cdsok1IoTD5IcdFlmtQzu3jD7iMWEpXNeog==
X-Received: by 2002:aed:2ac1:: with SMTP id t59mr5175205qtd.165.1609958614464;
        Wed, 06 Jan 2021 10:43:34 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id j29sm1523846qtv.11.2021.01.06.10.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 10:43:34 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: [PATCH 2/2] libsepol/cil: Fix heap-use-after-free in __class_reset_perm_values()
Date:   Wed,  6 Jan 2021 13:43:26 -0500
Message-Id: <20210106184326.272726-2-jwcart2@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210106184326.272726-1-jwcart2@gmail.com>
References: <20210106184326.272726-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Nicolas Iooss reports:
  A few weeks ago, OSS-Fuzz got configured in order to fuzz the CIL
  policy compiler (cf.
  https://github.com/SELinuxProject/selinux/issues/215 and
  https://github.com/google/oss-fuzz/pull/4790). It reported a bunch of
  simple issues, for which I will submit patches. There are also more
  subtle bugs, like the one triggered by this CIL policy:

  (class CLASS (PERM))
  (classorder (CLASS))
  (sid SID)
  (sidorder (SID))
  (sensitivity SENS)
  (sensitivityorder (SENS))
  (type TYPE)
  (allow TYPE self (CLASS (PERM)))

  (block b
      (optional o
          (sensitivitycategory SENS (C)) ; Non-existing category
  triggers disabling the optional
          (common COMMON (PERM1))
          (classcommon CLASS COMMON)
          (allow TYPE self (CLASS (PERM1)))
      )
  )

  On my computer, secilc manages to build this policy fine, but when
  clang's Address Sanitizer is enabled, running secilc leads to the
  following report:

  $ make -C libsepol/src CC=clang CFLAGS='-g -fsanitize=address' libsepol.a
  $ clang -g -fsanitize=address secilc/secilc.c libsepol/src/libsepol.a
  -o my_secilc
  $ ./my_secilc -vv testcase.cil
  Parsing testcase.cil
  Building AST from Parse Tree
  Destroying Parse Tree
  Resolving AST
  Failed to resolve sensitivitycategory statement at testcase.cil:12
  Disabling optional 'o' at testcase.cil:11
  Resetting declarations
  =================================================================
  ==181743==ERROR: AddressSanitizer: heap-use-after-free on address
  0x6070000000c0 at pc 0x55ff7e445d24 bp 0x7ffe7eecfba0 sp
  0x7ffe7eecfb98
  READ of size 4 at 0x6070000000c0 thread T0
      #0 0x55ff7e445d23 in __class_reset_perm_values
  /git/selinux-userspace/libsepol/src/../cil/src/cil_reset_ast.c:17:17

The problem is that the optional branch is destroyed when it is disabled,
so the common has already been destroyed when the reset code tries to
access the number of common permissions, so that it can change the
value of the class permissions back to their original values.

The solution is to count the number of class permissions and then
calculate the number of common permissions.

Reported-by: Nicolas Iooss <nicolas.iooss@m4x.org>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_reset_ast.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
index 43e6b88e..52e5f640 100644
--- a/libsepol/cil/src/cil_reset_ast.c
+++ b/libsepol/cil/src/cil_reset_ast.c
@@ -22,11 +22,12 @@ static int __class_reset_perm_values(__attribute__((unused)) hashtab_key_t k, ha
 static void cil_reset_class(struct cil_class *class)
 {
 	if (class->common != NULL) {
-		struct cil_class *common = class->common;
-		cil_symtab_map(&class->perms, __class_reset_perm_values, &common->num_perms);
+		/* Must assume that the common has been destroyed */
+		int num_common_perms = class->num_perms - class->perms.nprim;
+		cil_symtab_map(&class->perms, __class_reset_perm_values, &num_common_perms);
 		/* during a re-resolve, we need to reset the common, so a classcommon
 		 * statement isn't seen as a duplicate */
-		class->num_perms -= common->num_perms;
+		class->num_perms = class->perms.nprim;
 		class->common = NULL; /* Must make this NULL or there will be an error when re-resolving */
 	}
 	class->ordered = CIL_FALSE;
-- 
2.25.4

