Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34D3C433F5
	for <selinux@archiver.kernel.org>; Fri, 11 Mar 2022 14:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244671AbiCKO6Z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Mar 2022 09:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiCKO6Z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Mar 2022 09:58:25 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4BD1B3A62
        for <selinux@vger.kernel.org>; Fri, 11 Mar 2022 06:57:22 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id b188so9527922oia.13
        for <selinux@vger.kernel.org>; Fri, 11 Mar 2022 06:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wo6294Wov9hPCGXj5o5Rb9r4rsx7B/R66Pmjhvy1K0w=;
        b=pkJL76gvsbOhZ2oYhEk4ISJCYKQQj+DxrkW3T+aeMK8+EjeHCWF3DPMk7PuuXmhqoC
         m+rTGlfsgP0Cd9YhVGY3CIfA0sqzFqDXoEfDX7Pq3St3mqJNPop6/nQvMlOMHRHMp4W7
         05DZxrzJtFdusBYAMaEhodifuhfj6goh7Up6j9KGzbcjdPg/p8Jb0d6irYyD7WMW1IVy
         f+yf38Wkq7RLqbq8ifwP+sAUAYPl9kuS8R1UduenSI98XJEByaDv/2nkPnZ3gGVnwL3q
         o7uPn6GvqYwqHhWc8gRe/VqF4IyIpakEQP9ni7BEC5Ds6oZG9fz73xUB7Ii3IXGAcGFU
         txUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wo6294Wov9hPCGXj5o5Rb9r4rsx7B/R66Pmjhvy1K0w=;
        b=ZhEWHbIqhLWgOP3oEZQ3A7syzjwlwvnNrBdwHrejjblbbq/oweDZxh3l0jfS58fMcf
         TUU+NzBzb5ra+UOFF7KBC282vUaT5EQuPxvTLlZd4o2RsSOOMw8Qh1vl/A8HdCCPioXb
         h2lRc7uYPpz0/4dwdnNgRu+onWG0Rta+QB8NYKQB+SB5DY3kvtCCkrj2UHvX64368eKy
         ublya+wjylU8e4PsFEpGJt0ec+XPpJa4syQdnfWbToYX81T6qMl5kkwtowjmfk9zvjXe
         5U4u8J5mcgnBx8LNIUc9sc2NBdocfyM3SDXeEzbLvw4/7IRUhjxw4hc7MtF8Mvwh8/CK
         14nQ==
X-Gm-Message-State: AOAM531fM0SuhAboCqMI8weacCHFgYOdRlD5SOygPuSvZtHApZhXAmpI
        X8nq4/NJe+W0zeHkt24HU1ZL+41utSoHsZU7+G5MXC/Koi8=
X-Google-Smtp-Source: ABdhPJz9remF+17orcTcn3ab0JpP3ublTtHDT3xuGtDwSAKw3cupnYEyBO5ohULXtG8luNMprZUsE3pa6A27tfW2u/g=
X-Received: by 2002:a54:4611:0:b0:2d7:988a:5784 with SMTP id
 p17-20020a544611000000b002d7988a5784mr12454998oip.156.1647010641636; Fri, 11
 Mar 2022 06:57:21 -0800 (PST)
MIME-Version: 1.0
References: <20220308185811.72407-1-cgzones@googlemail.com>
In-Reply-To: <20220308185811.72407-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 11 Mar 2022 09:57:10 -0500
Message-ID: <CAP+JOzQzJHNgxdOFj1LA6BKNpcxmVmA=vnF=EzsQoAeip+KqEw@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol: reject xperm av rules in conditional statements
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 8, 2022 at 2:35 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Extended permission and neverallow rules are not permitted in
> conditional statements.
>
> This causes issues on policy optimization where avtab_search() might
> return a non extended permission rule when searching for one.
>
> Found by oss-fuzz (#45327)
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For both patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/policydb_validate.c | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index 735c7a33..72063351 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -658,7 +658,7 @@ bad:
>   * Functions to validate a kernel policydb
>   */
>
> -static int validate_avtab_key(avtab_key_t *key, validate_t flavors[])
> +static int validate_avtab_key(avtab_key_t *key, int conditional, validat=
e_t flavors[])
>  {
>         if (validate_value(key->source_type, &flavors[SYM_TYPES]))
>                 goto bad;
> @@ -670,13 +670,16 @@ static int validate_avtab_key(avtab_key_t *key, val=
idate_t flavors[])
>         case AVTAB_ALLOWED:
>         case AVTAB_AUDITALLOW:
>         case AVTAB_AUDITDENY:
> -       case AVTAB_XPERMS_ALLOWED:
> -       case AVTAB_XPERMS_AUDITALLOW:
> -       case AVTAB_XPERMS_DONTAUDIT:
>         case AVTAB_TRANSITION:
>         case AVTAB_MEMBER:
>         case AVTAB_CHANGE:
>                 break;
> +       case AVTAB_XPERMS_ALLOWED:
> +       case AVTAB_XPERMS_AUDITALLOW:
> +       case AVTAB_XPERMS_DONTAUDIT:
> +               if (conditional)
> +                       goto bad;
> +               break;
>         default:
>                 goto bad;
>         }
> @@ -691,7 +694,7 @@ static int validate_avtab_key_and_datum(avtab_key_t *=
k, avtab_datum_t *d, void *
>  {
>         validate_t *flavors =3D (validate_t *)args;
>
> -       if (validate_avtab_key(k, flavors))
> +       if (validate_avtab_key(k, 0, flavors))
>                 return -1;
>
>         if ((k->specified & AVTAB_TYPE) && validate_value(d->data, &flavo=
rs[SYM_TYPES]))
> @@ -716,7 +719,7 @@ static int validate_cond_av_list(sepol_handle_t *hand=
le, cond_av_list_t *cond_av
>
>         for (; cond_av; cond_av =3D cond_av->next) {
>                 for (avtab_ptr =3D cond_av->node; avtab_ptr; avtab_ptr =
=3D avtab_ptr->next) {
> -                       if (validate_avtab_key(&avtab_ptr->key, flavors))=
 {
> +                       if (validate_avtab_key(&avtab_ptr->key, 1, flavor=
s)) {
>                                 ERR(handle, "Invalid cond av list");
>                                 return -1;
>                         }
> @@ -726,7 +729,7 @@ static int validate_cond_av_list(sepol_handle_t *hand=
le, cond_av_list_t *cond_av
>         return 0;
>  }
>
> -static int validate_avrules(sepol_handle_t *handle, avrule_t *avrule, va=
lidate_t flavors[])
> +static int validate_avrules(sepol_handle_t *handle, avrule_t *avrule, in=
t conditional, validate_t flavors[])
>  {
>         class_perm_node_t *class;
>
> @@ -746,14 +749,17 @@ static int validate_avrules(sepol_handle_t *handle,=
 avrule_t *avrule, validate_t
>                 case AVRULE_AUDITALLOW:
>                 case AVRULE_AUDITDENY:
>                 case AVRULE_DONTAUDIT:
> -               case AVRULE_NEVERALLOW:
>                 case AVRULE_TRANSITION:
>                 case AVRULE_MEMBER:
>                 case AVRULE_CHANGE:
> +                       break;
> +               case AVRULE_NEVERALLOW:
>                 case AVRULE_XPERMS_ALLOWED:
>                 case AVRULE_XPERMS_AUDITALLOW:
>                 case AVRULE_XPERMS_DONTAUDIT:
>                 case AVRULE_XPERMS_NEVERALLOW:
> +                       if (conditional)
> +                               goto bad;
>                         break;
>                 default:
>                         goto bad;
> @@ -814,9 +820,9 @@ static int validate_cond_list(sepol_handle_t *handle,=
 cond_list_t *cond, validat
>                         goto bad;
>                 if (validate_cond_av_list(handle, cond->false_list, flavo=
rs))
>                         goto bad;
> -               if (validate_avrules(handle, cond->avtrue_list, flavors))
> +               if (validate_avrules(handle, cond->avtrue_list, 1, flavor=
s))
>                         goto bad;
> -               if (validate_avrules(handle, cond->avfalse_list, flavors)=
)
> +               if (validate_avrules(handle, cond->avfalse_list, 1, flavo=
rs))
>                         goto bad;
>                 if (validate_bool_id_array(handle, cond->bool_ids, cond->=
nbools, &flavors[SYM_BOOLS]))
>                         goto bad;
> @@ -1098,7 +1104,7 @@ static int validate_avrule_blocks(sepol_handle_t *h=
andle, avrule_block_t *avrule
>                 for (decl =3D avrule_block->branch_list; decl !=3D NULL; =
decl =3D decl->next) {
>                         if (validate_cond_list(handle, decl->cond_list, f=
lavors))
>                                 goto bad;
> -                       if (validate_avrules(handle, decl->avrules, flavo=
rs))
> +                       if (validate_avrules(handle, decl->avrules, 0, fl=
avors))
>                                 goto bad;
>                         if (validate_role_trans_rules(handle, decl->role_=
tr_rules, flavors))
>                                 goto bad;
> --
> 2.35.1
>
