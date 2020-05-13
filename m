Return-Path: <SRS0=fYOO=63=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6B8C2D0F8
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 00:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68F6320769
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 00:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="e8zHmwJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731619AbgEMATv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 May 2020 20:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731579AbgEMATv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 May 2020 20:19:51 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1458CC061A0C
        for <selinux@vger.kernel.org>; Tue, 12 May 2020 17:19:51 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id bs4so6383608edb.6
        for <selinux@vger.kernel.org>; Tue, 12 May 2020 17:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZJQDVP0NTLzp1pMoSvccNQtV7irlK9esrQ+2J19JgPA=;
        b=e8zHmwJw7d1PENdzcZs+QTZEYcCkP7w/G7qPhR2QMOfvxy3ubzWiXBFVaV5dFiAK6S
         bMcwc0hZvbJKBswC21DxY+eb9gLkYDIVx1316d5KvRGiXBY66kNrmAzkNQJLPBR2jMHR
         JUZcW1U1jRBkioI/yE1oZI9po69ZhEwLHk24gdSfMEDaPz/BH2HiSUv7ytkqonEqpKoV
         pXpfKJXHSTK+Y07/WmElRVF6EuFWcP9fwF6iBffZmX3vi9Uv1aoI7T2bytJABJQdXFbf
         TOgFz5CqNJ0idoQddvX8e09i6tKutdKLv9UEpg2aEwSdCElq9fQHbrUaaU9X2+gRoel9
         +hfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZJQDVP0NTLzp1pMoSvccNQtV7irlK9esrQ+2J19JgPA=;
        b=lud7tDZY2TZYWr5waNHp1IW6/wANwIcZnWery5Te5EVh6m/OgQG9TBXhAh8A2/rcfJ
         d8qCJQgJo3U0c8Cz64f8ns7dYxU+puCGuYoK7okxPuirb5x46ygCRACJxfkdbiWHkRVL
         xoKAnEX4yZXjJw9EsC9/W/1jsKrBJkF9yenitZN3Ihek2mLcD0suAfPHpQbxOqgHplhF
         CbX3Ay+4Jv4Mg6+a67DQbMkmR0if2ESqu0mUiMC0VAyMU+3sl6PMoq78dSD2hZQY+Avy
         xBxE2gntee62phYxfTK3s8Lxu6Nm7Sh/fvQchIeud0CfSeK3jkKRqOkWkW5LPUgJwFQH
         ufYA==
X-Gm-Message-State: AGi0PuYjBX7SCZXlWPPAm0u8m5Fk+nS4GCedwU4MekcJQfWLck709rwx
        9qSxNHCCAuVfAMrcgx1q9GWqtY69JY5eCBRhLpIr
X-Google-Smtp-Source: APiQypKdMjK0XWowk43GU6bihKqkbeOChmOVpiS3FVfoIUj3emgPGbk9F6f41b7RLKyQCdkJUL9ZmHJ7WqZzRPBrB3c=
X-Received: by 2002:a05:6402:1adc:: with SMTP id ba28mr20168196edb.12.1589329189703;
 Tue, 12 May 2020 17:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200509111852.29812-1-yuehaibing@huawei.com>
In-Reply-To: <20200509111852.29812-1-yuehaibing@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 May 2020 20:19:38 -0400
Message-ID: <CAHC9VhTcBGUzEo4_aw15jM7kZNWzNktBA2iBNOAbdP1dHZLb5Q@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: netlabel: Remove unused inline function selinux_netlbl_conn_setsid
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, tglx@linutronix.de,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, May 9, 2020 at 7:19 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> There's no callers in-tree.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  security/selinux/include/netlabel.h | 6 ------
>  1 file changed, 6 deletions(-)

This appears to go back to the original SELinux/NetLabel hooks.  Wow.

Thanks for the patch, it's now merged into the selinux/next branch.

-- 
paul moore
www.paul-moore.com
