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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC5FC43460
	for <selinux@archiver.kernel.org>; Thu,  8 Apr 2021 19:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49BBF610F9
	for <selinux@archiver.kernel.org>; Thu,  8 Apr 2021 19:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhDHTQr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Apr 2021 15:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbhDHTQr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Apr 2021 15:16:47 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D695C061760
        for <selinux@vger.kernel.org>; Thu,  8 Apr 2021 12:16:35 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id c4so3430884qkg.3
        for <selinux@vger.kernel.org>; Thu, 08 Apr 2021 12:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uNVjxbwsKrqwRb8jBBJOfCRPJrEs0SiZcbQRvn8IZOU=;
        b=uYNg8p8E81CpsSIx0WDbkdb3ze/Vt6pR3L2IgymOglBCCc3JY392ZQXb3M6Av8ZfpI
         ThgeA7wC0cUyaiCEIw34KNQ9EsegfFShLU6jZ808LMKrvXT3VHP1d8zuoX6Q3EtAMCbn
         coP4sZqVV9GlDohl/fdg4lReUoYwyiL1XxAH1HOLWN7B6CNro8ZAtQduTQA6qKvVGAL+
         rOMrTEfMcrd39Nkrbqw1OHpmDzmfmVP0W3B4tzhJzIPGCSkbBV+z1XcdzhguvprVandS
         oslMMg0ATUwQu9poZsmLPwcX9p3mIgqjOcWIRLBQn2lFuERzxzNNPurYQQR/oymCE4PU
         rXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uNVjxbwsKrqwRb8jBBJOfCRPJrEs0SiZcbQRvn8IZOU=;
        b=n+pH8R63zuj+gjihVLfSGptUItSwrNMGVmXb5QtO0Rag330F3pCJl8o9mRezJm/+fV
         VLfpf88ioefmdwaBJZEjQ2l5jPnZT4ByiFyCtDsZ4iwjLbV8CFyie8o4ryWu9wC3PyRf
         uC+XlM02H5vfP3nR8VoVtCFXPNYYmtcrdgECmm86lYx88YvrkCGkVMSuZmBTIdIiVAwU
         9v0EovP0/5HtJd4C0lBK6sFTo6FtRNIWLGSh0oJEM129KvmudywlyDDFOQa/iFPTsEjg
         LAKiLqxRfzbLynmVx0pB1IxNSBf079X5gF6SeoE5CJi7DLOgsrAwPojt7Qk2kGSZpp4a
         lUfw==
X-Gm-Message-State: AOAM53296sm1DO3+5KJEqRMGsfNfE4Qsljt4vW7sfkKL7uOOPB2v8lPC
        rooa4nXCVFRqVwT65vnUR8OAxZxWxlWwDw==
X-Google-Smtp-Source: ABdhPJwxRcZ6WP3oqCJLPio+wEvfzE/i6GaIIYD/3d9w7o5TEDVbBP49xfLHfpUdNUnLopwmBFZr2g==
X-Received: by 2002:a05:620a:4c7:: with SMTP id 7mr10358637qks.31.1617909394729;
        Thu, 08 Apr 2021 12:16:34 -0700 (PDT)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id v128sm147949qkc.127.2021.04.08.12.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 12:16:34 -0700 (PDT)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     nicolas.iooss@m4x.org, James Carter <jwcart2@gmail.com>
Subject: [PATCH 08/11] libsepol/cil: Allow permission expressions when using map classes
Date:   Thu,  8 Apr 2021 15:16:11 -0400
Message-Id: <20210408191614.262173-9-jwcart2@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210408191614.262173-1-jwcart2@gmail.com>
References: <20210408191614.262173-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The following policy will cause a segfault:
  (class CLASS (PERM))
  (class C (P1 P2 P3))
  (classorder (CLASS C))
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

  (classmap CM (PM1 PM2 PM3))
  (classmapping CM PM1 (C (P1)))
  (classmapping CM PM2 (C (P2)))
  (classmapping CM PM3 (C (P3)))
  (allow TYPE self (CM (and (all) (not PM2))))

The problem is that, while permission expressions are allowed for
normal classes, map classes are expected to only have permission
lists and no check is done to verify that only a permission list
is being used.

When the above policy is parsed, the "and" and "all" are seen as
expression operators, but when the map permissions are converted to
normal class and permissions, the permission expression is assumed
to be a list of datums and since the operators are not datums a
segfault is the result.

There is no reason to limit map classes to only using a list of
permissions and, in fact, it would be better to be able to use them
in the same way normal classes are used.

Allow permissions expressions to be used for map classes by first
evaluating the permission expression and then converting the
resulting list to normal classes and permissions.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/cil/src/cil_post.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index fd4758dc..05842b64 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -2137,6 +2137,10 @@ static int __evaluate_classperms_list(struct cil_list *classperms, struct cil_db
 				}
 			} else { /* MAP */
 				struct cil_list_item *i = NULL;
+				rc = __evaluate_classperms(cp, db);
+				if (rc != SEPOL_OK) {
+					goto exit;
+				}
 				cil_list_for_each(i, cp->perms) {
 					struct cil_perm *cmp = i->data;
 					rc = __evaluate_classperms_list(cmp->classperms, db);
-- 
2.26.3

