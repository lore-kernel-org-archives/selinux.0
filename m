Return-Path: <SRS0=OuNA=5X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1C2C2D0EC
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 21:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95E920769
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 21:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5l1OfMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgDGVCc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Apr 2020 17:02:32 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:42287 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgDGVCc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Apr 2020 17:02:32 -0400
Received: by mail-il1-f195.google.com with SMTP id f16so4658193ilj.9
        for <selinux@vger.kernel.org>; Tue, 07 Apr 2020 14:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oluPo1UfV7nkgwC9MrxaMS0Z+KvVNc80MeJ8czI0feI=;
        b=d5l1OfMya2WaFeC04hELlUAT5O5IWasVWYZal1sWDhL+84Bpqx7c1IrtCIDE/ybsI1
         ZT8kGlB8f39NAcqYfws4qRpnHO/Z6yIkdeqr+7QG/Gv13hAQsfujElVxOTpFgLJ7onL+
         2xI4/b9AkqPLbLQm7vdl0zX6se2ZcqaNPg0Pc3sxhb0+Q9eKQvdYO2d5DeYvqA+uzqz0
         8rfIKRyqvAzCOnwGZgSN317/R8XfRBzX/5fOshN/EHUYj0OMFzR25wv1FVmGM76+jjzZ
         lbSJct8D/f3vu5zMOBPsxoeLvhL2m1dbJNLGwfQwNZFkleK2d8TiSM42Nto2PBlPfHWj
         /amg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oluPo1UfV7nkgwC9MrxaMS0Z+KvVNc80MeJ8czI0feI=;
        b=Q8giv5FfYgiecv5aN1eXv5J1CSyXDcFP7Nppd7M89a7ErX16kTqeULDhndL4l+zSf+
         Ktrg1ZShJKD+I+qadvjGT4llkNJceywwaTs06u2RKUg6Sg8QUY8ZHjuPEwzbCKV7P0WX
         4HeqGslvaKGxsLbTWmytUP0f5tk2DJyzvlw3PJ4SGCOa3QvKNOHqKaGtm22QdonIMpDI
         Z/6hxq0nkNY+OrYA3tBmO0rzouZ8yZfvLECu0cX7eMNuabDS7wU0yJG57TDcOOxifg9f
         zO0qEo3bK1hLPZG/2ZMPdEaM4oRtPQ7Jbe70UHz+uvos0RN8eFwuzbWJpdWMny1liYug
         PPGA==
X-Gm-Message-State: AGi0PuZSp+xGqXP0BoY2vgGI4NKG/Kv6+ZRiknhGta0dGZ9FG/gQzLUI
        d/vNoB31ypMPAhOzc9QqkCZJN/bpIhfa6nNQIdg=
X-Google-Smtp-Source: APiQypKJG5ivhQLW1qLNyYsbDqZN5rgPqi0qqzsAxxCuoObUSot7D6ID+OOB++bxGmBshpGwMk7wItXvdRDfzPs9nMU=
X-Received: by 2002:a92:98d5:: with SMTP id a82mr4546602ill.163.1586293350500;
 Tue, 07 Apr 2020 14:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200407184239.2700998-1-aduskett@gmail.com> <476DC76E7D1DF2438D32BFADF679FC5649EBB79F@ORSMSX101.amr.corp.intel.com>
 <CAFSsvmpmhuRD2gWj8ZaRkmZ42DoUM0evfb4tfJTgm8yu=qf2Jg@mail.gmail.com> <CAFSsvmrcyhA2xdyAp2vQwN+pqwtK8Tj4uGKicKZfiBCy5pf8BQ@mail.gmail.com>
In-Reply-To: <CAFSsvmrcyhA2xdyAp2vQwN+pqwtK8Tj4uGKicKZfiBCy5pf8BQ@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Tue, 7 Apr 2020 16:02:19 -0500
Message-ID: <CAFftDdqN5hXaRZN2LStJkkmfsW-D0b1jeUowwDwr==oaybVOSg@mail.gmail.com>
Subject: Re: [PATCH 1/1] fix building against musl and uClibc libc libraries.
To:     Adam Duskett <aduskett@gmail.com>
Cc:     "Roberts, William C" <william.c.roberts@intel.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 7, 2020 at 3:54 PM Adam Duskett <aduskett@gmail.com> wrote:
>
> I just ended up making a new branch that has the latest updated
> commits and a new PR with an SOB line.
>
> https://github.com/SELinuxProject/selinux/pull/218

Top posting on this list is frowned upon, I will merge this after the
obligatory waiting period to allow others to comment.
I think its 48 hours... I could be wrong. If we documented that, I
didn't find it.

Thanks for playing along and resubmitting. Now you get all the
accolades and glory that come along with
contributing to SE Linux.

Don't be surprised if people come up to you while you're eating dinner
asking for autographs :-P.

>
> On Tue, Apr 7, 2020 at 1:47 PM Adam Duskett <aduskett@gmail.com> wrote:
> >
> > I did that just now!
> >
> > On Tue, Apr 7, 2020 at 1:27 PM Roberts, William C
> > <william.c.roberts@intel.com> wrote:
> > >
> > > > -----Original Message-----
> > > > From: selinux-owner@vger.kernel.org [mailto:selinux-owner@vger.kernel.org]
> > > > On Behalf Of aduskett@gmail.com
> > > > Sent: Tuesday, April 7, 2020 1:43 PM
> > > > To: selinux@vger.kernel.org
> > > > Cc: Adam Duskett <Aduskett@gmail.com>
> > > > Subject: [PATCH 1/1] fix building against musl and uClibc libc libraries.
> > > >
> > > > From: Adam Duskett <Aduskett@gmail.com>
> > > >
> > > > Currently, the src/Makefile provides the FTS_LDLIBS when building against musl
> > > > or uClibc. However, this is missing from utils/Makefile, which causes linking to fail.
> > > >
> > > > Add the FTS_LDLIBS variable to the LDLIBS variable in utils/Makefile to fix
> > > > compiling against uClibc and musl.
> > > >
> > > > Signed-off-by: Adam Duskett <Aduskett@gmail.com>
> > > > ---
> > > >  libselinux/utils/Makefile | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile index
> > > > 36150638..a5632b7c 100644
> > > > --- a/libselinux/utils/Makefile
> > > > +++ b/libselinux/utils/Makefile
> > > > @@ -45,7 +45,7 @@ endif
> > > >
> > > >  override CFLAGS += -I../include -D_GNU_SOURCE $(DISABLE_FLAGS)
> > > > $(PCRE_CFLAGS)  override LDFLAGS += -L../src -override LDLIBS += -lselinux
> > > > +override LDLIBS += -lselinux $(FTS_LDLIBS)
> > > >  PCRE_LDLIBS ?= -lpcre
> > > >
> > > >  ifeq ($(ANDROID_HOST),y)
> > > > --
> > > > 2.25.1
> > >
> > > If you want me to use the PR you have open, force push your branch to update the commit
> > > message. Else I'll have to create a new-pr and close your old one.
> > >
> > > Your open PR is here:
> > > https://github.com/SELinuxProject/selinux/pull/193
> > >
> > > Something like:
> > > git pull --rebase origin master
> > > git push aduskett HEAD:fix-musl-and-uclibc-builds
> > >
> > > would be ideal.
> > >
> > > Acked-by: William Roberts <william.c.roberts@intel.com>
