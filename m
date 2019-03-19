Return-Path: <SRS0=xf7N=RW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B00C43381
	for <selinux@archiver.kernel.org>; Tue, 19 Mar 2019 22:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D719E217F9
	for <selinux@archiver.kernel.org>; Tue, 19 Mar 2019 22:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="atFE+01Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfCSWIt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Mar 2019 18:08:49 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33759 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfCSWIt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Mar 2019 18:08:49 -0400
Received: by mail-lj1-f193.google.com with SMTP id f23so512786ljc.0
        for <selinux@vger.kernel.org>; Tue, 19 Mar 2019 15:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iSkk0ePQErm0XqnmUL1pWsS7Hii5D3RwOebpeXXCz+I=;
        b=atFE+01ZZs6ax/q+C82FCFuE7HJ+w+qoG5SR1bn67dZclbpBDlP1neUvZhbFDwd7vN
         ElyZRAriVzzjYqbV5irIrIwZQKDc4AA4z0/GkHZQOyXlzBbC/CRiNdI3Kyx8UZU+FbXV
         fVl/7npzQMWx1p42L4hEvuLNjj7ajfKOA8X0pb5VI6Bujo64FqF35T0aicmh7H0vBqMQ
         C1QByhxAdNNqnn0DY75D5ysg+nypXVs6G8mpmV5DZ08YQxyotMcM8Q4BZAoNsk39X/gj
         tMD7nKZ6fd0Ic8z3i0FgQuMwX4lQFRxMgbPB5E0lY7932EWlCrBDHOTCEh6nDb8KSA2K
         J7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iSkk0ePQErm0XqnmUL1pWsS7Hii5D3RwOebpeXXCz+I=;
        b=OiEh/YETqgF5OYF0XAqEHHpf/QwHfP8r0VaqvLSDM+aq7cLi62+NhiN5TFP/ltkCy/
         Qc0lPpY7t/DolYfE/P/K1afURgTShVaHSlsqmNtOUXTceGvZ5sIzoQHmVtsNXv4Xc0tS
         VMVTie/MVbh9xO8tlRDLxb16iKXR/QpYpgtLkGLI6avwplldr7RxPm7X6E8q8H0YsEES
         3VsUIils50XyxTR/noCRUn+Yfc/TuaPjBP5Gq3Rc+VF9J5Ut/qKem6+YVLVwsL/yartR
         pN6En0VfdxBo50iu6b21vysgjFxjwXR2puMqmwkwoXDqdhXfSUWA81xxUzQtJLKwjcvy
         hEnw==
X-Gm-Message-State: APjAAAX8ikN+SsM2oXMVUw2CP34m3JN8I8QaoxP+/phl71gOrEkIk1yl
        X/50/tSc0SUWLnj/df5Z9FlSdZl/mPebSiB0Qcv/wKrrWA==
X-Google-Smtp-Source: APXvYqxWcacVOmNWC2dGVunA8VwhNREDb+U7IDT8vynoPkuF6wpMQ8jXH/Dpp6FE5ZhQhSVrRk0lRzMQpyOfCGwoIv0=
X-Received: by 2002:a2e:500d:: with SMTP id e13mr12187723ljb.169.1553033327049;
 Tue, 19 Mar 2019 15:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhS1vRJuxxdzVsvkBVVVzt-3g9Q3qHSeeVPB9=JH+nNXbg@mail.gmail.com>
 <CAHRSSEwoR2-=pTRw1crXTXt-uOHe52UPof3hLcbZoVPDV5N4yw@mail.gmail.com>
 <CAHC9VhSwoCEDd8BgQ6_D8TRuVXJFNTavkAjyjFEAneVxBAwJ2Q@mail.gmail.com>
 <CAHRSSEzWFQi4PO3qBLziAVcsqe3O_u4LK9hJHa0Pyq3UZLW=BQ@mail.gmail.com> <CAHC9VhRcrNBRxkLxd5-biRJRqhby5hEOWHkv8hrsU87QOjpXGA@mail.gmail.com>
In-Reply-To: <CAHC9VhRcrNBRxkLxd5-biRJRqhby5hEOWHkv8hrsU87QOjpXGA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 Mar 2019 18:08:35 -0400
Message-ID: <CAHC9VhTzj7gNj6jJ13pquP5im+kqG--qfYn2O0=xB=n5sB7s3w@mail.gmail.com>
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

On Tue, Mar 19, 2019 at 3:33 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Mar 19, 2019 at 12:51 PM Todd Kjos <tkjos@google.com> wrote:
> > Paul,
> >
> > I think this patch will fix it... can you run the selinux-testsuite
> > with the patch to verify? (the conditional assumed that size_t can go
> > negative)
>
> Building a test kernel now, I'll report back as soon as it is finished.

Good news, the BUG_ON() panic is now gone, but I'm seeing a test
failure, although to be fair I saw some binder test failures during
the merge window (I generally don't worry about failures until -rc1 is
released).  The selinux-testsuite binder tests have been working since
spring 2018, but it's possible there might be a bug in the tests that
is just now showing up.  Have you ever looked at the selinux-testsuite
tests for binder?

* https://github.com/SELinuxProject/selinux-testsuite/tree/master/tests/binder

> > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > index 9a7c431469b3..bb9a661ffecc 100644
> > --- a/drivers/android/binder.c
> > +++ b/drivers/android/binder.c
> > @@ -2240,7 +2240,8 @@ static size_t binder_get_object(struct binder_proc *proc,
> >         size_t object_size = 0;
> >
> >         read_size = min_t(size_t, sizeof(*object), buffer->data_size - offset);
> > -       if (read_size < sizeof(*hdr) || !IS_ALIGNED(offset, sizeof(u32)))
> > +       if (offset > buffer->data_size || read_size < sizeof(*hdr) ||
> > +                       !IS_ALIGNED(offset, sizeof(u32)))
> >                 return 0;
> >         binder_alloc_copy_from_buffer(&proc->alloc, object, buffer,
> >                                       offset, read_size);
> >
> > On Mon, Mar 18, 2019 at 4:02 PM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > On Mon, Mar 18, 2019 at 6:51 PM Todd Kjos <tkjos@google.com> wrote:
> > > > On Mon, Mar 18, 2019 at 2:31 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > > Hello all.
> > > > >
> > > > > When running the selinux-testsuite (link below) against v5.1-rc1 I hit
> > > > > the BUG_ON() at the top of binder_alloc_do_buffer_copy() (trace
> > > > > below).  I'm hoping this is a known issue with a fix already in the
> > > > > works?
> > > >
> > > >
> > > > Sadly, this is the first report of this, so no fix in flight. I'll try
> > > > to get a fix up in the next few days.
> > >
> > > No problem, thanks for letting me know.  If you need some testing
> > > help, let me know.

-- 
paul moore
www.paul-moore.com
