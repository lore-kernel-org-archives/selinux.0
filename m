Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FD33B47C4
	for <selinux@vger.kernel.org>; Tue, 19 May 2026 19:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779219463; cv=pass; b=mGekAhB3UdofwYoEM8qb8mBrIGjDXLvBdLgEOBJQgrmkZNGw9FeYgHxnY28Kf/w+kXwy0HWkcZFXt88+7+jIzq+shIteMAs6YE5Se9xz3ZxiKy73VM225/Q0QzUVt1yROP22Y99/y5bPUP0rV/W/GgMeWbyqFiUWJtKJMRzZ9ZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779219463; c=relaxed/simple;
	bh=6fUSsrPE9D0tfyKefyQ247PfW1OOLP1DA6DXNcsBNJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYsRLdri6xCOg4RjxG9XiwM1jBLJbM1IG9v4XicnD5F5LQzVdq3CqLMCizdI0/he1uG8B3TzIsK0m6bBYWJDU6EKx85h/HtCdKfqz285rfq2iXzWVvPH+CXyMKFTpzLh5F9n3W9EiT07P32tR5cxgLtqiU/3u+2UjObUgfFi8Cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhJsByWK; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhJsByWK"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39378db197aso44982841fa.3
        for <selinux@vger.kernel.org>; Tue, 19 May 2026 12:37:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779219459; cv=none;
        d=google.com; s=arc-20240605;
        b=eN9gLKFK4MxjEAz1wE8cTD2f0LDQohakLM9J6oC7Y2lcL/Vgnj6ygnNbGrM7dXY3SH
         DEjyW9r6dhjIvC8FsJgk/old6DQVcnHcH+weuZkTdWhlX0MSyqS+hRV/Uyc/zFqBeHHt
         CibwF5NY9zwwJzdgfKRvS8k7DrSz2l2zhADw6UUU1ysjcfqVpnL1MuO+Rgm4CjWuExOr
         /kFIn4/RKGylvmunV+nfkJYJWCL5NdKw04SmX26I/YDUi4Z4i2vq2udl9rwZtRKhQv2d
         7KGQWe9pUibx5tihRBbcP0ytY/74y/1Bfjyr3mZyjcun9imQc+v8dxDxmvS7TbrLwVqN
         Sq+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3ojsV/r+bvUUMXd73PazFCag+7C0R8A9iVj2lh90T+s=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=VS0yt9sIn6mgXZDd8U6vHndczszV8HnK4lM6IZqUJi8Y2VxN/eJ0+GIMsowPxyGkQA
         6iiFc84Zn4JKZSaf1cw/yO6ejfdRV+WLh/8oya/sf6F7QV1dkLkcKyuBk0yd1DjtVob7
         N/rHEbaw+fnS1ZNnweewhE4ttKOPkl2lgdHfCk/CpX5ntIH4TVDHo6oxWsw0XHCuX33u
         OH0EBUqLaYId6SgZ0I09KIPsh7R6WdyHmpDHtXzokNN+mJu8PWMl65K2HhaRTfVsXZ9H
         uV7OxXZDqyiOdznWNDKtuerc/PfAKVNMd1ovVW/TgScQ39oUnqul1EFxoWOSOvS2Wgl4
         W6gA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779219459; x=1779824259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ojsV/r+bvUUMXd73PazFCag+7C0R8A9iVj2lh90T+s=;
        b=jhJsByWKMJyK2Zh9G6/iGy3x8vzynsPc8MCNDdvdvrYsoCSSh5jim2G1UIa/fIQwWv
         coiJJxzx6ZtlmwEH01+ck6kOXKYySy61VerbfLDWofuPH5FdCyjixlxJtHZC0Q+Bzmxs
         SPXclfnrHlKG7DkNRnAis0OoGSDFhl/vxaHh0QpIJJA2slVveN9scVUcieIeYbdCp47J
         5i1qSn2CnhEj/xL2ugE7DJfNh3bbSOhnmhGjeeRcAs8x+8t6Xob6AW8SDnKUZ13Gjrk7
         ElBhAtTz0Dp9d3gBpqJNsllYl37xZ43E4wwRt3HC2SNKTeq29gSmMX4huBW86fwSI56p
         jw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779219459; x=1779824259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3ojsV/r+bvUUMXd73PazFCag+7C0R8A9iVj2lh90T+s=;
        b=cOnPrpvCL3JhhwcxQCeBmZ3L4UG6shr3wrYx2mFNCSeXWhjSsewE8KUAQf010mePDN
         5FxMlXIrKY+POf70nRI/tZkcQCLt5Fcfj99Lz2MOT6IQE+V357EImip9t1+Z4PXbIarv
         hPkkK7zX7hFh8CHw4q5o79J29HZUh8uh9GMxW3/UlHlLQsPLtIHia7LijPfYYI4ti6Ef
         /LAQgdSDpYxFd7ie+Xdg4TtYj/VzKghbl+f5f7Cqy4Qto7Tq2gq7rPXTHGQ3ZCjewu9R
         40HBIbW/pYKBBS3sl/9CIVyl+MWB4CKrulYCKL0MXv4UelJ8UFSUJq0ZyaVYtsr9oCpS
         SvtQ==
X-Gm-Message-State: AOJu0YztCF0xNcojCa7r0WNO0u58RU1krbeEhwnDbdzGmp0ee8XLoSY6
	xCJagCeKQl/XWT9cAYO8o4vg7jDgWUCeneqIer1MB99Mc6KQu0+cVAzktOCpSqCuPxUeKrKKK98
	3EAOfuJpeP81js73oNvArIJ5EhaV/i7E=
X-Gm-Gg: Acq92OE2aJt6tM8STqHYGodzi/SsRzmvqzIFwfTCHTROT+0QAnUrDav4IXagBwrWi5Q
	9cTRMosoU08+YEOAazYn0TKGuMh8qqTlnTDwGohF4vHSVMO6LC5NPL04x25ICRpxULrf23DMclK
	qnMJ/2AZmUb3Wm7kvYWGdM4tas7PVcZyrwPLNPXC8Zb9FmnbTRIEPXn2JbfvFcFLB8+EemzQR9F
	2huh8PAO3ngLe8UzpLwvKSB/ocIMT1ubhcdPMBSPdxdwBO4xgEe79B7iHHkrT/fDi7s5iI3RYU1
	zcrm
X-Received: by 2002:a05:651c:4184:b0:38b:f632:e0fc with SMTP id
 38308e7fff4ca-39561c076ebmr49685201fa.1.1779219458565; Tue, 19 May 2026
 12:37:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507235608.65529-1-kalevi@kolttonen.fi>
In-Reply-To: <20260507235608.65529-1-kalevi@kolttonen.fi>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 19 May 2026 15:37:27 -0400
X-Gm-Features: AVHnY4INnkWiXjfFIEt9npHyh0H8Kh91Eu4e-XImHa9CFrGRVFny8wPGK_6skzA
Message-ID: <CAP+JOzTF7SKz-sDE_LGPbjsKA+B+97CmY-7x5+JUQywtux-sJA@mail.gmail.com>
Subject: Re: [PATCH v2] checkpolicy: replace malloc()+memset() with calloc()
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 7:56=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttonen.f=
i> wrote:
>
> Replace malloc()+memset() pattern with calloc()
> and also remove unneeded casts while at it.
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/policy_define.c | 89 +++++++++++++------------------------
>  1 file changed, 31 insertions(+), 58 deletions(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index b73de45c..02e2c077 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -175,12 +175,11 @@ int define_class(void)
>                 yyerror("no class name for class definition?");
>                 return -1;
>         }
> -       datum =3D (class_datum_t *) malloc(sizeof(class_datum_t));
> +       datum =3D calloc(1, sizeof(class_datum_t));
>         if (!datum) {
>                 yyerror("out of memory");
>                 goto cleanup;
>         }
> -       memset(datum, 0, sizeof(class_datum_t));
>         ret =3D declare_symbol(SYM_CLASSES, id, datum, &value, &value);
>         switch (ret) {
>         case -3:{
> @@ -354,12 +353,11 @@ int define_initial_sid(void)
>                 yyerror("no sid name for SID definition?");
>                 return -1;
>         }
> -       newc =3D (ocontext_t *) malloc(sizeof(ocontext_t));
> +       newc =3D calloc(1, sizeof(ocontext_t));
>         if (!newc) {
>                 yyerror("out of memory");
>                 goto bad;
>         }
> -       memset(newc, 0, sizeof(ocontext_t));
>         newc->u.name =3D id;
>         context_init(&newc->context[0]);
>         head =3D policydbp->ocontexts[OCON_ISID];
> @@ -579,12 +577,11 @@ int define_common_perms(void)
>                 free(id);
>                 return -1;
>         }
> -       comdatum =3D (common_datum_t *) malloc(sizeof(common_datum_t));
> +       comdatum =3D calloc(1, sizeof(common_datum_t));
>         if (!comdatum) {
>                 yyerror("out of memory");
>                 goto bad;
>         }
> -       memset(comdatum, 0, sizeof(common_datum_t));
>         ret =3D hashtab_insert(policydbp->p_commons.table,
>                              (hashtab_key_t) id, (hashtab_datum_t) comdat=
um);
>
> @@ -603,12 +600,11 @@ int define_common_perms(void)
>         }
>         policydbp->p_commons.nprim++;
>         while ((perm =3D queue_remove(id_queue))) {
> -               perdatum =3D (perm_datum_t *) malloc(sizeof(perm_datum_t)=
);
> +               perdatum =3D calloc(1, sizeof(perm_datum_t));
>                 if (!perdatum) {
>                         yyerror("out of memory");
>                         goto bad_perm;
>                 }
> -               memset(perdatum, 0, sizeof(perm_datum_t));
>                 perdatum->s.value =3D comdatum->permissions.nprim + 1;
>
>                 if (perdatum->s.value > (sizeof(sepol_access_vector_t) * =
8)) {
> @@ -713,12 +709,11 @@ int define_av_perms(int inherits)
>                 cladatum->permissions.nprim +=3D comdatum->permissions.np=
rim;
>         }
>         while ((id =3D queue_remove(id_queue))) {
> -               perdatum =3D (perm_datum_t *) malloc(sizeof(perm_datum_t)=
);
> +               perdatum =3D calloc(1, sizeof(perm_datum_t));
>                 if (!perdatum) {
>                         yyerror("out of memory");
>                         goto bad;
>                 }
> -               memset(perdatum, 0, sizeof(perm_datum_t));
>                 perdatum->s.value =3D ++cladatum->permissions.nprim;
>
>                 if (perdatum->s.value > (sizeof(sepol_access_vector_t) * =
8)) {
> @@ -1330,13 +1325,12 @@ static int add_aliases_to_type(type_datum_t * typ=
e)
>                         free(id);
>                         return -1;
>                 }
> -               aliasdatum =3D (type_datum_t *) malloc(sizeof(type_datum_=
t));
> +               aliasdatum =3D calloc(1, sizeof(type_datum_t));
>                 if (!aliasdatum) {
>                         free(id);
>                         yyerror("Out of memory!");
>                         return -1;
>                 }
> -               memset(aliasdatum, 0, sizeof(type_datum_t));
>                 aliasdatum->s.value =3D type->s.value;
>
>                 ret =3D declare_symbol(SYM_TYPES, id, aliasdatum,
> @@ -1890,13 +1884,12 @@ int define_bool_tunable(int is_tunable)
>                 free(id);
>                 return -1;
>         }
> -       datum =3D (cond_bool_datum_t *) malloc(sizeof(cond_bool_datum_t))=
;
> +       datum =3D calloc(1, sizeof(cond_bool_datum_t));
>         if (!datum) {
>                 yyerror("out of memory");
>                 free(id);
>                 return -1;
>         }
> -       memset(datum, 0, sizeof(cond_bool_datum_t));
>         if (is_tunable)
>                 datum->flags |=3D COND_BOOL_FLAGS_TUNABLE;
>         ret =3D declare_symbol(SYM_BOOLS, id, datum, &value, &value);
> @@ -2519,7 +2512,7 @@ static int avrule_cpy(avrule_t *dest, const avrule_=
t *src)
>         /* increment through the class perms and copy over */
>         src_perms =3D src->perms;
>         while (src_perms) {
> -               dest_perms =3D (class_perm_node_t *) calloc(1, sizeof(cla=
ss_perm_node_t));
> +               dest_perms =3D calloc(1, sizeof(class_perm_node_t));
>                 if (!dest_perms) {
>                         yyerror("out of memory");
>                         return -1;
> @@ -2556,7 +2549,7 @@ static int define_te_avtab_ioctl(const avrule_t *av=
rule_template, avrule_t **ret
>         if (avrule_ioctl_completedriver(rangelist, &complete_driver))
>                 return -1;
>         if (complete_driver) {
> -               avrule =3D (avrule_t *) calloc(1, sizeof(avrule_t));
> +               avrule =3D calloc(1, sizeof(avrule_t));
>                 if (!avrule) {
>                         yyerror("out of memory");
>                         return -1;
> @@ -2591,7 +2584,7 @@ static int define_te_avtab_ioctl(const avrule_t *av=
rule_template, avrule_t **ret
>                         return -1;
>
>                 if (xperms) {
> -                       avrule =3D (avrule_t *) calloc(1, sizeof(avrule_t=
));
> +                       avrule =3D calloc(1, sizeof(avrule_t));
>                         if (!avrule) {
>                                 yyerror("out of memory");
>                                 return -1;
> @@ -2654,7 +2647,7 @@ static int define_te_avtab_netlink(const avrule_t *=
avrule_template, avrule_t **r
>                         return -1;
>
>                 if (xperms) {
> -                       avrule =3D (avrule_t *) calloc(1, sizeof(avrule_t=
));
> +                       avrule =3D calloc(1, sizeof(avrule_t));
>                         if (!avrule) {
>                                 yyerror("out of memory");
>                                 return -1;
> @@ -3343,12 +3336,11 @@ int define_role_trans(int class_specified)
>                                         }
>                                 }
>
> -                               tr =3D malloc(sizeof(struct role_trans));
> +                               tr =3D calloc(1, sizeof(struct role_trans=
));
>                                 if (!tr) {
>                                         yyerror("out of memory");
>                                         goto bad;
>                                 }
> -                               memset(tr, 0, sizeof(struct role_trans));
>                                 tr->role =3D i + 1;
>                                 tr->type =3D j + 1;
>                                 tr->tclass =3D k + 1;
> @@ -3359,12 +3351,11 @@ int define_role_trans(int class_specified)
>                 }
>         }
>         /* Now add the real rule */
> -       rule =3D malloc(sizeof(struct role_trans_rule));
> +       rule =3D calloc(1, sizeof(struct role_trans_rule));
>         if (!rule) {
>                 yyerror("out of memory");
>                 goto bad;
>         }
> -       memset(rule, 0, sizeof(struct role_trans_rule));
>         rule->roles =3D roles;
>         rule->types =3D types;
>         rule->classes =3D e_classes;
> @@ -3731,13 +3722,12 @@ int define_constraint(constraint_expr_t * expr)
>                         free(id);
>                         goto bad;
>                 }
> -               node =3D malloc(sizeof(struct constraint_node));
> +               node =3D calloc(1, sizeof(struct constraint_node));
>                 if (!node) {
>                         yyerror("out of memory");
>                         free(node);
>                         goto bad;
>                 }
> -               memset(node, 0, sizeof(constraint_node_t));
>                 if (useexpr) {
>                         node->expr =3D expr;
>                         useexpr =3D 0;
> @@ -3892,13 +3882,12 @@ int define_validatetrans(constraint_expr_t * expr=
)
>                         goto bad;
>                 }
>
> -               node =3D malloc(sizeof(struct constraint_node));
> +               node =3D calloc(1, sizeof(struct constraint_node));
>                 if (!node) {
>                         yyerror("out of memory");
>                         free(id);
>                         goto bad;
>                 }
> -               memset(node, 0, sizeof(constraint_node_t));
>                 if (useexpr) {
>                         node->expr =3D expr;
>                         useexpr =3D 0;
> @@ -4209,12 +4198,11 @@ cond_expr_t *define_cond_expr(uint32_t expr_type,=
 void *arg1, void *arg2)
>         }
>
>         /* create a new expression struct */
> -       expr =3D malloc(sizeof(struct cond_expr));
> +       expr =3D calloc(1, sizeof(struct cond_expr));
>         if (!expr) {
>                 yyerror("out of memory");
>                 return NULL;
>         }
> -       memset(expr, 0, sizeof(cond_expr_t));
>         expr->expr_type =3D expr_type;
>
>         /* create the type asked for */
> @@ -4864,12 +4852,11 @@ int define_fs_context(unsigned int major, unsigne=
d int minor)
>                 return 0;
>         }
>
> -       newc =3D (ocontext_t *) malloc(sizeof(ocontext_t));
> +       newc =3D calloc(1, sizeof(ocontext_t));
>         if (!newc) {
>                 yyerror("out of memory");
>                 return -1;
>         }
> -       memset(newc, 0, sizeof(ocontext_t));
>
>         newc->u.name =3D (char *)malloc(6);
>         if (!newc->u.name) {
> @@ -4924,12 +4911,11 @@ int define_pirq_context(unsigned int pirq)
>                 return 0;
>         }
>
> -       newc =3D malloc(sizeof(ocontext_t));
> +       newc =3D calloc(1, sizeof(ocontext_t));
>         if (!newc) {
>                 yyerror("out of memory");
>                 return -1;
>         }
> -       memset(newc, 0, sizeof(ocontext_t));
>
>         newc->u.pirq =3D pirq;
>
> @@ -4975,12 +4961,11 @@ int define_iomem_context(uint64_t low, uint64_t h=
igh)
>                 return 0;
>         }
>
> -       newc =3D malloc(sizeof(ocontext_t));
> +       newc =3D calloc(1, sizeof(ocontext_t));
>         if (!newc) {
>                 yyerror("out of memory");
>                 return -1;
>         }
> -       memset(newc, 0, sizeof(ocontext_t));
>
>         newc->u.iomem.low_iomem  =3D low;
>         newc->u.iomem.high_iomem =3D high;
> @@ -5036,12 +5021,11 @@ int define_ioport_context(unsigned long low, unsi=
gned long high)
>                 return 0;
>         }
>
> -       newc =3D malloc(sizeof(ocontext_t));
> +       newc =3D calloc(1, sizeof(ocontext_t));
>         if (!newc) {
>                 yyerror("out of memory");
>                 return -1;
>         }
> -       memset(newc, 0, sizeof(ocontext_t));
>
>         newc->u.ioport.low_ioport  =3D low;
>         newc->u.ioport.high_ioport =3D high;
> @@ -5097,12 +5081,11 @@ int define_pcidevice_context(unsigned long device=
)
>                 return 0;
>         }
>
> -       newc =3D malloc(sizeof(ocontext_t));
> +       newc =3D calloc(1, sizeof(ocontext_t));
>         if (!newc) {
>                 yyerror("out of memory");
>                 return -1;
>         }
> -       memset(newc, 0, sizeof(ocontext_t));
>
>         newc->u.device =3D device;
>
> @@ -5150,12 +5133,11 @@ int define_devicetree_context(void)
>                 return 0;
>         }
>
> -       newc =3D malloc(sizeof(ocontext_t));
> +       newc =3D calloc(1, sizeof(ocontext_t));
>         if (!newc) {
>                 yyerror("out of memory");
>                 return -1;
>         }
> -       memset(newc, 0, sizeof(ocontext_t));
>
>         newc->u.name =3D (char *)queue_remove(id_queue);
>         if (!newc->u.name) {
> @@ -5208,12 +5190,11 @@ int define_port_context(unsigned int low, unsigne=
d int high)
>                 return 0;
>         }
>
> -       newc =3D malloc(sizeof(ocontext_t));
> +       newc =3D calloc(1, sizeof(ocontext_t));
>         if (!newc) {
>                 yyerror("out of memory");
>                 return -1;
>         }
> -       memset(newc, 0, sizeof(ocontext_t));
>
>         id =3D (char *)queue_remove(id_queue);
>         if (!id) {
> @@ -5301,12 +5282,11 @@ int define_ibpkey_context(unsigned int low, unsig=
ned int high)
>                 return 0;
>         }
>
> -       newc =3D malloc(sizeof(*newc));
> +       newc =3D calloc(1, sizeof(*newc));
>         if (!newc) {
>                 yyerror("out of memory");
>                 return -1;
>         }
> -       memset(newc, 0, sizeof(*newc));
>
>         id =3D queue_remove(id_queue);
>         if (!id) {
> @@ -5411,12 +5391,11 @@ int define_ibendport_context(unsigned int port)
>                 return -1;
>         }
>
> -       newc =3D malloc(sizeof(*newc));
> +       newc =3D calloc(1, sizeof(*newc));
>         if (!newc) {
>                 yyerror("out of memory");
>                 return -1;
>         }
> -       memset(newc, 0, sizeof(*newc));
>
>         newc->u.ibendport.dev_name =3D queue_remove(id_queue);
>         if (!newc->u.ibendport.dev_name) {
> @@ -5484,12 +5463,11 @@ int define_netif_context(void)
>                 return 0;
>         }
>
> -       newc =3D (ocontext_t *) malloc(sizeof(ocontext_t));
> +       newc =3D calloc(1, sizeof(ocontext_t));
>         if (!newc) {
>                 yyerror("out of memory");
>                 return -1;
>         }
> -       memset(newc, 0, sizeof(ocontext_t));
>
>         newc->u.name =3D (char *)queue_remove(id_queue);
>         if (!newc->u.name) {
> @@ -5615,13 +5593,12 @@ int define_ipv4_node_context(void)
>                 yywarn("host bits in ipv4 address set");
>         }
>
> -       newc =3D malloc(sizeof(ocontext_t));
> +       newc =3D calloc(1, sizeof(ocontext_t));
>         if (!newc) {
>                 yyerror("out of memory");
>                 return -1;
>         }
>
> -       memset(newc, 0, sizeof(ocontext_t));
>         newc->u.node.addr =3D addr.s_addr;
>         newc->u.node.mask =3D mask.s_addr;
>
> @@ -5864,13 +5841,12 @@ int define_ipv6_node_context(void)
>                 yywarn("host bits in ipv6 address set");
>         }
>
> -       newc =3D malloc(sizeof(ocontext_t));
> +       newc =3D calloc(1, sizeof(ocontext_t));
>         if (!newc) {
>                 yyerror("out of memory");
>                 return -1;
>         }
>
> -       memset(newc, 0, sizeof(ocontext_t));
>         memcpy(&newc->u.node6.addr[0], &addr.s6_addr[0], 16);
>         memcpy(&newc->u.node6.mask[0], &mask.s6_addr[0], 16);
>
> @@ -5975,12 +5951,11 @@ int define_fs_use(int behavior)
>                 return 0;
>         }
>
> -       newc =3D (ocontext_t *) malloc(sizeof(ocontext_t));
> +       newc =3D calloc(1, sizeof(ocontext_t));
>         if (!newc) {
>                 yyerror("out of memory");
>                 return -1;
>         }
> -       memset(newc, 0, sizeof(ocontext_t));
>
>         newc->u.name =3D (char *)queue_remove(id_queue);
>         if (!newc->u.name) {
> @@ -6043,12 +6018,11 @@ static int define_genfs_context_helper(char *fsty=
pe, int has_type)
>         }
>
>         if (!genfs || strcmp(fstype, genfs->fstype)) {
> -               newgenfs =3D malloc(sizeof(struct genfs));
> +               newgenfs =3D calloc(1, sizeof(struct genfs));
>                 if (!newgenfs) {
>                         yyerror("out of memory");
>                         return -1;
>                 }
> -               memset(newgenfs, 0, sizeof(struct genfs));
>                 newgenfs->fstype =3D fstype;
>                 newgenfs->next =3D genfs;
>                 if (genfs_p)
> @@ -6061,12 +6035,11 @@ static int define_genfs_context_helper(char *fsty=
pe, int has_type)
>                 fstype =3D NULL;
>         }
>
> -       newc =3D (ocontext_t *) malloc(sizeof(ocontext_t));
> +       newc =3D calloc(1, sizeof(ocontext_t));
>         if (!newc) {
>                 yyerror("out of memory");
>                 return -1;
>         }
> -       memset(newc, 0, sizeof(ocontext_t));
>
>         newc->u.name =3D (char *)queue_remove(id_queue);
>         if (!newc->u.name)
> --
> 2.54.0
>
>
