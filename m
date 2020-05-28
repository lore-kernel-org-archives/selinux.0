Return-Path: <SRS0=TvmB=7K=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BE7C433E0
	for <selinux@archiver.kernel.org>; Thu, 28 May 2020 14:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D5C4208DB
	for <selinux@archiver.kernel.org>; Thu, 28 May 2020 14:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JHIu9d0+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391308AbgE1OwK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 May 2020 10:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391291AbgE1OwG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 May 2020 10:52:06 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1F5C05BD1E
        for <selinux@vger.kernel.org>; Thu, 28 May 2020 07:52:06 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o15so214138ejm.12
        for <selinux@vger.kernel.org>; Thu, 28 May 2020 07:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vMeLNdK4uMjiDXwD4az6CH3dN6YwF/6fkAszdRYbTbY=;
        b=JHIu9d0+6DSTHMXP82bFFC5F1vJhV7txKcB9JhXZsLulqfVXt/euCNzZY3WpXWIESN
         iIsMvCyI8V6hwaI9Vt6qOnvPssPsGZg0ln2W422piMNeDPAhk6bn2/LIR/h3x4y5W9xH
         NqE/okj4srEiLWgwy4NmoJ3Suagp3qmqsHFSrB5FayfyIIRZ/Dd70u/TPnaa5piOGIO0
         YB3WuM2/6XisZSV2Lng53QNXLm57d31swJoSlb4SPAiV+IFz7sjMwKJ8XBp5Tdt/SB0f
         BMhgfyJW/3yflgofuDy5/XsE9qwjGhXUu/xyiJU6z4MdBRz4QfSQL3iCx9BbHJyQnaa9
         SkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vMeLNdK4uMjiDXwD4az6CH3dN6YwF/6fkAszdRYbTbY=;
        b=gTKDQyBRkZfFZPQ6CkrjImL4elUXHMvGVIQOp2k3RYt8PudzZYx1fkgBN+lGlFw8aE
         c6fRSzDM8NEV7+YGkn34nZLcpDBRHYgw6uRhlASD83t43RTi8b41xyRqVT6T4E0EmWko
         Bp6Bru074cKg2AiN1No4VyE/Cjq4RSjDZUm9GiYw+AGhSeBT0PMXbFTXn9E1MUyzcchY
         rxO5XQ0SXCkAsor/2Pfn6tG0xSVkokIYvNL3SxZAah5OqWnX2K0gQCoSpHi6Hj9xrl7C
         fSlCVdD5EZUjb3aNPvRknb8h9AKk6oFKFbIWaGuOk17Imw/uu8/+Jb0hc1GP/5sHh1it
         3Q1w==
X-Gm-Message-State: AOAM530f2wfk6R+RVsAq99ekx1EvaFYrqu7UPnVgX8HBnZ5FAeWCGA0i
        hi/PNmbFxxIu2L7qMItA9iMNp6TC2rv31tpREHWRHrZUR6g=
X-Google-Smtp-Source: ABdhPJyd96pS5zfnJV9EAC2pITjrwu7Ov32/wxOZu4Z/hF3j7BM6iacrHM2boAUvJZ7lDwGUbEOnPxKnoNcpAfNWYRg=
X-Received: by 2002:a17:906:35cf:: with SMTP id p15mr3033721ejb.520.1590677525212;
 Thu, 28 May 2020 07:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ4qJj4-of0F=TKZ1wb-s82_wbMCYLbFPuxJ57dqbNRjeQ@mail.gmail.com>
 <20200528125128.26915-1-cgzones@googlemail.com> <CAEjxPJ5f2r5R3AhZUxdYhO1U-OWdEd_+Mxfh=Q-THAuGF=Q4nA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5f2r5R3AhZUxdYhO1U-OWdEd_+Mxfh=Q-THAuGF=Q4nA@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Thu, 28 May 2020 16:51:54 +0200
Message-ID: <CAJ2a_Df54uupe42E_Dkcpa-wP+DG+m3bWN-9My_bon=h9RNS9g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] sepolgen: parse gen_tunable as bool
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Am Do., 28. Mai 2020 um 16:23 Uhr schrieb Stephen Smalley
<stephen.smalley.work@gmail.com>:
>
> On Thu, May 28, 2020 at 8:52 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Currently sepolgen-ifgen parses a gen_tunable statement as interface
> > and reports in verbose mode:
> >
> >     Missing interface definition for gen_tunable
> >
> > Add grammar for gen_tunable statements in the refparser
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  python/sepolgen/src/sepolgen/refparser.py | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolge=
n/src/sepolgen/refparser.py
> > index 2e521a0f..f3e0ae87 100644
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
> > +    '''gen_tunable : GEN_TUNABLE OPAREN TICK IDENTIFIER SQUOTE COMMA T=
RUE CPAREN
> > +                   | GEN_TUNABLE OPAREN TICK IDENTIFIER SQUOTE COMMA F=
ALSE CPAREN'''
>
> Looks like you need to also support the case where no quoting is
> performed.  Otherwise, I still see syntax errors, e.g.
> /usr/share/selinux/refpolicy/include/services/apache.if: Syntax error
> on line 35 allow_httpd_$1_script_anon_write [type=3DIDENTIFIER]
>
> 35: gen_tunable(allow_httpd_$1_script_anon_write, false)

I tried to avoid that by modifying Refpolicy[1], but I can include the
additional grammar.


[1]: https://github.com/SELinuxProject/refpolicy/pull/201
