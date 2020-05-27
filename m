Return-Path: <SRS0=EYrt=7J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463BAC433DF
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 15:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2206820899
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 15:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiJXm8ux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389536AbgE0PER (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 May 2020 11:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388922AbgE0PEQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 May 2020 11:04:16 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B63C05BD1E
        for <selinux@vger.kernel.org>; Wed, 27 May 2020 08:04:16 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id y85so21899017oie.11
        for <selinux@vger.kernel.org>; Wed, 27 May 2020 08:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SrbPa2EiaxewYnVB028yZhXQ2LqGI1lCiYG723SVmVs=;
        b=ZiJXm8uxg/0J/2PfCQyvQffSj+hlKYEOeIYnBWF3wRjDCxRuMt40LAg+Ssv5vumlxn
         DW+UjdsdZJ5dDxQTbhi21du8DQ2c3gGTFCNm2l7A70hoaFZbnlQhzMjoEOBEQqoxb5aY
         FcDs9xBMnT5UIuC1+QoPUNbbUnPKccCm3SAeB3bI4zy808t6iw3oGMr/pofacQqyL6om
         kMO3OXXlh/qPpAcUPQsMQXHATjUpDVMjSqbOjhjJPeTfkfAYyL7ao7uB+UAKaTXmUlHI
         /D8W8RxAXxslRUiJ4N01xm7KCYI7RyOu/TGxPpGnQIhulE3xJRImF1sNf2IFMa/C1Y7k
         Tnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SrbPa2EiaxewYnVB028yZhXQ2LqGI1lCiYG723SVmVs=;
        b=WI/yFp0kzIUQMNoqFxWErpQU58XML6lbxU9WcG1Zt2tnOX/BLjxjUx6FvQhUjQubAe
         KMrUq/f+t7uMuof5GJEMS0MLkvTtoRGm9eI1is6HNi6zrtp81InJWtFNHiboKdFrBTaT
         zmox0LwfcuzhabWxw+FJfV1sdBv/KUXMpiuobLBgiX4JH9FulJGKDHEqro7If8vNx9ME
         KJt2hnyYfe1a54juLssUtnd4nfYzY1EzA3+kGGo8GUiv6HkyZzyNUv8g/Q+IJ0vArERS
         uByYrRfUpgh+0KHyB11XFEjVBxwEtPXWmXUQdneyaZ4EUXUWQwy/3eZzV3qlmfISdc4o
         +1NA==
X-Gm-Message-State: AOAM5311lDtXchH7ENBo1ORgeERBMOYPRZl8temdTV5Mx+4WSfVhSdU1
        eRdWfxc7oPelrm/3CE2+A336o3Ab/sxiD7eRHUM=
X-Google-Smtp-Source: ABdhPJzWLFPIODa5C+kIRICC8i65tJwYeUgI95v9VWWJ5IV9KMDFfGueJfUWdO7lThTYNtvMWVUD/KJqvZJpbBMomyk=
X-Received: by 2002:aca:a948:: with SMTP id s69mr3023400oie.140.1590591856040;
 Wed, 27 May 2020 08:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200505190151.28871-1-cgzones@googlemail.com>
In-Reply-To: <20200505190151.28871-1-cgzones@googlemail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 27 May 2020 11:04:04 -0400
Message-ID: <CAEjxPJ4qJj4-of0F=TKZ1wb-s82_wbMCYLbFPuxJ57dqbNRjeQ@mail.gmail.com>
Subject: Re: [PATCH] sepolgen: parse gen_tunable as bool
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 5, 2020 at 3:03 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Currently sepolgen-ifgen parses a gen_tunable statement as interface
> and reports:
>
>     Missing interface definition for gen_tunable
>
> Add grammar for gen_tunable statements in the refparser
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

This looks correct to me but I don't see that warning/error when
running sepolgen-ifgen without this patch.
Is this reproducible?

> ---
>  python/sepolgen/src/sepolgen/refparser.py | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/python/sepolgen/src/sepolgen/refparser.py b/python/sepolgen/=
src/sepolgen/refparser.py
> index 2e521a0f..be7e7890 100644
> --- a/python/sepolgen/src/sepolgen/refparser.py
> +++ b/python/sepolgen/src/sepolgen/refparser.py
> @@ -126,6 +126,7 @@ tokens =3D (
>      'GEN_REQ',
>      'TEMPLATE',
>      'GEN_CONTEXT',
> +    'GEN_TUNABLE',
>      #   m4
>      'IFELSE',
>      'IFDEF',
> @@ -192,6 +193,7 @@ reserved =3D {
>      'gen_require' : 'GEN_REQ',
>      'template' : 'TEMPLATE',
>      'gen_context' : 'GEN_CONTEXT',
> +    'gen_tunable' : 'GEN_TUNABLE',
>      # M4
>      'ifelse' : 'IFELSE',
>      'ifndef' : 'IFNDEF',
> @@ -518,6 +520,7 @@ def p_policy_stmt(p):
>                     | range_transition_def
>                     | role_transition_def
>                     | bool
> +                   | gen_tunable
>                     | define
>                     | initial_sid
>                     | genfscon
> @@ -844,6 +847,17 @@ def p_bool(p):
>          b.state =3D False
>      p[0] =3D b
>
> +def p_gen_tunable(p):
> +    '''gen_tunable : GEN_TUNABLE OPAREN IDENTIFIER COMMA TRUE CPAREN
> +                   | GEN_TUNABLE OPAREN IDENTIFIER COMMA FALSE CPAREN'''
> +    b =3D refpolicy.Bool()
> +    b.name =3D p[3]
> +    if p[5] =3D=3D "true":
> +        b.state =3D True
> +    else:
> +        b.state =3D False
> +    p[0] =3D b
> +
>  def p_conditional(p):
>      ''' conditional : IF OPAREN cond_expr CPAREN OBRACE interface_stmts =
CBRACE
>                      | IF OPAREN cond_expr CPAREN OBRACE interface_stmts =
CBRACE ELSE OBRACE interface_stmts CBRACE
> --
> 2.26.2
>
