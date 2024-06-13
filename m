Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA34137905
	for <selinux@vger.kernel.org>; Thu, 13 Jun 2024 20:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718309736; cv=none; b=fTnWonAdJKH72kZPbSB0JLcFArmw/hdWHI/nfERzkV3FwQu/kkpI6z9Ub4CSOJcMo14bek34TM3gfNwIOwQbs0Uu7mZj0MEO+3zBvNfb8ptx+egLKx4cjL1EAmzbHH5S5K3vKk7Rvn9u8zfYFNP1EpnF02UAhDgRqdgcNrwec5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718309736; c=relaxed/simple;
	bh=jYfYTYd3C5dhqpLoXA7Wrc0g3Q9ZLrsC/2KD2ftMpLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bxbERW2epTOb4aoRaGHhiQWkkfuZ7XHxYcOkifa+DnYPy2iTOaR1DGvhzecTz2F1d4Wwld6FvTDQjavsUDe2vsUDPG3IOqheFvkaUHDPNnqsoZQuFhwePqOm2m/WHupSDerky+buw6HFasP2etwcVVDbXkwN/llzszLGy6G5T2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPa4GOkS; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPa4GOkS"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-80b8689775fso480328241.1
        for <selinux@vger.kernel.org>; Thu, 13 Jun 2024 13:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718309734; x=1718914534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjra96zS1d6tvSE0tCUqIZdFfTJEDqEFxGXXpHb6X+E=;
        b=KPa4GOkS84ir6oPgxMr3/WS5T9NJw5R7l5FCDMqTSXVnq83ij8cS+/DwczOxPEyxaq
         btiC23LF/CI84gWvW1zmlV+I4TbwLc6eKzCFcrwq7f3S+MbPvjtDjoNWZF/Loh66bwVW
         WipBzw4S1rN2aBi2zI+p0rm6aB0vV2QymFn2E4Rn7ISvAIITwM4NzY3T1jkDHH1Mba0x
         68qigPLzy5AzI/Z8q6gjKjiI9TJMRZuaN7S1SxibXLhfjAjwLcI+YRRJ7vQcihozTPoQ
         y24ulFZBiBozwpOpPQR80SayMn0rPaUFEcQggSTX0P8VWhac/ak9Yelzqr4ePvL9WbTE
         FzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718309734; x=1718914534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjra96zS1d6tvSE0tCUqIZdFfTJEDqEFxGXXpHb6X+E=;
        b=cWfuTKXpWUTSS6kXJ/LfVmKguBcwq+D4Jy3ta7C0ui59JVIyGzkWO4KFv2YdWATCQc
         5dVCG4q3Vb5MgYvu59TtRdMRCcmAF6E5Lg0uGTQbaQiwz6DbDSjIVvDd78SSWna1QRzf
         U2lkAKjT5GiociYfhpdsEjUmeKyhfFOAJ4WuLHmGtVxMajm+vzb6y0JFv1n4/GUhCyOx
         jXcK+1x0yNqLVzTaGhTk4xD1iSgtJXmCk7FhT5+cMA4KcDiBPcr0zAwxyYSWf0lPjrzy
         dMbvardrSGaB4t+qYZg8Fgu+3SkwU8aiMpy3m0po9QRHRwAmZ7Pc8mjwLI0vu+f0uUGV
         JOqg==
X-Gm-Message-State: AOJu0YxAsK6oCqvBut3mIiZr0kBrt8knGXOiVuJklRbYB+n5GHpNdUxn
	iZGSWsyjhW+KzC7sGaSRMQSc7/yFTCjWo7Rpp8dfCvc8O2K+OEtLGaBsQOJajI8r8E6hYNUqB7M
	lko+IaNX+3ieqC7QoJkCSgq9vErI=
X-Google-Smtp-Source: AGHT+IHmY88g5yqB5RbtWr6Bee68t0sMUbHE4Lwg9TFGCeixzdXkK0fbBduEj+O1WfuEDBX6UB2+FMJFcwBsTJqQaVI=
X-Received: by 2002:a05:6102:2332:b0:48d:920a:bd43 with SMTP id
 ada2fe7eead31-48dae3e47a5mr752195137.29.1718309733917; Thu, 13 Jun 2024
 13:15:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608172142.138894-1-cgoettsche@seltendoof.de>
 <20240608172142.138894-2-cgoettsche@seltendoof.de> <CAP+JOzSOa4DRcZprPSMmY0FKUaVrqfdRgO6v_LVWs1ke=LXtbg@mail.gmail.com>
In-Reply-To: <CAP+JOzSOa4DRcZprPSMmY0FKUaVrqfdRgO6v_LVWs1ke=LXtbg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 13 Jun 2024 16:15:23 -0400
Message-ID: <CAP+JOzTGONcFZuc1aP6HLucXsdxRw1WxrwH_dsUQ2NPi5jFe8w@mail.gmail.com>
Subject: Re: [PATCH 2/2] libsepol: rework permission enabled check
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 2:27=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Sat, Jun 8, 2024 at 1:22=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Check the class is defined once, and not for every permission via
> > is_perm_enabled(). Also pass the class datum to avoid an unnecessary
> > name lookup.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

I will fix the comment when I merge the patch.

Acked-by: James Carter <jwcart2@gmail.com>

> > ---
> >  .../include/sepol/policydb/avrule_block.h     |  4 +--
> >  libsepol/src/avrule_block.c                   | 27 +++++++------------
> >  libsepol/src/link.c                           |  6 ++++-
> >  3 files changed, 17 insertions(+), 20 deletions(-)
> >
> > diff --git a/libsepol/include/sepol/policydb/avrule_block.h b/libsepol/=
include/sepol/policydb/avrule_block.h
> > index 27047d43..18a1dc78 100644
> > --- a/libsepol/include/sepol/policydb/avrule_block.h
> > +++ b/libsepol/include/sepol/policydb/avrule_block.h
> > @@ -35,8 +35,8 @@ extern avrule_decl_t *get_avrule_decl(policydb_t * p,=
 uint32_t decl_id);
> >  extern cond_list_t *get_decl_cond_list(policydb_t * p,
> >                                        avrule_decl_t * decl,
> >                                        cond_list_t * cond);
> > -extern int is_id_enabled(char *id, policydb_t * p, int symbol_table);
> > -extern int is_perm_enabled(char *class_id, char *perm_id, policydb_t *=
 p);
> > +extern int is_id_enabled(const char *id, const policydb_t * p, int sym=
bol_table);
> > +extern int is_perm_existent(const class_datum_t *cladatum, const char =
*perm_id);
> >
> >  #ifdef __cplusplus
> >  }
> > diff --git a/libsepol/src/avrule_block.c b/libsepol/src/avrule_block.c
> > index dcfce8b8..547021e9 100644
> > --- a/libsepol/src/avrule_block.c
> > +++ b/libsepol/src/avrule_block.c
> > @@ -152,11 +152,11 @@ cond_list_t *get_decl_cond_list(policydb_t * p, a=
vrule_decl_t * decl,
> >   * marked as SCOPE_DECL, and any of its declaring block has been enabl=
ed,
> >   * then return 1.  Otherwise return 0. Can only be called after the
> >   * decl_val_to_struct index has been created */
> > -int is_id_enabled(char *id, policydb_t * p, int symbol_table)
> > +int is_id_enabled(const char *id, const policydb_t * p, int symbol_tab=
le)
> >  {
> > -       scope_datum_t *scope =3D
> > +       const scope_datum_t *scope =3D
> >             (scope_datum_t *) hashtab_search(p->scope[symbol_table].tab=
le, id);
> > -       avrule_decl_t *decl;
> > +       const avrule_decl_t *decl;
> >         uint32_t len;
> >
> >         if (scope =3D=3D NULL) {
> > @@ -189,21 +189,14 @@ int is_id_enabled(char *id, policydb_t * p, int s=
ymbol_table)
> >         return 0;
> >  }
> >
> > -/* Check if a particular permission is present within the given class,
> > - * and that the class is enabled.  Returns 1 if both conditions are
> > - * true, 0 if neither could be found or if the class id disabled. */
> > -int is_perm_enabled(char *class_id, char *perm_id, policydb_t * p)
> > +/* Check if a particular permission is present within the given class.
> > + * Whether the class is enabled is NOT checked.
> > + * Returns 1 if both conditions are true,
> > + * 0 if neither could be found or if the class id disabled. */
>
> It returns 0 only if the permission is not found.
>
> Everything else looks good to me.
> Thanks,
> Jim
>
>
> > +int is_perm_existent(const class_datum_t *cladatum, const char *perm_i=
d)
> >  {
> > -       class_datum_t *cladatum;
> > -       perm_datum_t *perm;
> > -       if (!is_id_enabled(class_id, p, SYM_CLASSES)) {
> > -               return 0;
> > -       }
> > -       cladatum =3D
> > -           (class_datum_t *) hashtab_search(p->p_classes.table, class_=
id);
> > -       if (cladatum =3D=3D NULL) {
> > -               return 0;
> > -       }
> > +       const perm_datum_t *perm;
> > +
> >         perm =3D hashtab_search(cladatum->permissions.table, perm_id);
> >         if (perm =3D=3D NULL && cladatum->comdatum !=3D 0) {
> >                 /* permission was not in this class.  before giving
> > diff --git a/libsepol/src/link.c b/libsepol/src/link.c
> > index a6f2a251..9281a986 100644
> > --- a/libsepol/src/link.c
> > +++ b/libsepol/src/link.c
> > @@ -1968,6 +1968,10 @@ static int is_decl_requires_met(link_state_t * s=
tate,
> >                 id =3D pol->p_class_val_to_name[i];
> >
> >
> > +               if (!is_id_enabled(id, state->base, SYM_CLASSES)) {
> > +                       return 0;
> > +               }
> > +
> >                 scope =3D hashtab_search(state->base->p_classes_scope.t=
able, id);
> >                 if (scope =3D=3D NULL) {
> >                         ERR(state->handle,
> > @@ -1994,7 +1998,7 @@ static int is_decl_requires_met(link_state_t * st=
ate,
> >                         perm_id =3D fparg.key;
> >
> >                         assert(perm_id !=3D NULL);
> > -                       if (!is_perm_enabled(id, perm_id, state->base))=
 {
> > +                       if (!is_perm_existent(cladatum, perm_id)) {
> >                                 if (req !=3D NULL) {
> >                                         req->symbol_type =3D SYM_CLASSE=
S;
> >                                         req->symbol_value =3D i + 1;
> > --
> > 2.45.1
> >
> >
