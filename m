Return-Path: <SRS0=TGs9=7I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D56CC433DF
	for <selinux@archiver.kernel.org>; Tue, 26 May 2020 17:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 089EE2073B
	for <selinux@archiver.kernel.org>; Tue, 26 May 2020 17:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTQxmVzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgEZRPY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 May 2020 13:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbgEZRPY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 May 2020 13:15:24 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E287C03E96D
        for <selinux@vger.kernel.org>; Tue, 26 May 2020 10:15:24 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id j8so22819876iog.13
        for <selinux@vger.kernel.org>; Tue, 26 May 2020 10:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A/yBUKZk6FM5+NOg1PzWZuyw9Tmg6qXmT/4txeakSEg=;
        b=bTQxmVzDD5reQ2wcLWrWSjFPhGAwZBgeoZbfcPkb5ifisgIb6N6hF07f290IAledbG
         wJEhRFvfd3ZhR1nykV7GNAnnHJTQAZ3Xr9GyygDlXnr1nwzd9lwhDPGHMkMAqRC6rxwt
         9Ww567w4G365RuaPYdNrjwgP0SeSGewBsek4G11B8c9d4dK3c7pOMnWe8cx71fguXDJS
         3HORY7KxouNm5DDXUhHiZro7vdVpTSvBLRfNcTmawKhTPNWHx/mwEzADFIL6zrD6LAxz
         L8jMd9oTkqp4iKJUoLs6vKCjAsAiopEgsYzyK2aiDVkaNrg2Pd4v6YvCT7z+N0wQ+Ttk
         G5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A/yBUKZk6FM5+NOg1PzWZuyw9Tmg6qXmT/4txeakSEg=;
        b=BhzIZ9NFK8ivG5+0KJLhtNei0IGCP8LnHVLhjun8i3KJ+8iv4STz/6mCqCwDtIq/nR
         sW0rUm2mINIDupLl8e8/KFat7gLioB03JPYGsHq2NZffci7hM++gSdMcGUSBt7zZ4QRs
         xf8MFX8iedEwYBnjuV3hoMBOlg5uEit7g7RhYHx6FAKoskkwya5tElx2xzYe0J1vHDgC
         FTpuceUP866bJwaJ3jilQ7XtSDkGyiYKDkcnghMdTH5xh6aYqc4ce59W9qLKh7wFmRZI
         r3cu2vOWz3dHGbiMPmTtVI/Ps9OoSTXhHd0CNdaT8ffN2sojJEIh+J7VBlHykb/yGbUr
         FooA==
X-Gm-Message-State: AOAM532M0ao+JwSSShoGqQcPACUupDxdR4EV8xxLR6o+Aaapuj5678Xl
        6/JrVgbAWFOYmTYaLF1Hn3m56o8fcuFtAhyMTco=
X-Google-Smtp-Source: ABdhPJzD94o+/X78ICt/eNpTOqISOPsDozAOuN2YzFhK8qD3TsT6qvzEi9EY9kDzK6d+/ZbOOGLkp4sIFWAPcC/E7e8=
X-Received: by 2002:a5d:9910:: with SMTP id x16mr17914022iol.143.1590513323442;
 Tue, 26 May 2020 10:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200520152538.23184-1-william.c.roberts@intel.com> <CAFqZXNumYyhzFhzGGrKZcFrAeRMgy4-WqaXvqVwKM1285vSgsQ@mail.gmail.com>
In-Reply-To: <CAFqZXNumYyhzFhzGGrKZcFrAeRMgy4-WqaXvqVwKM1285vSgsQ@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Tue, 26 May 2020 12:15:11 -0500
Message-ID: <CAFftDdoAiXbZggb9bHDQB5juNJC+EzJT+4-Y74GvwWpHWmeMxg@mail.gmail.com>
Subject: Re: [PATCH] README: Add kernel-modules for SCTP
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     "Roberts, William C" <william.c.roberts@intel.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 26, 2020 at 8:17 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Wed, May 20, 2020 at 5:26 PM <william.c.roberts@intel.com> wrote:
> > From: William Roberts <william.c.roberts@intel.com>
> >
> > Some Fedora images, notably the Fedora 32 cloud image, do not have the
> > kernel modules package installed by default. Thus SCTP isn't available.
> > Add the proper kernel-modules package for the running kernel.
>
> Hm, I thought it wasn't possible to remove the kernel-modules package
> for the running kernel, but it really is...
>
> >
> > Note: This applies to selinux-testsuite.
> >
> > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > ---
> >  README.md | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/README.md b/README.md
> > index 1bec9fe85c91..1a4c70c40d56 100644
> > --- a/README.md
> > +++ b/README.md
> > @@ -77,7 +77,8 @@ following command:
> >                 kernel-devel-$(uname -r) \
> >                 quota \
> >                 xfsprogs-devel \
> > -               libuuid-devel
> > +               libuuid-devel \
> > +               kernel-modules-$(uname -r)
>
> Can you please put both the kernel-* packages together? I think it
> would be best to always have both at the end so that anyone who uses
> locally built kernels can easily copy the command without the two. Or
> I can just amend your patch when applying if you're OK with that.

Thats fine by me, thanks.

>
> >
> >  #### Debian
> >
> > --
> > 2.17.1
> >
>
> --
> Ondrej Mosnacek
> Software Engineer, Platform Security - SELinux kernel,
> Red Hat, Inc.
>
