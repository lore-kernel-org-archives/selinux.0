Return-Path: <SRS0=OlHu=DK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F11EC4363D
	for <selinux@archiver.kernel.org>; Sat,  3 Oct 2020 08:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D46E3206CA
	for <selinux@archiver.kernel.org>; Sat,  3 Oct 2020 08:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgJCICW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 3 Oct 2020 04:02:22 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:41101 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgJCICV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 3 Oct 2020 04:02:21 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 7F4C2564913
        for <selinux@vger.kernel.org>; Sat,  3 Oct 2020 09:55:27 +0200 (CEST)
Received: by mail-oi1-f179.google.com with SMTP id c13so3617030oiy.6
        for <selinux@vger.kernel.org>; Sat, 03 Oct 2020 00:55:27 -0700 (PDT)
X-Gm-Message-State: AOAM530uQ00QxxWwmlwnPJ2/pdHDqSU4LCfqu3CwicvY2BSiP4ftqx8t
        /VRnmczCJn1u27rsLJpqSawANewkAedpo++pMYA=
X-Google-Smtp-Source: ABdhPJz+xIESDbBOiKU4vWhTl2OR5ZCeavIMOPvyY+f6U3mCMmRLvbWVA3ECGrVUy1VUD6HZSz1f9X82Lxz4zAE4QcE=
X-Received: by 2002:aca:f455:: with SMTP id s82mr1888206oih.40.1601711726438;
 Sat, 03 Oct 2020 00:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200907174712.290567-1-dominick.grift@defensec.nl>
 <20200908085329.409762-1-dominick.grift@defensec.nl> <CAJfZ7=khmKePn+=oA87mPXSZEgCiVzZ-3hJZZHF927a+=2R3TQ@mail.gmail.com>
In-Reply-To: <CAJfZ7=khmKePn+=oA87mPXSZEgCiVzZ-3hJZZHF927a+=2R3TQ@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 3 Oct 2020 09:55:15 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=nyP_M-F6zECcHmZTL_=wsNi-AJJbRCyDeN7gXsk-__Hw@mail.gmail.com>
Message-ID: <CAJfZ7=nyP_M-F6zECcHmZTL_=wsNi-AJJbRCyDeN7gXsk-__Hw@mail.gmail.com>
Subject: Re: [PATCH v2] cil_network_labeling_statements: fixes nodecon examples
To:     Dominick Grift <dominick.grift@defensec.nl>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Oct  3 09:55:27 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 2, 2020 at 9:01 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Tue, Sep 8, 2020 at 10:53 AM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
> >
> > The order of the subnet and netmask is wrong and also the value of netmask is wrong for single address subnet
> > Use an ipaddr reserved for documentation: https://tools.ietf.org/html/rfc5737
> > Add ipv6 example: https://tools.ietf.org/html/rfc3849
>
> It seems that this patch slipped through the review process, as there
> could have been some confusion about the repository it was for. It
> seems to me that it is for https://github.com/SELinuxProject/selinux,
> and its contents looks good. Thanks!
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> If nobody complains, I will apply this patch tonight.
> Nicolas

Merged. Thanks!
Nicolas

> > Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> > ---
> > I added a ip6 example because the old style netmask makes that a bit unclear. I know I will appreciate such an example later on.
> >
> >  .../docs/cil_network_labeling_statements.md   | 19 ++++++++++++++-----
> >  1 file changed, 14 insertions(+), 5 deletions(-)
> >
> > diff --git a/secilc/docs/cil_network_labeling_statements.md b/secilc/docs/cil_network_labeling_statements.md
> > index 49a836c1..60aec80d 100644
> > --- a/secilc/docs/cil_network_labeling_statements.md
> > +++ b/secilc/docs/cil_network_labeling_statements.md
> > @@ -145,12 +145,21 @@ These examples show named and anonymous [`nodecon`](cil_network_labeling_stateme
> >      (context context_1 (unconfined.user object_r unconfined.object low_low))
> >      (context context_2 (unconfined.user object_r unconfined.object (systemlow level_2)))
> >
> > -    (ipaddr netmask_1 255.255.255.0)
> > -    (ipaddr ipv4_1 192.168.1.64)
> > +    (ipaddr netmask_1 255.255.255.255)
> > +    (ipaddr ipv4_1 192.0.2.64)
> > +
> > +    (nodecon ipv4_1 netmask_1 context_2)
> > +    (nodecon (192.0.2.64) (255.255.255.255) context_1)
> > +    (nodecon (192.0.2.64) netmask_1 (unconfined.user object_r unconfined.object ((s0) (s0 (c0)))))
> > +
> > +    (context context_3 (sys.id sys.role my48prefix.node ((s0)(s0))))
> > +
> > +    (ipaddr netmask_2 ffff:ffff:ffff:0:0:0:0:0)
> > +    (ipaddr ipv6_2  2001:db8:1:0:0:0:0:0)
> >
> > -    (nodecon netmask_1 ipv4_1 context_2)
> > -    (nodecon (255.255.255.0) (192.168.1.64) context_1)
> > -    (nodecon netmask_1 (192.168.1.64) (unconfined.user object_r unconfined.object ((s0) (s0 (c0)))))
> > +    (nodecon ipv6_2 netmask_2 context_3)
> > +    (nodecon (2001:db8:1:0:0:0:0:0) (ffff:ffff:ffff:0:0:0:0:0) context_3)
> > +    (nodecon (2001:db8:1:0:0:0:0:0) netmask_2 (sys.id sys.role my48prefix.node ((s0)(s0))))
> >
> >  portcon
> >  -------
> > --
> > 2.28.0
> >

