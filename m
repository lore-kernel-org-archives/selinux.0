Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F22F6FB1
	for <selinux@vger.kernel.org>; Fri, 14 Jun 2024 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374293; cv=none; b=Qp8mbXIpwLrlRqdAZ7Aw0lucFZRTaXxvdR5VA8yT665I+6SIsu7V9Wd55P2ygTLDLUr6xRBEPSqKjpjzwGfKyM2Ju4KenL7L8D8vbi0KLq321xm4TjMJWi+OUjqHkmnysbx84GwugOGap/xsMiDvQnpgCrAyzmRMr5GxPKWkj0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374293; c=relaxed/simple;
	bh=eG+j9IG1BNGwSQdWPhLgCWsbT015HPkwfGssDubzu9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cuWGKYIEzCWaX7pEGw/Tr+ckFzBS++nkcVTvB+b7zRJcmttYHQG6ztGwsEYB4oYIKACoCF/o3nTUBfGpbBNH25Uz3fUbtOkw4o9/HqHeNivvqLGINI6t7CaCFkAstZ/+KzYb9iotnJmxs96GyeCw5e/CUPpX0tDXk5sKzXkD/mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLEdxwFY; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLEdxwFY"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6f855b2499cso1147213a34.1
        for <selinux@vger.kernel.org>; Fri, 14 Jun 2024 07:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718374290; x=1718979090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dH10oB9Sz1eFkuqyUSeKKAQWdywuowAjTn9aiGKcZww=;
        b=VLEdxwFYwHN6XmTrMFU48L0iT55pozP4Zq61URVyJG5oOUrb0zYrp5G7iic3a1uKYF
         93ihdXA0PfwsbdIaI8t1qzhv+r/IpIaLYuBtU7Fhay3cyXjFJHtntVMG0kZKUvHM/NN1
         w2ZxQ5fik70E62lfazBW3WYx/hyfkr/jr0TIpQYKmrL8mjA6fNP8UoQP57iEM0epX46r
         VPO/4J3u5PCOWfE8iTEEzRwAXgYgUP4LYmHOLRCVaQjN1Bl+zYgXtyO4Rr0x+txPHrx8
         rAmIR/9BCjjFCsJaaP8CEGJP1IEzH87EY5B/N2MPatGdDXq7ByHEz2SQh7zMuiR/lqbL
         IJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718374290; x=1718979090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dH10oB9Sz1eFkuqyUSeKKAQWdywuowAjTn9aiGKcZww=;
        b=WQLs4Wn8zrmwIzSeHpr2apvX27jgUxmc7wcw0ksbzUKCgGO0q2UpKGpMW7LrnrqpuB
         Deh19YOP6a1oWvFsD/zRc/4ns2VoGExmQqECoN/CBVpFcUwb3P/DLtkUD1ucbQ+aKECb
         e/0vKJY98wS4srRhbQX/bHmb8e08T6anTpCpR/7BcD7wa8NFYN8fRliFSJsbFsveSfEF
         B4T3qlwfnd5yXzrwGftP9xFg+tnHUT0SPT8kUoFLALx1BhP1n51bueA3Qi3ZkoIH8oA/
         xR6gE6oBncuoVN5/oJBipEFGBINS8zSV7iAkJttKIr3HAm7jg+tPAgJPjyEQGEed9l7E
         38iQ==
X-Gm-Message-State: AOJu0YxZMJPAdQK89jIQkf8xnM97y0LFT2er0iPsrSNWov/0CJgJqliP
	n1MmTu9UF3DEpiK4fujwrqdFHMAOa/uv/ny+mf6HLGZYKDpTUIwAkq2xUWkMIIa1gmoFmIprwAd
	TzvVXJMvPa7nCRZz+yjE/LMYA9pJCkg==
X-Google-Smtp-Source: AGHT+IHFvwapPL/fIxtFM4yS8bezoJapnZaoad4XEVsu6o5N8mVIQgXakghIo8aP21UT4WxyzzKsKFSaRI80QzcaWCM=
X-Received: by 2002:a05:6808:120a:b0:3d2:1ebd:83e0 with SMTP id
 5614622812f47-3d24e8e14b3mr2742354b6e.21.1718374290224; Fri, 14 Jun 2024
 07:11:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608172142.138894-1-cgoettsche@seltendoof.de> <CAP+JOzRvRn3kTeUKaN6ti921nMwJUJbDu4iW9JR7SnCt9J+wXQ@mail.gmail.com>
In-Reply-To: <CAP+JOzRvRn3kTeUKaN6ti921nMwJUJbDu4iW9JR7SnCt9J+wXQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 14 Jun 2024 10:11:18 -0400
Message-ID: <CAP+JOzSbNf=u3PXbsk4yQ7LzAviu9kEOrn1SRdHTW1d8nB3URA@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol: move unchanged data out of loop
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 2:27=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Sat, Jun 8, 2024 at 1:21=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Perform the lookup whether the class is in the current scope once, and
> > not for every permission.
> > This also ensures the class is checked to be in the current scope if
> > there are no permissions attached.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

These two patches have been merged.
Thanks,
Jim

> > ---
> >  libsepol/src/link.c | 38 ++++++++++++++++++--------------------
> >  1 file changed, 18 insertions(+), 20 deletions(-)
> >
> > diff --git a/libsepol/src/link.c b/libsepol/src/link.c
> > index b8272308..a6f2a251 100644
> > --- a/libsepol/src/link.c
> > +++ b/libsepol/src/link.c
> > @@ -1925,7 +1925,7 @@ static int find_perm(hashtab_key_t key, hashtab_d=
atum_t datum, void *varg)
> >   * Note that if a declaration had no requirement at all (e.g., an ELSE
> >   * block) this returns 1. */
> >  static int is_decl_requires_met(link_state_t * state,
> > -                               avrule_decl_t * decl,
> > +                               const avrule_decl_t * decl,
> >                                 struct missing_requirement *req)
> >  {
> >         /* (This algorithm is very unoptimized.  It performs many
> > @@ -1933,9 +1933,9 @@ static int is_decl_requires_met(link_state_t * st=
ate,
> >          * which symbols have been verified, so that they do not need
> >          * to be re-checked.) */
> >         unsigned int i, j;
> > -       ebitmap_t *bitmap;
> > -       char *id, *perm_id;
> > -       policydb_t *pol =3D state->base;
> > +       const ebitmap_t *bitmap;
> > +       const char *id, *perm_id;
> > +       const policydb_t *pol =3D state->base;
> >         ebitmap_node_t *node;
> >
> >         /* check that all symbols have been satisfied */
> > @@ -1961,27 +1961,25 @@ static int is_decl_requires_met(link_state_t * =
state,
> >         }
> >         /* check that all classes and permissions have been satisfied *=
/
> >         for (i =3D 0; i < decl->required.class_perms_len; i++) {
> > +               const class_datum_t *cladatum =3D pol->class_val_to_str=
uct[i];
> > +               const scope_datum_t *scope;
> > +
> > +               bitmap =3D &decl->required.class_perms_map[i];
> > +               id =3D pol->p_class_val_to_name[i];
> > +
> > +
> > +               scope =3D hashtab_search(state->base->p_classes_scope.t=
able, id);
> > +               if (scope =3D=3D NULL) {
> > +                       ERR(state->handle,
> > +                               "Could not find scope information for c=
lass %s",
> > +                               id);
> > +                       return -1;
> > +               }
> >
> > -               bitmap =3D decl->required.class_perms_map + i;
> >                 ebitmap_for_each_positive_bit(bitmap, node, j) {
> >                         struct find_perm_arg fparg;
> > -                       class_datum_t *cladatum;
> >                         uint32_t perm_value =3D j + 1;
> >                         int rc;
> > -                       scope_datum_t *scope;
> > -
> > -                       id =3D pol->p_class_val_to_name[i];
> > -                       cladatum =3D pol->class_val_to_struct[i];
> > -
> > -                       scope =3D
> > -                           hashtab_search(state->base->p_classes_scope=
.table,
> > -                                          id);
> > -                       if (scope =3D=3D NULL) {
> > -                               ERR(state->handle,
> > -                                   "Could not find scope information f=
or class %s",
> > -                                   id);
> > -                               return -1;
> > -                       }
> >
> >                         fparg.valuep =3D perm_value;
> >                         fparg.key =3D NULL;
> > --
> > 2.45.1
> >
> >
