Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3821CA47
	for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 20:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707856503; cv=none; b=dV2X7n+hS1k8F/X6QCsjk3+hf28aHPxoiHRuyM3+LbF9zLliLpxu8TKMO0A50TtVu9HJOI/H3TBH5VKBz1bHaQFtZNz0FcTcjkXqn3I8M4xpFcBZA3uXD5BISFjIkFAsfA8fuaAcX9llgq3m24vVLBitexluQWx85eDzRsQ7zSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707856503; c=relaxed/simple;
	bh=frhDCyBK7Qr6A89+vqIkW0kkOWblYfK8aMx/K6gOgOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UqY1ONxf+gwrBbmbelfUr5OxuAWz//4VL7C8P++xXHXfUag/W4kL7ayElsnth8uBqNZtgp4NglYE2FFrVjg6zasDIB38bFAlWkR6JAF+Z0oXOiQd42f7UpirS+FZ0g3CttEsiJfBnGSc4zDK2gAaBmxsTsC3MFRgEz9JzuETAw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYHklXdN; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYHklXdN"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7cedcea89a0so637822241.1
        for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 12:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707856501; x=1708461301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpgLufBJa59+0OlsFq1E8e/5ECAZycTqYauTFfnjOAw=;
        b=LYHklXdNLBGd5poKLLHJ6bVncNEA++ih0FBUqdnC3VI1yJHDsYrWAsSpT88/ith1dq
         A4W4aM8UtQbCwuNRsWTXVXYKkkJguBLQePLv1Kuk6bTm9JqYNrg82F2Hk8HlyX/lCMQP
         6vjw5FnDHkqbisT473MSkDlGhDQy7xRzbp8+RYiQrZgA1FQr1+LBJVb2sdsQmbScXm2O
         0NbKqXTeAOC60kFj7nG8N3tmCd1VT1RyeN6fvQLGdvidDOvjZki4WgwVoqK8I72XqND/
         s5Y7cFr9O+HDVgbYPi9XkU+dq3dE/v63UFabEg7TV0C7RedgcLFDTjfhRDHyehkGaXp7
         TFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707856501; x=1708461301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpgLufBJa59+0OlsFq1E8e/5ECAZycTqYauTFfnjOAw=;
        b=EUG7ibWsrbDYCfSOTORYoFqc0pO03BgWTsvpl618oBPd6kM7O12PJ1Eg/Xso5jQdNQ
         v+5JDe1wv9V1tl37D9WnU1fwQNlSYMBkpf8669Luh6Lx5HskfqVL7X07IcFdTDfpRxie
         B7i06wKqfIMLr+Jp16iv73Xn03cxnxze+bhbm8C03i4QrLkO6bJmLVeDXI/WAPp6h+v+
         n3Jp8ITN51V8HEl9tRt93OGfkmLN3tzLeazqicqEhZHhF+rYzjFDQiL2P3MmxUeIRbg6
         ZeX8PoLH3SEnCeJK+qIMmTx3cnU6IK+BaAZ5HQIFlahRjdjAU9G7A8wjxFigxJWW2KLS
         6Gpg==
X-Gm-Message-State: AOJu0YzqiUJNzQRZDigTf/MDD5eQRqNXgRvRoFi2UWQL11tSZqRhCDzq
	wVHE2szf+gfevjUN7eEyD+Q76LVfJ4UXxmdoNn5LQSF1UvHuxPYhmp5VAciQNnYm5ahty5vFrCh
	x+nJaX+++VpoGf7pI1kJuomOp81W4jHM+86w=
X-Google-Smtp-Source: AGHT+IFXeXgnKZVag31pN5O4ZmqDmdjZ7SPbSlqCzawWhXvSfwu18MaYqnOvZwye4A1Sssewi3JuMi4DnTdgPDYIPSU=
X-Received: by 2002:a05:6102:5487:b0:46e:cdcb:4471 with SMTP id
 bk7-20020a056102548700b0046ecdcb4471mr796782vsb.13.1707856500799; Tue, 13 Feb
 2024 12:35:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122135507.63506-1-cgzones@googlemail.com> <20240122135507.63506-3-cgzones@googlemail.com>
In-Reply-To: <20240122135507.63506-3-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 13 Feb 2024 15:34:49 -0500
Message-ID: <CAP+JOzTRv=kRsKS3FxYKA9bSY+a4ieEZGZSjkTaWR+d0oJttHg@mail.gmail.com>
Subject: Re: [PATCH 03/15] checkpolicy: cleanup identifiers on error
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 9:37=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Free identifiers removed from the queue but not yet owned by the policy
> on errors.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/policy_define.c | 32 ++++++++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 260e609d..db7e9d0e 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -342,6 +342,7 @@ static int read_classes(ebitmap_t *e_classes)
>         while ((id =3D queue_remove(id_queue))) {
>                 if (!is_id_in_scope(SYM_CLASSES, id)) {
>                         yyerror2("class %s is not within scope", id);
> +                       free(id);
>                         return -1;
>                 }
>                 cladatum =3D hashtab_search(policydbp->p_classes.table, i=
d);
> @@ -373,15 +374,18 @@ int define_default_user(int which)
>         while ((id =3D queue_remove(id_queue))) {
>                 if (!is_id_in_scope(SYM_CLASSES, id)) {
>                         yyerror2("class %s is not within scope", id);
> +                       free(id);
>                         return -1;
>                 }
>                 cladatum =3D hashtab_search(policydbp->p_classes.table, i=
d);
>                 if (!cladatum) {
>                         yyerror2("unknown class %s", id);
> +                       free(id);
>                         return -1;
>                 }
>                 if (cladatum->default_user && cladatum->default_user !=3D=
 which) {
>                         yyerror2("conflicting default user information fo=
r class %s", id);
> +                       free(id);
>                         return -1;
>                 }
>                 cladatum->default_user =3D which;
> @@ -405,15 +409,18 @@ int define_default_role(int which)
>         while ((id =3D queue_remove(id_queue))) {
>                 if (!is_id_in_scope(SYM_CLASSES, id)) {
>                         yyerror2("class %s is not within scope", id);
> +                       free(id);
>                         return -1;
>                 }
>                 cladatum =3D hashtab_search(policydbp->p_classes.table, i=
d);
>                 if (!cladatum) {
>                         yyerror2("unknown class %s", id);
> +                       free(id);
>                         return -1;
>                 }
>                 if (cladatum->default_role && cladatum->default_role !=3D=
 which) {
>                         yyerror2("conflicting default role information fo=
r class %s", id);
> +                       free(id);
>                         return -1;
>                 }
>                 cladatum->default_role =3D which;
> @@ -437,15 +444,18 @@ int define_default_type(int which)
>         while ((id =3D queue_remove(id_queue))) {
>                 if (!is_id_in_scope(SYM_CLASSES, id)) {
>                         yyerror2("class %s is not within scope", id);
> +                       free(id);
>                         return -1;
>                 }
>                 cladatum =3D hashtab_search(policydbp->p_classes.table, i=
d);
>                 if (!cladatum) {
>                         yyerror2("unknown class %s", id);
> +                       free(id);
>                         return -1;
>                 }
>                 if (cladatum->default_type && cladatum->default_type !=3D=
 which) {
>                         yyerror2("conflicting default type information fo=
r class %s", id);
> +                       free(id);
>                         return -1;
>                 }
>                 cladatum->default_type =3D which;
> @@ -469,15 +479,18 @@ int define_default_range(int which)
>         while ((id =3D queue_remove(id_queue))) {
>                 if (!is_id_in_scope(SYM_CLASSES, id)) {
>                         yyerror2("class %s is not within scope", id);
> +                       free(id);
>                         return -1;
>                 }
>                 cladatum =3D hashtab_search(policydbp->p_classes.table, i=
d);
>                 if (!cladatum) {
>                         yyerror2("unknown class %s", id);
> +                       free(id);
>                         return -1;
>                 }
>                 if (cladatum->default_range && cladatum->default_range !=
=3D which) {
>                         yyerror2("conflicting default range information f=
or class %s", id);
> +                       free(id);
>                         return -1;
>                 }
>                 cladatum->default_range =3D which;
> @@ -508,6 +521,7 @@ int define_common_perms(void)
>         comdatum =3D hashtab_search(policydbp->p_commons.table, id);
>         if (comdatum) {
>                 yyerror2("duplicate declaration for common %s\n", id);
> +               free(id);
>                 return -1;
>         }
>         comdatum =3D (common_datum_t *) malloc(sizeof(common_datum_t));
> @@ -770,12 +784,14 @@ int define_sens(void)
>         while ((id =3D queue_remove(id_queue))) {
>                 if (id_has_dot(id)) {
>                         yyerror("sensitivity aliases may not contain peri=
ods");
> -                       goto bad_alias;
> +                       free(id);
> +                       return -1;
>                 }
>                 aliasdatum =3D (level_datum_t *) malloc(sizeof(level_datu=
m_t));
>                 if (!aliasdatum) {
>                         yyerror("out of memory");
> -                       goto bad_alias;
> +                       free(id);
> +                       return -1;
>                 }
>                 level_datum_init(aliasdatum);
>                 aliasdatum->isalias =3D TRUE;
> @@ -940,12 +956,14 @@ int define_category(void)
>         while ((id =3D queue_remove(id_queue))) {
>                 if (id_has_dot(id)) {
>                         yyerror("category aliases may not contain periods=
");
> -                       goto bad_alias;
> +                       free(id);
> +                       return -1;
>                 }
>                 aliasdatum =3D (cat_datum_t *) malloc(sizeof(cat_datum_t)=
);
>                 if (!aliasdatum) {
>                         yyerror("out of memory");
> -                       goto bad_alias;
> +                       free(id);
> +                       return -1;
>                 }
>                 cat_datum_init(aliasdatum);
>                 aliasdatum->isalias =3D TRUE;
> @@ -3722,6 +3740,7 @@ uintptr_t define_cexpr(uint32_t expr_type, uintptr_=
t arg1, uintptr_t arg2)
>                                 if (!is_id_in_scope(SYM_USERS, id)) {
>                                         yyerror2("user %s is not within s=
cope",
>                                                  id);
> +                                       free(id);
>                                         constraint_expr_destroy(expr);
>                                         return 0;
>                                 }
> @@ -3733,6 +3752,7 @@ uintptr_t define_cexpr(uint32_t expr_type, uintptr_=
t arg1, uintptr_t arg2)
>                                                                     id);
>                                 if (!user) {
>                                         yyerror2("unknown user %s", id);
> +                                       free(id);
>                                         constraint_expr_destroy(expr);
>                                         return 0;
>                                 }
> @@ -3742,6 +3762,7 @@ uintptr_t define_cexpr(uint32_t expr_type, uintptr_=
t arg1, uintptr_t arg2)
>                                         yyerror2("role %s is not within s=
cope",
>                                                  id);
>                                         constraint_expr_destroy(expr);
> +                                       free(id);
>                                         return 0;
>                                 }
>                                 role =3D
> @@ -3753,6 +3774,7 @@ uintptr_t define_cexpr(uint32_t expr_type, uintptr_=
t arg1, uintptr_t arg2)
>                                 if (!role) {
>                                         yyerror2("unknown role %s", id);
>                                         constraint_expr_destroy(expr);
> +                                       free(id);
>                                         return 0;
>                                 }
>                                 val =3D role->s.value;
> @@ -3765,11 +3787,13 @@ uintptr_t define_cexpr(uint32_t expr_type, uintpt=
r_t arg1, uintptr_t arg2)
>                         } else {
>                                 yyerror("invalid constraint expression");
>                                 constraint_expr_destroy(expr);
> +                               free(id);
>                                 return 0;
>                         }
>                         if (ebitmap_set_bit(&expr->names, val - 1, TRUE))=
 {
>                                 yyerror("out of memory");
>                                 ebitmap_destroy(&expr->names);
> +                               free(id);
>                                 constraint_expr_destroy(expr);
>                                 return 0;
>                         }
> --
> 2.43.0
>
>
