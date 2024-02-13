Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3A460866
	for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 20:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707856583; cv=none; b=fzNLQbj9tMKTYmBzxpnEB9v2PDI9gI/RNgUfCfrzWEfRHvu0rPOEPISaMKXA3l7YzbnDyPzjiTInjejfOzpRKxPBu8ABR6CJ9ofiYjl0saxHIJqOeaJFvbTwws8tq8KG+0Yk7a4Mq7rsxzpwDyNDGEWZp4IF3LlebOEiEZHbqXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707856583; c=relaxed/simple;
	bh=cLkA/Z6garRLM71AwYM4n/yOW/yh5UwmVegCd0aBArU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BMKUT/cRXhBrl/zn6F2ffFQqvvQb15B6YdXit7Y5q2a+pqTN/4dDRyW9YQLU585LkbW1DiKEccfT3ibwdn5+6oRGtS/u+1g6jngSdto/GGHa/LBi5jwgKeruY2LaSjKDmST4mwRhqjwWkxLHwa6q5r8fVUkuWqWyldyPAJ88I48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9uN3jJm; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9uN3jJm"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7d6a85586e3so1991460241.2
        for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 12:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707856581; x=1708461381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMWUyj6bcbyRq49PPsBNalPheQ+l21lka2+e0Kz7bpE=;
        b=l9uN3jJmSlO5h8ZgYuLzMJ9e1dMASzv3XgLa4BoXuNUGXnaRwGTYfPH+UZWLJGLuyG
         /UeJPdt0Sz1D8u28iqit0Ir8nI2A6rstLtnp1MMgViPQCvPax1v7/Rv8EoM7wKc5V69i
         WKb5B+xShzu7ifUZWBuy3syZqICinm+0E20OUYip1a2CjMQlh5Axin0ctTbh2prD6RSF
         egngA3wCy9mc48kBxrVAIskxldhj2O42YIoKmmnjMmHsgPp/6hyVq39uE6p2iWCisl/f
         MZL9k2M+JcH6lOYAI8nmrfUyYgTHXB0IAVmIxyBVnEgLtIl1qdBuvkHK9zFe8bVaZWZj
         PX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707856581; x=1708461381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMWUyj6bcbyRq49PPsBNalPheQ+l21lka2+e0Kz7bpE=;
        b=jTmvB0TLAAOa4fVS3CSqdJuSlqWpS6nDsEiAQtfp5mEGsA6rUmNBID5vypPXIhorqt
         2chradaCmvI0H33RLzArN36M17HrBn5E9EZkspHaiEUiorJ8sxO2KsBReDv3lg/xFu0P
         fiAsmo5SwUgzqaIbsIZ/0UAyK84gnxXHP4Ct4Yxp7CL5N/alljO29NSVqAWKev6rb3il
         uhHCfTs16JjCY7jVh+EAgoLNsz9CwE6ya9wBbOX+LyovUFRk5sfQVxElYiD6tI2azqON
         HwYaRJT/MwJ5zwXFmx5RxKyJDZM2AJv9Q4wHWX8MmftnJr5QPAq4/V8k1yfHK5VMcdTd
         ZsQA==
X-Gm-Message-State: AOJu0Yyd9ehrKYUObA0+GPgT1y6kj+GfK9iyN+3DmsOufhxNQWGPlCtG
	eSuFFQajqh03m68Wly44/Y3Pf1NJ6lCBDbLoSoKvacoCuOtLHT32mYptMQzi2P6I0Lv9yeM64mz
	Yq9VZTkwNABCKb4vloszDghtCLFpfbrhQ1Lk=
X-Google-Smtp-Source: AGHT+IGetHjebrkGdtFtwfU5gL79PSBahMtZWAk3sC1cTZrTQ3bO+vFsqS6rxK4VkGetyBoluOIz1Tn71fEI3i8Qp9Q=
X-Received: by 2002:a05:6102:188b:b0:46e:dcf4:6b4e with SMTP id
 ji11-20020a056102188b00b0046edcf46b4emr122366vsb.3.1707856580875; Tue, 13 Feb
 2024 12:36:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122135507.63506-1-cgzones@googlemail.com> <20240122135507.63506-6-cgzones@googlemail.com>
In-Reply-To: <20240122135507.63506-6-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 13 Feb 2024 15:36:09 -0500
Message-ID: <CAP+JOzRaAH3F7GR-TSabp61hR=etn+KkjwXP0LkkrXfeCjspQw@mail.gmail.com>
Subject: Re: [PATCH 06/15] checkpolicy: clean expression on error
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 8:55=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The passed expression needs to be transferred into the policy or free'd
> by the sink functions define_constraint() and define_validatetrans().
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/policy_define.c | 68 ++++++++++++++++++++++---------------
>  1 file changed, 40 insertions(+), 28 deletions(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index ec19da9d..97582630 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -3428,20 +3428,22 @@ int define_constraint(constraint_expr_t * expr)
>                 return 0;
>         }
>
> +       ebitmap_init(&classmap);
> +
>         depth =3D -1;
>         for (e =3D expr; e; e =3D e->next) {
>                 switch (e->expr_type) {
>                 case CEXPR_NOT:
>                         if (depth < 0) {
>                                 yyerror("illegal constraint expression");
> -                               return -1;
> +                               goto bad;
>                         }
>                         break;
>                 case CEXPR_AND:
>                 case CEXPR_OR:
>                         if (depth < 1) {
>                                 yyerror("illegal constraint expression");
> -                               return -1;
> +                               goto bad;
>                         }
>                         depth--;
>                         break;
> @@ -3449,51 +3451,48 @@ int define_constraint(constraint_expr_t * expr)
>                 case CEXPR_NAMES:
>                         if (e->attr & CEXPR_XTARGET) {
>                                 yyerror("illegal constraint expression");
> -                               return -1;      /* only for validatetrans=
 rules */
> +                               goto bad;       /* only for validatetrans=
 rules */
>                         }
>                         if (depth =3D=3D (CEXPR_MAXDEPTH - 1)) {
>                                 yyerror("constraint expression is too dee=
p");
> -                               return -1;
> +                               goto bad;
>                         }
>                         depth++;
>                         break;
>                 default:
>                         yyerror("illegal constraint expression");
> -                       return -1;
> +                       goto bad;
>                 }
>         }
>         if (depth !=3D 0) {
>                 yyerror("illegal constraint expression");
> -               return -1;
> +               goto bad;
>         }
>
> -       ebitmap_init(&classmap);
>         while ((id =3D queue_remove(id_queue))) {
>                 if (!is_id_in_scope(SYM_CLASSES, id)) {
>                         yyerror2("class %s is not within scope", id);
>                         free(id);
> -                       return -1;
> +                       goto bad;
>                 }
>                 cladatum =3D
>                     (class_datum_t *) hashtab_search(policydbp->p_classes=
.table,
>                                                      (hashtab_key_t) id);
>                 if (!cladatum) {
>                         yyerror2("class %s is not defined", id);
> -                       ebitmap_destroy(&classmap);
>                         free(id);
> -                       return -1;
> +                       goto bad;
>                 }
>                 if (ebitmap_set_bit(&classmap, cladatum->s.value - 1, TRU=
E)) {
>                         yyerror("out of memory");
> -                       ebitmap_destroy(&classmap);
>                         free(id);
> -                       return -1;
> +                       goto bad;
>                 }
>                 node =3D malloc(sizeof(struct constraint_node));
>                 if (!node) {
>                         yyerror("out of memory");
>                         free(node);
> -                       return -1;
> +                       goto bad;
>                 }
>                 memset(node, 0, sizeof(constraint_node_t));
>                 if (useexpr) {
> @@ -3505,7 +3504,7 @@ int define_constraint(constraint_expr_t * expr)
>                 if (!node->expr) {
>                         yyerror("out of memory");
>                         free(node);
> -                       return -1;
> +                       goto bad;
>                 }
>                 node->permissions =3D 0;
>
> @@ -3557,8 +3556,7 @@ int define_constraint(constraint_expr_t * expr)
>                                         yyerror2("permission %s is not"
>                                                  " defined for class %s",=
 id, policydbp->p_class_val_to_name[i]);
>                                         free(id);
> -                                       ebitmap_destroy(&classmap);
> -                                       return -1;
> +                                       goto bad;
>                                 }
>                         }
>                         node->permissions |=3D (UINT32_C(1) << (perdatum-=
>s.value - 1));
> @@ -3569,6 +3567,13 @@ int define_constraint(constraint_expr_t * expr)
>         ebitmap_destroy(&classmap);
>
>         return 0;
> +
> +bad:
> +       ebitmap_destroy(&classmap);
> +       if (useexpr)
> +               constraint_expr_destroy(expr);
> +
> +       return -1;
>  }
>
>  int define_validatetrans(constraint_expr_t * expr)
> @@ -3587,20 +3592,22 @@ int define_validatetrans(constraint_expr_t * expr=
)
>                 return 0;
>         }
>
> +       ebitmap_init(&classmap);
> +
>         depth =3D -1;
>         for (e =3D expr; e; e =3D e->next) {
>                 switch (e->expr_type) {
>                 case CEXPR_NOT:
>                         if (depth < 0) {
>                                 yyerror("illegal validatetrans expression=
");
> -                               return -1;
> +                               goto bad;
>                         }
>                         break;
>                 case CEXPR_AND:
>                 case CEXPR_OR:
>                         if (depth < 1) {
>                                 yyerror("illegal validatetrans expression=
");
> -                               return -1;
> +                               goto bad;
>                         }
>                         depth--;
>                         break;
> @@ -3608,47 +3615,45 @@ int define_validatetrans(constraint_expr_t * expr=
)
>                 case CEXPR_NAMES:
>                         if (depth =3D=3D (CEXPR_MAXDEPTH - 1)) {
>                                 yyerror("validatetrans expression is too =
deep");
> -                               return -1;
> +                               goto bad;
>                         }
>                         depth++;
>                         break;
>                 default:
>                         yyerror("illegal validatetrans expression");
> -                       return -1;
> +                       goto bad;
>                 }
>         }
>         if (depth !=3D 0) {
>                 yyerror("illegal validatetrans expression");
> -               return -1;
> +               goto bad;
>         }
>
> -       ebitmap_init(&classmap);
>         while ((id =3D queue_remove(id_queue))) {
>                 if (!is_id_in_scope(SYM_CLASSES, id)) {
>                         yyerror2("class %s is not within scope", id);
>                         free(id);
> -                       return -1;
> +                       goto bad;
>                 }
>                 cladatum =3D
>                     (class_datum_t *) hashtab_search(policydbp->p_classes=
.table,
>                                                      (hashtab_key_t) id);
>                 if (!cladatum) {
>                         yyerror2("class %s is not defined", id);
> -                       ebitmap_destroy(&classmap);
>                         free(id);
> -                       return -1;
> +                       goto bad;
>                 }
>                 if (ebitmap_set_bit(&classmap, (cladatum->s.value - 1), T=
RUE)) {
>                         yyerror("out of memory");
> -                       ebitmap_destroy(&classmap);
>                         free(id);
> -                       return -1;
> +                       goto bad;
>                 }
>
>                 node =3D malloc(sizeof(struct constraint_node));
>                 if (!node) {
>                         yyerror("out of memory");
> -                       return -1;
> +                       free(id);
> +                       goto bad;
>                 }
>                 memset(node, 0, sizeof(constraint_node_t));
>                 if (useexpr) {
> @@ -3668,6 +3673,13 @@ int define_validatetrans(constraint_expr_t * expr)
>         ebitmap_destroy(&classmap);
>
>         return 0;
> +
> +bad:
> +       ebitmap_destroy(&classmap);
> +       if (useexpr)
> +               constraint_expr_destroy(expr);
> +
> +       return -1;
>  }
>
>  uintptr_t define_cexpr(uint32_t expr_type, uintptr_t arg1, uintptr_t arg=
2)
> --
> 2.43.0
>
>
