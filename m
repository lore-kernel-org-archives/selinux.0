Return-Path: <SRS0=/pgn=6O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51678C4724C
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 15:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D1F820870
	for <selinux@archiver.kernel.org>; Thu, 30 Apr 2020 15:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhawkU4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgD3PHD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726396AbgD3PHD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Apr 2020 11:07:03 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69391C035494
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 08:07:03 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id c124so1945575oib.13
        for <selinux@vger.kernel.org>; Thu, 30 Apr 2020 08:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lc9Q7mVQfULFu7VLl5dDRKpn/SKqNYXu80gyju0Gt98=;
        b=DhawkU4xrDM7zhML4huAIxVugHi9Asnn21FnbQGHu9ceXMH4SvGwNz3qY/Epv/KHLG
         hD+j8mf9hhjd8NnGWJ6xj7Szjgvh7+MQewAj3OcJw5wsQOfpj2WOlqhZXCgtCa0VbE+J
         VYBZejhAG9XjjP/HI/oMQaXkR+RZV/WU/zlBz8wP2HbDD6A5hn/Wt1Swb1XACpZMk+zp
         O+UPfkSBdu6ODbeLTSOHI9ik5DFb7esrqJaVRGlENyuhP3Cu2hfeWeixoBLSC2vijta3
         jh+V/hcd9UaZ5dWkqDxGxk+3CALEU6hkE3R5KjQ1bPb96mMrn1RP7bqSLgEMWwFOUZky
         e7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lc9Q7mVQfULFu7VLl5dDRKpn/SKqNYXu80gyju0Gt98=;
        b=RKjBKnbY90lHv1oqCy/y96lUZgZ1/6EZktXc0s2Q0LMHmUddmKdm+JgOmiacgAEep0
         Q62UObESN5oRCj7M1X38TftbYUNEWRSVMNM19skEZ/nswsatULwGm7uEyus7044eDaiN
         Dy32YHTzb+TkjC8vLI/VUcz+GNSlBJ2IYTKnMmOnriNwTBG5IxPr/k/1rymJsD7EeriQ
         veFlI2WYDifO0tpTdbhiJGVLF882prc35za7rbICTxfpcxeqt1HNxhdbTu0XanVKacU0
         XoHKSz03wuwxshCVb/KhBluAw9bQnwqKIa/lMkQ69F79HawFcAWOkXc46D2XpqrQdaUs
         OcHg==
X-Gm-Message-State: AGi0Pub+wKHBK0gtGcs1D8qs9iR8YeOy3UQgwyE7hi5NoO1EnWB9MR2W
        TngeLoCDXVKBLBs77RHtP5ZAd2jxdY/MchBsniuLGYqN
X-Google-Smtp-Source: APiQypJisF3MdQKG2MADb0LNj+bEcdTn8jdVytR6UzvH2ovZmydZujJb0L8K1fIj8wveq4zRBHxcQYX4u9YjKunyPXo=
X-Received: by 2002:aca:f482:: with SMTP id s124mr2097013oih.128.1588259222712;
 Thu, 30 Apr 2020 08:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200328124550.199568-1-omosnace@redhat.com> <20200328124550.199568-3-omosnace@redhat.com>
 <CAP+JOzTu=ziLHGgFfu6Do_yXV3eWQDA2hUEenYHP3StT64R=Bg@mail.gmail.com>
 <CAP+JOzRYAJgb3BZTJ5wodkat7kyqRED__Wp7oW6n-2Lj6J4yqQ@mail.gmail.com>
 <CAFqZXNsqfDw1SuW+69L776iw_J6CKKsrSjEivVnG_T3X20HXOA@mail.gmail.com>
 <CAP+JOzQMofOxLTSpDipzh52sWnKQT6bQ4dmY-AD_5NN=67mx4g@mail.gmail.com> <CAEjxPJ74rdziWudbtmbAm-UceJQtNePP_o-CWkyQZ7yONALYBg@mail.gmail.com>
In-Reply-To: <CAEjxPJ74rdziWudbtmbAm-UceJQtNePP_o-CWkyQZ7yONALYBg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 30 Apr 2020 11:06:51 -0400
Message-ID: <CAP+JOzTHikoHx8sXtG64qT1HE-6Hw-vK5GwTGSQjp+0J665n-g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] libsepol: implement POLICYDB_VERSION_COMP_FTRANS
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Chris PeBenito <pebenito@ieee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 30, 2020 at 10:25 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Apr 28, 2020 at 11:29 AM James Carter <jwcart2@gmail.com> wrote:
> >
> > On Tue, Apr 28, 2020 at 4:49 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > On Mon, Apr 27, 2020 at 9:39 PM James Carter <jwcart2@gmail.com> wrote:
> > > > On Tue, Mar 31, 2020 at 4:30 PM James Carter <jwcart2@gmail.com> wrote:
> > > > >
> > > > > On Sat, Mar 28, 2020 at 8:46 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > > >
> > > > > > Implement a new, more space-efficient form of storing filename
> > > > > > transitions in the binary policy. The internal structures have already
> > > > > > been converted to this new representation; this patch just implements
> > > > > > reading/writing an equivalent representation from/to the binary policy.
> > > > > >
> > > > > > This new format reduces the size of Fedora policy from 7.6 MB to only
> > > > > > 3.3 MB (with policy optimization enabled in both cases). With the
> > > > > > unconfined module disabled, the size is reduced from 3.3 MB to 2.4 MB.
> > > > > >
> > > > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > >
> > > > > Acked-by: James Carter <jwcart2@gmail.com>
> > > > >
> > > >
> > > > Sorry, it has been a while.
> > >
> > > No problem. I would've merged it myself, I just wasn't sure if we
> > > shouldn't try to do something about the setools issue somehow... But I
> > > really don't feel like touching that code, so if the consensus is that
> > > this is worth the breakage then I'm fine with it :)
> > >
> >
> > I thought the consensus was to apply this now, but it would be nice to
> > not break setools, so I am going to hold off merging for day or two
> > and take a look at how much work it would be to export what setools
> > needs.
>
> There was an earlier discussion about whether we ought to make another
> selinux userspace release soon.
> If so, we should defer applying this change until after that release
> to avoid breaking setools with no fix
> in sight for it.

I agree. That discussion was what got me really thinking about what to
do about setools.

Jim
