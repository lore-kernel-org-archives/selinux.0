Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC120C433EF
	for <selinux@archiver.kernel.org>; Wed, 17 Nov 2021 01:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A723260EC0
	for <selinux@archiver.kernel.org>; Wed, 17 Nov 2021 01:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbhKQCBn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Nov 2021 21:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbhKQCBi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Nov 2021 21:01:38 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0415C061208
        for <selinux@vger.kernel.org>; Tue, 16 Nov 2021 17:58:35 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id e14-20020a05622a110e00b002b0681d127eso874112qty.15
        for <selinux@vger.kernel.org>; Tue, 16 Nov 2021 17:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=Y1ZDTiUbWWm2WOPHxQC9exCfsXMznkrWWKCtdqB+d9Q=;
        b=ZSwcSSRvszaMFXK0kDp/c8khljaNv/GsQPzKoqbtIg/75qdwj78g5H1jCuNC8Ap1CW
         QL7LTMkoZ+JONOA2i20+4DzIAekL4iyDT+jVp+8moDkwgDgX+eanUznhaH64+ytQjBYU
         OynsJKHjOaS8BR0OjpG0kKUgzWMIiirNA43RTvms7NUpoT8gnv2nsx7iX253nT9mhSpj
         7ljv9YxEl+UWWRDy2Fhrb7vpygjV7EnUro4qmIphmwFmqwycL7P3AbQuyVXfnNFT/0Jg
         m/J5ecHQpZxbXPKD1ghJpGSkmb+oYTKruIhH0EiCuMy8DJqVJIsT91dlLzuoDHjY8pQW
         AaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=Y1ZDTiUbWWm2WOPHxQC9exCfsXMznkrWWKCtdqB+d9Q=;
        b=iJq1vRzQlHPunadRm5aJ795re3L5NJuK8qYibc9ZtxoW/cll7E7PHXbEpZq9k1W4C3
         +ngNn+EbgBq8pURZPThiBwWE4XX1qIkD2L0AB6hiOkIbbwJXO1xqYYP1irsp4Au/jjTe
         4v+6uaRhR3cnQawDvdCdwQaEM0RkoA93MijKW75Nb9XWvSG4KMxJxHiZBElm0plL6FXl
         BPmC2Rft+iqqnfH/GVgeJLd2rtsQJaRG3itNny8bsoNJ/3gGp65cNI9RyYcOKaxaPyFr
         a4EFst1vPTFHUY5v8t2eWVBrz7lqHkqIQzDTXJXrS7PjMisvc8O4mG1JPjOAqjdCpc5L
         8lGg==
X-Gm-Message-State: AOAM530mzFZDoqo90/1DxmIhrx6n232rIarnLdPrTtSFlHgx3Cg49bHC
        MUNYAmixvYFU9wxqlIEcmjYOFuKVrzWJ
X-Google-Smtp-Source: ABdhPJwxrHwDA+VKRPbupbiI0fCXobjeyaeFRWsoptkdXMLB5k6KWAJN1mj/Z4sXRVaikpPiNku2+gFrOFAs
X-Received: from dvandertop.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2862])
 (user=dvander job=sendgmr) by 2002:a05:622a:1a9b:: with SMTP id
 s27mr12566935qtc.417.1637114314814; Tue, 16 Nov 2021 17:58:34 -0800 (PST)
Date:   Wed, 17 Nov 2021 01:58:06 +0000
In-Reply-To: <20211117015806.2192263-1-dvander@google.com>
Message-Id: <20211117015806.2192263-5-dvander@google.com>
Mime-Version: 1.0
References: <20211117015806.2192263-1-dvander@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v19 4/4] overlayfs: inode_owner_or_capable called during execv
From:   David Anderson <dvander@google.com>
Cc:     David Anderson <dvander@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Mark Salyzyn <salyzyn@android.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, kernel-team@android.com,
        selinux@vger.kernel.org, paulmoore@microsoft.com,
        Luca.Boccassi@microsoft.com
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: John Stultz <john.stultz@linaro.org>

Using old_creds as an indication that we are not overriding the
credentials, bypass call to inode_owner_or_capable.  This solves
a problem with all execv calls being blocked when using the caller's
credentials.

Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Signed-off-by: David Anderson <dvander@google.com>
Fixes: 05acefb4872da ("ovl: check permission to open real file")
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-unionfs@vger.kernel.org
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: kernel-team@android.com
Cc: selinux@vger.kernel.org
Cc: paulmoore@microsoft.com
Cc: Luca.Boccassi@microsoft.com

v19 - rebase

v18 - rebase

v17 - rebase

v16 - introduced fix over rebased series
---
 fs/overlayfs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 11d8277c94cd..586de55bba79 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -55,7 +55,8 @@ static struct file *ovl_open_realfile(const struct file *file,
 	if (err) {
 		realfile = ERR_PTR(err);
 	} else {
-		if (!inode_owner_or_capable(&init_user_ns, realinode))
+		if (old_cred && !inode_owner_or_capable(&init_user_ns,
+							realinode))
 			flags &= ~O_NOATIME;
 
 		realfile = open_with_fake_path(&file->f_path, flags, realinode,
-- 
2.34.0.rc1.387.gb447b232ab-goog

