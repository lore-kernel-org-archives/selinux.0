Return-Path: <SRS0=Y9t7=WZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B31DC3A59F
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 16:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F13208C2
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 16:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="wl+xjOzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfH2Q7F (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Aug 2019 12:59:05 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35011 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfH2Q7F (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Aug 2019 12:59:05 -0400
Received: by mail-lf1-f66.google.com with SMTP id h27so3118004lfp.2
        for <selinux@vger.kernel.org>; Thu, 29 Aug 2019 09:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5qtDBydkjGbGU3RIcdA1PBZZ+RimzqQTIQIa6MMW4aw=;
        b=wl+xjOzUnSn5XCGe6lnfXDFQrDI0KzEXsIR+3VZziawud6pVKdjPjHHUFySxiFtrpF
         q37BlPSakpPRen/QBQIP/VxQXBjb7zqiZaebOcy+mRU48vFUY3zbqOvX24RtXm6FxjnX
         5bQWCv1Xn6qC0DDBVzW/5vko3yHWSWall7OrXmGkWYMDo0BAol++v8VT3YH6/yG4qCES
         Z4VZTXsddc47AV2QzSBaXJ0RTqEzDtCRm38EMKV3l+SGzgT8ezXjq1sNTjwCFb3MTIyO
         M5XeWhBS6wnXX8OACPdaaBNyeM0b4YDV6SwlbAdlDTNDJcgtyzd/CAQY/HHEuu0bsjji
         Bszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5qtDBydkjGbGU3RIcdA1PBZZ+RimzqQTIQIa6MMW4aw=;
        b=d0loH7arKOfdyD1f7gS4CmABUjwmXMIm/Ry11o4ObnlLfcSQjRG3aMyXzRoWbFWUBi
         ZHQduhcae/gholR8Ss07ID0+3SzFdQs8eClqCDZAc4QJFs/S3yKNxEdcCWYHuvINahRf
         vooxU4H5wGRL4HzGxDJh7sXeUoGakfHGVZSh+olT0FO5WpGuKxnOkQhaLRVMH+Z4lh1z
         rld/K4KrS0fGiJRFq+F5Wp/BCRf641cVwkrknwrNwYg/V1cUdgGBvuoMJ4VahlX5omPX
         Ible61pit6P1UVKhdTah7hultiePQlK4X2TwrkZF/mQV79eW8jyuJ3m/Nrv8MM+vH/6x
         s/NQ==
X-Gm-Message-State: APjAAAWgvwtnMidFfUokhe4y02qHw6NVm8vB0znWxhtMVBhmDeZaAmgp
        yOXy6opzYxduWQ1SrDppJCcGqDLUzM6FI8Gz0dOshGDFse/r
X-Google-Smtp-Source: APXvYqxVOYXIle+pXLFeZDZiQ/Nmwxj0NTzhiSCIL+yNiKBiTt9GU/z7bNte0P9uzlZelN4tWTxQjdSKP+40ZWyaq7c=
X-Received: by 2002:ac2:4474:: with SMTP id y20mr6251795lfl.31.1567097943258;
 Thu, 29 Aug 2019 09:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190828204259.23160-1-joshua.brindle@crunchydata.com>
 <CAHC9VhQVeSvqFYA9tgVZi9p5B6mDWdnsREJUYfP-oSGi17YhUQ@mail.gmail.com> <CAGB+Vh7dg-2mmtAYsFp3+v6a5DD1mRycOxqRLWOx1tcUOmvWYw@mail.gmail.com>
In-Reply-To: <CAGB+Vh7dg-2mmtAYsFp3+v6a5DD1mRycOxqRLWOx1tcUOmvWYw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 29 Aug 2019 12:58:51 -0400
Message-ID: <CAHC9VhRoTyyXb5iGW-NY7EVYmmE1m8CJJLh0dLswxgVp_tG7Gg@mail.gmail.com>
Subject: Re: [PATCH v2] default_range glblub implementation
To:     Joshua Brindle <joshua.brindle@crunchydata.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 29, 2019 at 9:29 AM Joshua Brindle
<joshua.brindle@crunchydata.com> wrote:
> On Wed, Aug 28, 2019 at 6:31 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Wed, Aug 28, 2019 at 4:43 PM Joshua Brindle
> > <joshua.brindle@crunchydata.com> wrote:
> > >
> > > A policy developer can now specify glblub as a default_range default and
> > > the computed transition will be the intersection of the mls range of
> > > the two contexts.
> > >
> > > The glb (greatest lower bound) lub (lowest upper bound) of a range is calculated
> > > as the greater of the low sensitivities and the lower of the high sensitivities
> > > and the and of each category bitmap.
> > >
> > > This can be used by MLS solution developers to compute a context that satisfies,
> > > for example, the range of a network interface and the range of a user logging in.
> > >
> > > Some examples are:
> > >
> > > User Permitted Range | Network Device Label | Computed Label
> > > ---------------------|----------------------|----------------
> > > S0-S1:c0.c12         | S0                   | S0
> > > S0-S1:c0.c12         | S0-S1:c0.c1024       | S0-S1:c0.c12
> > > S0-S4:c0.c512        | S1-S1:c0.c1024       | S1-S1:c0.c512
> > > S0-S16:c0,c2         | S4-S6:c0.c128        | S4-S6:c0,c2
> > > S0-S4                | S2-S6                | S2-S4
> > > S0-S4                | S5-S8                | INVALID
> > > S5-S8                | S0-S4                | INVALID
> > > S6:c0,c2-S7:c4,c5    | S0:c2,c4-S6:c5.c100  | S6:c2-S6:c5
> > >
> > > Signed-off-by: Joshua Brindle <joshua.brindle@crunchydata.com>
> > > ---
> > >  security/selinux/include/security.h |  3 ++-
> > >  security/selinux/ss/context.h       | 28 ++++++++++++++++++++++++++++
> > >  security/selinux/ss/ebitmap.c       | 18 ++++++++++++++++++
> > >  security/selinux/ss/ebitmap.h       |  1 +
> > >  security/selinux/ss/mls.c           |  2 ++
> > >  security/selinux/ss/policydb.c      |  5 +++++
> > >  security/selinux/ss/policydb.h      |  1 +
> > >  7 files changed, 57 insertions(+), 1 deletion(-)
> >
> > You incorporated some feedback from the v1 patch, but you ignored
> > some, can you explain why?
> >
>
> I apologize, I missed a couple C++ style comments, I'll fix those and
> resend, was there anything else? I thought I addressed all of the
> technical concerns.

My biggest concern wasn't really the style nits (although please do
fix those), but rather the guts of ebitmap_and() and the use of
ebitmap_get_bit() instead of something a bit more efficient.  Here is
my original comment:

  "Beyond that, since this is an AND operation, could we make better
   use of things like find_first_bit()/ebitmap_start_positive()/
   ebitmap_next_positive() to skip along one of the bitmaps instead
   of needing to call ebitmap_get_bit() for each bit?  I imagine it
   would be quicker that way."

> > For reference, here are my comments on your first patch:
> > * https://lore.kernel.org/selinux/CAHC9VhRXyRDjj3KJDHvA4ruJg6H+1kzFPzfA-PLZ-NqBicsLrw@mail.gmail.com/

-- 
paul moore
www.paul-moore.com
