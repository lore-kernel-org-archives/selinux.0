Return-Path: <SRS0=Lh2G=7C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CBFC433DF
	for <selinux@archiver.kernel.org>; Wed, 20 May 2020 15:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E09D20708
	for <selinux@archiver.kernel.org>; Wed, 20 May 2020 15:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+je5cOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgETPU3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 May 2020 11:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETPU2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 May 2020 11:20:28 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348BFC061A0E
        for <selinux@vger.kernel.org>; Wed, 20 May 2020 08:20:28 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id 17so3498143ilj.3
        for <selinux@vger.kernel.org>; Wed, 20 May 2020 08:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=utZH8rXXT0w9ASGCYwa/zYq/JC2fhmaQxJQn44JLuF4=;
        b=c+je5cOMf3X+Awv3Mk4hEXGB9jjFCri8oDHr21BkpPKrIdPrTjGgA83/VElamHdQfK
         Lkl/ANf8BQcJii5ZVLLIu+bvS4XkQU7ptVWe3OufLN4ST61FTIONbnuziPAl3Tt1nxjC
         TsL4guvtVyreHtDILVNgRFDfrfSl3jCArlNmNZT/EPtDypohY8t3SerGcJ6RwJXApye4
         bhcF/J7cQoIZ80K/g+BH/FtpX4yqrGqY79CxLtbso/jYDPBQ4SdLWE8nkm8UN+aAMK45
         rAsPAG7dk0BmO8dReSCHKRl80Uh/Pj2hezswQ1tdyA7tWlOaWuHwVnXNMkVeFQoeumHV
         vIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=utZH8rXXT0w9ASGCYwa/zYq/JC2fhmaQxJQn44JLuF4=;
        b=LWnzKf2TLuwL0kOHsx/9yF64MTZpBTAK9Txfd28fNPuBFktpEhDRc/UTAKlaDobZy8
         +f3qlVfEA2SXl7k3G4f7Y0KMal6EjaKqRd51d1KcklTtYsUmJj6bHXpnwtc725/zuM35
         ryoFA/z0P9PONljLCtnoEDv4HQC83ful63OSotf/swisILnFbXsm2/VY01DZLcBi+0tZ
         s9BI5qjxAPzjZSMhsyRBALi0MiJ9nw/pcjBtTUJEnXToVNS2YndCHrjUurBs5rbtBXBo
         6q+GxKql1QowMCyEGi+2Tpu9i6fo3Bafbn3Grq68F4MujRtBy11UhaRdA1+TdZWVEyUC
         RBKA==
X-Gm-Message-State: AOAM5300fXvwHf3vtrWM5MyUJ5V+gmUNl9jDU/qI62tOeegzAFA8yumy
        SMpx9wdsvEYGPHYl7qu5tpssbyHjTJjVFaGZFaA=
X-Google-Smtp-Source: ABdhPJxgfqmnxVORwS3lmvCUJbtFk6XDLgmu9ujDZFdMT4Sc/9N2230qQ+B5eJTq4ZCB0DggI5zObG/65lbP7k+IvgY=
X-Received: by 2002:a92:58d6:: with SMTP id z83mr4198039ilf.129.1589988027485;
 Wed, 20 May 2020 08:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200519151457.31618-1-william.c.roberts@intel.com>
 <20200519151457.31618-2-william.c.roberts@intel.com> <CAHC9VhRfWHPkz+rCSAa8kvwVu3dds9q47VfnBFSCJbV3GdMjwQ@mail.gmail.com>
 <CAFftDdpPS0wt3VHiMS6sMKTqAgviNB-TBRT1YqbrzgJftPFj_w@mail.gmail.com>
 <CAHC9VhS8rV_bF1j9Q7bT97916TKeEpNoCDTmjit9YAyMcJ+chQ@mail.gmail.com> <CAFftDdrWNZVvmvAfrLcO61GnTSOs0h5DvZsM7X1mcEP88HM-aA@mail.gmail.com>
In-Reply-To: <CAFftDdrWNZVvmvAfrLcO61GnTSOs0h5DvZsM7X1mcEP88HM-aA@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Wed, 20 May 2020 10:20:15 -0500
Message-ID: <CAFftDdo05a7xVhYH-ddQ22V4tH465SXAknRKCuntNmvVuP7ssQ@mail.gmail.com>
Subject: Re: [PATCH] ci: run SE Linux kernel test suite
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 20, 2020 at 10:13 AM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Tue, May 19, 2020 at 5:23 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Tue, May 19, 2020 at 6:16 PM William Roberts
> > <bill.c.roberts@gmail.com> wrote:
> > > On Tue, May 19, 2020 at 5:00 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Tue, May 19, 2020 at 11:15 AM <bill.c.roberts@gmail.com> wrote:
> >
> > ...
> >
> > > > > +dnf install -y \
> > > >
> > > > Another speaking from experience comment: you probably want to add
> > > > "--allowerasing" and "--skip-broken" to the dnf command line.  If you
> > > > can cope with the extra overhead, I would even suggest a "dnf clean
> > > > all -y" at the start.
> > >
> > > I don't see why we couldn't.
> > >
> > > Not really sure if it matters for those first two things, considering
> > > that were starting
> > > in the same state each time. Its not like we need to work on a system
> > > that's already
> > > been played with.
> >
> > FWIW, the VM I use for my automated kernel testing doesn't get played
> > with (other than to fix dnf/Rawhide problems) and I can tell you from
> > experience that Rawhide finds itself broken in new and exciting ways
> > :)
> >
> > You are using a stable Fedora release so it probably won't be too bad,
> > I'm just trying to share some of the lessons I've learned.
> >
>
> Sure, and I appreciate that. It actually doesn't add any time, to give
> you an idea
> the CI build time went from 14 to 11 mins. So that'll show you how much
> jitter there is. Ill send a V2 all fixed up shortly

Not true, I lied. I didn't have it back in enforcing mode so the test suite
was skipped. I still don't see it adding much in the way of time.
