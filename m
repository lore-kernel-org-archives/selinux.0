Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C8AC433FE
	for <selinux@archiver.kernel.org>; Fri,  1 Apr 2022 15:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344846AbiDAPQM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Apr 2022 11:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348885AbiDAOu7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Apr 2022 10:50:59 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A3D2B3D44
        for <selinux@vger.kernel.org>; Fri,  1 Apr 2022 07:41:56 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-d6ca46da48so2861487fac.12
        for <selinux@vger.kernel.org>; Fri, 01 Apr 2022 07:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ml1EN8D4brTK7TT4u4IRV6oZGsyJWv/yTGBq+gTa75U=;
        b=HCxqqA99eegypiO56yrlYHC1BIstC2O49enQXi80jjYspU/e0uhc1QOByJ6ZxV7BgY
         3mkZAZWs7dQTW9fv6Dk6g7fgb/JyeXgOevqPXE35wsMa/nAKVean9mpVRVUxa4/T8HVq
         Wz9wal+9nTReG9ozfVKqYVTra3a6rVpsuYH8ZytnLyyzvenhXzddfnKNigyRmqsy3sXZ
         xa9aHkYzpXu3nkQiBWCLXNWcItac22CNIFFkN2ydpDq4RXubm5eKh3r9o1mZ6+YWMisb
         LJXGwuAhBYIFCte+BGkIoIhaGuV2kdLPOcW6M9z2JAmOJc0oClfTU/hvteFjprtBMDXt
         JY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ml1EN8D4brTK7TT4u4IRV6oZGsyJWv/yTGBq+gTa75U=;
        b=jSyLhxSOXVCZToz3xOi2ksgfB+G1ODEhyPGLgNhAziXBubqktW26pxIt24quFfPtSo
         1vq8/h9zbOZEMuVN9kfyb8CGtHivTh5/08U2ND2qfz+ws79uJDScf7eCbM6LioL0VMe0
         2X3sYvlbvOip4Mq3gQqc/aax99qWf+56GXh2UNI6P8A299OlShiKYpg09ns7lrKT7qWG
         LMuB1ncArv8FjLEQhi+l5KGWcGn1Q25mn908Y4d0K7MidOo/Ufpsh2kymAQen0kL0UQ6
         bj7RJ/ujoELR21b9fMK4yvDPPA6c08oAg9NP0YwZ+qJD3Zm6y4BcdlkEbZKQuiD77Zai
         AKGQ==
X-Gm-Message-State: AOAM530ayPEw6yzH3p6D07mfCUcwI7sfr2g3eV8ix5EM3W7B9SzdzOrU
        0GGrRskxbhFAoxdPYfKQz6une6iJ9LUQ9w+C7NAqLtdQt30=
X-Google-Smtp-Source: ABdhPJx1fc3DrPF8ogxXXuK53Et5ymBDsD6wcV/l08WpBcu+GcyiE+Uz0we3pWFpyrIwsgZvJbHbKsvybljeXKVkdUM=
X-Received: by 2002:a05:6871:81e:b0:dd:9f3e:c94a with SMTP id
 q30-20020a056871081e00b000dd9f3ec94amr5055050oap.156.1648824083269; Fri, 01
 Apr 2022 07:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220331144452.30869-1-cgzones@googlemail.com>
In-Reply-To: <20220331144452.30869-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 1 Apr 2022 10:41:12 -0400
Message-ID: <CAP+JOzSXbEZuEy_oMgWPbu_mcTZo_HBb6-YVR1ULKpY36z2nkQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: add missing oom checks
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 31, 2022 at 11:34 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Check return values of memory allocation functions and propagate their
> failure.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/kernel_to_cil.c  |  9 +++++++++
>  libsepol/src/kernel_to_conf.c |  4 ++++
>  libsepol/src/module_to_cil.c  | 11 +++++++++++
>  libsepol/src/policydb.c       |  3 ++-
>  4 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index 869f6940..9128ac55 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -190,6 +190,10 @@ static char *constraint_expr_to_str(struct policydb =
*pdb, struct constraint_expr
>                                 }
>                                 if (!names) {
>                                         names =3D strdup("NO_IDENTIFIER")=
;
> +                                       if (!names) {
> +                                               sepol_log_err("Out of mem=
ory");
> +                                               goto exit;
> +                                       }
>                                 }
>                                 if (strchr(names, ' ')) {
>                                         new_val =3D create_str("(%s %s (%=
s))", 3, op, attr1, names);
> @@ -568,6 +572,11 @@ static int write_sids_to_cil(FILE *out, const char *=
const *sid_to_str,
>                 } else {
>                         snprintf(unknown, 18, "%s%u", "UNKNOWN", i);
>                         sid =3D strdup(unknown);
> +                       if (!sid) {
> +                               sepol_log_err("Out of memory");
> +                               rc =3D -1;
> +                               goto exit;
> +                       }
>                 }
>                 rc =3D strs_add_at_index(strs, sid, i);
>                 if (rc !=3D 0) {
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
> index 3544f73d..63dffd9b 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -187,6 +187,10 @@ static char *constraint_expr_to_str(struct policydb =
*pdb, struct constraint_expr
>                                 }
>                                 if (!names) {
>                                         names =3D strdup("NO_IDENTIFIER")=
;
> +                                       if (!names) {
> +                                               sepol_log_err("Out of mem=
ory");
> +                                               goto exit;
> +                                       }
>                                 }
>                                 if (strchr(names, ' ')) {
>                                         new_val =3D create_str("%s %s { %=
s }", 3, attr1, op, names);
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index c9e88f1e..f2e8aff0 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -393,6 +393,8 @@ static int typealias_list_create(struct policydb *pdb=
)
>         }
>
>         typealias_lists =3D calloc(max_decl_id + 1, sizeof(*typealias_lis=
ts));
> +       if (!typealias_lists)
> +               goto exit;
>         typealias_lists_len =3D max_decl_id + 1;
>
>         rc =3D hashtab_map(pdb->p_types.table, typealiases_gather_map, pd=
b);
> @@ -1792,6 +1794,10 @@ static int constraint_expr_to_string(struct policy=
db *pdb, struct constraint_exp
>                                 }
>                                 if (num_names =3D=3D 0) {
>                                         names =3D strdup("NO_IDENTIFIER")=
;
> +                                       if (!names) {
> +                                               rc =3D -1;
> +                                               goto exit;
> +                                       }
>                                 } else {
>                                         rc =3D name_list_to_string(name_l=
ist, num_names, &names);
>                                         if (rc !=3D 0) {
> @@ -2556,6 +2562,11 @@ static int ocontext_isid_to_cil(struct policydb *p=
db, const char *const *sid_to_
>                         goto exit;
>                 }
>                 item->sid_key =3D strdup(sid);
> +               if (!item->sid_key) {
> +                       log_err("Out of memory");
> +                       rc =3D -1;
> +                       goto exit;
> +               }
>                 item->next =3D head;
>                 head =3D item;
>         }
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index fc71463e..5c7e35e8 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -1252,7 +1252,8 @@ int policydb_index_others(sepol_handle_t * handle,
>         if (!p->type_val_to_struct)
>                 return -1;
>
> -       cond_init_bool_indexes(p);
> +       if (cond_init_bool_indexes(p))
> +               return -1;
>
>         for (i =3D SYM_ROLES; i < SYM_NUM; i++) {
>                 free(p->sym_val_to_name[i]);
> --
> 2.35.1
>
