Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE327C433DB
	for <selinux@archiver.kernel.org>; Tue,  5 Jan 2021 21:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8E3522D71
	for <selinux@archiver.kernel.org>; Tue,  5 Jan 2021 21:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731592AbhAEVzb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Jan 2021 16:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731586AbhAEVza (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Jan 2021 16:55:30 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820AFC061574
        for <selinux@vger.kernel.org>; Tue,  5 Jan 2021 13:54:50 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id 7so918133qtp.1
        for <selinux@vger.kernel.org>; Tue, 05 Jan 2021 13:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pcv00bu4GDXl22/pi10YkL/EsKNHfzWVjd0Wfai6+jo=;
        b=dEFy1ckTLTYIhRnwo9h13mtICfdsHc4DHUutDdeulIv5Y8T0xQOmKRx6WS2MP7VDhW
         wRnX2uXm20anmX58O4rODjfoQmlXMODRu21M2yB61B4y8cbjKMTw69E+p65AB9R9wa+k
         +WFUDmtvHw0FM17Qd3h02XTXqrJxaZiyX5juveBpQZtwmcFP/gHURMiCFLkMWoXa3Uik
         txVCcBVL7rhQBuF/2865esu06WCuhTrvcjMp63XuOo4JHt4IXZ7qf5tItZ9bJlDXk8lw
         YW+2PRvF5Ru4lQSkN2K4j33kq397DjWAgYSDkiVq6sp49qm4bypXV6v1NuHvkGxLgtQ0
         WCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pcv00bu4GDXl22/pi10YkL/EsKNHfzWVjd0Wfai6+jo=;
        b=Ml/zezUY6zb+hGJj94qHDrEgQ9NcQdgzp15Sux5m/sGSg8SsIhLX2jMFJbRfBjy1XL
         hCgoCeLwObFKVoZTuRG7pQ6YxKCweMTHPcNzgXIaJpSywk+uo58SWH8VJ44bREmtFGiY
         re3DfHh0NQrmoDnCLCueJusZ+6n18p1b6tEGAIO3uzs9411eyi6S5HxMzjdYvwvvRb0W
         QO08jSfJ5k2g3bvVqvuLvlAO5yH4DpT1DHtlkU9sjjJunjihNDInFuHvYu/7iwSTMh2O
         7SyX//0p9VqNwL67kzkbMbuvYQp5i0y2LetQJywRXXjqBuQZ+kHXjXNTiNnDXzDDa3wN
         cyZg==
X-Gm-Message-State: AOAM533hB0UQOLH1gw0NZbcu12WIcsYPfpmjX6THujdGZ9vGUgnF1NN1
        bBUXljNh8hTaXTDu+nTDR8iBXbXrwZU=
X-Google-Smtp-Source: ABdhPJxvHA7SXIL+t6aHDspbjkOeuCosWewzabmahqktgI4Qqlu0cQpcxP4iluPwm7G9mTUybeZRQA==
X-Received: by 2002:a05:622a:154:: with SMTP id v20mr1463441qtw.185.1609883689431;
        Tue, 05 Jan 2021 13:54:49 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id u5sm399807qka.86.2021.01.05.13.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 13:54:48 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: [PATCH] libsepol/cil: Fix heap-use-after-free in __class_reset_perm_values()
Date:   Tue,  5 Jan 2021 16:54:43 -0500
Message-Id: <20210105215443.238513-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.25.4
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
 libsepol/cil/src/cil_reset_ast.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/libsepol/cil/src/cil_reset_ast.c b/libsepol/cil/src/cil_reset_ast.c
index 43e6b88e..569f630b 100644
--- a/libsepol/cil/src/cil_reset_ast.c
+++ b/libsepol/cil/src/cil_reset_ast.c
@@ -9,6 +9,16 @@ static inline void cil_reset_level(struct cil_level *level);
 static inline void cil_reset_levelrange(struct cil_levelrange *levelrange);
 static inline void cil_reset_context(struct cil_context *context);
 
+static int __class_count_perms(__attribute__((unused)) hashtab_key_t k, __attribute__((unused)) hashtab_datum_t d, void *args)
+{
+	int *num = (int *)args;
+
+	(*num)++;
+
+	*((int *)args) = *num;
+
+	return SEPOL_OK;
+}
 
 static int __class_reset_perm_values(__attribute__((unused)) hashtab_key_t k, hashtab_datum_t d, void *args)
 {
@@ -22,11 +32,15 @@ static int __class_reset_perm_values(__attribute__((unused)) hashtab_key_t k, ha
 static void cil_reset_class(struct cil_class *class)
 {
 	if (class->common != NULL) {
-		struct cil_class *common = class->common;
-		cil_symtab_map(&class->perms, __class_reset_perm_values, &common->num_perms);
+		/* Must assume that the common has been destroyed */
+		int num_class_perms = 0;
+		int num_common_perms;
+		cil_symtab_map(&class->perms, __class_count_perms, &num_class_perms);
+		num_common_perms = class->num_perms - num_class_perms;
+		cil_symtab_map(&class->perms, __class_reset_perm_values, &num_common_perms);
 		/* during a re-resolve, we need to reset the common, so a classcommon
 		 * statement isn't seen as a duplicate */
-		class->num_perms -= common->num_perms;
+		class->num_perms = num_class_perms;
 		class->common = NULL; /* Must make this NULL or there will be an error when re-resolving */
 	}
 	class->ordered = CIL_FALSE;
-- 
2.25.4

