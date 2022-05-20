Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2CCC433EF
	for <selinux@archiver.kernel.org>; Fri, 20 May 2022 12:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347362AbiETMrN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 May 2022 08:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345523AbiETMrM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 May 2022 08:47:12 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3250C7983E
        for <selinux@vger.kernel.org>; Fri, 20 May 2022 05:47:11 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id i66so9790630oia.11
        for <selinux@vger.kernel.org>; Fri, 20 May 2022 05:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mTaNDBAzdUB9+VA99M2xIe0NHn88AkPslLdImuc/Zuo=;
        b=gbrv+6ztezDM/xbtbWlmTurhdZjyRdYMZVMFza4VTwPfKYUAaq4KRTZjrxpd5tXl5R
         ccHTopVhImoVkV2RCM7oTKxLS/pI46SYfO38QsSztIarI98JSX4M4Z3BaIL0BMz1LyCb
         5VH5PwshqqV4yAdtrSmJA64rBcs8x39aPeBFJIhBYpL0dO2js6rq2LXYOQ4i70zCe1Xs
         9B3HH7G5P4xgVoTA28du1NNyCIM5SUf+PuPUQQLz5kiuVMPdQxRLj8zJH8e/EOEKP8f8
         tX1yjbY4KaiVOi5crlBYku2Unfg55mrjCaQ34BRy+QXHPtRggaZqZXXHMPvl/UQoroty
         l3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mTaNDBAzdUB9+VA99M2xIe0NHn88AkPslLdImuc/Zuo=;
        b=BOv6S1D5QN3IdJO59YU5dnP3C5TLDGks/YNPaeG0hBwIuNBJlT3dz2xkmLkizEYZfB
         wgdeDQ0uahS9Ail+iEeS5FjLDdg3QoiZqfJdUA913dfP30m4GXrvBd4HzYKYXrsfuFmp
         EfR0tSOQnYx9tWl5CVaemeRZy5IA2gEcaRuFh+tkreRJ7s+u4jYg2N7phyDNiWjVryoS
         o3QrFQxRSZ5673w+I0D+qIHhEgWWhJm5umBlwjCgbCSDPQUUHvC5bbJ9gEAqtLrTTQ9W
         gvd2XJjNE5pQnF3oKTwkckRetyqcHRBG8moa38G6j6v8+vA/brawcp8CS80XE9NNMhxb
         8LHA==
X-Gm-Message-State: AOAM532M8nTBdqjFNlxertJpSOkSs9JVLP6VZVnL054hghc/UPdbG66e
        moIHwOY7yB4REso484QfZNDvWdz4lAWqHg1SvfwXCIU3
X-Google-Smtp-Source: ABdhPJzAj+eRimaDmX4K1KQuKS0S1t1qOtIh8T+jja9Bjut5o0uKnelxvEKREqjy5k7e8UCgIqmw8F0RGRRWcHjna84=
X-Received: by 2002:a05:6808:3009:b0:2f9:6119:d676 with SMTP id
 ay9-20020a056808300900b002f96119d676mr5282648oib.205.1653050830304; Fri, 20
 May 2022 05:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220517140748.24238-1-cgzones@googlemail.com>
 <20220517140748.24238-2-cgzones@googlemail.com> <CAP+JOzTaf4XNWVy1opWxFx+ymu-f=+LJ6ht7vwDWbQXy71LHWw@mail.gmail.com>
In-Reply-To: <CAP+JOzTaf4XNWVy1opWxFx+ymu-f=+LJ6ht7vwDWbQXy71LHWw@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Fri, 20 May 2022 14:46:59 +0200
Message-ID: <CAJ2a_DdypJ-d5QHn1xF=EqDeqw8M30EiToOavk_cka-gmV_48w@mail.gmail.com>
Subject: Re: [PATCH 2/2] libselinux: restorecon: avoid printing NULL pointer
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 18 May 2022 at 15:54, James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, May 17, 2022 at 3:20 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > The variable `curcon` is NULL in case the file has no current security
> > context.  Most C standard libraries handle it fine, avoid it nonetheles=
s
> > for standard conformance.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> > "(null)" might not be the best token to display, it was only taken to
> > not change current behavior
> > ---
> >  libselinux/src/selinux_restorecon.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selin=
ux_restorecon.c
> > index 1a185ced..1b21a605 100644
> > --- a/libselinux/src/selinux_restorecon.c
> > +++ b/libselinux/src/selinux_restorecon.c
> > @@ -771,7 +771,9 @@ static int restorecon_sb(const char *pathname, stru=
ct rest_flags *flags, bool fi
> >                         selinux_log(SELINUX_INFO,
> >                                     "%s %s from %s to %s\n",
> >                                     updated ? "Relabeled" : "Would rela=
bel",
> > -                                   pathname, curcon, newcon);
> > +                                   pathname,
> > +                                   curcon ? curcon : "(null)",
>
> Use "<<none>>", this is already used in file context files to indicate
> a file should not have a label.

"<<none>>" used in file contexts definitions does not mean no security
context but never relabel the existing context.
Maybe something like "<no context>" or "<empty context>"?

>
> Thanks,
> Jim
>
> > +                                   newcon);
> >
> >                 if (flags->syslog_changes && !flags->nochange) {
> >                         if (curcon)
> > --
> > 2.36.1
> >
