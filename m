Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A5EC47083
	for <selinux@archiver.kernel.org>; Wed,  2 Jun 2021 14:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D948613AA
	for <selinux@archiver.kernel.org>; Wed,  2 Jun 2021 14:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhFBOeS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Jun 2021 10:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhFBOeP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Jun 2021 10:34:15 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF94CC061574
        for <selinux@vger.kernel.org>; Wed,  2 Jun 2021 07:32:18 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id gb17so4165255ejc.8
        for <selinux@vger.kernel.org>; Wed, 02 Jun 2021 07:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9NEzqXEUZcOuaAjPBHdBD3YzSrWcsSUbM7pL6pp882Y=;
        b=HM2JLmp+cb2rdJXbwwCHeQpd+Dc/h/jgkm546CJQyOo/Cg+mQEP++Ynlso1n0rM02m
         pEMLMG67U3tbON5cmtQw8jB0X+Ur2Qc7EnKKvXkYxLC3uVTQCb6jBOy6+2c/jDavAh2e
         Ot5T7WWmE5G//I0VeNunVTc6qGFGMCB/dV3Shz94igkiZQNM1P3gTjKMKSCGDSyHUZHJ
         BrJVmsru/YODLzr2F+YBY5y7rOb6NCTjJUiajyYOzXIzm/XDLuEaP0/35G9Hy5e5Auah
         4SLAKXMJkyY+YGh3dY0EFxjiHdziTwKL9aQn4ehlj6msJTCbmWWi4EnHFQI5J6/YNObK
         iDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9NEzqXEUZcOuaAjPBHdBD3YzSrWcsSUbM7pL6pp882Y=;
        b=mPl84RUxHvSME1dJPeKUYe0VmUaz6tkGp470J1+a60vk41LsPIe7rwf/emRPrJInZC
         DyasA9sSoBtXdhOJD9ckKm03b0/XcmV0oTd7y4bCAHOJykbtkH4X9j6Yb7PUzWQENwxJ
         kUCZYdXriCTcq2h0dMz+mSHoPS1CQnR0jN58AtvaZGgCiEUkLTI/oVdl2QU0AumyJ4ag
         Y5zppsoVcBJ9oM9i+p9GUpBU8h2C0sd3E7Zx8ZhsO4DE2DL3VEwfsEectPVFEVZVKzpl
         G6VOSUOlF4tIn+KrOCwRq9rnVLD2IZFcbGstb9knyQGsOUZyjuoRpm7u5gTu55kKmf4e
         nx2w==
X-Gm-Message-State: AOAM530DyXjER2dafa6tE8KwPt+4BUlUUII9t9Ows35O9QJVicKpuvsi
        kYCtzHEQLkyNhutiU4hHPmsELA3yJT74lz/46iDO
X-Google-Smtp-Source: ABdhPJzhO5ghggXAHF+13y+zCETq5Suqlx0WNmIIHDe7WqLHXUgME/QTDQF5pXr+zsiWnZeNHENS6Haw1zOJx/cqvjg=
X-Received: by 2002:a17:906:1113:: with SMTP id h19mr25232518eja.398.1622644337403;
 Wed, 02 Jun 2021 07:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210602054802.GA984@raspberrypi>
In-Reply-To: <20210602054802.GA984@raspberrypi>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 2 Jun 2021 10:32:06 -0400
Message-ID: <CAHC9VhQdAt2EQqP3pQM=5TifTYuXxnU1QOvOT-aFaDaGiLLJXQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove duplicated LABEL_INITIALIZED check routine
To:     Austin Kim <austindh.kim@gmail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, austin.kim@lge.com,
        kernel-team@lge.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 2, 2021 at 1:48 AM Austin Kim <austindh.kim@gmail.com> wrote:
>
> The 'isec->initialized == LABEL_INITIALIZED' is checked twice in a row,
> since selinux was mainlined from Linux-2.6.12-rc2.
>
> Since 'isec->initialized' is protected using spin_lock(&isec->lock)
> within various APIs, it had better remove first exceptional routine.
>
> With this commit, the code look simpler, easier to read and maintain.
>
> Signed-off-by: Austin Kim <austindh.kim@gmail.com>
> ---
>  security/selinux/hooks.c | 3 ---
>  1 file changed, 3 deletions(-)

This is a common pattern when dealing with lock protected variables:
first check the variable before taking the lock (fast path) and if
necessary take the lock and re-check the variable when we know we have
exclusive access.

In the majority of cases the SELinux inode initialization value goes
from LABEL_INVALID to LABEL_INITIALIZED and stays there; while there
is an invalidation function/hook that is used by some
network/distributed filesystems, it isn't a common case to the best of
my knowledge.  With that understanding it makes perfect sense to do a
quick check to first see if the inode is initialized in
inode_doinit_with_dentry() and return quickly, without taking a lock,
if it is already initialized.  In the case where the inode has not
been previously initialized, or has been invalidated, we take the
spinlock to guarantee we are not racing with another task and re-check
the initialization value to ensure that another task hasn't
initialized the inode and act accordingly.

The existing code is correct.

-- 
paul moore
www.paul-moore.com
