Return-Path: <SRS0=Y9t7=WZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B9AC3A59F
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 13:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827FA233FF
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 13:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="JXhHdXVC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfH2N3W (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Aug 2019 09:29:22 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39787 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfH2N3V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Aug 2019 09:29:21 -0400
Received: by mail-oi1-f196.google.com with SMTP id 16so2520622oiq.6
        for <selinux@vger.kernel.org>; Thu, 29 Aug 2019 06:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T1hKITpKjzq9nz+xM9sYATlFjza9RVPaxbJoRln/xFI=;
        b=JXhHdXVCd1PmfMJ5WdhY5coTuojhy1ke70iSMbVt4o8AfDQlNIL9lLv+GWQmArp2sN
         JrNc1FQoG/AAP2kSiY20jx2bo+d5NJ+m6fBGSZTUjrFxDn1MCyjzeQ8IsjR95ENrHo24
         /E8FHicPKqE4w6jyluVFHwiUW2pbPlx+EOssW7iu4IviBLbEFQhtOC0iZn4/Anbn4SLi
         cw86hJD9aHrYj4D4tbUaxddA9EbWrCn55dy33wuWDzhQIr4WBbl9bNkHHjADeTiAfy+v
         Rofh02qV2VXWvk5a8SGUjkpOD7eQKP3NNJHXDgWmSKjCHrI0jddhBvffMtSFHlsMMmkd
         OMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T1hKITpKjzq9nz+xM9sYATlFjza9RVPaxbJoRln/xFI=;
        b=TRPeYxybjoDxf6CsQatzlFYAgWrEYvrco7c/yO8EIzvBWVLnmMB02lXNlC8ah1iHzG
         MxMYET932y5ctV9mxqVZImpmig14RCxQcd5pgUgQk98S+iaV3Pb21wjJh6yMf1hEgmy9
         seTat0x0kinf+8YyyIcOhYaCQuf3/uofWcaOsoqKet68QYn18UVNGY608IwyLk/PO8ZD
         f9A1eamxNlLN8gGpe1b1Tq5NwCPP8aTbdq+84a5NZLT4E9PYv1CQdN7Fx93cxn4JIfKT
         sVyQCINA2ithatA/KNUHzUkZnWONyrf2Y3S/SfBWI20Tp/oBzHM2Zcl26fuYSU9ezDjo
         obTg==
X-Gm-Message-State: APjAAAX6dogVPhhv6Q5mJVidCFUdMlCoww1/iv2nrOKQAOAP81uxioH+
        PqNTLjjkQJf5p5TCWJd24aZPs96b7LAMn45bKRqDKZRb
X-Google-Smtp-Source: APXvYqzICy7g+Y+92ch8zINDpLngfRlbZ1ZP0Fui0PTXPE6mQekeuyq4lCiwG4xcsNK20lzm3XIPBWBRwKEaLw5j0Ps=
X-Received: by 2002:a05:6808:8da:: with SMTP id k26mr6282462oij.178.1567085360721;
 Thu, 29 Aug 2019 06:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190828204259.23160-1-joshua.brindle@crunchydata.com> <CAHC9VhQVeSvqFYA9tgVZi9p5B6mDWdnsREJUYfP-oSGi17YhUQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQVeSvqFYA9tgVZi9p5B6mDWdnsREJUYfP-oSGi17YhUQ@mail.gmail.com>
From:   Joshua Brindle <joshua.brindle@crunchydata.com>
Date:   Thu, 29 Aug 2019 09:29:10 -0400
Message-ID: <CAGB+Vh7dg-2mmtAYsFp3+v6a5DD1mRycOxqRLWOx1tcUOmvWYw@mail.gmail.com>
Subject: Re: [PATCH v2] default_range glblub implementation
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 28, 2019 at 6:31 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Wed, Aug 28, 2019 at 4:43 PM Joshua Brindle
> <joshua.brindle@crunchydata.com> wrote:
> >
> > A policy developer can now specify glblub as a default_range default and
> > the computed transition will be the intersection of the mls range of
> > the two contexts.
> >
> > The glb (greatest lower bound) lub (lowest upper bound) of a range is calculated
> > as the greater of the low sensitivities and the lower of the high sensitivities
> > and the and of each category bitmap.
> >
> > This can be used by MLS solution developers to compute a context that satisfies,
> > for example, the range of a network interface and the range of a user logging in.
> >
> > Some examples are:
> >
> > User Permitted Range | Network Device Label | Computed Label
> > ---------------------|----------------------|----------------
> > S0-S1:c0.c12         | S0                   | S0
> > S0-S1:c0.c12         | S0-S1:c0.c1024       | S0-S1:c0.c12
> > S0-S4:c0.c512        | S1-S1:c0.c1024       | S1-S1:c0.c512
> > S0-S16:c0,c2         | S4-S6:c0.c128        | S4-S6:c0,c2
> > S0-S4                | S2-S6                | S2-S4
> > S0-S4                | S5-S8                | INVALID
> > S5-S8                | S0-S4                | INVALID
> > S6:c0,c2-S7:c4,c5    | S0:c2,c4-S6:c5.c100  | S6:c2-S6:c5
> >
> > Signed-off-by: Joshua Brindle <joshua.brindle@crunchydata.com>
> > ---
> >  security/selinux/include/security.h |  3 ++-
> >  security/selinux/ss/context.h       | 28 ++++++++++++++++++++++++++++
> >  security/selinux/ss/ebitmap.c       | 18 ++++++++++++++++++
> >  security/selinux/ss/ebitmap.h       |  1 +
> >  security/selinux/ss/mls.c           |  2 ++
> >  security/selinux/ss/policydb.c      |  5 +++++
> >  security/selinux/ss/policydb.h      |  1 +
> >  7 files changed, 57 insertions(+), 1 deletion(-)
>
> You incorporated some feedback from the v1 patch, but you ignored
> some, can you explain why?
>

I apologize, I missed a couple C++ style comments, I'll fix those and
resend, was there anything else? I thought I addressed all of the
technical concerns.

> For reference, here are my comments on your first patch:
> * https://lore.kernel.org/selinux/CAHC9VhRXyRDjj3KJDHvA4ruJg6H+1kzFPzfA-PLZ-NqBicsLrw@mail.gmail.com/
>
> --
> paul moore
> www.paul-moore.com
