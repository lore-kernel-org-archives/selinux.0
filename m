Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F045DC433F5
	for <selinux@archiver.kernel.org>; Wed, 10 Nov 2021 23:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2D846108B
	for <selinux@archiver.kernel.org>; Wed, 10 Nov 2021 23:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbhKJXD0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Nov 2021 18:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbhKJXDV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Nov 2021 18:03:21 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE13C0613F5
        for <selinux@vger.kernel.org>; Wed, 10 Nov 2021 15:00:33 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id k22-20020a635a56000000b002df9863aa74so759234pgm.19
        for <selinux@vger.kernel.org>; Wed, 10 Nov 2021 15:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yNrrb1MY66o5TEyam1VaYvCkGo/lj2vOXH/uZFJ75Lc=;
        b=CUiAJ9p5bk6Iv5tdC414ooYPRjb2bhcAWHQgOvROCxmPWVNHbu21+CN5VqNAqK+mcs
         FFtDjMO7bm0CbatcQhs84QzxXP94big3USlPHlyS3RGDCvEhnlsWpqBJZOVY8lIJp5hn
         3Go0qjSqbksTmIablvqW2e/FGdfCqpq6cyxLCONn7aCyrDVeFrErwdojbZM0cWHT3SRo
         3L9gRGkHDx4RmWHyqr/NfoVpe2WoTMZmIE0oHCr1zWm82eVeif7vlOfe1rGu3wFnjLec
         05IJIhEFUy7/jOUiv46ST6F/2eIPPE2FtQc6HN5u5tB7qBOo/oW1Lzhol+VXAc50CbA6
         8xpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yNrrb1MY66o5TEyam1VaYvCkGo/lj2vOXH/uZFJ75Lc=;
        b=A4+gCxfw1NOZ9v6QR9v/kJsU42CbUsecVAqxNjC3e0hoa6oL3jWJ0ZKN3fa0J3Y26w
         pBY4P+iYN56KRtu8b7Pa3IgvGsDP9PQaGIbTUykdDrNpCFYrIxDoK/JdKXGEh03zHrQx
         3kGWMpv+0n/8x9zHYCBfBHbPEVvSyDEn4y79PPIENk7fZEYCc9tAR+137T2ch4r+gkMK
         uKtxl3p/D9C+9+Hn+/oKEbQNFbRpUdTs+abEsqKu7Dm2itF/PW+s0BPkToV265ZEco2y
         wSoghynfOzHBGUDd3s1gCtdWWlkbIp5/US1PfSE4aiGdLU7DLF3b2BfMWtPuNWWCtR49
         3L9Q==
X-Gm-Message-State: AOAM531wfA6qeOfqS0r4Jo1J5Z6uNpGIloLic+GsESk60F7xqlqW1Eob
        YfDNjD2rmnKoE0cy01MjR0wEYv9bBA==
X-Google-Smtp-Source: ABdhPJywdaxOOw9nASlhOPJsKBRybMvXwDYonXMni0w7Qq+5w6A1MNcPmMEClR1ICZ6i+XHI8LUP2VsobA==
X-Received: from tkjos-desktop.mtv.corp.google.com ([2620:15c:211:200:4a73:99b6:9694:8c4d])
 (user=tkjos job=sendgmr) by 2002:a17:90a:b107:: with SMTP id
 z7mr3006564pjq.104.1636585232687; Wed, 10 Nov 2021 15:00:32 -0800 (PST)
Date:   Wed, 10 Nov 2021 15:00:25 -0800
In-Reply-To: <20211110230025.3272776-1-tkjos@google.com>
Message-Id: <20211110230025.3272776-3-tkjos@google.com>
Mime-Version: 1.0
References: <20211110230025.3272776-1-tkjos@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH 5.4 3/3] binder: use cred instead of task for getsecid
From:   Todd Kjos <tkjos@google.com>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org,
        arve@android.com, tkjos@android.com, maco@android.com,
        christian@brauner.io, jmorris@namei.org, serge@hallyn.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, keescook@chromium.org, jannh@google.com,
        jeffv@google.com, zohar@linux.ibm.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        devel@driverdev.osuosl.org
Cc:     joel@joelfernandes.org, kernel-team@android.com,
        Todd Kjos <tkjos@google.com>,
        kernel test robot <lkp@intel.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

commit 4d5b5539742d2554591751b4248b0204d20dcc9d upstream.

Use the 'struct cred' saved at binder_open() to lookup
the security ID via security_cred_getsecid(). This
ensures that the security context that opened binder
is the one used to generate the secctx.

Cc: stable@vger.kernel.org # 5.4+
Fixes: ec74136ded79 ("binder: create node flag to request sender's security context")
Signed-off-by: Todd Kjos <tkjos@google.com>
Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Change-Id: Ia7b59804a0bdbd51191bbcca556414840307c623
---
 drivers/android/binder.c | 2 +-
 include/linux/security.h | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index cebb2cd1876c..c2c411c458b2 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3107,7 +3107,7 @@ static void binder_transaction(struct binder_proc *proc,
 		u32 secid;
 		size_t added_size;
 
-		security_task_getsecid(proc->tsk, &secid);
+		security_cred_getsecid(proc->cred, &secid);
 		ret = security_secid_to_secctx(secid, &secctx, &secctx_sz);
 		if (ret) {
 			return_error = BR_FAILED_REPLY;
diff --git a/include/linux/security.h b/include/linux/security.h
index 0d4cb64cae1f..3f6b8195ae9e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -985,6 +985,11 @@ static inline void security_transfer_creds(struct cred *new,
 {
 }
 
+static inline void security_cred_getsecid(const struct cred *c, u32 *secid)
+{
+	*secid = 0;
+}
+
 static inline int security_kernel_act_as(struct cred *cred, u32 secid)
 {
 	return 0;
-- 
2.34.0.rc0.344.g81b53c2807-goog

