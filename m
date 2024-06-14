Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CC719D896
	for <selinux@vger.kernel.org>; Fri, 14 Jun 2024 14:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374452; cv=none; b=fGih+fGkwXsBXBL7Foer4xiem5epH1L2tWkSTkcDjbS7cpLJHq9rhvMvlKV1p8WyKt4goACd8GgQXuga1imIMIsvMuHyf1ZfNgAQPW9FKbs9tB10cJsLb7YWoDFsJYECcv7yB9emXtCpCPWZiPRRIFyMSlPfQjPg8uKM2PTuGHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374452; c=relaxed/simple;
	bh=DGIf45Iv41E+YMrXPTCvdijn5Xs+J98BnKWhJRaoBoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RfUo+rA7YSdu6GKVK1A0HyZv4Fz6gOv4YG+6vaiu+qUq2LCzNTwEAU+mp9yvFNo5XSa2EBfSkGMJgmy8I0q6N4xXB0KzooN7hWMag/7Skdvsf38J1gCZgybLImQUvKm0dOIpTx+1kY2pcHeu2osjo+47rNACRtVwaM3K9EG5ENk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWmVrkhQ; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWmVrkhQ"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-48c384ed600so1270419137.0
        for <selinux@vger.kernel.org>; Fri, 14 Jun 2024 07:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718374449; x=1718979249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bi4nOKXbJieZN2dF2FKoo2bo7gzjzMPAkkkOhWzMaGI=;
        b=JWmVrkhQSb9J34N8sAM7qgRRvg0xJFk4oRJ/Pgr6g/zVfd2yqcwkHCr8zkxUiTzr1v
         iPrDgruYWoyL44H1RU+AYw9C0mKTBF0RqEc3jo2PyxW4A+E+u56TYKlPGEVH6s8OafnG
         /mRUsziyiBqXu9cF1xcDPADC18Sg5/bqGuKvNtr2NIydIiLa6ZdtxyYib0YS1OWAvvSx
         of2v8VLwR7MIZHjzYAGvJo2KFByWHWdNfv0/gbM3gnLBvtAMxU1MpxxIYPy3+V7M+py8
         fHhuURcY5aZOBe356GuRX0mBR0r1XdKDNvHmCryCcB7Md9YCtxkzTJZ7iK/O6ECkDjVa
         +mXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718374449; x=1718979249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bi4nOKXbJieZN2dF2FKoo2bo7gzjzMPAkkkOhWzMaGI=;
        b=iXMYSfZUCcjK88wshKUMBAOBxlGEap2YaVcQ0l9R4eJIalfWPF749jGJoJEeGJQsgf
         9TVVewvbxGJpXba/x3hSsMbw12EuQQEwAZ4f0+XrqjUnhtEWXEcIOfOFnSA8BVQwOUen
         OeBIrfleMbwl1kTzev+uwIfnflv5r/rl/uQzE9leeX9gH3+v5uhMefLxP9mNxXfQzVri
         MDYsJxN9csMto2HK+HieR8+KNvguhMkZGs/OJCtmJYiVrIglno8OVwZD3TxkJ82mcQ0h
         k356L1SPl1bh10nYfA+kznr505z9+Pkt7S8SVlSQMIswQup4iOs9Go47Kbdl+KTkpW7r
         6PSw==
X-Gm-Message-State: AOJu0Yym7V9PMzG8W9QeNNCfDxbxlz3wppjI0EVn8FTSJqcZc5J/dstn
	1Qts1spGZNHnF53usIt5/f7LLy8Z6EDb7M8ZymJYb4DV3tkxDiRA3LDS7qb9VkS7T2+EMTUDULW
	uDn3wYGYjlx+BsrBG2D4pZvbhQQc=
X-Google-Smtp-Source: AGHT+IEpvK4/1nc/JgCB3UxahcRyDIAu022dvo7FEPZrc/1ROPTDN/r8gNWSsdZqWZFTQt6F4Xoy71fqCLntGFfMttQ=
X-Received: by 2002:a67:e352:0:b0:48d:a4aa:35f9 with SMTP id
 ada2fe7eead31-48da4aa3639mr4722012137.4.1718374449174; Fri, 14 Jun 2024
 07:14:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608171739.135501-1-cgoettsche@seltendoof.de> <CAP+JOzRhMS5WWgsBXnOVYKAe92EQDf64FjkqL_GZhp7RztGLMA@mail.gmail.com>
In-Reply-To: <CAP+JOzRhMS5WWgsBXnOVYKAe92EQDf64FjkqL_GZhp7RztGLMA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 14 Jun 2024 10:13:58 -0400
Message-ID: <CAP+JOzRB9BTyPwdmRx0ndDddvoDhAKgKfv=Hw=eK=A3vjCZ3tA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: contify function pointer arrays
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 2:41=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Sat, Jun 8, 2024 at 1:27=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > These function pointers are never modified.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsepol/src/link.c          | 4 ++--
> >  libsepol/src/module_to_cil.c | 8 ++++----
> >  libsepol/src/write.c         | 2 +-
> >  3 files changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/libsepol/src/link.c b/libsepol/src/link.c
> > index b8272308..048d742e 100644
> > --- a/libsepol/src/link.c
> > +++ b/libsepol/src/link.c
> > @@ -749,7 +749,7 @@ static int cat_copy_callback(hashtab_key_t key, has=
htab_datum_t datum,
> >         return 0;
> >  }
> >
> > -static int (*copy_callback_f[SYM_NUM]) (hashtab_key_t key,
> > +static int (*const copy_callback_f[SYM_NUM]) (hashtab_key_t key,
> >                                         hashtab_datum_t datum, void *da=
tap) =3D {
> >  NULL, class_copy_callback, role_copy_callback, type_copy_callback,
> >             user_copy_callback, bool_copy_callback, sens_copy_callback,
> > @@ -1215,7 +1215,7 @@ static int user_fix_callback(hashtab_key_t key, h=
ashtab_datum_t datum,
> >         return -1;
> >  }
> >
> > -static int (*fix_callback_f[SYM_NUM]) (hashtab_key_t key, hashtab_datu=
m_t datum,
> > +static int (*const fix_callback_f[SYM_NUM]) (hashtab_key_t key, hashta=
b_datum_t datum,
> >                                        void *datap) =3D {
> >  NULL, NULL, role_fix_callback, type_fix_callback, user_fix_callback,
> >             NULL, NULL, NULL};
> > diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.=
c
> > index 3b3480bf..2dbf137e 100644
> > --- a/libsepol/src/module_to_cil.c
> > +++ b/libsepol/src/module_to_cil.c
> > @@ -2951,8 +2951,8 @@ static int ocontexts_to_cil(struct policydb *pdb)
> >         int rc =3D -1;
> >         int ocon;
> >
> > -       static int (**ocon_funcs)(struct policydb *pdb, struct ocontext=
 *ocon);
> > -       static int (*ocon_selinux_funcs[OCON_NUM])(struct policydb *pdb=
, struct ocontext *ocon) =3D {
> > +       static int (*const *ocon_funcs)(struct policydb *pdb, struct oc=
ontext *ocon);
> > +       static int (*const ocon_selinux_funcs[OCON_NUM])(struct policyd=
b *pdb, struct ocontext *ocon) =3D {
> >                 ocontext_selinux_isid_to_cil,
> >                 ocontext_selinux_fs_to_cil,
> >                 ocontext_selinux_port_to_cil,
> > @@ -2963,7 +2963,7 @@ static int ocontexts_to_cil(struct policydb *pdb)
> >                 ocontext_selinux_ibpkey_to_cil,
> >                 ocontext_selinux_ibendport_to_cil,
> >         };
> > -       static int (*ocon_xen_funcs[OCON_NUM])(struct policydb *pdb, st=
ruct ocontext *ocon) =3D {
> > +       static int (*const ocon_xen_funcs[OCON_NUM])(struct policydb *p=
db, struct ocontext *ocon) =3D {
> >                 ocontext_xen_isid_to_cil,
> >                 ocontext_xen_pirq_to_cil,
> >                 ocontext_xen_ioport_to_cil,
> > @@ -3404,7 +3404,7 @@ exit:
> >  }
> >
> >
> > -static int (*func_to_cil[SYM_NUM])(int indent, struct policydb *pdb, s=
truct avrule_block *block, struct stack *decl_stack, char *key, void *datum=
, int scope) =3D {
> > +static int (*const func_to_cil[SYM_NUM])(int indent, struct policydb *=
pdb, struct avrule_block *block, struct stack *decl_stack, char *key, void =
*datum, int scope) =3D {
> >         NULL,   // commons, only stored in the global symtab, handled e=
lsewhere
> >         class_to_cil,
> >         role_to_cil,
> > diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> > index f8cd9e1d..a52e2e82 100644
> > --- a/libsepol/src/write.c
> > +++ b/libsepol/src/write.c
> > @@ -1344,7 +1344,7 @@ static int user_write(hashtab_key_t key, hashtab_=
datum_t datum, void *ptr)
> >         return POLICYDB_SUCCESS;
> >  }
> >
> > -static int (*write_f[SYM_NUM]) (hashtab_key_t key, hashtab_datum_t dat=
um,
> > +static int (*const write_f[SYM_NUM]) (hashtab_key_t key, hashtab_datum=
_t datum,
> >                                 void *datap) =3D {
> >  common_write, class_write, role_write, type_write, user_write,
> >             cond_write_bool, sens_write, cat_write,};
> > --
> > 2.45.1
> >
> >
