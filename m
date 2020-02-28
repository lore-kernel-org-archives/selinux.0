Return-Path: <SRS0=XvAr=4Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A0FC3F2D2
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 19:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06982468E
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 19:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7krVgg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgB1TEf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Feb 2020 14:04:35 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36182 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgB1TEf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Feb 2020 14:04:35 -0500
Received: by mail-oi1-f196.google.com with SMTP id c16so3900919oic.3
        for <selinux@vger.kernel.org>; Fri, 28 Feb 2020 11:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=YDsIrUB/36Sh0Sz8KZwgA6q/JW7rjC4MzOO4C1M4aEw=;
        b=h7krVgg+sHDRrHoOC23y1lrt3OeOvuR5LCmiO0AEBZKGtndu1MWjswTiVPqAe65fHo
         dozlyKuEeLxD+drpK5sCU5/etoqkXIxWVLi7Ot9jROV47pUk97AyQGthsoE6H6vnyoMA
         lpwo+3fZEEtQOh44PiFkIyvQ3DkfpalwnnnLNF6nJlwKkghPKdxJwK/iKQ+Imdove64R
         OZfO2UAHoBvFupxh+qA6/bAcOQQe22TAnx0cNFwtpUVzNUZd8+2Kxj/zm6WcbfM8RGwX
         cwPzI+N5tNq5T4tVm8mF05gXCAx7pgFwihzdpS0NMUKD8AeA/0ojPDwcHSlqeg3a5LVT
         Syhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=YDsIrUB/36Sh0Sz8KZwgA6q/JW7rjC4MzOO4C1M4aEw=;
        b=EsZlXtfUFt0l7gRmPr4le9V2Fw1q3LdwC2qaWblBLOSv7ayyXHzsQFzkl0cjALK2/I
         jyKtAH+ZEb41T0hXpRXsmrhnWYDhQSXtA+lW4PiUGSuzBbbItz72DQPxoXLmt5rUz4Ng
         fEf3MQdtW+zmqVLOdzyUYYvIIMliGm91T+A2PzeRgPnNouZ9N+VsYLpTGpuew0JT9Lwx
         YKS6Qos5CrD3HUjEhFXjwwTrlKux6nDaRXQeQErR5GTPu/RI+XhwfI1TiArMp63BF3jQ
         Oyw3M+7mTW9+UuEaSzrMVn4A/FMY7MzIOk9HKRyplFiFlaUrit3q/OBT6bzo/bMfgJmG
         JTtg==
X-Gm-Message-State: APjAAAVljmYrv2L1C1/SEBZqa42A9XSds1Md4r10rN7QXvTZBeogWIux
        hSv/ki5Ku6kSjCX627mw9hX2vRuJgjoiADx7Kgk=
X-Google-Smtp-Source: APXvYqwzKtn+23mT+FqM7XrQt2aVREPagrgAt10SYbcBYxrezZccbEvVZX2YxX7XTTsfEVUEGn03baP7l/JxNru1vMU=
X-Received: by 2002:aca:f517:: with SMTP id t23mr4047673oih.160.1582916674771;
 Fri, 28 Feb 2020 11:04:34 -0800 (PST)
MIME-Version: 1.0
References: <20200227230129.31166-1-william.c.roberts@intel.com>
 <20200228154857.587-1-william.c.roberts@intel.com> <20200228154857.587-4-william.c.roberts@intel.com>
 <CAEjxPJ7CuMf5QeW_jjEonRN=kfcpTV8c4UnUMyEjyb2hee1YXg@mail.gmail.com> <CAFftDdpeP39qvXNTe06EWkc3Kp_TMu5bGOf8WN6Q-k2Cehn_3w@mail.gmail.com>
In-Reply-To: <CAFftDdpeP39qvXNTe06EWkc3Kp_TMu5bGOf8WN6Q-k2Cehn_3w@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 28 Feb 2020 14:05:53 -0500
Message-ID: <CAEjxPJ7tt7T1NaYcG6B+k9smtcjrM0WXQXDXjnx5A=FNPLPt4w@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] Makefile: add linker script to minimize exports
To:     William Roberts <bill.c.roberts@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Petr Lautrbach <plautrba@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Ulrich Drepper <drepper@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 28, 2020 at 1:43 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Fri, Feb 28, 2020 at 12:35 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, Feb 28, 2020 at 10:49 AM <bill.c.roberts@gmail.com> wrote:
> > > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > > index c76110fbc650..f74dbeb983dd 100644
> > > --- a/libselinux/src/Makefile
> > > +++ b/libselinux/src/Makefile
> > > @@ -90,7 +90,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
> > >            -Werror -Wno-aggregate-return -Wno-redundant-decls \
> > >            $(EXTRA_CFLAGS)
> > >
> > > -LD_SONAME_FLAGS=-soname,$(LIBSO),-z,defs,-z,relro
> > > +LD_SONAME_FLAGS=-soname,$(LIBSO),-z,defs,-z,relro-Wl,--version-script=libselinux.map
> >
> > /usr/bin/ld: warning: -z relro-Wl ignored
> > I guess you meant relro,-Wl but you don't want that either.  -Wl has
> > to precede all the flags and it is already pre-pended later in the
> > Makefile.
>
> Grumble, did I ever say I *hate* Makefiles! v4 coming, im going to
> hold them so I can coalesce any other feedback
> into v4.

(restored cc; I accidentally only replied to you)
