Return-Path: <SRS0=OuNA=5X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196BFC2D0EC
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 20:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6642206C0
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 20:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbTIYGYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDGUyq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:54:46 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40731 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgDGUyq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Apr 2020 16:54:46 -0400
Received: by mail-oi1-f194.google.com with SMTP id y71so2780086oia.7
        for <selinux@vger.kernel.org>; Tue, 07 Apr 2020 13:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YEzFL1IugSXsvQ8FKkqqkAefJLj2Pbdhn4lEoo06T5E=;
        b=sbTIYGYRD3W2P1Lf4Lyo+GpfcjsHCw98++fpYweZivYBcIjsSCdP6gypAW5zKvz9XY
         LmZj5KbphN0obzO9G0NvqFBazYG7hX9oPvC4Gba3Zz7eXoA8J9CPJJM84/lZg55dZC72
         jIOeSBhFPS3knkCE+JxCESE3An4gWEVA/2S9Vomg7czzfwyQz98K8brO0gWknNQwo3af
         nDhfJYAv78DvFEzbXXuBdtiqSoICLz/N9lfVTEmYzwC50FON3Vm7OHCzPtsQjRwJ4aBP
         fYib+cA4/AMLL28d/FWTHi64JBpu6/LVy3AUQ9x0thaNuYNJ7P0p5o49HYUdyrtE5tbx
         Zxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YEzFL1IugSXsvQ8FKkqqkAefJLj2Pbdhn4lEoo06T5E=;
        b=UOitu/hTvivEswr+8OYYsZ3LJe96lqtrLfh5lD/O6qGyMyvxhizPFGYQYF01uvHJz5
         qwQuGBuxleXg4RUySxVfZIUdTOnL+z8ngfdZFQITa6TQdXkeH4tWSneszfw+CIK62YJI
         fKTOtNseYg6niOuT7E+RIDISwhFVV3FO/8kKskN+eDKvmduyzNS6YJsC4EN2ZniWEbuc
         R81PYYeYqMUWalxtUn4RR+/x1TwmrO5YzN+TgFASotH6JlNWAzv4GwrM0fJX1llCG5RX
         rGBiyuweRCm7IqqXHrc5wKnbqH9xbaybPEuvcgeB35OHu3l4p9FLoHva2haC16CKVFyb
         eeEg==
X-Gm-Message-State: AGi0PuZ2pxVw7WdcVhMuRIOStmDnXcRtY6q9GhLB2Y73EXAN0vjGBeZS
        RtiTVvgnH+jtFEHxEUOwjP6g154iIG4bi2ym0VE=
X-Google-Smtp-Source: APiQypI4iyuFsjX6lHUN3/cdJwaNG61guNWpFzMRDra2F3HG/jDJPV/QdFBh9X4zpmxBHfJ5EtM9T/BQUfe+n/YWSeY=
X-Received: by 2002:aca:39c3:: with SMTP id g186mr58993oia.168.1586292885650;
 Tue, 07 Apr 2020 13:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200407184239.2700998-1-aduskett@gmail.com> <476DC76E7D1DF2438D32BFADF679FC5649EBB79F@ORSMSX101.amr.corp.intel.com>
 <CAFSsvmpmhuRD2gWj8ZaRkmZ42DoUM0evfb4tfJTgm8yu=qf2Jg@mail.gmail.com>
In-Reply-To: <CAFSsvmpmhuRD2gWj8ZaRkmZ42DoUM0evfb4tfJTgm8yu=qf2Jg@mail.gmail.com>
From:   Adam Duskett <aduskett@gmail.com>
Date:   Tue, 7 Apr 2020 13:54:35 -0700
Message-ID: <CAFSsvmrcyhA2xdyAp2vQwN+pqwtK8Tj4uGKicKZfiBCy5pf8BQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] fix building against musl and uClibc libc libraries.
To:     "Roberts, William C" <william.c.roberts@intel.com>
Cc:     "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I just ended up making a new branch that has the latest updated
commits and a new PR with an SOB line.

https://github.com/SELinuxProject/selinux/pull/218

On Tue, Apr 7, 2020 at 1:47 PM Adam Duskett <aduskett@gmail.com> wrote:
>
> I did that just now!
>
> On Tue, Apr 7, 2020 at 1:27 PM Roberts, William C
> <william.c.roberts@intel.com> wrote:
> >
> > > -----Original Message-----
> > > From: selinux-owner@vger.kernel.org [mailto:selinux-owner@vger.kernel.org]
> > > On Behalf Of aduskett@gmail.com
> > > Sent: Tuesday, April 7, 2020 1:43 PM
> > > To: selinux@vger.kernel.org
> > > Cc: Adam Duskett <Aduskett@gmail.com>
> > > Subject: [PATCH 1/1] fix building against musl and uClibc libc libraries.
> > >
> > > From: Adam Duskett <Aduskett@gmail.com>
> > >
> > > Currently, the src/Makefile provides the FTS_LDLIBS when building against musl
> > > or uClibc. However, this is missing from utils/Makefile, which causes linking to fail.
> > >
> > > Add the FTS_LDLIBS variable to the LDLIBS variable in utils/Makefile to fix
> > > compiling against uClibc and musl.
> > >
> > > Signed-off-by: Adam Duskett <Aduskett@gmail.com>
> > > ---
> > >  libselinux/utils/Makefile | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile index
> > > 36150638..a5632b7c 100644
> > > --- a/libselinux/utils/Makefile
> > > +++ b/libselinux/utils/Makefile
> > > @@ -45,7 +45,7 @@ endif
> > >
> > >  override CFLAGS += -I../include -D_GNU_SOURCE $(DISABLE_FLAGS)
> > > $(PCRE_CFLAGS)  override LDFLAGS += -L../src -override LDLIBS += -lselinux
> > > +override LDLIBS += -lselinux $(FTS_LDLIBS)
> > >  PCRE_LDLIBS ?= -lpcre
> > >
> > >  ifeq ($(ANDROID_HOST),y)
> > > --
> > > 2.25.1
> >
> > If you want me to use the PR you have open, force push your branch to update the commit
> > message. Else I'll have to create a new-pr and close your old one.
> >
> > Your open PR is here:
> > https://github.com/SELinuxProject/selinux/pull/193
> >
> > Something like:
> > git pull --rebase origin master
> > git push aduskett HEAD:fix-musl-and-uclibc-builds
> >
> > would be ideal.
> >
> > Acked-by: William Roberts <william.c.roberts@intel.com>
