Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C43DC433EF
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 20:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F2C2610A2
	for <selinux@archiver.kernel.org>; Tue, 14 Sep 2021 20:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhINUp1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Sep 2021 16:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbhINUpU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Sep 2021 16:45:20 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ACAC061574
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 13:44:02 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso338144otv.12
        for <selinux@vger.kernel.org>; Tue, 14 Sep 2021 13:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TEa9Mt88FI7+RMLSYIfN85ZdoIIbbYXSIgk66poijwA=;
        b=AsJqpkgqt/lPwmt3tAZNdVui/1s2UV/pxFy7luiZIEJCFH5nnxV7LqOoj52kbLqHBY
         +ykvGnQYWIzUF5HlIJzxCMUotlzfMG6U1E0Bl1XhDzTan83cnpT0liJRh8D6/nR79Ql/
         QFG/KbtYpukTrP4FA9d6L36OQpwGwvGEdEG7mdtOda5Geh4nNik7Ngtf095Vd1pualUD
         VXA46+rlnr/NdAynqB11/o3bE7ennssD5e5udMdJeDHNynQDYg4MT+CmoYpXMyLEvH0A
         cIaJrRC9cptjvtLsTxT8+cr8UCseqrfjAB++CoXCukgIABlCqPhSKKYpv1kGw3dOdIRM
         qPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TEa9Mt88FI7+RMLSYIfN85ZdoIIbbYXSIgk66poijwA=;
        b=xDP6SF3siNl1QCxVvoUK4JKkCpMRY5EB8o+KWZP26Inkt+D7krKT2G4FqnT1RWLqc4
         Gt6JxntoBIbMmxcHpP4ca4RvUHpdNihuwGxHDsMzHa0eEoV/ZwG7IcTAEpyCHOu+HmeL
         MKWnXSzyHsSSyIx9l7TviEVy+foYDQSMRvrVV4rLDq9xiteeeSnP2IHUTxQk9TkrGlM4
         ZkFhS90W3McSsIdND+YCCEcyhIpmeOcnKQREZFkLTytjrIYBCrfaaN1nxhEAAcitWffg
         hGz0lXDQUfIGxOqYHIVk54eDTxCcH1CQhU1c/7OgDEXFY6/0M+f9ZVZvA5VXv8tyjWSw
         Oltw==
X-Gm-Message-State: AOAM531Ze65hbmHF0DfMHrpCP4bVcyJ3DvSRD4nwHvJugPJ5RL1fRqYf
        gJ3kX6tRxvrGTG1WgkpSwrqM2BSROWPS10Xswdpa8ujau6g=
X-Google-Smtp-Source: ABdhPJws8XoX1Em4xauNBbvl2Qw6/c2WlWuBRG9sMHUaMcPM696xPkuj7xj7r007MKqIxuoJmaZ6rd3kGPe3BjJu33c=
X-Received: by 2002:a05:6830:1f0a:: with SMTP id u10mr16692092otg.53.1631652242015;
 Tue, 14 Sep 2021 13:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210914124828.19488-1-cgzones@googlemail.com> <20210914124828.19488-12-cgzones@googlemail.com>
In-Reply-To: <20210914124828.19488-12-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 14 Sep 2021 16:43:51 -0400
Message-ID: <CAP+JOzTkGLzLtSL8P0uTh2O9Vh4SzHLBuivGY8bEwqOf-96r3w@mail.gmail.com>
Subject: Re: [PATCH 11/13] checkpolicy: error out on parsing too big integers
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 14, 2021 at 8:51 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Error out instead of silently converting too big integer values in
> policy sources.
>
>     policy_parse.y:893:41: runtime error: implicit conversion from type '=
unsigned long' of value 18446744073709551615 (64-bit, unsigned) to type 'un=
signed int' changed the value to 4294967295 (32-bit, unsigned)
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  checkpolicy/policy_parse.y | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
> index 6098eb50..e969d973 100644
> --- a/checkpolicy/policy_parse.y
> +++ b/checkpolicy/policy_parse.y
> @@ -890,10 +890,22 @@ filename          : FILENAME
>                         { yytext[strlen(yytext) - 1] =3D '\0'; if (insert=
_id(yytext + 1,0)) return -1; }
>                         ;
>  number                 : NUMBER
> -                       { $$ =3D strtoul(yytext,NULL,0); }
> +                       { unsigned long x;
> +                         errno =3D 0;
> +                         x =3D strtoul(yytext, NULL, 0);
> +                         if (errno || x > UINT_MAX)
> +                             return -1;

Some compilers will emit a warning if unsigned long is 32 bits. To
prevent this use:

if (errno)
   return -1;

#if ULONG_MAX > UINT_MAX
    if (val > UINT_MAX) {
        return -1;
    }
#endif

See commit b7ea65f547c67bfbae4ae133052583b090747e5a

And discussion:
https://lore.kernel.org/selinux/CAFftDdrGoQezmVSOnrFrPKaOnS3pejQXzYpfjwQ+QB=
HH_Pv02w@mail.gmail.com/

Jim



> +                         $$ =3D (unsigned int) x;
> +                       }
>                         ;
>  number64               : NUMBER
> -                       { $$ =3D strtoull(yytext,NULL,0); }
> +                       { unsigned long long x;
> +                         errno =3D 0;
> +                         x =3D strtoull(yytext, NULL, 0);
> +                         if (errno)
> +                             return -1;
> +                         $$ =3D (uint64_t) x;
> +                       }
>                         ;
>  ipv6_addr              : IPV6_ADDR
>                         { if (insert_id(yytext,0)) return -1; }
> --
> 2.33.0
>
