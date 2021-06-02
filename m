Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048C1C47083
	for <selinux@archiver.kernel.org>; Wed,  2 Jun 2021 05:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF3A361361
	for <selinux@archiver.kernel.org>; Wed,  2 Jun 2021 05:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhFBFtv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Jun 2021 01:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhFBFtv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Jun 2021 01:49:51 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C55EC061574;
        Tue,  1 Jun 2021 22:48:07 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id b15-20020a17090a550fb029015dad75163dso1110357pji.0;
        Tue, 01 Jun 2021 22:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=c7MkMWKFtmiiVwlpdWYeE/xiL6bpeZSYnEXl6lxBbgE=;
        b=ukjO1KdFh+9m9UoJKbxNcsYRNDPpYljr/9FC0nsfh7rt4wChNgtZLryyJELpWTYcuR
         KPdiz+CJ3ygtvoZzd97ZErBx/W34yb6Ryq8m+x+4EyZvPh321o+8HMxePenhqpStVXz7
         vL/TOzRUtH0gxeJrzftIu3hbXmb5AzZf8vYchlfRoyQdplMvbQp+rjMAkxEe5k4sSlq3
         51fXE87RXeUMAfhrUaPgJ2ZLxl7CnG9WhKLBb9i5w3uthAp3f3bv7Us6qiRlJq14edZm
         orQwOja8ddzJ7TU+AMx9KHwtD/rapUAGaptnzpO/Ed94lyZJt0TSp7BtYpRn2smWuJE0
         Lrnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=c7MkMWKFtmiiVwlpdWYeE/xiL6bpeZSYnEXl6lxBbgE=;
        b=lHnag4PS9uFdbzutDOqp3CzX5FVIx37OIruVhDQAo0qZ4BQiKTSs7Q8UcpJHoq3QUH
         ABjDdaBcGxZEIqre98tqV1sXTVdaEjB/0JWW3u8IKO775zxz6w4MaUmu1acBrMyo5qwe
         3QqCWjwYQTCasqUpA2y2/RoH3oW8mSg+HcSKrGs8Y9XZ0jjUFgHmRygLRhs5Xt986VVn
         tuDRrjlBhJ5khK0ntXN7AikXEncIz7EoaKoPq7JhVjnzJ/eXp03lwt/twdkuqck6J10J
         Y1RysEAoVrzLfVuUX6H+rggSy6PsmQLQeXnG0DWE1i0subdAwienR33AOVRSn6iW83z3
         wZEQ==
X-Gm-Message-State: AOAM533AAFgLs5mUNbkrL3HtY0078cRR9uQkKiBHQesHH07XIxrH/cQg
        6WeMdfNe0Qs5UHybNn66UG4=
X-Google-Smtp-Source: ABdhPJw34DkhCzWHxKxUZ9JZXjtSpSJdliUtYtn01ajOfTEkGjKvv1oYkwo18/7a7jLasD/zmqeSbQ==
X-Received: by 2002:a17:90b:234d:: with SMTP id ms13mr5410642pjb.135.1622612887022;
        Tue, 01 Jun 2021 22:48:07 -0700 (PDT)
Received: from raspberrypi ([125.141.84.155])
        by smtp.gmail.com with ESMTPSA id n9sm14835961pfd.4.2021.06.01.22.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 22:48:06 -0700 (PDT)
Date:   Wed, 2 Jun 2021 06:48:02 +0100
From:   Austin Kim <austindh.kim@gmail.com>
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        austin.kim@lge.com, kernel-team@lge.com
Subject: [PATCH] selinux: remove duplicated LABEL_INITIALIZED check routine
Message-ID: <20210602054802.GA984@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The 'isec->initialized == LABEL_INITIALIZED' is checked twice in a row,
since selinux was mainlined from Linux-2.6.12-rc2.

Since 'isec->initialized' is protected using spin_lock(&isec->lock)
within various APIs, it had better remove first exceptional routine.

With this commit, the code look simpler, easier to read and maintain.

Signed-off-by: Austin Kim <austindh.kim@gmail.com>
---
 security/selinux/hooks.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index fc6a3ab7e179..a236b0a33665 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1448,9 +1448,6 @@ static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dent
 	struct dentry *dentry;
 	int rc = 0;
 
-	if (isec->initialized == LABEL_INITIALIZED)
-		return 0;
-
 	spin_lock(&isec->lock);
 	if (isec->initialized == LABEL_INITIALIZED)
 		goto out_unlock;
-- 
2.20.1

