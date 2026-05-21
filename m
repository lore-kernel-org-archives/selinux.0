Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879A73D9670
	for <selinux@vger.kernel.org>; Thu, 21 May 2026 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373396; cv=pass; b=ExrLfgIS6aWgxWENjslloH80SYnAfaTKTlqywdP8oaxA2rQXww/CIR7sQdbJ2sqNPjBUkY/dDfWyHLbib9QhtyT0x0eqKbacCIBsBp81ydIAvUX0Xy0v93rEzC1q/EkAyn3peL1eneKQRiyEHwOk26/5nK8NGsDbctJv9Lt7mho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373396; c=relaxed/simple;
	bh=KleIZONAwhJB7kJjG3aUImbi5tSm4ZXX3y+3y7bVa+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KcZfAOE6XPAoTR4p84Qe4LES04W4XMOn8GOfcMY7QKzuGWX9ApXv3R9Qz62lmsqIRvSvDxfveMf21e9fGmFobDwmOUB9+cpKo05q3oNu47cQKIflkG/SSFbeUiWz0OMekpwYK4bryu+qjkazgOrh60Os/iOruy2/jfPn748rWoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6xozO3X; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6xozO3X"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39393c1b5aaso8044771fa.3
        for <selinux@vger.kernel.org>; Thu, 21 May 2026 07:23:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779373393; cv=none;
        d=google.com; s=arc-20240605;
        b=gB9tJQ2QNuf2cEokgDEIeOwzVbrfHPia0WjOfhXe8zjAv6LHkcsNYUTpGt+QUqBw7m
         6qJqFKK3TxBQLFen89vFYjJ4HPv799jlI45q6VPmZ9X+c9Pz6dpNajm+oJWaD/TGrsMB
         q0zQF5P7F2eFSgdKkgCpWXleMln6WdHfoyhM4Jy7aIs4UF1cfLdpbGxtlpn8nO90/+w3
         2ZUuCHho5Z4WkWVbzPit4ykECyGBck6i62bCWwKh6xcOxN27WOUIVte1EnHwKym4sqyZ
         OtDLmlrC5HckUowJ+JGu8XJxNm7YfWpzAc782ae81g3+SYPKkJvh4HymKS79ZAxFYmYk
         hcVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UA7pmyNcKexJSHBA/F+oyIt47uwC5Q6vJKb0Pvaw3cQ=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=km1rgrdHQqJp/k3X3xYe+SYtOk5rZ6PelPxLKTFKlJp9o4Dh2/dEvllxQBcf3G9qZV
         jwSGiwlnnOD+0BkD7VWh9Xk2j2+mDySgVlBNTBlARiS48s95cXfGz0fw8av8XJuwfeXq
         YBukS8b53SlE/h9AxuVJTkoF4vuz5JDSDtmBMsht9gzQq4q1myIJHfqZhd0aYWq07lu2
         W1T8kGieGg5tAAkYu2EW5zKEU6p/A4hQNuWe1JHLjuhGDKdhwhWAi5icYQTieLG1oZ5z
         CBEWWRtANScx4trLsLY6CS/DuP/wq55PYwp+qwRqHAAVXSLfZzlIrlXlRdZMLQFq7deu
         ih0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779373393; x=1779978193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UA7pmyNcKexJSHBA/F+oyIt47uwC5Q6vJKb0Pvaw3cQ=;
        b=C6xozO3XYjBIoeTkrt4mKpyjUcX7dNt7re+7gIyQvQOvOetlo3y1JhfCRMQDBLQsrz
         Wqmqj1k2bPOhjCc22ljhI3ekhOOp0BzQkGLMEsC0nEydYnIL6qPeU1xczbitJ7CmTCcW
         d76P3i8XODoOssqbIzmySpdFnERgYVEPRz0JN4wGpyaknseYj3QbAQa4WEMJc799uD3/
         Tryosaekuk6hYNHR7E5JU9QeU6JxdB+xVcwgh1zr8nhPJyl2kWlowugVHTLXuhMTbONZ
         vyK3j0UBNr7BY0D9Us3v40oLNSuPm4DN/433btgRn9i00IRhChvS4mc0qXuhEPdkbX9h
         RiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779373393; x=1779978193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UA7pmyNcKexJSHBA/F+oyIt47uwC5Q6vJKb0Pvaw3cQ=;
        b=VO+rC/+fVTjwOP36/EeKLs8E2CCIyP6qUofBa/XFEfnqNfFfW5T0d1IAzPnp7tvyNV
         JJpsCydZjR0wvq305sIoovnfUrXuCbalnodH8KDCb+odwTuISLTAV1I+n86R6gkGOhzO
         AKS3NpRUA9KMKH9eCBoohtWvBQHJBZFPfvH77pLPPxCHXrcGYQJldL/OKPoRONv5EhI3
         8ErU1IBMQSGAb7TvDJeHUwl85mHkVrcsJOmq1GrllnCTARmjrbv9LPUkG2wHwM5JFiGF
         yCx8/afPiql/VJK4ZlF0ipULolIAC4LUn9ILhzmvIuMySNlvUSe9EzXuuCmk0VPLcMrI
         zuZQ==
X-Gm-Message-State: AOJu0YzthD6tS4e+8chMyZ6Su7SSbtAo5jCs12vmXDCw4phmXJGhtrVE
	critlmaPj7PWiZ+zL7irmr0NXdZ/lOhPknC8NnTBc23D8rZcnEEBigs/zEJL0ORTJcQdSYeDxhi
	gfhiFuOr1ubFgZA6FDqxEoqmeiBsBipA=
X-Gm-Gg: Acq92OFbrle0H0Nk9y4aDTDvsEY4hblZAhzFv1WTmwgfO2Zi0ZT1ePr1pKE6W9a9tBw
	++po9KKhNaW06jzsGKn5nkbw9koFxZuhHWPD1O4PHXjkl6OcvXuOUoFaN/uP67oL2RDbS5vW1Xg
	bD7d6RBzs9/AYobmUwZEZp1kqxUD+ahtBk/ndZOwK00EP/5Nt0oP0dOXM02cB2RhFGLrdJl3Bgl
	Md86BGZpXns05/3z/cMlgSRB7DDjh0e9nag26aS/4H85JSJHyioT8cWLR+Svg6wNDPxv5hFG3kU
	ksNCMnqKxjKE3e4=
X-Received: by 2002:a2e:9844:0:b0:38e:9667:f21a with SMTP id
 38308e7fff4ca-395ca5f21f7mr8395321fa.20.1779373392284; Thu, 21 May 2026
 07:23:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508121327.91410-1-kalevi@kolttonen.fi> <20260508121327.91410-5-kalevi@kolttonen.fi>
 <CAP+JOzR8fLePvbCuG4Rg3qcRwpeJH9HkfLVksN77_M+qNGKpVw@mail.gmail.com>
In-Reply-To: <CAP+JOzR8fLePvbCuG4Rg3qcRwpeJH9HkfLVksN77_M+qNGKpVw@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 21 May 2026 10:23:00 -0400
X-Gm-Features: AVHnY4Igaso2U2v8m8lwqHrgdEWfmgfzG71eCswweon5eKreOGgJhRrmOs6leS0
Message-ID: <CAP+JOzSGOcHpWVcCAY6hmewtGOkZDmUTn7OZMRwnm4pr90AY9g@mail.gmail.com>
Subject: Re: [PATCH 4/4] checkpolicy: remove unneeded malloc() casts
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 11:34=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Fri, May 8, 2026 at 8:18=E2=80=AFAM Kalevi Kolttonen <kalevi@kolttonen=
.fi> wrote:
> >
> > Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  checkpolicy/policy_define.c | 28 +++++++++++++---------------
> >  1 file changed, 13 insertions(+), 15 deletions(-)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index 755a8428..0a553a1f 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -786,7 +786,7 @@ int define_sens(void)
> >                 yyerror2("sensitivity identifier %s may not contain per=
iods", id);
> >                 goto bad;
> >         }
> > -       level =3D (mls_level_t *) malloc(sizeof(mls_level_t));
> > +       level =3D malloc(sizeof(mls_level_t));
> >         if (!level) {
> >                 yyerror("out of memory");
> >                 goto bad;
> > @@ -795,7 +795,7 @@ int define_sens(void)
> >         level->sens =3D 0;        /* actual value set in define_dominan=
ce */
> >         ebitmap_init(&level->cat);      /* actual value set in define_l=
evel */
> >
> > -       datum =3D (level_datum_t *) malloc(sizeof(level_datum_t));
> > +       datum =3D malloc(sizeof(level_datum_t));
> >         if (!datum) {
> >                 yyerror("out of memory");
> >                 goto bad;
> > @@ -839,7 +839,7 @@ int define_sens(void)
> >                         free(id);
> >                         return -1;
> >                 }
> > -               aliasdatum =3D (level_datum_t *) malloc(sizeof(level_da=
tum_t));
> > +               aliasdatum =3D malloc(sizeof(level_datum_t));
> >                 if (!aliasdatum) {
> >                         yyerror("out of memory");
> >                         free(id);
> > @@ -976,7 +976,7 @@ int define_category(void)
> >                 yyerror2("category identifier %s may not contain period=
s", id);
> >                 goto bad;
> >         }
> > -       datum =3D (cat_datum_t *) malloc(sizeof(cat_datum_t));
> > +       datum =3D malloc(sizeof(cat_datum_t));
> >         if (!datum) {
> >                 yyerror("out of memory");
> >                 goto bad;
> > @@ -1019,7 +1019,7 @@ int define_category(void)
> >                         free(id);
> >                         return -1;
> >                 }
> > -               aliasdatum =3D (cat_datum_t *) malloc(sizeof(cat_datum_=
t));
> > +               aliasdatum =3D malloc(sizeof(cat_datum_t));
> >                 if (!aliasdatum) {
> >                         yyerror("out of memory");
> >                         free(id);
> > @@ -1091,7 +1091,7 @@ static int clone_level(hashtab_key_t key __attrib=
ute__ ((unused)), hashtab_datum
> >                         levdatum->notdefined =3D FALSE;
> >                         return 0;
> >                 }
> > -               newlevel =3D (mls_level_t *) malloc(sizeof(mls_level_t)=
);
> > +               newlevel =3D malloc(sizeof(mls_level_t));
> >                 if (!newlevel)
> >                         return -1;
> >                 if (mls_level_cpy(newlevel, level)) {
> > @@ -2167,7 +2167,7 @@ static int define_te_avtab_xperms_helper(int whic=
h, avrule_t ** rule)
> >         unsigned int i;
> >         int add =3D 1, ret;
> >
> > -       avrule =3D (avrule_t *) malloc(sizeof(avrule_t));
> > +       avrule =3D malloc(sizeof(avrule_t));
> >         if (!avrule) {
> >                 yyerror("out of memory");
> >                 goto out;
> > @@ -2231,8 +2231,7 @@ static int define_te_avtab_xperms_helper(int whic=
h, avrule_t ** rule)
> >         perms =3D NULL;
> >         id =3D queue_head(id_queue);
> >         ebitmap_for_each_positive_bit(&tclasses, node, i) {
> > -               cur_perms =3D
> > -                   (class_perm_node_t *) malloc(sizeof(class_perm_node=
_t));
> > +               cur_perms =3D malloc(sizeof(class_perm_node_t));
> >                 if (!cur_perms) {
> >                         yyerror("out of memory");
> >                         goto out2;
> > @@ -2779,7 +2778,7 @@ static int define_te_avtab_helper(int which, avru=
le_t ** rule)
> >
> >         ebitmap_init(&tclasses);
> >
> > -       avrule =3D (avrule_t *) malloc(sizeof(avrule_t));
> > +       avrule =3D malloc(sizeof(avrule_t));
> >         if (!avrule) {
> >                 yyerror("memory error");
> >                 ret =3D -1;
> > @@ -2848,8 +2847,7 @@ static int define_te_avtab_helper(int which, avru=
le_t ** rule)
> >
> >         perms =3D NULL;
> >         ebitmap_for_each_positive_bit(&tclasses, node, i) {
> > -               cur_perms =3D
> > -                   (class_perm_node_t *) malloc(sizeof(class_perm_node=
_t));
> > +               cur_perms =3D malloc(sizeof(class_perm_node_t));
> >                 if (!cur_perms) {
> >                         yyerror("out of memory");
> >                         ret =3D -1;
> > @@ -4390,7 +4388,7 @@ static int mls_semantic_cats_merge(mls_semantic_c=
at_t ** dst,
> >         mls_semantic_cat_t *new;
> >
> >         while (src) {
> > -               new =3D (mls_semantic_cat_t *) malloc(sizeof(mls_semant=
ic_cat_t));
> > +               new =3D malloc(sizeof(mls_semantic_cat_t));
> >                 if (!new)
> >                         return -1;
> >
> > @@ -4467,7 +4465,7 @@ static int parse_semantic_categories(char *id, le=
vel_datum_t * levdatum __attrib
> >                 range_start =3D range_end =3D cdatum->s.value;
> >         }
> >
> > -       newcat =3D (mls_semantic_cat_t *) malloc(sizeof(mls_semantic_ca=
t_t));
> > +       newcat =3D malloc(sizeof(mls_semantic_cat_t));
> >         if (!newcat) {
> >                 yyerror("out of memory");
> >                 return -1;
> > @@ -4859,7 +4857,7 @@ int define_fs_context(unsigned int major, unsigne=
d int minor)
> >                 return -1;
> >         }
> >
> > -       newc->u.name =3D (char *)malloc(6);
> > +       newc->u.name =3D malloc(6);
> >         if (!newc->u.name) {
> >                 yyerror("out of memory");
> >                 free(newc);
> > --
> > 2.54.0
> >
> >
