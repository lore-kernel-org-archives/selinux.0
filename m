Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA23179A7
	for <selinux@vger.kernel.org>; Mon,  7 Apr 2025 18:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049269; cv=none; b=a1f4EB+fa5csvi2BSFpTt6vNhNDFJHm/u20kryMvcuEIylZ2ag3h9Xxnm3zDcHSbXKyrvz/RdgLP9xsb30GNHJXTGPTTYfoAsZ19tJekd5oJ3wVrzYPkDRUkr4MS+SKGjZ+cECf/VrRNFX6M71GFlCv9LYea9GW7vUtW+rHB1hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049269; c=relaxed/simple;
	bh=vGGJ0b1/7hv84frmhCrKxG+K+HIGpGYBg8Wh6q/AKZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sCKEJ4MjqQI6gF0tslMYPzrnzPYrMEXKupoP1T0K2eoVf3v4/PSH+VGIpMPKCF3NjMHhjIqnpe+voAdH0isd8I551t/Y6O59TMKQkRVVT9LjdSq75ommNe/f2OelVZRwP6aUdYOMYhZFoGr7Aj/a4CBYB9UaE6uMawXIJ4nm+ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IX/qaMNh; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IX/qaMNh"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c58974ed57so492780185a.2
        for <selinux@vger.kernel.org>; Mon, 07 Apr 2025 11:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744049267; x=1744654067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DHeVfTfmJlG/gbsXkohE83oRZKcjyrlDFLKAUJx8Sk=;
        b=IX/qaMNhXLmVWiW1Lf+0A4LsCpnvJZf7PS6TkBx+AbNkwHEm51qM6+Oe6xplnH3T1O
         8r0T21FWQxcogs8rM/pGW0+rrQaF0Gc4lt4iKvhLlb73EM+mmZolda8KOEh+oa2rH5be
         N3hR4TSwKrdiQfox0Dbl6FU9ptaUzdsy3119lKRBii0GpXugiUIpgB9kjjCnPZSBIugg
         5AAFRVByltJgifaxs8ljQTy2pRw7wdEu5SCh8YiYqSxpOwVnxPYRkw5d0HoqyguC41w8
         AZ+mhEaaJl0NA6ITvJHJxeYBUJKf/p+6hp3YPlALmtB74PNLD8d8utlo26gTXzo40rF0
         0M5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744049267; x=1744654067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DHeVfTfmJlG/gbsXkohE83oRZKcjyrlDFLKAUJx8Sk=;
        b=akD+lS9E1xMyr/KUncwqYTql7Yn2mPomY6IvRoxNrAkvX4+h3+NysxS4Iog86ucF4A
         e6685KJhucuxZMHn9zO7kpkq/TdiVlKlwqViJQBsqbECF/Sibe+3liLI4pVWZgcBvZvO
         NiXTmKakbL5XYTQJLzfoyRCJJBTbqDk6ignAZgLIK9PIy9DSsKONd8y07ZWGsqcyOGro
         ZcVPQb46mR9e++8TtMa2VbjIlCq+n+FCCdjgG2494Lp5MDbSwFMXj4+UWjtEGLcQWhXS
         Xu8y34PxgWgVwde1ByEsX9fYeiySMpbBLJeJgtn/EAV5Xz8K8ELXEkUMkt2PydwlewwU
         2LMA==
X-Gm-Message-State: AOJu0Yz00ZZn6wAtUlzEbTZFZ8vf/v6JskLijqXbqp0/toMzfKbpdhkz
	me0ZdrpAIdlm1FNHcvkW8IarVlwBgBS0guyuuW7z87dvV8drYmDeX2dx3RxRuUu8KMkPLHwLHcV
	UI9oafvNKsdsWboORzJZ4b+rrNdQ=
X-Gm-Gg: ASbGncvWdD2e/L01SExkW0gGY49jknVkWZA6+iRbXnRNmzGfSAKG18nQNQ1TC+ZPBy3
	dGjxNe4kK5lQySbS0XwAHjL6Ny1VQTsoDp7KKxLjFBXq3K6OBHZkFHSW8CTe+Z9YuOioTBRvVin
	dH1aVDjH7Ku/4va0D8ZZQYOWs=
X-Google-Smtp-Source: AGHT+IFOC+UlRGORPT3U3g9rtDJWX138PGCbaknIN7zSxpwusyTdrB4BPCRCSHv1Ihk+Gf+Q3usac/iXBg9w8FdokQQ=
X-Received: by 2002:a05:620a:4486:b0:7c5:5585:6c8b with SMTP id
 af79cd13be357-7c774e4ae71mr1755773185a.50.1744049266875; Mon, 07 Apr 2025
 11:07:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222172631.18683-1-cgoettsche@seltendoof.de> <CAP+JOzQtx53dN7TNjpWddEQL-tUrjapOJ1Ex6j1HHfYbcPVQdA@mail.gmail.com>
In-Reply-To: <CAP+JOzQtx53dN7TNjpWddEQL-tUrjapOJ1Ex6j1HHfYbcPVQdA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 7 Apr 2025 14:07:35 -0400
X-Gm-Features: ATxdqUH6qxrgJW3i3Cx8E0AO_cqhBzddpDW2o7yMH1uAmaf9e_m7w_mZdvPWz94
Message-ID: <CAP+JOzRe+M2FDzQXD66tuQ=fF5D4snk97vHQr6NHXrYvaNGkdA@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: rework cleanup in define_te_avtab_xperms_helper()
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 12:40=E2=80=AFPM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Sat, Feb 22, 2025 at 12:34=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Clean up the local avrule on error, since its ownership is not
> > transferred. Also clean up the local ebitmap on error.
> >
> > Reported-by: oss-fuzz (issue 398356438)
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  checkpolicy/policy_define.c | 29 ++++++++++++++---------------
> >  1 file changed, 14 insertions(+), 15 deletions(-)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index f19e9f6d..06068556 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -1610,7 +1610,8 @@ struct val_to_name {
> >
> >  /* Adds a type, given by its textual name, to a typeset.  If *add is
> >     0, then add the type to the negative set; otherwise if *add is 1
> > -   then add it to the positive side. */
> > +   then add it to the positive side.
> > +   The identifier `id` is always consumed. */
> >  static int set_types(type_set_t * set, char *id, int *add, char staral=
lowed)
> >  {
> >         type_datum_t *t;
> > @@ -2117,18 +2118,17 @@ static int define_te_avtab_xperms_helper(int wh=
ich, avrule_t ** rule)
> >  {
> >         char *id;
> >         class_perm_node_t *perms, *tail =3D NULL, *cur_perms =3D NULL;
> > -       class_datum_t *cladatum;
> > -       perm_datum_t *perdatum =3D NULL;
> > +       const class_datum_t *cladatum;
> > +       const perm_datum_t *perdatum;
> >         ebitmap_t tclasses;
> >         ebitmap_node_t *node;
> >         avrule_t *avrule;
> >         unsigned int i;
> > -       int add =3D 1, ret =3D 0;
> > +       int add =3D 1, ret;
> >
> >         avrule =3D (avrule_t *) malloc(sizeof(avrule_t));
> >         if (!avrule) {
> >                 yyerror("out of memory");
> > -               ret =3D -1;
> >                 goto out;
> >         }
> >         avrule_init(avrule);
> > @@ -2139,14 +2139,13 @@ static int define_te_avtab_xperms_helper(int wh=
ich, avrule_t ** rule)
> >         avrule->xperms =3D NULL;
> >         if (!avrule->source_filename) {
> >                 yyerror("out of memory");
> > -               return -1;
> > +               goto out;
> >         }
> >
> >         while ((id =3D queue_remove(id_queue))) {
> >                 if (set_types
> >                     (&avrule->stypes, id, &add,
> >                      which =3D=3D AVRULE_XPERMS_NEVERALLOW ? 1 : 0)) {
> > -                       ret =3D -1;
> >                         goto out;
> >                 }
> >         }
> > @@ -2156,13 +2155,11 @@ static int define_te_avtab_xperms_helper(int wh=
ich, avrule_t ** rule)
> >                         free(id);
> >                         if (add =3D=3D 0 && which !=3D AVRULE_XPERMS_NE=
VERALLOW) {
> >                                 yyerror("-self is only supported in nev=
erallow and neverallowxperm rules");
> > -                               ret =3D -1;
> >                                 goto out;
> >                         }
> >                         avrule->flags |=3D (add ? RULE_SELF : RULE_NOTS=
ELF);
> >                         if ((avrule->flags & RULE_SELF) && (avrule->fla=
gs & RULE_NOTSELF)) {
> >                                 yyerror("self and -self are mutual excl=
usive");
> > -                               ret =3D -1;
> >                                 goto out;
> >                         }
> >                         continue;
> > @@ -2170,7 +2167,6 @@ static int define_te_avtab_xperms_helper(int whic=
h, avrule_t ** rule)
> >                 if (set_types
> >                     (&avrule->ttypes, id, &add,
> >                      which =3D=3D AVRULE_XPERMS_NEVERALLOW ? 1 : 0)) {
> > -                       ret =3D -1;
> >                         goto out;
> >                 }
> >         }
> > @@ -2178,7 +2174,6 @@ static int define_te_avtab_xperms_helper(int whic=
h, avrule_t ** rule)
> >         if ((avrule->ttypes.flags & TYPE_COMP)) {
> >                 if (avrule->flags & RULE_NOTSELF) {
> >                         yyerror("-self is not supported in complements"=
);
> > -                       ret =3D -1;
> >                         goto out;
> >                 }
> >                 if (avrule->flags & RULE_SELF) {
> > @@ -2190,7 +2185,7 @@ static int define_te_avtab_xperms_helper(int whic=
h, avrule_t ** rule)
> >         ebitmap_init(&tclasses);
> >         ret =3D read_classes(&tclasses);
> >         if (ret)
> > -               goto out;
> > +               goto out2;
> >
> >         perms =3D NULL;
> >         id =3D queue_head(id_queue);
> > @@ -2199,8 +2194,7 @@ static int define_te_avtab_xperms_helper(int whic=
h, avrule_t ** rule)
> >                     (class_perm_node_t *) malloc(sizeof(class_perm_node=
_t));
> >                 if (!cur_perms) {
> >                         yyerror("out of memory");
> > -                       ret =3D -1;
> > -                       goto out;
> > +                       goto out2;
> >                 }
> >                 class_perm_node_init(cur_perms);
> >                 cur_perms->tclass =3D i + 1;
> > @@ -2238,9 +2232,14 @@ static int define_te_avtab_xperms_helper(int whi=
ch, avrule_t ** rule)
> >
> >         avrule->perms =3D perms;
> >         *rule =3D avrule;
> > +       return 0;
> >
> > +out2:
> > +       ebitmap_destroy(&tclasses);
> >  out:
> > -       return ret;
> > +       avrule_destroy(avrule);
> > +       free(avrule);
> > +       return -1;
> >  }
> >
> >  /* index of the u32 containing the permission */
> > --
> > 2.47.2
> >
> >
