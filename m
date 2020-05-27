Return-Path: <SRS0=EYrt=7J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC406C433E0
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 13:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB76B207CB
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 13:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKmO3CLF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388404AbgE0Nhh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 May 2020 09:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387682AbgE0Nhe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 May 2020 09:37:34 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9F3C08C5C1
        for <selinux@vger.kernel.org>; Wed, 27 May 2020 06:37:34 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id a68so19134595otb.10
        for <selinux@vger.kernel.org>; Wed, 27 May 2020 06:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gWrn0ZzoLGU+0s2/NF6+EKuwvJ9nKhht4luvoBZquWg=;
        b=cKmO3CLFcqz7y82y4fNrZv97ott0aHBQ3ZdHlxY//1FElQ1OwoNmTfgdnxWnafaGDI
         vu87iYG4oGeyfuTa1YK/fRSjzGbyDBeZlyRYJic5b4xj8RcxZPewD4+coKQyJv4qY1D2
         CG/xXijToXIQNjdjqT1Ra9kdV7ehmep48oyGsAYgAcGASPOC9JN6Ggzu3TqW3CrtkXpo
         mUJYxYZFjrmpJqnFx+blrL8WWB4Opm8IJVPI/ga9gbC9UyfrcbSzppTmKnv2JFDOcQLt
         kXZmXYeksE/H6G2Cx44J9t5Y/Er0gd46zNQRmtYZ2cMcCnWy+FNeWw4e0JI0IMPMRMSk
         qiiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gWrn0ZzoLGU+0s2/NF6+EKuwvJ9nKhht4luvoBZquWg=;
        b=Cf47VJUXd6oszI3GNdLepOy2lQIMGTXPiZpFo397F+3gyTir5DtTyN3Sj4zAToU7x9
         KuNwDSJul2DNR49GuMWf4CumTNkVFsNttiulOK5fkBNu7t8RJzrF11Uq9B/Iy1lmiuqk
         sRyAjituxe+6D0P5HuxNCEliQQ3FmNIukWbEs3d5waqGsXRZzEfuff9Bmgrv4XOazE6d
         BEj/qA+1NqizLSy8K4bPx3kqVau/qF5vPcJFEwQ5M7MqlGdGbbIMSi5xA6a3Aj7n1CQm
         e8w+5EjuV5giUfmmVe5JSi4Osk3c0RLzCQ9AIESHydC8BgLv5Pd4z3L6M2QvRMbZMeUR
         9uFA==
X-Gm-Message-State: AOAM5305M/etVTIyHfJYjIQTgHa14JT1sgaVKI42hsbQDqDyYDbo2Z6/
        1Gg9pMMURYFTC1I8uL2mTSPwO4VDpiYHgUzRwXY=
X-Google-Smtp-Source: ABdhPJwSzN2VsrzZYr7rtvUe7yApWzWuXVZ+SC/ZHTldh4348vMM5SZG1JRzU59G6kALes2ySyE6NZZcaSTfoFm+Ig4=
X-Received: by 2002:a05:6830:4c3:: with SMTP id s3mr4733622otd.162.1590586654279;
 Wed, 27 May 2020 06:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200523195130.409607-1-jlebon@redhat.com> <CAFqZXNsuJ7S9zFhHBJNJxUr4=_ZGmKdzTU29PrWRuziMfJJkGQ@mail.gmail.com>
 <CACpbjYqBL3a6iVuN9NGzLLHdENC-EXNsNikJZsEhpvCkCGEM2A@mail.gmail.com> <CAFqZXNtXHxv6RzgEc_nzHdaGpOEGzMzMe=k_P23VgC-9ftPeVQ@mail.gmail.com>
In-Reply-To: <CAFqZXNtXHxv6RzgEc_nzHdaGpOEGzMzMe=k_P23VgC-9ftPeVQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 27 May 2020 09:37:23 -0400
Message-ID: <CAEjxPJ6udNnACZz9gsm=HrHb6KV_MKtDbSgpOiyzb7PG7YOuMA@mail.gmail.com>
Subject: Re: [PATCH] selinux: allow reading labels before policy is loaded
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Jonathan Lebon <jlebon@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 27, 2020 at 4:23 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Tue, May 26, 2020 at 9:12 PM Jonathan Lebon <jlebon@redhat.com> wrote:
> > On Mon, May 25, 2020 at 1:14 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > I might be missing something, but couldn't you achieve the same by
> > > simply adding something like this in here:
> > >
> > > if (!selinux_initialized(&selinux_state))
> > >         return -EOPNOTSUPP;
> > >
> > > (Or by adding it to the condition above.)
> > >
> > > Then you should hit this condition here and be all set:
> > > https://elixir.bootlin.com/linux/v5.7-rc7/source/fs/xattr.c#L337
> >
> > Hi Ondrej,
> >
> > Yes, that looks promising. Two questions with that approach:
> >
> > 1. Is there a concern here with transiently returning -EOPNOTSUPP even
> > if the SELinux LSM does technically support the inode_getsecurity
> > hook? I'm thinking of potential corner-cases down the road where
> > somehow this knowledge is cached.
>
> I would hope not. I don't think it's likely this would be cached,
> since it would require a guarantee from all LSMs that they won't flip
> from -EOPNOTSUPP to something else... That would be error-prone IMHO.
>
> >
> > 2. The selinux_inode_getsecurity hook today does somewhat handle the
> > uninitialized case. It ends up here:
> >
> > https://elixir.bootlin.com/linux/v5.7-rc7/source/security/selinux/ss/services.c#L1322.
> >
> > Specifically, it has support for initial SIDs. The patch I wrote
> > purposely tries to allow falling back to that logic. Is there a
> > concern with short-circuiting this logic even if the inode SID somehow
> > isn't SECINITSID_UNLABELED?
>
> Oh, right, so that's what I missed :) I'll have to defer to Stephen on
> whether this is a concern... Obviously we lose the previous behavior
> of returning the initial SID strings via getxattr(), but I'm not sure
> if that's significant. Since those strings obviously aren't real
> contexts, it seems they only serve an informational purpose.
>
> Anyway, I looked at the original patch again and it generally looks
> sane. I don't like the fact that we need to call back to
> __vfs_getxattr() in yet another place, but it makes sense since
> security_inode_getsecurity() is basically overriding it. So I leave it
> on Stephen or Paul to decide which is better.

I think Ondrej's suggested approach is better.  I don't think it is a concern.
