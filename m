Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3E3C433EF
	for <selinux@archiver.kernel.org>; Thu,  3 Mar 2022 21:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236631AbiCCVyJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Mar 2022 16:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbiCCVyJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Mar 2022 16:54:09 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3630A41612
        for <selinux@vger.kernel.org>; Thu,  3 Mar 2022 13:53:23 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id j9-20020a9d7d89000000b005ad5525ba09so5791403otn.10
        for <selinux@vger.kernel.org>; Thu, 03 Mar 2022 13:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HfP6OKlZVL9E9oC48rUWJ5si9Rx9NMCUxY8jo2pv6sk=;
        b=fqoaulA0eOx2I/liZpwtpnIf6xDP+rE020bD5pmvkC/QeqmGb3rBJBvOz6NjrOm9Hw
         ZdIJ9wQo/nxVFeTcASC3xK5mVynQd57mJsCYV3jAZf39BXdJlTIaKauBNvxbsSW7GFw3
         nCBNBU1jgLX6evfcpQrbMN7cBcyVUg615wPIo7+GN+iJQP6h/Iqy6jXXVeONW2VN24xP
         8qahuCZWvOlHoPYk124gmlugmzuDpLYIPxdPAQ9HAp60fDU2Zq3QQBWjYWAakEOyPV2I
         18zReqAtFzxs3Yug2lqVr18nn/w+wh1tdGIITCttMq2zUbxj25kID8/F68DNbnQy5E6W
         JJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HfP6OKlZVL9E9oC48rUWJ5si9Rx9NMCUxY8jo2pv6sk=;
        b=GLB7gsaaRSh+1hW91XD6YbIlkoJW4W0RV9ZjD3sGt4DOSfx3Zr6Xaw/lVey/xLHNRW
         Odt/bG7Miyd4J3jkpuLW8ic6z/BKcZC6NOFv8h+4ap6RcGDWQpg4TR/KkyK5oxRYeNlv
         Z6p8aLi/KcLLrBDrg99rPDw0CbOXczxGg8YKbLRuYvTLjMcL3pFnUYseOnfsmz/la46G
         gBsHwTmy1Ejlk9SO2WPXZxvn4ZEEl+Q+VHeGcCCX92KRXRiYxwAZiN6hK1E8RKQ20fAx
         8SFOHmvU0N3dPNVs2wei/gNnz4739m8x69op/aazJ9BWNYVzpXbL9mFuYfaDyKw08UtW
         YIVw==
X-Gm-Message-State: AOAM531UxNJS7sstQqjAWJF+w3nkWzmK/kQc2GwkVDfRVdGO4O0JLtp1
        t5TzWKH0JRG371F8JZi1ghD+Bz0Q2I3UopvwgqM=
X-Google-Smtp-Source: ABdhPJyrw4IJUKQSxFdOaDDPNyxjDWetiFTtqljRLzVRf+rKmbCNHm3vljLsT/pDBh09uWH70A7YfJW+Aqe+QCZnsFE=
X-Received: by 2002:a9d:6c8:0:b0:5ad:5a1e:f79d with SMTP id
 66-20020a9d06c8000000b005ad5a1ef79dmr20463406otx.154.1646344402369; Thu, 03
 Mar 2022 13:53:22 -0800 (PST)
MIME-Version: 1.0
References: <20220222135037.30497-1-cgzones@googlemail.com> <20220222181148.54329-1-cgzones@googlemail.com>
In-Reply-To: <20220222181148.54329-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 3 Mar 2022 16:53:11 -0500
Message-ID: <CAP+JOzQ+bEsoJyRhsGbJVALEzL6_VTtOvjh9f4nMzhv=nQvvig@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: validate expressions by evaluating
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 22, 2022 at 9:51 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Evaluate expressions similar to the actual kernel security server such
> that invalid expressions, e.g. `t2 =3D=3D t3` for validatetrans, are
> rejected.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v2:
>     reject third task context in normal constraints
> ---
>  libsepol/src/policydb_validate.c | 226 ++++++++++++++++++++++---------
>  1 file changed, 159 insertions(+), 67 deletions(-)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index 735c7a33..3b0ea0e1 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -223,90 +223,182 @@ bad:
>         return -1;
>  }
>
> -static int validate_constraint_nodes(sepol_handle_t *handle, unsigned in=
t nperms, constraint_node_t *cons, validate_t flavors[])
> +/*
> + * Follow evaluation of expressions to find invalid ones.
> + * Keep in sync with kernel source security/selinux/ss/services.c::const=
raint_expr_eval()
> + */
> +static int validate_expression(sepol_handle_t *handle, constraint_expr_t=
 *e, int validatetrans, validate_t flavors[])
>  {
> -       constraint_expr_t *cexp;
> -
> -       for (; cons; cons =3D cons->next) {
> -               if (nperms > 0 && cons->permissions =3D=3D 0)
> -                       goto bad;
> -               if (nperms > 0 && nperms !=3D PERM_SYMTAB_SIZE && cons->p=
ermissions >=3D (UINT32_C(1) << nperms))
> -                       goto bad;
> +       int sp =3D -1;

The function read_cons_helper() is used when reading in the policy and
it keeps track of the stack and will return an error if there is a
problem, so I don't think that this is going to be useful when
validating the policy.

Most of what you have here is concerned with keeping track of the
stack. There is more validation that can be done, however. See if the
patch that I sent to the list will meet your needs.

Thanks,
Jim


>
> -               for (cexp =3D cons->expr; cexp; cexp =3D cexp->next) {
> -                       if (cexp->attr & CEXPR_USER) {
> -                               if (validate_ebitmap(&cexp->names, &flavo=
rs[SYM_USERS]))
> -                                       goto bad;
> -                               if (validate_empty_type_set(cexp->type_na=
mes))
> -                                       goto bad;
> -                       } else if (cexp->attr & CEXPR_ROLE) {
> -                               if (validate_ebitmap(&cexp->names, &flavo=
rs[SYM_ROLES]))
> -                                       goto bad;
> -                               if (validate_empty_type_set(cexp->type_na=
mes))
> -                                       goto bad;
> -                       } else if (cexp->attr & CEXPR_TYPE) {
> -                               if (validate_ebitmap(&cexp->names, &flavo=
rs[SYM_TYPES]))
> -                                       goto bad;
> -                               if (validate_type_set(cexp->type_names, &=
flavors[SYM_TYPES]))
> -                                       goto bad;
> -                       } else {
> -                               if (!ebitmap_is_empty(&cexp->names))
> -                                       goto bad;
> -                               if (validate_empty_type_set(cexp->type_na=
mes))
> -                                       goto bad;
> -                       }
> +       for (; e; e =3D e->next) {
> +               /* validate symbols (implied in kernel source) */
> +               if (e->attr & CEXPR_USER) {
> +                       if (validate_ebitmap(&e->names, &flavors[SYM_USER=
S]))
> +                               goto bad;
> +                       if (validate_empty_type_set(e->type_names))
> +                               goto bad;
> +               } else if (e->attr & CEXPR_ROLE) {
> +                       if (validate_ebitmap(&e->names, &flavors[SYM_ROLE=
S]))
> +                               goto bad;
> +                       if (validate_empty_type_set(e->type_names))
> +                               goto bad;
> +               } else if (e->attr & CEXPR_TYPE) {
> +                       if (validate_ebitmap(&e->names, &flavors[SYM_TYPE=
S]))
> +                               goto bad;
> +                       if (validate_type_set(e->type_names, &flavors[SYM=
_TYPES]))
> +                               goto bad;
> +               } else {
> +                       if (!ebitmap_is_empty(&e->names))
> +                               goto bad;
> +                       if (validate_empty_type_set(e->type_names))
> +                               goto bad;
> +               }
>
> -                       if (cexp->expr_type =3D=3D CEXPR_ATTR || cexp->ex=
pr_type =3D=3D CEXPR_NAMES) {
> -                               switch (cexp->op) {
> -                               case CEXPR_EQ:
> -                               case CEXPR_NEQ:
> +               switch (e->expr_type) {
> +               case CEXPR_NOT:
> +                       if(sp < 0)
> +                               goto bad;
> +                       break;
> +               case CEXPR_AND:
> +                       if(sp < 0)
> +                               goto bad;
> +                       sp--;
> +                       break;
> +               case CEXPR_OR:
> +                       if(sp < 0)
> +                               goto bad;
> +                       sp--;
> +                       break;
> +               case CEXPR_ATTR:
> +                       if (sp =3D=3D (CEXPR_MAXDEPTH - 1))
> +                               return 0;
> +                       switch (e->attr) {
> +                       case CEXPR_USER:
> +                               break;
> +                       case CEXPR_TYPE:
> +                               break;
> +                       case CEXPR_ROLE:
> +                               switch (e->op) {
>                                 case CEXPR_DOM:
> +                                       ++sp;
> +                                       continue;
>                                 case CEXPR_DOMBY:
> +                                       ++sp;
> +                                       continue;
>                                 case CEXPR_INCOMP:
> -                                       break;
> +                                       ++sp;
> +                                       continue;
>                                 default:
> -                                       goto bad;
> -                               }
> -
> -                               switch (cexp->attr) {
> -                               case CEXPR_USER:
> -                               case CEXPR_USER | CEXPR_TARGET:
> -                               case CEXPR_USER | CEXPR_XTARGET:
> -                               case CEXPR_ROLE:
> -                               case CEXPR_ROLE | CEXPR_TARGET:
> -                               case CEXPR_ROLE | CEXPR_XTARGET:
> -                               case CEXPR_TYPE:
> -                               case CEXPR_TYPE | CEXPR_TARGET:
> -                               case CEXPR_TYPE | CEXPR_XTARGET:
> -                               case CEXPR_L1L2:
> -                               case CEXPR_L1H2:
> -                               case CEXPR_H1L2:
> -                               case CEXPR_H1H2:
> -                               case CEXPR_L1H1:
> -                               case CEXPR_L2H2:
>                                         break;
> -                               default:
> -                                       goto bad;
>                                 }
> -                       } else {
> -                               switch (cexp->expr_type) {
> -                               case CEXPR_NOT:
> -                               case CEXPR_AND:
> -                               case CEXPR_OR:
> -                                       break;
> +                               break;
> +                       case CEXPR_L1L2:
> +                               goto mls_ops;
> +                       case CEXPR_L1H2:
> +                               goto mls_ops;
> +                       case CEXPR_H1L2:
> +                               goto mls_ops;
> +                       case CEXPR_H1H2:
> +                               goto mls_ops;
> +                       case CEXPR_L1H1:
> +                               goto mls_ops;
> +                       case CEXPR_L2H2:
> +                               goto mls_ops;
> +mls_ops:
> +                               switch (e->op) {
> +                               case CEXPR_EQ:
> +                                       ++sp;
> +                                       continue;
> +                               case CEXPR_NEQ:
> +                                       ++sp;
> +                                       continue;
> +                               case CEXPR_DOM:
> +                                       ++sp;
> +                                       continue;
> +                               case CEXPR_DOMBY:
> +                                       ++sp;
> +                                       continue;
> +                               case CEXPR_INCOMP:
> +                                       ++sp;
> +                                       continue;
>                                 default:
>                                         goto bad;
>                                 }
> +                               break;
> +                       default:
> +                               goto bad;
> +                       }
>
> -                               if (cexp->op !=3D 0)
> +                       switch (e->op) {
> +                       case CEXPR_EQ:
> +                               ++sp;
> +                               break;
> +                       case CEXPR_NEQ:
> +                               ++sp;
> +                               break;
> +                       default:
> +                               goto bad;
> +                       }
> +                       break;
> +               case CEXPR_NAMES:
> +                       if (sp =3D=3D (CEXPR_MAXDEPTH-1))
> +                               return 0;
> +                       if (e->attr & CEXPR_TARGET)
> +                               ;
> +                       else if (e->attr & CEXPR_XTARGET) {
> +                               if (!validatetrans)
>                                         goto bad;
> +                       }
> +                       if (e->attr & CEXPR_USER)
> +                               ;
> +                       else if (e->attr & CEXPR_ROLE)
> +                               ;
> +                       else if (e->attr & CEXPR_TYPE)
> +                               ;
> +                       else
> +                               goto bad;
>
> -                               if (cexp->attr !=3D 0)
> -                                       goto bad;
> +                       switch (e->op) {
> +                       case CEXPR_EQ:
> +                               ++sp;
> +                               break;
> +                       case CEXPR_NEQ:
> +                               ++sp;
> +                               break;
> +                       default:
> +                               goto bad;
>                         }
> +                       break;
> +               default:
> +                       goto bad;
>                 }
>         }
>
> +       if (sp !=3D 0)
> +               goto bad;
> +
> +       return 0;
> +
> +bad:
> +       ERR(handle, "Invalid expression");
> +       return -1;
> +}
> +
> +static int validate_constraint_nodes(sepol_handle_t *handle, unsigned in=
t nperms, constraint_node_t *cons, int validatetrans, validate_t flavors[])
> +{
> +       for (; cons; cons =3D cons->next) {
> +               if (validatetrans && cons->permissions !=3D 0)
> +                       goto bad;
> +               if (!validatetrans && cons->permissions =3D=3D 0)
> +                       goto bad;
> +               if (!validatetrans && nperms !=3D PERM_SYMTAB_SIZE && con=
s->permissions >=3D (UINT32_C(1) << nperms))
> +                       goto bad;
> +
> +               if (validate_expression(handle, cons->expr, validatetrans=
, flavors))
> +                       goto bad;
> +       }
> +
>         return 0;
>
>  bad:
> @@ -320,9 +412,9 @@ static int validate_class_datum(sepol_handle_t *handl=
e, class_datum_t *class, va
>                 goto bad;
>         if (class->permissions.nprim > PERM_SYMTAB_SIZE)
>                 goto bad;
> -       if (validate_constraint_nodes(handle, class->permissions.nprim, c=
lass->constraints, flavors))
> +       if (validate_constraint_nodes(handle, class->permissions.nprim, c=
lass->constraints, 0, flavors))
>                 goto bad;
> -       if (validate_constraint_nodes(handle, 0, class->validatetrans, fl=
avors))
> +       if (validate_constraint_nodes(handle, class->permissions.nprim, c=
lass->validatetrans, 1, flavors))
>                 goto bad;
>
>         switch (class->default_user) {
> --
> 2.35.1
>
