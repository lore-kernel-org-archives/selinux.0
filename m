Return-Path: <SRS0=VL4G=BA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B10BC433DF
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 21:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E79720720
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 21:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ZpwLdWR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbgGUVJI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728893AbgGUVJI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Jul 2020 17:09:08 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D339CC061794
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2020 14:09:07 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o18so23026115eje.7
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2020 14:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=koqnpq71lELoZUB+C8QrauRsNakWYE+XcWergaee6j4=;
        b=ZpwLdWR7kurwdKTTCBRyXGgkznnCQ1Tg1vY+JvC9gAdj9yvbdJwKcbQAe28vc/51z5
         RZVCFoQcpp339NeG+LCuJ09NEPE6E/HwPCPQkHxDL/yB/Nq2s248sdUe5sx7DT81fxXW
         ZO35fXPT4u6UlxZkHxZXBO4Q0ieymtqFeKcwsT2+aMnvWoVXf8uttI7oIuensA54BNf/
         Jv6daVaEntgbyciYnoXZsVdjoX6b87e/HTXkonE2huORRhdrsLVhRZ35NVLjHBLHOkuB
         qh4u2d5/qVoqyIkY8CoB2cVoP5iAEUVpvsavLzSBD7g1Jplp47EH03yat4A7uxcKlsQH
         pcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=koqnpq71lELoZUB+C8QrauRsNakWYE+XcWergaee6j4=;
        b=NGvgqW449Wsz5LaYf+CjiErudOrY7k2J6GFztFP+3zQV7nR3EiYmLsOtssGYEoS2ww
         jC3QjIyZ/2Qwx+5AMQWxPe+c0WhJWnPFEpfxoc7npzRHhB0TcUjzbcesNPSXGije21Mj
         Qna6As+Z+HErFO1yW75T3n5qq2Bs1/t2G6Lu1YlHwF02aJhCuBqWd+7Z6ddvCHSa0zYk
         C0LLKdRW5/EVpeqI9YSC+YJ1cEQaST3o5aPS9xt4/tft9lq+F0OuDCuxl6znHa2eaKW+
         87dPZR8LRKGotouLgfcN6G7tj0k8+aT2S0bc0imr0IhZiKIXuUaizTWGfv0da1nWTJDV
         6HFw==
X-Gm-Message-State: AOAM5319H4TVbZ95bqLSgH3zT/AGP1Ta8psA7jJtYrpYGBdPK2Y2TCyU
        48qNNjoDWv9vxSzOYeEkb3Yp5l9t9ns5RYENlM6f
X-Google-Smtp-Source: ABdhPJx6gUj/9ZMNwWUxkDP5/EdShD5nBDxYSST73AO4wiA6UQcMkN+Z8Ixe7o18bMMXAFUwW+BpdN+Ca8S5Z+iMiUE=
X-Received: by 2002:a17:906:1a59:: with SMTP id j25mr25571829ejf.398.1595365746465;
 Tue, 21 Jul 2020 14:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200718104842.1333101-1-dominick.grift@defensec.nl>
 <20200719181704.1583398-1-dominick.grift@defensec.nl> <CAHC9VhTS0hr+i3GvMJPhs3WQd48fOdz3xbZBUSJDJD=XAfNQvQ@mail.gmail.com>
 <d37dcc1e21d3292c4112810c7d398d5590e14d14.camel@btinternet.com> <CAP+JOzSrGLc3i=P-rPOnsLSLQnaZm+W7Xb4oNwjNDz4AquJpNA@mail.gmail.com>
In-Reply-To: <CAP+JOzSrGLc3i=P-rPOnsLSLQnaZm+W7Xb4oNwjNDz4AquJpNA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 21 Jul 2020 17:08:55 -0400
Message-ID: <CAHC9VhSuUev17p_kEJKvo2qs8tOvpZ0=Fp2v8puPMoZ06tPi4g@mail.gmail.com>
Subject: Re: [SELinux-notebook PATCH v5] adds CIL policy with makefile
To:     James Carter <jwcart2@gmail.com>
Cc:     Richard Haines <richard_c_haines@btinternet.com>,
        Dominick Grift <dominick.grift@defensec.nl>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 21, 2020 at 2:35 PM James Carter <jwcart2@gmail.com> wrote:
> On Tue, Jul 21, 2020 at 12:56 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> >
> > On Tue, 2020-07-21 at 12:42 -0400, Paul Moore wrote:
> > > On Sun, Jul 19, 2020 at 2:17 PM Dominick Grift
> > > <dominick.grift@defensec.nl> wrote:
> > > > This example CIL policy takes a different approach:
> > > >
> > > > 1. Leverages CIL
> > > > 2. Installs using semodule to make it tunable at runtime (but you
> > > > can obviously also use secilc to build a monolithic version and
> > > > deploy that)
> > > > 3. Makes few assumptions about variables
> > > > 4. Leverages handleunknown allow and declares least required access
> > > > vectors so that you can pick and choose which access vectors you
> > > > want to use and ignore the remainder
> > > > 5. Leverages unlabeled and file ISID and makes no assumptions about
> > > > any volatile filesystems you may or may not use
> > > > 6. As small and simple as reasonably possible, heavily documented
> > > > 7. Modern, Requires SELinux 3.1
> > > >
> > > > Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> > > > ---
> > > > v2: rename XWAYLAND.md to XSERVER_XWAYLAND.md and cover both
> > > > Xserver as well as Xwayland
> > > > V3: fix typo in XSERVER_XWAYLAND.md and exclude x_contexts
> > > > altogether
> > > > v4: remove XSERVER_XWAYLAND and add the note to README.md, redo
> > > > README.md and clean up cil-policy.cil
> > > > v5: add -F to fixfiles onboot (onboot should probably just imply
> > > > -F)
> > > >
> > > >  src/cil_overview.md                           |  11 +
> > > >  src/notebook-examples/README.md               |   2 +
> > > >  src/notebook-examples/cil-policy/Makefile     |  31 ++
> > > >  src/notebook-examples/cil-policy/README.md    |  90 ++++
> > > >  .../cil-policy/cil-policy.cil                 | 448
> > > > ++++++++++++++++++
> > > >  5 files changed, 582 insertions(+)
> > > >  create mode 100644 src/notebook-examples/cil-policy/Makefile
> > > >  create mode 100644 src/notebook-examples/cil-policy/README.md
> > > >  create mode 100644 src/notebook-examples/cil-policy/cil-policy.cil
> > >
> > > James, Richard, you both had comments on previous drafts, does v3
> > > look
> > > good to you guys?
> >
> > Yes I've tested this (v4 & V5) a few times and okay on Fedora 32 WS.
> >
> > Acked-by: Richard Haines <richard_c_haines@btinternet.com>
>
> Looks good.
>
> Acked-by: James Carter <jwcart2@gmail.com>

Great, I'll merge this into main.  Thank you everyone!

-- 
paul moore
www.paul-moore.com
