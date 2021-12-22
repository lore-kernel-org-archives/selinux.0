Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4B7C433EF
	for <selinux@archiver.kernel.org>; Wed, 22 Dec 2021 20:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345374AbhLVUKG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Dec 2021 15:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236592AbhLVUKG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Dec 2021 15:10:06 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5CAC061574
        for <selinux@vger.kernel.org>; Wed, 22 Dec 2021 12:10:05 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id e16so3412735qkl.12
        for <selinux@vger.kernel.org>; Wed, 22 Dec 2021 12:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=XvR1YRdTxuXwgX4SvkY7PLMBJhmSpQRG9Rgng1JerRU=;
        b=zRIcqXrJYoqcs374Va45n/RgWf76U4Zf7ruPK8z0x4Ek2TSguJsJoB8yKoYVn9DmBi
         eVMhefCmeIO6CQ2/JZ8oXA8mFCdge+Bvl0h4R8LVJ+hAca3tizAC9V9gFSq7y7y3fTab
         DoCEETJ8cCrtAjTEPmd3S87qhe2L973Kt0t6NDuFkTIPaqJbJJXuwxCFmpel5zSYgEMt
         XrHkrbbX3+QHwrYkE67WWtd6B37XzMj55rn6azuNuk9J7GZ1NlHELNYJib6Ej+Azxk4W
         WlE1/+Iq7WzHr6UOff4T+vJAPNzFVvmDS0V6d2zX9h6r5V7Ic5kIz/+cv6hqr0jscUqm
         fPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=XvR1YRdTxuXwgX4SvkY7PLMBJhmSpQRG9Rgng1JerRU=;
        b=ORGR9QBxDWrsuFLtjCtz/QeNn9/NnZaJkmu2pmNnBwq4HykBXQY+iOjQXM4ynrNdfU
         G4hq3qgXVoVJBiYCdY35QuJjqUXeV4mbdvl7gWgtoOqK8kLJDTwtdXjHKP9t4VZw4sH8
         JteE8EmiK0MZY3vtZMqaL9czsUo8UBInW+vLt/b3hWIb6lsVticvZRDG10cC7klEKQ3w
         e4ozHW7zeMO+d5sUSnZI+qemGj+Ib31/+miSvedbiVTh+YMfOUjtIuAAaB01LuCQZP9y
         dPYo1n+/A77fdgVLu8VfaoijDM6mkSePkVoX4rv8/+cP2luqptm7/n1p9ptLiVDZ3jMt
         UJ9A==
X-Gm-Message-State: AOAM5320F4nF2QwETQxbJCQa7Bv8gTknC8jGKA5F5Nyp/IwfVJnWA4gn
        f7r2s20zNK0s/2IYJLziZo0MQOiYkPZ2
X-Google-Smtp-Source: ABdhPJwaTkI0K6uPSEaplsxQlreq8AD+Dz+zNZYPRknZImS8P1My41HVmpsga1+R48PTEbxwiobnaQ==
X-Received: by 2002:a05:620a:4448:: with SMTP id w8mr3287282qkp.622.1640203804256;
        Wed, 22 Dec 2021 12:10:04 -0800 (PST)
Received: from localhost (pool-96-237-52-46.bstnma.fios.verizon.net. [96.237.52.46])
        by smtp.gmail.com with ESMTPSA id a16sm2500659qta.94.2021.12.22.12.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 12:10:03 -0800 (PST)
Subject: [PATCH] selinux: minor tweaks to selinux_add_opt()
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Wed, 22 Dec 2021 15:10:03 -0500
Message-ID: <164020380312.90681.9455892274206356279.stgit@olly>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Two minor edits to selinux_add_opt(): use "sizeof(*ptr)" instead of
"sizeof(type)" in the kzalloc() call, and rename the "Einval" jump
target to "err" for the sake of consistency.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8ef63b7af855..904f9c23f0f6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -972,14 +972,14 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 	struct selinux_mnt_opts *opts = *mnt_opts;
 	bool is_alloc_opts = false;
 
-	if (token == Opt_seclabel)	/* eaten and completely ignored */
+	if (token == Opt_seclabel)
+		/* eaten and completely ignored */
 		return 0;
-
 	if (!s)
 		return -ENOMEM;
 
 	if (!opts) {
-		opts = kzalloc(sizeof(struct selinux_mnt_opts), GFP_KERNEL);
+		opts = kzalloc(sizeof(*opts), GFP_KERNEL);
 		if (!opts)
 			return -ENOMEM;
 		*mnt_opts = opts;
@@ -989,27 +989,29 @@ static int selinux_add_opt(int token, const char *s, void **mnt_opts)
 	switch (token) {
 	case Opt_context:
 		if (opts->context || opts->defcontext)
-			goto Einval;
+			goto err;
 		opts->context = s;
 		break;
 	case Opt_fscontext:
 		if (opts->fscontext)
-			goto Einval;
+			goto err;
 		opts->fscontext = s;
 		break;
 	case Opt_rootcontext:
 		if (opts->rootcontext)
-			goto Einval;
+			goto err;
 		opts->rootcontext = s;
 		break;
 	case Opt_defcontext:
 		if (opts->context || opts->defcontext)
-			goto Einval;
+			goto err;
 		opts->defcontext = s;
 		break;
 	}
+
 	return 0;
-Einval:
+
+err:
 	if (is_alloc_opts) {
 		kfree(opts);
 		*mnt_opts = NULL;

