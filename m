Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722E2C433FE
	for <selinux@archiver.kernel.org>; Wed,  6 Oct 2021 19:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 517C2610C7
	for <selinux@archiver.kernel.org>; Wed,  6 Oct 2021 19:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239525AbhJFTsP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Oct 2021 15:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239509AbhJFTsM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Oct 2021 15:48:12 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9C1C061760
        for <selinux@vger.kernel.org>; Wed,  6 Oct 2021 12:46:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id q17-20020a25b591000000b005a07d27bbdaso4819889ybj.3
        for <selinux@vger.kernel.org>; Wed, 06 Oct 2021 12:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+cJ2U8Kdfy1yQQcGk3LARYGCqa9M8jIliNAIu7s74eQ=;
        b=ZvJyaUxlzhtcsgadNpmuGGUBZT76eQqyEVoB8on2XenmCdJm9gZ6R2RDf+xiH8rMFG
         1qN5V/UD5aOJs8Hf+hNMD/y6MJMO2w469S+KdFUi+IIo0pJ9S4959sStXjvF7imp5s1w
         Ob9eaIYx5Q95X1D4mzr7Hvi1k54zuwi2eUnK3ftn06t6/bX3gsBzqF2IPr9cJkEs+0UF
         mhBehHkdB00HeaH0+BEtSaaQh1xMDssE8KeuYFm1U5yF8qgcRSJpDrMErZLNHycGQ/FL
         u9Z2R+tNbEc4r6wr6vKtKhYsHcoD35c2RxK1kBQeQA9o8fp0riETFiZRHe6WIpcMZv5f
         rjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+cJ2U8Kdfy1yQQcGk3LARYGCqa9M8jIliNAIu7s74eQ=;
        b=vIew/Vka3Evp+/u03r7juEXpxPZLLaEzpyY97Nc++hLTjqkHvvrG1IDsLVF7ooPV4T
         teGZk5spEV9NMlTmE9tEC/H9josi6VcA/ToCQRzs5TPetWhFo1+7hHuvPnxE5ttaewwB
         j7dfEk2Kb/N0zcVxe+LORBPB3Hlj7sJybdHdBg7c+bKS+uHfjO7xM2Pd8PDwalqExlGK
         e6JB5ubyNocymNgvOP9YP/bjb9cfVbLeGQ2fOduoTAJ7u6DACJt4dROT0Q2VWFkjG0K1
         +lsf4ZzI+PUlGa1s/uP/8uIIJltR+l+oE+4H/MMCq08rASoE8ee7Ni73FbWJXekvIPJi
         zGSA==
X-Gm-Message-State: AOAM531JVKlbEJusip3YL0bClh4ra5STwvyOrh/NP43hsa2kfEuXx1TO
        MFAsBXlEIxf1FR8/5AAcrwXpBWJpzA==
X-Google-Smtp-Source: ABdhPJx4NII6suHk437Oza4d9GhybnDEU0XlzwSKDh6uVO5Hgr9ofng+eRpQ+vrF7M4hFmvgSyMBKr4gIA==
X-Received: from ava-linux2.mtv.corp.google.com ([2620:15c:211:200:6ff2:347f:ac4a:8a04])
 (user=tkjos job=sendgmr) by 2002:a25:e4c7:: with SMTP id b190mr47234ybh.28.1633549579410;
 Wed, 06 Oct 2021 12:46:19 -0700 (PDT)
Date:   Wed,  6 Oct 2021 12:46:09 -0700
In-Reply-To: <20211006194610.953319-1-tkjos@google.com>
Message-Id: <20211006194610.953319-3-tkjos@google.com>
Mime-Version: 1.0
References: <20211006194610.953319-1-tkjos@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v3 2/3] binder: use cred instead of task for getsecid
From:   Todd Kjos <tkjos@google.com>
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, christian@brauner.io, jmorris@namei.org,
        serge@hallyn.com, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        keescook@chromium.org, jannh@google.com, jeffv@google.com,
        zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     joel@joelfernandes.org, kernel-team@android.com,
        Todd Kjos <tkjos@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use the 'struct cred' saved at binder_open() to lookup
the security ID via security_cred_getsecid(). This
ensures that the security context that opened binder
is the one used to generate the secctx.

Fixes: ec74136ded79 ("binder: create node flag to request sender's
security context")
Signed-off-by: Todd Kjos <tkjos@google.com>
Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: stable@vger.kernel.org # 5.4+
---
v3: added this patch to series

 drivers/android/binder.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index ca599ebdea4a..989afd0804ca 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2722,16 +2722,7 @@ static void binder_transaction(struct binder_proc *proc,
 		u32 secid;
 		size_t added_size;
 
-		/*
-		 * Arguably this should be the task's subjective LSM secid but
-		 * we can't reliably access the subjective creds of a task
-		 * other than our own so we must use the objective creds, which
-		 * are safe to access.  The downside is that if a task is
-		 * temporarily overriding it's creds it will not be reflected
-		 * here; however, it isn't clear that binder would handle that
-		 * case well anyway.
-		 */
-		security_task_getsecid_obj(proc->tsk, &secid);
+		security_cred_getsecid(proc->cred, &secid);
 		ret = security_secid_to_secctx(secid, &secctx, &secctx_sz);
 		if (ret) {
 			return_error = BR_FAILED_REPLY;
-- 
2.33.0.800.g4c38ced690-goog

