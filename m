Return-Path: <SRS0=Y9t7=WZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF18C3A59F
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 17:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02052189D
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 17:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="v/ff9ZNU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfH2RLp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Aug 2019 13:11:45 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34470 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfH2RLo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Aug 2019 13:11:44 -0400
Received: by mail-ot1-f65.google.com with SMTP id c7so4190876otp.1
        for <selinux@vger.kernel.org>; Thu, 29 Aug 2019 10:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LLFwB718xwnPmd1mJSQTWuWbRYIaTL+v1XQHQcP2gl8=;
        b=v/ff9ZNUN2URZYbsw1DxFP4C/dBieQ4WdDYhpLkebd8hQHVWz1rdUusdJrVbwcpqZ/
         q072mVZZHUWUJbWQOeV4aGNPZahQfac/Df2KkjKwnK05DU7bklPu9BJUf2aMQ6XWBRaj
         218klUtfT2Dp2MOpVECe4+KVvETjMrsNHsFf1HzekPnYLMi76gPy1RysVwrQcJrBZhCn
         E1e0/Vtco8gG2Y5S1pypQrld+7hItQrAe6GIo9UMGaVpmkNnmVU/cChuzyPzqdXkWWIp
         UAsaDbu0VqEDpGAMcyDu3FN0zR7uINsdw1pJJ+1bH/DjzxYEtEvSp/xnh90yy0fPKNKW
         9lCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LLFwB718xwnPmd1mJSQTWuWbRYIaTL+v1XQHQcP2gl8=;
        b=ZUz6w5JrNSn/9Q2MvH6iTu0OYn9vYTCDy9LHRIvP62Ctf7ibwlDJKZ3hgtZClPqaU6
         dUCJAo+1Go7qErukmvyxoURT2GP7bUZ3KjZ7G0Fm56Oi4GrIbMJpbEkWZdw2T2I5G7zB
         TbCUUIkfI+fWw2Q1tvbK5cxOcmyMQbp3evu1r+gTcvMVYJNUNmwZNI+wgV3vvxb65MDt
         iCpa8LhBpI4Ehb3+geTsLAw3IyibnVTsHBgcqQSynASUI+cLcK5U2x45kjOsqtz//ZOn
         etBNS77gjMBDlpk+m4C/01bmJUktyj1Cioke0RDiOBBfV6A5iyPLZLszD2xcomEbmcmc
         yU0Q==
X-Gm-Message-State: APjAAAXlmXfD/VQeohBMMFhy7XPcrXjHw6PQNpZmf1fBI5RSD8NpAyrB
        z98McE1+imtvP4Rjq8vBQdk5PeGRKiLFB/gyJhU3PJg9xBY=
X-Google-Smtp-Source: APXvYqyRIYFb3EowJvld+8FM4cwsyaEz52N89wKU7UnBcdLLKC3aYd31g5BIe17fSwVTz8XBMgCQB6TEYzKpnHdHBCQ=
X-Received: by 2002:a9d:4c18:: with SMTP id l24mr8263012otf.168.1567098703981;
 Thu, 29 Aug 2019 10:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190828204259.23160-1-joshua.brindle@crunchydata.com>
 <CAHC9VhQVeSvqFYA9tgVZi9p5B6mDWdnsREJUYfP-oSGi17YhUQ@mail.gmail.com>
 <CAGB+Vh7dg-2mmtAYsFp3+v6a5DD1mRycOxqRLWOx1tcUOmvWYw@mail.gmail.com> <CAHC9VhRoTyyXb5iGW-NY7EVYmmE1m8CJJLh0dLswxgVp_tG7Gg@mail.gmail.com>
In-Reply-To: <CAHC9VhRoTyyXb5iGW-NY7EVYmmE1m8CJJLh0dLswxgVp_tG7Gg@mail.gmail.com>
From:   Joshua Brindle <joshua.brindle@crunchydata.com>
Date:   Thu, 29 Aug 2019 13:11:33 -0400
Message-ID: <CAGB+Vh7GpEC5vzvUFiUrzvKEq4ihOENZdM9dOvcL+Lap4Uh96w@mail.gmail.com>
Subject: Re: [PATCH v2] default_range glblub implementation
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 29, 2019 at 12:59 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Aug 29, 2019 at 9:29 AM Joshua Brindle
> <joshua.brindle@crunchydata.com> wrote:
> > On Wed, Aug 28, 2019 at 6:31 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Wed, Aug 28, 2019 at 4:43 PM Joshua Brindle
> > > <joshua.brindle@crunchydata.com> wrote:
> > > >
> > > > A policy developer can now specify glblub as a default_range default and
> > > > the computed transition will be the intersection of the mls range of
> > > > the two contexts.
> > > >
> > > > The glb (greatest lower bound) lub (lowest upper bound) of a range is calculated
> > > > as the greater of the low sensitivities and the lower of the high sensitivities
> > > > and the and of each category bitmap.
> > > >
> > > > This can be used by MLS solution developers to compute a context that satisfies,
> > > > for example, the range of a network interface and the range of a user logging in.
> > > >
> > > > Some examples are:
> > > >
> > > > User Permitted Range | Network Device Label | Computed Label
> > > > ---------------------|----------------------|----------------
> > > > S0-S1:c0.c12         | S0                   | S0
> > > > S0-S1:c0.c12         | S0-S1:c0.c1024       | S0-S1:c0.c12
> > > > S0-S4:c0.c512        | S1-S1:c0.c1024       | S1-S1:c0.c512
> > > > S0-S16:c0,c2         | S4-S6:c0.c128        | S4-S6:c0,c2
> > > > S0-S4                | S2-S6                | S2-S4
> > > > S0-S4                | S5-S8                | INVALID
> > > > S5-S8                | S0-S4                | INVALID
> > > > S6:c0,c2-S7:c4,c5    | S0:c2,c4-S6:c5.c100  | S6:c2-S6:c5
> > > >
> > > > Signed-off-by: Joshua Brindle <joshua.brindle@crunchydata.com>
> > > > ---
> > > >  security/selinux/include/security.h |  3 ++-
> > > >  security/selinux/ss/context.h       | 28 ++++++++++++++++++++++++++++
> > > >  security/selinux/ss/ebitmap.c       | 18 ++++++++++++++++++
> > > >  security/selinux/ss/ebitmap.h       |  1 +
> > > >  security/selinux/ss/mls.c           |  2 ++
> > > >  security/selinux/ss/policydb.c      |  5 +++++
> > > >  security/selinux/ss/policydb.h      |  1 +
> > > >  7 files changed, 57 insertions(+), 1 deletion(-)
> > >
> > > You incorporated some feedback from the v1 patch, but you ignored
> > > some, can you explain why?
> > >
> >
> > I apologize, I missed a couple C++ style comments, I'll fix those and
> > resend, was there anything else? I thought I addressed all of the
> > technical concerns.
>
> My biggest concern wasn't really the style nits (although please do
> fix those), but rather the guts of ebitmap_and() and the use of
> ebitmap_get_bit() instead of something a bit more efficient.  Here is
> my original comment:
>
>   "Beyond that, since this is an AND operation, could we make better
>    use of things like find_first_bit()/ebitmap_start_positive()/
>    ebitmap_next_positive() to skip along one of the bitmaps instead
>    of needing to call ebitmap_get_bit() for each bit?  I imagine it
>    would be quicker that way."
>

I used ebitmap_for_each_positive_bit() for the outer loop which uses
ebitmap_start_positive() and ebitmap_next_positive().

I suppose I could try to track both lists at the same time and AND the
bitmaps when the startbit is the same but I don't expect this to
really be any kind of bottleneck.

> > > For reference, here are my comments on your first patch:
> > > * https://lore.kernel.org/selinux/CAHC9VhRXyRDjj3KJDHvA4ruJg6H+1kzFPzfA-PLZ-NqBicsLrw@mail.gmail.com/
>
> --
> paul moore
> www.paul-moore.com
