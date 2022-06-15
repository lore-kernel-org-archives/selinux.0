Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8629C433EF
	for <selinux@archiver.kernel.org>; Wed, 15 Jun 2022 18:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244186AbiFOSSt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jun 2022 14:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242198AbiFOSSr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jun 2022 14:18:47 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA3C3CFD5
        for <selinux@vger.kernel.org>; Wed, 15 Jun 2022 11:18:46 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id i25so3531084oii.7
        for <selinux@vger.kernel.org>; Wed, 15 Jun 2022 11:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pqKDnVRTbEb8n6ahLqtrk51nmOklgalLN56htTnydaI=;
        b=Eg4HiaN2P3vdMEW+MTm3Ym2iILGI9N8/SHpbQZ8NokThhFoqb5qws4UgKdHv/t+0ig
         h4Dt/B1hpwppKAwu/uMifm5uWv4LBWaR06qe1gGIpzNXY5dEQCeaVF3fsLrKA6qiXMzq
         rrqgJJxjcrhaYfSNc5Yl5n4Bmu1SuhzszpC6pVT/KRPyVNaX7xiV4GNlE3vsLH+EsL4X
         X6OyGhnqMmyv7A0CgQxG7vuehPWvTbDiT5MVpP6xuxu9V06RZfHY+22z+KZ5gHUluX/B
         9HpJsFm+hlreqJPv5DHsMYU4CuFNnjI++8zIhdh0RH21TkGFGCGWHD6a6WKg2YCCBopX
         htSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pqKDnVRTbEb8n6ahLqtrk51nmOklgalLN56htTnydaI=;
        b=1QCYM3yvD0FLiv6QtiUqzfY/n0WipU4cnOeHG+c2N052lrq+AX0T9ASIC2l7XVggOO
         KVHxpm0Q7/99RhKqY9OHSM4xFCden4JpnOujMyRJCpNLW/ngrYSfeyr5WetIPrQLKz8S
         BJj6EZi+xKH0lq7kDhZQjEQVuklLek+jnC63zI/I/+N5W3wtk6DsFm+YH9XHSCxtLRYI
         HoP5WwVHrFI48Q3U2xiL8E3OVwv276eO2AlDpX6PPq91HmL/3VqUsC5XIhImzc6Zk3UP
         ZD14qWh1143EqaBh1rr6r/A+2a0tMJRFbV4v5TsWlfF+gIfaFuRID2uFQRNVNpLkUZNx
         05hg==
X-Gm-Message-State: AJIora8e6oUoOzw7Ystp/4giV2t97lSz1BbItmCZE1oeKe7FqjyvjkNK
        o2r6MdAaO20lE7pj158aQ1+YJ6J5RlfOQc9ljM46MVYy
X-Google-Smtp-Source: AGRyM1sydHSLCW3KesmFrmfEErXyzk79OgDzfckOuiybBEHGX5hNp198RlkIAvrYKbI6F1C673f/7KCDvhZG5pVsqH8=
X-Received: by 2002:a05:6808:20a6:b0:32f:3376:46f1 with SMTP id
 s38-20020a05680820a600b0032f337646f1mr525560oiw.182.1655317126009; Wed, 15
 Jun 2022 11:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220607150145.29757-1-cgzones@googlemail.com> <20220609081955.3887-1-cgzones@googlemail.com>
In-Reply-To: <20220609081955.3887-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 15 Jun 2022 14:18:35 -0400
Message-ID: <CAP+JOzSOgTt7qi_u788kKhdnwFcCemJuv8KinREHXrzeUg6M4A@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: fix validation of user declarations in
 non-base modules
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>, bauen1 <j2468h@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 9, 2022 at 4:27 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Users may be declared in non-base modules, which do not get expanded,
> leaving the `struct user_datum` members `exp_range` and `exp_dfltlevel`
> empty.
> Skip validation of the expanded range and level for non-base module
> polices.
>
> Reported-by: bauen1 <j2468h@gmail.com>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v2:
>    - update commit description and fix typos

Sorry, I didn't see this patch before I applied the first one.
Jim

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
