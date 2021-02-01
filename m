Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC8FC433E6
	for <selinux@archiver.kernel.org>; Mon,  1 Feb 2021 15:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B06464EAA
	for <selinux@archiver.kernel.org>; Mon,  1 Feb 2021 15:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhBAPXP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Feb 2021 10:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhBAPXF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Feb 2021 10:23:05 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA51C061573
        for <selinux@vger.kernel.org>; Mon,  1 Feb 2021 07:22:25 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id i8so8508152ejc.7
        for <selinux@vger.kernel.org>; Mon, 01 Feb 2021 07:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2amyvVWh8xFcqsfA6loSYCM9SZGp+mQ8KM0rq4MWUdU=;
        b=DxnuEXWpc1G89oC+BItlIuPKZN65rRsXkK2ad5FDtd4Cu9YCuQq4djh933/flqzIc6
         RJQM4ccyoFJrM1OIpMnSULKds6J/mVIah/HV7HAmUkCw8AI5BQGrWXZ9Jxpa59V1Dkdz
         EOtN0AsirhrvFMel29uiaBE4uVx53SqK70j9MVIWAagXL37O/QxmBvH5Q8kNLU3I7IrN
         rdg4FFSerIWDPYCpDp7fd7EBNVq2Y5NT84R5BeUOzpaqqgSr07bi585JkoEqR+gVH/Pt
         LKm+3jff/W3mlEO4a3WiA7+g0B3HPcAv1ZNgt+vSchrmcaLHA2lb0rTZdFTwn1ehHnK0
         buAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=2amyvVWh8xFcqsfA6loSYCM9SZGp+mQ8KM0rq4MWUdU=;
        b=Fiwn27Df1ZumY7p+GQBMJJMZ7HadzuS1wGPZReJd5SuHXv1B5taIyiFV6aZzYaY/rY
         yQ1SuUuNLDKmastdMoPgjQuYxsHL5BO5TAsFkxtETauftrPT38JsS0tJ8f6zYI9+ULrz
         LJ5V4XnN4w0ZWs01TyuzGmJ/zZWtvu+McNh2wwW0mlc1cmuVr/yMC7XRKYOEVtm8HN6r
         f888J8bz9IVg3Pr764/2Vr1mJ6puNsEGHLj6N3nXK/fUBfD37QfJ3hk746sAMn0ls0wj
         xC0FwvjQNew2H/0YAFvAEtWCtbPuR1muwrqIbaqUP2IzL3y0n6m/l9Zk0LPXfVCxT0ey
         lAJg==
X-Gm-Message-State: AOAM532/GiDatCktJuGB+1kL1uT87NutLs7uoPHKBAf8Mp7LR3k1ZMn5
        v2Frrv960E6tL6LjNKGiGUhhA0rdkXRHo5fMJ5qi+WFkqsA=
X-Google-Smtp-Source: ABdhPJzuXaNiuCJSVyZ/ljXChL7LegWI/EGlI8VtYkLDPFOB1m4XAvnKWTKPBzoJ+C9jq2S8Gz5fUnJL358BnZUlk/I=
X-Received: by 2002:a17:906:5002:: with SMTP id s2mr17795367ejj.16.1612192943894;
 Mon, 01 Feb 2021 07:22:23 -0800 (PST)
MIME-Version: 1.0
References: <20210201145658.14919-1-cgzones@googlemail.com>
In-Reply-To: <20210201145658.14919-1-cgzones@googlemail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Mon, 1 Feb 2021 16:22:12 +0100
Message-ID: <CAJ2a_DdrpAAiJvs080Uh+7uZUgiQwTVn1JWVroZR-TxrdX77ng@mail.gmail.com>
Subject: Re: [PATCH] setfiles: drop now unused static variable
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Am Mo., 1. Feb. 2021 um 15:57 Uhr schrieb Christian G=C3=B6ttsche
<cgzones@googlemail.com>:
>
> be7f54cb1f88d96592af8f0df0e62dda002907a5 made the variable nerr useless.
> Remove it.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  policycoreutils/setfiles/setfiles.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfil=
es/setfiles.c
> index 92616571..f018d161 100644
> --- a/policycoreutils/setfiles/setfiles.c
> +++ b/policycoreutils/setfiles/setfiles.c
> @@ -19,7 +19,6 @@ static int warn_no_match;
>  static int null_terminated;
>  static int request_digest;
>  static struct restore_opts r_opts;
> -static int nerr;
>
>  #define STAT_BLOCK_SIZE 1
>
> @@ -161,7 +160,6 @@ int main(int argc, char **argv)
>         warn_no_match =3D 0;
>         request_digest =3D 0;
>         policyfile =3D NULL;
> -       nerr =3D 0;
>
>         r_opts.abort_on_error =3D 0;
>         r_opts.progname =3D strdup(argv[0]);
> @@ -427,9 +425,6 @@ int main(int argc, char **argv)
>         r_opts.selabel_opt_digest =3D (request_digest ? (char *)1 : NULL)=
;
>         r_opts.selabel_opt_path =3D altpath;
>
> -       if (nerr)
> -               exit(-1);
> -
>         restore_init(&r_opts);
>
>         if (use_input_file) {
> --
> 2.30.0
>

Duplicate of https://patchwork.kernel.org/project/selinux/patch/20210201143=
206.389547-1-plautrba@redhat.com/

Please ignore.
