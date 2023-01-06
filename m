Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2BAC54EBD
	for <selinux@archiver.kernel.org>; Fri,  6 Jan 2023 20:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjAFUa6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 6 Jan 2023 15:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjAFUa5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 6 Jan 2023 15:30:57 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067393C729
        for <selinux@vger.kernel.org>; Fri,  6 Jan 2023 12:30:56 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id c6so2852321pls.4
        for <selinux@vger.kernel.org>; Fri, 06 Jan 2023 12:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IExa2o8Boa9pjE5Orm4ScbWwYDm4momCaLQlE8pNxzg=;
        b=fmQL/ZDCbRSR6Yf3pC3jbj4vR1v7x3506n44zHHZyqq56aULBpt0dqEDdzn4JJz4AN
         7u83tfulXb3XFYt+dPS8T9LG73DJNZmRNG6BaJgLHOfLa1JVY2EKpqP1Yr4w9XRTJcT4
         siWuiwXCCG3GlIjeP5nCQ4S6oB+Q74h0KxRzD042YfnOk/IZjY9whcpEZa1vLp0N3IhP
         pUp00BsnDLtF6i8ltUgB+DLmF6Bdk8CU8374zTSHPOl5DITi0HiBx78cJ315stbXnR6c
         opteBNScRTe6nFF3sIj7FTKn7uUQ10uGU6ISzCEbyZLN3Us2zF7jT6MDmP0XLIn2vrod
         qZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IExa2o8Boa9pjE5Orm4ScbWwYDm4momCaLQlE8pNxzg=;
        b=4S+EWl7qQsowAE4mPs5vP6j3f+y/i1YBcd5ZcIwJ0gEnM0mcETldgRXGDtSRnecyP3
         bAAvBlZ6mITsVlGxvVvSJ4tovDmtCb93g0UD9JS/QLF1usKvih5x8KKvo8u3gi2x9Nq/
         gQ1mStezRM8acda3i7SL8gh6OAP1v+E2EiQih5R3RRo7veQlaJ8i/0Y9n972H/xZYXqK
         274kTaxWjaUDTbpzq9Na4zlR5smYrrZltA29RuV2BM1Fa2+6wj9QKX4Yqd8wuGJLxq2G
         liycn4u/+qARHwmOTPcQCoiNRN/yMfwU6HkeP+TrV3x/J1FAutipbow8rjn3ANvZtjgG
         0CAQ==
X-Gm-Message-State: AFqh2krjMoW3InpBTsNk+nSY0es0Z0hYrYOFhRd4Kll6dd9OkxkR1tWc
        FBEnHZBNDkYR0OyBiJp7QQNNlVNQhnrUmOhGCbqQ
X-Google-Smtp-Source: AMrXdXsqcUbWqkh7g8y2KuCTUSGRtxuwfWoG9onPrk0zc3IKjZWGbyEU34N95hNt2F3AGw0AN97qk7oLhiRy26DMos0=
X-Received: by 2002:a17:902:cec8:b0:192:6675:8636 with SMTP id
 d8-20020a170902cec800b0019266758636mr2899362plg.15.1673037055482; Fri, 06 Jan
 2023 12:30:55 -0800 (PST)
MIME-Version: 1.0
References: <20221213033948.73512-1-alexander.kozhevnikov@huawei-partners.com> <20221213033948.73512-2-alexander.kozhevnikov@huawei-partners.com>
In-Reply-To: <20221213033948.73512-2-alexander.kozhevnikov@huawei-partners.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 6 Jan 2023 15:30:43 -0500
Message-ID: <CAHC9VhRHK19tn4wepQsSk2sJKqeoO3Wv7niMePjzk0BFkpra=A@mail.gmail.com>
Subject: Re: [PATCH 1/1] [RFC] SELINUX: Remove obsolete deferred inode
 security init list.
To:     Alexander Kozhevnikov <alexander.kozhevnikov@huawei-partners.com>
Cc:     linux-security-module@vger.kernel.org,
        jamorris@linux.microsoft.com, selinux@vger.kernel.org,
        stephen.smalley.work@gmail.com, artem.kuzin@huawei.com,
        hw.likun@huawei.com, xiujianfeng@huawei.com, yusongping@huawei.com,
        hukeping@huawei.com, konstantin.meskhidze@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Dec 12, 2022 at 10:40 PM Alexander Kozhevnikov
<alexander.kozhevnikov@huawei-partners.com> wrote:
>
> This patch is a proposed code optimization for SELinux:
>
> 1) Each inode has SELinux security structure attached
>    to it, this one need to be initialized at some point.
> 2) This initialization is done by the function
>    inode_doinit_with_dentry ( ).
> 3) In the kernel releases started from some point in the past
>    this function (2) is always called normally from function
>    __inode_security_revalidate ( ).
> 4) Which in turn is always called  from inode_security ( ), which
>    is a base point for any selinux calls and always called on
>    any access to any inode except a few special cases when
>    _inode_security_novalidate ( ) is used.
> 5) Inode security structure initialization can be done only after
>    SELinux is fully initialized and policy is loaded.
> 6) So, for this purpose there was a special defeferred inode security
>    initialization list protected by a spinlock implemented, which was
>    populated instead of isec initialization in function
>    inode_doinit_with_dentry ( ), if it was called before SELinux full
>    initialization, and processed at the time when SELinux policy load
>    occurred by calling again inode_doinit_with_dentry ( ) on each inode
>    in this list.
> 7) This list was a part of a default initialization logic before (3) was
>    implemented, but now, taking into account new mechanism implemented
>    with current approach of inode security revalidation on each access
>    (4)-(3)-(2), it looks obsolete and not needed anymore.
> 8) So deferred initialization, this list and code associated with it can
>    be safely removed now, as anyway, if inode isec was not initialized
>    before it will be processed on any next inode access.
> 9) Another case for calling inode_doinit_with_dentry( ) is when a new
>    dentry is created. This is done by call from d_instantiate( ). When
>    the deferred initialization list is removed it would be useful to
>    also check for SELinux initialization status here before calling
>    inode_doinit_with_dentry( ) like it is done in
>    __inode_security_revalidate( ).
> 10) There are two possible positive consequences from this removal:
>      a. More clean and simple code, less memory consumption;
>      b. This deferred initialization in some cases (for example SELinux
>         was switched on manually after system was up quite a long time)
>         could take some significant time to process, i.e. system looks
>         hung for some notable time. And now this is avoided.
>
> Signed-off-by: Alexander Kozhevnikov <alexander.kozhevnikov@huawei-partners.com>
> ---
>  security/selinux/hooks.c          | 91 ++++---------------------------
>  security/selinux/include/objsec.h |  3 -
>  2 files changed, 11 insertions(+), 83 deletions(-)

Merged into selinux/next with some minor style and grammar fixes,
thanks Alexander!

-- 
paul-moore.com
