Return-Path: <SRS0=VL4G=BA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC73DC433E0
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 18:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3B3B20717
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 18:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uMpTDh2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGUSfN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Jul 2020 14:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgGUSfM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Jul 2020 14:35:12 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CE1C061794
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2020 11:35:11 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 72so15821146otc.3
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2020 11:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gd3DOKgahVLS69fdxARLm8m3EEwPFkvI9ND24m+OgDU=;
        b=uMpTDh2rIKIFoqeNvA+lQRh5dlVNypQBWjFlHQclPY7ifesTjdEG9bAMK/DX35lwLh
         dP2AT501sAjMlIV451W1QZ2u/4tR1f2ROCf9UETkScG0DEcyI8isAgWBVo2Mymr6ilgS
         YyJlkW5uFajPgdTzrjjD6g9nv+pu5/3HEw0jGmzYofU2W/AOFwVXfCquJ8edejxM0yf8
         2jDIz6lpJ/YnuRUPTRpM1jSdcxgb21VlGixLUYVV7nF0xQuggPj2aoQONx/2yYMdqz3S
         qak7w7Z5w49VrmFJOYiqWyE6SSZotA3gjM23xGwnt5rXtAPI6vs6HpbGltkeZc/cqyRj
         kfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gd3DOKgahVLS69fdxARLm8m3EEwPFkvI9ND24m+OgDU=;
        b=KUZyAwbcCcxGxEM3ZPilNpnggugtAKoqJoVza6ieFzDf2E6XMz8QpQ0VvIJT0Ifn4a
         PSWIIv6IdZ7opYGEN5MgKO0vsqyy6iPs6OZ5vHu1PDkmZk2tqC2newZ2Z2MPDYUTthl2
         qCVARuxF/wiF5thAGTJR3P03pJwwNgRByg9xJUlnXFWgKChtwjhSnSbC2loiNnK9Q1/n
         3aIUzfLYynRVqVEPrRT7f7I8qNHYPv3xL5/PT0dmP4FRc+5IblKKb/KcvT2JILP3ddCV
         1dEwmVbhRB0Qh8df+2wO7CVGu/KJyzLcyzZjadjLGwSVeiiub7BW6FJdKKn3+gkpRcsN
         CPcw==
X-Gm-Message-State: AOAM531D8eZwDtvdhjkZxJAXpbikZeY46ufdH2zhnnU1EZvL/81DMI6i
        +IThSXCIlkczlxzHJ+3kl9+NRwMouyT0poKo45k=
X-Google-Smtp-Source: ABdhPJwaRo0tD/sIh5CWpUvtaNP2j0QSybOP2kJDy2/0VUdGRsEIg9Og+PMDm/ck8JnAXOsZbUlb7cioyTvR+usOn5k=
X-Received: by 2002:a9d:20c9:: with SMTP id x67mr26738947ota.295.1595356511377;
 Tue, 21 Jul 2020 11:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200718104842.1333101-1-dominick.grift@defensec.nl>
 <20200719181704.1583398-1-dominick.grift@defensec.nl> <CAHC9VhTS0hr+i3GvMJPhs3WQd48fOdz3xbZBUSJDJD=XAfNQvQ@mail.gmail.com>
 <d37dcc1e21d3292c4112810c7d398d5590e14d14.camel@btinternet.com>
In-Reply-To: <d37dcc1e21d3292c4112810c7d398d5590e14d14.camel@btinternet.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 21 Jul 2020 14:37:53 -0400
Message-ID: <CAP+JOzSrGLc3i=P-rPOnsLSLQnaZm+W7Xb4oNwjNDz4AquJpNA@mail.gmail.com>
Subject: Re: [SELinux-notebook PATCH v5] adds CIL policy with makefile
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Dominick Grift <dominick.grift@defensec.nl>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 21, 2020 at 12:56 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> On Tue, 2020-07-21 at 12:42 -0400, Paul Moore wrote:
> > On Sun, Jul 19, 2020 at 2:17 PM Dominick Grift
> > <dominick.grift@defensec.nl> wrote:
> > > This example CIL policy takes a different approach:
> > >
> > > 1. Leverages CIL
> > > 2. Installs using semodule to make it tunable at runtime (but you
> > > can obviously also use secilc to build a monolithic version and
> > > deploy that)
> > > 3. Makes few assumptions about variables
> > > 4. Leverages handleunknown allow and declares least required access
> > > vectors so that you can pick and choose which access vectors you
> > > want to use and ignore the remainder
> > > 5. Leverages unlabeled and file ISID and makes no assumptions about
> > > any volatile filesystems you may or may not use
> > > 6. As small and simple as reasonably possible, heavily documented
> > > 7. Modern, Requires SELinux 3.1
> > >
> > > Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> > > ---
> > > v2: rename XWAYLAND.md to XSERVER_XWAYLAND.md and cover both
> > > Xserver as well as Xwayland
> > > V3: fix typo in XSERVER_XWAYLAND.md and exclude x_contexts
> > > altogether
> > > v4: remove XSERVER_XWAYLAND and add the note to README.md, redo
> > > README.md and clean up cil-policy.cil
> > > v5: add -F to fixfiles onboot (onboot should probably just imply
> > > -F)
> > >
> > >  src/cil_overview.md                           |  11 +
> > >  src/notebook-examples/README.md               |   2 +
> > >  src/notebook-examples/cil-policy/Makefile     |  31 ++
> > >  src/notebook-examples/cil-policy/README.md    |  90 ++++
> > >  .../cil-policy/cil-policy.cil                 | 448
> > > ++++++++++++++++++
> > >  5 files changed, 582 insertions(+)
> > >  create mode 100644 src/notebook-examples/cil-policy/Makefile
> > >  create mode 100644 src/notebook-examples/cil-policy/README.md
> > >  create mode 100644 src/notebook-examples/cil-policy/cil-policy.cil
> >
> > James, Richard, you both had comments on previous drafts, does v3
> > look
> > good to you guys?
>
> Yes I've tested this (v4 & V5) a few times and okay on Fedora 32 WS.
>
> Acked-by: Richard Haines <richard_c_haines@btinternet.com>

Looks good.

Acked-by: James Carter <jwcart2@gmail.com>

>
>
> >
> > --
> > paul moore
> > www.paul-moore.com
>
