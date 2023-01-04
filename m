Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E766C4332F
	for <selinux@archiver.kernel.org>; Wed,  4 Jan 2023 17:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbjADR5q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Jan 2023 12:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239490AbjADR5n (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Jan 2023 12:57:43 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7F418B3F
        for <selinux@vger.kernel.org>; Wed,  4 Jan 2023 09:57:34 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id m18so84331294eji.5
        for <selinux@vger.kernel.org>; Wed, 04 Jan 2023 09:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ooV5hXX8BTYJwU4gNETuSW0za8WMnaxdvTkY8YQ9fk0=;
        b=KYJV3N3TvZOaOdFpZYda6bD4a4IHgdKh/ZtDu3mtQuNXSdf5B3HznkAxEjzTdWlMdv
         l9eigtfDZyCkp8euynMjG3Q5dr5eGmxj0XO2F7TZaa2iadK536rf+RG0arW2oVyiJTXl
         4uMNYWVPxt3I8h07vStwpvhjEylNwZ/pl3zrFK8j0mwirTGwcqPUDtGddiJ7Xj3QU1N6
         Y4ICnHhd+0M8Ms77HrvuQ/fVM5wVB+2k4ziXhOb/9remwLyDX62U11Iz8+hskTKlMaxm
         D5ZX0YJdElmyufRxjqszr3G43K8V277DV17p0/Ove7UH5G04bL+ApBh8msqCNfjemCT5
         ilPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ooV5hXX8BTYJwU4gNETuSW0za8WMnaxdvTkY8YQ9fk0=;
        b=EXTD0lWOKpHE3Bc8ha2t6Uu1upGeO2lhtdtg9oOATVO/sgk/6qhV49fC0A3fHiAEwb
         /Kwml4BhQMmfQsKnd4iEpgvc8Cn8j4pyBNiumd5yd5rfG1NOFB11hfIjWnhLByRas7Ek
         lTIpMN3Ie4md7NLWUkn680AWGe/bXQXqxfWksck/wBuL2nhYqX0STfoRwS4Ca6Fe2xBp
         qm1caybhHqk1h3Pq7QkZsAVldGANDlzJ1Jlq0VAuYYA/7cxLB1HiSH5N6+3oMTXpEEWW
         h0klvG7TZ4eTB+F/t9nuevzSPbjSkC/sZAkFyGRnmVpeWPRKeVlwSPwchLetw0eidwJv
         auvQ==
X-Gm-Message-State: AFqh2kq5dJzqy2nz/nWSfJ0JFVDFrm39sAD4/1huw+7dUwQ2GcQ+HhqJ
        iJA7iMs47ycQh5gGhA6IdpyOnkujNTAJBIx1iJACEJh/ZGI=
X-Google-Smtp-Source: AMrXdXufDpjlYfJKvGsPe/x1foApWC613v4GHYmaxj5t1Rms50TB7gn1Qc+oKeSnEuBGGSYqWEWL69zcmvl53iRnQoA=
X-Received: by 2002:a17:906:2c52:b0:7ad:b286:8ee2 with SMTP id
 f18-20020a1709062c5200b007adb2868ee2mr2823453ejh.511.1672855052908; Wed, 04
 Jan 2023 09:57:32 -0800 (PST)
MIME-Version: 1.0
References: <20221220154134.25652-1-cgzones@googlemail.com>
In-Reply-To: <20221220154134.25652-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 4 Jan 2023 12:57:21 -0500
Message-ID: <CAP+JOzSVkSkuoOkCYmzqY9Gamg-t28D7pZRSK3QSV3AD_Ger3w@mail.gmail.com>
Subject: Re: [PATCH] libsepol: reject attributes in type av rules for kernel policies
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Dec 20, 2022 at 10:44 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The kernel does not support type attributes as source or target in type
> av rules (type_transition, type_member, type_change)[1].  Such rules
> should have been expanded[2].
>
> [1]: https://github.com/SELinuxProject/selinux-kernel/blob/abe3c631447dcd=
1ba7af972fe6f054bee6f136fa/security/selinux/ss/services.c#L1843
> [2]: https://github.com/SELinuxProject/selinux/blob/0a8c177dacdc1df96ea11=
bb8aa75e16c4fa82285/libsepol/src/expand.c#L1981
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/policydb_validate.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index 521ea4ff..469c14f4 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -770,12 +770,20 @@ bad:
>   * Functions to validate a kernel policydb
>   */
>
> -static int validate_avtab_key(const avtab_key_t *key, int conditional, v=
alidate_t flavors[])
> +static int validate_avtab_key(const avtab_key_t *key, int conditional, c=
onst policydb_t *p, validate_t flavors[])
>  {
> -       if (validate_value(key->source_type, &flavors[SYM_TYPES]))
> -               goto bad;
> -       if (validate_value(key->target_type, &flavors[SYM_TYPES]))
> -               goto bad;
> +       if (p->policy_type =3D=3D POLICY_KERN && key->specified & AVTAB_T=
YPE) {
> +               if (validate_simpletype(key->source_type, p, flavors))
> +                       goto bad;
> +               if (validate_simpletype(key->target_type, p, flavors))
> +                       goto bad;
> +       } else {
> +               if (validate_value(key->source_type, &flavors[SYM_TYPES])=
)
> +                       goto bad;
> +               if (validate_value(key->target_type, &flavors[SYM_TYPES])=
)
> +                       goto bad;
> +       }
> +
>         if (validate_value(key->target_class, &flavors[SYM_CLASSES]))
>                 goto bad;
>         switch (0xFFF & key->specified) {
> @@ -821,7 +829,7 @@ static int validate_avtab_key_and_datum(avtab_key_t *=
k, avtab_datum_t *d, void *
>  {
>         map_arg_t *margs =3D args;
>
> -       if (validate_avtab_key(k, 0, margs->flavors))
> +       if (validate_avtab_key(k, 0, margs->policy, margs->flavors))
>                 return -1;
>
>         if ((k->specified & AVTAB_TYPE) && validate_simpletype(d->data, m=
args->policy, margs->flavors))
> @@ -845,13 +853,13 @@ static int validate_avtab(sepol_handle_t *handle, c=
onst avtab_t *avtab, const po
>         return 0;
>  }
>
> -static int validate_cond_av_list(sepol_handle_t *handle, const cond_av_l=
ist_t *cond_av, validate_t flavors[])
> +static int validate_cond_av_list(sepol_handle_t *handle, const cond_av_l=
ist_t *cond_av, const policydb_t *p, validate_t flavors[])
>  {
>         const struct avtab_node *avtab_ptr;
>
>         for (; cond_av; cond_av =3D cond_av->next) {
>                 for (avtab_ptr =3D cond_av->node; avtab_ptr; avtab_ptr =
=3D avtab_ptr->next) {
> -                       if (validate_avtab_key(&avtab_ptr->key, 1, flavor=
s)) {
> +                       if (validate_avtab_key(&avtab_ptr->key, 1, p, fla=
vors)) {
>                                 ERR(handle, "Invalid cond av list");
>                                 return -1;
>                         }
> @@ -996,9 +1004,9 @@ static int validate_cond_list(sepol_handle_t *handle=
, const cond_list_t *cond, c
>         for (; cond; cond =3D cond->next) {
>                 if (validate_cond_expr(handle, cond->expr, &flavors[SYM_B=
OOLS]))
>                         goto bad;
> -               if (validate_cond_av_list(handle, cond->true_list, flavor=
s))
> +               if (validate_cond_av_list(handle, cond->true_list, p, fla=
vors))
>                         goto bad;
> -               if (validate_cond_av_list(handle, cond->false_list, flavo=
rs))
> +               if (validate_cond_av_list(handle, cond->false_list, p, fl=
avors))
>                         goto bad;
>                 if (validate_avrules(handle, cond->avtrue_list, 1, p, fla=
vors))
>                         goto bad;
> --
> 2.39.0
>
