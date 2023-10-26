Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6224C25B48
	for <selinux@archiver.kernel.org>; Thu, 26 Oct 2023 15:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbjJZPie (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Oct 2023 11:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjJZPie (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Oct 2023 11:38:34 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32F81A6
        for <selinux@vger.kernel.org>; Thu, 26 Oct 2023 08:38:31 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d9c2420e417so781139276.2
        for <selinux@vger.kernel.org>; Thu, 26 Oct 2023 08:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698334711; x=1698939511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EwAqPEcnfkwo9lWk9v82S2i+OA6NrB82M1LvkoKbds=;
        b=XCXTX2cPM2O6Mo7q0rKjUP+nVa9mA/ApMI2WiJNjK4wGVrdhzvdtiAMX8kLEHYOP7z
         EVocsvkJzpe6gP9sqZwrnGZ7+RlhK/oA7U3tQxDE9XPZZNMTHabPaDDVz/OUy+GOQC5H
         MS3mwSlt9IC34ZbVLkr8tmOih3kp5iDBaetC6r/qg37X2CulSncT05TWaojFaUESmCHv
         nPdcU2Q730C68S1kNXrf2ySFIx3U4MXnvUi/Lizd7noW8SeBZJvRqtBriKcqfM4TQHxp
         XTJ2/bnPEG8x1SP16TOLxa90vsU9ZqKQ82aDda4MoYtpaQ190puMtm7aqSEh7m1+ck7Z
         /KgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698334711; x=1698939511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0EwAqPEcnfkwo9lWk9v82S2i+OA6NrB82M1LvkoKbds=;
        b=kFYWaSSiXTE1FhNJq2Xuzy28F+zID8dMOr1IIFQD5F7NmA1kUGtugBy1/3kmugxJtU
         NfPeqUZWCoV7LLXk0nOwXG1OvLGaRB6WuRSDuzhr/azqxUejaGTxBmMhqpdvWl2rfaFd
         dlypN+Hn/2gW3tigu3oo7amn/0FwZf42mc6ZVIM+fEwHN1e6d7hfezbh56iO92WWcatE
         gGq3x5reh93tPOfb8cwZQMGcmrPEP3C98fqaYD36SyIo1qaOYbl9DbgPB985ULbAXhQT
         j0bdGA7FPGhLtt4ahcL+VlvNiDq2CC768KlyQpEndpqudVqTQlLgPb4ltQFra8OpIjKG
         LPrg==
X-Gm-Message-State: AOJu0Ywnej2s0/ZL4M8v6StZJedWPUzSccQsiaVg71QGgVeck4DDzAuu
        zj8iiGpRfLEPJnmPyWvKF9BZttsOPU3NFCMUeRMKj31uYSK4IKE=
X-Google-Smtp-Source: AGHT+IG1tfbXN3bAkYv3KGKYE0d9/pH2mCKrxe3nVeAX/S2JUAcp50XxiMNthfd+B77MAkP+DZ7RZqEat+2vPhPuFKg=
X-Received: by 2002:a25:adc8:0:b0:da0:4fba:1c61 with SMTP id
 d8-20020a25adc8000000b00da04fba1c61mr7510762ybe.46.1698334711141; Thu, 26 Oct
 2023 08:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <20231024213525.361332-4-paul@paul-moore.com> <20231024213525.361332-7-paul@paul-moore.com>
 <20231026.ieyieDie4see@digikod.net>
In-Reply-To: <20231026.ieyieDie4see@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 26 Oct 2023 11:38:20 -0400
Message-ID: <CAHC9VhTFfBVb3Ru3fhNgRV=c82UhHmhcvcpYDPUFW9G8LNHjHA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] lsm: consolidate buffer size handling into lsm_fill_user_ctx()
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 26, 2023 at 11:13=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
> On Tue, Oct 24, 2023 at 05:35:29PM -0400, Paul Moore wrote:
> > While we have a lsm_fill_user_ctx() helper function designed to make
> > life easier for LSMs which return lsm_ctx structs to userspace, we
> > didn't include all of the buffer length safety checks and buffer
> > padding adjustments in the helper.  This led to code duplication
> > across the different LSMs and the possibility for mistakes across the
> > different LSM subsystems.  In order to reduce code duplication and
> > decrease the chances of silly mistakes, we're consolidating all of
> > this code into the lsm_fill_user_ctx() helper.
> >
> > The buffer padding is also modified from a fixed 8-byte alignment to
> > an alignment that matches the word length of the machine
> > (BITS_PER_LONG / 8).
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
>
> > diff --git a/security/security.c b/security/security.c
> > index 67ded406a5ea..45c4f5440c95 100644
> > --- a/security/security.c
> > +++ b/security/security.c

...

> > +int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, size_t *uctx_len,
> > +                   void *val, size_t val_len,
> > +                   u64 id, u64 flags)
> >  {
> > -     struct lsm_ctx *lctx;
> > -     size_t locallen =3D struct_size(lctx, ctx, context_size);
> > +     struct lsm_ctx *nctx =3D NULL;
> > +     size_t nctx_len;
> >       int rc =3D 0;
> >
> > -     lctx =3D kzalloc(locallen, GFP_KERNEL);
> > -     if (lctx =3D=3D NULL)
> > -             return -ENOMEM;
> > +     nctx_len =3D ALIGN(struct_size(nctx, ctx, val_len), BITS_PER_LONG=
 / 8);
>
> Why the arch-dependent constant?

My thinking is that most arches tend to perform better when data is
aligned on a word boundary and this should help achieve that in a way
that doesn't assume the arch's word length.  If you have an idea on
how to do this differently I'm open to suggestions.

It's worth noting that this is something we can change in the future
as the lsm_ctx struct has the len field which we can use for arbitrary
amounts of padding, including none.

> I'm not even sure why we want to align this size. We'll only copy the
> actual size right?

We allocate, zero out, and copy @nctx_len/@nctx->len.

> > +     if (nctx_len > *uctx_len) {
> > +             rc =3D -E2BIG;
> > +             goto out;
> > +     }
> >
> > -     lctx->id =3D id;
> > -     lctx->flags =3D flags;
> > -     lctx->ctx_len =3D context_size;
> > -     lctx->len =3D locallen;
> > +     nctx =3D kzalloc(nctx_len, GFP_KERNEL);
> > +     if (nctx =3D=3D NULL) {
> > +             rc =3D -ENOMEM;
> > +             goto out;
> > +     }
> > +     nctx->id =3D id;
> > +     nctx->flags =3D flags;
> > +     nctx->len =3D nctx_len;
> > +     nctx->ctx_len =3D val_len;
> > +     memcpy(nctx->ctx, val, val_len);
> >
> > -     memcpy(lctx->ctx, context, context_size);
> > -
> > -     if (copy_to_user(ctx, lctx, locallen))
> > +     if (copy_to_user(uctx, nctx, nctx_len))
> >               rc =3D -EFAULT;
> >
> > -     kfree(lctx);
> > -
> > +out:
> > +     kfree(nctx);
> > +     *uctx_len =3D nctx_len;
> >       return rc;
> >  }

--=20
paul-moore.com
