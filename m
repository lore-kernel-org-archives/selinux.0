Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3429AC4361B
	for <selinux@archiver.kernel.org>; Tue,  8 Dec 2020 23:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E62B523A5A
	for <selinux@archiver.kernel.org>; Tue,  8 Dec 2020 23:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731773AbgLHXmL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Dec 2020 18:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731748AbgLHXmK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Dec 2020 18:42:10 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D002C06179C
        for <selinux@vger.kernel.org>; Tue,  8 Dec 2020 15:41:30 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id b73so6250edf.13
        for <selinux@vger.kernel.org>; Tue, 08 Dec 2020 15:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0styejjvaAGmzemOZ5MgVk/FxItoWovN4p8t1k68Ido=;
        b=zQ9miL8kae4D2P0vHCXxyu6zOLNOtsMXBhVjDzSeDAgWDgQezVOte9VFwMnx0nJFF6
         W2W1++Tp0cqsk14cyNspQDcpKVeuChDDiv6r6hRB53n9YF6AJWWyachsJXXvs/FmcT2d
         tiKKG49oNDAx3Dfd5s7Uvnrr6wrmsyRzGcgflUNMFd1NTSHrXCLBVeUSvgak8SsEY9Ms
         gTC/ktstcbpYkqzBLGb52MSTAOY8QY+PAmfun9yn8qyH1hFwUIoRcnHy54jMGHDemWSn
         oHiy3sdklNTw4k7QZEXXOhwjv5AtQZPKbp6U2H2HW0NNed2mAxUE3wkRfSFzkB0onVLQ
         ADqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0styejjvaAGmzemOZ5MgVk/FxItoWovN4p8t1k68Ido=;
        b=R26pwF0ARfP6n/52y68rc7NvdwQmzppinqdlqlMzUggG8gVBN1oXrLa3kAPGAnoTCw
         xSy3R/nkyM6Btx6X/4q/FBbwCjSxBzwh+yCj5znXHKQ0WYts28CQ25RD5yLsGBiMLNNY
         ga7XEzlXH7vOgKFoDUmxc4AnRuyZEHDUGQTEIV8yNywW6V5Jubyy4LY0nnKh4+Z3qpBv
         zt8gb67kovtWcJLBf4nx5o/G1cMegvFL7BM+WR/2WNOB1gwkKxO1FG2hICVm6Gdsxo/c
         vSnBM+VB3j++XC5Jshgg0lbU6WGS/doudPaEeKEgwgq3zbjZX8/IEvYLFpR0M95/aYaE
         Zwig==
X-Gm-Message-State: AOAM530f+rQ3qV2Fjf3e93nmVAvycYIBipDd94+87miDU5Pvi1d2l/LW
        2xaUhM22iP2zI+0KG+R8zZQGJHi8LYFjDmzxR27n
X-Google-Smtp-Source: ABdhPJzHlU4UpwUzqg11zhEI6bUD1V1aoYiay4Hp1SkiE25rgoxmkUijslZqutsWnLJfRPm8pvRZf720v3sPEV5mje8=
X-Received: by 2002:a05:6402:10ce:: with SMTP id p14mr354875edu.12.1607470889147;
 Tue, 08 Dec 2020 15:41:29 -0800 (PST)
MIME-Version: 1.0
References: <CAFqZXNsGabHBfV36nNAVLJgEzjkBev-O3YZ1vnmXyVoaDdjiHQ@mail.gmail.com>
 <CAHC9VhRCu5W4YOzcidUhv7biVc+a4QrRknVn-57YVSM3vWZH+Q@mail.gmail.com> <20201207205209.GD3107@redhat.com>
In-Reply-To: <20201207205209.GD3107@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 8 Dec 2020 18:41:17 -0500
Message-ID: <CAHC9VhTHXxZRKaUybvLzPMFLP08co9e6yNjB3upVJyCPbh3=+g@mail.gmail.com>
Subject: Re: virtiofs and its optional xattr support vs. fs_use_xattr
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Zdenek Pytela <zpytela@redhat.com>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Dec 7, 2020 at 3:52 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> On Mon, Dec 07, 2020 at 10:03:24AM -0500, Paul Moore wrote:
> > On Mon, Dec 7, 2020 at 9:43 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > Hi everyone,
> > >
> > > In [1] we ran into a problem with the current handling of filesystem
> > > labeling rules. Basically, it is only possible to specify either
> > > genfscon or fs_use_xattr for a given filesystem, but in the case of
> > > virtiofs, certain mounts may support security xattrs, while other ones
> > > may not.
>
> [ cc virtio-fs list and miklos ]
> > Quickly skimming the linked GH issue, it appears that the problem
> > really lies in the fact that virtiofs allows one to enable/disable
> > xattrs at mount time.  What isn't clear to me is why one would need to
> > disable xattrs, can you explain that use case?  Why does enabling
> > xattrs in virtiofs cause problems?
>
> Its not exactly a mount time option. Its a virtiofs file server option.
>
> xattr support by default is disabled because it has performance
> penalty. Users can enable it if they want to.

Oh the number of sins against security that have been committed under
the banner of performance! ;)

Regardless, thanks for the explanation, that helps.

-- 
paul moore
www.paul-moore.com
