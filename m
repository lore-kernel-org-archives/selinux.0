Return-Path: <SRS0=xf7N=RW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A89BC43381
	for <selinux@archiver.kernel.org>; Tue, 19 Mar 2019 22:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D122175B
	for <selinux@archiver.kernel.org>; Tue, 19 Mar 2019 22:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xw6I0Mqp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfCSWQS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Mar 2019 18:16:18 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43597 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfCSWQS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Mar 2019 18:16:18 -0400
Received: by mail-qt1-f193.google.com with SMTP id v32so263713qtc.10
        for <selinux@vger.kernel.org>; Tue, 19 Mar 2019 15:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UXPiO1nRNePCEnDymNt68VhQ0vteXJwzbUyHeomVlCg=;
        b=Xw6I0MqpciIfrCPGZE7FiIVDD7dYhvh1m1igfq5vRlSNTfITNvZLEE8o4t7YCNb8qI
         FT9qoFFABU+/qmEI/I+o6unveMMKRAVEWLkFFOckhFhzCV/syuyIyYWRzMEer43aCOEz
         3TU987AhOCTsBi0xtvUdPGkpAo7k0fKqSDcfMnek811wnzIDZf6vf0TAhWIQv0HfMDsZ
         0B2rQD19dlItQRPgJaUDv6EXRCZLCli07yc1NcGrhgAtG6rRBs6aMdDUu5jVk0tFqIQd
         gJZL/tSpdrYk5LpAc6gUG2AwRcoo7erebpJiAEjDG5Sazup0qUK0yNOT7mzAsHiGonV6
         OJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UXPiO1nRNePCEnDymNt68VhQ0vteXJwzbUyHeomVlCg=;
        b=Thrq+tMvx1Tnp0CWwMHV7PvvYr+qLO/4e4v0NapGIEdODqtlZoNU26BxDAl51ZYb44
         S/izlQ3FwleBIPYP17llLXv6DrBzeUClWN3qNRt9+6l1yzMYcazYm48IwSoY4+dld7UZ
         DcT7g1H9k6IAG/zXaeOjHxamEGQPZtVKW9TW36f85DFzY+NfDd/l9zRRDbHmQu4myolD
         q1k56beNIDSP9JXzFnUkkuvRsY1GxwSiWaEMFVQUcpwbN2NamFBNtMYddgXQZbdFoOoP
         oW+S7acIqKQDzmU8vCklyPea68TNUUZeEtmvegpMTJYn27rK0AznOerz2yPfmo7MPe5+
         rQ/A==
X-Gm-Message-State: APjAAAWSKF69tN4PJhJLNf8/58hAxgyNcHHnrtBRQo7bAJCUP5SiUfbI
        USvxUAPUdM6TEw4Efn6byLVx7VoPCCok6MTtpuEnj67U
X-Google-Smtp-Source: APXvYqzkqmwkybivUMvEiK9t8tE99Yqv5NHMP89z7LUtkQnoFPO/MecXWY97CD5sv3ps1jNNF1HCwQ7I458GZH0dS00=
X-Received: by 2002:ac8:28e4:: with SMTP id j33mr4117169qtj.349.1553033777486;
 Tue, 19 Mar 2019 15:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhS1vRJuxxdzVsvkBVVVzt-3g9Q3qHSeeVPB9=JH+nNXbg@mail.gmail.com>
 <CAHRSSEwoR2-=pTRw1crXTXt-uOHe52UPof3hLcbZoVPDV5N4yw@mail.gmail.com>
 <CAHC9VhSwoCEDd8BgQ6_D8TRuVXJFNTavkAjyjFEAneVxBAwJ2Q@mail.gmail.com>
 <CAHRSSEzWFQi4PO3qBLziAVcsqe3O_u4LK9hJHa0Pyq3UZLW=BQ@mail.gmail.com>
 <CAHC9VhRcrNBRxkLxd5-biRJRqhby5hEOWHkv8hrsU87QOjpXGA@mail.gmail.com> <CAHC9VhTzj7gNj6jJ13pquP5im+kqG--qfYn2O0=xB=n5sB7s3w@mail.gmail.com>
In-Reply-To: <CAHC9VhTzj7gNj6jJ13pquP5im+kqG--qfYn2O0=xB=n5sB7s3w@mail.gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Tue, 19 Mar 2019 15:16:05 -0700
Message-ID: <CAHRSSEzt_d=8r34PJuyu5u6DWm461XXGhEVYignfktvj8pWSgg@mail.gmail.com>
Subject: Re: v5.1-rc1 binder_alloc_do_buffer_copy() BUG_ON triggered by selinux-testsuite
To:     Paul Moore <paul@paul-moore.com>
Cc:     Todd Kjos <tkjos@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        selinux@vger.kernel.org,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 19, 2019 at 3:08 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Tue, Mar 19, 2019 at 3:33 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Mar 19, 2019 at 12:51 PM Todd Kjos <tkjos@google.com> wrote:
> > > Paul,
> > >
> > > I think this patch will fix it... can you run the selinux-testsuite
> > > with the patch to verify? (the conditional assumed that size_t can go
> > > negative)
> >
> > Building a test kernel now, I'll report back as soon as it is finished.
>
> Good news, the BUG_ON() panic is now gone,

Great. Thanks for testing it.

> but I'm seeing a test
> failure, although to be fair I saw some binder test failures during
> the merge window (I generally don't worry about failures until -rc1 is
> released).  The selinux-testsuite binder tests have been working since
> spring 2018, but it's possible there might be a bug in the tests that
> is just now showing up.  Have you ever looked at the selinux-testsuite
> tests for binder?

No, I didn't know they existed until yesterday. Glad to have more test
coverage. Were they running clean on 5.0.0?

Is there a public dashboard where I can take a look at those binder failures?

-Todd

>
> * https://github.com/SELinuxProject/selinux-testsuite/tree/master/tests/binder
>
> > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > index 9a7c431469b3..bb9a661ffecc 100644
> > > --- a/drivers/android/binder.c
> > > +++ b/drivers/android/binder.c
> > > @@ -2240,7 +2240,8 @@ static size_t binder_get_object(struct binder_proc *proc,
> > >         size_t object_size = 0;
> > >
> > >         read_size = min_t(size_t, sizeof(*object), buffer->data_size - offset);
> > > -       if (read_size < sizeof(*hdr) || !IS_ALIGNED(offset, sizeof(u32)))
> > > +       if (offset > buffer->data_size || read_size < sizeof(*hdr) ||
> > > +                       !IS_ALIGNED(offset, sizeof(u32)))
> > >                 return 0;
> > >         binder_alloc_copy_from_buffer(&proc->alloc, object, buffer,
> > >                                       offset, read_size);
> > >
> > > On Mon, Mar 18, 2019 at 4:02 PM Paul Moore <paul@paul-moore.com> wrote:
> > > >
> > > > On Mon, Mar 18, 2019 at 6:51 PM Todd Kjos <tkjos@google.com> wrote:
> > > > > On Mon, Mar 18, 2019 at 2:31 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > > > Hello all.
> > > > > >
> > > > > > When running the selinux-testsuite (link below) against v5.1-rc1 I hit
> > > > > > the BUG_ON() at the top of binder_alloc_do_buffer_copy() (trace
> > > > > > below).  I'm hoping this is a known issue with a fix already in the
> > > > > > works?
> > > > >
> > > > >
> > > > > Sadly, this is the first report of this, so no fix in flight. I'll try
> > > > > to get a fix up in the next few days.
> > > >
> > > > No problem, thanks for letting me know.  If you need some testing
> > > > help, let me know.
>
> --
> paul moore
> www.paul-moore.com
