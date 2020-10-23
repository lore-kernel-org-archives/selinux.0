Return-Path: <SRS0=zvjF=D6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56010C4363A
	for <selinux@archiver.kernel.org>; Fri, 23 Oct 2020 14:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05A4922254
	for <selinux@archiver.kernel.org>; Fri, 23 Oct 2020 14:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pykkvz32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S376033AbgJWOuo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 23 Oct 2020 10:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S375949AbgJWOuo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 23 Oct 2020 10:50:44 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E85C0613CE
        for <selinux@vger.kernel.org>; Fri, 23 Oct 2020 07:50:43 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id n6so2073498ioc.12
        for <selinux@vger.kernel.org>; Fri, 23 Oct 2020 07:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dp3YoMP6dWzMW/ec5Rv/fewKwFLWrhXmyuNMx38WgyI=;
        b=Pykkvz32DRPagXXRs7YtUY328NE2Zen+f3kGqlXZhvEdQAcVxu0m4F3a1k758QBlef
         sUdAPJSsJIhyNf8VyUBMgb992kCN3VT0ABVUjsrDs5WUcRSG3pfuX2KwQFUhPoJOn6lq
         MVrSBGxVUqu4ia74PJckVyPDK8JtcmExVwYsKttXJdb+xO1+HtcQy0rNyWN2yv0e9N4G
         xsvuuwsdSkLoPZWyfjqEBB/+gEezVU5pZoXNMNVpjhg1zgA8LdpT4fF+EkyEJbyyAGMU
         WN5AzLsRQYH18U/FsvKmaXsrsJr/hn9WCNZj3XFJG9kw/1TQuBtQr4xPq7McK3f1bZg4
         LuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dp3YoMP6dWzMW/ec5Rv/fewKwFLWrhXmyuNMx38WgyI=;
        b=jnQ7dhHwJts93vv/nIPr9Sg5GKBATmTc8A+z/u7XqwlZTkeVvd3NSvkaEdp3lSLaPm
         6hrGUXtELYrdgDW1ur7xG8sNE18GtLG7NJo3/cBUXv7NYtHrcG68fC7KGiQtZ/HyrmkO
         sJCiwqtesH5VDaXdsAblwPPQ6+GHbT1nr+eXZFSKNitilzXcfkKEojLANclWgHFtkWmw
         91yLUZcugcvp2zOziVBJdGNxfqIq4GrGsddTSB0furmonTzENB6qkycQNIwsGDP78P1+
         NezETw920cOhBDE4e4aXoyRjWv1vnd9Lcf2f5nMnji2pSdiEnKbniYeitNcVEVQnYA+y
         dWkQ==
X-Gm-Message-State: AOAM531uxowPlAvo3yF2aXiESe5cXeWGXc0RMfS/NsjGyS98jKBg4Li5
        6dpIE+wKcVRi52Kh+PWhoCbT4uugPGxUQ6BI+F0=
X-Google-Smtp-Source: ABdhPJxmZU6sMv0nlKUBmkiSUH3em+exyocZCMD6JXiwRTVn9Qq7X6cm4Rj33chQ4a3MckkWUaq5fU+EgwZ2NLhL06I=
X-Received: by 2002:a02:7083:: with SMTP id f125mr2318411jac.27.1603464642763;
 Fri, 23 Oct 2020 07:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <5825612.FvA7u9GNv5@odin> <CAFftDdrgFQdw0Ctf4Y1L6zfBqL-Awfbvq7qr4eMP5r-3K6ALKQ@mail.gmail.com>
In-Reply-To: <CAFftDdrgFQdw0Ctf4Y1L6zfBqL-Awfbvq7qr4eMP5r-3K6ALKQ@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 23 Oct 2020 09:50:31 -0500
Message-ID: <CAFftDdqKtziqbYXGfD9dd5ARMZUt5TFVt54C=0SO_xMD2WPkKw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Add build option to disable X11 backend
To:     =?UTF-8?B?QmrDtnJuIEJpZGFy?= <bjorn.bidar@jolla.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 23, 2020 at 9:48 AM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Tue, Oct 20, 2020 at 7:28 AM Bj=C3=B6rn Bidar <bjorn.bidar@jolla.com> =
wrote:
> >
> > Add build option to libselinux to disable the X11 backend without using
> > ANDROID_HOST.
> >
> > Signed-off-by: Bj=C3=B6rn Bidar <bjorn.bidar@jolla.com>
> > ---
> >  libselinux/Makefile     | 5 ++++-
> >  libselinux/src/Makefile | 4 ++++
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/libselinux/Makefile b/libselinux/Makefile
> > index 6a43b243..cb5872b7 100644
> > --- a/libselinux/Makefile
> > +++ b/libselinux/Makefile
> > @@ -17,7 +17,10 @@ endif
> >  ifeq ($(DISABLE_BOOL),y)
> >         DISABLE_FLAGS+=3D -DDISABLE_BOOL
> >  endif
> > -export DISABLE_SETRANS DISABLE_RPM DISABLE_FLAGS ANDROID_HOST
> > +ifeq ($(DISABLE_X11),y)
> > +       DISABLE_FLAGS+=3D -DNO_X_BACKEND
> > +endif
> > +export DISABLE_SETRANS DISABLE_RPM DISABLE_FLAGS ANDROID_HOST DISABLE_=
X11
> >
> >  USE_PCRE2 ?=3D n
> >  ifeq ($(USE_PCRE2),y)
> > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > index 190016e2..be0b6eec 100644
> > --- a/libselinux/src/Makefile
> > +++ b/libselinux/src/Makefile
> > @@ -126,6 +126,10 @@ DISABLE_FLAGS+=3D -DNO_ANDROID_BACKEND
> >  SRCS:=3D $(filter-out label_backends_android.c, $(SRCS))
> >  endif
> >
> > +ifeq ($(DISABLE_X11),y)
> > +SRCS:=3D $(filter-out label_x.c, $(SRCS))
> > +endif
> > +
> >  SWIGRUBY =3D swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./ $(DISABLE_=
FLAGS)
> >
> >  all: $(LIBA) $(LIBSO) $(LIBPC)
> > --
> > 2.28.0
> >
>
> Acked-by: William Roberts <william.c.roberts@intel.com>

I see the PR was already staged, merged:
https://github.com/SELinuxProject/selinux/pull/264
