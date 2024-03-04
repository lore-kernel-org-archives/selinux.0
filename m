Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2991879948
	for <selinux@vger.kernel.org>; Mon,  4 Mar 2024 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579855; cv=none; b=WKvIUD6kPSM34xTsnq4HtxQ3AbuFv9kMlYy48b7HoeosCODP40o778qgU0+ZWXyciH4HBU75ZIx11uqcmaBj+Lz+LpGKGyFJkAy4s+/VQ8qPbWNDrX3k3xMiLG8YQ6qCiDVa5miGZZAbF7gV8eGRzugZhisV+yWHppkYpSBrzSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579855; c=relaxed/simple;
	bh=l3ooQ59YSZn4wVsfk9uTrzX6M1IMqVj1MpDFxJQw8LY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NmslogBiJnhI949RoBYgSHnt0ogefsSX/YSPzancxfhXOYgk+hJaq2+h2RJHUILhanmwdbdrn78pmwesplqzGubzivh1tSm9//h65MLqOj7UcEV5jFji6mwqhkVGgDo0eDvGFh/qootuNaCeCmB7NlF/Q4TLM/b/EfNA4JuYQcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ygw5tyvf; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ygw5tyvf"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-472640aba12so1037673137.2
        for <selinux@vger.kernel.org>; Mon, 04 Mar 2024 11:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709579853; x=1710184653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VtMLg+oLszrMY+DVJoVHi9fuGQMB3s0ecbOOLIoXFg=;
        b=Ygw5tyvf2hWdnleKCrOW1vuz/2QFqCI0BZlk+RiG/+4xSqMY5Y5jJtOCjNTWlSWNv5
         /ELZnsV7jcWcGZkncgHnARBcDfCZHQLzoainD6JD+laf1LwrbLcCkgz9bFOAi5/47g68
         om3QghYzw4zmBQBfiOc6t6ORO+8tydPVFt/DPl78V2NqsnMsMc2UwqwWnm0CUsM3Qp1z
         tFurNAUop6qbB4pV8fSc1zs6KJ78RNccrS+bmi9JtHLeoclT92vfknXhgQSQ81YU4BqM
         6tOIJFL9+yyFeC3LQEBv8PKDlb5pu2REk4KrD1OsM0mVr7TYSWExLgHh9Ru8o3YNzLh7
         UtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579853; x=1710184653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VtMLg+oLszrMY+DVJoVHi9fuGQMB3s0ecbOOLIoXFg=;
        b=pIz0zs5b9c2TwPW8ByWQyUfZXbds3FlQthPb96McORSNphArdMeV2R2dhkEK0mDKCa
         O8eGW/2M8n2WeRU74FHR3p85ExqT8+NoOkFzVy+G4bv9ht0n2EIkv2hNRMCVIHWrAmpA
         8W567+W80Ajd1LdC9M9Ezp7EzsOgI2n0UpyccpBtZB5Tqemg9HKxSGU1OWs5mkoiHSjL
         jFdu6odX7Ul9Q3eXZwL0hG02V0Kuayl/Xr+SItY8xYyMXH1FHF12mJeZAfqDmvEneZ8X
         SPv9Njetu/8cfdJSaMNYhZRwSUKRGeyLPkd50XDJA+C9LDodafUs2EavP1/Z6uXvLyOE
         NeyQ==
X-Gm-Message-State: AOJu0YwVlNyWRbh8ktOMvIS4N74NzE5/IiNderv74tMI4Eq5aUyE9pe0
	RBa+u6pFfFIeMHzrMoBtXm20bA10qb4AWEERPaPboMTmLWsA/lFhfeCFbn05BAbjQXl166U/xqT
	OINUaLQJWTmhejsPZyXK+wbVN87E=
X-Google-Smtp-Source: AGHT+IF8ddDYVvcw4JgAL/wB2Er98yjTeEyTnBuwHwjmmt+wbYY2HESGw5dZaVrlpzUIaJCFoO8NHWPYTtKzLBkoJKY=
X-Received: by 2002:a05:6102:ac9:b0:472:5960:9e9b with SMTP id
 m9-20020a0561020ac900b0047259609e9bmr8365980vsh.29.1709579851536; Mon, 04 Mar
 2024 11:17:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122135507.63506-1-cgzones@googlemail.com>
 <20240122135507.63506-3-cgzones@googlemail.com> <CAP+JOzTRv=kRsKS3FxYKA9bSY+a4ieEZGZSjkTaWR+d0oJttHg@mail.gmail.com>
In-Reply-To: <CAP+JOzTRv=kRsKS3FxYKA9bSY+a4ieEZGZSjkTaWR+d0oJttHg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 4 Mar 2024 14:17:20 -0500
Message-ID: <CAP+JOzTXmq415baQq73GdisACEuq2Yj9c4SMk+n9HvCgTSzB4Q@mail.gmail.com>
Subject: Re: [PATCH 03/15] checkpolicy: cleanup identifiers on error
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:34=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Jan 22, 2024 at 9:37=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Free identifiers removed from the queue but not yet owned by the policy
> > on errors.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  checkpolicy/policy_define.c | 32 ++++++++++++++++++++++++++++----
> >  1 file changed, 28 insertions(+), 4 deletions(-)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index 260e609d..db7e9d0e 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -342,6 +342,7 @@ static int read_classes(ebitmap_t *e_classes)
> >         while ((id =3D queue_remove(id_queue))) {
> >                 if (!is_id_in_scope(SYM_CLASSES, id)) {
> >                         yyerror2("class %s is not within scope", id);
> > +                       free(id);
> >                         return -1;
> >                 }
> >                 cladatum =3D hashtab_search(policydbp->p_classes.table,=
 id);
> > @@ -373,15 +374,18 @@ int define_default_user(int which)
> >         while ((id =3D queue_remove(id_queue))) {
> >                 if (!is_id_in_scope(SYM_CLASSES, id)) {
> >                         yyerror2("class %s is not within scope", id);
> > +                       free(id);
> >                         return -1;
> >                 }
> >                 cladatum =3D hashtab_search(policydbp->p_classes.table,=
 id);
> >                 if (!cladatum) {
> >                         yyerror2("unknown class %s", id);
> > +                       free(id);
> >                         return -1;
> >                 }
> >                 if (cladatum->default_user && cladatum->default_user !=
=3D which) {
> >                         yyerror2("conflicting default user information =
for class %s", id);
> > +                       free(id);
> >                         return -1;
> >                 }
> >                 cladatum->default_user =3D which;
> > @@ -405,15 +409,18 @@ int define_default_role(int which)
> >         while ((id =3D queue_remove(id_queue))) {
> >                 if (!is_id_in_scope(SYM_CLASSES, id)) {
> >                         yyerror2("class %s is not within scope", id);
> > +                       free(id);
> >                         return -1;
> >                 }
> >                 cladatum =3D hashtab_search(policydbp->p_classes.table,=
 id);
> >                 if (!cladatum) {
> >                         yyerror2("unknown class %s", id);
> > +                       free(id);
> >                         return -1;
> >                 }
> >                 if (cladatum->default_role && cladatum->default_role !=
=3D which) {
> >                         yyerror2("conflicting default role information =
for class %s", id);
> > +                       free(id);
> >                         return -1;
> >                 }
> >                 cladatum->default_role =3D which;
> > @@ -437,15 +444,18 @@ int define_default_type(int which)
> >         while ((id =3D queue_remove(id_queue))) {
> >                 if (!is_id_in_scope(SYM_CLASSES, id)) {
> >                         yyerror2("class %s is not within scope", id);
> > +                       free(id);
> >                         return -1;
> >                 }
> >                 cladatum =3D hashtab_search(policydbp->p_classes.table,=
 id);
> >                 if (!cladatum) {
> >                         yyerror2("unknown class %s", id);
> > +                       free(id);
> >                         return -1;
> >                 }
> >                 if (cladatum->default_type && cladatum->default_type !=
=3D which) {
> >                         yyerror2("conflicting default type information =
for class %s", id);
> > +                       free(id);
> >                         return -1;
> >                 }
> >                 cladatum->default_type =3D which;
> > @@ -469,15 +479,18 @@ int define_default_range(int which)
> >         while ((id =3D queue_remove(id_queue))) {
> >                 if (!is_id_in_scope(SYM_CLASSES, id)) {
> >                         yyerror2("class %s is not within scope", id);
> > +                       free(id);
> >                         return -1;
> >                 }
> >                 cladatum =3D hashtab_search(policydbp->p_classes.table,=
 id);
> >                 if (!cladatum) {
> >                         yyerror2("unknown class %s", id);
> > +                       free(id);
> >                         return -1;
> >                 }
> >                 if (cladatum->default_range && cladatum->default_range =
!=3D which) {
> >                         yyerror2("conflicting default range information=
 for class %s", id);
> > +                       free(id);
> >                         return -1;
> >                 }
> >                 cladatum->default_range =3D which;
> > @@ -508,6 +521,7 @@ int define_common_perms(void)
> >         comdatum =3D hashtab_search(policydbp->p_commons.table, id);
> >         if (comdatum) {
> >                 yyerror2("duplicate declaration for common %s\n", id);
> > +               free(id);
> >                 return -1;
> >         }
> >         comdatum =3D (common_datum_t *) malloc(sizeof(common_datum_t));
> > @@ -770,12 +784,14 @@ int define_sens(void)
> >         while ((id =3D queue_remove(id_queue))) {
> >                 if (id_has_dot(id)) {
> >                         yyerror("sensitivity aliases may not contain pe=
riods");
> > -                       goto bad_alias;
> > +                       free(id);
> > +                       return -1;
> >                 }
> >                 aliasdatum =3D (level_datum_t *) malloc(sizeof(level_da=
tum_t));
> >                 if (!aliasdatum) {
> >                         yyerror("out of memory");
> > -                       goto bad_alias;
> > +                       free(id);
> > +                       return -1;
> >                 }
> >                 level_datum_init(aliasdatum);
> >                 aliasdatum->isalias =3D TRUE;
> > @@ -940,12 +956,14 @@ int define_category(void)
> >         while ((id =3D queue_remove(id_queue))) {
> >                 if (id_has_dot(id)) {
> >                         yyerror("category aliases may not contain perio=
ds");
> > -                       goto bad_alias;
> > +                       free(id);
> > +                       return -1;
> >                 }
> >                 aliasdatum =3D (cat_datum_t *) malloc(sizeof(cat_datum_=
t));
> >                 if (!aliasdatum) {
> >                         yyerror("out of memory");
> > -                       goto bad_alias;
> > +                       free(id);
> > +                       return -1;
> >                 }
> >                 cat_datum_init(aliasdatum);
> >                 aliasdatum->isalias =3D TRUE;
> > @@ -3722,6 +3740,7 @@ uintptr_t define_cexpr(uint32_t expr_type, uintpt=
r_t arg1, uintptr_t arg2)
> >                                 if (!is_id_in_scope(SYM_USERS, id)) {
> >                                         yyerror2("user %s is not within=
 scope",
> >                                                  id);
> > +                                       free(id);
> >                                         constraint_expr_destroy(expr);
> >                                         return 0;
> >                                 }
> > @@ -3733,6 +3752,7 @@ uintptr_t define_cexpr(uint32_t expr_type, uintpt=
r_t arg1, uintptr_t arg2)
> >                                                                     id)=
;
> >                                 if (!user) {
> >                                         yyerror2("unknown user %s", id)=
;
> > +                                       free(id);
> >                                         constraint_expr_destroy(expr);
> >                                         return 0;
> >                                 }
> > @@ -3742,6 +3762,7 @@ uintptr_t define_cexpr(uint32_t expr_type, uintpt=
r_t arg1, uintptr_t arg2)
> >                                         yyerror2("role %s is not within=
 scope",
> >                                                  id);
> >                                         constraint_expr_destroy(expr);
> > +                                       free(id);
> >                                         return 0;
> >                                 }
> >                                 role =3D
> > @@ -3753,6 +3774,7 @@ uintptr_t define_cexpr(uint32_t expr_type, uintpt=
r_t arg1, uintptr_t arg2)
> >                                 if (!role) {
> >                                         yyerror2("unknown role %s", id)=
;
> >                                         constraint_expr_destroy(expr);
> > +                                       free(id);
> >                                         return 0;
> >                                 }
> >                                 val =3D role->s.value;
> > @@ -3765,11 +3787,13 @@ uintptr_t define_cexpr(uint32_t expr_type, uint=
ptr_t arg1, uintptr_t arg2)
> >                         } else {
> >                                 yyerror("invalid constraint expression"=
);
> >                                 constraint_expr_destroy(expr);
> > +                               free(id);
> >                                 return 0;
> >                         }
> >                         if (ebitmap_set_bit(&expr->names, val - 1, TRUE=
)) {
> >                                 yyerror("out of memory");
> >                                 ebitmap_destroy(&expr->names);
> > +                               free(id);
> >                                 constraint_expr_destroy(expr);
> >                                 return 0;
> >                         }
> > --
> > 2.43.0
> >
> >
