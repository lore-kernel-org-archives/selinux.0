Return-Path: <SRS0=EYrt=7J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EE1C433E0
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 08:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A22D2084C
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 08:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7wrEB4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbgE0IXn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 May 2020 04:23:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57776 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729292AbgE0IXm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 May 2020 04:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590567819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dev/QFDSBLgjOKDuw4i5Evy3pMaC69lfhqx3YnbEStM=;
        b=f7wrEB4t7Olqf0f9kabYimQQLDCiZ28o6+VP8BEhenScFroxKskNTsv4lU7Xahq5UOb073
        //Em0mFh5X6iD1bkn2kid47o/zP89S4rTIvVZyLYUVQmdbxZ4ZFMlCODjgvUz6Fw+ZN+b3
        g/YzduH/ecSzNHRaSP/ASQpUAr4ogG0=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-mEGEkm2SMRyLeeYlc8jiFQ-1; Wed, 27 May 2020 04:23:31 -0400
X-MC-Unique: mEGEkm2SMRyLeeYlc8jiFQ-1
Received: by mail-oi1-f199.google.com with SMTP id 203so12713887oie.19
        for <selinux@vger.kernel.org>; Wed, 27 May 2020 01:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dev/QFDSBLgjOKDuw4i5Evy3pMaC69lfhqx3YnbEStM=;
        b=OEnNNnDNt06LatgY8s5NxYbpto4ISAgZ2ncmSn7IWSLQITxAhjlmaNDi3yBb41rX89
         ak4GBJmj1RBrIwpozWKmwaB4/aS8jlATgPQpZaVNrVFxAgvhdZqJ/wDZyCDrDrAl0qly
         e2wpLSSSF/XSOsxMwqUQOns0KC2gbJTdiaXDuBZIV3UztNTGzVn+Ncnj7aQPcn2wd5Yp
         o7+Pga7l4mUKN+L8t0JXCry5DnHM92Gyh+546FlOsF4L8X0keHvPRcsCE8EpzC6kCRaR
         ekphjzVhIzNO8YOEvLURKVWKZ87J9mNZYvpLNgJ4gDL60JZ123lzV8m/lEIQFOaBnRXm
         0uDg==
X-Gm-Message-State: AOAM530juZY0W86+yI8VD2td4KfZ+0ALfXLNA8Qu8tDa7Q6KOSxXCzUw
        OJimIxTlAe7Dy5KxQtPlEpGCTeg394x2rfTI2Daxm28yc2o4yGDw8f9qgbylk0ctjcv8qRt4g5N
        Nz931CjKvvOL1vcCUyqbdcd4HGkTHTcM1Pg==
X-Received: by 2002:a9d:23f5:: with SMTP id t108mr3848637otb.66.1590567811144;
        Wed, 27 May 2020 01:23:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMNx2TznD4B64U/ePxgo1L8zc71IRvBTzo2zjQStT7O/gzIOuyjmijMhzqi0d3N5ds9vVWNqTat+gY6AmCdE8=
X-Received: by 2002:a9d:23f5:: with SMTP id t108mr3848629otb.66.1590567810881;
 Wed, 27 May 2020 01:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200523195130.409607-1-jlebon@redhat.com> <CAFqZXNsuJ7S9zFhHBJNJxUr4=_ZGmKdzTU29PrWRuziMfJJkGQ@mail.gmail.com>
 <CACpbjYqBL3a6iVuN9NGzLLHdENC-EXNsNikJZsEhpvCkCGEM2A@mail.gmail.com>
In-Reply-To: <CACpbjYqBL3a6iVuN9NGzLLHdENC-EXNsNikJZsEhpvCkCGEM2A@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 27 May 2020 10:23:19 +0200
Message-ID: <CAFqZXNtXHxv6RzgEc_nzHdaGpOEGzMzMe=k_P23VgC-9ftPeVQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: allow reading labels before policy is loaded
To:     Jonathan Lebon <jlebon@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 26, 2020 at 9:12 PM Jonathan Lebon <jlebon@redhat.com> wrote:
> On Mon, May 25, 2020 at 1:14 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > I might be missing something, but couldn't you achieve the same by
> > simply adding something like this in here:
> >
> > if (!selinux_initialized(&selinux_state))
> >         return -EOPNOTSUPP;
> >
> > (Or by adding it to the condition above.)
> >
> > Then you should hit this condition here and be all set:
> > https://elixir.bootlin.com/linux/v5.7-rc7/source/fs/xattr.c#L337
>
> Hi Ondrej,
>
> Yes, that looks promising. Two questions with that approach:
>
> 1. Is there a concern here with transiently returning -EOPNOTSUPP even
> if the SELinux LSM does technically support the inode_getsecurity
> hook? I'm thinking of potential corner-cases down the road where
> somehow this knowledge is cached.

I would hope not. I don't think it's likely this would be cached,
since it would require a guarantee from all LSMs that they won't flip
from -EOPNOTSUPP to something else... That would be error-prone IMHO.

>
> 2. The selinux_inode_getsecurity hook today does somewhat handle the
> uninitialized case. It ends up here:
>
> https://elixir.bootlin.com/linux/v5.7-rc7/source/security/selinux/ss/services.c#L1322.
>
> Specifically, it has support for initial SIDs. The patch I wrote
> purposely tries to allow falling back to that logic. Is there a
> concern with short-circuiting this logic even if the inode SID somehow
> isn't SECINITSID_UNLABELED?

Oh, right, so that's what I missed :) I'll have to defer to Stephen on
whether this is a concern... Obviously we lose the previous behavior
of returning the initial SID strings via getxattr(), but I'm not sure
if that's significant. Since those strings obviously aren't real
contexts, it seems they only serve an informational purpose.

Anyway, I looked at the original patch again and it generally looks
sane. I don't like the fact that we need to call back to
__vfs_getxattr() in yet another place, but it makes sense since
security_inode_getsecurity() is basically overriding it. So I leave it
on Stephen or Paul to decide which is better.

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel,
Red Hat, Inc.

