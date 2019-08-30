Return-Path: <SRS0=26Hx=W2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E84C3A59B
	for <selinux@archiver.kernel.org>; Fri, 30 Aug 2019 21:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E5223407
	for <selinux@archiver.kernel.org>; Fri, 30 Aug 2019 21:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="01NUJ4DT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfH3ViW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Aug 2019 17:38:22 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36282 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfH3ViW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Aug 2019 17:38:22 -0400
Received: by mail-lj1-f195.google.com with SMTP id u15so7754869ljl.3
        for <selinux@vger.kernel.org>; Fri, 30 Aug 2019 14:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NzB2u2tMf++H6zBcovcHvslNOGQAdTWOG+rGU4fVdfU=;
        b=01NUJ4DTtsK2if6czPun5PCvptm0ob45gpS+PWcqfqbYxcwk2YC604l5+lEEZdj1Tg
         EHew20EZxfBGxlfYxFoQqrXjpP+HsIBbFGoZovVAWECu9WPAvFfd76HtVsrCc7dXvsG6
         HSU9ROJlWhtvm2aN8DlsHusFCaWVHoW6U+kyhnQDHgnCUwFLw+2+k+DK/dGn88tmMzQ3
         h7m+GWbKAy5h3wiOIEj61+EvS136DIyfFePTlIv0vhiBwmVeRHtp3TZnoyZPLzfpzeT1
         qBL2NP4Kzu7KeNHCZ2rEz1huzL6RU7EErERswRFavaD38MfUS43rVcKC5XABGDxXLs4a
         /3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NzB2u2tMf++H6zBcovcHvslNOGQAdTWOG+rGU4fVdfU=;
        b=aYSrI43JLWr/IpHbm7DccAEaC0rI4w/o6uH4eRCxv20OnLTAJvS+NU0vJdd4K2/S/m
         jI0LrpMPincQrLYHyIyUf9Osu9ySrzPcvWT1ElhA3doJVN1C8tPiYJwhmH0bOBrxGkd/
         y1UlOc1mQQApX+2e3LsORZ8Arr2pHMQobpMooA40PjnlhqAYm/fopAKpF1TYd2I7gHf6
         p78O1eBoP7VVvu7Mp/BXY3WD2zx+2d4oNgWlaTvpfH+1blLpSST/fVg7nRwiYEmJeMMS
         pbsrxgbW6jFn/NQaC4pGYXdkq3v8O5U0FvOeG+QyTWzMezjcNPZ+0x7QtLqNyONv4Z8S
         edcA==
X-Gm-Message-State: APjAAAXfetvVh4BJDNQgvFKwXslR0R+w2kbVoxpPlyY5XxeiwyIlylWj
        2rbRnhlpoDbayT56E4QJivToPQRMmdNfyJXBjySCjdkcbg==
X-Google-Smtp-Source: APXvYqzyzwkLRh0dJ55s09x7iDZLJZBlRsQtHeGgIo+TL1FBYFfuSkmauaA6qYVzQY/cyVCs1YH5mY/Psi4ZyOaSv2k=
X-Received: by 2002:a2e:6393:: with SMTP id s19mr9351407lje.46.1567201100027;
 Fri, 30 Aug 2019 14:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190828204259.23160-1-joshua.brindle@crunchydata.com>
 <CAHC9VhQVeSvqFYA9tgVZi9p5B6mDWdnsREJUYfP-oSGi17YhUQ@mail.gmail.com>
 <CAGB+Vh7dg-2mmtAYsFp3+v6a5DD1mRycOxqRLWOx1tcUOmvWYw@mail.gmail.com>
 <CAHC9VhRoTyyXb5iGW-NY7EVYmmE1m8CJJLh0dLswxgVp_tG7Gg@mail.gmail.com> <CAGB+Vh7GpEC5vzvUFiUrzvKEq4ihOENZdM9dOvcL+Lap4Uh96w@mail.gmail.com>
In-Reply-To: <CAGB+Vh7GpEC5vzvUFiUrzvKEq4ihOENZdM9dOvcL+Lap4Uh96w@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 30 Aug 2019 17:38:08 -0400
Message-ID: <CAHC9VhSBXGGQVoaXd0b8vh04Lgrfmx1Fsd=706yr=6g6tORbxA@mail.gmail.com>
Subject: Re: [PATCH v2] default_range glblub implementation
To:     Joshua Brindle <joshua.brindle@crunchydata.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 29, 2019 at 1:11 PM Joshua Brindle
<joshua.brindle@crunchydata.com> wrote:
> On Thu, Aug 29, 2019 at 12:59 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Thu, Aug 29, 2019 at 9:29 AM Joshua Brindle
> > <joshua.brindle@crunchydata.com> wrote:
> > > On Wed, Aug 28, 2019 at 6:31 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Wed, Aug 28, 2019 at 4:43 PM Joshua Brindle
> > > > <joshua.brindle@crunchydata.com> wrote:
> > > > >
> > > > > A policy developer can now specify glblub as a default_range default and
> > > > > the computed transition will be the intersection of the mls range of
> > > > > the two contexts.
> > > > >
> > > > > The glb (greatest lower bound) lub (lowest upper bound) of a range is calculated
> > > > > as the greater of the low sensitivities and the lower of the high sensitivities
> > > > > and the and of each category bitmap.
> > > > >
> > > > > This can be used by MLS solution developers to compute a context that satisfies,
> > > > > for example, the range of a network interface and the range of a user logging in.
> > > > >
> > > > > Some examples are:
> > > > >
> > > > > User Permitted Range | Network Device Label | Computed Label
> > > > > ---------------------|----------------------|----------------
> > > > > S0-S1:c0.c12         | S0                   | S0
> > > > > S0-S1:c0.c12         | S0-S1:c0.c1024       | S0-S1:c0.c12
> > > > > S0-S4:c0.c512        | S1-S1:c0.c1024       | S1-S1:c0.c512
> > > > > S0-S16:c0,c2         | S4-S6:c0.c128        | S4-S6:c0,c2
> > > > > S0-S4                | S2-S6                | S2-S4
> > > > > S0-S4                | S5-S8                | INVALID
> > > > > S5-S8                | S0-S4                | INVALID
> > > > > S6:c0,c2-S7:c4,c5    | S0:c2,c4-S6:c5.c100  | S6:c2-S6:c5
> > > > >
> > > > > Signed-off-by: Joshua Brindle <joshua.brindle@crunchydata.com>
> > > > > ---
> > > > >  security/selinux/include/security.h |  3 ++-
> > > > >  security/selinux/ss/context.h       | 28 ++++++++++++++++++++++++++++
> > > > >  security/selinux/ss/ebitmap.c       | 18 ++++++++++++++++++
> > > > >  security/selinux/ss/ebitmap.h       |  1 +
> > > > >  security/selinux/ss/mls.c           |  2 ++
> > > > >  security/selinux/ss/policydb.c      |  5 +++++
> > > > >  security/selinux/ss/policydb.h      |  1 +
> > > > >  7 files changed, 57 insertions(+), 1 deletion(-)
> > > >
> > > > You incorporated some feedback from the v1 patch, but you ignored
> > > > some, can you explain why?
> > > >
> > >
> > > I apologize, I missed a couple C++ style comments, I'll fix those and
> > > resend, was there anything else? I thought I addressed all of the
> > > technical concerns.
> >
> > My biggest concern wasn't really the style nits (although please do
> > fix those), but rather the guts of ebitmap_and() and the use of
> > ebitmap_get_bit() instead of something a bit more efficient.  Here is
> > my original comment:
> >
> >   "Beyond that, since this is an AND operation, could we make better
> >    use of things like find_first_bit()/ebitmap_start_positive()/
> >    ebitmap_next_positive() to skip along one of the bitmaps instead
> >    of needing to call ebitmap_get_bit() for each bit?  I imagine it
> >    would be quicker that way."
> >
>
> I used ebitmap_for_each_positive_bit() for the outer loop which uses
> ebitmap_start_positive() and ebitmap_next_positive().

Sorry, my mistake.  Your implementation wasn't quite what I was
expecting and on quick glance it looked similar to your previous
effort so I assumed it hadn't changed.  The v2 variant should be fine.

> I suppose I could try to track both lists at the same time and AND the
> bitmaps when the startbit is the same but I don't expect this to
> really be any kind of bottleneck.

-- 
paul moore
www.paul-moore.com
