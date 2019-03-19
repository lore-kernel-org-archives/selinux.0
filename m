Return-Path: <SRS0=xf7N=RW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EB8C4360F
	for <selinux@archiver.kernel.org>; Tue, 19 Mar 2019 22:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88DDA2175B
	for <selinux@archiver.kernel.org>; Tue, 19 Mar 2019 22:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Gg2B8ulg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfCSWUr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Mar 2019 18:20:47 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37385 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbfCSWUr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Mar 2019 18:20:47 -0400
Received: by mail-lj1-f194.google.com with SMTP id v13so507961ljk.4
        for <selinux@vger.kernel.org>; Tue, 19 Mar 2019 15:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LYcypAl4slDd1DRt1D5/gjyny7aCLTmLyxDkOoR6RVY=;
        b=Gg2B8ulgQ4dh7mYMdrGegyvGsHyzfzhsq59hqpFvkRUKRLUHvuzw2jE0ZYqlYJEEOs
         1NDuZHRqnJeyZcvPlb2HTbeLIBVLiWzpiSvEitDb4B9do9+3VcdLHR8bRYCvIxvJxdtk
         UphB2bz100myfBbJVBaC6DrmMUI9blj2LQEXNICqQxLW8BbyzvpJVFO/4S8SC1oE/Bfw
         l/lv44onjaJCles/cOvBZPYWH8PE7Nh0sKbIJnvCnG9CHawTXgmQWPi1hMxVkHAzWgzz
         A9B9pC+qy2u+Vgd4VRlN7safDyWSzk2/fdT1e0LXZGNFHW/UtBVsq+Wqzoa+PHRxRZhJ
         0gfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LYcypAl4slDd1DRt1D5/gjyny7aCLTmLyxDkOoR6RVY=;
        b=duTMNPbP6KFETnAEPi/IqiW40lJHo1mCDDoz7WZBL4092MDXhsBAlkUcXrt5DDX+Zj
         wkxjq/1+6Rj7ZR7B1D6S6kOu0S08zl/XJbGSht1hgDubKnFHezX6ZvkG8YeMzfzEbXCV
         cH8skie8yPoyL8e3312aYffSfFckobYdoSoK8S2s1U5XiaAIcMfKx9rd3LGhxCA6vf9M
         F3wEzCNAsUTEFXZeRGaYZAUYI400vJlYfqsWEPJINage4QuOraSlkKqvsDyf4e+9AYdX
         EqsFp6CTnajUqye+aM394S7XVkaeFGpJQpfsJCOgv47gwNSMGbgP+JxdaNNHPUYg2M9F
         YdQw==
X-Gm-Message-State: APjAAAX+NrMv4A7KXGmfkfT4fWK9sOqppbpx6uPAd8Bo3sI1gTbqQUYi
        1XCRxvo/vXzhnbO9tmZB0Og64Rgb2Wut8Fm63Ljg
X-Google-Smtp-Source: APXvYqwtQqGm+7Qj4C+FhTOjeyNCgQvU7f3Www3dc+PnIFXm6N/YDafZQnvN44vsb1y5Fly50/UQPP7RSxae5GHa2dM=
X-Received: by 2002:a05:651c:d7:: with SMTP id 23mr747156ljr.5.1553034044329;
 Tue, 19 Mar 2019 15:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhS1vRJuxxdzVsvkBVVVzt-3g9Q3qHSeeVPB9=JH+nNXbg@mail.gmail.com>
 <CAHRSSEwoR2-=pTRw1crXTXt-uOHe52UPof3hLcbZoVPDV5N4yw@mail.gmail.com>
 <CAHC9VhSwoCEDd8BgQ6_D8TRuVXJFNTavkAjyjFEAneVxBAwJ2Q@mail.gmail.com>
 <CAHRSSEzWFQi4PO3qBLziAVcsqe3O_u4LK9hJHa0Pyq3UZLW=BQ@mail.gmail.com>
 <CAHC9VhRcrNBRxkLxd5-biRJRqhby5hEOWHkv8hrsU87QOjpXGA@mail.gmail.com>
 <CAHC9VhTzj7gNj6jJ13pquP5im+kqG--qfYn2O0=xB=n5sB7s3w@mail.gmail.com> <CAHRSSEzt_d=8r34PJuyu5u6DWm461XXGhEVYignfktvj8pWSgg@mail.gmail.com>
In-Reply-To: <CAHRSSEzt_d=8r34PJuyu5u6DWm461XXGhEVYignfktvj8pWSgg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 Mar 2019 18:20:33 -0400
Message-ID: <CAHC9VhT_OWOU97C2NeDq8TWQzsu74V7maLWSXPhBFUKwrTvtCA@mail.gmail.com>
Subject: Re: v5.1-rc1 binder_alloc_do_buffer_copy() BUG_ON triggered by selinux-testsuite
To:     Todd Kjos <tkjos@google.com>
Cc:     Todd Kjos <tkjos@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        selinux@vger.kernel.org,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 19, 2019 at 6:16 PM Todd Kjos <tkjos@google.com> wrote:
> On Tue, Mar 19, 2019 at 3:08 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Tue, Mar 19, 2019 at 3:33 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Tue, Mar 19, 2019 at 12:51 PM Todd Kjos <tkjos@google.com> wrote:
> > > > Paul,
> > > >
> > > > I think this patch will fix it... can you run the selinux-testsuite
> > > > with the patch to verify? (the conditional assumed that size_t can go
> > > > negative)
> > >
> > > Building a test kernel now, I'll report back as soon as it is finished.
> >
> > Good news, the BUG_ON() panic is now gone,
>
> Great. Thanks for testing it.

Thanks for the fix :)

> > but I'm seeing a test
> > failure, although to be fair I saw some binder test failures during
> > the merge window (I generally don't worry about failures until -rc1 is
> > released).  The selinux-testsuite binder tests have been working since
> > spring 2018, but it's possible there might be a bug in the tests that
> > is just now showing up.  Have you ever looked at the selinux-testsuite
> > tests for binder?
>
> No, I didn't know they existed until yesterday. Glad to have more test
> coverage. Were they running clean on 5.0.0?

Yep.  They were added to the test suite last May and have been running
clean since then.

> Is there a public dashboard where I can take a look at those binder failures?

Not really.  I send test results to a not-yet-publicized mailing list,
but there is more detail in the GitHub issue below (my last comment
has the verbose test output):

* https://github.com/SELinuxProject/selinux-kernel/issues/46

> > * https://github.com/SELinuxProject/selinux-testsuite/tree/master/tests/binder
> >
> > > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > > index 9a7c431469b3..bb9a661ffecc 100644
> > > > --- a/drivers/android/binder.c
> > > > +++ b/drivers/android/binder.c
> > > > @@ -2240,7 +2240,8 @@ static size_t binder_get_object(struct binder_proc *proc,
> > > >         size_t object_size = 0;
> > > >
> > > >         read_size = min_t(size_t, sizeof(*object), buffer->data_size - offset);
> > > > -       if (read_size < sizeof(*hdr) || !IS_ALIGNED(offset, sizeof(u32)))
> > > > +       if (offset > buffer->data_size || read_size < sizeof(*hdr) ||
> > > > +                       !IS_ALIGNED(offset, sizeof(u32)))
> > > >                 return 0;
> > > >         binder_alloc_copy_from_buffer(&proc->alloc, object, buffer,
> > > >                                       offset, read_size);
> > > >
> > > > On Mon, Mar 18, 2019 at 4:02 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > >
> > > > > On Mon, Mar 18, 2019 at 6:51 PM Todd Kjos <tkjos@google.com> wrote:
> > > > > > On Mon, Mar 18, 2019 at 2:31 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > > > > Hello all.
> > > > > > >
> > > > > > > When running the selinux-testsuite (link below) against v5.1-rc1 I hit
> > > > > > > the BUG_ON() at the top of binder_alloc_do_buffer_copy() (trace
> > > > > > > below).  I'm hoping this is a known issue with a fix already in the
> > > > > > > works?
> > > > > >
> > > > > >
> > > > > > Sadly, this is the first report of this, so no fix in flight. I'll try
> > > > > > to get a fix up in the next few days.
> > > > >
> > > > > No problem, thanks for letting me know.  If you need some testing
> > > > > help, let me know.
> >
> > --
> > paul moore
> > www.paul-moore.com



-- 
paul moore
www.paul-moore.com
