Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E392C433E0
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 19:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DA3020728
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 19:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9KyYhD6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgEOT1d (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 15:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbgEOT1c (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 15:27:32 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63C1C061A0C
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 12:27:32 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id y10so3985341iov.4
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 12:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AWoxIZ7Pxk6vfw50Yi3jDfVjR9PgceS0aLVbSL/D4R0=;
        b=N9KyYhD6dzmKOVHLdnx1Vhu+pFKCfYagQRfDwJ7wGLfmXaFOfzlR7FqvTMVWrmmKIw
         hsjIm54yl6VNWsb3UDGQnxvetQ9DlSXmgFRHtjNBZ5iQnaoQWPEunc7jlpuo8uKdke4X
         ufJS2FVNvejkdXSxJzngblt91XRYsYuaNva3cXDk9Jz0R+O+l9biui+wlGPJgrA+qPkE
         z3A+NdOaqzeDSp9j3sRfkdhrU2D2ItOtkT2xH9oKPiysy43fHL1+G5ydpSz4+wMaxx+G
         txwDZe40DkdlTwqM2paWcuSVEMTKVgLLi4qK0D9y61C2IEgS4T3OzlixzO4SdZ9eMjDX
         0o+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AWoxIZ7Pxk6vfw50Yi3jDfVjR9PgceS0aLVbSL/D4R0=;
        b=YYjsvRxBNckNADMHhxYDJPpIdf0zqI5qOyZFBqB8stVSQXeOmCgBVdklOWAm9tYrw8
         PkuNKpjPiIPdutjrfP5ResDejtVH0qdyW8FkpuBbGbE592xF5Hb0uJn6UT0ynXpBZmwL
         neOXIUB8Z6eVzZICrEF7PmyRd/R7aFX4wknd3r9X0XyTy9tYz9aA45w+J1DLMqYcs7lC
         nWrcxeE6l/SfUcVR1kKrqbOqSfGA7sjTfjBi2IIcPxcN9QGcHlqO1+cbC5apbd/VMKJm
         o3PCvOuwPe1WlzBrUzNhlHLdGZ91kOYhH6DufN1j1C5q0Jgdg7uuLzUIQ0uwSe5dmD+c
         75rw==
X-Gm-Message-State: AOAM532tr5iz3t0V6sS4Oo2TAhEf/xHXtEgDOOqk9+Q80NJi+TN275cr
        OKpgsHLX8Xy4RgMdZpjxQ5UIrRGDqfjYGashe5k=
X-Google-Smtp-Source: ABdhPJw9PJr+Oe7yhBz6WCIcra/HoXUuHeGdfGy+UThhfSz65oTc/jKCNzt38FDUDztL4/PoZnF47wQc1Mymb/OJ0lo=
X-Received: by 2002:a6b:d10f:: with SMTP id l15mr4358296iob.143.1589570851890;
 Fri, 15 May 2020 12:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200515173042.12666-1-william.c.roberts@intel.com>
 <CAFqZXNtaSV-FHYwZ41Sp8f9eOu=RU6hSR_1Gqxb9LocaQ7BnzA@mail.gmail.com>
 <CAFftDdqabuGFeP3ugx+UDREZUnhkrjEoPMkuxaLC=H61_J+H+w@mail.gmail.com> <CAEjxPJ5tE2qmPYibzjGcp1pQDESXPG8-kHczDSyZBXen+t0+-A@mail.gmail.com>
In-Reply-To: <CAEjxPJ5tE2qmPYibzjGcp1pQDESXPG8-kHczDSyZBXen+t0+-A@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 15 May 2020 14:27:20 -0500
Message-ID: <CAFftDdopJ_y7YoNG5P00kMu9qx_5NAFpR8aOSJr4J0F=BeZ-Tg@mail.gmail.com>
Subject: Re: [PATCH] README: add pkg kernel-devel to dnf command
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        "Roberts, William C" <william.c.roberts@intel.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 15, 2020 at 1:51 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, May 15, 2020 at 2:11 PM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> >
> > On Fri, May 15, 2020 at 12:59 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > On Fri, May 15, 2020 at 7:31 PM <william.c.roberts@intel.com> wrote:
> > > > From: William Roberts <william.c.roberts@intel.com>
> > > >
> > > > The text above states that kernel-devel is needed, but it's missing from
> > > > the dnf command.
> > > >
> > > > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > > > ---
> > > >  README.md | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/README.md b/README.md
> > > > index 1f7e5d92a100..a73e9cc0c06d 100644
> > > > --- a/README.md
> > > > +++ b/README.md
> > > > @@ -77,7 +77,8 @@ following command:
> > > >                 kernel-devel \
> > >
> > > It's actually right there already ^^
> >
> > Yeah that's the foot cannon, I thought I was good, but you need the
> > specific ones
> > as Ondrej pointed out to me.
> >
> > >
> > > >                 quota \
> > > >                 xfsprogs-devel \
> > > > -               libuuid-devel
> > > > +               libuuid-devel \
> > > > +               kernel-devel-$(uname -r)
> > >
> > > I proposed adding the -$(uname -r) before, but there were some valid
> > > counterarguments. See the discussion here:
> > > https://lore.kernel.org/selinux/CAFqZXNs5jcOOnhzT8=DQgzaf9RtBZ1=oqTU83pjVLMqPb-rzHA@mail.gmail.com/
> > >
> >
> > Arguments for why the dnf command should have it with uname:
> > 1. We tried to add it twice, it's bit people twice.
> > 2. The README states "On a modern Fedora system you can install these
> > dependencies with the following command:"
> >     - which is wrong, you need the specific package
> >     - If you're going to provide a "dnf install" or a apt-get install,
> > it should just work
> >     - the apt-get example has uname -r in it.
> >     - so the precludes building your own kernel, if you do that as
> > Paul stated, you're on your own. (lore comment)
>
> I'm ok with adding it.

Does anyone want to ack this one?

Ok I found another one, kernel-modules-extra is needed for the sctp module.

The tests expect sctp support, should we conditionally skip these if
sctp is not enabled?
Whats the best way of checking for that proto if we want this? just an
ls of /proc/sys/net:
ls /proc/sys/net/
bridge  core  ipv4  ipv6  netfilter  nf_conntrack_max  sctp  unix
