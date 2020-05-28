Return-Path: <SRS0=TvmB=7K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13615C433DF
	for <selinux@archiver.kernel.org>; Thu, 28 May 2020 12:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF4CC2075A
	for <selinux@archiver.kernel.org>; Thu, 28 May 2020 12:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="s76cOdI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389899AbgE1MzC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 May 2020 08:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389884AbgE1MzA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 May 2020 08:55:00 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F281C05BD1E
        for <selinux@vger.kernel.org>; Thu, 28 May 2020 05:55:00 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id mb16so1544995ejb.4
        for <selinux@vger.kernel.org>; Thu, 28 May 2020 05:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aFGoywfcepvenJAPEO5UPVyZDYJFHOOsk9rEbbj6RXg=;
        b=s76cOdI2R+Js/LPVX13JOt4uMfKWFq/v9kdV0HIOVUrDRqG32uWztFGvTDYqiErFPD
         2mRfBmkvYly4fqRyic2CiUpijxlCKnURmy42YxS45osQjCQoenvTAYnBd59C8fUfd+Vo
         UwCmt98YJFucd4sSmFolAMRlJ0+4uLaoLA15PY64rtIsv7paNGK5eJ7Nxy35sLIq3O3h
         qjBuYcUV+I5fJB242l10ttajd73zsuNt/+BDP/B9UpqQzIwopGHSoKlzBWVDWbeCAoEO
         TYZQFslfYnZtt2gVX+mAFzOTDbsIlJYZzbz0STqX8vVQopHSOvmHxX18O6RcPjvryTA7
         hViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aFGoywfcepvenJAPEO5UPVyZDYJFHOOsk9rEbbj6RXg=;
        b=eZcZzUWADYRQv1eYOLjQrAK32Kv1JKL3mmTa+YY1GlA2Yoq+kxCRTwypSolAIPAnZo
         3tvOXMlF8Pheq/6s6J6zSn3cd+Y2bZgUjXrGVdg7mw0jKh61sfmPLApWNLbEbYYrobWh
         wKvKoLwytjrWGaKxZpKcitwE23cJZ4viEI7cwSE6SUuDbsoJNLtfcm8pOm/9foMLmxUm
         Dl3pxN5wMnuRyhAMTSNhXitMOQmJKRHo9pn5p7Y9NX/JKzr7ZQiBExJooGZc3KL6r+1m
         5/W9CYhCKRstKSSjMEUUNUOVap/p80lc0Mu2Ft8i+ajMGoAwygbDtiLaN+5S1M48s/wm
         J8cQ==
X-Gm-Message-State: AOAM532BDAJKh/KiAJ3UcE+5u4+tvvlNO2+fzSnONPMigfokwa/DUmsp
        40/MV+2BG2/amq7cTRQx9ls2L/I5ab+9Mf6JouU=
X-Google-Smtp-Source: ABdhPJzNfWa2iNHJPNcHqJ67zf9RrezFJ9KzJkDwPX/7QZ/mhyXmaoVDtzDOJ5pXYe9WR+MVRBq9zhdaXScOK7AACVg=
X-Received: by 2002:a17:907:40c7:: with SMTP id nv7mr2786517ejb.16.1590670499198;
 Thu, 28 May 2020 05:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200505190151.28871-1-cgzones@googlemail.com> <CAEjxPJ4qJj4-of0F=TKZ1wb-s82_wbMCYLbFPuxJ57dqbNRjeQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4qJj4-of0F=TKZ1wb-s82_wbMCYLbFPuxJ57dqbNRjeQ@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Thu, 28 May 2020 14:54:48 +0200
Message-ID: <CAJ2a_Dcm30H+sOK0LKXV7Ypv7MBcqFgtS+iTh+No=R3kiQpnpA@mail.gmail.com>
Subject: Re: [PATCH] sepolgen: parse gen_tunable as bool
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Am Mi., 27. Mai 2020 um 17:04 Uhr schrieb Stephen Smalley
<stephen.smalley.work@gmail.com>:
>
> On Tue, May 5, 2020 at 3:03 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Currently sepolgen-ifgen parses a gen_tunable statement as interface
> > and reports:
> >
> >     Missing interface definition for gen_tunable
> >
> > Add grammar for gen_tunable statements in the refparser
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> This looks correct to me but I don't see that warning/error when
> running sepolgen-ifgen without this patch.
> Is this reproducible?
>

It should be when running in verbose mode. (running against Refpolicy)

> > ---
> >  python/sepolgen/src/sepolgen/refparser.py | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolge=
n/src/sepolgen/refparser.py
> > index 2e521a0f..be7e7890 100644
> > --- a/python/sepolgen/src/sepolgen/refparser.py
> > +++ b/python/sepolgen/src/sepolgen/refparser.py
> > @@ -126,6 +126,7 @@ tokens =3D (
> >      'GEN_REQ',
> >      'TEMPLATE',
> >      'GEN_CONTEXT',
> > +    'GEN_TUNABLE',
> >      #   m4
> >      'IFELSE',
> >      'IFDEF',
> > @@ -192,6 +193,7 @@ reserved =3D {
> >      'gen_require' : 'GEN_REQ',
> >      'template' : 'TEMPLATE',
> >      'gen_context' : 'GEN_CONTEXT',
> > +    'gen_tunable' : 'GEN_TUNABLE',
> >      # M4
> >      'ifelse' : 'IFELSE',
> >      'ifndef' : 'IFNDEF',
> > @@ -518,6 +520,7 @@ def p_policy_stmt(p):
> >                     | range_transition_def
> >                     | role_transition_def
> >                     | bool
> > +                   | gen_tunable
> >                     | define
> >                     | initial_sid
> >                     | genfscon
> > @@ -844,6 +847,17 @@ def p_bool(p):
> >          b.state =3D False
> >      p[0] =3D b
> >
> > +def p_gen_tunable(p):
> > +    '''gen_tunable : GEN_TUNABLE OPAREN IDENTIFIER COMMA TRUE CPAREN
> > +                   | GEN_TUNABLE OPAREN IDENTIFIER COMMA FALSE CPAREN'=
''
> > +    b =3D refpolicy.Bool()
> > +    b.name =3D p[3]
> > +    if p[5] =3D=3D "true":
> > +        b.state =3D True
> > +    else:
> > +        b.state =3D False
> > +    p[0] =3D b
> > +
> >  def p_conditional(p):
> >      ''' conditional : IF OPAREN cond_expr CPAREN OBRACE interface_stmt=
s CBRACE
> >                      | IF OPAREN cond_expr CPAREN OBRACE interface_stmt=
s CBRACE ELSE OBRACE interface_stmts CBRACE
> > --
> > 2.26.2
> >
