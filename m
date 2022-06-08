Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA37C433EF
	for <selinux@archiver.kernel.org>; Wed,  8 Jun 2022 18:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiFHSlm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jun 2022 14:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiFHSlm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jun 2022 14:41:42 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145271FA7C
        for <selinux@vger.kernel.org>; Wed,  8 Jun 2022 11:41:41 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id v143so6389521oie.13
        for <selinux@vger.kernel.org>; Wed, 08 Jun 2022 11:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WyJjqn/EtThDKvdu3IzPG0qenlEZpvC3TDM1W3ggDpg=;
        b=HEYnhK0opMDrfS1kePCivTlVL+KMlQdFDXniDs4vwDQ0BK8BTDkExZ8bRIBXRm9nGw
         YzEZuPFMkmkgxyXjTzPl4iGVwbbxKyrwvR1eiJWkGwtFpXVcRgxY9gEs5MgmIQgeSdoQ
         YLMmkbyn8D4AxLhi50Koeyg0eqLuPgGh6YViKACHXLknM73p5T2lWqnZQiI+MOKeWx0u
         KDarWkLrSIBOqPjWXUeYFRfjv+a5DVptZdT4xNZdOHrnGisXXzYp9uEOGneRpyLutXd9
         fcMaeqIg3UtOrhLqPpLmJPbl9fFNg0l5uhpx5PuQWNfEuUKvyxwtrkIzsQ+rQDBDF4ya
         Wdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WyJjqn/EtThDKvdu3IzPG0qenlEZpvC3TDM1W3ggDpg=;
        b=kOHUQgb7+WLfe2ETPWLzvKMZYAC29ruLKnkXLnPsmO4RSc5NRvCmOoC9N7SY3QeIxH
         zDTXbete9A2ktVQzm95dp/jmcx8PRoniYa2oCJAmQo+qmeIxKDKewPaX21gRDlCisTSr
         nquGEWmIqpKcnSuvZTyJtG0p661Q14BWEL23lTVy5zlCnQ+3QMVeEL+aRsM2cCnqfVNh
         4FWJuEiHOHvG8+w3vJmnTxEejQni1g/a/w6sWjuk3SqEpjWxjrNblgcaxsHAB4tQ+uNP
         4J++JMjK7Q7xr6PS2xy0LcEfl8rWrLFyYJLRj1TTI/WDoogg3IoUri5UrkmyrsZDt3mu
         YsdQ==
X-Gm-Message-State: AOAM531lzD/LtDC1p/o+7ReAds+QsBkNmVDXFXuTFYMj+g6EWc87aYXY
        +ajkfU5TiPoYursRefkijW6GgAE/xnvdwhQM2LY=
X-Google-Smtp-Source: ABdhPJyGnxn0UwoCpJ6thzWcJeA5SXr2vWgv3nod9vLBNw8E6pEpnkak/tik5XhyB+JLsMQFhkh8op44+m0xUjNgqs8=
X-Received: by 2002:a05:6808:208c:b0:32b:91e4:32e1 with SMTP id
 s12-20020a056808208c00b0032b91e432e1mr3238188oiw.182.1654713700438; Wed, 08
 Jun 2022 11:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220607150145.29757-1-cgzones@googlemail.com>
In-Reply-To: <20220607150145.29757-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 8 Jun 2022 14:41:29 -0400
Message-ID: <CAP+JOzT+AaQgOa1T0zxVOERwQZnjkkQ0dGiiarHbPCxVJo7pFg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: fix validation of user declarations in modules
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>, bauen1 <j2468h@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 7, 2022 at 11:54 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Users are allowed to be declared in modules. Modules do not get expanded
> leaving the `struct user_datum` members `exp_range` and `exp_dfltlevel`
> empty.
> Do no validate the expanded range and level for modular polices.
>
> Reported-by: bauen1 <j2468h@gmail.com>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/policydb_validate.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index da18282b..99d4eb7f 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -18,7 +18,7 @@ typedef struct validate {
>  typedef struct map_arg {
>         validate_t *flavors;
>         sepol_handle_t *handle;
> -       int mls;
> +       policydb_t *policy;
>  } map_arg_t;
>
>  static int create_gap_ebitmap(char **val_to_name, uint32_t nprim, ebitma=
p_t *gaps)
> @@ -571,7 +571,7 @@ static int validate_mls_range(mls_range_t *range, val=
idate_t *sens, validate_t *
>         return -1;
>  }
>
> -static int validate_user_datum(sepol_handle_t *handle, user_datum_t *use=
r, validate_t flavors[], int mls)
> +static int validate_user_datum(sepol_handle_t *handle, user_datum_t *use=
r, validate_t flavors[], policydb_t *p)
>  {
>         if (validate_value(user->s.value, &flavors[SYM_USERS]))
>                 goto bad;
> @@ -581,9 +581,9 @@ static int validate_user_datum(sepol_handle_t *handle=
, user_datum_t *user, valid
>                 goto bad;
>         if (validate_mls_semantic_level(&user->dfltlevel, &flavors[SYM_LE=
VELS], &flavors[SYM_CATS]))
>                 goto bad;
> -       if (mls && validate_mls_range(&user->exp_range, &flavors[SYM_LEVE=
LS], &flavors[SYM_CATS]))
> +       if (p->mls && p->policy_type !=3D POLICY_MOD && validate_mls_rang=
e(&user->exp_range, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
>                 goto bad;
> -       if (mls && validate_mls_level(&user->exp_dfltlevel, &flavors[SYM_=
LEVELS], &flavors[SYM_CATS]))
> +       if (p->mls && p->policy_type !=3D POLICY_MOD && validate_mls_leve=
l(&user->exp_dfltlevel, &flavors[SYM_LEVELS], &flavors[SYM_CATS]))
>                 goto bad;
>         if (user->bounds && validate_value(user->bounds, &flavors[SYM_USE=
RS]))
>                 goto bad;
> @@ -599,7 +599,7 @@ static int validate_user_datum_wrapper(__attribute__(=
(unused)) hashtab_key_t k,
>  {
>         map_arg_t *margs =3D args;
>
> -       return validate_user_datum(margs->handle, d, margs->flavors, marg=
s->mls);
> +       return validate_user_datum(margs->handle, d, margs->flavors, marg=
s->policy);
>  }
>
>  static int validate_bool_datum(sepol_handle_t *handle, cond_bool_datum_t=
 *boolean, validate_t flavors[])
> @@ -689,7 +689,7 @@ static int validate_datum(__attribute__ ((unused))has=
htab_key_t k, hashtab_datum
>
>  static int validate_datum_array_entries(sepol_handle_t *handle, policydb=
_t *p, validate_t flavors[])
>  {
> -       map_arg_t margs =3D { flavors, handle, p->mls };
> +       map_arg_t margs =3D { flavors, handle, p };
>
>         if (hashtab_map(p->p_commons.table, validate_common_datum_wrapper=
, &margs))
>                 goto bad;
> --
> 2.36.1
>
