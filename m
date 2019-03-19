Return-Path: <SRS0=xf7N=RW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA03C43381
	for <selinux@archiver.kernel.org>; Tue, 19 Mar 2019 19:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D74720854
	for <selinux@archiver.kernel.org>; Tue, 19 Mar 2019 19:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="DvyNqMyr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfCSTdV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Mar 2019 15:33:21 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43878 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfCSTdV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Mar 2019 15:33:21 -0400
Received: by mail-lf1-f66.google.com with SMTP id g7so24235lfh.10
        for <selinux@vger.kernel.org>; Tue, 19 Mar 2019 12:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T3rfPEOEl2AeWC21b4kyxtolJV3yp9JcfpDZ2abDEDQ=;
        b=DvyNqMyr/r8T/Dv6Br5llT3cqXJY/ZrU1Y7tGwTENLxrfbsI8DICYNRmC7lH8Ui0MR
         s8w32iOwZsW0sReRYas+Z7n5scuCm1wU3m3F49hs0j7lveYYnBoq76bs7SRo6r2nujEu
         kKeCvwKQ+xtIVTGZ54lQS1PIR2Xvqe+1SaI+/HxmAAI1ew9lMZZLQVdpeINsgxsvV9CE
         O1QqwFVY+td6v9Sv+5PYPC0euiXtGhstIuPRqTJPgdDbWiBr8S7wjGm47LXovNTZn5wb
         YcHz5s722AR0dXbZcIT9GJUst2bcZaSjpCrp6eJAz0U2EIipz1gXapHZVPB8vQgRNQeg
         /C/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T3rfPEOEl2AeWC21b4kyxtolJV3yp9JcfpDZ2abDEDQ=;
        b=HUdbBFzVJDcdyug166ilqwDLRDy+r+BuPi/394T7zg9ZmcQVJnR4EKy/wb6l9Tn9gN
         DRCL+EurTI9q/xIrHhNXZRHWXKLj034N9uYsKqhg78KVjc80TqmSI4Dol4SiKWB7qC4d
         9hPNj/+rzFo3Nb7MMESiG3YVSH6+15kVHAfIZvPPqEt0WSK/zYOrHjQ1Nyh4BzMk2FLV
         rOahrmHtYJQp65CMsYHsjHEtdIsJ3/0X5KAZB4dRzdadl4+Si/I1OSbpEkD7awpjfvZt
         f0rPM+WZu5cah8yF1IMB1dNcEiNPcOVzQSBafB75lJTCycKMm5BBoYw58+GZoNs1NbA9
         2qMA==
X-Gm-Message-State: APjAAAXFY/MVGS+kPZViyaCPPTSWnWOlgKokyr1FVhHATo/jyHG7G+6l
        CVfF8tY1D2C+jKH4n8CUEFhI2TMWXQFQFdFFYPIk
X-Google-Smtp-Source: APXvYqwL3irO/cGxK85ggzTvpqzJbTZ4AKYgOO8FdWmCqqi2DgAjL4qWEadLY1sNumLX1OMgRk2YVyy82sO9P2aHOxc=
X-Received: by 2002:ac2:42da:: with SMTP id n26mr12487768lfl.91.1553023997439;
 Tue, 19 Mar 2019 12:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhS1vRJuxxdzVsvkBVVVzt-3g9Q3qHSeeVPB9=JH+nNXbg@mail.gmail.com>
 <CAHRSSEwoR2-=pTRw1crXTXt-uOHe52UPof3hLcbZoVPDV5N4yw@mail.gmail.com>
 <CAHC9VhSwoCEDd8BgQ6_D8TRuVXJFNTavkAjyjFEAneVxBAwJ2Q@mail.gmail.com> <CAHRSSEzWFQi4PO3qBLziAVcsqe3O_u4LK9hJHa0Pyq3UZLW=BQ@mail.gmail.com>
In-Reply-To: <CAHRSSEzWFQi4PO3qBLziAVcsqe3O_u4LK9hJHa0Pyq3UZLW=BQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 Mar 2019 15:33:05 -0400
Message-ID: <CAHC9VhRcrNBRxkLxd5-biRJRqhby5hEOWHkv8hrsU87QOjpXGA@mail.gmail.com>
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

On Tue, Mar 19, 2019 at 12:51 PM Todd Kjos <tkjos@google.com> wrote:
> Paul,
>
> I think this patch will fix it... can you run the selinux-testsuite
> with the patch to verify? (the conditional assumed that size_t can go
> negative)

Building a test kernel now, I'll report back as soon as it is finished.

Thanks.

> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 9a7c431469b3..bb9a661ffecc 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2240,7 +2240,8 @@ static size_t binder_get_object(struct binder_proc *proc,
>         size_t object_size = 0;
>
>         read_size = min_t(size_t, sizeof(*object), buffer->data_size - offset);
> -       if (read_size < sizeof(*hdr) || !IS_ALIGNED(offset, sizeof(u32)))
> +       if (offset > buffer->data_size || read_size < sizeof(*hdr) ||
> +                       !IS_ALIGNED(offset, sizeof(u32)))
>                 return 0;
>         binder_alloc_copy_from_buffer(&proc->alloc, object, buffer,
>                                       offset, read_size);
>
> On Mon, Mar 18, 2019 at 4:02 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Mon, Mar 18, 2019 at 6:51 PM Todd Kjos <tkjos@google.com> wrote:
> > > On Mon, Mar 18, 2019 at 2:31 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > Hello all.
> > > >
> > > > When running the selinux-testsuite (link below) against v5.1-rc1 I hit
> > > > the BUG_ON() at the top of binder_alloc_do_buffer_copy() (trace
> > > > below).  I'm hoping this is a known issue with a fix already in the
> > > > works?
> > >
> > >
> > > Sadly, this is the first report of this, so no fix in flight. I'll try
> > > to get a fix up in the next few days.
> >
> > No problem, thanks for letting me know.  If you need some testing
> > help, let me know.
> >
> > --
> > paul moore
> > www.paul-moore.com



-- 
paul moore
www.paul-moore.com
