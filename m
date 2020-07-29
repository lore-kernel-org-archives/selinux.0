Return-Path: <SRS0=6Qkr=BI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6256FC433EB
	for <selinux@archiver.kernel.org>; Wed, 29 Jul 2020 17:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 438412083B
	for <selinux@archiver.kernel.org>; Wed, 29 Jul 2020 17:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PeYr3jVB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgG2R7d (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Jul 2020 13:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbgG2R7G (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Jul 2020 13:59:06 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED15C0619DE
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2020 10:59:05 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d4so14677403pgk.4
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2020 10:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2dckHYDBSef92hBk0hdLw37DCCWMtjung/PzGLRIGlQ=;
        b=PeYr3jVB7W6UcW212/oJZmLRi4czVPcQjfijK3aeH7rdxGYPMC62JtlyIoOxj7gwy5
         c2dWpHJMjKgNg5+GOs7lE5ptFlJbitvkjzFCMkK2BuSsglPWQHHRYHbZXOmZVOOvVeL9
         AXbaJuHNrbC7ktjkX3HyAY7OqVwqAjEvn/WKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2dckHYDBSef92hBk0hdLw37DCCWMtjung/PzGLRIGlQ=;
        b=ZrLXeKyQHuTBcoR2VvUqaaSbYX7hOoChldHHVaA5VrZ9QEa2UTpNe2m0MSNVz9hXYI
         itSWIkd2bEygd3HWRa/5lxJy3rAIraDuk4wygkUoSJXUchklvoxIdjFKcA9Wee+Uqiws
         Tg4u1pNnbqWpw8iMIq1JE6Hg9PE3hurD/IThvLzgHrTVS7w8b0RNr4vsrRI5w3BoIrbr
         uX8Es9sopdlwv9yWRggyKh+rbc3m40oJzKdPcOStm55ibmXq2uaVdwBsto8ssN2+n8u4
         PWachWCQn10xxGzifg61s+IE8wz6fcxQb/eHtIZz65Gk1zPpEtin7AwU0dZ7PFVbcD5Z
         GuSA==
X-Gm-Message-State: AOAM533FQOfgVW/LDgN1ezIczrFezo0NhpPYOP6kLlv2cxE7ypglQ60P
        pvbfnML5SEsxZBnM4YVxrm71sQ==
X-Google-Smtp-Source: ABdhPJx0d4Pms05JWWdUqTfjeGaSa2h+B6c1vOgjK6stye4AbmKSEHfAQSNgfmrRFdWMcscCi/9fDQ==
X-Received: by 2002:a65:64c5:: with SMTP id t5mr30425186pgv.28.1596045544724;
        Wed, 29 Jul 2020 10:59:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t73sm3172293pfc.78.2020.07.29.10.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 10:58:58 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Jessica Yu <jeyu@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Takashi Iwai <tiwai@suse.de>, SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/17] module: Call security_kernel_post_load_data()
Date:   Wed, 29 Jul 2020 10:58:39 -0700
Message-Id: <20200729175845.1745471-12-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200729175845.1745471-1-keescook@chromium.org>
References: <20200729175845.1745471-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Now that there is an API for checking loaded contents for modules
loaded without a file, call into the LSM hooks.

Cc: Jessica Yu <jeyu@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/module.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index d773f32f8dfd..72e33e25d7b9 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2970,7 +2970,7 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
 	if (info->len < sizeof(*(info->hdr)))
 		return -ENOEXEC;
 
-	err = security_kernel_load_data(LOADING_MODULE, false);
+	err = security_kernel_load_data(LOADING_MODULE, true);
 	if (err)
 		return err;
 
@@ -2980,11 +2980,17 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
 		return -ENOMEM;
 
 	if (copy_chunked_from_user(info->hdr, umod, info->len) != 0) {
-		vfree(info->hdr);
-		return -EFAULT;
+		err = -EFAULT;
+		goto out;
 	}
 
-	return 0;
+	err = security_kernel_post_load_data((char *)info->hdr, info->len,
+					     LOADING_MODULE);
+out:
+	if (err)
+		vfree(info->hdr);
+
+	return err;
 }
 
 static void free_copy(struct load_info *info)
-- 
2.25.1

