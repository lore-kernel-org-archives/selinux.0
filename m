Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B31C433EF
	for <selinux@archiver.kernel.org>; Fri, 11 Mar 2022 16:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239977AbiCKQEV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Mar 2022 11:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346375AbiCKQEU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Mar 2022 11:04:20 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6751CE9A8
        for <selinux@vger.kernel.org>; Fri, 11 Mar 2022 08:03:16 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id 6-20020a4a0906000000b0031d7eb98d31so10954018ooa.10
        for <selinux@vger.kernel.org>; Fri, 11 Mar 2022 08:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v25kbEGXW8UuA7NXNZLHPqd6YD6gS7xYhePJwYy3uvw=;
        b=OHCyWLWR1hy7vYmSQY7I/pzDD8dKHXpfyF0SYj1h9sPf5KVz7Kvpk6mL0O5iQBUyq4
         bYv3lTH5K9czDPDcLtghW7EP9LkRMjQXAvhzQf64v1PTvhqtTVAEiuVEUlTXdMjP/R/E
         a4v98gZapo2nxZSM53gp3hThr1Qbt9a5msb6elHEp0Tw0o+Foas3oHDYQzdP5553k2Ha
         +2dhq4aUUechK/2AEHNaLoHpibb8cxQ6I2W2CP0v4T+mrpSK0tkROZwhOEgKgZJcQ1B8
         APLQucdNEC+Lii56YEYFzOPTcRlSM0dlf9FmtB7/LLRCEonbMmu4sJrvNcwlcEeLSXc2
         ghww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v25kbEGXW8UuA7NXNZLHPqd6YD6gS7xYhePJwYy3uvw=;
        b=6ig76x1Mh5ZB7hLdgykJ+NmKNNa5vb4+fyT1fw6jTf2F0IjCvvd0fGfUF2+0vimXkh
         K3X06Z9a7edBZLpyGCwcjroHZ7a+yTK1XKqd4B07aMFbG3/b+lA/NOY4QUhtpikmcuuy
         WlvMv1AYyo7S4Nux+U1xm56IXuKQMdhU1+8Shg3vi8MXFWBDsi9BWHCOlsVIMQg2wGXH
         mZSipNtdn1nZLjswxuYJuR0TERAlcfksUEG3WS92Nzp1L3zzMJxueX7SreRVOiLdbmtI
         w7hBmN8VM7BEibjjS7hh9zkzZowxIuw29V3TXb2TK/dRrWtKZKIAgzbNF28LEy6v/nTb
         3nUw==
X-Gm-Message-State: AOAM5334mr+zzrkO6+YeL8jMs66vcOJu/2yf9XlMGlZJlGl2SiuKLfJf
        YMrdLMsNu5mGie0Svp6fRP+zIKbclLHrUC8JVZvOn7L7
X-Google-Smtp-Source: ABdhPJxirYBG+lwtqHD46vC4dEcD8MMOdK4hAH0oVcuQ85TXQ0Ag8cVQSYM92LRV/n41+jK5270YOBz0+A1Y9M+nXU8=
X-Received: by 2002:a05:6870:5a4:b0:da:b3f:3206 with SMTP id
 m36-20020a05687005a400b000da0b3f3206mr5729573oap.182.1647014596319; Fri, 11
 Mar 2022 08:03:16 -0800 (PST)
MIME-Version: 1.0
References: <20220303052306.357002-1-tweek@google.com> <CAP+JOzQr0vA4AuEYcvOXHwxcG+bFEjmq=07Z8gLgb0sk=XXXQw@mail.gmail.com>
In-Reply-To: <CAP+JOzQr0vA4AuEYcvOXHwxcG+bFEjmq=07Z8gLgb0sk=XXXQw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 11 Mar 2022 11:03:05 -0500
Message-ID: <CAP+JOzTqOaHbsM4aZuMgr_1BiVnpfYMYs6ODujNmRP5tUP1KBA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: fix reallocarray imports
To:     =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Alan Stokes <alanstokes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 4, 2022 at 2:53 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Thu, Mar 3, 2022 at 2:20 AM Thi=C3=A9baud Weksteen <tweek@google.com> =
wrote:
> >
> > In f0a5f6e, calls to reallocarray were introduced. Ensure that the
> > correct header (private.h) is included when necessary.
> >
> > Fixes: f0a5f6e ("libsepol: use reallocarray wrapper to avoid overflows"=
)
> > Test: Built using Android CI (glibc 2.17)
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsepol/src/kernel_to_common.c | 1 +
> >  libsepol/src/util.c             | 2 ++
> >  2 files changed, 3 insertions(+)
> >
> > diff --git a/libsepol/src/kernel_to_common.c b/libsepol/src/kernel_to_c=
ommon.c
> > index dc9e689e..972499ab 100644
> > --- a/libsepol/src/kernel_to_common.c
> > +++ b/libsepol/src/kernel_to_common.c
> > @@ -18,6 +18,7 @@
> >  #include <sepol/policydb/hashtab.h>
> >  #include <sepol/policydb/symtab.h>
> >
> > +#include "private.h"
> >  #include "kernel_to_common.h"
> >
> >
> > diff --git a/libsepol/src/util.c b/libsepol/src/util.c
> > index b7230564..1cd1308d 100644
> > --- a/libsepol/src/util.c
> > +++ b/libsepol/src/util.c
> > @@ -28,6 +28,8 @@
> >  #include <sepol/policydb/policydb.h>
> >  #include <sepol/policydb/util.h>
> >
> > +#include "private.h"
> > +
> >  struct val_to_name {
> >         unsigned int val;
> >         char *name;
> > --
> > 2.35.1.574.g5d30c73bfb-goog
> >
